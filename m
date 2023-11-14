Return-Path: <netdev+bounces-47565-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E69147EA762
	for <lists+netdev@lfdr.de>; Tue, 14 Nov 2023 01:17:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4CCDAB20A69
	for <lists+netdev@lfdr.de>; Tue, 14 Nov 2023 00:17:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4994B1385;
	Tue, 14 Nov 2023 00:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="BmBQuolh"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57A855241
	for <netdev@vger.kernel.org>; Tue, 14 Nov 2023 00:17:09 +0000 (UTC)
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43311D53
	for <netdev@vger.kernel.org>; Mon, 13 Nov 2023 16:17:07 -0800 (PST)
Received: by mail-pg1-x52a.google.com with SMTP id 41be03b00d2f7-5b99bfca064so3256814a12.3
        for <netdev@vger.kernel.org>; Mon, 13 Nov 2023 16:17:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1699921027; x=1700525827; darn=vger.kernel.org;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=M2VRyMKxJX8fyyFmdZwQji2gc9ZTNEkEM8Hw38TPtaE=;
        b=BmBQuolhAE8mutKfAa9vT6XfXcEDZ+SLn46oT0RpPw4cBVNfOEVlTKJX/Bt4TB64s5
         dKc9yJ4cfALnDPPxcxDXhLlTxZgcYHbL4AgupGMc9S3IOZ15CMGtPOa/yUUre5+TZbOX
         cUivvrwcR2PzkphBfmGEug8fq6/+78bm+Pb4s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699921027; x=1700525827;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=M2VRyMKxJX8fyyFmdZwQji2gc9ZTNEkEM8Hw38TPtaE=;
        b=PPU4wljtAo290q9llDAuwdQs0vOYrP6C+zjFAMTiv8y1vH7TU6RA8bdrFNmE6Cv7vK
         bOceOD0lSOKY49h2zn/sYgFzYJ7QNvf6taWRNexMxLcOKG5VYLYZsrWWYDB+TuV7Cm2w
         lt0ysDI81DsLlm6gw7uBIclFUwCHlgJUs/Q/MY4VfyR7vccoCMVXJsTM4GCa/y0sPRdM
         PPDqWh6R+a9jvCivOCYajIRWdWG0Uc/ovx8r1yBO23RkSebiXC0kIr0EJoKIL2H/pgUT
         oKUecQ2zb7sXUluZx5L/2kXMON0mu+5BPFIO06V6uhNmoLrq6bVXlQogUeXe/hFbJK21
         GslA==
X-Gm-Message-State: AOJu0YwdNaxse+smPWgX7RtRvmVVP+lb97sFDK+qcgW5lePGXxFsJmrA
	ZJMA9+FXp7ms88mUBGLusSBcXg==
X-Google-Smtp-Source: AGHT+IH1NE5EkGvT0ye44IWdRsC5N8u33tqNKWOM9p7YUDF7XIZBSbUaIUZWQfO9Y+On4q0myOZ5jw==
X-Received: by 2002:a05:6a20:54a7:b0:17e:2afd:408a with SMTP id i39-20020a056a2054a700b0017e2afd408amr7478626pzk.5.1699921026220;
        Mon, 13 Nov 2023 16:17:06 -0800 (PST)
Received: from lvnvda5233.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id p6-20020a17090a680600b0027ffff956bcsm4063478pjj.47.2023.11.13.16.17.04
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 Nov 2023 16:17:05 -0800 (PST)
From: Michael Chan <michael.chan@broadcom.com>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	gospo@broadcom.com,
	Andy Gospodarek <andrew.gospodarek@broadcom.com>
Subject: [PATCH net-next v2 10/13] bnxt_en: Add helper to get the number of CP rings required for TX rings
Date: Mon, 13 Nov 2023 16:16:18 -0800
Message-Id: <20231114001621.101284-11-michael.chan@broadcom.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20231114001621.101284-1-michael.chan@broadcom.com>
References: <20231114001621.101284-1-michael.chan@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000f68008060a11b4f8"

--000000000000f68008060a11b4f8
Content-Transfer-Encoding: 8bit

Up until now, each TX ring always requires a completion ring/NQ/MSIX.
bnxt_trim_rings() and the assignment of bp->cp_nr_rings always make
this assumption.  This will no longer be true in the next patches, so
we refactor and add helper functions to determine the proper relationship
between TX rings and the required completion ring/NQ/MSIX.  This patch
does not change the 1:1 relationship yet.

Note that on P5 chips, each RX and TX ring still requires a completion
ring.  Only the number of NQs has been reduced.  We should no longer call
bnxt_trim_rings() to adjust the RX and TX rings on P5 chips.  Replace with
simple logic to check that RX + TX < CP and adjust accordingly.

bnxt_check_rings() should call _bnxt_get_max_rings() to get the raw
number of rings instead of bnxt_get_max_rings().  If we are about to
create TCs, bnxt_get_max_rings() would not be able to calculate the max
rings correctly.

Reviewed-by: Andy Gospodarek <andrew.gospodarek@broadcom.com>
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c     | 95 +++++++++++++++----
 drivers/net/ethernet/broadcom/bnxt/bnxt.h     |  1 +
 .../net/ethernet/broadcom/bnxt/bnxt_ethtool.c |  6 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c |  5 +-
 4 files changed, 82 insertions(+), 25 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 6002b834e898..7c1a3db651f5 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -6284,7 +6284,8 @@ static int bnxt_hwrm_get_rings(struct bnxt *bp)
 			if (bp->flags & BNXT_FLAG_AGG_RINGS)
 				rx >>= 1;
 			if (cp < (rx + tx)) {
-				bnxt_trim_rings(bp, &rx, &tx, cp, false);
+				rx = cp / 2;
+				tx = rx;
 				if (bp->flags & BNXT_FLAG_AGG_RINGS)
 					rx <<= 1;
 				hw_resc->resv_rx_rings = rx;
@@ -6585,6 +6586,7 @@ static int __bnxt_reserve_rings(struct bnxt *bp)
 	int grp, rx_rings, rc;
 	int vnic = 1, stat;
 	bool sh = false;
+	int tx_cp;
 
 	if (!bnxt_need_reserve_rings(bp))
 		return 0;
@@ -6634,7 +6636,8 @@ static int __bnxt_reserve_rings(struct bnxt *bp)
 	rc = bnxt_trim_rings(bp, &rx_rings, &tx, cp, sh);
 	if (bp->flags & BNXT_FLAG_AGG_RINGS)
 		rx = rx_rings << 1;
-	cp = sh ? max_t(int, tx, rx_rings) : tx + rx_rings;
+	tx_cp = bnxt_num_tx_to_cp(bp, tx);
+	cp = sh ? max_t(int, tx_cp, rx_rings) : tx_cp + rx_rings;
 	bp->tx_nr_rings = tx;
 
 	/* If we cannot reserve all the RX rings, reset the RSS map only
@@ -9061,8 +9064,8 @@ static int bnxt_set_real_num_queues(struct bnxt *bp)
 	return rc;
 }
 
-static int bnxt_trim_rings(struct bnxt *bp, int *rx, int *tx, int max,
-			   bool shared)
+static int __bnxt_trim_rings(struct bnxt *bp, int *rx, int *tx, int max,
+			     bool shared)
 {
 	int _rx = *rx, _tx = *tx;
 
@@ -9085,6 +9088,46 @@ static int bnxt_trim_rings(struct bnxt *bp, int *rx, int *tx, int max,
 	return 0;
 }
 
+static int __bnxt_num_tx_to_cp(struct bnxt *bp, int tx, int tx_sets, int tx_xdp)
+{
+	return tx;
+}
+
+int bnxt_num_tx_to_cp(struct bnxt *bp, int tx)
+{
+	int tcs = netdev_get_num_tc(bp->dev);
+
+	if (!tcs)
+		tcs = 1;
+	return __bnxt_num_tx_to_cp(bp, tx, tcs, bp->tx_nr_rings_xdp);
+}
+
+static int bnxt_num_cp_to_tx(struct bnxt *bp, int tx_cp)
+{
+	int tcs = netdev_get_num_tc(bp->dev);
+
+	return (tx_cp - bp->tx_nr_rings_xdp) * tcs +
+	       bp->tx_nr_rings_xdp;
+}
+
+static int bnxt_trim_rings(struct bnxt *bp, int *rx, int *tx, int max,
+			   bool sh)
+{
+	int tx_cp = bnxt_num_tx_to_cp(bp, *tx);
+
+	if (tx_cp != *tx) {
+		int tx_saved = tx_cp, rc;
+
+		rc = __bnxt_trim_rings(bp, rx, &tx_cp, max, sh);
+		if (rc)
+			return rc;
+		if (tx_cp != tx_saved)
+			*tx = bnxt_num_cp_to_tx(bp, tx_cp);
+		return 0;
+	}
+	return __bnxt_trim_rings(bp, rx, tx, max, sh);
+}
+
 static void bnxt_setup_msix(struct bnxt *bp)
 {
 	const int len = sizeof(bp->irq_tbl[0].name);
@@ -9247,7 +9290,7 @@ static int bnxt_get_num_msix(struct bnxt *bp)
 
 static int bnxt_init_msix(struct bnxt *bp)
 {
-	int i, total_vecs, max, rc = 0, min = 1, ulp_msix;
+	int i, total_vecs, max, rc = 0, min = 1, ulp_msix, tx_cp;
 	struct msix_entry *msix_ent;
 
 	total_vecs = bnxt_get_num_msix(bp);
@@ -9289,9 +9332,10 @@ static int bnxt_init_msix(struct bnxt *bp)
 		if (rc)
 			goto msix_setup_exit;
 
+		tx_cp = bnxt_num_tx_to_cp(bp, bp->tx_nr_rings);
 		bp->cp_nr_rings = (min == 1) ?
-				  max_t(int, bp->tx_nr_rings, bp->rx_nr_rings) :
-				  bp->tx_nr_rings + bp->rx_nr_rings;
+				  max_t(int, tx_cp, bp->rx_nr_rings) :
+				  tx_cp + bp->rx_nr_rings;
 
 	} else {
 		rc = -ENOMEM;
@@ -12186,23 +12230,27 @@ static void bnxt_sp_task(struct work_struct *work)
 	clear_bit(BNXT_STATE_IN_SP_TASK, &bp->state);
 }
 
+static void _bnxt_get_max_rings(struct bnxt *bp, int *max_rx, int *max_tx,
+				int *max_cp);
+
 /* Under rtnl_lock */
 int bnxt_check_rings(struct bnxt *bp, int tx, int rx, bool sh, int tcs,
 		     int tx_xdp)
 {
-	int max_rx, max_tx, tx_sets = 1;
+	int max_rx, max_tx, max_cp, tx_sets = 1, tx_cp;
 	int tx_rings_needed, stats;
 	int rx_rings = rx;
-	int cp, vnics, rc;
+	int cp, vnics;
 
 	if (tcs)
 		tx_sets = tcs;
 
-	rc = bnxt_get_max_rings(bp, &max_rx, &max_tx, sh);
-	if (rc)
-		return rc;
+	if (bp->flags & BNXT_FLAG_AGG_RINGS)
+		rx_rings <<= 1;
 
-	if (max_rx < rx)
+	_bnxt_get_max_rings(bp, &max_rx, &max_tx, &max_cp);
+
+	if (max_rx < rx_rings)
 		return -ENOMEM;
 
 	tx_rings_needed = tx * tx_sets + tx_xdp;
@@ -12211,11 +12259,12 @@ int bnxt_check_rings(struct bnxt *bp, int tx, int rx, bool sh, int tcs,
 
 	vnics = 1;
 	if ((bp->flags & (BNXT_FLAG_RFS | BNXT_FLAG_CHIP_P5)) == BNXT_FLAG_RFS)
-		vnics += rx_rings;
+		vnics += rx;
 
-	if (bp->flags & BNXT_FLAG_AGG_RINGS)
-		rx_rings <<= 1;
-	cp = sh ? max_t(int, tx_rings_needed, rx) : tx_rings_needed + rx;
+	tx_cp = __bnxt_num_tx_to_cp(bp, tx_rings_needed, tx_sets, tx_xdp);
+	cp = sh ? max_t(int, tx_cp, rx) : tx_cp + rx;
+	if (max_cp < cp)
+		return -ENOMEM;
 	stats = cp;
 	if (BNXT_NEW_RM(bp)) {
 		cp += bnxt_get_ulp_msix_num(bp);
@@ -12849,7 +12898,7 @@ int bnxt_setup_mq_tc(struct net_device *dev, u8 tc)
 {
 	struct bnxt *bp = netdev_priv(dev);
 	bool sh = false;
-	int rc;
+	int rc, tx_cp;
 
 	if (tc > bp->max_tc) {
 		netdev_err(dev, "Too many traffic classes requested: %d. Max supported is %d.\n",
@@ -12880,8 +12929,9 @@ int bnxt_setup_mq_tc(struct net_device *dev, u8 tc)
 		netdev_reset_tc(dev);
 	}
 	bp->tx_nr_rings += bp->tx_nr_rings_xdp;
-	bp->cp_nr_rings = sh ? max_t(int, bp->tx_nr_rings, bp->rx_nr_rings) :
-			       bp->tx_nr_rings + bp->rx_nr_rings;
+	tx_cp = bnxt_num_tx_to_cp(bp, bp->tx_nr_rings);
+	bp->cp_nr_rings = sh ? max_t(int, tx_cp, bp->rx_nr_rings) :
+			       tx_cp + bp->rx_nr_rings;
 
 	if (netif_running(bp->dev))
 		return bnxt_open_nic(bp, true, false);
@@ -13360,7 +13410,10 @@ static void _bnxt_get_max_rings(struct bnxt *bp, int *max_rx, int *max_tx,
 	if (bp->flags & BNXT_FLAG_AGG_RINGS)
 		*max_rx >>= 1;
 	if (bp->flags & BNXT_FLAG_CHIP_P5) {
-		bnxt_trim_rings(bp, max_rx, max_tx, *max_cp, false);
+		if (*max_cp < (*max_rx + *max_tx)) {
+			*max_rx = *max_cp / 2;
+			*max_tx = *max_rx;
+		}
 		/* On P5 chips, max_cp output param should be available NQs */
 		*max_cp = max_irq;
 	}
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.h b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
index 2028233c0561..4ce993943924 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
@@ -2393,6 +2393,7 @@ int __bnxt_hwrm_get_tx_rings(struct bnxt *bp, u16 fid, int *tx_rings);
 int bnxt_nq_rings_in_use(struct bnxt *bp);
 int bnxt_hwrm_set_coal(struct bnxt *);
 void bnxt_free_ctx_mem(struct bnxt *bp);
+int bnxt_num_tx_to_cp(struct bnxt *bp, int tx);
 unsigned int bnxt_get_max_func_stat_ctxs(struct bnxt *bp);
 unsigned int bnxt_get_avail_stat_ctxs_for_en(struct bnxt *bp);
 unsigned int bnxt_get_max_func_cp_rings(struct bnxt *bp);
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
index 18c06158fead..76f2eab52ce7 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
@@ -923,6 +923,7 @@ static int bnxt_set_channels(struct net_device *dev,
 	bool sh = false;
 	int tx_xdp = 0;
 	int rc = 0;
+	int tx_cp;
 
 	if (channel->other_count)
 		return -EINVAL;
@@ -994,8 +995,9 @@ static int bnxt_set_channels(struct net_device *dev,
 	if (tcs > 1)
 		bp->tx_nr_rings = bp->tx_nr_rings_per_tc * tcs + tx_xdp;
 
-	bp->cp_nr_rings = sh ? max_t(int, bp->tx_nr_rings, bp->rx_nr_rings) :
-			       bp->tx_nr_rings + bp->rx_nr_rings;
+	tx_cp = bnxt_num_tx_to_cp(bp, bp->tx_nr_rings);
+	bp->cp_nr_rings = sh ? max_t(int, tx_cp, bp->rx_nr_rings) :
+			       tx_cp + bp->rx_nr_rings;
 
 	/* After changing number of rx channels, update NTUPLE feature. */
 	netdev_update_features(dev);
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c
index 52b75108e130..9d428eb3fdb9 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c
@@ -398,7 +398,7 @@ int bnxt_xdp_xmit(struct net_device *dev, int num_frames,
 static int bnxt_xdp_set(struct bnxt *bp, struct bpf_prog *prog)
 {
 	struct net_device *dev = bp->dev;
-	int tx_xdp = 0, rc, tc;
+	int tx_xdp = 0, tx_cp, rc, tc;
 	struct bpf_prog *old;
 
 	if (prog && !prog->aux->xdp_has_frags &&
@@ -446,7 +446,8 @@ static int bnxt_xdp_set(struct bnxt *bp, struct bpf_prog *prog)
 	}
 	bp->tx_nr_rings_xdp = tx_xdp;
 	bp->tx_nr_rings = bp->tx_nr_rings_per_tc * tc + tx_xdp;
-	bp->cp_nr_rings = max_t(int, bp->tx_nr_rings, bp->rx_nr_rings);
+	tx_cp = bnxt_num_tx_to_cp(bp, bp->tx_nr_rings);
+	bp->cp_nr_rings = max_t(int, tx_cp, bp->rx_nr_rings);
 	bnxt_set_tpa_flags(bp);
 	bnxt_set_ring_params(bp);
 
-- 
2.30.1


--000000000000f68008060a11b4f8
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIIQbQYJKoZIhvcNAQcCoIIQXjCCEFoCAQExDzANBglghkgBZQMEAgEFADALBgkqhkiG9w0BBwGg
gg3EMIIFDTCCA/WgAwIBAgIQeEqpED+lv77edQixNJMdADANBgkqhkiG9w0BAQsFADBMMSAwHgYD
VQQLExdHbG9iYWxTaWduIFJvb3QgQ0EgLSBSMzETMBEGA1UEChMKR2xvYmFsU2lnbjETMBEGA1UE
AxMKR2xvYmFsU2lnbjAeFw0yMDA5MTYwMDAwMDBaFw0yODA5MTYwMDAwMDBaMFsxCzAJBgNVBAYT
AkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMTEwLwYDVQQDEyhHbG9iYWxTaWduIEdDQyBS
MyBQZXJzb25hbFNpZ24gMiBDQSAyMDIwMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEA
vbCmXCcsbZ/a0fRIQMBxp4gJnnyeneFYpEtNydrZZ+GeKSMdHiDgXD1UnRSIudKo+moQ6YlCOu4t
rVWO/EiXfYnK7zeop26ry1RpKtogB7/O115zultAz64ydQYLe+a1e/czkALg3sgTcOOcFZTXk38e
aqsXsipoX1vsNurqPtnC27TWsA7pk4uKXscFjkeUE8JZu9BDKaswZygxBOPBQBwrA5+20Wxlk6k1
e6EKaaNaNZUy30q3ArEf30ZDpXyfCtiXnupjSK8WU2cK4qsEtj09JS4+mhi0CTCrCnXAzum3tgcH
cHRg0prcSzzEUDQWoFxyuqwiwhHu3sPQNmFOMwIDAQABo4IB2jCCAdYwDgYDVR0PAQH/BAQDAgGG
MGAGA1UdJQRZMFcGCCsGAQUFBwMCBggrBgEFBQcDBAYKKwYBBAGCNxQCAgYKKwYBBAGCNwoDBAYJ
KwYBBAGCNxUGBgorBgEEAYI3CgMMBggrBgEFBQcDBwYIKwYBBQUHAxEwEgYDVR0TAQH/BAgwBgEB
/wIBADAdBgNVHQ4EFgQUljPR5lgXWzR1ioFWZNW+SN6hj88wHwYDVR0jBBgwFoAUj/BLf6guRSSu
TVD6Y5qL3uLdG7wwegYIKwYBBQUHAQEEbjBsMC0GCCsGAQUFBzABhiFodHRwOi8vb2NzcC5nbG9i
YWxzaWduLmNvbS9yb290cjMwOwYIKwYBBQUHMAKGL2h0dHA6Ly9zZWN1cmUuZ2xvYmFsc2lnbi5j
b20vY2FjZXJ0L3Jvb3QtcjMuY3J0MDYGA1UdHwQvMC0wK6ApoCeGJWh0dHA6Ly9jcmwuZ2xvYmFs
c2lnbi5jb20vcm9vdC1yMy5jcmwwWgYDVR0gBFMwUTALBgkrBgEEAaAyASgwQgYKKwYBBAGgMgEo
CjA0MDIGCCsGAQUFBwIBFiZodHRwczovL3d3dy5nbG9iYWxzaWduLmNvbS9yZXBvc2l0b3J5LzAN
BgkqhkiG9w0BAQsFAAOCAQEAdAXk/XCnDeAOd9nNEUvWPxblOQ/5o/q6OIeTYvoEvUUi2qHUOtbf
jBGdTptFsXXe4RgjVF9b6DuizgYfy+cILmvi5hfk3Iq8MAZsgtW+A/otQsJvK2wRatLE61RbzkX8
9/OXEZ1zT7t/q2RiJqzpvV8NChxIj+P7WTtepPm9AIj0Keue+gS2qvzAZAY34ZZeRHgA7g5O4TPJ
/oTd+4rgiU++wLDlcZYd/slFkaT3xg4qWDepEMjT4T1qFOQIL+ijUArYS4owpPg9NISTKa1qqKWJ
jFoyms0d0GwOniIIbBvhI2MJ7BSY9MYtWVT5jJO3tsVHwj4cp92CSFuGwunFMzCCA18wggJHoAMC
AQICCwQAAAAAASFYUwiiMA0GCSqGSIb3DQEBCwUAMEwxIDAeBgNVBAsTF0dsb2JhbFNpZ24gUm9v
dCBDQSAtIFIzMRMwEQYDVQQKEwpHbG9iYWxTaWduMRMwEQYDVQQDEwpHbG9iYWxTaWduMB4XDTA5
MDMxODEwMDAwMFoXDTI5MDMxODEwMDAwMFowTDEgMB4GA1UECxMXR2xvYmFsU2lnbiBSb290IENB
IC0gUjMxEzARBgNVBAoTCkdsb2JhbFNpZ24xEzARBgNVBAMTCkdsb2JhbFNpZ24wggEiMA0GCSqG
SIb3DQEBAQUAA4IBDwAwggEKAoIBAQDMJXaQeQZ4Ihb1wIO2hMoonv0FdhHFrYhy/EYCQ8eyip0E
XyTLLkvhYIJG4VKrDIFHcGzdZNHr9SyjD4I9DCuul9e2FIYQebs7E4B3jAjhSdJqYi8fXvqWaN+J
J5U4nwbXPsnLJlkNc96wyOkmDoMVxu9bi9IEYMpJpij2aTv2y8gokeWdimFXN6x0FNx04Druci8u
nPvQu7/1PQDhBjPogiuuU6Y6FnOM3UEOIDrAtKeh6bJPkC4yYOlXy7kEkmho5TgmYHWyn3f/kRTv
riBJ/K1AFUjRAjFhGV64l++td7dkmnq/X8ET75ti+w1s4FRpFqkD2m7pg5NxdsZphYIXAgMBAAGj
QjBAMA4GA1UdDwEB/wQEAwIBBjAPBgNVHRMBAf8EBTADAQH/MB0GA1UdDgQWBBSP8Et/qC5FJK5N
UPpjmove4t0bvDANBgkqhkiG9w0BAQsFAAOCAQEAS0DbwFCq/sgM7/eWVEVJu5YACUGssxOGhigH
M8pr5nS5ugAtrqQK0/Xx8Q+Kv3NnSoPHRHt44K9ubG8DKY4zOUXDjuS5V2yq/BKW7FPGLeQkbLmU
Y/vcU2hnVj6DuM81IcPJaP7O2sJTqsyQiunwXUaMld16WCgaLx3ezQA3QY/tRG3XUyiXfvNnBB4V
14qWtNPeTCekTBtzc3b0F5nCH3oO4y0IrQocLP88q1UOD5F+NuvDV0m+4S4tfGCLw0FREyOdzvcy
a5QBqJnnLDMfOjsl0oZAzjsshnjJYS8Uuu7bVW/fhO4FCU29KNhyztNiUGUe65KXgzHZs7XKR1g/
XzCCBUwwggQ0oAMCAQICDF5AaMOe0cZvaJpCQjANBgkqhkiG9w0BAQsFADBbMQswCQYDVQQGEwJC
RTEZMBcGA1UEChMQR2xvYmFsU2lnbiBudi1zYTExMC8GA1UEAxMoR2xvYmFsU2lnbiBHQ0MgUjMg
UGVyc29uYWxTaWduIDIgQ0EgMjAyMDAeFw0yMjA5MTAwODIxMzhaFw0yNTA5MTAwODIxMzhaMIGO
MQswCQYDVQQGEwJJTjESMBAGA1UECBMJS2FybmF0YWthMRIwEAYDVQQHEwlCYW5nYWxvcmUxFjAU
BgNVBAoTDUJyb2FkY29tIEluYy4xFTATBgNVBAMTDE1pY2hhZWwgQ2hhbjEoMCYGCSqGSIb3DQEJ
ARYZbWljaGFlbC5jaGFuQGJyb2FkY29tLmNvbTCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoC
ggEBALhEmG7egFWvPKcrDxuNhNcn2oHauIHc8AzGhPyJxU4S6ZUjHM/psoNo5XxlMSRpYE7g7vLx
J4NBefU36XTEWVzbEkAuOSuJTuJkm98JE3+wjeO+aQTbNF3mG2iAe0AZbAWyqFxZulWitE8U2tIC
9mttDjSN/wbltcwuti7P57RuR+WyZstDlPJqUMm1rJTbgDqkF2pnvufc4US2iexnfjGopunLvioc
OnaLEot1MoQO7BIe5S9H4AcCEXXcrJJiAtMCl47ARpyHmvQFQFFTrHgUYEd9V+9bOzY7MBIGSV1N
/JfsT1sZw6HT0lJkSQefhPGpBniAob62DJP3qr11tu8CAwEAAaOCAdowggHWMA4GA1UdDwEB/wQE
AwIFoDCBowYIKwYBBQUHAQEEgZYwgZMwTgYIKwYBBQUHMAKGQmh0dHA6Ly9zZWN1cmUuZ2xvYmFs
c2lnbi5jb20vY2FjZXJ0L2dzZ2NjcjNwZXJzb25hbHNpZ24yY2EyMDIwLmNydDBBBggrBgEFBQcw
AYY1aHR0cDovL29jc3AuZ2xvYmFsc2lnbi5jb20vZ3NnY2NyM3BlcnNvbmFsc2lnbjJjYTIwMjAw
TQYDVR0gBEYwRDBCBgorBgEEAaAyASgKMDQwMgYIKwYBBQUHAgEWJmh0dHBzOi8vd3d3Lmdsb2Jh
bHNpZ24uY29tL3JlcG9zaXRvcnkvMAkGA1UdEwQCMAAwSQYDVR0fBEIwQDA+oDygOoY4aHR0cDov
L2NybC5nbG9iYWxzaWduLmNvbS9nc2djY3IzcGVyc29uYWxzaWduMmNhMjAyMC5jcmwwJAYDVR0R
BB0wG4EZbWljaGFlbC5jaGFuQGJyb2FkY29tLmNvbTATBgNVHSUEDDAKBggrBgEFBQcDBDAfBgNV
HSMEGDAWgBSWM9HmWBdbNHWKgVZk1b5I3qGPzzAdBgNVHQ4EFgQU31rAyTdZweIF0tJTFYwfOv2w
L4QwDQYJKoZIhvcNAQELBQADggEBACcuyaGmk0NSZ7Kio7O7WSZ0j0f9xXcBnLbJvQXFYM7JI5uS
kw5ozATEN5gfmNIe0AHzqwoYjAf3x8Dv2w7HgyrxWdpjTKQFv5jojxa3A5LVuM8mhPGZfR/L5jSk
5xc3llsKqrWI4ov4JyW79p0E99gfPA6Waixoavxvv1CZBQ4Stu7N660kTu9sJrACf20E+hdKLoiU
hd5wiQXo9B2ncm5P3jFLYLBmPltIn/uzdiYpFj+E9kS9XYDd+boBZhN1Vh0296zLQZobLfKFzClo
E6IFyTTANonrXvCRgodKS+QJEH8Syu2jSKe023aVemkuZjzvPK7o9iU7BKkPG2pzLPgxggJtMIIC
aQIBATBrMFsxCzAJBgNVBAYTAkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMTEwLwYDVQQD
EyhHbG9iYWxTaWduIEdDQyBSMyBQZXJzb25hbFNpZ24gMiBDQSAyMDIwAgxeQGjDntHGb2iaQkIw
DQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEILiEG7SA5Cnrz/URgS2wHH/qAEh+ejX3
2+UE5Tbg192aMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTIzMTEx
NDAwMTcwN1owaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCG
SAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQC
ATANBgkqhkiG9w0BAQEFAASCAQBumXp5Rje3vMqU4vfo5NGzNKtKUecxw6Zl6c1so0TJEDkdX7OC
ac2xbpfQBrcK7tTevXMn+zw87hN9puxnPF3Ex0r5jupIK35RMRfcpw919LU/yF3as1Uoc+6Yb0p0
SedGXuaLrRr4v/bVyfiOC+bH823GTmBv7x94gfHrTyeYuxjvj/x1aRN3vQXjMj/Nbm0Gmlsl8sd+
PVX2CN4RDGJqp5G5NQhHCTvREJsKcjVF/wLbx6ru48OmxjnjZAquKvTGrlUvtVoRID7lwGsmdSR2
ylO9Zua7bwiRdxkTtil/6c4Rzdu235xaXMxdvF5wPsSmfmQLj0bwupJLfcloM9Qb
--000000000000f68008060a11b4f8--

