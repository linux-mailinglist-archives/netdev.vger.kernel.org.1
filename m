Return-Path: <netdev+bounces-204006-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4083BAF8752
	for <lists+netdev@lfdr.de>; Fri,  4 Jul 2025 07:36:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E45A83A536F
	for <lists+netdev@lfdr.de>; Fri,  4 Jul 2025 05:35:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43F691AAA1C;
	Fri,  4 Jul 2025 05:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RSAoM6Ja"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12ACA347D5;
	Fri,  4 Jul 2025 05:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751607367; cv=none; b=Xto/Z7NQn8y9q7zN32ePDaRiOkJmLGI/X6o0BWvTJ0xuAljnRttYbq+2aGpuHz3uq6QYLWOH+ZFinN7uPRciTd0olntKO/5hJjp8vy4WBDTHuPTNjLMNtTglYZpRM5oRsyelT782MvIlPVNeRjy9AUy9nxMw4SPTgx5ljHuFXd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751607367; c=relaxed/simple;
	bh=S6i1vmjbQd/F1a2CosAXojWNB/W1Oq0tSufcWcscSag=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=XqRdfllTr1wQogL+uGIfg9U8zLRH2sMyYYcTB82IarBkTjhtTmdaL1oxfBCT6ScGFAiUeR18IETWto8jH14DsgY8JS5CHSpGZEdU7oOskbmdDYEA3gYVPxb98wgOohjeaRV36cF+a+02/N9AvCSOn8HcDUrzSk6Hcc0VYGcyDz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RSAoM6Ja; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 899C8C4CEE3;
	Fri,  4 Jul 2025 05:36:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751607366;
	bh=S6i1vmjbQd/F1a2CosAXojWNB/W1Oq0tSufcWcscSag=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=RSAoM6JalaRzoka2JsJrKvd1Y44DVbBnOwfGXbK920ENK97jh6VHToAwCtyWIsVwh
	 OL07ZOmgnnzGi6DF1kaYLH9VHlGShu9cf3YmSEL/gF3vySVkwLst3Lipo5DQyPXGpY
	 KmLX55nQjPU/IsD0S121SjIsjh5evK/1M2+noCJhpcOKTUi+G3ocBMDscd40SnBweY
	 WtlV3guPOdIwbvTYSxUUFN3aOtXChlo+CFxp3bR1Cvl7sRDQa0jA+Vsy4nXOQv622u
	 ZIJa0Drj8MAyRAmY0svT1daC9Q6Yao8hfZsVhi2ojJ62LTYOa1ZRR7wcJRk2oJ8uSH
	 XyxY2j9kj7bUA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75191C83F09;
	Fri,  4 Jul 2025 05:36:06 +0000 (UTC)
From: Yang Li via B4 Relay <devnull+yang.li.amlogic.com@kernel.org>
Date: Fri, 04 Jul 2025 13:36:04 +0800
Subject: [PATCH v3] Bluetooth: ISO: Support SCM_TIMESTAMPING for ISO TS
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250704-iso_ts-v3-1-2328bc602961@amlogic.com>
X-B4-Tracking: v=1; b=H4sIAENoZ2gC/1WMWwrCMBQFt1LybSS56SP1y32ISExv2wu2kaQEp
 XTvpoUqfs7hzMwsoCcM7JTNzGOkQG5MoA4Zs70ZO+TUJGYgoBA5SE7B3abArQajhDBY6Zyl89N
 jS68tdLkm7ilMzr+3bpTruifqPREllxwLXbZKNFja+9kMD9eRPVo3sDUS4SdWAr4iJLEC1ci6t
 lqU+l9cluUDtrm4ztcAAAA=
To: Marcel Holtmann <marcel@holtmann.org>, 
 Johan Hedberg <johan.hedberg@gmail.com>, 
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Yang Li <yang.li@amlogic.com>
X-Mailer: b4 0.13-dev-f0463
X-Developer-Signature: v=1; a=ed25519-sha256; t=1751607364; l=1653;
 i=yang.li@amlogic.com; s=20240418; h=from:subject:message-id;
 bh=C5WSe4xpxMywiJVuo177OZ9NkV8vydxLCuzzPLrDJ70=;
 b=BPvz/HGiu+RRd/d7DdT0qoLzNUl91lP8saypFLqpEV6DymwgKZT1fwShR0X0vedw8VkPV0hbt
 AsNh/CPpqm9BRqPmei3UxNyNxB7NtYKTfAimIss2qLjyLM4t+n2AXpV
X-Developer-Key: i=yang.li@amlogic.com; a=ed25519;
 pk=86OaNWMr3XECW9HGNhkJ4HdR2eYA5SEAegQ3td2UCCs=
X-Endpoint-Received: by B4 Relay for yang.li@amlogic.com/20240418 with
 auth_id=180
X-Original-From: Yang Li <yang.li@amlogic.com>
Reply-To: yang.li@amlogic.com

From: Yang Li <yang.li@amlogic.com>

User-space applications (e.g., PipeWire) depend on
ISO-formatted timestamps for precise audio sync.

Signed-off-by: Yang Li <yang.li@amlogic.com>
---
Changes in v3:
- Change to use hwtimestamp
- Link to v2: https://lore.kernel.org/r/20250702-iso_ts-v2-1-723d199c8068@amlogic.com

Changes in v2:
- Support SOCK_RCVTSTAMPNS via CMSG for ISO sockets
- Link to v1: https://lore.kernel.org/r/20250429-iso_ts-v1-1-e586f30de6cb@amlogic.com
---
 net/bluetooth/iso.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/iso.c b/net/bluetooth/iso.c
index fc22782cbeeb..67ff355167d8 100644
--- a/net/bluetooth/iso.c
+++ b/net/bluetooth/iso.c
@@ -2301,13 +2301,21 @@ void iso_recv(struct hci_conn *hcon, struct sk_buff *skb, u16 flags)
 		if (ts) {
 			struct hci_iso_ts_data_hdr *hdr;
 
-			/* TODO: add timestamp to the packet? */
 			hdr = skb_pull_data(skb, HCI_ISO_TS_DATA_HDR_SIZE);
 			if (!hdr) {
 				BT_ERR("Frame is too short (len %d)", skb->len);
 				goto drop;
 			}
 
+			/* The ISO ts is based on the controller’s clock domain,
+			 * so hardware timestamping (hwtimestamp) must be used.
+			 * Ref: Documentation/networking/timestamping.rst,
+			 * chapter 3.1 Hardware Timestamping.
+ 			 */
+			struct skb_shared_hwtstamps *hwts = skb_hwtstamps(skb);
+			if (hwts)
+				hwts->hwtstamp = us_to_ktime(le32_to_cpu(hdr->ts));
+
 			len = __le16_to_cpu(hdr->slen);
 		} else {
 			struct hci_iso_data_hdr *hdr;

---
base-commit: 3bc46213b81278f3a9df0324768e152de71eb9fe
change-id: 20250421-iso_ts-c82a300ae784

Best regards,
-- 
Yang Li <yang.li@amlogic.com>



