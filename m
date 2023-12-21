Return-Path: <netdev+bounces-59801-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1722E81C0C3
	for <lists+netdev@lfdr.de>; Thu, 21 Dec 2023 23:04:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 836411F23E99
	for <lists+netdev@lfdr.de>; Thu, 21 Dec 2023 22:04:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3535F7996B;
	Thu, 21 Dec 2023 22:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="brBMn4+h"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 606247946F
	for <netdev@vger.kernel.org>; Thu, 21 Dec 2023 22:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-7812275feccso51904685a.3
        for <netdev@vger.kernel.org>; Thu, 21 Dec 2023 14:03:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1703196195; x=1703800995; darn=vger.kernel.org;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=dl1nCMP/IENAjGJAG4PO16xVzVSysXH7bwmdxo7nOag=;
        b=brBMn4+hKlFv+nIctJ+gJxUb4ZrAHdkzeYwVn7IhS4aaI+O+uFSvztRZEO2CDb2FIM
         a2UDbifgeYGIdhrHUD4pNaUxl/qgsBkLtmx4qxXs5gnateExNIdudhK0EROv5XjI1NT4
         SxUQ3ZZa7//Th8MKgDT2rnlhdDJPS5aEPGuiY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703196195; x=1703800995;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dl1nCMP/IENAjGJAG4PO16xVzVSysXH7bwmdxo7nOag=;
        b=RGz8J931PGilepCyyy1EB2EuODlgl2EBk5oVc59m39xJckW+3E98pgCdQzqJzbSlt/
         pT6B7/g/uiMhbSsUDZVKeEHbkCzzU+rgUKHWZwI3svQ+27O7AA2XQdUG1qUaYc6OPHvN
         3oyGkHIW2WHwAA2hiCYk7k4VRw07QOY44vevjoNHSlp1TZPwo9/I3RlS+NFZbGG/yHF7
         spUZh+UssagHcZ8oN/1b6B/H3C2qnAXLbDp3jtiM1f0sHF4dPXlIbT/idc2suyfRKMvw
         yxUCK4OzvtxA5e+Gls4wbICi7Ibb3ZTm8fVYdK+PDA/sdhqrAWtTMqY0K2lkaZyO1gvi
         Q5lg==
X-Gm-Message-State: AOJu0YzQaAyZMgVPISovPXQRNnftXkn5J9Jb3Bj2ndKTZq9Wu3FdgQhV
	bX5l7T+wzqvBBYTaNgn30Dojoxf4Ax9X7i1W6wWP2Z6r+g==
X-Google-Smtp-Source: AGHT+IGVpK8CJW3i7W7Xl68AaiRUo1qo2hdYPOatYKGr4N/ssOxNlgUKa5kF17KsishbsgKJAUpO9Q==
X-Received: by 2002:a05:6214:519c:b0:67f:6056:7dc5 with SMTP id kl28-20020a056214519c00b0067f60567dc5mr478612qvb.66.1703196195045;
        Thu, 21 Dec 2023 14:03:15 -0800 (PST)
Received: from lvnvda5233.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id ee14-20020a0562140a4e00b0067f712874fbsm905198qvb.129.2023.12.21.14.03.13
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Dec 2023 14:03:14 -0800 (PST)
From: Michael Chan <michael.chan@broadcom.com>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	pavan.chebbi@broadcom.com,
	andrew.gospodarek@broadcom.com
Subject: [PATCH net-next 11/13] bnxt_en: Add ntuple matching flags to the bnxt_ntuple_filter structure.
Date: Thu, 21 Dec 2023 14:02:16 -0800
Message-Id: <20231221220218.197386-12-michael.chan@broadcom.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20231221220218.197386-1-michael.chan@broadcom.com>
References: <20231221220218.197386-1-michael.chan@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000372f91060d0c449a"

--000000000000372f91060d0c449a
Content-Transfer-Encoding: 8bit

aRFS filters match all 5 tuples.  User defined ntuple filters may
specify some of the tuples as wildcards.  To support that, we add the
ntuple_flags to the bnxt_ntuple_filter struct to specify which tuple
fields are to be matched.  The matching tuple fields will then be
passed to the firmware in bnxt_hwrm_cfa_ntuple_filter_alloc() to create
the proper filter.

Reviewed-by: Vasundhara Volam <vasundhara-v.volam@broadcom.com>
Reviewed-by: Andy Gospodarek <andrew.gospodarek@broadcom.com>
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c     | 81 +++++++++++++------
 drivers/net/ethernet/broadcom/bnxt/bnxt.h     | 10 +++
 .../net/ethernet/broadcom/bnxt/bnxt_ethtool.c | 58 +++++++------
 3 files changed, 99 insertions(+), 50 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 1549a1e4edac..f9c7562ae619 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -5638,6 +5638,14 @@ int bnxt_hwrm_cfa_ntuple_filter_free(struct bnxt *bp,
 #define BNXT_NTP_TUNNEL_FLTR_FLAG				\
 		CFA_NTUPLE_FILTER_ALLOC_REQ_ENABLES_TUNNEL_TYPE
 
+void bnxt_fill_ipv6_mask(__be32 mask[4])
+{
+	int i;
+
+	for (i = 0; i < 4; i++)
+		mask[i] = cpu_to_be32(~0);
+}
+
 static int bnxt_hwrm_cfa_ntuple_filter_alloc(struct bnxt *bp,
 					     struct bnxt_ntuple_filter *fltr)
 {
@@ -5672,24 +5680,28 @@ static int bnxt_hwrm_cfa_ntuple_filter_alloc(struct bnxt *bp,
 	req->ip_protocol = keys->basic.ip_proto;
 
 	if (keys->basic.n_proto == htons(ETH_P_IPV6)) {
-		int i;
-
 		req->ethertype = htons(ETH_P_IPV6);
 		req->ip_addr_type =
 			CFA_NTUPLE_FILTER_ALLOC_REQ_IP_ADDR_TYPE_IPV6;
-		*(struct in6_addr *)&req->src_ipaddr[0] =
-			keys->addrs.v6addrs.src;
-		*(struct in6_addr *)&req->dst_ipaddr[0] =
-			keys->addrs.v6addrs.dst;
-		for (i = 0; i < 4; i++) {
-			req->src_ipaddr_mask[i] = cpu_to_be32(0xffffffff);
-			req->dst_ipaddr_mask[i] = cpu_to_be32(0xffffffff);
+		if (fltr->ntuple_flags & BNXT_NTUPLE_MATCH_SRC_IP) {
+			*(struct in6_addr *)&req->src_ipaddr[0] =
+				keys->addrs.v6addrs.src;
+			bnxt_fill_ipv6_mask(req->src_ipaddr_mask);
+		}
+		if (fltr->ntuple_flags & BNXT_NTUPLE_MATCH_DST_IP) {
+			*(struct in6_addr *)&req->dst_ipaddr[0] =
+				keys->addrs.v6addrs.dst;
+			bnxt_fill_ipv6_mask(req->dst_ipaddr_mask);
 		}
 	} else {
-		req->src_ipaddr[0] = keys->addrs.v4addrs.src;
-		req->src_ipaddr_mask[0] = cpu_to_be32(0xffffffff);
-		req->dst_ipaddr[0] = keys->addrs.v4addrs.dst;
-		req->dst_ipaddr_mask[0] = cpu_to_be32(0xffffffff);
+		if (fltr->ntuple_flags & BNXT_NTUPLE_MATCH_SRC_IP) {
+			req->src_ipaddr[0] = keys->addrs.v4addrs.src;
+			req->src_ipaddr_mask[0] = cpu_to_be32(0xffffffff);
+		}
+		if (fltr->ntuple_flags & BNXT_NTUPLE_MATCH_DST_IP) {
+			req->dst_ipaddr[0] = keys->addrs.v4addrs.dst;
+			req->dst_ipaddr_mask[0] = cpu_to_be32(0xffffffff);
+		}
 	}
 	if (keys->control.flags & FLOW_DIS_ENCAPSULATION) {
 		req->enables |= cpu_to_le32(BNXT_NTP_TUNNEL_FLTR_FLAG);
@@ -5697,10 +5709,14 @@ static int bnxt_hwrm_cfa_ntuple_filter_alloc(struct bnxt *bp,
 			CFA_NTUPLE_FILTER_ALLOC_REQ_TUNNEL_TYPE_ANYTUNNEL;
 	}
 
-	req->src_port = keys->ports.src;
-	req->src_port_mask = cpu_to_be16(0xffff);
-	req->dst_port = keys->ports.dst;
-	req->dst_port_mask = cpu_to_be16(0xffff);
+	if (fltr->ntuple_flags & BNXT_NTUPLE_MATCH_SRC_PORT) {
+		req->src_port = keys->ports.src;
+		req->src_port_mask = cpu_to_be16(0xffff);
+	}
+	if (fltr->ntuple_flags & BNXT_NTUPLE_MATCH_DST_PORT) {
+		req->dst_port = keys->ports.dst;
+		req->dst_port_mask = cpu_to_be16(0xffff);
+	}
 
 	resp = hwrm_req_hold(bp, req);
 	rc = hwrm_req_send(bp, req);
@@ -13882,24 +13898,38 @@ static bool bnxt_fltr_match(struct bnxt_ntuple_filter *f1,
 	struct flow_keys *keys1 = &f1->fkeys;
 	struct flow_keys *keys2 = &f2->fkeys;
 
+	if (f1->ntuple_flags != f2->ntuple_flags)
+		return false;
+
 	if (keys1->basic.n_proto != keys2->basic.n_proto ||
 	    keys1->basic.ip_proto != keys2->basic.ip_proto)
 		return false;
 
 	if (keys1->basic.n_proto == htons(ETH_P_IP)) {
-		if (keys1->addrs.v4addrs.src != keys2->addrs.v4addrs.src ||
-		    keys1->addrs.v4addrs.dst != keys2->addrs.v4addrs.dst)
+		if (((f1->ntuple_flags & BNXT_NTUPLE_MATCH_SRC_IP) &&
+		     keys1->addrs.v4addrs.src != keys2->addrs.v4addrs.src) ||
+		    ((f1->ntuple_flags & BNXT_NTUPLE_MATCH_DST_IP) &&
+		     keys1->addrs.v4addrs.dst != keys2->addrs.v4addrs.dst))
 			return false;
 	} else {
-		if (memcmp(&keys1->addrs.v6addrs.src, &keys2->addrs.v6addrs.src,
-			   sizeof(keys1->addrs.v6addrs.src)) ||
-		    memcmp(&keys1->addrs.v6addrs.dst, &keys2->addrs.v6addrs.dst,
-			   sizeof(keys1->addrs.v6addrs.dst)))
+		if (((f1->ntuple_flags & BNXT_NTUPLE_MATCH_SRC_IP) &&
+		     memcmp(&keys1->addrs.v6addrs.src,
+			    &keys2->addrs.v6addrs.src,
+			    sizeof(keys1->addrs.v6addrs.src))) ||
+		    ((f1->ntuple_flags & BNXT_NTUPLE_MATCH_DST_IP) &&
+		     memcmp(&keys1->addrs.v6addrs.dst,
+			    &keys2->addrs.v6addrs.dst,
+			    sizeof(keys1->addrs.v6addrs.dst))))
 			return false;
 	}
 
-	if (keys1->ports.ports == keys2->ports.ports &&
-	    keys1->control.flags == keys2->control.flags &&
+	if (((f1->ntuple_flags & BNXT_NTUPLE_MATCH_SRC_PORT) &&
+	     keys1->ports.src != keys2->ports.src) ||
+	    ((f1->ntuple_flags & BNXT_NTUPLE_MATCH_DST_PORT) &&
+	     keys1->ports.dst != keys2->ports.dst))
+		return false;
+
+	if (keys1->control.flags == keys2->control.flags &&
 	    f1->l2_fltr == f2->l2_fltr)
 		return true;
 
@@ -13981,6 +14011,7 @@ static int bnxt_rx_flow_steer(struct net_device *dev, const struct sk_buff *skb,
 	}
 
 	new_fltr->l2_fltr = l2_fltr;
+	new_fltr->ntuple_flags = BNXT_NTUPLE_MATCH_ALL;
 
 	idx = bnxt_get_ntp_filter_idx(bp, fkeys, skb);
 	rcu_read_lock();
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.h b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
index 60f62bc36d2c..dc1bc163c82f 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
@@ -1358,6 +1358,15 @@ struct bnxt_ntuple_filter {
 	struct bnxt_filter_base	base;
 	struct flow_keys	fkeys;
 	struct bnxt_l2_filter	*l2_fltr;
+	u32			ntuple_flags;
+#define BNXT_NTUPLE_MATCH_SRC_IP	1
+#define BNXT_NTUPLE_MATCH_DST_IP	2
+#define BNXT_NTUPLE_MATCH_SRC_PORT	4
+#define BNXT_NTUPLE_MATCH_DST_PORT	8
+#define BNXT_NTUPLE_MATCH_ALL		(BNXT_NTUPLE_MATCH_SRC_IP |	\
+					 BNXT_NTUPLE_MATCH_DST_IP |	\
+					 BNXT_NTUPLE_MATCH_SRC_PORT |	\
+					 BNXT_NTUPLE_MATCH_DST_PORT)
 	u32			flow_id;
 };
 
@@ -2638,6 +2647,7 @@ int bnxt_hwrm_l2_filter_free(struct bnxt *bp, struct bnxt_l2_filter *fltr);
 int bnxt_hwrm_l2_filter_alloc(struct bnxt *bp, struct bnxt_l2_filter *fltr);
 int bnxt_hwrm_cfa_ntuple_filter_free(struct bnxt *bp,
 				     struct bnxt_ntuple_filter *fltr);
+void bnxt_fill_ipv6_mask(__be32 mask[4]);
 int bnxt_get_nr_rss_ctxs(struct bnxt *bp, int rx_rings);
 int bnxt_hwrm_vnic_cfg(struct bnxt *bp, u16 vnic_id);
 int __bnxt_hwrm_get_tx_rings(struct bnxt *bp, u16 fid, int *tx_rings);
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
index 8cc762a12a3e..558dd1f9a18e 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
@@ -1100,20 +1100,23 @@ static int bnxt_grxclsrule(struct bnxt *bp, struct ethtool_rxnfc *cmd)
 		else
 			goto fltr_err;
 
-		fs->h_u.tcp_ip4_spec.ip4src = fkeys->addrs.v4addrs.src;
-		fs->m_u.tcp_ip4_spec.ip4src = cpu_to_be32(~0);
-
-		fs->h_u.tcp_ip4_spec.ip4dst = fkeys->addrs.v4addrs.dst;
-		fs->m_u.tcp_ip4_spec.ip4dst = cpu_to_be32(~0);
-
-		fs->h_u.tcp_ip4_spec.psrc = fkeys->ports.src;
-		fs->m_u.tcp_ip4_spec.psrc = cpu_to_be16(~0);
-
-		fs->h_u.tcp_ip4_spec.pdst = fkeys->ports.dst;
-		fs->m_u.tcp_ip4_spec.pdst = cpu_to_be16(~0);
+		if (fltr->ntuple_flags & BNXT_NTUPLE_MATCH_SRC_IP) {
+			fs->h_u.tcp_ip4_spec.ip4src = fkeys->addrs.v4addrs.src;
+			fs->m_u.tcp_ip4_spec.ip4src = cpu_to_be32(~0);
+		}
+		if (fltr->ntuple_flags & BNXT_NTUPLE_MATCH_DST_IP) {
+			fs->h_u.tcp_ip4_spec.ip4dst = fkeys->addrs.v4addrs.dst;
+			fs->m_u.tcp_ip4_spec.ip4dst = cpu_to_be32(~0);
+		}
+		if (fltr->ntuple_flags & BNXT_NTUPLE_MATCH_SRC_PORT) {
+			fs->h_u.tcp_ip4_spec.psrc = fkeys->ports.src;
+			fs->m_u.tcp_ip4_spec.psrc = cpu_to_be16(~0);
+		}
+		if (fltr->ntuple_flags & BNXT_NTUPLE_MATCH_DST_PORT) {
+			fs->h_u.tcp_ip4_spec.pdst = fkeys->ports.dst;
+			fs->m_u.tcp_ip4_spec.pdst = cpu_to_be16(~0);
+		}
 	} else {
-		int i;
-
 		if (fkeys->basic.ip_proto == IPPROTO_TCP)
 			fs->flow_type = TCP_V6_FLOW;
 		else if (fkeys->basic.ip_proto == IPPROTO_UDP)
@@ -1121,19 +1124,24 @@ static int bnxt_grxclsrule(struct bnxt *bp, struct ethtool_rxnfc *cmd)
 		else
 			goto fltr_err;
 
-		*(struct in6_addr *)&fs->h_u.tcp_ip6_spec.ip6src[0] =
-			fkeys->addrs.v6addrs.src;
-		*(struct in6_addr *)&fs->h_u.tcp_ip6_spec.ip6dst[0] =
-			fkeys->addrs.v6addrs.dst;
-		for (i = 0; i < 4; i++) {
-			fs->m_u.tcp_ip6_spec.ip6src[i] = cpu_to_be32(~0);
-			fs->m_u.tcp_ip6_spec.ip6dst[i] = cpu_to_be32(~0);
+		if (fltr->ntuple_flags & BNXT_NTUPLE_MATCH_SRC_IP) {
+			*(struct in6_addr *)&fs->h_u.tcp_ip6_spec.ip6src[0] =
+				fkeys->addrs.v6addrs.src;
+			bnxt_fill_ipv6_mask(fs->m_u.tcp_ip6_spec.ip6src);
+		}
+		if (fltr->ntuple_flags & BNXT_NTUPLE_MATCH_DST_IP) {
+			*(struct in6_addr *)&fs->h_u.tcp_ip6_spec.ip6dst[0] =
+				fkeys->addrs.v6addrs.dst;
+			bnxt_fill_ipv6_mask(fs->m_u.tcp_ip6_spec.ip6dst);
+		}
+		if (fltr->ntuple_flags & BNXT_NTUPLE_MATCH_SRC_PORT) {
+			fs->h_u.tcp_ip6_spec.psrc = fkeys->ports.src;
+			fs->m_u.tcp_ip6_spec.psrc = cpu_to_be16(~0);
+		}
+		if (fltr->ntuple_flags & BNXT_NTUPLE_MATCH_DST_PORT) {
+			fs->h_u.tcp_ip6_spec.pdst = fkeys->ports.dst;
+			fs->m_u.tcp_ip6_spec.pdst = cpu_to_be16(~0);
 		}
-		fs->h_u.tcp_ip6_spec.psrc = fkeys->ports.src;
-		fs->m_u.tcp_ip6_spec.psrc = cpu_to_be16(~0);
-
-		fs->h_u.tcp_ip6_spec.pdst = fkeys->ports.dst;
-		fs->m_u.tcp_ip6_spec.pdst = cpu_to_be16(~0);
 	}
 
 	fs->ring_cookie = fltr->base.rxq;
-- 
2.30.1


--000000000000372f91060d0c449a
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
DQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIGKCCK3Ax40Ey80DH/75oMMkVJmKHbtW
XVSApvXXPPOvMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTIzMTIy
MTIyMDMxNVowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCG
SAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQC
ATANBgkqhkiG9w0BAQEFAASCAQAkeBQG2jv0BRpFRlG2V6PhUth6H+uilfA2DWNV2cRI+vSQmBy7
ggK9S2UscIZtGShdY7E8jsrwxhm9oH2P5zeJKy5BLKVVAclL3wSjzuHexFHobKUx3yRUT9NqospZ
GoBImn4PjzHQUYrNZgwjZZYL4FPiTw1Nq+FoR7qpiw9zdOTDnTWrrK8U++6bxAYEVkMa5TF9jgHZ
nWoDyXiplFObtvcgjNjmfjUbgI1uFByH91fkOxH9ph1MrHQU+rojFF8ex0Hvm00gW+yCg845HkH2
2/2O4ikN63nX/74uVXL8faKwc76sw3vhK1bFAmSp0itFtb89I9ChWY7ZMmsat/B4
--000000000000372f91060d0c449a--

