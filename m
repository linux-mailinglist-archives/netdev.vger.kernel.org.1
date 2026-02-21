Return-Path: <netdev+bounces-259830-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CLHTMer2mWl/XgMAu9opvQ
	(envelope-from <netdev+bounces-259830-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 21 Feb 2026 19:18:18 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 26F9216D799
	for <lists+netdev@lfdr.de>; Sat, 21 Feb 2026 19:18:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D83A53042092
	for <lists+netdev@lfdr.de>; Sat, 21 Feb 2026 18:18:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89D6B309EEB;
	Sat, 21 Feb 2026 18:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s5soBj+6"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64D231DFF7;
	Sat, 21 Feb 2026 18:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771697894; cv=none; b=P/LCpfF7MC7G6i0bJRovwtQ7IRsfNxPzxejvLahRPLTYygDYsa8uE6y2TdtjJ82gMfrEVYnm2bPIcAraF/RPpXUtrzb9z+HvOpySRnfLvi7FeGx2ql/LG9UlzorMVDny4d7F7CTMn/gtk6NeMhPyAOt3FrQN3njIe9Jqcroqb/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771697894; c=relaxed/simple;
	bh=SuUcqCf2HA3OvwXLrDAmWDTy8YFKdj+8DDbAcgS1VpM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QvuTeYcPqhIp+Sv0crAoQoM+tz3D7vz84DZOQwKEouMQeg2HV5OjxIiyk3kP4Jed8dnpVU3QZv1C1/0W1NryuPFi4/HaV5au/Zqb6NS0g9pQU0grghtmW4te4f/dzJ7tW17P6+7gG8N1SPQz/7KslhzLK9gcuFCn0SgxkqJ0SPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s5soBj+6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 32288C19421;
	Sat, 21 Feb 2026 18:18:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771697894;
	bh=SuUcqCf2HA3OvwXLrDAmWDTy8YFKdj+8DDbAcgS1VpM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=s5soBj+6MejX3gZdifFN3XOwgX9Wu1PxdGkeFOq0r0WIOkkJmWlRtd3eGqZz8UVSu
	 HMmd5eEA5gDx0oRqX8Ox2o5CK9MGnnP6l91XboNbI0jIrGH7+WyWCwRYh7IUAOlY1B
	 R544gk2x1916GjixyKcMVq3hwHB8hslKolClxDwicB6AydidpZ6lTgHDK6vTk/KXPu
	 SQdaKpZJde2S2I/BP9Ge90Vvers6nROfmvmmh2WK4jObZlHrEEpfcV0jvbhOmrardb
	 egyyjtfs8KEa1KCHYDTvFGv3XLvGxMks/Dn/E06DtpMknLgxlKn+VX2Mbdu1iUaGiC
	 VPQEqeFWgbJCw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24EB4C61DFF;
	Sat, 21 Feb 2026 18:18:14 +0000 (UTC)
From: Satish Kharat via B4 Relay <devnull+satishkh.cisco.com@kernel.org>
Date: Sat, 21 Feb 2026 10:17:00 -0800
Subject: [PATCH 2/2] net:ethernet:enic: map ethtool link modes by VIC type
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260221-enic-cscwi36355-v1-2-5a01a6046d5e@cisco.com>
References: <20260221-enic-cscwi36355-v1-0-5a01a6046d5e@cisco.com>
In-Reply-To: <20260221-enic-cscwi36355-v1-0-5a01a6046d5e@cisco.com>
To: netdev@vger.kernel.org
Cc: Satish Kharat <satishkh@cisco.com>, linux-kernel@vger.kernel.org
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1771697893; l=10825;
 i=satishkh@cisco.com; h=from:subject:message-id;
 bh=N8+kx2iBxqmrLKDZNVdwcLIsgoMssw7v9dyzc2PHkug=;
 b=64KvIvj7jOG4a//DsBtTdWjXE8su0jbhjaYA+eiALn4FaECFd14f4M18MH9bAnnkgLCxARptm
 ohthWDszQfRC4t5iDJhuhvA2r2ehcMOofR/mxdXEjxFiltxjj0T2i9C
X-Developer-Key: i=satishkh@cisco.com; a=ed25519;
 pk=4BxbLoCGvHeIMH/PbpiNVx8/2IcTjFvqcr0AD8K6WLY=
X-Endpoint-Received: by B4 Relay for satishkh@cisco.com/default with
 auth_id=639
X-Original-From: Satish Kharat <satishkh@cisco.com>
Reply-To: satishkh@cisco.com
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-259830-lists,netdev=lfdr.de,satishkh.cisco.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnull@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	HAS_REPLYTO(0.00)[satishkh@cisco.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 26F9216D799
X-Rspamd-Action: no action

From: Satish Kharat <satishkh@cisco.com>

Report supported and advertised media types based on the VIC subsystem
ID so ethtool reflects the hardware capabilities.

Signed-off-by: Satish Kharat <satishkh@cisco.com>
---
 drivers/net/ethernet/cisco/enic/enic_ethtool.c | 229 ++++++++++++++++++++++++-
 1 file changed, 222 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/cisco/enic/enic_ethtool.c b/drivers/net/ethernet/cisco/enic/enic_ethtool.c
index 471613899..80fbbb7ef 100644
--- a/drivers/net/ethernet/cisco/enic/enic_ethtool.c
+++ b/drivers/net/ethernet/cisco/enic/enic_ethtool.c
@@ -126,19 +126,234 @@ static void enic_intr_coal_set_rx(struct enic *enic, u32 timer)
 	}
 }
 
+static void enic_get_supp_adv_media_type(struct net_device *netdev,
+					 struct ethtool_link_ksettings *ecmd)
+{
+	struct enic *enic = netdev_priv(netdev);
+	struct ethtool_link_settings *base = &ecmd->base;
+	u16 sub_dev_id = 0;
+
+	base->port = PORT_OTHER;
+
+	if (enic->pdev)
+		sub_dev_id = enic->pdev->subsystem_device;
+
+	switch (sub_dev_id) {
+	case PCI_SUBDEV_ID_CISCO_VIC_1225:
+	case PCI_SUBDEV_ID_CISCO_VIC_1227:
+		ethtool_link_ksettings_add_link_mode(ecmd, supported,
+						     10000baseSR_Full);
+		ethtool_link_ksettings_add_link_mode(ecmd, advertising,
+						     10000baseSR_Full);
+		ethtool_link_ksettings_add_link_mode(ecmd, supported, FIBRE);
+		ethtool_link_ksettings_add_link_mode(ecmd, advertising, FIBRE);
+		base->port = PORT_FIBRE;
+		break;
+	case PCI_SUBDEV_ID_CISCO_VIC_1285:
+		ethtool_link_ksettings_add_link_mode(ecmd, supported,
+						     40000baseSR4_Full);
+		ethtool_link_ksettings_add_link_mode(ecmd, advertising,
+						     40000baseSR4_Full);
+		ethtool_link_ksettings_add_link_mode(ecmd, supported, FIBRE);
+		ethtool_link_ksettings_add_link_mode(ecmd, advertising, FIBRE);
+		base->port = PORT_FIBRE;
+		break;
+	case PCI_SUBDEV_ID_CISCO_VIC_1225T:
+	case PCI_SUBDEV_ID_CISCO_VIC_1227T:
+		ethtool_link_ksettings_add_link_mode(ecmd, supported,
+						     10000baseT_Full);
+		ethtool_link_ksettings_add_link_mode(ecmd, advertising,
+						     10000baseT_Full);
+		ethtool_link_ksettings_add_link_mode(ecmd, supported, FIBRE);
+		ethtool_link_ksettings_add_link_mode(ecmd, advertising, FIBRE);
+		base->port = PORT_FIBRE;
+		break;
+	case PCI_SUBDEV_ID_CISCO_VIC_1385:
+	case PCI_SUBDEV_ID_CISCO_VIC_1387:
+		ethtool_link_ksettings_add_link_mode(ecmd, supported,
+						     10000baseSR_Full);
+		ethtool_link_ksettings_add_link_mode(ecmd, advertising,
+						     10000baseSR_Full);
+		ethtool_link_ksettings_add_link_mode(ecmd, supported,
+						     10000baseLR_Full);
+		ethtool_link_ksettings_add_link_mode(ecmd, advertising,
+						     10000baseLR_Full);
+		ethtool_link_ksettings_add_link_mode(ecmd, supported,
+						     40000baseSR4_Full);
+		ethtool_link_ksettings_add_link_mode(ecmd, advertising,
+						     40000baseSR4_Full);
+		ethtool_link_ksettings_add_link_mode(ecmd, supported,
+						     40000baseLR4_Full);
+		ethtool_link_ksettings_add_link_mode(ecmd, advertising,
+						     40000baseLR4_Full);
+		ethtool_link_ksettings_add_link_mode(ecmd, supported, FIBRE);
+		ethtool_link_ksettings_add_link_mode(ecmd, advertising, FIBRE);
+		base->port = PORT_FIBRE;
+		break;
+	case PCI_SUBDEV_ID_CISCO_VIC_1477:
+	case PCI_SUBDEV_ID_CISCO_VIC_1485:
+	case PCI_SUBDEV_ID_CISCO_VIC_1487:
+	case PCI_SUBDEV_ID_CISCO_VIC_1495:
+	case PCI_SUBDEV_ID_CISCO_VIC_1497:
+		ethtool_link_ksettings_add_link_mode(ecmd, supported,
+						     40000baseCR4_Full);
+		ethtool_link_ksettings_add_link_mode(ecmd, advertising,
+						     40000baseCR4_Full);
+		ethtool_link_ksettings_add_link_mode(ecmd, supported,
+						     40000baseSR4_Full);
+		ethtool_link_ksettings_add_link_mode(ecmd, advertising,
+						     40000baseSR4_Full);
+		ethtool_link_ksettings_add_link_mode(ecmd, supported,
+						     40000baseLR4_Full);
+		ethtool_link_ksettings_add_link_mode(ecmd, advertising,
+						     40000baseLR4_Full);
+		ethtool_link_ksettings_add_link_mode(ecmd, supported,
+						     100000baseSR4_Full);
+		ethtool_link_ksettings_add_link_mode(ecmd, advertising,
+						     100000baseSR4_Full);
+		ethtool_link_ksettings_add_link_mode(ecmd, supported,
+						     100000baseCR4_Full);
+		ethtool_link_ksettings_add_link_mode(ecmd, advertising,
+						     100000baseCR4_Full);
+		ethtool_link_ksettings_add_link_mode(ecmd, supported, FIBRE);
+		ethtool_link_ksettings_add_link_mode(ecmd, advertising, FIBRE);
+		base->port = PORT_FIBRE;
+		break;
+	case PCI_SUBDEV_ID_CISCO_VIC_15235:
+	case PCI_SUBDEV_ID_CISCO_VIC_15237:
+	case PCI_SUBDEV_ID_CISCO_VIC_15238:
+		ethtool_link_ksettings_add_link_mode(ecmd, supported,
+						     40000baseCR4_Full);
+		ethtool_link_ksettings_add_link_mode(ecmd, advertising,
+						     40000baseCR4_Full);
+		ethtool_link_ksettings_add_link_mode(ecmd, supported,
+						     40000baseSR4_Full);
+		ethtool_link_ksettings_add_link_mode(ecmd, advertising,
+						     40000baseSR4_Full);
+		ethtool_link_ksettings_add_link_mode(ecmd, supported,
+						     40000baseLR4_Full);
+		ethtool_link_ksettings_add_link_mode(ecmd, advertising,
+						     40000baseLR4_Full);
+		ethtool_link_ksettings_add_link_mode(ecmd, supported,
+						     100000baseSR4_Full);
+		ethtool_link_ksettings_add_link_mode(ecmd, advertising,
+						     100000baseSR4_Full);
+		ethtool_link_ksettings_add_link_mode(ecmd, supported,
+						     100000baseCR4_Full);
+		ethtool_link_ksettings_add_link_mode(ecmd, advertising,
+						     100000baseCR4_Full);
+		ethtool_link_ksettings_add_link_mode(ecmd, supported,
+						     200000baseSR4_Full);
+		ethtool_link_ksettings_add_link_mode(ecmd, advertising,
+						     200000baseSR4_Full);
+		ethtool_link_ksettings_add_link_mode(ecmd, supported,
+						     200000baseDR4_Full);
+		ethtool_link_ksettings_add_link_mode(ecmd, advertising,
+						     200000baseDR4_Full);
+		ethtool_link_ksettings_add_link_mode(ecmd, supported,
+						     200000baseLR4_ER4_FR4_Full);
+		ethtool_link_ksettings_add_link_mode(ecmd, advertising,
+						     200000baseLR4_ER4_FR4_Full);
+		ethtool_link_ksettings_add_link_mode(ecmd, supported, FIBRE);
+		ethtool_link_ksettings_add_link_mode(ecmd, advertising, FIBRE);
+		base->port = PORT_FIBRE;
+		break;
+	case PCI_SUBDEV_ID_CISCO_VIC_1455:
+	case PCI_SUBDEV_ID_CISCO_VIC_1457:
+	case PCI_SUBDEV_ID_CISCO_VIC_1467:
+		ethtool_link_ksettings_add_link_mode(ecmd, supported,
+						     10000baseT_Full);
+		ethtool_link_ksettings_add_link_mode(ecmd, advertising,
+						     10000baseT_Full);
+		ethtool_link_ksettings_add_link_mode(ecmd, supported,
+						     25000baseSR_Full);
+		ethtool_link_ksettings_add_link_mode(ecmd, advertising,
+						     25000baseSR_Full);
+		ethtool_link_ksettings_add_link_mode(ecmd, supported, FIBRE);
+		ethtool_link_ksettings_add_link_mode(ecmd, advertising, FIBRE);
+		base->port = PORT_FIBRE;
+		break;
+	case PCI_SUBDEV_ID_CISCO_VIC_15428:
+	case PCI_SUBDEV_ID_CISCO_VIC_15427:
+	case PCI_SUBDEV_ID_CISCO_VIC_15425:
+		ethtool_link_ksettings_add_link_mode(ecmd, supported,
+						     10000baseT_Full);
+		ethtool_link_ksettings_add_link_mode(ecmd, advertising,
+						     10000baseT_Full);
+		ethtool_link_ksettings_add_link_mode(ecmd, supported,
+						     25000baseSR_Full);
+		ethtool_link_ksettings_add_link_mode(ecmd, advertising,
+						     25000baseSR_Full);
+		ethtool_link_ksettings_add_link_mode(ecmd, supported,
+						     50000baseSR_Full);
+		ethtool_link_ksettings_add_link_mode(ecmd, advertising,
+						     50000baseSR_Full);
+		ethtool_link_ksettings_add_link_mode(ecmd, supported, FIBRE);
+		ethtool_link_ksettings_add_link_mode(ecmd, advertising, FIBRE);
+		base->port = PORT_FIBRE;
+		break;
+	/* Do not mention port type as FIBRE for blade VICs */
+	case PCI_SUBDEV_ID_CISCO_VIC_1240:
+	case PCI_SUBDEV_ID_CISCO_VIC_1280:
+		ethtool_link_ksettings_add_link_mode(ecmd, supported,
+						     10000baseKR_Full);
+		ethtool_link_ksettings_add_link_mode(ecmd, advertising,
+						     10000baseKR_Full);
+		break;
+	case PCI_SUBDEV_ID_CISCO_VIC_1340:
+	case PCI_SUBDEV_ID_CISCO_VIC_1380:
+	case PCI_SUBDEV_ID_CISCO_VIC_1440: /* 10G/40G KR */
+	case PCI_SUBDEV_ID_CISCO_VIC_1480: /* 10G/40G KR */
+		ethtool_link_ksettings_add_link_mode(ecmd, supported,
+						     10000baseKR_Full);
+		ethtool_link_ksettings_add_link_mode(ecmd, advertising,
+						     10000baseKR_Full);
+		ethtool_link_ksettings_add_link_mode(ecmd, supported,
+						     40000baseKR4_Full);
+		ethtool_link_ksettings_add_link_mode(ecmd, advertising,
+						     40000baseKR4_Full);
+		break;
+	case PCI_SUBDEV_ID_CISCO_VIC_14425: /* 25G KR */
+	case PCI_SUBDEV_ID_CISCO_VIC_14825: /* 25G KR */
+	case PCI_SUBDEV_ID_CISCO_VIC_15420: /* 25G KR */
+	case PCI_SUBDEV_ID_CISCO_VIC_15422: /* 25G KR */
+		ethtool_link_ksettings_add_link_mode(ecmd, supported,
+						     25000baseKR_Full);
+		ethtool_link_ksettings_add_link_mode(ecmd, advertising,
+						     25000baseKR_Full);
+		break;
+	case PCI_SUBDEV_ID_CISCO_VIC_15411: /* 10G KR */
+	case PCI_SUBDEV_ID_CISCO_VIC_15412: /* 10G KR */
+		ethtool_link_ksettings_add_link_mode(ecmd, supported,
+						     10000baseKR_Full);
+		ethtool_link_ksettings_add_link_mode(ecmd, advertising,
+						     10000baseKR_Full);
+		break;
+	case PCI_SUBDEV_ID_CISCO_VIC_15231: /* 25G/100G/200G KR */
+	case PCI_SUBDEV_ID_CISCO_VIC_15230: /* 25G/100G/200G KR */
+		ethtool_link_ksettings_add_link_mode(ecmd, supported,
+						     25000baseKR_Full);
+		ethtool_link_ksettings_add_link_mode(ecmd, advertising,
+						     25000baseKR_Full);
+		ethtool_link_ksettings_add_link_mode(ecmd, supported,
+						     100000baseKR_Full);
+		ethtool_link_ksettings_add_link_mode(ecmd, advertising,
+						     100000baseKR_Full);
+		ethtool_link_ksettings_add_link_mode(ecmd, supported,
+						     200000baseKR4_Full);
+		ethtool_link_ksettings_add_link_mode(ecmd, advertising,
+						     200000baseKR4_Full);
+		break;
+	}
+}
+
 static int enic_get_ksettings(struct net_device *netdev,
 			      struct ethtool_link_ksettings *ecmd)
 {
 	struct enic *enic = netdev_priv(netdev);
 	struct ethtool_link_settings *base = &ecmd->base;
 
-	ethtool_link_ksettings_add_link_mode(ecmd, supported,
-					     10000baseT_Full);
-	ethtool_link_ksettings_add_link_mode(ecmd, supported, FIBRE);
-	ethtool_link_ksettings_add_link_mode(ecmd, advertising,
-					     10000baseT_Full);
-	ethtool_link_ksettings_add_link_mode(ecmd, advertising, FIBRE);
-	base->port = PORT_FIBRE;
+	enic_get_supp_adv_media_type(netdev, ecmd);
 
 	if (netif_carrier_ok(netdev)) {
 		base->speed = vnic_dev_port_speed(enic->vdev);

-- 
2.43.0



