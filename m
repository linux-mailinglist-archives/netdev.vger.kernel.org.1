Return-Path: <netdev+bounces-271836-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2BS1A8jBxGku3QQAu9opvQ
	(envelope-from <netdev+bounces-271836-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 06:19:04 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id B78F232F4E8
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 06:19:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id CBCF93030B8B
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 05:19:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0BEF358D3D;
	Thu, 26 Mar 2026 05:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OEn/zSbu"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88CBA33F5BC;
	Thu, 26 Mar 2026 05:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774502339; cv=none; b=TyDjedoeiWBhycL4F03VZxCpkyQ5jQNAcCa83BKiOSOH7SSlN4XzsZdMSdKNBoOLti9HoZ2/ixNPTUrlemhX/BS3AZKcxQk+reVHXv9qJaMkioIVNrNJoIvesx2dO1Hvn3QuOZcuAEQE+sbCaUOPcWVsW/C8jXGNO9IiZccVqfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774502339; c=relaxed/simple;
	bh=ZxR9g+zCxK8pArCJ7PTFR8axACYwGxTDHOn4nO9U1U8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=E/8eTRKiDWbqEAHg9dGbMTH9PDAwhFLpPaMAMJ4cBqLpRCokZKl4IEtCQ9MLVx/eWPZ70CDXeNpIhveWxG7DkBTGNqIkkdtJwmBI48e57+EnfDTcjMeql+MH3jpDfllwMi7H2ykPVaIpfboDQco+lne6ygFuMWT9Mm/jrvxktOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OEn/zSbu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4722EC2BCB2;
	Thu, 26 Mar 2026 05:18:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774502339;
	bh=ZxR9g+zCxK8pArCJ7PTFR8axACYwGxTDHOn4nO9U1U8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=OEn/zSbuLWAqDs7LnTNsxTluRfu9aP8df5/l/ORq7XVZLeMg4nCLfaLafAdOm6xcn
	 06AuBcM/axg0e3oH1nua/Vn/rvUFetXmIdOsEcreNhMuZEFx31rIhfBQBjFcTg4EL8
	 jWLH5WNynLCZMtYGRnqeSeRDLtmjhoVr4ysAWwnPuF9pIFxoRrImYayKs+VsT0X/m1
	 3Yc/Wlg0nj+c5fUNU/W3V76qGJHpZwjNvG4O3sxbg6+D+VLCtj17wMEf+xK+oW/H4p
	 rKmDfSNt3qlYDRaj6TYWqEyiqebZdyYRx1vN7MUj5fjV5dxrapqgguvalP0gvLX8JQ
	 tocRoCCChSb2Q==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F96B109E536;
	Thu, 26 Mar 2026 05:18:59 +0000 (UTC)
From: Satish Kharat via B4 Relay <devnull+satishkh.cisco.com@kernel.org>
Date: Wed, 25 Mar 2026 22:19:01 -0700
Subject: [PATCH net-next v2 3/6] enic: detect SR-IOV VF type from PCI
 capability
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260325-enic-sriov-v2-prep-v2-3-f72cf716ebfa@cisco.com>
References: <20260325-enic-sriov-v2-prep-v2-0-f72cf716ebfa@cisco.com>
In-Reply-To: <20260325-enic-sriov-v2-prep-v2-0-f72cf716ebfa@cisco.com>
To: Satish Kharat <satishkh@cisco.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1774502338; l=3365;
 i=satishkh@cisco.com; h=from:subject:message-id;
 bh=EHjug9jFvuqtjK7rgKqTb+ZxcNgtnQ9ViaQc7HzlDNE=;
 b=AD0i77XBku6AEiTk8t2xkYir/gIjsd+fXx33Dw+/aSvAoL7RtiUjMV2ymSZWUddEPfCfux/yC
 q9l8UMp/3BDAoM1M835/mWX+uB0Jd9nf0RmRbbj2QmHcY9qSaA1A3fN
X-Developer-Key: i=satishkh@cisco.com; a=ed25519;
 pk=4BxbLoCGvHeIMH/PbpiNVx8/2IcTjFvqcr0AD8K6WLY=
X-Endpoint-Received: by B4 Relay for satishkh@cisco.com/default with
 auth_id=639
X-Original-From: Satish Kharat <satishkh@cisco.com>
Reply-To: satishkh@cisco.com
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_RHS_MATCH_TO(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-271836-lists,netdev=lfdr.de,satishkh.cisco.com];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_HAS_DN(0.00)[];
	HAS_REPLYTO(0.00)[satishkh@cisco.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnull@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,cisco.com:email,cisco.com:replyto,cisco.com:mid]
X-Rspamd-Queue-Id: B78F232F4E8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Satish Kharat <satishkh@cisco.com>

Read the VF device ID from the SR-IOV PCI capability at probe time to
determine whether the PF is configured for V1, USNIC, or V2 virtual
functions. Store the result in enic->vf_type for use by subsequent
SR-IOV operations.

The VF type is a firmware-configured property (set via UCSM, CIMC,
Intersight etc) that is immutable from the driver's perspective. Only
PFs are probed for this capability; VFs and dynamic vnics skip
detection.

Signed-off-by: Satish Kharat <satishkh@cisco.com>
---
 drivers/net/ethernet/cisco/enic/enic.h      |  8 +++++++
 drivers/net/ethernet/cisco/enic/enic_main.c | 37 +++++++++++++++++++++++++++++
 2 files changed, 45 insertions(+)

diff --git a/drivers/net/ethernet/cisco/enic/enic.h b/drivers/net/ethernet/cisco/enic/enic.h
index 366c65d072fc..0fd9cd917132 100644
--- a/drivers/net/ethernet/cisco/enic/enic.h
+++ b/drivers/net/ethernet/cisco/enic/enic.h
@@ -225,6 +225,13 @@ struct enic_rq {
 	struct page_pool *pool;
 } ____cacheline_aligned;
 
+enum enic_vf_type {
+	ENIC_VF_TYPE_NONE,
+	ENIC_VF_TYPE_V1,
+	ENIC_VF_TYPE_USNIC,
+	ENIC_VF_TYPE_V2,
+};
+
 /* Per-instance private data structure */
 struct enic {
 	struct net_device *netdev;
@@ -252,6 +259,7 @@ struct enic {
 #ifdef CONFIG_PCI_IOV
 	u16 num_vfs;
 #endif
+	enum enic_vf_type vf_type;
 	spinlock_t enic_api_lock;
 	bool enic_api_busy;
 	struct enic_port_profile *pp;
diff --git a/drivers/net/ethernet/cisco/enic/enic_main.c b/drivers/net/ethernet/cisco/enic/enic_main.c
index e16dfbcd2c22..acd05350ec1a 100644
--- a/drivers/net/ethernet/cisco/enic/enic_main.c
+++ b/drivers/net/ethernet/cisco/enic/enic_main.c
@@ -67,6 +67,7 @@
 #define PCI_DEVICE_ID_CISCO_VIC_ENET_DYN     0x0044  /* enet dynamic vnic */
 #define PCI_DEVICE_ID_CISCO_VIC_ENET_VF      0x0071  /* enet SRIOV VF */
 #define PCI_DEVICE_ID_CISCO_VIC_ENET_VF_V2   0x02b7  /* enet SRIOV V2 VF */
+#define PCI_DEVICE_ID_CISCO_VIC_ENET_VF_USNIC 0x00cf /* enet USNIC VF */
 
 /* Supported devices */
 static const struct pci_device_id enic_id_table[] = {
@@ -2621,6 +2622,41 @@ static void enic_iounmap(struct enic *enic)
 			iounmap(enic->bar[i].vaddr);
 }
 
+#ifdef CONFIG_PCI_IOV
+static void enic_sriov_detect_vf_type(struct enic *enic)
+{
+	struct pci_dev *pdev = enic->pdev;
+	int pos;
+	u16 vf_dev_id;
+
+	if (enic_is_sriov_vf(enic) || enic_is_dynamic(enic))
+		return;
+
+	pos = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_SRIOV);
+	if (!pos) {
+		enic->vf_type = ENIC_VF_TYPE_NONE;
+		return;
+	}
+
+	pci_read_config_word(pdev, pos + PCI_SRIOV_VF_DID, &vf_dev_id);
+
+	switch (vf_dev_id) {
+	case PCI_DEVICE_ID_CISCO_VIC_ENET_VF:
+		enic->vf_type = ENIC_VF_TYPE_V1;
+		break;
+	case PCI_DEVICE_ID_CISCO_VIC_ENET_VF_USNIC:
+		enic->vf_type = ENIC_VF_TYPE_USNIC;
+		break;
+	case PCI_DEVICE_ID_CISCO_VIC_ENET_VF_V2:
+		enic->vf_type = ENIC_VF_TYPE_V2;
+		break;
+	default:
+		enic->vf_type = ENIC_VF_TYPE_NONE;
+		break;
+	}
+}
+#endif
+
 static int enic_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 {
 	struct device *dev = &pdev->dev;
@@ -2734,6 +2770,7 @@ static int enic_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 			num_pps = enic->num_vfs;
 		}
 	}
+	enic_sriov_detect_vf_type(enic);
 #endif
 
 	/* Allocate structure for port profiles */

-- 
2.43.0



