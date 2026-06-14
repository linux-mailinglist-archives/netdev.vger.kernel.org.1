Return-Path: <netdev+bounces-299161-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id R9p0A5BXLmrUtgQAu9opvQ
	(envelope-from <netdev+bounces-299161-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 14 Jun 2026 09:26:08 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 569AC6808DD
	for <lists+netdev@lfdr.de>; Sun, 14 Jun 2026 09:26:07 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=broadcom.com header.s=google header.b=d7RLpp0W;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299161-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-299161-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=broadcom.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 075FA3029AFA
	for <lists+netdev@lfdr.de>; Sun, 14 Jun 2026 07:25:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0535E393DCD;
	Sun, 14 Jun 2026 07:25:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f97.google.com (mail-yx1-f97.google.com [74.125.224.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DB6938D687
	for <netdev@vger.kernel.org>; Sun, 14 Jun 2026 07:25:21 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781421922; cv=none; b=LhMZRUrVbltxfZsUcEtdNyPyiQjKbVZJ8YO696X4OU+TT1i0hsOsXpffj5j+Wjmmt7dkP1QdLWbE1L+Ct5M3tdXluZAVff3x5Tdxm33rdkOW7bHa9PshIRgz4tMcUrJwkTH3g/+BmPDc58fVeav7J+ZxDY/eL2XtHMWkTcFI4T4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781421922; c=relaxed/simple;
	bh=RKjkWuO2h0MIEt/xd4L7d0PbMnLFy1kiKHcJkMgs21g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hExwOZ0ypKNFwnRVflvoD0wcqLJeXjssa9hvuQZ/DVqfqDDvLm4bJQ2Wy/IRpNVB5PC+27seYnhxTHUsWsJQv8HVCBas3BqOlpb0N8u6lBrVoi7zscNbNlvpdmDBOiHmUJiA/inuChcEXRm1v6f5g3swCgYl57lgASSPccU5R+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=d7RLpp0W; arc=none smtp.client-ip=74.125.224.97
Received: by mail-yx1-f97.google.com with SMTP id 956f58d0204a3-66077e888b2so2080243d50.3
        for <netdev@vger.kernel.org>; Sun, 14 Jun 2026 00:25:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781421920; x=1782026720;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EhJuXDrwVHnDwB5NjGjjCqjZILYXugf/3cKeFZk37+I=;
        b=rzTWshnbdqCFK0eFsajRcnn2JGUsTz8o0Gpmc0CFQSYTdBuiTjSOiBvsdMGDfTDxP2
         RkYW1oMkO8oZjVlGtc+ePVilZsrTjrmBs0ZYtSHCBJ7QoOi/VS63l/5+WQHiveVHXgKQ
         yyuIdyv/qvGvSyn4Y/MdAVQ0ZX9NUfOMBOn3rzyqMOQ8pl3zLVMbHtJP4WdgahhHkyFC
         05sNeckkSVVxvSmduv/2iCWadTgeUfag3I/Ov48/9RDqda9EEN5VDqUzy4rxeJFTyBUK
         VpbsnDz+DeQSA+NYSztxpM3/c5ZnYyC58ARCEBPZioPz4uNw51DemdRCTykur1uWkohG
         85ZQ==
X-Gm-Message-State: AOJu0YyHjB4041jlBTDvHOsOgAQn1/tZ55cUb2jl4N3IDxO3tsdh122t
	k2pJHkDzBBMGaYbNpJgdd7uL8NwF/U2bqWoQFx/ME3dROpxv8/xneaWzoMepBjOz9IplfoKyCl1
	KJ9iaFZ0LAZSdSt95q1RQ5p5YZb3B/+rEwJDLV2qjU/Q+Qf7kO9w8JKMt4KJM8fYjsbWQ8nCdAM
	z+ldNYoxcFrCVSTQ8dSshFAVvpJnENQ6hcdtD5Asy7iwtz77bgaDeO3Pf/6l3BbWJBpIi0Ng6fL
	l/Tpy9lsTk=
X-Gm-Gg: Acq92OFf9XayoJ2ShbWsZPiOxPfPBNUQGGriMBmKOv8Gf3BcJOFxq5z5MiLkLdrwENT
	u658osfbQp57yuqF4PcopFiOQNrV1LCmT27pIM4qJWN/dGbjLdbxxof/BA51ySp2aYIinvpZaER
	ixplDPZ2PFU4OPk/BkKnc+hoHZg+eFFFi9kylQqzM+YhQ+nXyy5/rpLhGKmg7xcuATc7hxg1Qc5
	xaJM73Hsti6kqv/Cg7j4fUV4nmr6ExbpMznSdLMijcQpj0u0quJq5nOMLUocrli02H3gR54b+3h
	btIlCD565Fl3eFNFzMVLCTZRcKyDiobQn5GRhs8u28V7cJcXWmamDsmSopRCyub3SOx3rnjiqLi
	skfZ15hcPdbjjFxJbFvCguhF4MNzAGYEnnXN+ObxipIk3AdYrqWUuQ97sAwsUeIXZxALqC8Dh+c
	uTcOlXlGKtksFwXo9RsaHFp+GCWoXybQNAwvA1vTiSFBEoo1dTwDFH9UzP
X-Received: by 2002:a05:690e:1241:b0:660:54e4:5dd1 with SMTP id 956f58d0204a3-66278315777mr7612505d50.44.1781421920370;
        Sun, 14 Jun 2026 00:25:20 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-18.dlp.protect.broadcom.com. [144.49.247.18])
        by smtp-relay.gmail.com with ESMTPS id 956f58d0204a3-66274c5f65csm555094d50.8.2026.06.14.00.25.19
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 14 Jun 2026 00:25:20 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-3074d4102a9so6938818eec.0
        for <netdev@vger.kernel.org>; Sun, 14 Jun 2026 00:25:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1781421919; x=1782026719; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EhJuXDrwVHnDwB5NjGjjCqjZILYXugf/3cKeFZk37+I=;
        b=d7RLpp0WfoekEyxrwECAcvJhID3P4hWNyywnU3NXDXXwJnecnzOCu1hITc1Irxms5a
         wXSPHeXwfJ+1z9Me92uW40+Bu0o+rj6dirhvUoh3RHYwjI4u3MTPnSn3KaSRVoFbaiRm
         gNK4vORyS4NYi2HJzjsU2HPrq55MQ7Brj5tgE=
X-Received: by 2002:a05:7300:501:b0:2d8:97d6:6abc with SMTP id 5a478bee46e88-3082009bf1amr6327094eec.22.1781421918793;
        Sun, 14 Jun 2026 00:25:18 -0700 (PDT)
X-Received: by 2002:a05:7300:501:b0:2d8:97d6:6abc with SMTP id 5a478bee46e88-3082009bf1amr6327069eec.22.1781421918131;
        Sun, 14 Jun 2026 00:25:18 -0700 (PDT)
Received: from lvnvda3289.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3081ea43bc7sm10043280eec.22.2026.06.14.00.25.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Jun 2026 00:25:17 -0700 (PDT)
From: Michael Chan <michael.chan@broadcom.com>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	pavan.chebbi@broadcom.com,
	andrew.gospodarek@broadcom.com,
	Ajit Khaparde <ajit.khaparde@broadcom.com>
Subject: [PATCH net-next v3 03/15] bnxt_en: Set default MPC ring count
Date: Sun, 14 Jun 2026 00:23:55 -0700
Message-ID: <20260614072407.2761092-4-michael.chan@broadcom.com>
X-Mailer: git-send-email 2.45.4
In-Reply-To: <20260614072407.2761092-1-michael.chan@broadcom.com>
References: <20260614072407.2761092-1-michael.chan@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-6.16 / 15.00];
	WHITELIST_DMARC(-7.00)[broadcom.com:D:+];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-299161-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:davem@davemloft.net,m:netdev@vger.kernel.org,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:pavan.chebbi@broadcom.com,m:andrew.gospodarek@broadcom.com,m:ajit.khaparde@broadcom.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[michael.chan@broadcom.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[michael.chan@broadcom.com,netdev@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[broadcom.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	ALIAS_RESOLVED(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[broadcom.com:dkim,broadcom.com:email,broadcom.com:mid,broadcom.com:from_mime,vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 569AC6808DD

If the firmware supports MPC channels and CONFIG_BNXT_TLS is set, set
the default number of MPC channels.  These MPC rings will share MSIX
with the TX rings.  The number of MPC channels for each type must not
exceed the ethtool TX channel count.  bnxt_set_dflt_mpc_rings() will
determine the count for each MPC channel type and it cannot be directly
controlled by the user.

We also add bnxt_trim_mpc_rings() to make final adjustments in case
the number of reserved TX channels is less than expected.

Reviewed-by: Ajit Khaparde <ajit.khaparde@broadcom.com>
Reviewed-by: Andy Gospodarek <andrew.gospodarek@broadcom.com>
Reviewed-by: Pavan Chebbi <pavan.chebbi@broadcom.com>
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
---
v3:
Use proper int type for min_t().

v2:
https://lore.kernel.org/netdev/20260512212105.3488258-4-michael.chan@broadcom.com/
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c     |  7 +++
 .../net/ethernet/broadcom/bnxt/bnxt_ethtool.c |  3 +
 drivers/net/ethernet/broadcom/bnxt/bnxt_mpc.c | 63 +++++++++++++++++++
 drivers/net/ethernet/broadcom/bnxt/bnxt_mpc.h | 15 +++++
 4 files changed, 88 insertions(+)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 2ee7928ec50d..3e84a92d963d 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -13151,6 +13151,7 @@ static int __bnxt_open_nic(struct bnxt *bp, bool irq_re_init, bool link_re_init)
 		return rc;
 
 	bnxt_adj_tx_rings(bp);
+	bnxt_trim_mpc_rings(bp);
 	rc = bnxt_alloc_mem(bp, irq_re_init);
 	if (rc) {
 		netdev_err(bp->dev, "bnxt_alloc_mem err: %x\n", rc);
@@ -16691,6 +16692,7 @@ static void bnxt_trim_dflt_sh_rings(struct bnxt *bp)
 	bp->rx_nr_rings = bp->cp_nr_rings;
 	bp->tx_nr_rings_per_tc = bp->cp_nr_rings;
 	bp->tx_nr_rings = bnxt_tx_nr_rings(bp);
+	bnxt_trim_mpc_rings(bp);
 }
 
 static void bnxt_adj_dflt_rings(struct bnxt *bp, bool sh)
@@ -16742,6 +16744,8 @@ static int bnxt_set_dflt_rings(struct bnxt *bp, bool sh)
 		bnxt_set_dflt_ulp_stat_ctxs(bp);
 	}
 
+	bnxt_set_dflt_mpc_rings(bp);
+
 	rc = __bnxt_reserve_rings(bp);
 	if (rc && rc != -ENODEV)
 		netdev_warn(bp->dev, "Unable to reserve tx rings\n");
@@ -16756,6 +16760,7 @@ static int bnxt_set_dflt_rings(struct bnxt *bp, bool sh)
 		if (rc && rc != -ENODEV)
 			netdev_warn(bp->dev, "2nd rings reservation failed.\n");
 		bnxt_adj_tx_rings(bp);
+		bnxt_trim_mpc_rings(bp);
 	}
 	if (BNXT_CHIP_TYPE_NITRO_A0(bp)) {
 		bp->rx_nr_rings++;
@@ -16790,6 +16795,7 @@ static int bnxt_init_dflt_ring_mode(struct bnxt *bp)
 		goto init_dflt_ring_err;
 
 	bnxt_adj_tx_rings(bp);
+	bnxt_trim_mpc_rings(bp);
 
 	bnxt_set_dflt_rfs(bp);
 
@@ -17133,6 +17139,7 @@ static int bnxt_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 	 * limited MSIX, so we re-initialize the TX rings per TC.
 	 */
 	bp->tx_nr_rings_per_tc = bp->tx_nr_rings;
+	bnxt_trim_mpc_rings(bp);
 
 	if (BNXT_PF(bp)) {
 		if (!bnxt_pf_wq) {
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
index 56d74a3c24b7..c60c04c34fad 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
@@ -37,6 +37,7 @@
 #include "bnxt_nvm_defs.h"	/* NVRAM content constant and structure defs */
 #include "bnxt_fw_hdr.h"	/* Firmware hdr constant and structure defs */
 #include "bnxt_coredump.h"
+#include "bnxt_mpc.h"
 
 #define BNXT_NVM_ERR_MSG(dev, extack, msg)			\
 	do {							\
@@ -1050,6 +1051,8 @@ static int bnxt_set_channels(struct net_device *dev,
 
 	bnxt_set_cp_rings(bp, sh);
 
+	bnxt_set_dflt_mpc_rings(bp);
+
 	/* After changing number of rx channels, update NTUPLE feature. */
 	netdev_update_features(dev);
 	if (netif_running(dev)) {
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_mpc.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_mpc.c
index 9859a5f86268..183f1a3726c7 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_mpc.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_mpc.c
@@ -3,6 +3,7 @@
 
 #include <linux/stddef.h>
 #include <linux/types.h>
+#include <linux/kernel.h>
 #include <linux/slab.h>
 #include <linux/bnxt/hsi.h>
 
@@ -45,3 +46,65 @@ int bnxt_mpc_cp_rings_in_use(struct bnxt *bp)
 		return 0;
 	return mpc->mpc_cp_rings;
 }
+
+void bnxt_trim_mpc_rings(struct bnxt *bp)
+{
+	struct bnxt_mpc_info *mpc = bp->mpc_info;
+	int max = bp->tx_nr_rings_per_tc;
+	u8 max_cp = 0;
+	int i;
+
+	if (!mpc)
+		return;
+
+	for (i = 0; i < BNXT_MPC_TYPE_MAX; i++) {
+		mpc->mpc_ring_count[i] = min_t(int, mpc->mpc_ring_count[i],
+					       max);
+		max_cp = max(max_cp, mpc->mpc_ring_count[i]);
+	}
+	mpc->mpc_cp_rings = max_cp;
+}
+
+void bnxt_set_dflt_mpc_rings(struct bnxt *bp)
+{
+	struct bnxt_hw_resc *hw_resc = &bp->hw_resc;
+	struct bnxt_mpc_info *mpc = bp->mpc_info;
+	int mpc_tce, mpc_rce, avail, mpc_cp, i;
+
+	if (!BNXT_MPC_CRYPTO_CAPABLE(bp))
+		return;
+
+	avail = hw_resc->max_tx_rings - bp->tx_nr_rings;
+	/* don't use more than 80% */
+	avail = avail * 4 / 5;
+
+	if (avail < (BNXT_MIN_MPC_TCE + BNXT_MIN_MPC_RCE))
+		goto disable_mpc;
+
+	mpc_tce = min_t(int, avail / 2, bp->tx_nr_rings_per_tc);
+	mpc_rce = mpc_tce;
+
+	mpc_tce = min_t(int, mpc_tce, BNXT_DFLT_MPC_TCE);
+	mpc_rce = min_t(int, mpc_rce, BNXT_DFLT_MPC_RCE);
+
+	avail = hw_resc->max_cp_rings - bp->tx_nr_rings -
+		bp->rx_nr_rings;
+
+	if (avail < BNXT_MIN_MPC_TCE || avail < BNXT_MIN_MPC_RCE)
+		goto disable_mpc;
+
+	mpc_tce = min(mpc_tce, avail);
+	mpc_rce = min(mpc_rce, avail);
+
+	mpc_cp = max(mpc_tce, mpc_rce);
+
+	mpc->mpc_ring_count[BNXT_MPC_TCE_TYPE] = mpc_tce;
+	mpc->mpc_ring_count[BNXT_MPC_RCE_TYPE] = mpc_rce;
+	mpc->mpc_cp_rings = mpc_cp;
+	return;
+
+disable_mpc:
+	mpc->mpc_cp_rings = 0;
+	for (i = 0; i < BNXT_MPC_TYPE_MAX; i++)
+		mpc->mpc_ring_count[i] = 0;
+}
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_mpc.h b/drivers/net/ethernet/broadcom/bnxt/bnxt_mpc.h
index 7a7d81197ea6..4ff8cad75a23 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_mpc.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_mpc.h
@@ -17,6 +17,11 @@ enum bnxt_mpc_type {
 
 #define BNXT_MAX_MPC		8
 
+#define BNXT_MIN_MPC_TCE	1
+#define BNXT_MIN_MPC_RCE	1
+#define BNXT_DFLT_MPC_TCE	BNXT_MAX_MPC
+#define BNXT_DFLT_MPC_RCE	BNXT_MAX_MPC
+
 struct bnxt_mpc_info {
 	u8			mpc_chnls_cap;
 	u8			mpc_cp_rings;
@@ -37,6 +42,8 @@ void bnxt_alloc_mpc_info(struct bnxt *bp, u8 mpc_chnls_cap);
 void bnxt_free_mpc_info(struct bnxt *bp);
 int bnxt_mpc_tx_rings_in_use(struct bnxt *bp);
 int bnxt_mpc_cp_rings_in_use(struct bnxt *bp);
+void bnxt_trim_mpc_rings(struct bnxt *bp);
+void bnxt_set_dflt_mpc_rings(struct bnxt *bp);
 #else
 static inline void bnxt_alloc_mpc_info(struct bnxt *bp, u8 mpc_chnls_cap)
 {
@@ -55,5 +62,13 @@ static inline int bnxt_mpc_cp_rings_in_use(struct bnxt *bp)
 {
 	return 0;
 }
+
+static inline void bnxt_trim_mpc_rings(struct bnxt *bp)
+{
+}
+
+static inline void bnxt_set_dflt_mpc_rings(struct bnxt *bp)
+{
+}
 #endif	/* CONFIG_BNXT_TLS */
 #endif	/* BNXT_MPC_H */
-- 
2.51.0


