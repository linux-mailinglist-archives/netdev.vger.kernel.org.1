Return-Path: <netdev+bounces-271428-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MLU2ER2Nw2nJrQQAu9opvQ
	(envelope-from <netdev+bounces-271428-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 08:22:05 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 010493209D3
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 08:22:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 312B430A2FA1
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 07:21:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6BA1363C52;
	Wed, 25 Mar 2026 07:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="afsCAQdM"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3E12355049;
	Wed, 25 Mar 2026 07:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774423299; cv=none; b=RAlYk5Wg1kTPQPP1Byg15IHIpw+iB11cD68z3Sn20tothxZuZP7ayewEjvVXred8jFKsZXDNONu3WzRpJDl2Nqz2n5wr2bm/9SpgfQMI/IpRDesZ205Pnlso/dpgcK2nniT+Ehmq3k20iyIA1IdQoXAL0LB5YtS/+zYJISCiv7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774423299; c=relaxed/simple;
	bh=ZxR9g+zCxK8pArCJ7PTFR8axACYwGxTDHOn4nO9U1U8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=X6sIsaW1sl66zbCpWoY8Z9C73LXJnped+AsKs2Tk/uVbR1YO8XAcF1zqGI2wtKmNhG1AmZOiphTRCCPPMXJ6nzW/hjOxBT5Y0LsCC230uqHWGoC3rdiHw0m6HLPLTOeK/9B5ArK3MGx5y25oyIfeJiGXkTPQkMp4NJ+Ui1BlUCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=afsCAQdM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 98AEBC2BC9E;
	Wed, 25 Mar 2026 07:21:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774423299;
	bh=ZxR9g+zCxK8pArCJ7PTFR8axACYwGxTDHOn4nO9U1U8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=afsCAQdMDohdM8Xige7WpifiM9awuLuo7JPAYsMHoRQSetlugJ1fuEnWBPrPOm4H2
	 6cIrHlOqtRcLcF40j5G5k1Fo0ktPIhezNgKGSJYYCvdgCtT+FaM4Vnh8mqEEnxdKDX
	 zHi7xtlE1aE1L8FvLjZHsOCVqO54+iveIcEThmMCb9asS1pT2LbpDiaR2VBgsfu9il
	 NDhmP2hyk8TG9YbW7fuPGZO8bXFIcrlHOfJjv1oYbUgdXiy+S+Anw5BMxSWaI7NNjh
	 4lDcYVmi3e2UQM3mFH3ymPETQWW7V7d3HP7aVu5BwwCK4Jv8PRGL7ZLJMNsKwleoDn
	 /R02i8cn8hF2Q==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91C89FEA820;
	Wed, 25 Mar 2026 07:21:39 +0000 (UTC)
From: Satish Kharat via B4 Relay <devnull+satishkh.cisco.com@kernel.org>
Date: Wed, 25 Mar 2026 00:21:41 -0700
Subject: [PATCH net-next 3/6] enic: detect SR-IOV VF type from PCI
 capability
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260325-enic-sriov-v2-prep-v1-3-48f04ce110cc@cisco.com>
References: <20260325-enic-sriov-v2-prep-v1-0-48f04ce110cc@cisco.com>
In-Reply-To: <20260325-enic-sriov-v2-prep-v1-0-48f04ce110cc@cisco.com>
To: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Satish Kharat <satishkh@cisco.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1774423298; l=3365;
 i=satishkh@cisco.com; h=from:subject:message-id;
 bh=EHjug9jFvuqtjK7rgKqTb+ZxcNgtnQ9ViaQc7HzlDNE=;
 b=yaOkGTKgsAhWqOdG77B5YS9h9fMZk/RoDGHOV+CUnvb4VnF5EFzIRQe9UXT8rvoPSrrf1lRt1
 AaX3Bc4KwzOC4ZagmU9mgsJugzBW/VI1b2IWi9sS/aqXGddy268o3yf
X-Developer-Key: i=satishkh@cisco.com; a=ed25519;
 pk=4BxbLoCGvHeIMH/PbpiNVx8/2IcTjFvqcr0AD8K6WLY=
X-Endpoint-Received: by B4 Relay for satishkh@cisco.com/default with
 auth_id=639
X-Original-From: Satish Kharat <satishkh@cisco.com>
Reply-To: satishkh@cisco.com
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-271428-lists,netdev=lfdr.de,satishkh.cisco.com];
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
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	HAS_REPLYTO(0.00)[satishkh@cisco.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,cisco.com:email,cisco.com:replyto,cisco.com:mid]
X-Rspamd-Queue-Id: 010493209D3
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



