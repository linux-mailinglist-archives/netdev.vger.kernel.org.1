Return-Path: <netdev+bounces-69291-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 25DA484A953
	for <lists+netdev@lfdr.de>; Mon,  5 Feb 2024 23:32:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D129A28F661
	for <lists+netdev@lfdr.de>; Mon,  5 Feb 2024 22:32:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA8981EB3C;
	Mon,  5 Feb 2024 22:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="RcSqpxKC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD86417552
	for <netdev@vger.kernel.org>; Mon,  5 Feb 2024 22:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707172345; cv=none; b=aB/0kxpsUy+Jypu9Hk11jVlbD3asjvlQmaCVnNvRWNqAATYZj947C9pQg0kX9hYDiL7TBiwNrZUJAlWfEk+9/D07cSHL/HTLjNaHr98lW3n3mjjGI7S3r8sfK3OYABRNasi44cOOID8ejZl8FIAmLwG5uSjaaz8DVrwF0VIpijk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707172345; c=relaxed/simple;
	bh=tJZXnu/qRp5nLcD+RRWVPilcbS3jRneUVt2SJd6Jnew=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qBuFHittNWdoUYCUcjdK5LjcCpYCJiUdGGfADeg40HQag9W2uVRD+GGJhLqRXKxHPBvgc1T9XNihtroIaswUWPYQssI0P7zoF3cXIhJjHIOSw3QrG6tz3Lcs7iAYc69A6Dyc5cHCdQXbsBNqRbRGOwJKbOe2Uy21BV7Di34cWo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=RcSqpxKC; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-42a4516ec46so35679971cf.0
        for <netdev@vger.kernel.org>; Mon, 05 Feb 2024 14:32:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1707172343; x=1707777143; darn=vger.kernel.org;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=uxBXJjQne4Y0nPfa9UXE/uXKqXiOkLASCfuYgXm9WJA=;
        b=RcSqpxKC9QZ5+plVk4VKjiO1HzXQOJY1Hg+YJ4eC2DhzeuhBxBm/UVHEYy5hwfXgjs
         ju0C9Db2pnazfvLqIarSFTkHv8yifncnmnmrf7sMQh/e1KTmUfD0S3bhKlqj57qbISGD
         P9+V7EJSPNyojdfq5Q9Q4pQHtaRwxpMbppBMs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707172343; x=1707777143;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uxBXJjQne4Y0nPfa9UXE/uXKqXiOkLASCfuYgXm9WJA=;
        b=I9oFAblqz69YUUpnG1giBxTQVih+h2482UuSfZVfGQxTEBY0q0WIg+kpxZDRLSZcEx
         u571sDsoBdZYlBYlECnzBqoDbqa0Lwzwmetk3k5YMZtDSIwfCvPULiSoDNVIgjBF/w3B
         1jvyCQrETZpNSDvA20HsDPvVL0SfaO21fM1LcA/BEOWKInR/bRgQQT+tUnwlOuoHOd79
         BoKPxRYoeo1f7DbexPr77lEKdj5zNdOMPLiBtpVkp9IiK7qyQqtIsi4JMno9WByH4QCm
         mCrVudVMqv5gE60GSE+9fKrirnkb1x+mal61lat1Fj57a0t8C8Q4uLnsGEY1SNOGKm02
         J06A==
X-Gm-Message-State: AOJu0YzeBkziShvSLP0qRozNP8yP7658YLg6dHGiOpbbXi97DAcYWs/X
	60uy6aEaqmsYQ73F1yWvq+vgwJ6rFtLZfiTR+z73ewcpoIFRL4blUFMLZDSBRA==
X-Google-Smtp-Source: AGHT+IHFfSTLhh1SRBsXYY+RZ/yukSgwaeogM6CrpI9KT406tLe5QZEV+UajMYaeAv9WLwYiYFQ27Q==
X-Received: by 2002:a05:622a:349:b0:42b:fac1:8141 with SMTP id r9-20020a05622a034900b0042bfac18141mr2057015qtw.7.1707172342547;
        Mon, 05 Feb 2024 14:32:22 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCU6paz0aOO8jaCPJULjDo/v5VAm56gXa4plD+ySYGK6gxZsBCcBwwHc02ThjKs+mVM7ngnf6alUfURfPyZjHZnGX5t41BH4IzAypshX8r4J93Q8eF7n//GYoMVRMFaJ8wWp81d6MhOPA6o6271OjP5cggBoyGCoJyTA2XpOsN4LP5eC9EKrwwcVbX+s+Pu1c6cqDbMv4Bx8/G1v7yWuP73lqj2j5sBt9xApPh2MElr1qgrBqxquWvH8pLi6Kw==
Received: from lvnvda5233.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id x11-20020ac8120b000000b0042c2d47d7fbsm340864qti.60.2024.02.05.14.32.20
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 05 Feb 2024 14:32:21 -0800 (PST)
From: Michael Chan <michael.chan@broadcom.com>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew.gospodarek@broadcom.com,
	pavan.chebbi@broadcom.com,
	Vikas Gupta <vikas.gupta@broadcom.com>
Subject: [PATCH net-next 05/13] bnxt_en: Enhance ethtool ntuple support for ip flows besides TCP/UDP
Date: Mon,  5 Feb 2024 14:31:54 -0800
Message-Id: <20240205223202.25341-6-michael.chan@broadcom.com>
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
	boundary="00000000000014cecb0610aa0991"

--00000000000014cecb0610aa0991
Content-Transfer-Encoding: 8bit

From: Vikas Gupta <vikas.gupta@broadcom.com>

Enable flow type ipv4/ipv6
1) for protocols ICMPV4 and ICMPV6.
2) for wildcard match. Wildcard matches to TCP/UDP/ICMP.
   Note that, IPPROTO_RAW(255) i.e. a reserved protocol
   considered for a wildcard.

Reviewed-by: Andy Gospodarek <andrew.gospodarek@broadcom.com>
Reviewed-by: Pavan Chebbi <pavan.chebbi@broadcom.com>
Signed-off-by: Vikas Gupta <vikas.gupta@broadcom.com>
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c     |   4 +
 drivers/net/ethernet/broadcom/bnxt/bnxt.h     |   1 +
 .../net/ethernet/broadcom/bnxt/bnxt_ethtool.c | 124 +++++++++++++++---
 .../net/ethernet/broadcom/bnxt/bnxt_ethtool.h |   2 +
 4 files changed, 113 insertions(+), 18 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index dc54cc0ab075..ea9c33e328cf 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -8891,6 +8891,10 @@ static int bnxt_hwrm_cfa_adv_flow_mgnt_qcaps(struct bnxt *bp)
 	    CFA_ADV_FLOW_MGNT_QCAPS_RESP_FLAGS_RFS_RING_TBL_IDX_V2_SUPPORTED)
 		bp->fw_cap |= BNXT_FW_CAP_CFA_RFS_RING_TBL_IDX_V2;
 
+	if (flags &
+	    CFA_ADV_FLOW_MGNT_QCAPS_RESP_FLAGS_NTUPLE_FLOW_RX_EXT_IP_PROTO_SUPPORTED)
+		bp->fw_cap |= BNXT_FW_CAP_CFA_NTUPLE_RX_EXT_IP_PROTO;
+
 hwrm_cfa_adv_qcaps_exit:
 	hwrm_req_drop(bp, req);
 	return rc;
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.h b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
index aae180fa63b7..16f18c70c7bb 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
@@ -2302,6 +2302,7 @@ struct bnxt {
 	#define BNXT_FW_CAP_PRE_RESV_VNICS		BIT_ULL(35)
 	#define BNXT_FW_CAP_BACKING_STORE_V2		BIT_ULL(36)
 	#define BNXT_FW_CAP_VNIC_TUNNEL_TPA		BIT_ULL(37)
+	#define BNXT_FW_CAP_CFA_NTUPLE_RX_EXT_IP_PROTO	BIT_ULL(38)
 
 	u32			fw_dbg_cap;
 
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
index b3fd32ff963a..b6bc14b5d1bb 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
@@ -1130,28 +1130,50 @@ static int bnxt_grxclsrule(struct bnxt *bp, struct ethtool_rxnfc *cmd)
 	fkeys = &fltr->fkeys;
 	fmasks = &fltr->fmasks;
 	if (fkeys->basic.n_proto == htons(ETH_P_IP)) {
-		if (fkeys->basic.ip_proto == IPPROTO_TCP)
+		if (fkeys->basic.ip_proto == IPPROTO_ICMP ||
+		    fkeys->basic.ip_proto == IPPROTO_RAW) {
+			fs->flow_type = IP_USER_FLOW;
+			fs->h_u.usr_ip4_spec.ip_ver = ETH_RX_NFC_IP4;
+			if (fkeys->basic.ip_proto == IPPROTO_ICMP)
+				fs->h_u.usr_ip4_spec.proto = IPPROTO_ICMP;
+			else
+				fs->h_u.usr_ip4_spec.proto = IPPROTO_RAW;
+			fs->m_u.usr_ip4_spec.proto = BNXT_IP_PROTO_FULL_MASK;
+		} else if (fkeys->basic.ip_proto == IPPROTO_TCP) {
 			fs->flow_type = TCP_V4_FLOW;
-		else if (fkeys->basic.ip_proto == IPPROTO_UDP)
+		} else if (fkeys->basic.ip_proto == IPPROTO_UDP) {
 			fs->flow_type = UDP_V4_FLOW;
-		else
+		} else {
 			goto fltr_err;
+		}
 
 		fs->h_u.tcp_ip4_spec.ip4src = fkeys->addrs.v4addrs.src;
 		fs->m_u.tcp_ip4_spec.ip4src = fmasks->addrs.v4addrs.src;
 		fs->h_u.tcp_ip4_spec.ip4dst = fkeys->addrs.v4addrs.dst;
 		fs->m_u.tcp_ip4_spec.ip4dst = fmasks->addrs.v4addrs.dst;
-		fs->h_u.tcp_ip4_spec.psrc = fkeys->ports.src;
-		fs->m_u.tcp_ip4_spec.psrc = fmasks->ports.src;
-		fs->h_u.tcp_ip4_spec.pdst = fkeys->ports.dst;
-		fs->m_u.tcp_ip4_spec.pdst = fmasks->ports.dst;
+		if (fs->flow_type == TCP_V4_FLOW ||
+		    fs->flow_type == UDP_V4_FLOW) {
+			fs->h_u.tcp_ip4_spec.psrc = fkeys->ports.src;
+			fs->m_u.tcp_ip4_spec.psrc = fmasks->ports.src;
+			fs->h_u.tcp_ip4_spec.pdst = fkeys->ports.dst;
+			fs->m_u.tcp_ip4_spec.pdst = fmasks->ports.dst;
+		}
 	} else {
-		if (fkeys->basic.ip_proto == IPPROTO_TCP)
+		if (fkeys->basic.ip_proto == IPPROTO_ICMPV6 ||
+		    fkeys->basic.ip_proto == IPPROTO_RAW) {
+			fs->flow_type = IPV6_USER_FLOW;
+			if (fkeys->basic.ip_proto == IPPROTO_ICMPV6)
+				fs->h_u.usr_ip6_spec.l4_proto = IPPROTO_ICMPV6;
+			else
+				fs->h_u.usr_ip6_spec.l4_proto = IPPROTO_RAW;
+			fs->m_u.usr_ip6_spec.l4_proto = BNXT_IP_PROTO_FULL_MASK;
+		} else if (fkeys->basic.ip_proto == IPPROTO_TCP) {
 			fs->flow_type = TCP_V6_FLOW;
-		else if (fkeys->basic.ip_proto == IPPROTO_UDP)
+		} else if (fkeys->basic.ip_proto == IPPROTO_UDP) {
 			fs->flow_type = UDP_V6_FLOW;
-		else
+		} else {
 			goto fltr_err;
+		}
 
 		*(struct in6_addr *)&fs->h_u.tcp_ip6_spec.ip6src[0] =
 			fkeys->addrs.v6addrs.src;
@@ -1161,10 +1183,13 @@ static int bnxt_grxclsrule(struct bnxt *bp, struct ethtool_rxnfc *cmd)
 			fkeys->addrs.v6addrs.dst;
 		*(struct in6_addr *)&fs->m_u.tcp_ip6_spec.ip6dst[0] =
 			fmasks->addrs.v6addrs.dst;
-		fs->h_u.tcp_ip6_spec.psrc = fkeys->ports.src;
-		fs->m_u.tcp_ip6_spec.psrc = fmasks->ports.src;
-		fs->h_u.tcp_ip6_spec.pdst = fkeys->ports.dst;
-		fs->m_u.tcp_ip6_spec.pdst = fmasks->ports.dst;
+		if (fs->flow_type == TCP_V6_FLOW ||
+		    fs->flow_type == UDP_V6_FLOW) {
+			fs->h_u.tcp_ip6_spec.psrc = fkeys->ports.src;
+			fs->m_u.tcp_ip6_spec.psrc = fmasks->ports.src;
+			fs->h_u.tcp_ip6_spec.pdst = fkeys->ports.dst;
+			fs->m_u.tcp_ip6_spec.pdst = fmasks->ports.dst;
+		}
 	}
 
 	fs->ring_cookie = fltr->base.rxq;
@@ -1228,6 +1253,28 @@ static int bnxt_add_l2_cls_rule(struct bnxt *bp,
 	return rc;
 }
 
+static bool bnxt_verify_ntuple_ip4_flow(struct ethtool_usrip4_spec *ip_spec,
+					struct ethtool_usrip4_spec *ip_mask)
+{
+	if (ip_mask->l4_4_bytes || ip_mask->tos ||
+	    ip_spec->ip_ver != ETH_RX_NFC_IP4 ||
+	    ip_mask->proto != BNXT_IP_PROTO_FULL_MASK ||
+	    (ip_spec->proto != IPPROTO_RAW && ip_spec->proto != IPPROTO_ICMP))
+		return false;
+	return true;
+}
+
+static bool bnxt_verify_ntuple_ip6_flow(struct ethtool_usrip6_spec *ip_spec,
+					struct ethtool_usrip6_spec *ip_mask)
+{
+	if (ip_mask->l4_4_bytes || ip_mask->tclass ||
+	    ip_mask->l4_proto != BNXT_IP_PROTO_FULL_MASK ||
+	    (ip_spec->l4_proto != IPPROTO_RAW &&
+	     ip_spec->l4_proto != IPPROTO_ICMPV6))
+		return false;
+	return true;
+}
+
 static int bnxt_add_ntuple_cls_rule(struct bnxt *bp,
 				    struct ethtool_rx_flow_spec *fs)
 {
@@ -1247,6 +1294,18 @@ static int bnxt_add_ntuple_cls_rule(struct bnxt *bp,
 	if ((flow_type & (FLOW_MAC_EXT | FLOW_EXT)) || vf)
 		return -EOPNOTSUPP;
 
+	if (flow_type == IP_USER_FLOW) {
+		if (!bnxt_verify_ntuple_ip4_flow(&fs->h_u.usr_ip4_spec,
+						 &fs->m_u.usr_ip4_spec))
+			return -EOPNOTSUPP;
+	}
+
+	if (flow_type == IPV6_USER_FLOW) {
+		if (!bnxt_verify_ntuple_ip6_flow(&fs->h_u.usr_ip6_spec,
+						 &fs->m_u.usr_ip6_spec))
+			return -EOPNOTSUPP;
+	}
+
 	new_fltr = kzalloc(sizeof(*new_fltr), GFP_KERNEL);
 	if (!new_fltr)
 		return -ENOMEM;
@@ -1259,6 +1318,18 @@ static int bnxt_add_ntuple_cls_rule(struct bnxt *bp,
 
 	rc = -EOPNOTSUPP;
 	switch (flow_type) {
+	case IP_USER_FLOW: {
+		struct ethtool_usrip4_spec *ip_spec = &fs->h_u.usr_ip4_spec;
+		struct ethtool_usrip4_spec *ip_mask = &fs->m_u.usr_ip4_spec;
+
+		fkeys->basic.ip_proto = ip_spec->proto;
+		fkeys->basic.n_proto = htons(ETH_P_IP);
+		fkeys->addrs.v4addrs.src = ip_spec->ip4src;
+		fmasks->addrs.v4addrs.src = ip_mask->ip4src;
+		fkeys->addrs.v4addrs.dst = ip_spec->ip4dst;
+		fmasks->addrs.v4addrs.dst = ip_mask->ip4dst;
+		break;
+	}
 	case TCP_V4_FLOW:
 	case UDP_V4_FLOW: {
 		struct ethtool_tcpip4_spec *ip_spec = &fs->h_u.tcp_ip4_spec;
@@ -1278,6 +1349,18 @@ static int bnxt_add_ntuple_cls_rule(struct bnxt *bp,
 		fmasks->ports.dst = ip_mask->pdst;
 		break;
 	}
+	case IPV6_USER_FLOW: {
+		struct ethtool_usrip6_spec *ip_spec = &fs->h_u.usr_ip6_spec;
+		struct ethtool_usrip6_spec *ip_mask = &fs->m_u.usr_ip6_spec;
+
+		fkeys->basic.ip_proto = ip_spec->l4_proto;
+		fkeys->basic.n_proto = htons(ETH_P_IPV6);
+		fkeys->addrs.v6addrs.src = *(struct in6_addr *)&ip_spec->ip6src;
+		fmasks->addrs.v6addrs.src = *(struct in6_addr *)&ip_mask->ip6src;
+		fkeys->addrs.v6addrs.dst = *(struct in6_addr *)&ip_spec->ip6dst;
+		fmasks->addrs.v6addrs.dst = *(struct in6_addr *)&ip_mask->ip6dst;
+		break;
+	}
 	case TCP_V6_FLOW:
 	case UDP_V6_FLOW: {
 		struct ethtool_tcpip6_spec *ip_spec = &fs->h_u.tcp_ip6_spec;
@@ -1349,6 +1432,15 @@ static int bnxt_srxclsrlins(struct bnxt *bp, struct ethtool_rxnfc *cmd)
 	if (fs->location != RX_CLS_LOC_ANY)
 		return -EINVAL;
 
+	flow_type = fs->flow_type;
+	if ((flow_type == IP_USER_FLOW ||
+	     flow_type == IPV6_USER_FLOW) &&
+	    !(bp->fw_cap & BNXT_FW_CAP_CFA_NTUPLE_RX_EXT_IP_PROTO))
+		return -EOPNOTSUPP;
+	if (flow_type & (FLOW_MAC_EXT | FLOW_RSS))
+		return -EINVAL;
+	flow_type &= ~FLOW_EXT;
+
 	ring = ethtool_get_flow_spec_ring(fs->ring_cookie);
 	vf = ethtool_get_flow_spec_ring_vf(fs->ring_cookie);
 	if (BNXT_VF(bp) && vf)
@@ -1358,10 +1450,6 @@ static int bnxt_srxclsrlins(struct bnxt *bp, struct ethtool_rxnfc *cmd)
 	if (!vf && ring >= bp->rx_nr_rings)
 		return -EINVAL;
 
-	flow_type = fs->flow_type;
-	if (flow_type & (FLOW_MAC_EXT | FLOW_RSS))
-		return -EINVAL;
-	flow_type &= ~FLOW_EXT;
 	if (flow_type == ETHER_FLOW)
 		rc = bnxt_add_l2_cls_rule(bp, fs);
 	else
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.h b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.h
index a8ecef8ab82c..f9e36ac80c40 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.h
@@ -43,6 +43,8 @@ struct bnxt_led_cfg {
 
 #define BNXT_PXP_REG_LEN	0x3110
 
+#define BNXT_IP_PROTO_FULL_MASK	0xFF
+
 extern const struct ethtool_ops bnxt_ethtool_ops;
 
 u32 bnxt_get_rxfh_indir_size(struct net_device *dev);
-- 
2.30.1


--00000000000014cecb0610aa0991
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
DQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIMeMhCobq/gg93VOZSY5x6/IGSS7OILA
jG479nigjtwNMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI0MDIw
NTIyMzIyM1owaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCG
SAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQC
ATANBgkqhkiG9w0BAQEFAASCAQBy9KRrL9HsH6SnGrMHt/wovPDXr8005zwwyQIqZh3ino/86NNS
tQ4tItlbugLZdPChXrgAonpUxfNbiFJ2VsakXUM3/cnHkjzz1YmpwKRw5/j/yvlheGMPZbsmZu8G
S1KG7r8137QLrINBbyiCTzza1pdpEjPvIzJmtg9+bIHXBtcI+eHLxy7vfAG2aIOSyIM7aF3/KvhC
Ar/Ol4LxB1Swi/Zq3e2aM/RSwP8F+KNa2/tlmXF8/fCSHQHW0lTClVnHluU38hkBsx6xYIOr5T0D
rvXFuhBS6zklpqZBrTmq3Jy75oWp5D2RmQixjSGhSqnX8c5sFqm8hOxDBcvVfxXg
--00000000000014cecb0610aa0991--

