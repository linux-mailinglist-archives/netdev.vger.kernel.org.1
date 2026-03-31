Return-Path: <netdev+bounces-273482-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sElHBTpvy2k3HwYAu9opvQ
	(envelope-from <netdev+bounces-273482-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 08:52:42 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FD96364A40
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 08:52:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 36FAE3049701
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 06:52:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF8D9383C8B;
	Tue, 31 Mar 2026 06:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Ff6eDpf7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f97.google.com (mail-ot1-f97.google.com [209.85.210.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 364B03A9639
	for <netdev@vger.kernel.org>; Tue, 31 Mar 2026 06:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774939932; cv=none; b=DH70u1qpGQdijjFEyJef+pzcabHhC54gTn7qg2N2Hi84CU0mQY5pM5BdKpsB6FU0QoKKJlyrKjJgTfIF/CbgBpcCm6C9m2hfNsCEAZtrc9/dtWigSwxDvFcR3pO00on/XIVve5ofFqDip2kBCwljfKL8qm7S3PIQK2o4EBDeMBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774939932; c=relaxed/simple;
	bh=rNyAJLUFX5mES4h8Xff3WDzIn2fXOHVvAsbj5PBXBnA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lm0I3FAZTJiCxOye6yh1mNg8jkg0LQOvdIiNN7yoEKDaK+Dsgd9FFqHjpV/3JoQQupvBDgUD6BpV0RVNr0tqeDwT/iVbW40VtXSYBEenD20CgX6P5NA3m7HpcH/prexVvQHU6C7+k2F4dVXdvVslX1NfegLKWzyIJBSvQJvwTgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Ff6eDpf7; arc=none smtp.client-ip=209.85.210.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-ot1-f97.google.com with SMTP id 46e09a7af769-7d7653db148so2896108a34.2
        for <netdev@vger.kernel.org>; Mon, 30 Mar 2026 23:52:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774939930; x=1775544730;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xtgzHvFmMRW5uRsMU6k0lGujq7JV/bUvlrr92D6oH6A=;
        b=OvBlSKP9K2YkFtPx/wxHcr2k1Yxx8cBZPD7qc1a72VZ3Z9rLyUYGyRwmXSmVfAVEXU
         T0aGD9bCKdSrv9d6R4Veu/KVrxvN30Y6z2RqUvBo3jH0UiYLyV5HoJ0d/9WxO0ztpj4B
         Hzo8PMuhLQOcGVKxSXlQ05YfXyI3r+WxoVVf4tDXpwbCDo2PDYPhnhL6s6PkPYnRwWX1
         UfLLQeeAgL8PVrshEN02ljg8Aao+kAj+sjkTNFssonVyZA5tEB6kK9Uv1yKBbe9mNkKx
         oL0janKLCoHdLo8B74BsYDTiImqOHr0cJjoLwFERgws9Mt/BNX8lwpR5kYT+DYeimQvf
         l5mw==
X-Gm-Message-State: AOJu0Yyh+8tudKUmuugJ7dH+k4yBxktJZcYjMk/wg00uCrFpwg9e7aJN
	PMm0Q/T64qG45sMzjFjj5ml7bn/NHX7tTs5ar7N9B74vkiyZMn3JFIwir3Vl+AIz/UkMhqBzx43
	qdPsgdwFY+Sv2wJ0+8DlRJWxg/K+uyzGQIJARMGQHCrMiPjzC68EdDdL8EaMDTFb6qqMav2HF+j
	Uw9xP+Uu+N5VPEQbf7niwMXqTXqDnfzoVYWwKQs+p6XN1vLJv7rxLbJlaxGPEzaIw3ETY/Wb7aL
	8KpdaxuRSM=
X-Gm-Gg: ATEYQzyLfhQSZllUsYrLvcdG+dOShmK15oZhHbnBj/55u1qCtrDinLQINqHJKWHaRl3
	bCguFLPDrzhPOV3+QJeD3HqY96vD8PW03MacO+CYfO7+U6Y9pMCrWEnJSPktvGQFtNMHdwTW2lO
	uusMczM8sRMvvJPCKAHJvCQmGhjRnlqxWnT6lptmMVY6k+ySbAlv5MWXZz/p5LRgGxCNQis//qr
	w3bYtn0/dyeZbSuYD/lIwunldksFGUGOMBg8dRgJ5QZjD1RkLRtWcQBlN4W998ncm9YEy3GVRS/
	ekXeqcMnZFgz6OFukePms3Q4B71Kxw8gy0UHbmXMqreEs+Lk7FgtXf4lj12AEAyA90Gto5ZDT8C
	KaMPxoZEc5+ngMEUPfKI+rmPl0G1aoUeb8TL7npIXlc276PUBjFHUCBL+owbbPU5x8CxCW8iVdc
	wiunqe
X-Received: by 2002:a05:6830:43ab:b0:7d7:ef00:2909 with SMTP id 46e09a7af769-7d9fae274ffmr9146006a34.13.1774939930046;
        Mon, 30 Mar 2026 23:52:10 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com ([144.49.247.127])
        by smtp-relay.gmail.com with ESMTPS id 46e09a7af769-7da0a34c069sm2055571a34.1.2026.03.30.23.52.08
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 30 Mar 2026 23:52:10 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-8a1accb970fso42706446d6.3
        for <netdev@vger.kernel.org>; Mon, 30 Mar 2026 23:52:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1774939928; x=1775544728; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xtgzHvFmMRW5uRsMU6k0lGujq7JV/bUvlrr92D6oH6A=;
        b=Ff6eDpf7KJe8YBOlCqOvce7YKNxMbKmjdrjWUTmdnnipvsPzmghDdJ9VbZ1LKwRU/B
         xzc6OwdaVWlrG0KcycLfQTGA0alrwuT46muQSUskCHCBk2VDbaYG2dVAikPLV4v6ABQl
         7j0Ionj57DnRrK0dm+I50/qPRANM08pBiEj3c=
X-Received: by 2002:a05:6214:6116:b0:8a0:d5be:23f5 with SMTP id 6a1803df08f44-8a0d5be2966mr86469296d6.48.1774939927896;
        Mon, 30 Mar 2026 23:52:07 -0700 (PDT)
X-Received: by 2002:a05:6214:6116:b0:8a0:d5be:23f5 with SMTP id 6a1803df08f44-8a0d5be2966mr86469186d6.48.1774939927412;
        Mon, 30 Mar 2026 23:52:07 -0700 (PDT)
Received: from lvnvda3289.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-89ecbda4d50sm80543966d6.15.2026.03.30.23.52.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2026 23:52:06 -0700 (PDT)
From: Michael Chan <michael.chan@broadcom.com>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	pavan.chebbi@broadcom.com,
	andrew.gospodarek@broadcom.com,
	Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Subject: [PATCH net v2 1/3] bnxt_en: Refactor some basic ring setup and adjustment logic
Date: Mon, 30 Mar 2026 23:51:36 -0700
Message-ID: <20260331065138.948205-2-michael.chan@broadcom.com>
X-Mailer: git-send-email 2.45.4
In-Reply-To: <20260331065138.948205-1-michael.chan@broadcom.com>
References: <20260331065138.948205-1-michael.chan@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[michael.chan@broadcom.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-273482-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,broadcom.com:dkim,broadcom.com:email,broadcom.com:mid];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[broadcom.com:+];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 6FD96364A40
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Refactor out the basic code that trims the default rings, sets up and
adjusts XDP TX rings and CP rings.  There is no change in behavior.
This is to prepare for the next bug fix patch.

Reviewed-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Reviewed-by: Pavan Chebbi <pavan.chebbi@broadcom.com>
Reviewed-by: Andy Gospodarek <andrew.gospodarek@broadcom.com>
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c     | 53 +++++++++++++------
 drivers/net/ethernet/broadcom/bnxt/bnxt.h     |  1 +
 .../net/ethernet/broadcom/bnxt/bnxt_ethtool.c |  5 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c |  5 +-
 4 files changed, 41 insertions(+), 23 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 7ed805713fbb..173f962fc2ab 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -12992,6 +12992,21 @@ static int bnxt_tx_nr_rings_per_tc(struct bnxt *bp)
 	return bp->num_tc ? bp->tx_nr_rings / bp->num_tc : bp->tx_nr_rings;
 }
 
+static void bnxt_set_xdp_tx_rings(struct bnxt *bp)
+{
+	bp->tx_nr_rings_xdp = bp->tx_nr_rings_per_tc;
+	bp->tx_nr_rings += bp->tx_nr_rings_xdp;
+}
+
+static void bnxt_adj_tx_rings(struct bnxt *bp)
+{
+	/* Make adjustments if reserved TX rings are less than requested */
+	bp->tx_nr_rings -= bp->tx_nr_rings_xdp;
+	bp->tx_nr_rings_per_tc = bnxt_tx_nr_rings_per_tc(bp);
+	if (bp->tx_nr_rings_xdp)
+		bnxt_set_xdp_tx_rings(bp);
+}
+
 static int __bnxt_open_nic(struct bnxt *bp, bool irq_re_init, bool link_re_init)
 {
 	int rc = 0;
@@ -13009,13 +13024,7 @@ static int __bnxt_open_nic(struct bnxt *bp, bool irq_re_init, bool link_re_init)
 	if (rc)
 		return rc;
 
-	/* Make adjustments if reserved TX rings are less than requested */
-	bp->tx_nr_rings -= bp->tx_nr_rings_xdp;
-	bp->tx_nr_rings_per_tc = bnxt_tx_nr_rings_per_tc(bp);
-	if (bp->tx_nr_rings_xdp) {
-		bp->tx_nr_rings_xdp = bp->tx_nr_rings_per_tc;
-		bp->tx_nr_rings += bp->tx_nr_rings_xdp;
-	}
+	bnxt_adj_tx_rings(bp);
 	rc = bnxt_alloc_mem(bp, irq_re_init);
 	if (rc) {
 		netdev_err(bp->dev, "bnxt_alloc_mem err: %x\n", rc);
@@ -15436,11 +15445,19 @@ static int bnxt_change_mtu(struct net_device *dev, int new_mtu)
 	return 0;
 }
 
+void bnxt_set_cp_rings(struct bnxt *bp, bool sh)
+{
+	int tx_cp = bnxt_num_tx_to_cp(bp, bp->tx_nr_rings);
+
+	bp->cp_nr_rings = sh ? max_t(int, tx_cp, bp->rx_nr_rings) :
+			       tx_cp + bp->rx_nr_rings;
+}
+
 int bnxt_setup_mq_tc(struct net_device *dev, u8 tc)
 {
 	struct bnxt *bp = netdev_priv(dev);
 	bool sh = false;
-	int rc, tx_cp;
+	int rc;
 
 	if (tc > bp->max_tc) {
 		netdev_err(dev, "Too many traffic classes requested: %d. Max supported is %d.\n",
@@ -15473,9 +15490,7 @@ int bnxt_setup_mq_tc(struct net_device *dev, u8 tc)
 		bp->num_tc = 0;
 	}
 	bp->tx_nr_rings += bp->tx_nr_rings_xdp;
-	tx_cp = bnxt_num_tx_to_cp(bp, bp->tx_nr_rings);
-	bp->cp_nr_rings = sh ? max_t(int, tx_cp, bp->rx_nr_rings) :
-			       tx_cp + bp->rx_nr_rings;
+	bnxt_set_cp_rings(bp, sh);
 
 	if (netif_running(bp->dev))
 		return bnxt_open_nic(bp, true, false);
@@ -16525,6 +16540,15 @@ static void bnxt_trim_dflt_sh_rings(struct bnxt *bp)
 	bp->tx_nr_rings = bnxt_tx_nr_rings(bp);
 }
 
+static void bnxt_adj_dflt_rings(struct bnxt *bp, bool sh)
+{
+	if (sh)
+		bnxt_trim_dflt_sh_rings(bp);
+	else
+		bp->cp_nr_rings = bp->tx_nr_rings_per_tc + bp->rx_nr_rings;
+	bp->tx_nr_rings = bnxt_tx_nr_rings(bp);
+}
+
 static int bnxt_set_dflt_rings(struct bnxt *bp, bool sh)
 {
 	int dflt_rings, max_rx_rings, max_tx_rings, rc;
@@ -16550,11 +16574,8 @@ static int bnxt_set_dflt_rings(struct bnxt *bp, bool sh)
 		return rc;
 	bp->rx_nr_rings = min_t(int, dflt_rings, max_rx_rings);
 	bp->tx_nr_rings_per_tc = min_t(int, dflt_rings, max_tx_rings);
-	if (sh)
-		bnxt_trim_dflt_sh_rings(bp);
-	else
-		bp->cp_nr_rings = bp->tx_nr_rings_per_tc + bp->rx_nr_rings;
-	bp->tx_nr_rings = bnxt_tx_nr_rings(bp);
+
+	bnxt_adj_dflt_rings(bp, sh);
 
 	avail_msix = bnxt_get_max_func_irqs(bp) - bp->cp_nr_rings;
 	if (avail_msix >= BNXT_MIN_ROCE_CP_RINGS) {
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.h b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
index a97d651130df..4bc7f7aeaab3 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
@@ -2985,6 +2985,7 @@ int bnxt_check_rings(struct bnxt *bp, int tx, int rx, bool sh, int tcs,
 		     int tx_xdp);
 int bnxt_fw_init_one(struct bnxt *bp);
 bool bnxt_hwrm_reset_permitted(struct bnxt *bp);
+void bnxt_set_cp_rings(struct bnxt *bp, bool sh);
 int bnxt_setup_mq_tc(struct net_device *dev, u8 tc);
 struct bnxt_ntuple_filter *bnxt_lookup_ntp_filter_from_idx(struct bnxt *bp,
 				struct bnxt_ntuple_filter *fltr, u32 idx);
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
index 28d0ece2e7b1..0407aa1b3190 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
@@ -945,7 +945,6 @@ static int bnxt_set_channels(struct net_device *dev,
 	bool sh = false;
 	int tx_xdp = 0;
 	int rc = 0;
-	int tx_cp;
 
 	if (channel->other_count)
 		return -EINVAL;
@@ -1013,9 +1012,7 @@ static int bnxt_set_channels(struct net_device *dev,
 	if (tcs > 1)
 		bp->tx_nr_rings = bp->tx_nr_rings_per_tc * tcs + tx_xdp;
 
-	tx_cp = bnxt_num_tx_to_cp(bp, bp->tx_nr_rings);
-	bp->cp_nr_rings = sh ? max_t(int, tx_cp, bp->rx_nr_rings) :
-			       tx_cp + bp->rx_nr_rings;
+	bnxt_set_cp_rings(bp, sh);
 
 	/* After changing number of rx channels, update NTUPLE feature. */
 	netdev_update_features(dev);
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c
index 85cbeb35681c..bebe37e139c9 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c
@@ -384,7 +384,7 @@ int bnxt_xdp_xmit(struct net_device *dev, int num_frames,
 static int bnxt_xdp_set(struct bnxt *bp, struct bpf_prog *prog)
 {
 	struct net_device *dev = bp->dev;
-	int tx_xdp = 0, tx_cp, rc, tc;
+	int tx_xdp = 0, rc, tc;
 	struct bpf_prog *old;
 
 	netdev_assert_locked(dev);
@@ -431,8 +431,7 @@ static int bnxt_xdp_set(struct bnxt *bp, struct bpf_prog *prog)
 	}
 	bp->tx_nr_rings_xdp = tx_xdp;
 	bp->tx_nr_rings = bp->tx_nr_rings_per_tc * tc + tx_xdp;
-	tx_cp = bnxt_num_tx_to_cp(bp, bp->tx_nr_rings);
-	bp->cp_nr_rings = max_t(int, tx_cp, bp->rx_nr_rings);
+	bnxt_set_cp_rings(bp, true);
 	bnxt_set_tpa_flags(bp);
 	bnxt_set_ring_params(bp);
 
-- 
2.51.0


