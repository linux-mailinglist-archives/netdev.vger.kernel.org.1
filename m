Return-Path: <netdev+bounces-280338-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AC4PGNV66GlvKwIAu9opvQ
	(envelope-from <netdev+bounces-280338-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 09:37:57 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id CF6E8443018
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 09:37:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2E66430234C4
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 07:37:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F263372B4B;
	Wed, 22 Apr 2026 07:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WWAwc0sj"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CAFE37266E
	for <netdev@vger.kernel.org>; Wed, 22 Apr 2026 07:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776843453; cv=none; b=tNNL8K4GbWuV3PKtI7BCN74+0dNVD1Bc+Wl4gqYWtdJF+T5y11U9nsiTV9Zi2tLN/xvs2JCi9FH6hkc0POJMff0uG6c8+/nXYfAT5hlur1v6WTkPoU1tTWkybtitQaloq0qNBhHziOXfWxeNq+0M42SXUSySer+tlgRZaGBVLLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776843453; c=relaxed/simple;
	bh=5dyoG/KCVtoa4Pp0xAZxPffQDXF8eRW3WvaFi6JA03I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EehX5D1jFL1dvohkZdCHD2OvVHQ+l9VbpDWcHRvkg0vNQ3EIktHzsAJZiKt9oA9I+FegLFrHBh9Q2s2f43W3zE/2DFxlRscXeiIrkNUjz8LlsHTpNgFTZQL3wyG/kLS6TvIYSqFjxmDqY0usUcOvickaUUM0ChaFIpU6KU84IOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WWAwc0sj; arc=none smtp.client-ip=74.125.82.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f43.google.com with SMTP id a92af1059eb24-12c19d23b19so6549184c88.0
        for <netdev@vger.kernel.org>; Wed, 22 Apr 2026 00:37:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776843451; x=1777448251; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8wgrP8hCcHXs+AdVctjn43hPNU4GYFc9lVuWtTj29k0=;
        b=WWAwc0sjsbeFGHYjnuCaACNq5u0idJLYArsJNW7jW7/0n2vpC8H62GzhYDpNwQpYhX
         DN//BuooZzVGHUTQloi1bt8gFWNiVjDTbCUgQXVNgcLgRsDNRb9Bhn4l2VuJVMsS4KGC
         0N9LE3AfZDyUD76ffvMpE/SX6Jutx7U2FRP7lU7NPRI9r+RlTTQG/C0Vzd6EiHg+y2JS
         dUlbKgOT67SBzXLh8mTbucgo3y4NCLbMHh4a1I2xDCNYkDyqBCoklF62lXLP/0Kw/juh
         0ObdNILeWZZCzjbjiji8gCBPBETrze/A74aEomKI3l3bfiiOXIjWIKwK9rmnYhXAYm2+
         J6hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776843451; x=1777448251;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8wgrP8hCcHXs+AdVctjn43hPNU4GYFc9lVuWtTj29k0=;
        b=jhP/GmwFC1hMpKZ7eIuIrFtF7T4iWC5jz7eqiJ8W4dpVjQS1WGqTPR0L4ds9TpkX7d
         jVAYbv3PI/nEhv74KId8BiAwvRcWjZkZshjCHvqKONak24DLWmxrbsBpijp0j0eqbo5b
         dYlEeGhO8h8RFlVaagB2ue7vdWcfHsAuUy9d7ht/isRKZDlTDSOcOVeR1nBFSnXZ6dC5
         Qae+p93CCFUO1gyCHTn18C67f6rf0NItrxWBkwpKJRYpbROro1Z8ytN3qVC2wqosZHRR
         ObqCBD8Bodld3Zsg/8+eBOdNnmctmFmmAHhWOvXiZ7yGqemjBWlLK25K4UHZAZ6XkYkG
         H2fQ==
X-Forwarded-Encrypted: i=1; AFNElJ+4P1GXiPmufV3+AOvnQQNTAGGR9jVUE79O/ZSAspgE7jZ3+qFtgfbFY7wV97wzz8L2hTJwNA0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxjt1YtbQpVfqdfwRuLbziewd/5wxhIbWGR8OxBndWWXBQiHc3u
	1a/X2RJokg1jNimWvfh3lUFysF6D3iXGIJ31hDrU00OdgHuxnQz6uxA2
X-Gm-Gg: AeBDietCzQeryRkcBHyOmZStMUDtIHBfu5D3+UJc30Qa1+ZwMkotNux2Vwe9wsv0jWz
	/Qae8He+xL3L0EL2T5VLIx2TFLoHwv/qBWlK0ZbBCyhJV7S9hihob+meOnE5T5HZ34UWdcVq20c
	K/Yc0Eq3fAUZBRXV8A2/pp8cyF+zOspk4KssIsbomN1yD04GmeZlT97ee+5nYWsmDaX6VYEvpzw
	YJi/9c4l0npv0WXQg+45rIiU3XlIHPIYrNAKVOD1m6sSDQiixgQgRj3ZmLLYxh6L4l1gVoHO9Y+
	sHqKzD36keKxRBcxXkD9i42YZ6LRNgMtd8grMW02ajAcj+xkhrY6ANfvRzOOdFq/oJiRipKsXtv
	CvFS5x879R1WieFgsTjM1ME3mdZg6bH+HttTGrSndPSXJjjd23Eq2aWlqA2EcoDU3i0hfky84UM
	i3JBXaWtIb3pSmUndYkZxVOAbOrYfwizwZ89pksofWWhXTcLXIYcjnwexXsxFzSwU6ABy5Ip3mX
	G+tUB38rFqZR06Wa0YcM8tQCjThC3M=
X-Received: by 2002:a05:7022:eac8:b0:128:d375:f1cc with SMTP id a92af1059eb24-12c73f759e5mr11998285c88.12.1776843451156;
        Wed, 22 Apr 2026 00:37:31 -0700 (PDT)
Received: from efaec68ba852.tailc0aff1.ts.net ([206.206.192.132])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12db8684f90sm3360768c88.13.2026.04.22.00.37.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2026 00:37:30 -0700 (PDT)
From: Weiming Shi <bestswngs@gmail.com>
To: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Amery Hung <ameryhung@gmail.com>,
	Leon Hwang <leon.hwang@linux.dev>,
	Kees Cook <kees@kernel.org>,
	Fushuai Wang <wangfushuai@baidu.com>,
	Menglong Dong <menglong8.dong@gmail.com>,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	Xiang Mei <xmei5@asu.edu>,
	Weiming Shi <bestswngs@gmail.com>
Subject: [PATCH bpf v3] bpf: Fix NULL pointer dereference in bpf_sk_storage_clone and diag paths
Date: Tue, 21 Apr 2026 23:54:12 -0700
Message-ID: <20260422065411.1007737-2-bestswngs@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [6.34 / 15.00];
	SEM_URIBL(3.50)[asu.edu:email];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	BAD_REP_POLICIES(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,linux.dev,baidu.com,vger.kernel.org,asu.edu];
	TAGGED_FROM(0.00)[bounces-280338-lists,netdev=lfdr.de];
	GREYLIST(0.00)[pass,meta];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	R_DKIM_ALLOW(0.00)[gmail.com:s=20251104];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	DMARC_POLICY_ALLOW(0.00)[gmail.com,none];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[bestswngs@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	NEURAL_SPAM(0.00)[0.644];
	R_SPF_ALLOW(0.00)[+ip4:172.105.105.114:c];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	ARC_ALLOW(0.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,asu.edu:email]
X-Rspamd-Queue-Id: CF6E8443018
X-Rspamd-Action: add header
X-Rspamd-Server: lfdr
X-Spam: Yes

bpf_selem_unlink_nofail() sets SDATA(selem)->smap to NULL before
removing the selem from the storage hlist. A concurrent RCU reader in
bpf_sk_storage_clone() can observe the selem still on the list with
smap already NULL, causing a NULL pointer dereference.

 general protection fault, probably for non-canonical address 0xdffffc000000000a:
 KASAN: null-ptr-deref in range [0x0000000000000050-0x0000000000000057]
 RIP: 0010:bpf_sk_storage_clone+0x1cd/0xaa0 net/core/bpf_sk_storage.c:174
 Call Trace:
  <IRQ>
  sk_clone+0xfed/0x1980 net/core/sock.c:2591
  inet_csk_clone_lock+0x30/0x760 net/ipv4/inet_connection_sock.c:1222
  tcp_create_openreq_child+0x35/0x2680 net/ipv4/tcp_minisocks.c:571
  tcp_v4_syn_recv_sock+0x123/0xf90 net/ipv4/tcp_ipv4.c:1729
  tcp_check_req+0x8e1/0x2580 include/net/tcp.h:855
  tcp_v4_rcv+0x1845/0x3b80 net/ipv4/tcp_ipv4.c:2347

Add a NULL check for smap in bpf_sk_storage_clone().
bpf_sk_storage_diag_put_all() and bpf_sk_storage_diag_put() have the
same unprotected dereference pattern, add NULL checks there as well and
pass the validated smap to diag_get() so it no longer performs its own
rcu_dereference.

Fixes: 5d800f87d0a5 ("bpf: Support lockless unlink when freeing map or local storage")
Reported-by: Xiang Mei <xmei5@asu.edu>
Signed-off-by: Weiming Shi <bestswngs@gmail.com>
---
v3:
  pass smap to diag_get()
v2:
  drop the NULL check in diag_get(); The caller already checks smap for
NULL.

 net/core/bpf_sk_storage.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/net/core/bpf_sk_storage.c b/net/core/bpf_sk_storage.c
index f8338acebf077..1f9bd0005883b 100644
--- a/net/core/bpf_sk_storage.c
+++ b/net/core/bpf_sk_storage.c
@@ -172,7 +172,7 @@ int bpf_sk_storage_clone(const struct sock *sk, struct sock *newsk)
 		struct bpf_map *map;
 
 		smap = rcu_dereference(SDATA(selem)->smap);
-		if (!(smap->map.map_flags & BPF_F_CLONE))
+		if (!smap || !(smap->map.map_flags & BPF_F_CLONE))
 			continue;
 
 		/* Note that for lockless listeners adding new element
@@ -534,10 +534,10 @@ bpf_sk_storage_diag_alloc(const struct nlattr *nla_stgs)
 }
 EXPORT_SYMBOL_GPL(bpf_sk_storage_diag_alloc);
 
-static int diag_get(struct bpf_local_storage_data *sdata, struct sk_buff *skb)
+static int diag_get(struct bpf_local_storage_map *smap,
+		    struct bpf_local_storage_data *sdata, struct sk_buff *skb)
 {
 	struct nlattr *nla_stg, *nla_value;
-	struct bpf_local_storage_map *smap;
 
 	/* It cannot exceed max nlattr's payload */
 	BUILD_BUG_ON(U16_MAX - NLA_HDRLEN < BPF_LOCAL_STORAGE_MAX_VALUE_SIZE);
@@ -546,7 +546,6 @@ static int diag_get(struct bpf_local_storage_data *sdata, struct sk_buff *skb)
 	if (!nla_stg)
 		return -EMSGSIZE;
 
-	smap = rcu_dereference(sdata->smap);
 	if (nla_put_u32(skb, SK_DIAG_BPF_STORAGE_MAP_ID, smap->map.id))
 		goto errout;
 
@@ -599,9 +598,11 @@ static int bpf_sk_storage_diag_put_all(struct sock *sk, struct sk_buff *skb,
 	saved_len = skb->len;
 	hlist_for_each_entry_rcu(selem, &sk_storage->list, snode) {
 		smap = rcu_dereference(SDATA(selem)->smap);
+		if (!smap)
+			continue;
 		diag_size += nla_value_size(smap->map.value_size);
 
-		if (nla_stgs && diag_get(SDATA(selem), skb))
+		if (nla_stgs && diag_get(smap, SDATA(selem), skb))
 			/* Continue to learn diag_size */
 			err = -EMSGSIZE;
 	}
@@ -633,6 +634,7 @@ int bpf_sk_storage_diag_put(struct bpf_sk_storage_diag *diag,
 	unsigned int diag_size = nla_total_size(0);
 	struct bpf_local_storage *sk_storage;
 	struct bpf_local_storage_data *sdata;
+	struct bpf_local_storage_map *smap;
 	struct nlattr *nla_stgs;
 	unsigned int saved_len;
 	int err = 0;
@@ -668,7 +670,11 @@ int bpf_sk_storage_diag_put(struct bpf_sk_storage_diag *diag,
 
 		diag_size += nla_value_size(diag->maps[i]->value_size);
 
-		if (nla_stgs && diag_get(sdata, skb))
+		smap = rcu_dereference(sdata->smap);
+		if (!smap)
+			continue;
+
+		if (nla_stgs && diag_get(smap, sdata, skb))
 			/* Continue to learn diag_size */
 			err = -EMSGSIZE;
 	}
-- 
2.43.0


