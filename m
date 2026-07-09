Return-Path: <netdev+bounces-306052-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 7PMHB0FBT2recwIAu9opvQ
	(envelope-from <netdev+bounces-306052-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 09 Jul 2026 08:35:45 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A7A2E72D376
	for <lists+netdev@lfdr.de>; Thu, 09 Jul 2026 08:35:44 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b="lZZsMNO/";
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306052-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-306052-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CD2AE3065EDE
	for <lists+netdev@lfdr.de>; Thu,  9 Jul 2026 06:30:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DD2D3C4562;
	Thu,  9 Jul 2026 06:30:44 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B6883CDBBD
	for <netdev@vger.kernel.org>; Thu,  9 Jul 2026 06:30:42 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783578644; cv=none; b=rgTxEBYLBIT3NlHRlyfR3Q8z+EemTPc3BfbhkUrkw8+gy8nDex3nG7AWvzaH0Je5JI9VmZoMnt0hgMCEnhoJ+Kc0TnBHwFlAHJ4Ldf6FFwsrsXfLO4EmbsErdyZtjvHtxJHuI056NUr0HKqLsjkh+hTP8nwlZ8qCY90Eodo8PuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783578644; c=relaxed/simple;
	bh=7iyGFkX/KVZ2dRRCt8MLBEDmWyxHFZZgQiTUzgZCRpg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=UMFYRy4PUhAJQ0kZgxwKhyXYoVSuDuRHowswRiG3gwgOYUdM5zg41f+LPg+XwR1KGr6B50Tt+ID07wXWUZl80zTlKYe3mkC+cXKIh5oM/d711LmJLADJJ+e0wpFeEkgbQtISfFrYxrsF7yrWNp/XMsUfPQXiXRDdl2doJmJGRuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lZZsMNO/; arc=none smtp.client-ip=209.85.210.181
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-84347ad88edso2049340b3a.1
        for <netdev@vger.kernel.org>; Wed, 08 Jul 2026 23:30:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783578642; x=1784183442; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=3gd7QqaANUrhoi2BRtAEvQ24FdV1dl/9cG/AY/sVUI8=;
        b=lZZsMNO/C6c8nDY3sq5qNnSjYrxMChPpyH5HkVNaFwa1HUrh26K6qlPzNf5Dvp8PTw
         jx3jQw+ARDbqsGxxOQmq60yzdatadXHyy2sUVgpxXT0zQ70H5R++0CxHvgix+MncdjFW
         Kg1ktLhamaTqrv3XZezZUb5R9TiHm3rumqrhKnSj8vj1QkalX4TeNVyQzrBOYwoyBlMv
         iS00G9BlexdMad2wbzW47AAShbCFsl2n2Vg2rYSZN4FxB30y9JTY92q+4AE5bFy/bV5e
         2Ixke3ngtnBGR8sedmL6zIHx64NhsCHkFAq159XCJ44IUq8eqrwhIxOAPG0rB9n/K0Eu
         NWoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783578642; x=1784183442;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3gd7QqaANUrhoi2BRtAEvQ24FdV1dl/9cG/AY/sVUI8=;
        b=UArS/IIhLXIVvNt9NsrHncmVio61sG29ewGOW0gPb/me1BqrZPr0YsAuRYj0WdBt4d
         boEUJIrVSZqV3V8oK/sTj4QRPhZLmh0RJ6dXdEcwsKGmeLkAok9whk+/B97qzOmTa6fN
         60Aer7GNjOfb5ePtJvLVQBrQrxBYkYurznZn1yVFlqvyGEJN8ZXPWAc+WoNc+bD+PXXx
         fIT3BAvlXwm30tav+iSgQjlU31qcw8QC1IQgaOP2kf5t9OWcIFu+3/HqDL+GYAPZ3pXV
         4eYX6EIjZtTEOyQIgsmoa/ke/bDHF6jE6KmMTY7x3/I95GhtJ6374PZC2manwb8lSg5i
         1aqg==
X-Forwarded-Encrypted: i=1; AHgh+RqyvovMdH7E6M/nGzVbMAnPlwtVqT9V7hT7Yvb82dlctVAB8iEJ+VHI3IDD+tC1VM7gGcfZL68=@vger.kernel.org
X-Gm-Message-State: AOJu0YyvW2MQaiVO6+EEw1xduQEmvlCPs03Lq//dfy9rb2i1LxmwgPlA
	wKdiCq4ycH1S++zWpgF049b/v8b/CgGdzE5LDTzaklVjM71tV2nNKzeh
X-Gm-Gg: AfdE7ckm4W70hO9VpL8WnRWwF5sSz+vgfRIQHfcapw0NNXuylZAgUOteBCG5c9DPb4N
	munz9K98jVcpuHuYSnq2csip0FL0nmG/3ld8AQXqau+25WDGcISm+AAe7gdqzYRX9IotW1t6My8
	KDzDdPFEqMZ5dLi/eapB+wqHzJqQ1RBLrfwXKHbkYZVXLCsWkifD4kuitDuxO37+n59Nr0riYLV
	KSPlaKSyePgAGGCw7MIxCxtlJFnFLahmCreJf+9V3TWQm6cmSYHlrEyTYX8KHCfPjlkWKmS9EAY
	YYaDVAmHhp/hWC93IAjYMy/Ad1NYC5Tx+p4Jg8f0LdaiCdBYpZaTyjwmeCnPZ6LLWMZg/s+Xurt
	c+xWU1Tt+ncgIGXxK7rFQXI7bHDfhVOxYmcec6a6RIgOPnOxgrrtjob579V/XHmMY2jK69Pm7gl
	tq59gBofyxhJBcsH2nwaH32w==
X-Received: by 2002:a05:6a00:3486:b0:848:2f77:e2dd with SMTP id d2e1a72fcca58-8484392ec4emr5740542b3a.70.1783578641852;
        Wed, 08 Jul 2026 23:30:41 -0700 (PDT)
Received: from c79home.localdomain ([14.127.26.222])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-847f6b9e12csm8087708b3a.21.2026.07.08.23.30.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2026 23:30:40 -0700 (PDT)
From: Zhixing Chen <running910@gmail.com>
To: Florian Westphal <fw@strlen.de>,
	Pablo Neira Ayuso <pablo@netfilter.org>
Cc: Phil Sutter <phil@nwl.cc>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org,
	netdev@vger.kernel.org,
	Zhixing Chen <running910@gmail.com>
Subject: [PATCH nf] netfilter: ip6tables: set hotdrop for malformed extension header matches
Date: Thu,  9 Jul 2026 14:30:12 +0800
Message-Id: <20260709063012.33160-1-running910@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[nwl.cc,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,netfilter.org,gmail.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-306052-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:fw@strlen.de,m:pablo@netfilter.org,m:phil@nwl.cc,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:netfilter-devel@vger.kernel.org,m:coreteam@netfilter.org,m:netdev@vger.kernel.org,m:running910@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[running910@gmail.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[running910@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A7A2E72D376

The hbh, srh and ipv6header matches have paths that return false for
malformed IPv6 extension header packets without setting hotdrop.

For hbh, strict option parsing stops when the option type or length field
cannot be read, or when advancing to the next requested option would
exceed the available header data. Mark these packets for hotdrop instead
of treating them as a rule mismatch.

For srh, keep a missing SRH as a normal mismatch, but set hotdrop when
header lookup fails for other reasons, when the SRH fixed header is not
present, when the advertised SRH length exceeds the available skb data, or
when SID selector reads fail.

For ipv6header, set hotdrop when the next extension header is not fully
present or when the advertised extension header length exceeds the
available skb data.

Returning false treats the packet as a rule mismatch. Set hotdrop for
these malformed packets so they cannot bypass rules intended to drop
packets with these IPv6 extension headers.

Signed-off-by: Zhixing Chen <running910@gmail.com>
---

This is a follow-up to the previous IPv6 extension header hotdrop fix:
https://lore.kernel.org/netfilter-devel/20260703125709.16493-6-fw@strlen.de/

---
 net/ipv6/netfilter/ip6t_hbh.c        | 21 +++++++++-----
 net/ipv6/netfilter/ip6t_ipv6header.c | 10 +++++--
 net/ipv6/netfilter/ip6t_srh.c        | 42 ++++++++++++++++++++++------
 3 files changed, 54 insertions(+), 19 deletions(-)

diff --git a/net/ipv6/netfilter/ip6t_hbh.c b/net/ipv6/netfilter/ip6t_hbh.c
index 6d1a5d2026a6..a67f7d0fe93f 100644
--- a/net/ipv6/netfilter/ip6t_hbh.c
+++ b/net/ipv6/netfilter/ip6t_hbh.c
@@ -104,8 +104,10 @@ hbh_mt6(const struct sk_buff *skb, struct xt_action_param *par)
 				break;
 			tp = skb_header_pointer(skb, ptr, sizeof(_opttype),
 						&_opttype);
-			if (tp == NULL)
-				break;
+			if (!tp) {
+				par->hotdrop = true;
+				return false;
+			}
 
 			/* Type check */
 			if (*tp != (optinfo->opts[temp] & 0xFF00) >> 8) {
@@ -120,13 +122,17 @@ hbh_mt6(const struct sk_buff *skb, struct xt_action_param *par)
 				u16 spec_len;
 
 				/* length field exists ? */
-				if (hdrlen < 2)
-					break;
+				if (hdrlen < 2) {
+					par->hotdrop = true;
+					return false;
+				}
 				lp = skb_header_pointer(skb, ptr + 1,
 							sizeof(_optlen),
 							&_optlen);
-				if (lp == NULL)
-					break;
+				if (!lp) {
+					par->hotdrop = true;
+					return false;
+				}
 				spec_len = optinfo->opts[temp] & 0x00FF;
 
 				if (spec_len != 0x00FF && spec_len != *lp) {
@@ -147,7 +153,8 @@ hbh_mt6(const struct sk_buff *skb, struct xt_action_param *par)
 			if ((ptr > skb->len - optlen || hdrlen < optlen) &&
 			    temp < optinfo->optsnr - 1) {
 				pr_debug("new pointer is too large!\n");
-				break;
+				par->hotdrop = true;
+				return false;
 			}
 			ptr += optlen;
 			hdrlen -= optlen;
diff --git a/net/ipv6/netfilter/ip6t_ipv6header.c b/net/ipv6/netfilter/ip6t_ipv6header.c
index c52ff929c93b..0568eb99eb1c 100644
--- a/net/ipv6/netfilter/ip6t_ipv6header.c
+++ b/net/ipv6/netfilter/ip6t_ipv6header.c
@@ -53,8 +53,10 @@ ipv6header_mt6(const struct sk_buff *skb, struct xt_action_param *par)
 			break;
 		}
 		/* Is there enough space for the next ext header? */
-		if (len < (int)sizeof(struct ipv6_opt_hdr))
+		if (len < (int)sizeof(struct ipv6_opt_hdr)) {
+			par->hotdrop = true;
 			return false;
+		}
 		/* ESP -> evaluate */
 		if (nexthdr == NEXTHDR_ESP) {
 			temp |= MASK_ESP;
@@ -99,8 +101,10 @@ ipv6header_mt6(const struct sk_buff *skb, struct xt_action_param *par)
 		nexthdr = hp->nexthdr;
 		len -= hdrlen;
 		ptr += hdrlen;
-		if (ptr > skb->len)
-			break;
+		if (ptr > skb->len) {
+			par->hotdrop = true;
+			return false;
+		}
 	}
 
 	if (nexthdr != NEXTHDR_NONE && nexthdr != NEXTHDR_ESP)
diff --git a/net/ipv6/netfilter/ip6t_srh.c b/net/ipv6/netfilter/ip6t_srh.c
index db0fd64d8986..33a659b9b0e3 100644
--- a/net/ipv6/netfilter/ip6t_srh.c
+++ b/net/ipv6/netfilter/ip6t_srh.c
@@ -27,16 +27,25 @@ static bool srh_mt6(const struct sk_buff *skb, struct xt_action_param *par)
 	struct ipv6_sr_hdr *srh;
 	struct ipv6_sr_hdr _srh;
 	int hdrlen, srhoff = 0;
+	int err;
 
-	if (ipv6_find_hdr(skb, &srhoff, IPPROTO_ROUTING, NULL, NULL) < 0)
+	err = ipv6_find_hdr(skb, &srhoff, IPPROTO_ROUTING, NULL, NULL);
+	if (err < 0) {
+		if (err != -ENOENT)
+			par->hotdrop = true;
 		return false;
+	}
 	srh = skb_header_pointer(skb, srhoff, sizeof(_srh), &_srh);
-	if (!srh)
+	if (!srh) {
+		par->hotdrop = true;
 		return false;
+	}
 
 	hdrlen = ipv6_optlen(srh);
-	if (skb->len - srhoff < hdrlen)
+	if (skb->len - srhoff < hdrlen) {
+		par->hotdrop = true;
 		return false;
+	}
 
 	if (srh->type != IPV6_SRCRT_TYPE_4)
 		return false;
@@ -121,16 +130,25 @@ static bool srh1_mt6(const struct sk_buff *skb, struct xt_action_param *par)
 	struct in6_addr _psid, _nsid, _lsid;
 	struct ipv6_sr_hdr *srh;
 	struct ipv6_sr_hdr _srh;
+	int err;
 
-	if (ipv6_find_hdr(skb, &srhoff, IPPROTO_ROUTING, NULL, NULL) < 0)
+	err = ipv6_find_hdr(skb, &srhoff, IPPROTO_ROUTING, NULL, NULL);
+	if (err < 0) {
+		if (err != -ENOENT)
+			par->hotdrop = true;
 		return false;
+	}
 	srh = skb_header_pointer(skb, srhoff, sizeof(_srh), &_srh);
-	if (!srh)
+	if (!srh) {
+		par->hotdrop = true;
 		return false;
+	}
 
 	hdrlen = ipv6_optlen(srh);
-	if (skb->len - srhoff < hdrlen)
+	if (skb->len - srhoff < hdrlen) {
+		par->hotdrop = true;
 		return false;
+	}
 
 	if (srh->type != IPV6_SRCRT_TYPE_4)
 		return false;
@@ -206,8 +224,10 @@ static bool srh1_mt6(const struct sk_buff *skb, struct xt_action_param *par)
 		psidoff = srhoff + sizeof(struct ipv6_sr_hdr) +
 			  ((srh->segments_left + 1) * sizeof(struct in6_addr));
 		psid = skb_header_pointer(skb, psidoff, sizeof(_psid), &_psid);
-		if (!psid)
+		if (!psid) {
+			par->hotdrop = true;
 			return false;
+		}
 		if (NF_SRH_INVF(srhinfo, IP6T_SRH_INV_PSID,
 				ipv6_masked_addr_cmp(psid, &srhinfo->psid_msk,
 						     &srhinfo->psid_addr)))
@@ -221,8 +241,10 @@ static bool srh1_mt6(const struct sk_buff *skb, struct xt_action_param *par)
 		nsidoff = srhoff + sizeof(struct ipv6_sr_hdr) +
 			  ((srh->segments_left - 1) * sizeof(struct in6_addr));
 		nsid = skb_header_pointer(skb, nsidoff, sizeof(_nsid), &_nsid);
-		if (!nsid)
+		if (!nsid) {
+			par->hotdrop = true;
 			return false;
+		}
 		if (NF_SRH_INVF(srhinfo, IP6T_SRH_INV_NSID,
 				ipv6_masked_addr_cmp(nsid, &srhinfo->nsid_msk,
 						     &srhinfo->nsid_addr)))
@@ -233,8 +255,10 @@ static bool srh1_mt6(const struct sk_buff *skb, struct xt_action_param *par)
 	if (srhinfo->mt_flags & IP6T_SRH_LSID) {
 		lsidoff = srhoff + sizeof(struct ipv6_sr_hdr);
 		lsid = skb_header_pointer(skb, lsidoff, sizeof(_lsid), &_lsid);
-		if (!lsid)
+		if (!lsid) {
+			par->hotdrop = true;
 			return false;
+		}
 		if (NF_SRH_INVF(srhinfo, IP6T_SRH_INV_LSID,
 				ipv6_masked_addr_cmp(lsid, &srhinfo->lsid_msk,
 						     &srhinfo->lsid_addr)))
-- 
2.34.1


