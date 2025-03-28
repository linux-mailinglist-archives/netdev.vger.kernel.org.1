Return-Path: <netdev+bounces-178140-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E3C5FA74E2A
	for <lists+netdev@lfdr.de>; Fri, 28 Mar 2025 16:55:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E3F931890BAC
	for <lists+netdev@lfdr.de>; Fri, 28 Mar 2025 15:56:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F8011D61A5;
	Fri, 28 Mar 2025 15:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=riseup.net header.i=@riseup.net header.b="Z08roktd"
X-Original-To: netdev@vger.kernel.org
Received: from mx1.riseup.net (mx1.riseup.net [198.252.153.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86DC21D5ADB
	for <netdev@vger.kernel.org>; Fri, 28 Mar 2025 15:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.252.153.129
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743177349; cv=none; b=cG4x+QfkEZrr3VVVoTeYCHdlGM8xmt+cPjXbZBc/a29hhjIaZSsZmpkUT9rIXkfL/CRJ4i4/3aB2Np7Ybqls1HxAHTz28F0RuauW65dMbbru/YjiJN5HaKilorr6i8DbcMSm7juemFAWKUDgRzUpumvm3t5QuSFLCJ1RpkLi720=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743177349; c=relaxed/simple;
	bh=zoszVNHKwrPNnO/yvLG98CA0WHKOt/atIf+E04hkBgU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PX8JUgaeel3SBzwhM41oqF/6vAOa1642AejIvUedqe9WcJQJ5gDMrzI7DIk9k5GT67LC+5eTf3+jfkbGcP9bazA6Hk/DDDZEiN3lZZYrW7JRYCgjGZaEprLHDeruiWAcpbwGwrRbK44LUC3zxaFcGx8tqSP1dV8YMUR0r6P1i9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riseup.net; spf=pass smtp.mailfrom=riseup.net; dkim=pass (1024-bit key) header.d=riseup.net header.i=@riseup.net header.b=Z08roktd; arc=none smtp.client-ip=198.252.153.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riseup.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riseup.net
Received: from fews01-sea.riseup.net (fews01-sea-pn.riseup.net [10.0.1.109])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx1.riseup.net (Postfix) with ESMTPS id 4ZPQ985MlnzDqW9;
	Fri, 28 Mar 2025 15:55:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=riseup.net; s=squak;
	t=1743177340; bh=zoszVNHKwrPNnO/yvLG98CA0WHKOt/atIf+E04hkBgU=;
	h=From:To:Cc:Subject:Date:From;
	b=Z08roktdaeh8Xqm0H3JeEURI9tAtAM6BXzOGT1ki+nXl+vwmMJKblfecWitZTQHPa
	 XrZPewafkQoDM7+yBaT3Fv8BEhrEU3IIf3pFyvq/Coxm0utFBC581ixWDogPfj3YFk
	 PRDmQ/4bfhLAtlWvF5zFQW3xv3K+zyVoKJRfy4PE=
X-Riseup-User-ID: 515467EF802CAD87B229357CCB8EA9B4A2B26853BE8C734D170A898EE8DFC67D
Received: from [127.0.0.1] (localhost [127.0.0.1])
	 by fews01-sea.riseup.net (Postfix) with ESMTPSA id 4ZPQ970y55zJtc4;
	Fri, 28 Mar 2025 15:55:38 +0000 (UTC)
From: Fernando Fernandez Mancera <ffmancera@riseup.net>
To: netdev@vger.kernel.org
Cc: lukma@denx.de,
	wojciech.drewek@intel.com,
	m-karicheri2@ti.com,
	Fernando Fernandez Mancera <ffmancera@riseup.net>
Subject: [PATCH] net: hsr: sync hw addr of slave2 according to slave1 hw addr on PRP
Date: Fri, 28 Mar 2025 16:55:22 +0100
Message-ID: <20250328155522.3514-1-ffmancera@riseup.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In order to work properly PRP requires slave1 and slave2 to share the
same MAC address. To ease the configuration process on userspace tools,
sync the slave2 MAC address with slave1.

Signed-off-by: Fernando Fernandez Mancera <ffmancera@riseup.net>
---
NOTE: I am not sure the call_netdevice_notifiers() are needed here.
I am wondering, if this change makes sense in HSR too.
Feedback is welcome.
---
 net/hsr/hsr_device.c | 2 ++
 net/hsr/hsr_main.c   | 9 +++++++++
 2 files changed, 11 insertions(+)

diff --git a/net/hsr/hsr_device.c b/net/hsr/hsr_device.c
index 439cfb7ad5d1..f971eb321655 100644
--- a/net/hsr/hsr_device.c
+++ b/net/hsr/hsr_device.c
@@ -706,6 +706,8 @@ int hsr_dev_finalize(struct net_device *hsr_dev, struct net_device *slave[2],
 		 */
 		hsr->net_id = PRP_LAN_ID << 1;
 		hsr->proto_ops = &prp_ops;
+		eth_hw_addr_set(slave[1], slave[0]->dev_addr);
+		call_netdevice_notifiers(NETDEV_CHANGEADDR, slave[1]);
 	} else {
 		hsr->proto_ops = &hsr_ops;
 	}
diff --git a/net/hsr/hsr_main.c b/net/hsr/hsr_main.c
index d7ae32473c41..192893c3f2ec 100644
--- a/net/hsr/hsr_main.c
+++ b/net/hsr/hsr_main.c
@@ -78,6 +78,15 @@ static int hsr_netdev_notify(struct notifier_block *nb, unsigned long event,
 			eth_hw_addr_set(master->dev, dev->dev_addr);
 			call_netdevice_notifiers(NETDEV_CHANGEADDR,
 						 master->dev);
+
+			if (hsr->prot_version == PRP_V1) {
+				port = hsr_port_get_hsr(hsr, HSR_PT_SLAVE_B);
+				if (port) {
+					eth_hw_addr_set(port->dev, dev->dev_addr);
+					call_netdevice_notifiers(NETDEV_CHANGEADDR,
+								 port->dev);
+				}
+			}
 		}
 
 		/* Make sure we recognize frames from ourselves in hsr_rcv() */
-- 
2.49.0


