Return-Path: <netdev+bounces-69288-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 09A1284A950
	for <lists+netdev@lfdr.de>; Mon,  5 Feb 2024 23:32:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B4C3F28F1C9
	for <lists+netdev@lfdr.de>; Mon,  5 Feb 2024 22:32:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 637311EB5E;
	Mon,  5 Feb 2024 22:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="aU6kT2E1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B4C417EF
	for <netdev@vger.kernel.org>; Mon,  5 Feb 2024 22:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707172340; cv=none; b=LEvAVUhvbHYnZVb5NKZpirxXmOzP22U25NrjWXDSbHW2N/oYdAhkLryO2uwal76EbivJFkOTqkQIkZyDLVEPMhsb6xEGhnqLck9UetPPlmRBgeBM8j1o+l8mS4F8tprquv3gdKt9W3P68MJ+gyd6NmOq7Pq2tKbbtaZEChRqEzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707172340; c=relaxed/simple;
	bh=USstlF9AF09uFw/m0UkzN5M17NuAlDATjQPowT6nXy0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FSjn6f1uEdyKforFJIVc3XTa/CEfV6aG4TaoSbQYLzsQM+jDWKtpk0hUZOyfayj2ZPL+lpFn5h2OnnfZa8AYUIbc5mi/0wY7V+8mVu9Gn4Wro4YR1f5tMndGxp4HzA/ilejoLSF+1vehUY+6xEuRQ6pmNm+tA8Emvob/I39viWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=aU6kT2E1; arc=none smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-6e13cfc0b2fso2727217a34.2
        for <netdev@vger.kernel.org>; Mon, 05 Feb 2024 14:32:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1707172337; x=1707777137; darn=vger.kernel.org;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=NItPsgaHvg3rOLJjy8ztFaCxrZ0ediYjA7YPu+zpX3I=;
        b=aU6kT2E1eu0FEPykT0GqoF98rYi1/1Z7XnQQ8C4CED9C1f8ogM69cu2zE9Xhpbx4M+
         cYeBfTQY39eumPDJn4/YxxgnNKiISlA5k2VOLUsTe8ieaydG/I2h5jIuDUHPNLFIwrvE
         ue/RZRWpMZV6gQ/e9+YoQffZXRnuWSSMKqc7o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707172337; x=1707777137;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NItPsgaHvg3rOLJjy8ztFaCxrZ0ediYjA7YPu+zpX3I=;
        b=QZVFXBfvZuFgFPvD0VOk2WgCvM8oKFIY7VCSPuO8oAAWQZRhvHlqVdTN38PSE7AnCv
         loNl5aS+EC4SRPV0P7+yYSGJy/BotLAZIZUmdqrAL7X7GTeWQsK1vSBu0kWl8ilHh+U1
         sFZdy3BAbqociG4PBS7eqaZ+GrmBbJGV0ZxUnP6ZZwr9ayyMImJuk4xKlJ+U4+DC7Ase
         VUpF2rizS44LSXKJoWtEy75L6BcO7HQKls+sCwaZjKVKmSa5KJgYNbNpV9T7w3RN5KTQ
         kT9nmWbx71tE/SEKSt43ZmAcdEyIU3c9ZkNteUnzQhvCQv/4PSrBkM3fzY41+OLU6jLO
         RaIw==
X-Gm-Message-State: AOJu0YwTAa9HOHpwh2c9589h/G6K7t0ja+vr/7j2rmcNo9jekOk0r4X2
	hDAZIaFzd54ntJ+YIvAQxYcJLKr0fvu+s9Lvs9eieSTAJbFPNgoyUSjEWrrhBfPq0BuJjfG0fgQ
	=
X-Google-Smtp-Source: AGHT+IFVuXPv20TPX6KHC9O4FWrBL/rIlOgGDizqTxXWVmsQ2PD8LBgYniVFuQTRKwYHrgiw1pSt+w==
X-Received: by 2002:a9d:7993:0:b0:6dc:1cf:2fef with SMTP id h19-20020a9d7993000000b006dc01cf2fefmr614728otm.15.1707172337575;
        Mon, 05 Feb 2024 14:32:17 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCUm/pOogs/e7VCnpCDxGhE0fmYjPwRx4Qf49Ue+hW2knhCjPih68YUeqQcnzGdx3A5ParVQi9oop9sgQoFAXLKa0Uu6hWopQ397MyM4+1ySYApGP2ceyYgOHWpxs4ViHIzoygCWl/mJSsMeZrUAd2c3oKOrdIJ96CN/iHFZaVA9x1FrPJZMff83N+VVlWZNnZcBBQ6sJVEbOBgFT+GzXXBe0dU=
Received: from lvnvda5233.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id x11-20020ac8120b000000b0042c2d47d7fbsm340864qti.60.2024.02.05.14.32.16
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 05 Feb 2024 14:32:16 -0800 (PST)
From: Michael Chan <michael.chan@broadcom.com>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew.gospodarek@broadcom.com,
	pavan.chebbi@broadcom.com
Subject: [PATCH net-next 02/13] bnxt_en: Add ethtool -N support for ether filters.
Date: Mon,  5 Feb 2024 14:31:51 -0800
Message-Id: <20240205223202.25341-3-michael.chan@broadcom.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20240205223202.25341-1-michael.chan@broadcom.com>
References: <20240205223202.25341-1-michael.chan@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000c6a63c0610aa0834"

--000000000000c6a63c0610aa0834
Content-Transfer-Encoding: 8bit

Add ETHTOOL_SRXCLSRLINS and ETHTOOL_SRXCLSRLDEL support for inserting
and deleting L2 ether filter rules.  Destination MAC address and
optional VLAN are supported for each filter entry.  This is currently
only supported on older BCM573XX and BCM574XX chips only.

Reviewed-by: Pavan Chebbi <pavan.chebbi@broadcom.com>
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c     | 34 +++++++++
 drivers/net/ethernet/broadcom/bnxt/bnxt.h     |  3 +
 .../net/ethernet/broadcom/bnxt/bnxt_ethtool.c | 69 ++++++++++++++++++-
 3 files changed, 103 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 91ecf514b924..3cc3504181c7 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -5519,6 +5519,40 @@ static struct bnxt_l2_filter *bnxt_alloc_l2_filter(struct bnxt *bp,
 	return fltr;
 }
 
+struct bnxt_l2_filter *bnxt_alloc_new_l2_filter(struct bnxt *bp,
+						struct bnxt_l2_key *key,
+						u16 flags)
+{
+	struct bnxt_l2_filter *fltr;
+	u32 idx;
+	int rc;
+
+	idx = jhash2(&key->filter_key, BNXT_L2_KEY_SIZE, bp->hash_seed) &
+	      BNXT_L2_FLTR_HASH_MASK;
+	spin_lock_bh(&bp->ntp_fltr_lock);
+	fltr = __bnxt_lookup_l2_filter(bp, key, idx);
+	if (fltr) {
+		fltr = ERR_PTR(-EEXIST);
+		goto l2_filter_exit;
+	}
+	fltr = kzalloc(sizeof(*fltr), GFP_ATOMIC);
+	if (!fltr) {
+		fltr = ERR_PTR(-ENOMEM);
+		goto l2_filter_exit;
+	}
+	fltr->base.flags = flags;
+	rc = bnxt_init_l2_filter(bp, fltr, key, idx);
+	if (rc) {
+		spin_unlock_bh(&bp->ntp_fltr_lock);
+		bnxt_del_l2_filter(bp, fltr);
+		return ERR_PTR(rc);
+	}
+
+l2_filter_exit:
+	spin_unlock_bh(&bp->ntp_fltr_lock);
+	return fltr;
+}
+
 static u16 bnxt_vf_target_id(struct bnxt_pf_info *pf, u16 vf_idx)
 {
 #ifdef CONFIG_BNXT_SRIOV
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.h b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
index 4bd1cf01d99e..21721b8748bc 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
@@ -2646,6 +2646,9 @@ int bnxt_hwrm_func_drv_rgtr(struct bnxt *bp, unsigned long *bmap,
 			    int bmap_size, bool async_only);
 int bnxt_hwrm_func_drv_unrgtr(struct bnxt *bp);
 void bnxt_del_l2_filter(struct bnxt *bp, struct bnxt_l2_filter *fltr);
+struct bnxt_l2_filter *bnxt_alloc_new_l2_filter(struct bnxt *bp,
+						struct bnxt_l2_key *key,
+						u16 flags);
 int bnxt_hwrm_l2_filter_free(struct bnxt *bp, struct bnxt_l2_filter *fltr);
 int bnxt_hwrm_l2_filter_alloc(struct bnxt *bp, struct bnxt_l2_filter *fltr);
 int bnxt_hwrm_cfa_ntuple_filter_free(struct bnxt *bp,
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
index 1c8610386404..2d8e847e8fdd 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
@@ -1152,6 +1152,58 @@ static int bnxt_grxclsrule(struct bnxt *bp, struct ethtool_rxnfc *cmd)
 	return rc;
 }
 
+static int bnxt_add_l2_cls_rule(struct bnxt *bp,
+				struct ethtool_rx_flow_spec *fs)
+{
+	u32 ring = ethtool_get_flow_spec_ring(fs->ring_cookie);
+	u8 vf = ethtool_get_flow_spec_ring_vf(fs->ring_cookie);
+	struct ethhdr *h_ether = &fs->h_u.ether_spec;
+	struct ethhdr *m_ether = &fs->m_u.ether_spec;
+	struct bnxt_l2_filter *fltr;
+	struct bnxt_l2_key key;
+	u16 vnic_id;
+	u8 flags;
+	int rc;
+
+	if (BNXT_CHIP_P5_PLUS(bp))
+		return -EOPNOTSUPP;
+
+	if (!is_broadcast_ether_addr(m_ether->h_dest))
+		return -EINVAL;
+	ether_addr_copy(key.dst_mac_addr, h_ether->h_dest);
+	key.vlan = 0;
+	if (fs->flow_type & FLOW_EXT) {
+		struct ethtool_flow_ext *m_ext = &fs->m_ext;
+		struct ethtool_flow_ext *h_ext = &fs->h_ext;
+
+		if (m_ext->vlan_tci != htons(0xfff) || !h_ext->vlan_tci)
+			return -EINVAL;
+		key.vlan = ntohs(h_ext->vlan_tci);
+	}
+
+	if (vf) {
+		flags = BNXT_ACT_FUNC_DST;
+		vnic_id = 0xffff;
+		vf--;
+	} else {
+		flags = BNXT_ACT_RING_DST;
+		vnic_id = bp->vnic_info[ring + 1].fw_vnic_id;
+	}
+	fltr = bnxt_alloc_new_l2_filter(bp, &key, flags);
+	if (IS_ERR(fltr))
+		return PTR_ERR(fltr);
+
+	fltr->base.fw_vnic_id = vnic_id;
+	fltr->base.rxq = ring;
+	fltr->base.vf_idx = vf;
+	rc = bnxt_hwrm_l2_filter_alloc(bp, fltr);
+	if (rc)
+		bnxt_del_l2_filter(bp, fltr);
+	else
+		fs->location = fltr->base.sw_id;
+	return rc;
+}
+
 #define IPV4_ALL_MASK		((__force __be32)~0)
 #define L4_PORT_ALL_MASK	((__force __be16)~0)
 
@@ -1335,7 +1387,7 @@ static int bnxt_srxclsrlins(struct bnxt *bp, struct ethtool_rxnfc *cmd)
 		return -EINVAL;
 	flow_type &= ~FLOW_EXT;
 	if (flow_type == ETHER_FLOW)
-		rc = -EOPNOTSUPP;
+		rc = bnxt_add_l2_cls_rule(bp, fs);
 	else
 		rc = bnxt_add_ntuple_cls_rule(bp, fs);
 	return rc;
@@ -1346,11 +1398,22 @@ static int bnxt_srxclsrldel(struct bnxt *bp, struct ethtool_rxnfc *cmd)
 	struct ethtool_rx_flow_spec *fs = &cmd->fs;
 	struct bnxt_filter_base *fltr_base;
 	struct bnxt_ntuple_filter *fltr;
+	u32 id = fs->location;
 
 	rcu_read_lock();
+	fltr_base = bnxt_get_one_fltr_rcu(bp, bp->l2_fltr_hash_tbl,
+					  BNXT_L2_FLTR_HASH_SIZE, id);
+	if (fltr_base) {
+		struct bnxt_l2_filter *l2_fltr;
+
+		l2_fltr = container_of(fltr_base, struct bnxt_l2_filter, base);
+		rcu_read_unlock();
+		bnxt_hwrm_l2_filter_free(bp, l2_fltr);
+		bnxt_del_l2_filter(bp, l2_fltr);
+		return 0;
+	}
 	fltr_base = bnxt_get_one_fltr_rcu(bp, bp->ntp_fltr_hash_tbl,
-					  BNXT_NTP_FLTR_HASH_SIZE,
-					  fs->location);
+					  BNXT_NTP_FLTR_HASH_SIZE, id);
 	if (!fltr_base) {
 		rcu_read_unlock();
 		return -ENOENT;
-- 
2.30.1


--000000000000c6a63c0610aa0834
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
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
DQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIHZmJ1rdn4n2sG1DSupbx2RuamrFsevJ
SQjp0NqPn6CWMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI0MDIw
NTIyMzIxN1owaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCG
SAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQC
ATANBgkqhkiG9w0BAQEFAASCAQCkhQoDp1N5N/rYxLj9WJSibOAYqK07QkIK47Ao9oPESjWFV0Mi
nj0QxYWbceQSXDxCk+4fBTdpO5l1sgvyTnJv7BStmrDE7URgqaOLAxrUQL9UUdUglkQb0E7iAUgU
P5/YKZ9lKEgKusu4zEEk6mYARf//MorMbzrprPfa9pP0I/pFmzLozNk7sQp0im/DoDiZnN/x2B4B
2F9CRZLZ7VVH7QM9I03WbvnUiN2LV7VBaTCqoKAo2XjY5IFln14dQAlZ5sKOu9aRoX9ZskBnPaHD
/iAIchSwpWghH/HOV+E6mxpIsIRfd9hOGlIY2lXgWIYf/RMaf3fuhFez6n6YGRP6
--000000000000c6a63c0610aa0834--

