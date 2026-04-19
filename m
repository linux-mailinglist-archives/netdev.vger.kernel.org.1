Return-Path: <netdev+bounces-279611-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gIMzANdY5WmFiQEAu9opvQ
	(envelope-from <netdev+bounces-279611-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 20 Apr 2026 00:36:07 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 699AB425B16
	for <lists+netdev@lfdr.de>; Mon, 20 Apr 2026 00:36:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A77F83021E4B
	for <lists+netdev@lfdr.de>; Sun, 19 Apr 2026 22:35:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DD1E313522;
	Sun, 19 Apr 2026 22:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d/J6TDTh"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D67972E06E6
	for <netdev@vger.kernel.org>; Sun, 19 Apr 2026 22:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776638150; cv=none; b=oUFkTbPYjo0E5LvcuvbgboZ3ZqHKJYo9hrqjVUKXZIwqTyeSiJW80bZINw3zAXIZzJq8KPY+hd401BRhagxw5bDj7ffPeTETdEQA0FxYDZHh7oCDnlPNIfoT5t6uiqgOg8+R6n1i0SArDzEvUIOsPMBnaZxbacrF6Gj+8PEOvsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776638150; c=relaxed/simple;
	bh=I3Myfp0QkKb5K00juGV5JyULkwTG3pZaIDyX99SJCYU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Btq2VOVJGSHJhsQhrUhni+nOOh1JfzveryLGYVmqN3ynNcdqu0dtmqKAdf9n7q4/OvJwg4g3YwmFV82+dee+bkJ+jnXspwRMSG5kFq2ENPEN7bWmIiZZHXYIPGnK+zI64lm1uwefygBPBKAQ8gwVWD4b5xA8pPg7bTUKYRbb99Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d/J6TDTh; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-8d65f4073bfso363014385a.3
        for <netdev@vger.kernel.org>; Sun, 19 Apr 2026 15:35:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776638147; x=1777242947; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8YjJhAhidNVRBtD80lOpLbifsanwTva+YHTmSJo3O1w=;
        b=d/J6TDThi2QEqimMl3rtVk85/fKhYaGOwyBWMIf/B+SVHvpx0KrLDWADmKOqAJ8iYM
         XYNLgxBGBSZhGJFHj963EgTi5p0RHSvupG+rVD/B0wPPtBaBVTO/cZVKR6y0dNMHqvHs
         NdA/p+nxlqy55jdljCpoS75R3D8L4kXvKxUkVH6XjonE3cA/CmlA1CtglFREKMxM91Vi
         01qSmJnYyuf9mtjP4JPQw3iuZfzyBc02BoZeto3vu4kEfbq3/O/2jab0qSyQBPr+4fOw
         jq4/PqWHvpXvdG5pt/N1GuBfRU6+cVRcg/wpLSmhmjq/dXfIdT7kUvAxNRQi6i9GpNSh
         3Z5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776638147; x=1777242947;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8YjJhAhidNVRBtD80lOpLbifsanwTva+YHTmSJo3O1w=;
        b=f21fiC2dqdV+8vSNBvcYVRs9KrHU/wy7hJFBXZLp4LK63WaM6cfPxRT21vyBYjWJ9O
         kFkKZphVOk/wXyADn+pgDhWt1yYdB1w5GgCBzrF38cnrAUomGDfJfK0JxZG7fHRvTbAb
         W+4MPiLlZOzvogyg58saj8RjTnKKCb/U6H+OEvdAHDKmOXbts7BpNPbAvtFTd/ftO7kX
         eYWrlxSJ1ozVqXeiG9eSo4y0yYmUUctT+L/AURCvb1BmUK1tMpcYiYNliPEuFnfHqkCW
         beHVGhIUomtSlC+jHYzwe7WqCudcmmevqSXHaXYqMiBpc3kzJQX8HXSXkBU4jcUe9yCz
         +5UA==
X-Forwarded-Encrypted: i=1; AFNElJ9BBLydXGfn9cUqE/8HymvHBOVdPNajZ4js4EZxjxUCM2ctFSX49/WoNxwc1Bm7XjdN6f7ZSfc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2ALDTqXGTkdW9s0EO+OKL9WYOA+8rGBD1g2dE4V9p94bT342R
	NfXQFhx2U6JDAU1FjcWPk2vOahV3QNID7vtxq+6jq4H7bhPpJq0f5kSy
X-Gm-Gg: AeBDiesbeIKb7IGL8v8u8/X2JM4ie8AhNobjiLkB5UR34kazY3ESpb1vxli8t9U2b9x
	rn/RuweSvLOp9c9vi2nOkW3UDbp3lWLutuOuOFaI5Onqg/t2t9mQKLjVH7LMwBA2MQ8cCwHQe8s
	caEQCtDSlghtOjeX/NAY9T+oZKxqXij/1hg6GelaCQJI+YssVfX515uFAzoac7/hvoKDoC7QGiP
	rlF15mqvAfblA5jG30xYDAw6aVrP1nBwLiAxio+6TPwLBVTowT7VxCIK+durJulY23OTvo2XWHf
	2oDw20ADSoad6ZVEDhMIBtbzvB7LVyd+wzKW08cLrM/zCKjqY16Tb9Lxk0zQrzINdcUv9JR/KC2
	zgOPmk8mtO2cOIiEM/LDhAo4RnEBPdh9XQFsFnDNhh2JcO6pVR8dZW/gyyx0Q7huR89hNSCtmzX
	c2cBN9s+bxy90+liAF1S9GNQXArF72s8O4/XXZ4JhAv/bnw7qqYeRMl6iA/pL9CMVdKWlYPlms8
	Y1qlSaoBF4htdBENHI3NzYoIwMcG0I=
X-Received: by 2002:a05:620a:46a0:b0:8cf:c4d7:dfa with SMTP id af79cd13be357-8e78f827c71mr1660750385a.16.1776638146787;
        Sun, 19 Apr 2026 15:35:46 -0700 (PDT)
Received: from server0 (c-68-48-65-54.hsd1.mi.comcast.net. [68.48.65.54])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8e7d8edb734sm727830985a.29.2026.04.19.15.35.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Apr 2026 15:35:46 -0700 (PDT)
From: Michael Bommarito <michael.bommarito@gmail.com>
To: Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	netdev@vger.kernel.org
Cc: "David S . Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Fan Du <fan.du@windriver.com>,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] xfrm: ah: account for ESN high bits in async callbacks
Date: Sun, 19 Apr 2026 18:35:42 -0400
Message-ID: <20260419223542.2293727-1-michael.bommarito@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-279611-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[12];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_NEQ_ENVFROM(0.00)[michaelbommarito@gmail.com,netdev@vger.kernel.org];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 699AB425B16
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

AH allocates its temporary auth/ICV layout differently when ESN is enabled:
the async ahash setup appends a 4-byte seqhi slot before the ICV or
auth_data area, but the async completion callbacks still reconstruct the
temporary layout as if seqhi were absent.

With an async AH implementation selected, that makes AH copy or compare
the wrong bytes on both the IPv4 and IPv6 paths. In UML repro on IPv4 AH
with ESN and forced async hmac(sha1), ping fails with 100% packet loss,
and the callback logs show the pre-fix drift:

  ah4 output_done: esn=1 err=0 icv_off=20 expected_off=24
  ah4 input_done: esn=1 auth_off=20 expected_auth_off=24 icv_off=32 expected_icv_off=36

Reconstruct the callback-side layout the same way the setup path built it
by skipping the ESN seqhi slot before locating the saved auth_data or ICV.
Per RFC 4302, the ESN high-order 32 bits participate in the AH ICV
computation, so the async callbacks must account for the seqhi slot.

Post-fix, the same IPv4 AH+ESN+forced-async-hmac(sha1) UML repro shows
the corrected offset (ah4 output_done: esn=1 err=0 icv_off=24
expected_off=24) and ping succeeds; net/ipv4/ah4.o and net/ipv6/ah6.o
build clean at W=1. IPv6 AH+ESN was not exercised at runtime, and the
change has not been tested against a real async hardware AH engine.

Fixes: d4d573d0334d ("{IPv4,xfrm} Add ESN support for AH egress part")
Fixes: d8b2a8600b0e ("{IPv4,xfrm} Add ESN support for AH ingress part")
Fixes: 26dd70c3fad3 ("{IPv6,xfrm} Add ESN support for AH egress part")
Fixes: 8d6da6f32557 ("{IPv6,xfrm} Add ESN support for AH ingress part")
Cc: stable@vger.kernel.org
Assisted-by: Codex:gpt-5-4
Assisted-by: Claude:claude-opus-4-7
Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
---
 net/ipv4/ah4.c | 14 ++++++++++++--
 net/ipv6/ah6.c | 14 ++++++++++++--
 2 files changed, 24 insertions(+), 4 deletions(-)

diff --git a/net/ipv4/ah4.c b/net/ipv4/ah4.c
index 5fb812443a08..4366cbac3f06 100644
--- a/net/ipv4/ah4.c
+++ b/net/ipv4/ah4.c
@@ -124,9 +124,14 @@ static void ah_output_done(void *data, int err)
 	struct iphdr *top_iph = ip_hdr(skb);
 	struct ip_auth_hdr *ah = ip_auth_hdr(skb);
 	int ihl = ip_hdrlen(skb);
+	int seqhi_len = 0;
+	__be32 *seqhi;
 
+	if (x->props.flags & XFRM_STATE_ESN)
+		seqhi_len = sizeof(*seqhi);
 	iph = AH_SKB_CB(skb)->tmp;
-	icv = ah_tmp_icv(iph, ihl);
+	seqhi = (__be32 *)((char *)iph + ihl);
+	icv = ah_tmp_icv(seqhi, seqhi_len);
 	memcpy(ah->auth_data, icv, ahp->icv_trunc_len);
 
 	top_iph->tos = iph->tos;
@@ -270,12 +275,17 @@ static void ah_input_done(void *data, int err)
 	struct ip_auth_hdr *ah = ip_auth_hdr(skb);
 	int ihl = ip_hdrlen(skb);
 	int ah_hlen = (ah->hdrlen + 2) << 2;
+	int seqhi_len = 0;
+	__be32 *seqhi;
 
 	if (err)
 		goto out;
 
+	if (x->props.flags & XFRM_STATE_ESN)
+		seqhi_len = sizeof(*seqhi);
 	work_iph = AH_SKB_CB(skb)->tmp;
-	auth_data = ah_tmp_auth(work_iph, ihl);
+	seqhi = (__be32 *)((char *)work_iph + ihl);
+	auth_data = ah_tmp_auth(seqhi, seqhi_len);
 	icv = ah_tmp_icv(auth_data, ahp->icv_trunc_len);
 
 	err = crypto_memneq(icv, auth_data, ahp->icv_trunc_len) ? -EBADMSG : 0;
diff --git a/net/ipv6/ah6.c b/net/ipv6/ah6.c
index cb26beea4398..de1e68199a01 100644
--- a/net/ipv6/ah6.c
+++ b/net/ipv6/ah6.c
@@ -317,14 +317,19 @@ static void ah6_output_done(void *data, int err)
 	struct ipv6hdr *top_iph = ipv6_hdr(skb);
 	struct ip_auth_hdr *ah = ip_auth_hdr(skb);
 	struct tmp_ext *iph_ext;
+	int seqhi_len = 0;
+	__be32 *seqhi;
 
 	extlen = skb_network_header_len(skb) - sizeof(struct ipv6hdr);
 	if (extlen)
 		extlen += sizeof(*iph_ext);
 
+	if (x->props.flags & XFRM_STATE_ESN)
+		seqhi_len = sizeof(*seqhi);
 	iph_base = AH_SKB_CB(skb)->tmp;
 	iph_ext = ah_tmp_ext(iph_base);
-	icv = ah_tmp_icv(iph_ext, extlen);
+	seqhi = (__be32 *)((char *)iph_ext + extlen);
+	icv = ah_tmp_icv(seqhi, seqhi_len);
 
 	memcpy(ah->auth_data, icv, ahp->icv_trunc_len);
 	memcpy(top_iph, iph_base, IPV6HDR_BASELEN);
@@ -471,13 +476,18 @@ static void ah6_input_done(void *data, int err)
 	struct ip_auth_hdr *ah = ip_auth_hdr(skb);
 	int hdr_len = skb_network_header_len(skb);
 	int ah_hlen = ipv6_authlen(ah);
+	int seqhi_len = 0;
+	__be32 *seqhi;
 
 	if (err)
 		goto out;
 
+	if (x->props.flags & XFRM_STATE_ESN)
+		seqhi_len = sizeof(*seqhi);
 	work_iph = AH_SKB_CB(skb)->tmp;
 	auth_data = ah_tmp_auth(work_iph, hdr_len);
-	icv = ah_tmp_icv(auth_data, ahp->icv_trunc_len);
+	seqhi = (__be32 *)(auth_data + ahp->icv_trunc_len);
+	icv = ah_tmp_icv(seqhi, seqhi_len);
 
 	err = crypto_memneq(icv, auth_data, ahp->icv_trunc_len) ? -EBADMSG : 0;
 	if (err)
-- 
2.53.0


