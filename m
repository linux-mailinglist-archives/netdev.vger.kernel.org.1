Return-Path: <netdev+bounces-307347-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id z+aSNG2rVWo/rgAAu9opvQ
	(envelope-from <netdev+bounces-307347-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 05:22:21 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CD58E7509D3
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 05:22:20 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=FzyyjIV4;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-307347-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-307347-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E9BCB30091E4
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 03:22:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4EDC3B9D83;
	Tue, 14 Jul 2026 03:22:16 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C909A34FF78
	for <netdev@vger.kernel.org>; Tue, 14 Jul 2026 03:22:14 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783999336; cv=none; b=ENq+VsAumXbO6wnpQyQSPf+hz63bJos8pNZab1vEuf3rE7r09eUKQSbhyyfH2UuS/Ni57v0N140s/XMVaOcCf/914/WQ1KOn9Q9oyS/smls8GvwFBBkZo3+az3G0N41ozksIuxZgqEZnqH0TwZIsfNkdXpZ+xPXuhDagAGaxRoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783999336; c=relaxed/simple;
	bh=eBS2/UCPUQ6+8V6OTgVzup444Pe4czSkA2Syz7+RS1M=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=VJ1xvfUO6jXGAfBVw+DccrzFkHfL9IHJwyhjrzTpDuelXlP5NMhw3f8LVHKdjX0bScnS7JM07njc/7ATueb9hcp3M7qFzy6yhQR2WrFb78mo1V8E9OLUqUKMHcArK6b5B7uK/9tpyKq8Kcn46Hg8qbrNPO1sJ6ZKsvPlKv2sKF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FzyyjIV4; arc=none smtp.client-ip=209.85.216.45
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-381b831d535so604016a91.0
        for <netdev@vger.kernel.org>; Mon, 13 Jul 2026 20:22:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783999334; x=1784604134; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=5RlpC6pS3D2JC8KnQchimNr9oFVPt7c8UwtX27SHkOo=;
        b=FzyyjIV4aXvuAhjX5VmqSaAffcwjCIS4S3SCEjGKWmAwNgVu366WSSzbjQe8J86F6z
         Y4/4osgN1n5S+8yNnUe8/pr/22HANzboAoVsQttBExon+bU4iOe64BG/0S/I0nANQau8
         CyDlKcHfYSCxowakeB5sYyo0/TIKUEdUhVUAWCM/e1bx8JNRaFfraXz3hN3XELMB0/u1
         qs+OjBTms2Rn+PsAcLrYAHfuZp/ySN5xFoAg6193Ha7yc27rVW3uMkythV+hSWk7gX16
         DNxfUltQrLAlE/tvsGmZN6KWyn04qz7Or+VnX4zRQQ8+8nZW8BWLIQCUPdqJejXq4NWC
         C05A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783999334; x=1784604134;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5RlpC6pS3D2JC8KnQchimNr9oFVPt7c8UwtX27SHkOo=;
        b=VmsGl92G33xVE25hhI6pDTVdwD0iFtLVKqS5g4S+we9wXnr77DhIwLgdFmqFcFRz3x
         HBTplT6Ou7tebxHh18aIsws0gcq4Z+XdjVtifcOuc3RhpbV72ThP6VLx4FyBK4h8CcZD
         MF4HzU8n2vPXUfIrlafnMwNUoT9KlahDxskfZaoxOY4D/MPR9cyZvFDjA+knRpdtK/2I
         a21vuwdd1Pa1a2rzL7hcU71JKboa4iXUiMyHm2HDmkmnXi6C9Iy2ckDLWywPVHlVQ+mI
         QgjQmUGiyzTy25Al+Axg0w20KgmpQO/zjqJ7d8UOo8YtgfqKaP7OGX5UgHGeYlB0gQ5J
         mcTA==
X-Forwarded-Encrypted: i=1; AHgh+RrdMq7mc5DhCG3UQjUrzkxFPe0iOfziPvPDjXwHJysh+E9qhmb4NwtpE4cVJU2lnUn4pwDPv/s=@vger.kernel.org
X-Gm-Message-State: AOJu0YzmoqJmiNeMkC2xnbC2RHklpycwgM74AsFQBaN8t0B/EMfwsq3h
	GXskheAmDqke2jgRfBdHzqUVl3wCTPs2hIgjFlw2vZ+CObY4j8nhcNa3
X-Gm-Gg: AfdE7cmZjd1YvOT9nvYez+RDHcTDg23YXJDasgyLaXzjZBO1svgZL3pDFuOdJN8k6Q3
	y68M06UOFi27Caeli5WEYtRcGTYfgk2K5l5VMJ98yh1ROg9vuYcFkLw/iega7ZxgmwI4iu2y11s
	XCNPQE24uOLfVkJ65RSzeocUaYqruh1s0oyOZOCmHsRciqrb47yX8WZwvQR8EJ8vSz2/FtMCmA3
	v+CLgATnYNAf8Oel8TL54lw9P2IhImagaUVHvBHebe/Hb9yya4rw3VBBzKaW89IahQQiB19xR37
	tI2CCA0booEZjhjAGVTVAhMB+Yv2fR4J1wZ9S8Cyd6BE1lXhInVHYd1Q1PuKsCdSzsbOJJc/fiZ
	SRDQvJl82LVreecI+VJdiTGVLXaIKERMEOSSQNc3K5Ny9pfclDql1RIMBOT5r96i2NqRxJZnxFh
	Sghk6l5btik9jUDD2f2g+J
X-Received: by 2002:a17:90b:540d:b0:37f:9ce1:cda8 with SMTP id 98e67ed59e1d1-38dc7752969mr10742606a91.30.1783999333895;
        Mon, 13 Jul 2026 20:22:13 -0700 (PDT)
Received: from c79ofce.localdomain ([204.3.140.65])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38e174442f6sm728635a91.10.2026.07.13.20.22.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 20:22:13 -0700 (PDT)
From: Zhixing Chen <running910@gmail.com>
To: Florian Westphal <fw@strlen.de>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Phil Sutter <phil@nwl.cc>
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org,
	netdev@vger.kernel.org,
	Zhixing Chen <running910@gmail.com>
Subject: [PATCH nf v2] netfilter: ip6tables: set hotdrop for malformed extension header matches
Date: Tue, 14 Jul 2026 11:21:24 +0800
Message-Id: <20260714032124.7042-1-running910@gmail.com>
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
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,netfilter.org,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-307347-lists,netdev=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:fw@strlen.de,m:pablo@netfilter.org,m:phil@nwl.cc,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:netfilter-devel@vger.kernel.org,m:coreteam@netfilter.org,m:netdev@vger.kernel.org,m:running910@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORGED_SENDER(0.00)[running910@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[running910@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: CD58E7509D3

The hbh, srh and ipv6header matches have paths that return false for
malformed IPv6 extension header packets without setting hotdrop.

For hbh, strict option parsing stops when the option type or length field
cannot be read, or when advancing to the next requested option would
exceed the available header data. Mark these packets for hotdrop instead
of treating them as a rule mismatch.

For srh, keep a missing SRH as a normal mismatch, but set hotdrop when
header lookup fails for other reasons, when the SRH fixed header is not
present, when the advertised SRH length exceeds the available skb data,
when segments_left exceeds first_segment, or when SID selector reads fail.

For ipv6header, set hotdrop when the advertised extension header length
exceeds the available skb data.

Returning false treats the packet as a rule mismatch. Set hotdrop for
these malformed packets so they cannot bypass rules intended to drop
packets with these IPv6 extension headers.

Signed-off-by: Zhixing Chen <running910@gmail.com>
---

Changes in v2:
- Use hotdrop labels for hbh and srh paths.
- Mark SRH packets with segments_left greater than first_segment for
  hotdrop.
- Drop the redundant ipv6header length check before skb_header_pointer().

v1: https://lore.kernel.org/netdev/20260709063012.33160-1-running910@gmail.com/T/

---
 net/ipv6/netfilter/ip6t_hbh.c        | 27 ++++++++++---------
 net/ipv6/netfilter/ip6t_ipv6header.c |  9 +++----
 net/ipv6/netfilter/ip6t_srh.c        | 40 ++++++++++++++++++++--------
 3 files changed, 47 insertions(+), 29 deletions(-)

diff --git a/net/ipv6/netfilter/ip6t_hbh.c b/net/ipv6/netfilter/ip6t_hbh.c
index 6d1a5d2026a6..1b5dcc92b7da 100644
--- a/net/ipv6/netfilter/ip6t_hbh.c
+++ b/net/ipv6/netfilter/ip6t_hbh.c
@@ -62,21 +62,18 @@ hbh_mt6(const struct sk_buff *skb, struct xt_action_param *par)
 			    NEXTHDR_HOP : NEXTHDR_DEST, NULL, NULL);
 	if (err < 0) {
 		if (err != -ENOENT)
-			par->hotdrop = true;
+			goto hotdrop;
 		return false;
 	}
 
 	oh = skb_header_pointer(skb, ptr, sizeof(_optsh), &_optsh);
-	if (oh == NULL) {
-		par->hotdrop = true;
-		return false;
-	}
+	if (!oh)
+		goto hotdrop;
 
 	hdrlen = ipv6_optlen(oh);
 	if (skb->len - ptr < hdrlen) {
 		/* Packet smaller than it's length field */
-		par->hotdrop = true;
-		return false;
+		goto hotdrop;
 	}
 
 	pr_debug("IPv6 OPTS LEN %u %u ", hdrlen, oh->hdrlen);
@@ -104,8 +101,8 @@ hbh_mt6(const struct sk_buff *skb, struct xt_action_param *par)
 				break;
 			tp = skb_header_pointer(skb, ptr, sizeof(_opttype),
 						&_opttype);
-			if (tp == NULL)
-				break;
+			if (!tp)
+				goto hotdrop;
 
 			/* Type check */
 			if (*tp != (optinfo->opts[temp] & 0xFF00) >> 8) {
@@ -121,12 +118,12 @@ hbh_mt6(const struct sk_buff *skb, struct xt_action_param *par)
 
 				/* length field exists ? */
 				if (hdrlen < 2)
-					break;
+					goto hotdrop;
 				lp = skb_header_pointer(skb, ptr + 1,
 							sizeof(_optlen),
 							&_optlen);
-				if (lp == NULL)
-					break;
+				if (!lp)
+					goto hotdrop;
 				spec_len = optinfo->opts[temp] & 0x00FF;
 
 				if (spec_len != 0x00FF && spec_len != *lp) {
@@ -147,7 +144,7 @@ hbh_mt6(const struct sk_buff *skb, struct xt_action_param *par)
 			if ((ptr > skb->len - optlen || hdrlen < optlen) &&
 			    temp < optinfo->optsnr - 1) {
 				pr_debug("new pointer is too large!\n");
-				break;
+				goto hotdrop;
 			}
 			ptr += optlen;
 			hdrlen -= optlen;
@@ -159,6 +156,10 @@ hbh_mt6(const struct sk_buff *skb, struct xt_action_param *par)
 	}
 
 	return false;
+
+hotdrop:
+	par->hotdrop = true;
+	return false;
 }
 
 static int hbh_mt6_check(const struct xt_mtchk_param *par)
diff --git a/net/ipv6/netfilter/ip6t_ipv6header.c b/net/ipv6/netfilter/ip6t_ipv6header.c
index c52ff929c93b..e339cefc7fff 100644
--- a/net/ipv6/netfilter/ip6t_ipv6header.c
+++ b/net/ipv6/netfilter/ip6t_ipv6header.c
@@ -52,9 +52,6 @@ ipv6header_mt6(const struct sk_buff *skb, struct xt_action_param *par)
 			temp |= MASK_NONE;
 			break;
 		}
-		/* Is there enough space for the next ext header? */
-		if (len < (int)sizeof(struct ipv6_opt_hdr))
-			return false;
 		/* ESP -> evaluate */
 		if (nexthdr == NEXTHDR_ESP) {
 			temp |= MASK_ESP;
@@ -99,8 +96,10 @@ ipv6header_mt6(const struct sk_buff *skb, struct xt_action_param *par)
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
index db0fd64d8986..321c7f40a24f 100644
--- a/net/ipv6/netfilter/ip6t_srh.c
+++ b/net/ipv6/netfilter/ip6t_srh.c
@@ -27,22 +27,27 @@ static bool srh_mt6(const struct sk_buff *skb, struct xt_action_param *par)
 	struct ipv6_sr_hdr *srh;
 	struct ipv6_sr_hdr _srh;
 	int hdrlen, srhoff = 0;
+	int err;
 
-	if (ipv6_find_hdr(skb, &srhoff, IPPROTO_ROUTING, NULL, NULL) < 0)
+	err = ipv6_find_hdr(skb, &srhoff, IPPROTO_ROUTING, NULL, NULL);
+	if (err < 0) {
+		if (err != -ENOENT)
+			goto hotdrop;
 		return false;
+	}
 	srh = skb_header_pointer(skb, srhoff, sizeof(_srh), &_srh);
 	if (!srh)
-		return false;
+		goto hotdrop;
 
 	hdrlen = ipv6_optlen(srh);
 	if (skb->len - srhoff < hdrlen)
-		return false;
+		goto hotdrop;
 
 	if (srh->type != IPV6_SRCRT_TYPE_4)
 		return false;
 
 	if (srh->segments_left > srh->first_segment)
-		return false;
+		goto hotdrop;
 
 	/* Next Header matching */
 	if (srhinfo->mt_flags & IP6T_SRH_NEXTHDR)
@@ -111,6 +116,10 @@ static bool srh_mt6(const struct sk_buff *skb, struct xt_action_param *par)
 				!(srh->tag == srhinfo->tag)))
 			return false;
 	return true;
+
+hotdrop:
+	par->hotdrop = true;
+	return false;
 }
 
 static bool srh1_mt6(const struct sk_buff *skb, struct xt_action_param *par)
@@ -121,22 +130,27 @@ static bool srh1_mt6(const struct sk_buff *skb, struct xt_action_param *par)
 	struct in6_addr _psid, _nsid, _lsid;
 	struct ipv6_sr_hdr *srh;
 	struct ipv6_sr_hdr _srh;
+	int err;
 
-	if (ipv6_find_hdr(skb, &srhoff, IPPROTO_ROUTING, NULL, NULL) < 0)
+	err = ipv6_find_hdr(skb, &srhoff, IPPROTO_ROUTING, NULL, NULL);
+	if (err < 0) {
+		if (err != -ENOENT)
+			goto hotdrop;
 		return false;
+	}
 	srh = skb_header_pointer(skb, srhoff, sizeof(_srh), &_srh);
 	if (!srh)
-		return false;
+		goto hotdrop;
 
 	hdrlen = ipv6_optlen(srh);
 	if (skb->len - srhoff < hdrlen)
-		return false;
+		goto hotdrop;
 
 	if (srh->type != IPV6_SRCRT_TYPE_4)
 		return false;
 
 	if (srh->segments_left > srh->first_segment)
-		return false;
+		goto hotdrop;
 
 	/* Next Header matching */
 	if (srhinfo->mt_flags & IP6T_SRH_NEXTHDR)
@@ -207,7 +221,7 @@ static bool srh1_mt6(const struct sk_buff *skb, struct xt_action_param *par)
 			  ((srh->segments_left + 1) * sizeof(struct in6_addr));
 		psid = skb_header_pointer(skb, psidoff, sizeof(_psid), &_psid);
 		if (!psid)
-			return false;
+			goto hotdrop;
 		if (NF_SRH_INVF(srhinfo, IP6T_SRH_INV_PSID,
 				ipv6_masked_addr_cmp(psid, &srhinfo->psid_msk,
 						     &srhinfo->psid_addr)))
@@ -222,7 +236,7 @@ static bool srh1_mt6(const struct sk_buff *skb, struct xt_action_param *par)
 			  ((srh->segments_left - 1) * sizeof(struct in6_addr));
 		nsid = skb_header_pointer(skb, nsidoff, sizeof(_nsid), &_nsid);
 		if (!nsid)
-			return false;
+			goto hotdrop;
 		if (NF_SRH_INVF(srhinfo, IP6T_SRH_INV_NSID,
 				ipv6_masked_addr_cmp(nsid, &srhinfo->nsid_msk,
 						     &srhinfo->nsid_addr)))
@@ -234,13 +248,17 @@ static bool srh1_mt6(const struct sk_buff *skb, struct xt_action_param *par)
 		lsidoff = srhoff + sizeof(struct ipv6_sr_hdr);
 		lsid = skb_header_pointer(skb, lsidoff, sizeof(_lsid), &_lsid);
 		if (!lsid)
-			return false;
+			goto hotdrop;
 		if (NF_SRH_INVF(srhinfo, IP6T_SRH_INV_LSID,
 				ipv6_masked_addr_cmp(lsid, &srhinfo->lsid_msk,
 						     &srhinfo->lsid_addr)))
 			return false;
 	}
 	return true;
+
+hotdrop:
+	par->hotdrop = true;
+	return false;
 }
 
 static int srh_mt6_check(const struct xt_mtchk_param *par)
-- 
2.34.1


