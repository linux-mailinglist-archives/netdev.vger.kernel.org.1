Return-Path: <netdev+bounces-178143-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B459DA74E37
	for <lists+netdev@lfdr.de>; Fri, 28 Mar 2025 17:07:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB121189328A
	for <lists+netdev@lfdr.de>; Fri, 28 Mar 2025 16:07:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD0BE1D5CEA;
	Fri, 28 Mar 2025 16:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=riseup.net header.i=@riseup.net header.b="i1oOEQ1T"
X-Original-To: netdev@vger.kernel.org
Received: from mx0.riseup.net (mx0.riseup.net [198.252.153.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B2B9DDC5
	for <netdev@vger.kernel.org>; Fri, 28 Mar 2025 16:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.252.153.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743178018; cv=none; b=Lzj/WHpcCVZPl4k1PUU2YyB0XlNV4C/QonkYYDFTPOHWSW24nhrco2fu3Gr795tQarlWtp3MVKzyLTMxtxofqcXdhxi/OxwpbGXdfZMWwDhld0FM5pI9ykhIspI/HzLaCUwHbdNwOkoQ280owBHxMAlWBRNt1AFL29sJXCYkkJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743178018; c=relaxed/simple;
	bh=UpiMh+wQEMzeTdyCxsvzsIGSrV/eK3/a3KM21vKXgHg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cGlS4FjJJ7jRQWm/ODpPgw+3Rj8kZdTVFqjhuHVZTamHQm2Dwz18LBs3RAjY4HFFA9A17lwgK7X9lwONtpzub9vlg9AmbX0Oecp86RYs7FB5N1g09fPcXml2Uj8c3JGVMXp+UyWDJxBMI9OPvjqF3LEGBJdrHMjs8kj7L1KY5Hg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riseup.net; spf=pass smtp.mailfrom=riseup.net; dkim=pass (1024-bit key) header.d=riseup.net header.i=@riseup.net header.b=i1oOEQ1T; arc=none smtp.client-ip=198.252.153.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riseup.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riseup.net
Received: from fews02-sea.riseup.net (fews02-sea-pn.riseup.net [10.0.1.112])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx0.riseup.net (Postfix) with ESMTPS id 4ZPQQ83vsBz9w52;
	Fri, 28 Mar 2025 16:06:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=riseup.net; s=squak;
	t=1743178016; bh=UpiMh+wQEMzeTdyCxsvzsIGSrV/eK3/a3KM21vKXgHg=;
	h=From:To:Cc:Subject:Date:From;
	b=i1oOEQ1TnSj97y85RSCmJ/S8DtMroUkazddj8XXpLGKxPr448PHeXQvIFjiBHvtFp
	 czsuCJLXx4H/qfUBvidcHwSdwMNeJalYtMevhdnOELvW3Sayf3XlN9iyuH7pgsexJj
	 XMtj6+XHOvxOIBWkjHOeRIa67AOybz80s2DZ9Zic=
X-Riseup-User-ID: F42B837010BDD7E18E2C342D272D4153CD6BC68C5D63BD19A4B98690E1BA1B6B
Received: from [127.0.0.1] (localhost [127.0.0.1])
	 by fews02-sea.riseup.net (Postfix) with ESMTPSA id 4ZPQQ6700tzFw3p;
	Fri, 28 Mar 2025 16:06:54 +0000 (UTC)
From: Fernando Fernandez Mancera <ffmancera@riseup.net>
To: netdev@vger.kernel.org
Cc: lukma@denx.de,
	wojciech.drewek@intel.com,
	m-karicheri2@ti.com,
	Fernando Fernandez Mancera <ffmancera@riseup.net>
Subject: [PATCH v2 net-next] net: hsr: sync hw addr of slave2 according to slave1 hw addr on PRP
Date: Fri, 28 Mar 2025 17:06:42 +0100
Message-ID: <20250328160642.3595-1-ffmancera@riseup.net>
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
v2: specified the target tree
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


