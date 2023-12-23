Return-Path: <netdev+bounces-60056-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E2E881D22F
	for <lists+netdev@lfdr.de>; Sat, 23 Dec 2023 05:24:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0273F1F21ACA
	for <lists+netdev@lfdr.de>; Sat, 23 Dec 2023 04:24:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6CC1C2D6;
	Sat, 23 Dec 2023 04:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="A78B5Mr6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15202BA4E
	for <netdev@vger.kernel.org>; Sat, 23 Dec 2023 04:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-67ac0ef6bb8so13596546d6.1
        for <netdev@vger.kernel.org>; Fri, 22 Dec 2023 20:22:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1703305374; x=1703910174; darn=vger.kernel.org;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=fc5r+PWhufvcunFlTTWBXzxE1Sj34SrNZk3Qvh1HHJE=;
        b=A78B5Mr6c7D9swGai7hIAYEpdSztVS4SgplhG3k2qwqI6Bw49UerLV6q66JEm5evcD
         l0N1SCSKh5OZrQSlF/26o1NtAO5gdlYa0HNKacXkWrkvHNqYTVnT5rFFC3b4hYdbybti
         +ajA7VaQXOcjUmBPL4EzvWNab6AbtvAEYejrU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703305374; x=1703910174;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fc5r+PWhufvcunFlTTWBXzxE1Sj34SrNZk3Qvh1HHJE=;
        b=u/iUvEtfzz/n15UfvweY+G+4cgJqDAIDIJ//v6HxIVAzuEuDwqSWwuD5cpYYPd7vFG
         mg7BT+pLXj7PCxP+xug6TZZCsbX3XObtmb7AJzbo3hP9SFF/rQ4kgt7UHdnWaYzA3D1j
         0VdIPYDcjak79COb6LNe1Izlz0w16E+F8Y/+X2rG69IAnPbeLMMLLQ6dX21o7ZVPm6il
         ZTl8o8F+FxFw+M8CN8bwHf9MO2k0mPgIgDAduZKVQ1eM9VsfC3umnLfTDssLJKxlzQug
         Z8IHQ6aVCkB4kn5ik88HjqEAhlCmUOWPlNVUS2O9adRHHXHvaU46cMo/hHUP7vIp3W89
         cN/Q==
X-Gm-Message-State: AOJu0YzeKuOZXj0deFU58muLV7A8v91x8onVWUPxFDacqyP3H1XjBqEs
	m0U9FHAuSGal4ACAditMdXQg068mfUbv
X-Google-Smtp-Source: AGHT+IHl0MtfU59nlVF7xA8yhe0Eny2dMKhzIDKev5MPI3O1eP8YJPfetFt/VGgOi2acrbvCJ+O6Vw==
X-Received: by 2002:ad4:4ee6:0:b0:67f:28b7:a685 with SMTP id dv6-20020ad44ee6000000b0067f28b7a685mr3283518qvb.7.1703305373817;
        Fri, 22 Dec 2023 20:22:53 -0800 (PST)
Received: from lvnvda5233.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id ek5-20020ad45985000000b0067f8046a1acsm1299916qvb.144.2023.12.22.20.22.52
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Dec 2023 20:22:53 -0800 (PST)
From: Michael Chan <michael.chan@broadcom.com>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	pavan.chebbi@broadcom.com,
	andrew.gospodarek@broadcom.com
Subject: [PATCH net-next v2 12/13] bnxt_en: Add support for ntuple filters added from ethtool.
Date: Fri, 22 Dec 2023 20:22:09 -0800
Message-Id: <20231223042210.102485-13-michael.chan@broadcom.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20231223042210.102485-1-michael.chan@broadcom.com>
References: <20231223042210.102485-1-michael.chan@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000c6d332060d25af48"

--000000000000c6d332060d25af48
Content-Transfer-Encoding: 8bit

Add support for adding user defined ntuple TCP/UDP filters.  These
filters are similar to aRFS filters except that they don't get aged.
Source IP, destination IP, source port, or destination port can be
unspecifed as wildcard.  At least one of these tuples must be specifed.
If a tuple is specified, the full mask must be specified.

All ntuple related ethtool functions are now no longer compiled only
for CONFIG_RFS_ACCEL.

Reviewed-by: Vasundhara Volam <vasundhara-v.volam@broadcom.com>
Reviewed-by: Andy Gospodarek <andrew.gospodarek@broadcom.com>
Reviewed-by: Pavan Chebbi <pavan.chebbi@broadcom.com>
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c     |   6 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt.h     |   3 +
 .../net/ethernet/broadcom/bnxt/bnxt_ethtool.c | 199 +++++++++++++++++-
 3 files changed, 201 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index b949ab124dda..827821e89c40 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -5650,8 +5650,8 @@ void bnxt_fill_ipv6_mask(__be32 mask[4])
 		mask[i] = cpu_to_be32(~0);
 }
 
-static int bnxt_hwrm_cfa_ntuple_filter_alloc(struct bnxt *bp,
-					     struct bnxt_ntuple_filter *fltr)
+int bnxt_hwrm_cfa_ntuple_filter_alloc(struct bnxt *bp,
+				      struct bnxt_ntuple_filter *fltr)
 {
 	struct hwrm_cfa_ntuple_filter_alloc_output *resp;
 	struct hwrm_cfa_ntuple_filter_alloc_input *req;
@@ -14072,6 +14072,8 @@ static void bnxt_cfg_ntp_filters(struct bnxt *bp)
 			bool del = false;
 
 			if (test_bit(BNXT_FLTR_VALID, &fltr->base.state)) {
+				if (fltr->base.flags & BNXT_ACT_NO_AGING)
+					continue;
 				if (rps_may_expire_flow(bp->dev, fltr->base.rxq,
 							fltr->flow_id,
 							fltr->base.sw_id)) {
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.h b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
index dc1bc163c82f..b8ef1717cb65 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
@@ -1342,6 +1342,7 @@ struct bnxt_filter_base {
 #define BNXT_ACT_DROP		1
 #define BNXT_ACT_RING_DST	2
 #define BNXT_ACT_FUNC_DST	4
+#define BNXT_ACT_NO_AGING	8
 	u16			sw_id;
 	u16			rxq;
 	u16			fw_vnic_id;
@@ -2647,6 +2648,8 @@ int bnxt_hwrm_l2_filter_free(struct bnxt *bp, struct bnxt_l2_filter *fltr);
 int bnxt_hwrm_l2_filter_alloc(struct bnxt *bp, struct bnxt_l2_filter *fltr);
 int bnxt_hwrm_cfa_ntuple_filter_free(struct bnxt *bp,
 				     struct bnxt_ntuple_filter *fltr);
+int bnxt_hwrm_cfa_ntuple_filter_alloc(struct bnxt *bp,
+				      struct bnxt_ntuple_filter *fltr);
 void bnxt_fill_ipv6_mask(__be32 mask[4]);
 int bnxt_get_nr_rss_ctxs(struct bnxt *bp, int rx_rings);
 int bnxt_hwrm_vnic_cfg(struct bnxt *bp, u16 vnic_id);
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
index 558dd1f9a18e..c3b9be328b87 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
@@ -1011,7 +1011,6 @@ static int bnxt_set_channels(struct net_device *dev,
 	return rc;
 }
 
-#ifdef CONFIG_RFS_ACCEL
 static u32 bnxt_get_all_fltr_ids_rcu(struct bnxt *bp, struct hlist_head tbl[],
 				     int tbl_size, u32 *ids, u32 start,
 				     u32 id_cnt)
@@ -1152,7 +1151,195 @@ static int bnxt_grxclsrule(struct bnxt *bp, struct ethtool_rxnfc *cmd)
 
 	return rc;
 }
-#endif
+
+#define IPV4_ALL_MASK		((__force __be32)~0)
+#define L4_PORT_ALL_MASK	((__force __be16)~0)
+
+static bool ipv6_mask_is_full(__be32 mask[4])
+{
+	return (mask[0] & mask[1] & mask[2] & mask[3]) == IPV4_ALL_MASK;
+}
+
+static bool ipv6_mask_is_zero(__be32 mask[4])
+{
+	return !(mask[0] | mask[1] | mask[2] | mask[3]);
+}
+
+static int bnxt_add_ntuple_cls_rule(struct bnxt *bp,
+				    struct ethtool_rx_flow_spec *fs)
+{
+	u8 vf = ethtool_get_flow_spec_ring_vf(fs->ring_cookie);
+	u32 ring = ethtool_get_flow_spec_ring(fs->ring_cookie);
+	struct bnxt_ntuple_filter *new_fltr, *fltr;
+	struct bnxt_l2_filter *l2_fltr;
+	u32 flow_type = fs->flow_type;
+	struct flow_keys *fkeys;
+	u32 idx;
+	int rc;
+
+	if (!bp->vnic_info)
+		return -EAGAIN;
+
+	if ((flow_type & (FLOW_MAC_EXT | FLOW_EXT)) || vf)
+		return -EOPNOTSUPP;
+
+	new_fltr = kzalloc(sizeof(*new_fltr), GFP_KERNEL);
+	if (!new_fltr)
+		return -ENOMEM;
+
+	l2_fltr = bp->vnic_info[0].l2_filters[0];
+	atomic_inc(&l2_fltr->refcnt);
+	new_fltr->l2_fltr = l2_fltr;
+	fkeys = &new_fltr->fkeys;
+
+	rc = -EOPNOTSUPP;
+	switch (flow_type) {
+	case TCP_V4_FLOW:
+	case UDP_V4_FLOW: {
+		struct ethtool_tcpip4_spec *ip_spec = &fs->h_u.tcp_ip4_spec;
+		struct ethtool_tcpip4_spec *ip_mask = &fs->m_u.tcp_ip4_spec;
+
+		fkeys->basic.ip_proto = IPPROTO_TCP;
+		if (flow_type == UDP_V4_FLOW)
+			fkeys->basic.ip_proto = IPPROTO_UDP;
+		fkeys->basic.n_proto = htons(ETH_P_IP);
+
+		if (ip_mask->ip4src == IPV4_ALL_MASK) {
+			fkeys->addrs.v4addrs.src = ip_spec->ip4src;
+			new_fltr->ntuple_flags |= BNXT_NTUPLE_MATCH_SRC_IP;
+		} else if (ip_mask->ip4src) {
+			goto ntuple_err;
+		}
+		if (ip_mask->ip4dst == IPV4_ALL_MASK) {
+			fkeys->addrs.v4addrs.dst = ip_spec->ip4dst;
+			new_fltr->ntuple_flags |= BNXT_NTUPLE_MATCH_DST_IP;
+		} else if (ip_mask->ip4dst) {
+			goto ntuple_err;
+		}
+
+		if (ip_mask->psrc == L4_PORT_ALL_MASK) {
+			fkeys->ports.src = ip_spec->psrc;
+			new_fltr->ntuple_flags |= BNXT_NTUPLE_MATCH_SRC_PORT;
+		} else if (ip_mask->psrc) {
+			goto ntuple_err;
+		}
+		if (ip_mask->pdst == L4_PORT_ALL_MASK) {
+			fkeys->ports.dst = ip_spec->pdst;
+			new_fltr->ntuple_flags |= BNXT_NTUPLE_MATCH_DST_PORT;
+		} else if (ip_mask->pdst) {
+			goto ntuple_err;
+		}
+		break;
+	}
+	case TCP_V6_FLOW:
+	case UDP_V6_FLOW: {
+		struct ethtool_tcpip6_spec *ip_spec = &fs->h_u.tcp_ip6_spec;
+		struct ethtool_tcpip6_spec *ip_mask = &fs->m_u.tcp_ip6_spec;
+
+		fkeys->basic.ip_proto = IPPROTO_TCP;
+		if (flow_type == UDP_V6_FLOW)
+			fkeys->basic.ip_proto = IPPROTO_UDP;
+		fkeys->basic.n_proto = htons(ETH_P_IPV6);
+
+		if (ipv6_mask_is_full(ip_mask->ip6src)) {
+			fkeys->addrs.v6addrs.src =
+				*(struct in6_addr *)&ip_spec->ip6src;
+			new_fltr->ntuple_flags |= BNXT_NTUPLE_MATCH_SRC_IP;
+		} else if (!ipv6_mask_is_zero(ip_mask->ip6src)) {
+			goto ntuple_err;
+		}
+		if (ipv6_mask_is_full(ip_mask->ip6dst)) {
+			fkeys->addrs.v6addrs.dst =
+				*(struct in6_addr *)&ip_spec->ip6dst;
+			new_fltr->ntuple_flags |= BNXT_NTUPLE_MATCH_DST_IP;
+		} else if (!ipv6_mask_is_zero(ip_mask->ip6dst)) {
+			goto ntuple_err;
+		}
+
+		if (ip_mask->psrc == L4_PORT_ALL_MASK) {
+			fkeys->ports.src = ip_spec->psrc;
+			new_fltr->ntuple_flags |= BNXT_NTUPLE_MATCH_SRC_PORT;
+		} else if (ip_mask->psrc) {
+			goto ntuple_err;
+		}
+		if (ip_mask->pdst == L4_PORT_ALL_MASK) {
+			fkeys->ports.dst = ip_spec->pdst;
+			new_fltr->ntuple_flags |= BNXT_NTUPLE_MATCH_DST_PORT;
+		} else if (ip_mask->pdst) {
+			goto ntuple_err;
+		}
+		break;
+	}
+	default:
+		rc = -EOPNOTSUPP;
+		goto ntuple_err;
+	}
+	if (!new_fltr->ntuple_flags)
+		goto ntuple_err;
+
+	idx = bnxt_get_ntp_filter_idx(bp, fkeys, NULL);
+	rcu_read_lock();
+	fltr = bnxt_lookup_ntp_filter_from_idx(bp, new_fltr, idx);
+	if (fltr) {
+		rcu_read_unlock();
+		rc = -EEXIST;
+		goto ntuple_err;
+	}
+	rcu_read_unlock();
+
+	new_fltr->base.rxq = ring;
+	new_fltr->base.flags = BNXT_ACT_NO_AGING;
+	__set_bit(BNXT_FLTR_VALID, &new_fltr->base.state);
+	rc = bnxt_insert_ntp_filter(bp, new_fltr, idx);
+	if (!rc) {
+		rc = bnxt_hwrm_cfa_ntuple_filter_alloc(bp, new_fltr);
+		if (rc) {
+			bnxt_del_ntp_filter(bp, new_fltr);
+			return rc;
+		}
+		fs->location = new_fltr->base.sw_id;
+		return 0;
+	}
+
+ntuple_err:
+	atomic_dec(&l2_fltr->refcnt);
+	kfree(new_fltr);
+	return rc;
+}
+
+static int bnxt_srxclsrlins(struct bnxt *bp, struct ethtool_rxnfc *cmd)
+{
+	struct ethtool_rx_flow_spec *fs = &cmd->fs;
+	u32 ring, flow_type;
+	int rc;
+	u8 vf;
+
+	if (!netif_running(bp->dev))
+		return -EAGAIN;
+	if (!(bp->flags & BNXT_FLAG_RFS))
+		return -EPERM;
+	if (fs->location != RX_CLS_LOC_ANY)
+		return -EINVAL;
+
+	ring = ethtool_get_flow_spec_ring(fs->ring_cookie);
+	vf = ethtool_get_flow_spec_ring_vf(fs->ring_cookie);
+	if (BNXT_VF(bp) && vf)
+		return -EINVAL;
+	if (BNXT_PF(bp) && vf > bp->pf.active_vfs)
+		return -EINVAL;
+	if (!vf && ring >= bp->rx_nr_rings)
+		return -EINVAL;
+
+	flow_type = fs->flow_type;
+	if (flow_type & (FLOW_MAC_EXT | FLOW_RSS))
+		return -EINVAL;
+	flow_type &= ~FLOW_EXT;
+	if (flow_type == ETHER_FLOW)
+		rc = -EOPNOTSUPP;
+	else
+		rc = bnxt_add_ntuple_cls_rule(bp, fs);
+	return rc;
+}
 
 static u64 get_ethtool_ipv4_rss(struct bnxt *bp)
 {
@@ -1302,14 +1489,13 @@ static int bnxt_get_rxnfc(struct net_device *dev, struct ethtool_rxnfc *cmd,
 	int rc = 0;
 
 	switch (cmd->cmd) {
-#ifdef CONFIG_RFS_ACCEL
 	case ETHTOOL_GRXRINGS:
 		cmd->data = bp->rx_nr_rings;
 		break;
 
 	case ETHTOOL_GRXCLSRLCNT:
 		cmd->rule_cnt = bp->ntp_fltr_count;
-		cmd->data = BNXT_NTP_FLTR_MAX_FLTR;
+		cmd->data = BNXT_NTP_FLTR_MAX_FLTR | RX_CLS_LOC_SPECIAL;
 		break;
 
 	case ETHTOOL_GRXCLSRLALL:
@@ -1319,7 +1505,6 @@ static int bnxt_get_rxnfc(struct net_device *dev, struct ethtool_rxnfc *cmd,
 	case ETHTOOL_GRXCLSRULE:
 		rc = bnxt_grxclsrule(bp, cmd);
 		break;
-#endif
 
 	case ETHTOOL_GRXFH:
 		rc = bnxt_grxfh(bp, cmd);
@@ -1343,6 +1528,10 @@ static int bnxt_set_rxnfc(struct net_device *dev, struct ethtool_rxnfc *cmd)
 		rc = bnxt_srxfh(bp, cmd);
 		break;
 
+	case ETHTOOL_SRXCLSRLINS:
+		rc = bnxt_srxclsrlins(bp, cmd);
+		break;
+
 	default:
 		rc = -EOPNOTSUPP;
 		break;
-- 
2.30.1


--000000000000c6d332060d25af48
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
DQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEICsP/Cb78QmyaqLak/zYBdUagareZiig
BfTKJgsW6LZWMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTIzMTIy
MzA0MjI1NFowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCG
SAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQC
ATANBgkqhkiG9w0BAQEFAASCAQC0bUsAiB+jgJvfAt+EqFJp2ML3+6qGJQ++WXjRQMsevU0h9q3W
IbER+Ih5YvPAwficLdYaK25Kw7Tj97dlomzEOhMOyCb1+oTl0QzZtDi3rCnNXB5K2seLcEGg1/Bb
NMoAokFI4ah9R/q5WWHIufsm0fSB3NVY5IpEH8HWbI5wdivRa4p7s/xTTFd//77EfVTtdefkGIRx
Zz//JCnQaaUr27BfizbjIYF1nlMtM4t4P17ARtnufgoWqeR75wscgkYpJF6evmR7kst3tAo83hvB
ynu8LkX1dNkf8FwPqUa5uxcQ1TxcjpMcwRoAiSDnsZH1Ue/ta9eaiFBDq/eVJFnR
--000000000000c6d332060d25af48--

