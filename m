Return-Path: <netdev+bounces-306424-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 8ZyvEhh0UGoezQIAu9opvQ
	(envelope-from <netdev+bounces-306424-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 06:24:56 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id D328F7371DA
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 06:24:55 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=broadcom.com header.s=google header.b="Wua0C/W6";
	dmarc=pass (policy=reject) header.from=broadcom.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306424-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-306424-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 05C53301B83F
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 04:24:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A558F36D506;
	Fri, 10 Jul 2026 04:24:53 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f228.google.com (mail-pl1-f228.google.com [209.85.214.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2E2A36C9ED
	for <netdev@vger.kernel.org>; Fri, 10 Jul 2026 04:24:51 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783657493; cv=none; b=rXYkmBDPOhdOI91HXskSbOnapvC801x4kzSBUjQW2Zu0Djgtcxf2Wk0GOuZcAZNgjJDSZ4SG0K74xfyPLARDlCucowWDGXThFJaxjshTNFOLz4VJxqM2uYQaDX4Ya2REGr9Hq5KwmVcJTC6j+l9wypqnDFjrk3gmtk3sC1DthrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783657493; c=relaxed/simple;
	bh=HsXK+TJaMMpQ7XfKAgHoQXATFtaYtDhgPKbELrcUmQw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ElhBCpjPYAw7ilUEthB4qGKHINBqmMbRELxKlPD4JIm7Dr61GypgMjmu723dnW6Hi8DcYfiEZUO9kPstu2hgjlKGMM63Uv3VeKgxbHd6Vx0ddWlmjyzOlzmdAYZkSjGGDOgYT51zkdIg+cVVmdnmr23kR8tA7AonY1NsqQBZy+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Wua0C/W6; arc=none smtp.client-ip=209.85.214.228
Received: by mail-pl1-f228.google.com with SMTP id d9443c01a7336-2cace7da66eso4975125ad.0
        for <netdev@vger.kernel.org>; Thu, 09 Jul 2026 21:24:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783657491; x=1784262291;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=f+X7pWIoiimFwVjwZa+UzQHKI81GF73FDAzHU+3i81A=;
        b=nwleuTzlP3NEohO4jz+OC/d/wreiRlVs9uOFhCfcVCZqR3eGABo3PURE9lFGVddmPP
         RUbxx7dcdmQZL8G+23R3MhAMEPm9nHAtB2fvfxj+ulsq2Dg4/j3UIJyZcNHE4mwxjTwa
         ApTCTenzoLQV/MmIGjz1Dr2EfrYBmdtX0fJdobB8qF9KRXdi9T2FCOKKZZYcrYCnwSLd
         3vxnR3gRPclYVAr7f1ZIyPgVDGitH0p8QRatz1fUnsT3knvFNbvTOBjFOaxvdF0SihSi
         8ngID6khdSQg4TECNExRr/CU3xemAMuQ/UbBfVmMBAShyr/h71wbBl+HfIfJuCIcsG+U
         pLoA==
X-Gm-Message-State: AOJu0Yy7CDb6nNCEcwHgNJQx/HdsgN3+g3NXg9ZC/QGhplrEJOPizoqO
	fSikNzpRaS93g08rpEXdF1SAwgBFHgnWFBtG5BDIfcKtgmas8ztwffOjQo80JzYdW+lZgMD+QyF
	gum8abPt58mWeVsqK+SEWh4yqA8T8acaQsanLRiu5fFCSSQf2hHk1LbaXcCIEHxwxo6dTnihuKC
	0fYQjA0/LNj7LzwcagverH0mdiwnERtP/aw3gRDJTgrH8tk4aOxLTz1Mj0TskWjw+rwjx8puN44
	8Ktb2OhAxI=
X-Gm-Gg: AfdE7clxjiZHA7BMPM1Z8aMqds+0fM7yWCWtPvTi4FkRVP5dkeyoWeaiF2OII5Gqu5I
	0jtRQFF1Qc4jOfvRAdOmpBxjZ9m1NKHa8Iud/JSuCL1zWROD02+mymZeH6AUPUkvUjAcCPn/e4g
	RxBg2iQDdotLJ2xi2MQ3s9fCbDsmk3J/NB2UO3LzJNdlXIjmSVFyV1H2sYmu0B5/g37qJVYZfz8
	mN2zZTZ3Vd7tg4zYmBV980RiEmpQjVlkV7eMnXodANOnMheX7VziU/VsEShBpOwipCXwq7tJG2X
	wZ2Y6kVe0J5Bxle8F2sMcOfW6uDtUTtgQd8bpwyQTlWkzIGYNRPfBDCzOtrqhOiZbAi3zFDnOpi
	b06jGMa7jthT8JV1hETds1itHBxguGYHlNo78Ro6z/bpRxzHNWAz3tlRiVN/u+kEXFENXHqEdzy
	jSv/kRKWz2nhZG3j1gEXrfUztSA43uA6A4F/nHstVHAdz/Mw==
X-Received: by 2002:a17:903:b46:b0:2cc:1452:a014 with SMTP id d9443c01a7336-2ccea3a7a46mr93076075ad.18.1783657491133;
        Thu, 09 Jul 2026 21:24:51 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-11.dlp.protect.broadcom.com. [144.49.247.11])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-2ccc9bc58ebsm9719885ad.4.2026.07.09.21.24.50
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 Jul 2026 21:24:51 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-ca6bd8a190cso823870a12.0
        for <netdev@vger.kernel.org>; Thu, 09 Jul 2026 21:24:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1783657489; x=1784262289; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=f+X7pWIoiimFwVjwZa+UzQHKI81GF73FDAzHU+3i81A=;
        b=Wua0C/W6RTG2joFWIDDXDgFXpVzcS/YApWotGEVmC3oEdwYYVRo/hSapGmnPvMPpUz
         tJYAsK3WLwJZs/zRS06WDGzAboodX2gffVnogODP6tD8b6G5HlFzdXxX0T1BHOR+22Wp
         XZpKPCjARV4NUJHbxkjDZb9J86KYVM7eX2YOQ=
X-Received: by 2002:a05:6a21:4e02:b0:3c0:9c19:65c1 with SMTP id adf61e73a8af0-3c0bcd20167mr11078854637.73.1783657488830;
        Thu, 09 Jul 2026 21:24:48 -0700 (PDT)
X-Received: by 2002:a05:6a21:4e02:b0:3c0:9c19:65c1 with SMTP id adf61e73a8af0-3c0bcd20167mr11078819637.73.1783657488300;
        Thu, 09 Jul 2026 21:24:48 -0700 (PDT)
Received: from lvnvda3289.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-313b4cbafa1sm276627eec.6.2026.07.09.21.24.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 21:24:47 -0700 (PDT)
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
Subject: [PATCH net-next v5 03/15] bnxt_en: Set default MPC ring count
Date: Thu,  9 Jul 2026 21:23:48 -0700
Message-ID: <20260710042400.3996847-4-michael.chan@broadcom.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260710042400.3996847-1-michael.chan@broadcom.com>
References: <20260710042400.3996847-1-michael.chan@broadcom.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-306424-lists,netdev=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D328F7371DA

If the firmware supports MPC channels and CONFIG_BNXT_TLS is set, set
the default number of MPC channels.  These MPC rings will share MSIX
with the TX rings.  The number of MPC channels for each type must not
exceed the ethtool TX channel count.  When changing ethtool channels,
bnxt_calc_dflt_mpc_rings() will determine the default MPC rings for
the newly requested channel count and we call bnxt_check_rings() to
check before we commit.  bnxt_set_dflt_mpc_rings() will set the
committed MPC rings for the new committed channel count.

We also add bnxt_trim_mpc_rings() to make final adjustments in case
the number of reserved TX channels is less than expected.

Reviewed-by: Ajit Khaparde <ajit.khaparde@broadcom.com>
Reviewed-by: Andy Gospodarek <andrew.gospodarek@broadcom.com>
Reviewed-by: Pavan Chebbi <pavan.chebbi@broadcom.com>
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
---
v5:
Improve the ethtool -L MPC calculation to use the actual MPC rings
during ring check.

Add a comment in the code to explain the bnxt_trim_mpc_ring() call.

v3:
https://lore.kernel.org/netdev/20260614072407.2761092-4-michael.chan@broadcom.com/

Use proper int type for min_t().

v2:
https://lore.kernel.org/netdev/20260512212105.3488258-4-michael.chan@broadcom.com/
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c     | 11 +++
 .../net/ethernet/broadcom/bnxt/bnxt_ethtool.c |  8 ++-
 drivers/net/ethernet/broadcom/bnxt/bnxt_mpc.c | 72 +++++++++++++++++++
 drivers/net/ethernet/broadcom/bnxt/bnxt_mpc.h | 27 +++++++
 4 files changed, 117 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 519437d61298..56de663f3027 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -13196,6 +13196,7 @@ static int __bnxt_open_nic(struct bnxt *bp, bool irq_re_init, bool link_re_init)
 		return rc;
 
 	bnxt_adj_tx_rings(bp);
+	bnxt_trim_mpc_rings(bp);
 	rc = bnxt_alloc_mem(bp, irq_re_init);
 	if (rc) {
 		netdev_err(bp->dev, "bnxt_alloc_mem err: %x\n", rc);
@@ -16745,6 +16746,7 @@ static void bnxt_trim_dflt_sh_rings(struct bnxt *bp)
 	bp->rx_nr_rings = bp->cp_nr_rings;
 	bp->tx_nr_rings_per_tc = bp->cp_nr_rings;
 	bp->tx_nr_rings = bnxt_tx_nr_rings(bp);
+	bnxt_trim_mpc_rings(bp);
 }
 
 static void bnxt_adj_dflt_rings(struct bnxt *bp, bool sh)
@@ -16796,6 +16798,8 @@ static int bnxt_set_dflt_rings(struct bnxt *bp, bool sh)
 		bnxt_set_dflt_ulp_stat_ctxs(bp);
 	}
 
+	bnxt_set_dflt_mpc_rings(bp);
+
 	rc = __bnxt_reserve_rings(bp);
 	if (rc && rc != -ENODEV)
 		netdev_warn(bp->dev, "Unable to reserve tx rings\n");
@@ -16810,6 +16814,11 @@ static int bnxt_set_dflt_rings(struct bnxt *bp, bool sh)
 		if (rc && rc != -ENODEV)
 			netdev_warn(bp->dev, "2nd rings reservation failed.\n");
 		bnxt_adj_tx_rings(bp);
+		/* Re-cap MPC ring counts against the reduced TX rings.
+		 * Any extra reserved MPC rings will be reconciled on
+		 * the next open.
+		 */
+		bnxt_trim_mpc_rings(bp);
 	}
 	if (BNXT_CHIP_TYPE_NITRO_A0(bp)) {
 		bp->rx_nr_rings++;
@@ -16844,6 +16853,7 @@ static int bnxt_init_dflt_ring_mode(struct bnxt *bp)
 		goto init_dflt_ring_err;
 
 	bnxt_adj_tx_rings(bp);
+	bnxt_trim_mpc_rings(bp);
 
 	bnxt_set_dflt_rfs(bp);
 
@@ -17187,6 +17197,7 @@ static int bnxt_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 	 * limited MSIX, so we re-initialize the TX rings per TC.
 	 */
 	bp->tx_nr_rings_per_tc = bp->tx_nr_rings;
+	bnxt_trim_mpc_rings(bp);
 
 	if (BNXT_PF(bp)) {
 		if (!bnxt_pf_wq) {
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
index 88d879a27820..4bc3cac57b13 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
@@ -960,7 +960,7 @@ static int bnxt_set_channels(struct net_device *dev,
 	struct bnxt *bp = netdev_priv(dev);
 	int req_tx_rings, req_rx_rings, tcs;
 	u32 new_tbl_size = 0, old_tbl_size;
-	int mpc_per_type = 0, mpc_cp = 0;
+	int mpc_per_type, mpc_cp;
 	bool sh = false;
 	int tx_xdp = 0;
 	int rc = 0;
@@ -995,6 +995,10 @@ static int bnxt_set_channels(struct net_device *dev,
 		tx_xdp = req_rx_rings;
 	}
 
+	bnxt_calc_dflt_mpc_rings(bp,
+				 req_tx_rings * (tcs > 1 ? tcs : 1) + tx_xdp,
+				 req_tx_rings, req_rx_rings, &mpc_per_type,
+				 &mpc_cp);
 	rc = bnxt_check_rings(bp, req_tx_rings, req_rx_rings, sh, tcs, tx_xdp,
 			      mpc_per_type * BNXT_MPC_TYPE_MAX, mpc_cp);
 	if (rc) {
@@ -1054,6 +1058,8 @@ static int bnxt_set_channels(struct net_device *dev,
 
 	bnxt_set_cp_rings(bp, sh);
 
+	bnxt_set_dflt_mpc_rings(bp);
+
 	/* After changing number of rx channels, update NTUPLE feature. */
 	netdev_update_features(dev);
 	if (netif_running(dev)) {
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_mpc.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_mpc.c
index 9859a5f86268..26eef764c544 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_mpc.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_mpc.c
@@ -3,6 +3,7 @@
 
 #include <linux/stddef.h>
 #include <linux/types.h>
+#include <linux/kernel.h>
 #include <linux/slab.h>
 #include <linux/bnxt/hsi.h>
 
@@ -45,3 +46,74 @@ int bnxt_mpc_cp_rings_in_use(struct bnxt *bp)
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
+void bnxt_calc_dflt_mpc_rings(struct bnxt *bp, int tx_nr_rings,
+			      int tx_nr_rings_per_tc, int rx_nr_rings,
+			      int *mpc_per_type, int *mpc_cp)
+{
+	struct bnxt_hw_resc *hw_resc = &bp->hw_resc;
+	int mpc_tce, avail;
+
+	*mpc_per_type = 0;
+	*mpc_cp = 0;
+
+	if (!BNXT_MPC_CRYPTO_CAPABLE(bp))
+		return;
+
+	avail = hw_resc->max_tx_rings - tx_nr_rings;
+	/* don't use more than 80% */
+	avail = avail * 4 / 5;
+
+	if (avail < (BNXT_MIN_MPC_TCE + BNXT_MIN_MPC_RCE))
+		return;
+
+	mpc_tce = min_t(int, avail / 2, tx_nr_rings_per_tc);
+	mpc_tce = min_t(int, mpc_tce, BNXT_DFLT_MPC_TCE);
+
+	avail = hw_resc->max_cp_rings - tx_nr_rings - rx_nr_rings;
+
+	if (avail < BNXT_MIN_MPC_TCE || avail < BNXT_MIN_MPC_RCE)
+		return;
+
+	mpc_tce = min(mpc_tce, avail);
+
+	/* TCE and RCE are sized equally, so the per-type count is also the
+	 * MPC CP ring count (max(mpc_tce, mpc_rce)).
+	 */
+	*mpc_per_type = mpc_tce;
+	*mpc_cp = mpc_tce;
+}
+
+void bnxt_set_dflt_mpc_rings(struct bnxt *bp)
+{
+	struct bnxt_mpc_info *mpc = bp->mpc_info;
+	int per_type, mpc_cp, i;
+
+	if (!BNXT_MPC_CRYPTO_CAPABLE(bp))
+		return;
+
+	bnxt_calc_dflt_mpc_rings(bp, bp->tx_nr_rings, bp->tx_nr_rings_per_tc,
+				 bp->rx_nr_rings, &per_type, &mpc_cp);
+
+	for (i = 0; i < BNXT_MPC_TYPE_MAX; i++)
+		mpc->mpc_ring_count[i] = per_type;
+	mpc->mpc_cp_rings = mpc_cp;
+}
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_mpc.h b/drivers/net/ethernet/broadcom/bnxt/bnxt_mpc.h
index 7a7d81197ea6..6d50ca8c45ab 100644
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
@@ -37,6 +42,11 @@ void bnxt_alloc_mpc_info(struct bnxt *bp, u8 mpc_chnls_cap);
 void bnxt_free_mpc_info(struct bnxt *bp);
 int bnxt_mpc_tx_rings_in_use(struct bnxt *bp);
 int bnxt_mpc_cp_rings_in_use(struct bnxt *bp);
+void bnxt_trim_mpc_rings(struct bnxt *bp);
+void bnxt_calc_dflt_mpc_rings(struct bnxt *bp, int tx_nr_rings,
+			      int tx_nr_rings_per_tc, int rx_nr_rings,
+			      int *mpc_per_type, int *mpc_cp);
+void bnxt_set_dflt_mpc_rings(struct bnxt *bp);
 #else
 static inline void bnxt_alloc_mpc_info(struct bnxt *bp, u8 mpc_chnls_cap)
 {
@@ -55,5 +65,22 @@ static inline int bnxt_mpc_cp_rings_in_use(struct bnxt *bp)
 {
 	return 0;
 }
+
+static inline void bnxt_trim_mpc_rings(struct bnxt *bp)
+{
+}
+
+static inline void bnxt_calc_dflt_mpc_rings(struct bnxt *bp, int tx_nr_rings,
+					    int tx_nr_rings_per_tc,
+					    int rx_nr_rings, int *mpc_per_type,
+					    int *mpc_cp)
+{
+	*mpc_per_type = 0;
+	*mpc_cp = 0;
+}
+
+static inline void bnxt_set_dflt_mpc_rings(struct bnxt *bp)
+{
+}
 #endif	/* CONFIG_BNXT_TLS */
 #endif	/* BNXT_MPC_H */
-- 
2.51.0


