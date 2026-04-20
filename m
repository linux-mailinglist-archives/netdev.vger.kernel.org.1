Return-Path: <netdev+bounces-279863-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eL+1F3dl5mlmvwEAu9opvQ
	(envelope-from <netdev+bounces-279863-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 20 Apr 2026 19:42:15 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 51C96431DAE
	for <lists+netdev@lfdr.de>; Mon, 20 Apr 2026 19:42:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 0DF3630505F2
	for <lists+netdev@lfdr.de>; Mon, 20 Apr 2026 16:16:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC95C3321BF;
	Mon, 20 Apr 2026 16:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G19AvS1o"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 573FC3112D0
	for <netdev@vger.kernel.org>; Mon, 20 Apr 2026 16:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776701780; cv=none; b=mM/EfROMQTZBPqPmvhfzXyConSzLjA/a80/niaEUDj/DVaDPjIbHAQtPjYj8jSSNwZnCft+7deoj0BUvetbid5BGebNKENYMaMnjUkLq5diBJRnpsr/+osrKW+/17oXxbf3+0bTU+HBlyf9cp6QYxg5U5/mwSGpWI0LFCmqbllA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776701780; c=relaxed/simple;
	bh=0RO+cn4XOSgeN0aZfQM5DIrCmQQEiJfa8/NprR8hbfw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eSZEqE3zuAuVCu5tFi9e7nuZEYQL/k3fHmedEFDD37XA2fAfzGq/xWjtOOU3PVeCtJVZDiOvzZf2eP7NErY6kKPoIAucPklYsEKQBp6PP13/RmQ0tAn3GLQYh2ZnVVZYq2/tkRkBW5siiJERG2DLf5aQFTJ/EaJPTsnZGCsO1pQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G19AvS1o; arc=none smtp.client-ip=74.125.82.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-2e622a9da9cso157756eec.0
        for <netdev@vger.kernel.org>; Mon, 20 Apr 2026 09:16:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776701778; x=1777306578; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uqz6eVdmKi0qqROGlvTqXQYPBPAP8XJ0Rhi2kMv7Qfw=;
        b=G19AvS1oXw/nd00CD7GU8sgo9vcldiD3AyZ/oOKMeMYbMYhLIiCn2WmJgUoqQ4I5P7
         wApYJjYt3qHrQc2eQ38F4E7xJfMlsqbELLBy4dvf6VXZrV5WNUeDo40a+mCTyMPMeNVS
         2AKkoMpqMHF2dUbjH7eYVjFTy2/+rdIm9ZDZftms1jSqNEKKxfwryMx8GR1qGvWvhIe7
         UgRSAKYdjGR34LaC3g4PiRUN7bu50YhEJLAVQCtRNHYUtHwJNrTuxwP9g95Dwd1LF2be
         YPjsnSK21bCysvOMKIktsET8oSw/9d+2sk+3aJpmkIui7m8wON/o3G49pnNgzW/sO8SQ
         65yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776701778; x=1777306578;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uqz6eVdmKi0qqROGlvTqXQYPBPAP8XJ0Rhi2kMv7Qfw=;
        b=oqA2kwQotSAkIpGBEyVmIuGkJODIiLhYh07+PpBF+TfPerNLoEmXtQhaTOHB8lfn8Q
         ow3ZyuJRmvqUQky9Wft388VWC955nJbaos52jQ97jV9xolY2ia9ndMTOcAyXiMu1us+H
         kL9jY3cxJcv3OQnR5FRmCKHhiyxKavYtLqDbcisE6y2+DEX7IwFNzGyo1csCpktXGbm2
         osDaADIqMDqjiSsGlqJA/PCKJlkvebm+aoRAvtDO05myUnKmj6v7mxtfRp8RDxZNTcMA
         BahJaisIznqLy1UhBgu60Lp5N5pWXFbX3WnO1DHZaySdc9HD3mOrMDwFTqP5wTlxXatS
         d1zw==
X-Forwarded-Encrypted: i=1; AFNElJ8EpPGmVeMUnHA9DTZwqT3OGHa1xvo47nUCwDN1qI6ODAh+c48Ol8KZ/pTWrcrjJFfhb+8XtvY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVPF9a9WJDEGPNEzEVT+1DYEldfiagzN+gRiiqZCy7VMDBYJ8R
	1Omw34ZCSYvvdefwZFsL7ocs/PGWbtJMnZVPD14HjEUbaYa97gl9eC2p
X-Gm-Gg: AeBDievgZQm3mNTRJmWf6pWBl62gxgTTjEwo5L/gyYznzFWvLYr/7Q7dGapegx58m2o
	2FyAtxE19LUFgK6O95LOXd/Ft9NCpdgkGcL4rlRJ1oLGttXQ0SmIGy6e2y2T2wzkSdr4E8719t3
	Dh2KASwjnBY2/5nHDzoLTCCHXX+vKBEcGcNkBjyhru8vfMcsOnr48b7idL9EECjKhKfFHEkgzh/
	rmpuI0G4CTNvSVlS516Meonh+kOzBPsdpEOrCGValZGiha+cB0/G9ZoGp6gUy/St/J3j6pi5/UG
	vQmaD/Y4kn50CtUrTUMyygIpbSW04SxC2mpQ5UIbqwYL+3Em6Nct2VxIbziFgdVlRYSwFVGIUhT
	DZvh0e9e0HrohwLWWy3U7qljCxtOoXHgwWgkA1tEExVaWVDd2s7F2KuHzjn0q5c40uxWJSnlsWI
	ORJ3XYjAwGXfb+jBnXgHWq9yRIzZymzfs4foJytYB3nZxDsP2VF6zwZEL7iIcNLdbIUQTXuDbcg
	iRWCPiOTE9WjUC4g7Nk
X-Received: by 2002:a05:7301:6085:b0:2e2:4979:eba with SMTP id 5a478bee46e88-2e465770d9fmr7343990eec.7.1776701778367;
        Mon, 20 Apr 2026 09:16:18 -0700 (PDT)
Received: from efaec68ba852.tailc0aff1.ts.net ([206.206.192.132])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2e53d2cfd3esm14914111eec.21.2026.04.20.09.16.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2026 09:16:17 -0700 (PDT)
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
Subject: [PATCH bpf] bpf: Fix NULL pointer dereference in bpf_sk_storage_clone and diag paths
Date: Mon, 20 Apr 2026 09:14:33 -0700
Message-ID: <20260420161432.3919396-2-bestswngs@gmail.com>
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
	TAGGED_FROM(0.00)[bounces-279863-lists,netdev=lfdr.de];
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
	NEURAL_SPAM(0.00)[0.655];
	R_SPF_ALLOW(0.00)[+ip4:104.64.211.4:c];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	ARC_ALLOW(0.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,asu.edu:email]
X-Rspamd-Queue-Id: 51C96431DAE
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

While at it, also add NULL checks in bpf_sk_storage_diag_put_all() and
diag_get() which have the same unprotected dereference pattern and could
theoretically hit the same race during an inet_diag dump.

Fixes: 5d800f87d0a5 ("bpf: Support lockless unlink when freeing map or local storage")
Reported-by: Xiang Mei <xmei5@asu.edu>
Signed-off-by: Weiming Shi <bestswngs@gmail.com>
---
 net/core/bpf_sk_storage.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/net/core/bpf_sk_storage.c b/net/core/bpf_sk_storage.c
index f8338acebf077..3b487280f50fa 100644
--- a/net/core/bpf_sk_storage.c
+++ b/net/core/bpf_sk_storage.c
@@ -172,7 +172,7 @@ int bpf_sk_storage_clone(const struct sock *sk, struct sock *newsk)
 		struct bpf_map *map;
 
 		smap = rcu_dereference(SDATA(selem)->smap);
-		if (!(smap->map.map_flags & BPF_F_CLONE))
+		if (!smap || !(smap->map.map_flags & BPF_F_CLONE))
 			continue;
 
 		/* Note that for lockless listeners adding new element
@@ -547,6 +547,8 @@ static int diag_get(struct bpf_local_storage_data *sdata, struct sk_buff *skb)
 		return -EMSGSIZE;
 
 	smap = rcu_dereference(sdata->smap);
+	if (!smap)
+		goto errout;
 	if (nla_put_u32(skb, SK_DIAG_BPF_STORAGE_MAP_ID, smap->map.id))
 		goto errout;
 
@@ -599,6 +601,8 @@ static int bpf_sk_storage_diag_put_all(struct sock *sk, struct sk_buff *skb,
 	saved_len = skb->len;
 	hlist_for_each_entry_rcu(selem, &sk_storage->list, snode) {
 		smap = rcu_dereference(SDATA(selem)->smap);
+		if (!smap)
+			continue;
 		diag_size += nla_value_size(smap->map.value_size);
 
 		if (nla_stgs && diag_get(SDATA(selem), skb))
-- 
2.43.0


