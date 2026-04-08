Return-Path: <netdev+bounces-276637-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UFNTGEGE1mmwFwgAu9opvQ
	(envelope-from <netdev+bounces-276637-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 18:37:21 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CCE353BEEBD
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 18:37:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 495BC3017FA0
	for <lists+netdev@lfdr.de>; Wed,  8 Apr 2026 16:36:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD92D3D8138;
	Wed,  8 Apr 2026 16:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q0WU8sgD"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C0493D3336;
	Wed,  8 Apr 2026 16:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775666185; cv=none; b=HqfKgBXPv6E3P/WiISbENWHUz39V6xJBzTqH3UhJpN+Zu8d5lR6TkCxffzACl5ijXDIRxO+GT0wPSFRzXV3v5UwHBAPmJzF6kyJz9olBg8zYFvuTAd0hLds51KQy4NButu0amqU5cQpNcfHNAi4vdnBXt5IiY7m/K5UXqhWZDSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775666185; c=relaxed/simple;
	bh=hM8dMeKXmS+dvWPySSm3oBnImgqDeTAGUZzSdcDsdBM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=inZyXzYaBqIwNzSksYSCggewYpk050VBGxNuGmEbld0Hv8m92KgvcdjMZQxApjL1uiQ1mgoW2XAvz+NTcCzLANUwXKKg61OfQA9jaq513lDEXfEoIDTd/2To2ciRiq28RgWWUw26Aya29u/pvo7fQlDU1QGNyemGcEUhiI3DYqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q0WU8sgD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7FEAAC2BCB1;
	Wed,  8 Apr 2026 16:36:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775666185;
	bh=hM8dMeKXmS+dvWPySSm3oBnImgqDeTAGUZzSdcDsdBM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=q0WU8sgDI2a89Mm1Jl2uV254HwzbbdZ/Ve+yZQ1aJ7FasQCuAGAp7LxgheLtZq6TJ
	 EzwOscdJ+XqzKlitc9PAe1NIG9/NIlo6cNgnBZlpwKc97JEzHP8aCqcU7i61rT314b
	 2MErnb3/l7lEYHdTLYW7WCEQioU3wDlfv6vOhEzN7KuXbrbUR8eJAuN0ZmSoToPWaU
	 GDcBbVmfBgqsOtRqJ2pDzAou56TusJerd6gVkDressNte+xXeFeDNZi2oiEY7D+gNs
	 7rTQIYl1I0uMHTgOkNHMXgi3EwAJTnRtX5BuJw7yYhrWG/fka3/Kr1OaVQgaWZWPnn
	 inQ7MXIs2TigQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AB6B10F9960;
	Wed,  8 Apr 2026 16:36:25 +0000 (UTC)
From: Satish Kharat via B4 Relay <devnull+satishkh.cisco.com@kernel.org>
Date: Wed, 08 Apr 2026 09:36:30 -0700
Subject: [PATCH net-next v3 09/10] enic: wire V2 SR-IOV enable with admin
 channel and MBOX
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260408-enic-sriov-v2-admin-channel-v2-v3-9-1d4999a03cec@cisco.com>
References: <20260408-enic-sriov-v2-admin-channel-v2-v3-0-1d4999a03cec@cisco.com>
In-Reply-To: <20260408-enic-sriov-v2-admin-channel-v2-v3-0-1d4999a03cec@cisco.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 20260401-enic-sriov-v2-prep-v4-0-d5834b2ef1b9@cisco.com, 
 Satish Kharat <satishkh@cisco.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1775666183; l=6968;
 i=satishkh@cisco.com; h=from:subject:message-id;
 bh=zCB5qvsG6G0FZO/eisMOenEoWZcr+34AiANPF/df2Q0=;
 b=/6z99TSxFKZa9lB9letaY8arc2IgT5cBGZXsaU8XBQylA7ooi3YDgyMfWJz+SsjnZQg6uFRj7
 wOznU+StGwjCPNVkNqMLvdQ2czipM1xIS8+LhGTr1wBWPm6uzfOTsqi
X-Developer-Key: i=satishkh@cisco.com; a=ed25519;
 pk=4BxbLoCGvHeIMH/PbpiNVx8/2IcTjFvqcr0AD8K6WLY=
X-Endpoint-Received: by B4 Relay for satishkh@cisco.com/default with
 auth_id=639
X-Original-From: Satish Kharat <satishkh@cisco.com>
Reply-To: satishkh@cisco.com
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-276637-lists,netdev=lfdr.de,satishkh.cisco.com];
	FROM_HAS_DN(0.00)[];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	HAS_REPLYTO(0.00)[satishkh@cisco.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnull@kernel.org,netdev@vger.kernel.org];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[cisco.com:email,cisco.com:replyto,cisco.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: CCE353BEEBD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Satish Kharat <satishkh@cisco.com>

Extend enic_sriov_configure() to handle V2 SR-IOV VFs. When the PF
detects V2 VF device IDs, the enable path allocates per-VF MBOX state,
opens the admin channel, initializes the MBOX protocol, and then calls
pci_enable_sriov(). The admin channel must be ready before VFs are
created so that VF drivers can immediately begin the MBOX capability
and registration handshake during their probe.

The disable path reverses this order: pci_disable_sriov() first (so VF
drivers unregister via MBOX), then the admin channel is closed and
per-VF state is freed.

The existing V1/USNIC SR-IOV paths are unchanged.

Signed-off-by: Satish Kharat <satishkh@cisco.com>
---
 drivers/net/ethernet/cisco/enic/enic_main.c | 137 ++++++++++++++++++++++++++--
 drivers/net/ethernet/cisco/enic/enic_res.c  |   1 +
 drivers/net/ethernet/cisco/enic/vnic_enet.h |   4 +-
 3 files changed, 134 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/cisco/enic/enic_main.c b/drivers/net/ethernet/cisco/enic/enic_main.c
index 73bb59eef7a0..39b0d635f1fc 100644
--- a/drivers/net/ethernet/cisco/enic/enic_main.c
+++ b/drivers/net/ethernet/cisco/enic/enic_main.c
@@ -60,6 +60,8 @@
 #include "enic_clsf.h"
 #include "enic_rq.h"
 #include "enic_wq.h"
+#include "enic_admin.h"
+#include "enic_mbox.h"
 
 #define ENIC_NOTIFY_TIMER_PERIOD	(2 * HZ)
 
@@ -2689,6 +2691,120 @@ static void enic_sriov_detect_vf_type(struct enic *enic)
 		enic->vf_type = ENIC_VF_TYPE_NONE;
 	}
 }
+
+static int __maybe_unused
+enic_sriov_v2_enable(struct enic *enic, int num_vfs)
+{
+	int err;
+
+	if (!enic->has_admin_channel) {
+		netdev_err(enic->netdev,
+			   "V2 SR-IOV requires admin channel resources\n");
+		return -EOPNOTSUPP;
+	}
+
+	enic->vf_state = kcalloc(num_vfs, sizeof(*enic->vf_state), GFP_KERNEL);
+	if (!enic->vf_state)
+		return -ENOMEM;
+
+	err = enic_admin_channel_open(enic);
+	if (err) {
+		netdev_err(enic->netdev,
+			   "Failed to open admin channel: %d\n", err);
+		goto free_vf_state;
+	}
+
+	enic_mbox_init(enic);
+
+	enic->num_vfs = num_vfs;
+
+	err = pci_enable_sriov(enic->pdev, num_vfs);
+	if (err) {
+		netdev_err(enic->netdev,
+			   "pci_enable_sriov failed: %d\n", err);
+		goto close_admin;
+	}
+
+	enic->priv_flags |= ENIC_SRIOV_ENABLED;
+	return num_vfs;
+
+close_admin:
+	enic->num_vfs = 0;
+	enic_admin_channel_close(enic);
+free_vf_state:
+	kfree(enic->vf_state);
+	enic->vf_state = NULL;
+	return err;
+}
+
+static void enic_sriov_v2_disable(struct enic *enic)
+{
+	pci_disable_sriov(enic->pdev);
+	enic_admin_channel_close(enic);
+	kfree(enic->vf_state);
+	enic->vf_state = NULL;
+	enic->num_vfs = 0;
+	enic->priv_flags &= ~ENIC_SRIOV_ENABLED;
+}
+
+static int __maybe_unused
+enic_sriov_configure(struct pci_dev *pdev, int num_vfs)
+{
+	struct net_device *netdev = pci_get_drvdata(pdev);
+	struct enic *enic = netdev_priv(netdev);
+	struct enic_port_profile *pp;
+	int err;
+
+	if (num_vfs > 0) {
+		if (enic->config.mq_subvnic_count) {
+			netdev_err(netdev,
+				   "SR-IOV not supported with multi-queue sub-vnics\n");
+			return -EOPNOTSUPP;
+		}
+
+		if (enic->vf_type == ENIC_VF_TYPE_NONE) {
+			netdev_err(netdev,
+				   "SR-IOV not supported on this firmware version\n");
+			return -EOPNOTSUPP;
+		}
+
+		if (enic->vf_type == ENIC_VF_TYPE_V2)
+			return enic_sriov_v2_enable(enic, num_vfs);
+
+		pp = kcalloc(num_vfs, sizeof(*pp), GFP_KERNEL);
+		if (!pp)
+			return -ENOMEM;
+
+		err = pci_enable_sriov(pdev, num_vfs);
+		if (err) {
+			kfree(pp);
+			return err;
+		}
+
+		kfree(enic->pp);
+		enic->pp = pp;
+		enic->num_vfs = num_vfs;
+		enic->priv_flags |= ENIC_SRIOV_ENABLED;
+		return num_vfs;
+	}
+
+	if (!enic_sriov_enabled(enic))
+		return 0;
+
+	if (enic->vf_type == ENIC_VF_TYPE_V2) {
+		enic_sriov_v2_disable(enic);
+		return 0;
+	}
+
+	pci_disable_sriov(pdev);
+	enic->num_vfs = 0;
+	enic->priv_flags &= ~ENIC_SRIOV_ENABLED;
+
+	kfree(enic->pp);
+	enic->pp = kzalloc(sizeof(*enic->pp), GFP_KERNEL);
+
+	return 0;
+}
 #endif
 
 static int enic_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
@@ -2787,12 +2903,18 @@ static int enic_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 		goto err_out_vnic_unregister;
 
 #ifdef CONFIG_PCI_IOV
-	/* Get number of subvnics */
+	enic_sriov_detect_vf_type(enic);
+
+	/* Auto-enable SR-IOV if VFs were pre-configured (e.g. at boot).
+	 * V2 VFs require the admin channel, which is not yet set up at probe
+	 * time; use sysfs (enic_sriov_configure) to enable V2 SR-IOV instead.
+	 */
 	pos = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_SRIOV);
 	if (pos) {
 		pci_read_config_word(pdev, pos + PCI_SRIOV_TOTAL_VF,
 			&enic->num_vfs);
-		if (enic->num_vfs) {
+		if (enic->num_vfs &&
+		    enic->vf_type != ENIC_VF_TYPE_V2) {
 			err = pci_enable_sriov(pdev, enic->num_vfs);
 			if (err) {
 				dev_err(dev, "SRIOV enable failed, aborting."
@@ -2804,7 +2926,6 @@ static int enic_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 			num_pps = enic->num_vfs;
 		}
 	}
-	enic_sriov_detect_vf_type(enic);
 #endif
 
 	/* Allocate structure for port profiles */
@@ -3033,14 +3154,16 @@ static void enic_remove(struct pci_dev *pdev)
 		cancel_work_sync(&enic->reset);
 		cancel_work_sync(&enic->change_mtu_work);
 		unregister_netdev(netdev);
-		enic_dev_deinit(enic);
-		vnic_dev_close(enic->vdev);
 #ifdef CONFIG_PCI_IOV
 		if (enic_sriov_enabled(enic)) {
-			pci_disable_sriov(pdev);
-			enic->priv_flags &= ~ENIC_SRIOV_ENABLED;
+			if (enic->vf_type == ENIC_VF_TYPE_V2)
+				enic_sriov_v2_disable(enic);
+			else
+				pci_disable_sriov(pdev);
 		}
 #endif
+		enic_dev_deinit(enic);
+		vnic_dev_close(enic->vdev);
 		kfree(enic->pp);
 		vnic_dev_unregister(enic->vdev);
 		enic_iounmap(enic);
diff --git a/drivers/net/ethernet/cisco/enic/enic_res.c b/drivers/net/ethernet/cisco/enic/enic_res.c
index 2b7545d6a67f..436326ace049 100644
--- a/drivers/net/ethernet/cisco/enic/enic_res.c
+++ b/drivers/net/ethernet/cisco/enic/enic_res.c
@@ -59,6 +59,7 @@ int enic_get_vnic_config(struct enic *enic)
 	GET_CONFIG(intr_timer_usec);
 	GET_CONFIG(loop_tag);
 	GET_CONFIG(num_arfs);
+	GET_CONFIG(mq_subvnic_count);
 	GET_CONFIG(max_rq_ring);
 	GET_CONFIG(max_wq_ring);
 	GET_CONFIG(max_cq_ring);
diff --git a/drivers/net/ethernet/cisco/enic/vnic_enet.h b/drivers/net/ethernet/cisco/enic/vnic_enet.h
index 9e8e86262a3f..519d2969990b 100644
--- a/drivers/net/ethernet/cisco/enic/vnic_enet.h
+++ b/drivers/net/ethernet/cisco/enic/vnic_enet.h
@@ -21,7 +21,9 @@ struct vnic_enet_config {
 	u16 loop_tag;
 	u16 vf_rq_count;
 	u16 num_arfs;
-	u8 reserved[66];
+	u8 reserved1[32];
+	u16 mq_subvnic_count;
+	u8 reserved2[32];
 	u32 max_rq_ring;	// MAX RQ ring size
 	u32 max_wq_ring;	// MAX WQ ring size
 	u32 max_cq_ring;	// MAX CQ ring size

-- 
2.43.0



