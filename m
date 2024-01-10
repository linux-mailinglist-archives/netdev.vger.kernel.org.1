Return-Path: <netdev+bounces-60971-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D9878220E3
	for <lists+netdev@lfdr.de>; Tue,  2 Jan 2024 19:20:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E0AB7284348
	for <lists+netdev@lfdr.de>; Tue,  2 Jan 2024 18:20:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F320515E9C;
	Tue,  2 Jan 2024 18:19:57 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B382156FB;
	Tue,  2 Jan 2024 18:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=v0yd.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=v0yd.nl
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4T4Ljh4gf0z9sWQ;
	Tue,  2 Jan 2024 19:19:52 +0100 (CET)
From: =?UTF-8?q?Jonas=20Dre=C3=9Fler?= <verdre@v0yd.nl>
To: Marcel Holtmann <marcel@holtmann.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: =?UTF-8?q?Jonas=20Dre=C3=9Fler?= <verdre@v0yd.nl>,
	asahi@lists.linux.dev,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH v2 2/4] Bluetooth: mgmt: Remove leftover queuing of power_off work
Date: Tue,  2 Jan 2024 19:19:18 +0100
Message-ID: <20240102181946.57288-3-verdre@v0yd.nl>
In-Reply-To: <20240102181946.57288-1-verdre@v0yd.nl>
References: <20240102181946.57288-1-verdre@v0yd.nl>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Queuing of power_off work was introduced in these functions with commits
8b064a3ad377c016a17e74f676e7a204c2b8c9f2 and
c9910d0fb4fc2ede468b26d45a1d50c309897770 in an effort to clean up state
and do things like disconnecting devices before actually powering off
the device.

After that, commit a3172b7eb4a2719711187cfca12097d2326e85a7 introduced a
timeout to ensure that the device actually got powered off, even if some
of the cleanup work would never complete.

This code later got refactored with commit
cf75ad8b41d2aa06f98f365d42a3ae8b059daddd, which made powering off the
device synchronous and removed the need for initiating the power_off
work from other places. The timeout mentioned above got removed too,
because we now also made use of the command timeout during power on/off.

These days the power_off work still exists, but it only seems to only be
used for HCI_AUTO_OFF functionality, which is why we never noticed
those two leftover places where we queue power_off work. So let's remove
that code.

Signed-off-by: Jonas Dreßler <verdre@v0yd.nl>
---
 net/bluetooth/mgmt.c | 16 ----------------
 1 file changed, 16 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index d4498037f..c5291e139 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -9760,14 +9760,6 @@ void mgmt_device_disconnected(struct hci_dev *hdev, bdaddr_t *bdaddr,
 	struct mgmt_ev_device_disconnected ev;
 	struct sock *sk = NULL;
 
-	/* The connection is still in hci_conn_hash so test for 1
-	 * instead of 0 to know if this is the last one.
-	 */
-	if (mgmt_powering_down(hdev) && hci_conn_count(hdev) == 1) {
-		cancel_delayed_work(&hdev->power_off);
-		queue_work(hdev->req_workqueue, &hdev->power_off.work);
-	}
-
 	if (!mgmt_connected)
 		return;
 
@@ -9824,14 +9816,6 @@ void mgmt_connect_failed(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 link_type,
 {
 	struct mgmt_ev_connect_failed ev;
 
-	/* The connection is still in hci_conn_hash so test for 1
-	 * instead of 0 to know if this is the last one.
-	 */
-	if (mgmt_powering_down(hdev) && hci_conn_count(hdev) == 1) {
-		cancel_delayed_work(&hdev->power_off);
-		queue_work(hdev->req_workqueue, &hdev->power_off.work);
-	}
-
 	bacpy(&ev.addr.bdaddr, bdaddr);
 	ev.addr.type = link_to_bdaddr(link_type, addr_type);
 	ev.status = mgmt_status(status);
-- 
2.43.0


