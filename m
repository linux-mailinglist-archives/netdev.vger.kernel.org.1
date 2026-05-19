Return-Path: <netdev+bounces-289250-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8FBjARPDC2qWMQUAu9opvQ
	(envelope-from <netdev+bounces-289250-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 03:55:31 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A38B657632C
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 03:55:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6D670302DF9E
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 01:55:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9582F2F7F06;
	Tue, 19 May 2026 01:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cm1O+m+Q"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 312B52FB969
	for <netdev@vger.kernel.org>; Tue, 19 May 2026 01:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779155726; cv=none; b=jgz6Cln5+B+4sw84E/TPYgVX9P2z+iyvmSzg/m+XkufeZ1WhHlWk8o22F1X/4zOYdD1OKqEe9wup4HLNDdpkPE6haqA/9unei4cKknKX0ektbZmhjYVJwjay552rFJ97r7nPgaR6AT9mmvVVm0nO+JtWD9nL3UQG1Xk0tj5lMGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779155726; c=relaxed/simple;
	bh=VLgfShC+GnqWUvnm2T1qwLmUj4i+nQ5Lf0c0ffK125E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Mu7a7rbf0Dg9rMY6Rm3Y880TGT0zNlBxYzRGLu3PSRUjoFpL4rsrm1G8csQsDVCldM1Uu9WYCIsfKW8uVD83x7LKGmsXUsHSAMezN6T4NBOrpHisBjZx4NA/5RnhDw3arPz9UYrI5VQM6B6JY9NYcb0XdD2xZcPah7J4MVVRhYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cm1O+m+Q; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2baca4df358so16230085ad.2
        for <netdev@vger.kernel.org>; Mon, 18 May 2026 18:55:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779155724; x=1779760524; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CrLsXHJrmnZC07Rq0XCc6PS/mOpD2keMwqnjxffoI7k=;
        b=cm1O+m+QrGjkF/sIHe6KGD2ZTAlf/HGzAhsqpBxhlls91i/eg9CALUeBWwCFtfZJ63
         s2WLotJq77USlrd+eAORSLOgMITKfXev8WFZsjf5KdnNZENhKzIugHGqJzD1g0yC8pfu
         ObzMLXUU3yKt+mW+4BWqKLKWlcHyevCNx1e6ngp9WTgCKuW2awR2R4WFC0uVMFvESvF1
         dJOA1Mz01EqRv2MckBMSdGWpfH9bykCUNNNSP60+NzaPDb8Tfh5wu6N4Lx07sNsBABG7
         tIbZ5kaDGVHI755exmoIlmzEmE4vz5trNmdqSPbci9kfPxt7BYB836snljDq+KcRWSvb
         Soeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779155724; x=1779760524;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CrLsXHJrmnZC07Rq0XCc6PS/mOpD2keMwqnjxffoI7k=;
        b=gky24y1yi04G7NwekxfM71PYfzAKyOQcIU7wxhsz69Aua3UC6jqN7Xzh6JLK90QhBk
         LPfbxYe0dQimsDjNbaUripg4uW1aKrukN0u6KdBcOPGTGsiottLlne1wadSrsnYewsew
         g5HXA0vzrxy7xZg4H6IIiyYaJfaobIeEX6ME5/sL1r6HXwb4mbalqEgpP9HoS0JuZkt3
         6FiPatbXb4GhcDRNJzLmaVlF2660U36DANFMiMXnWOiFmu5kNycuholNvF1IhoPPZoBa
         sNGxH+4FKQo5t7I9DHdLYJ4e7pbF2MSVAZ7shGRUDi8drHsDdKmaBaSpEb0sld5B7e7i
         1HCA==
X-Forwarded-Encrypted: i=1; AFNElJ/J8CYhirpEjUNyF9lgNlmuFENdCAk0Hs4Xq6HgWSiMhfJ3BCFVCyfdi3cZBL0qk/3eEbs1FHw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyB5QXgfTSidPJiysM4EfHnP5PkugYhrnf6FAFA65drJx0rAYQx
	hSnS2w7L+woZ/d6E2gTVY4kwyDPcY7OOF3P/xMvCOfuNVUgJdZHUR0iW
X-Gm-Gg: Acq92OHyhCra0kQjO2RCyOA7kWXkcf5NGLvdx3mvBL2ZrsMBF8qAqc6GAgf1kfJrPfd
	9HMHVOPtJ4rV6pOp1Bk4xOLjQRgS9g78wLE8vTggwYWiwWDWIrul3kDYkN3pu+P7+Yr5mBkNnJC
	Nhp+FuuREypuWb4M4sULcRwlFft7DHEyxJTSap23sNu7FRa4t5oOvjPq1Y24xGk+NaWMWNc6sLw
	3w9qdyiM7BRWZ8VUqar7Lhqe50TM30VjLwMM2adN2VQOmzlKSLPjS2SIlROTe8FWMx1PftIMY5m
	kiuKlLGPw+5LucaquVMbH6cJ29+FkPvZtaBw/YsdEz0vmAxmaJq0dpHE/KNr23sYJiURdNS0hCx
	trdIX4QgDFTFT8zjdPU1QWmWL4pgH5MHMj1k1Jh3r7LRpMRyaeE9d56sf0PHvEzSSz5j2px77ZE
	iYXEa/U/HfiX2FL3xWxfwpotELcxrkGTvTRxfVWslOTIJSN0tvnimnxvsg6iPElWad6uVX6axqo
	HtWxlSchOhVpT3K2LcGocTnRvUdSahpn+M=
X-Received: by 2002:a17:903:37ce:b0:2bd:a403:1d82 with SMTP id d9443c01a7336-2bda4031ef2mr126868885ad.21.1779155724515;
        Mon, 18 May 2026 18:55:24 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d:7285:c2ff:fe45:8a32])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bd5d235e04sm169927115ad.80.2026.05.18.18.55.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 18:55:23 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: netfilter-devel@vger.kernel.org
Cc: Simon Horman <horms@verge.net.au>,
	Julian Anastasov <ja@ssi.bg>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Florian Westphal <fw@strlen.de>,
	Phil Sutter <phil@nwl.cc>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org (open list:IPVS),
	lvs-devel@vger.kernel.org (open list:IPVS),
	coreteam@netfilter.org (open list:NETFILTER),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] ipvs: Use flexible array for MH lookup table
Date: Mon, 18 May 2026 18:55:06 -0700
Message-ID: <20260519015506.634185-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	TAGGED_FROM(0.00)[bounces-289250-lists,netdev=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rosenp@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: A38B657632C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Store the Maglev hash lookup table in the scheduler state
allocation instead of allocating it separately.

This keeps the lookup table tied to the RCU-freed state lifetime and
simplifies the allocation and cleanup paths.

Assisted-by: Codex:GPT-5.5
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 net/netfilter/ipvs/ip_vs_mh.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/net/netfilter/ipvs/ip_vs_mh.c b/net/netfilter/ipvs/ip_vs_mh.c
index 020863047562..d31d3c6d4216 100644
--- a/net/netfilter/ipvs/ip_vs_mh.c
+++ b/net/netfilter/ipvs/ip_vs_mh.c
@@ -59,11 +59,11 @@ static int primes[] = {251, 509, 1021, 2039, 4093,
 
 struct ip_vs_mh_state {
 	struct rcu_head			rcu_head;
-	struct ip_vs_mh_lookup		*lookup;
 	struct ip_vs_mh_dest_setup	*dest_setup;
 	hsiphash_key_t			hash1, hash2;
 	int				gcd;
 	int				rshift;
+	struct ip_vs_mh_lookup		lookup[];
 };
 
 static inline void generate_hash_secret(hsiphash_key_t *hash1,
@@ -372,7 +372,6 @@ static void ip_vs_mh_state_free(struct rcu_head *head)
 	struct ip_vs_mh_state *s;
 
 	s = container_of(head, struct ip_vs_mh_state, rcu_head);
-	kfree(s->lookup);
 	kfree(s);
 }
 
@@ -382,16 +381,10 @@ static int ip_vs_mh_init_svc(struct ip_vs_service *svc)
 	struct ip_vs_mh_state *s;
 
 	/* Allocate the MH table for this service */
-	s = kzalloc_obj(*s);
+	s = kzalloc_flex(*s, lookup, IP_VS_MH_TAB_SIZE);
 	if (!s)
 		return -ENOMEM;
 
-	s->lookup = kzalloc_objs(struct ip_vs_mh_lookup, IP_VS_MH_TAB_SIZE);
-	if (!s->lookup) {
-		kfree(s);
-		return -ENOMEM;
-	}
-
 	generate_hash_secret(&s->hash1, &s->hash2);
 	s->gcd = ip_vs_mh_gcd_weight(svc);
 	s->rshift = ip_vs_mh_shift_weight(svc, s->gcd);
-- 
2.54.0


