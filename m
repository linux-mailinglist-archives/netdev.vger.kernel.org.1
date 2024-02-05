Return-Path: <netdev+bounces-69290-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E30384A952
	for <lists+netdev@lfdr.de>; Mon,  5 Feb 2024 23:32:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A32FF1C2552A
	for <lists+netdev@lfdr.de>; Mon,  5 Feb 2024 22:32:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECB59482D1;
	Mon,  5 Feb 2024 22:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="QhI8R56+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDED817EF
	for <netdev@vger.kernel.org>; Mon,  5 Feb 2024 22:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707172343; cv=none; b=ABTN4cAcwMJw6mT9l0v2zwjKTn/e0HlurqLF79TD+nnu5ASPPZBzphu1lJ3RdjyMECL4uZdO3q4VTeQGwL5yi5sKGWPDS4SEskBauNUBWUJ8lf3cF9IhvrbF45FdafL6hxBIVgn//FX46sxk/Xr4I3tcg/y+AhXhdlqCC66LeR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707172343; c=relaxed/simple;
	bh=WKra8p2fqYMlqtLSZoUFOtSyguXv13pjw2NH64rtT4o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=J410gcNhaLXFz1n5log69lwaczJEMkLQClFtq2Z99mS4tjJTr9MdpLQQOjfgMCBrMyeIMqsGhaMb5gM8Ollz3aThjJ/rlWFtZa1vWw0cu2J4AKM0Hxc6tmZwSXXw9Y6xnhm7DeGbLphEQPXatfxt0Aj6JOJzjt3plOqAb9cUsFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=QhI8R56+; arc=none smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-6e1352dd653so3216164a34.2
        for <netdev@vger.kernel.org>; Mon, 05 Feb 2024 14:32:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1707172341; x=1707777141; darn=vger.kernel.org;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=Uw4RFxhrxsRKs5AE2lrmv9T0z4jNi03EtnU+f4LrWOk=;
        b=QhI8R56+2WoYzAOtiEyf6wpTZkmIUkAtZtfOGKf5DbFJr01c1eS1LB5WoE+EkTmQcg
         o/NHe5Svv9Z131JNE/gz/6FdGnIAVc5QYSkygIjcOt1fJdgRhvIKJMiWdyvf/YltHNIo
         Q5mSk+ifspnBINHJ42AEvJcCrSrs32QbV7Z8o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707172341; x=1707777141;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Uw4RFxhrxsRKs5AE2lrmv9T0z4jNi03EtnU+f4LrWOk=;
        b=Mhr/cesScLZN+n/g5AonjxgSXE8NYxAqqJMPnDFYqzRNJRYNoSLt4A+t+qWgPt/R6l
         IUQTBg5J7Qzz/xt4L3/faHi0Ltj+0JVzx/VqTA724h3Jzl3DtN359Fwe7CXJn7UYry4g
         V2TPKZ0L42lUGpTazcbgHV5L7oyYStu+0puRgwRo9ay4rCU0gZxU6l7hr+gTvegmeIEn
         0tBjpruLAXBmsD1TqqHJ5PUVwboNTY77+Q6NqN8k0xD/Wy2RpZqjeVqCiZv/ShWK+z3C
         eqKZi8OcMwH+UmIOWRKFcwJWefAjz4cYeb5Hs6RTrZ2g0z1vwrl2XIGt09oB1M9A12y9
         ja+g==
X-Gm-Message-State: AOJu0YyTeU+CWijTdK8k+x7G25Xkw51krPYD2brmbblmHC6noMd4ucsB
	ZjFx+HtoEi5GC7iYHGk0ACJojvig5Y5JsZXvB/N+1GnA56NzMU5wtIuUwxoCVg==
X-Google-Smtp-Source: AGHT+IG9Upm+WQgNuq5FktZF9JERt4HIoEOKnrielwU4FWACtOVpIp4hGBWf8R33hjsY3Pj0Y3wc3A==
X-Received: by 2002:a05:6830:2011:b0:6e1:1492:3653 with SMTP id e17-20020a056830201100b006e114923653mr1075324otp.5.1707172340663;
        Mon, 05 Feb 2024 14:32:20 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWjoiagjpiFRvza9zItAeAWRfzCrVhBzy+Vnf/vTBrTDhy68Nlac1n9hCTHnCOoYz2TnVXDOdp8u5wNWqC9eqzrWuieiYf0KWcy2SKI9tkHbapTc2UV6bgx6UZWuI1m3rEksCjVlJ6odxBLYIAbshmo0rc4u0cjUn7eUisAc4JtNiDQOrKiTwqoJKgCmyYtgEGIPZ8JRGu7ZQfcv7BHLi9I8CfdrMVgTmB2EZoq+sLfW7rd2AOm6JfEhIG2
Received: from lvnvda5233.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id x11-20020ac8120b000000b0042c2d47d7fbsm340864qti.60.2024.02.05.14.32.19
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 05 Feb 2024 14:32:20 -0800 (PST)
From: Michael Chan <michael.chan@broadcom.com>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew.gospodarek@broadcom.com,
	pavan.chebbi@broadcom.com,
	Edwin Peer <edwin.peer@broadcom.com>
Subject: [PATCH net-next 04/13] bnxt_en: implement fully specified 5-tuple masks
Date: Mon,  5 Feb 2024 14:31:53 -0800
Message-Id: <20240205223202.25341-5-michael.chan@broadcom.com>
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
	boundary="000000000000f668e90610aa08b4"

--000000000000f668e90610aa08b4
Content-Transfer-Encoding: 8bit

From: Edwin Peer <edwin.peer@broadcom.com>

Support subfield masking for IP addresses and ports. Previously, only
entire fields could be included or excluded in NTUPLE filters.

Reviewed-by: Pavan Chebbi <pavan.chebbi@broadcom.com>
Signed-off-by: Edwin Peer <edwin.peer@broadcom.com>
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c     | 141 ++++++++++-------
 drivers/net/ethernet/broadcom/bnxt/bnxt.h     |  19 +--
 .../net/ethernet/broadcom/bnxt/bnxt_ethtool.c | 142 +++++-------------
 3 files changed, 134 insertions(+), 168 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index da298f4512b5..dc54cc0ab075 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -246,6 +246,49 @@ static const u16 bnxt_async_events_arr[] = {
 
 static struct workqueue_struct *bnxt_pf_wq;
 
+#define BNXT_IPV6_MASK_ALL {{{ 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, \
+			       0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff }}}
+#define BNXT_IPV6_MASK_NONE {{{ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 }}}
+
+const struct bnxt_flow_masks BNXT_FLOW_MASK_NONE = {
+	.ports = {
+		.src = 0,
+		.dst = 0,
+	},
+	.addrs = {
+		.v6addrs = {
+			.src = BNXT_IPV6_MASK_NONE,
+			.dst = BNXT_IPV6_MASK_NONE,
+		},
+	},
+};
+
+const struct bnxt_flow_masks BNXT_FLOW_IPV6_MASK_ALL = {
+	.ports = {
+		.src = cpu_to_be16(0xffff),
+		.dst = cpu_to_be16(0xffff),
+	},
+	.addrs = {
+		.v6addrs = {
+			.src = BNXT_IPV6_MASK_ALL,
+			.dst = BNXT_IPV6_MASK_ALL,
+		},
+	},
+};
+
+const struct bnxt_flow_masks BNXT_FLOW_IPV4_MASK_ALL = {
+	.ports = {
+		.src = cpu_to_be16(0xffff),
+		.dst = cpu_to_be16(0xffff),
+	},
+	.addrs = {
+		.v4addrs = {
+			.src = cpu_to_be32(0xffffffff),
+			.dst = cpu_to_be32(0xffffffff),
+		},
+	},
+};
+
 static bool bnxt_vf_pciid(enum board_idx idx)
 {
 	return (idx == NETXTREME_C_VF || idx == NETXTREME_E_VF ||
@@ -5690,6 +5733,7 @@ int bnxt_hwrm_cfa_ntuple_filter_alloc(struct bnxt *bp,
 {
 	struct hwrm_cfa_ntuple_filter_alloc_output *resp;
 	struct hwrm_cfa_ntuple_filter_alloc_input *req;
+	struct bnxt_flow_masks *masks = &fltr->fmasks;
 	struct flow_keys *keys = &fltr->fkeys;
 	struct bnxt_l2_filter *l2_fltr;
 	struct bnxt_vnic_info *vnic;
@@ -5722,25 +5766,15 @@ int bnxt_hwrm_cfa_ntuple_filter_alloc(struct bnxt *bp,
 		req->ethertype = htons(ETH_P_IPV6);
 		req->ip_addr_type =
 			CFA_NTUPLE_FILTER_ALLOC_REQ_IP_ADDR_TYPE_IPV6;
-		if (fltr->ntuple_flags & BNXT_NTUPLE_MATCH_SRC_IP) {
-			*(struct in6_addr *)&req->src_ipaddr[0] =
-				keys->addrs.v6addrs.src;
-			bnxt_fill_ipv6_mask(req->src_ipaddr_mask);
-		}
-		if (fltr->ntuple_flags & BNXT_NTUPLE_MATCH_DST_IP) {
-			*(struct in6_addr *)&req->dst_ipaddr[0] =
-				keys->addrs.v6addrs.dst;
-			bnxt_fill_ipv6_mask(req->dst_ipaddr_mask);
-		}
+		*(struct in6_addr *)&req->src_ipaddr[0] = keys->addrs.v6addrs.src;
+		*(struct in6_addr *)&req->src_ipaddr_mask[0] = masks->addrs.v6addrs.src;
+		*(struct in6_addr *)&req->dst_ipaddr[0] = keys->addrs.v6addrs.dst;
+		*(struct in6_addr *)&req->dst_ipaddr_mask[0] = masks->addrs.v6addrs.dst;
 	} else {
-		if (fltr->ntuple_flags & BNXT_NTUPLE_MATCH_SRC_IP) {
-			req->src_ipaddr[0] = keys->addrs.v4addrs.src;
-			req->src_ipaddr_mask[0] = cpu_to_be32(0xffffffff);
-		}
-		if (fltr->ntuple_flags & BNXT_NTUPLE_MATCH_DST_IP) {
-			req->dst_ipaddr[0] = keys->addrs.v4addrs.dst;
-			req->dst_ipaddr_mask[0] = cpu_to_be32(0xffffffff);
-		}
+		req->src_ipaddr[0] = keys->addrs.v4addrs.src;
+		req->src_ipaddr_mask[0] = masks->addrs.v4addrs.src;
+		req->dst_ipaddr[0] = keys->addrs.v4addrs.dst;
+		req->dst_ipaddr_mask[0] = masks->addrs.v4addrs.dst;
 	}
 	if (keys->control.flags & FLOW_DIS_ENCAPSULATION) {
 		req->enables |= cpu_to_le32(BNXT_NTP_TUNNEL_FLTR_FLAG);
@@ -5748,14 +5782,10 @@ int bnxt_hwrm_cfa_ntuple_filter_alloc(struct bnxt *bp,
 			CFA_NTUPLE_FILTER_ALLOC_REQ_TUNNEL_TYPE_ANYTUNNEL;
 	}
 
-	if (fltr->ntuple_flags & BNXT_NTUPLE_MATCH_SRC_PORT) {
-		req->src_port = keys->ports.src;
-		req->src_port_mask = cpu_to_be16(0xffff);
-	}
-	if (fltr->ntuple_flags & BNXT_NTUPLE_MATCH_DST_PORT) {
-		req->dst_port = keys->ports.dst;
-		req->dst_port_mask = cpu_to_be16(0xffff);
-	}
+	req->src_port = keys->ports.src;
+	req->src_port_mask = masks->ports.src;
+	req->dst_port = keys->ports.dst;
+	req->dst_port_mask = masks->ports.dst;
 
 	resp = hwrm_req_hold(bp, req);
 	rc = hwrm_req_send(bp, req);
@@ -13955,45 +13985,39 @@ int bnxt_insert_ntp_filter(struct bnxt *bp, struct bnxt_ntuple_filter *fltr,
 static bool bnxt_fltr_match(struct bnxt_ntuple_filter *f1,
 			    struct bnxt_ntuple_filter *f2)
 {
+	struct bnxt_flow_masks *masks1 = &f1->fmasks;
+	struct bnxt_flow_masks *masks2 = &f2->fmasks;
 	struct flow_keys *keys1 = &f1->fkeys;
 	struct flow_keys *keys2 = &f2->fkeys;
 
-	if (f1->ntuple_flags != f2->ntuple_flags)
-		return false;
-
 	if (keys1->basic.n_proto != keys2->basic.n_proto ||
 	    keys1->basic.ip_proto != keys2->basic.ip_proto)
 		return false;
 
 	if (keys1->basic.n_proto == htons(ETH_P_IP)) {
-		if (((f1->ntuple_flags & BNXT_NTUPLE_MATCH_SRC_IP) &&
-		     keys1->addrs.v4addrs.src != keys2->addrs.v4addrs.src) ||
-		    ((f1->ntuple_flags & BNXT_NTUPLE_MATCH_DST_IP) &&
-		     keys1->addrs.v4addrs.dst != keys2->addrs.v4addrs.dst))
+		if (keys1->addrs.v4addrs.src != keys2->addrs.v4addrs.src ||
+		    masks1->addrs.v4addrs.src != masks2->addrs.v4addrs.src ||
+		    keys1->addrs.v4addrs.dst != keys2->addrs.v4addrs.dst ||
+		    masks1->addrs.v4addrs.dst != masks2->addrs.v4addrs.dst)
 			return false;
 	} else {
-		if (((f1->ntuple_flags & BNXT_NTUPLE_MATCH_SRC_IP) &&
-		     memcmp(&keys1->addrs.v6addrs.src,
-			    &keys2->addrs.v6addrs.src,
-			    sizeof(keys1->addrs.v6addrs.src))) ||
-		    ((f1->ntuple_flags & BNXT_NTUPLE_MATCH_DST_IP) &&
-		     memcmp(&keys1->addrs.v6addrs.dst,
-			    &keys2->addrs.v6addrs.dst,
-			    sizeof(keys1->addrs.v6addrs.dst))))
+		if (!ipv6_addr_equal(&keys1->addrs.v6addrs.src,
+				     &keys2->addrs.v6addrs.src) ||
+		    !ipv6_addr_equal(&masks1->addrs.v6addrs.src,
+				     &masks2->addrs.v6addrs.src) ||
+		    !ipv6_addr_equal(&keys1->addrs.v6addrs.dst,
+				     &keys2->addrs.v6addrs.dst) ||
+		    !ipv6_addr_equal(&masks1->addrs.v6addrs.dst,
+				     &masks2->addrs.v6addrs.dst))
 			return false;
 	}
 
-	if (((f1->ntuple_flags & BNXT_NTUPLE_MATCH_SRC_PORT) &&
-	     keys1->ports.src != keys2->ports.src) ||
-	    ((f1->ntuple_flags & BNXT_NTUPLE_MATCH_DST_PORT) &&
-	     keys1->ports.dst != keys2->ports.dst))
-		return false;
-
-	if (keys1->control.flags == keys2->control.flags &&
-	    f1->l2_fltr == f2->l2_fltr)
-		return true;
-
-	return false;
+	return keys1->ports.src == keys2->ports.src &&
+	       masks1->ports.src == masks2->ports.src &&
+	       keys1->ports.dst == keys2->ports.dst &&
+	       masks1->ports.dst == masks2->ports.dst &&
+	       keys1->control.flags == keys2->control.flags &&
+	       f1->l2_fltr == f2->l2_fltr;
 }
 
 struct bnxt_ntuple_filter *
@@ -14058,10 +14082,13 @@ static int bnxt_rx_flow_steer(struct net_device *dev, const struct sk_buff *skb,
 		rc = -EPROTONOSUPPORT;
 		goto err_free;
 	}
-	if (fkeys->basic.n_proto == htons(ETH_P_IPV6) &&
-	    bp->hwrm_spec_code < 0x10601) {
-		rc = -EPROTONOSUPPORT;
-		goto err_free;
+	new_fltr->fmasks = BNXT_FLOW_IPV4_MASK_ALL;
+	if (fkeys->basic.n_proto == htons(ETH_P_IPV6)) {
+		if (bp->hwrm_spec_code < 0x10601) {
+			rc = -EPROTONOSUPPORT;
+			goto err_free;
+		}
+		new_fltr->fmasks = BNXT_FLOW_IPV6_MASK_ALL;
 	}
 	flags = fkeys->control.flags;
 	if (((flags & FLOW_DIS_ENCAPSULATION) &&
@@ -14069,9 +14096,7 @@ static int bnxt_rx_flow_steer(struct net_device *dev, const struct sk_buff *skb,
 		rc = -EPROTONOSUPPORT;
 		goto err_free;
 	}
-
 	new_fltr->l2_fltr = l2_fltr;
-	new_fltr->ntuple_flags = BNXT_NTUPLE_MATCH_ALL;
 
 	idx = bnxt_get_ntp_filter_idx(bp, fkeys, skb);
 	rcu_read_lock();
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.h b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
index 21721b8748bc..aae180fa63b7 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
@@ -1355,19 +1355,20 @@ struct bnxt_filter_base {
 	struct rcu_head         rcu;
 };
 
+struct bnxt_flow_masks {
+	struct flow_dissector_key_ports ports;
+	struct flow_dissector_key_addrs addrs;
+};
+
+extern const struct bnxt_flow_masks BNXT_FLOW_MASK_NONE;
+extern const struct bnxt_flow_masks BNXT_FLOW_IPV6_MASK_ALL;
+extern const struct bnxt_flow_masks BNXT_FLOW_IPV4_MASK_ALL;
+
 struct bnxt_ntuple_filter {
 	struct bnxt_filter_base	base;
 	struct flow_keys	fkeys;
+	struct bnxt_flow_masks	fmasks;
 	struct bnxt_l2_filter	*l2_fltr;
-	u32			ntuple_flags;
-#define BNXT_NTUPLE_MATCH_SRC_IP	1
-#define BNXT_NTUPLE_MATCH_DST_IP	2
-#define BNXT_NTUPLE_MATCH_SRC_PORT	4
-#define BNXT_NTUPLE_MATCH_DST_PORT	8
-#define BNXT_NTUPLE_MATCH_ALL		(BNXT_NTUPLE_MATCH_SRC_IP |	\
-					 BNXT_NTUPLE_MATCH_DST_IP |	\
-					 BNXT_NTUPLE_MATCH_SRC_PORT |	\
-					 BNXT_NTUPLE_MATCH_DST_PORT)
 	u32			flow_id;
 };
 
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
index 4d4dd2b231b8..b3fd32ff963a 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
@@ -1080,6 +1080,7 @@ static int bnxt_grxclsrule(struct bnxt *bp, struct ethtool_rxnfc *cmd)
 		(struct ethtool_rx_flow_spec *)&cmd->fs;
 	struct bnxt_filter_base *fltr_base;
 	struct bnxt_ntuple_filter *fltr;
+	struct bnxt_flow_masks *fmasks;
 	struct flow_keys *fkeys;
 	int rc = -EINVAL;
 
@@ -1127,6 +1128,7 @@ static int bnxt_grxclsrule(struct bnxt *bp, struct ethtool_rxnfc *cmd)
 	fltr = container_of(fltr_base, struct bnxt_ntuple_filter, base);
 
 	fkeys = &fltr->fkeys;
+	fmasks = &fltr->fmasks;
 	if (fkeys->basic.n_proto == htons(ETH_P_IP)) {
 		if (fkeys->basic.ip_proto == IPPROTO_TCP)
 			fs->flow_type = TCP_V4_FLOW;
@@ -1135,22 +1137,14 @@ static int bnxt_grxclsrule(struct bnxt *bp, struct ethtool_rxnfc *cmd)
 		else
 			goto fltr_err;
 
-		if (fltr->ntuple_flags & BNXT_NTUPLE_MATCH_SRC_IP) {
-			fs->h_u.tcp_ip4_spec.ip4src = fkeys->addrs.v4addrs.src;
-			fs->m_u.tcp_ip4_spec.ip4src = cpu_to_be32(~0);
-		}
-		if (fltr->ntuple_flags & BNXT_NTUPLE_MATCH_DST_IP) {
-			fs->h_u.tcp_ip4_spec.ip4dst = fkeys->addrs.v4addrs.dst;
-			fs->m_u.tcp_ip4_spec.ip4dst = cpu_to_be32(~0);
-		}
-		if (fltr->ntuple_flags & BNXT_NTUPLE_MATCH_SRC_PORT) {
-			fs->h_u.tcp_ip4_spec.psrc = fkeys->ports.src;
-			fs->m_u.tcp_ip4_spec.psrc = cpu_to_be16(~0);
-		}
-		if (fltr->ntuple_flags & BNXT_NTUPLE_MATCH_DST_PORT) {
-			fs->h_u.tcp_ip4_spec.pdst = fkeys->ports.dst;
-			fs->m_u.tcp_ip4_spec.pdst = cpu_to_be16(~0);
-		}
+		fs->h_u.tcp_ip4_spec.ip4src = fkeys->addrs.v4addrs.src;
+		fs->m_u.tcp_ip4_spec.ip4src = fmasks->addrs.v4addrs.src;
+		fs->h_u.tcp_ip4_spec.ip4dst = fkeys->addrs.v4addrs.dst;
+		fs->m_u.tcp_ip4_spec.ip4dst = fmasks->addrs.v4addrs.dst;
+		fs->h_u.tcp_ip4_spec.psrc = fkeys->ports.src;
+		fs->m_u.tcp_ip4_spec.psrc = fmasks->ports.src;
+		fs->h_u.tcp_ip4_spec.pdst = fkeys->ports.dst;
+		fs->m_u.tcp_ip4_spec.pdst = fmasks->ports.dst;
 	} else {
 		if (fkeys->basic.ip_proto == IPPROTO_TCP)
 			fs->flow_type = TCP_V6_FLOW;
@@ -1159,24 +1153,18 @@ static int bnxt_grxclsrule(struct bnxt *bp, struct ethtool_rxnfc *cmd)
 		else
 			goto fltr_err;
 
-		if (fltr->ntuple_flags & BNXT_NTUPLE_MATCH_SRC_IP) {
-			*(struct in6_addr *)&fs->h_u.tcp_ip6_spec.ip6src[0] =
-				fkeys->addrs.v6addrs.src;
-			bnxt_fill_ipv6_mask(fs->m_u.tcp_ip6_spec.ip6src);
-		}
-		if (fltr->ntuple_flags & BNXT_NTUPLE_MATCH_DST_IP) {
-			*(struct in6_addr *)&fs->h_u.tcp_ip6_spec.ip6dst[0] =
-				fkeys->addrs.v6addrs.dst;
-			bnxt_fill_ipv6_mask(fs->m_u.tcp_ip6_spec.ip6dst);
-		}
-		if (fltr->ntuple_flags & BNXT_NTUPLE_MATCH_SRC_PORT) {
-			fs->h_u.tcp_ip6_spec.psrc = fkeys->ports.src;
-			fs->m_u.tcp_ip6_spec.psrc = cpu_to_be16(~0);
-		}
-		if (fltr->ntuple_flags & BNXT_NTUPLE_MATCH_DST_PORT) {
-			fs->h_u.tcp_ip6_spec.pdst = fkeys->ports.dst;
-			fs->m_u.tcp_ip6_spec.pdst = cpu_to_be16(~0);
-		}
+		*(struct in6_addr *)&fs->h_u.tcp_ip6_spec.ip6src[0] =
+			fkeys->addrs.v6addrs.src;
+		*(struct in6_addr *)&fs->m_u.tcp_ip6_spec.ip6src[0] =
+			fmasks->addrs.v6addrs.src;
+		*(struct in6_addr *)&fs->h_u.tcp_ip6_spec.ip6dst[0] =
+			fkeys->addrs.v6addrs.dst;
+		*(struct in6_addr *)&fs->m_u.tcp_ip6_spec.ip6dst[0] =
+			fmasks->addrs.v6addrs.dst;
+		fs->h_u.tcp_ip6_spec.psrc = fkeys->ports.src;
+		fs->m_u.tcp_ip6_spec.psrc = fmasks->ports.src;
+		fs->h_u.tcp_ip6_spec.pdst = fkeys->ports.dst;
+		fs->m_u.tcp_ip6_spec.pdst = fmasks->ports.dst;
 	}
 
 	fs->ring_cookie = fltr->base.rxq;
@@ -1240,19 +1228,6 @@ static int bnxt_add_l2_cls_rule(struct bnxt *bp,
 	return rc;
 }
 
-#define IPV4_ALL_MASK		((__force __be32)~0)
-#define L4_PORT_ALL_MASK	((__force __be16)~0)
-
-static bool ipv6_mask_is_full(__be32 mask[4])
-{
-	return (mask[0] & mask[1] & mask[2] & mask[3]) == IPV4_ALL_MASK;
-}
-
-static bool ipv6_mask_is_zero(__be32 mask[4])
-{
-	return !(mask[0] | mask[1] | mask[2] | mask[3]);
-}
-
 static int bnxt_add_ntuple_cls_rule(struct bnxt *bp,
 				    struct ethtool_rx_flow_spec *fs)
 {
@@ -1260,6 +1235,7 @@ static int bnxt_add_ntuple_cls_rule(struct bnxt *bp,
 	u32 ring = ethtool_get_flow_spec_ring(fs->ring_cookie);
 	struct bnxt_ntuple_filter *new_fltr, *fltr;
 	struct bnxt_l2_filter *l2_fltr;
+	struct bnxt_flow_masks *fmasks;
 	u32 flow_type = fs->flow_type;
 	struct flow_keys *fkeys;
 	u32 idx;
@@ -1278,6 +1254,7 @@ static int bnxt_add_ntuple_cls_rule(struct bnxt *bp,
 	l2_fltr = bp->vnic_info[0].l2_filters[0];
 	atomic_inc(&l2_fltr->refcnt);
 	new_fltr->l2_fltr = l2_fltr;
+	fmasks = &new_fltr->fmasks;
 	fkeys = &new_fltr->fkeys;
 
 	rc = -EOPNOTSUPP;
@@ -1291,32 +1268,14 @@ static int bnxt_add_ntuple_cls_rule(struct bnxt *bp,
 		if (flow_type == UDP_V4_FLOW)
 			fkeys->basic.ip_proto = IPPROTO_UDP;
 		fkeys->basic.n_proto = htons(ETH_P_IP);
-
-		if (ip_mask->ip4src == IPV4_ALL_MASK) {
-			fkeys->addrs.v4addrs.src = ip_spec->ip4src;
-			new_fltr->ntuple_flags |= BNXT_NTUPLE_MATCH_SRC_IP;
-		} else if (ip_mask->ip4src) {
-			goto ntuple_err;
-		}
-		if (ip_mask->ip4dst == IPV4_ALL_MASK) {
-			fkeys->addrs.v4addrs.dst = ip_spec->ip4dst;
-			new_fltr->ntuple_flags |= BNXT_NTUPLE_MATCH_DST_IP;
-		} else if (ip_mask->ip4dst) {
-			goto ntuple_err;
-		}
-
-		if (ip_mask->psrc == L4_PORT_ALL_MASK) {
-			fkeys->ports.src = ip_spec->psrc;
-			new_fltr->ntuple_flags |= BNXT_NTUPLE_MATCH_SRC_PORT;
-		} else if (ip_mask->psrc) {
-			goto ntuple_err;
-		}
-		if (ip_mask->pdst == L4_PORT_ALL_MASK) {
-			fkeys->ports.dst = ip_spec->pdst;
-			new_fltr->ntuple_flags |= BNXT_NTUPLE_MATCH_DST_PORT;
-		} else if (ip_mask->pdst) {
-			goto ntuple_err;
-		}
+		fkeys->addrs.v4addrs.src = ip_spec->ip4src;
+		fmasks->addrs.v4addrs.src = ip_mask->ip4src;
+		fkeys->addrs.v4addrs.dst = ip_spec->ip4dst;
+		fmasks->addrs.v4addrs.dst = ip_mask->ip4dst;
+		fkeys->ports.src = ip_spec->psrc;
+		fmasks->ports.src = ip_mask->psrc;
+		fkeys->ports.dst = ip_spec->pdst;
+		fmasks->ports.dst = ip_mask->pdst;
 		break;
 	}
 	case TCP_V6_FLOW:
@@ -1329,40 +1288,21 @@ static int bnxt_add_ntuple_cls_rule(struct bnxt *bp,
 			fkeys->basic.ip_proto = IPPROTO_UDP;
 		fkeys->basic.n_proto = htons(ETH_P_IPV6);
 
-		if (ipv6_mask_is_full(ip_mask->ip6src)) {
-			fkeys->addrs.v6addrs.src =
-				*(struct in6_addr *)&ip_spec->ip6src;
-			new_fltr->ntuple_flags |= BNXT_NTUPLE_MATCH_SRC_IP;
-		} else if (!ipv6_mask_is_zero(ip_mask->ip6src)) {
-			goto ntuple_err;
-		}
-		if (ipv6_mask_is_full(ip_mask->ip6dst)) {
-			fkeys->addrs.v6addrs.dst =
-				*(struct in6_addr *)&ip_spec->ip6dst;
-			new_fltr->ntuple_flags |= BNXT_NTUPLE_MATCH_DST_IP;
-		} else if (!ipv6_mask_is_zero(ip_mask->ip6dst)) {
-			goto ntuple_err;
-		}
-
-		if (ip_mask->psrc == L4_PORT_ALL_MASK) {
-			fkeys->ports.src = ip_spec->psrc;
-			new_fltr->ntuple_flags |= BNXT_NTUPLE_MATCH_SRC_PORT;
-		} else if (ip_mask->psrc) {
-			goto ntuple_err;
-		}
-		if (ip_mask->pdst == L4_PORT_ALL_MASK) {
-			fkeys->ports.dst = ip_spec->pdst;
-			new_fltr->ntuple_flags |= BNXT_NTUPLE_MATCH_DST_PORT;
-		} else if (ip_mask->pdst) {
-			goto ntuple_err;
-		}
+		fkeys->addrs.v6addrs.src = *(struct in6_addr *)&ip_spec->ip6src;
+		fmasks->addrs.v6addrs.src = *(struct in6_addr *)&ip_mask->ip6src;
+		fkeys->addrs.v6addrs.dst = *(struct in6_addr *)&ip_spec->ip6dst;
+		fmasks->addrs.v6addrs.dst = *(struct in6_addr *)&ip_mask->ip6dst;
+		fkeys->ports.src = ip_spec->psrc;
+		fmasks->ports.src = ip_mask->psrc;
+		fkeys->ports.dst = ip_spec->pdst;
+		fmasks->ports.dst = ip_mask->pdst;
 		break;
 	}
 	default:
 		rc = -EOPNOTSUPP;
 		goto ntuple_err;
 	}
-	if (!new_fltr->ntuple_flags)
+	if (!memcmp(&BNXT_FLOW_MASK_NONE, fmasks, sizeof(*fmasks)))
 		goto ntuple_err;
 
 	idx = bnxt_get_ntp_filter_idx(bp, fkeys, NULL);
-- 
2.30.1


--000000000000f668e90610aa08b4
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
DQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEILPxfqNt8hazUT/B2LEWKn5qvc6psKf2
dkwip/Ytpdc6MBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI0MDIw
NTIyMzIyMVowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCG
SAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQC
ATANBgkqhkiG9w0BAQEFAASCAQAB4F4dhR55pR48UIehnLfbc9jzL2Ff6EOYhLhg6Bg8Nqguuqi1
JKslwgFEKzoflG4R1lZrYZ7pESsj5PyCTpYK5qOvBll4GiY2h2vKQ1LGGRzzum2sAr3JLZFl2+v2
NcTA0i06WqkhO/W+fe/KlY4O8LLXxGdix3p3u5x2YtcYboi8klzHYHqX2bZzvAU0u/EUT3/CJOvh
xGxsfEHdx//WEQYNa6o/8JHdMRCFIgnl6KwdxtWiL7/kab0WiHP59z+sSZznmV6RL23vyEJvuDBj
T6FFYXWr79T9oJU2fQFtxOhjOuT+ENxkPKUQHjPXEGcfIKhK/7CYW8LZfEcdLqYo
--000000000000f668e90610aa08b4--

