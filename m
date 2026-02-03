Return-Path: <netdev+bounces-256126-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uAbMLmCGgWmzGwMAu9opvQ
	(envelope-from <netdev+bounces-256126-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 06:23:44 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E1F5D49D3
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 06:23:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 26C053082F5E
	for <lists+netdev@lfdr.de>; Tue,  3 Feb 2026 05:22:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0602B365A1A;
	Tue,  3 Feb 2026 05:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kgtI/vJS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f202.google.com (mail-qk1-f202.google.com [209.85.222.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88615366050
	for <netdev@vger.kernel.org>; Tue,  3 Feb 2026 05:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770096139; cv=none; b=NiRCAwiO5uNiXSCg1+jcaEX8nO5nL6G3iS7R9WQECVB7o0kPU4YaEmpKYUcsr7G9/oKFP0p9HNuJ2ZkfmPbyERHmCz17VDQxPffSh6ZJ2wRpY8YgJgOO+EWO6AI8pzV5HNCm3ZNip69aiCRGPzYafR7pKlaCANygPj/OUBTR6zw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770096139; c=relaxed/simple;
	bh=3Khfvj2qdaEYhfvYiNP6JCQeT4JCtKOk3cYTxBW0D7k=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=M+/TBNYtypMRnvOcGpFZXLu4Z2UVtETZlxPW5evj9VXAph7QzvZX/JuIIuf8e/f6pS1KrueK7+ZhUhU5ocsxluibHtBafzpUkc9Wkac15aENHFIUCkaRePdxzhDb4Y7SxrNhQ0PJPt6cGmO83mKNmmxT2KnWKwp2ZaZrvE9E8i8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kgtI/vJS; arc=none smtp.client-ip=209.85.222.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qk1-f202.google.com with SMTP id af79cd13be357-8c70ed6c849so1346532085a.1
        for <netdev@vger.kernel.org>; Mon, 02 Feb 2026 21:22:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1770096137; x=1770700937; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=nF8hk51I84HATicgSqa/awSrwEPZcn0FdCsjftcO3sM=;
        b=kgtI/vJSxsQJPa86rFo1ZAY47Pn+wOM/1L9d3DTPIrGRSHI+kx/+n96JJwonPkNtVx
         Awlkst7tN5FZomc9MoM5d8NO2dkbg9GGepUC2xZXvuKGmAdetNyCoGsrZ6kWtsHpH2WH
         XDPv4fg0zTIdSLsWZ8QePn59a/YEtkMH7XN6WqLpnA1NNyRSs/f0Bwa+LK4D6hT5qPdN
         Y1BUbuZTshB90u4mrKauWVz92dv9UE6vbfGtTZQgTVd/1ckRqRReJnpZgRO9u5lTHBDi
         RqQL6MKJYeHl3vmjKFc1ikpZGIvvUR7qSdXLrNG0qhSDuszYUvjg48wUmB1qGkL/R9j0
         12Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770096137; x=1770700937;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nF8hk51I84HATicgSqa/awSrwEPZcn0FdCsjftcO3sM=;
        b=lgEe6anTtXYX6GF2txC8TYbJ5ubib/Y7hwlN095YH4/MqvaILL4As1cwF80HD74Alr
         ppOtEVZ905/HhrO6BjLojVlj8sBZXRLhei5LN703g7mX6yEPirzTziSpRYYssj0lNz+u
         9bTD+3W06W7zCVafXaWligQTYgT/drrd0WAY3YvH7Gd4FTjB1t+ASQW0cxNLBpSwtqRq
         keNOejF7/knfJ2BeNeWfoUjciUUkUq1xK59OxL4nFgG62v05qTXzn9fnAOI6OZ/SateF
         5hgYwkAITqVf+RuBqiWVJAr6yUvw0+Yw2P1idFJKntA++YG2W58TVPatmudJqMb3whO0
         eBBQ==
X-Forwarded-Encrypted: i=1; AJvYcCXKaf98AWTBVjt5vPaKRTF30v6400FAURLM0ggUpyfVcA+A37Hj1+LkCBVYqBARiqnCu3/ZYm4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZSbwZ3eWWZxO1WMf2SrXE3uLGi2wxuX7D6doTta5DGIDtcSCT
	2u9jbpX1fpE/msfy+cGcsdz9wJssZzjq4Bw+DFtwYRR7+ngoe7u8lOCXseX47ryNmkXHI5tpXnF
	wrhoxtUYkiN8ipA==
X-Received: from qknxj32.prod.google.com ([2002:a05:620a:5be0:b0:8b1:97cd:6753])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:c51:b0:8c6:abc5:f15e with SMTP id af79cd13be357-8c9eb30e8e1mr1884283385a.67.1770096137498;
 Mon, 02 Feb 2026 21:22:17 -0800 (PST)
Date: Tue,  3 Feb 2026 05:22:10 +0000
In-Reply-To: <20260203052210.3684125-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260203052210.3684125-1-edumazet@google.com>
X-Mailer: git-send-email 2.53.0.rc1.225.gd81095ad13-goog
Message-ID: <20260203052210.3684125-5-edumazet@google.com>
Subject: [PATCH v2 net-next 4/4] tcp: move __reqsk_free() out of line
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Neal Cardwell <ncardwell@google.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,google.com,vger.kernel.org,gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-256126-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vmlinux.new:url]
X-Rspamd-Queue-Id: 1E1F5D49D3
X-Rspamd-Action: no action

Inlining __reqsk_free() is overkill, let's reclaim 2 Kbytes of text.

$ scripts/bloat-o-meter -t vmlinux.old vmlinux.new
add/remove: 2/4 grow/shrink: 2/14 up/down: 225/-2338 (-2113)
Function                                     old     new   delta
__reqsk_free                                   -     114    +114
sock_edemux                                   18      82     +64
inet_csk_listen_start                        233     264     +31
__pfx___reqsk_free                             -      16     +16
__pfx_reqsk_queue_alloc                       16       -     -16
__pfx_reqsk_free                              16       -     -16
reqsk_queue_alloc                             46       -     -46
tcp_req_err                                  272     177     -95
reqsk_fastopen_remove                        348     253     -95
cookie_bpf_check                             157      62     -95
cookie_tcp_reqsk_alloc                       387     290     -97
cookie_v4_check                             1568    1465    -103
reqsk_free                                   105       -    -105
cookie_v6_check                             1519    1412    -107
sock_gen_put                                 187      78    -109
sock_pfree                                   212      82    -130
tcp_try_fastopen                            1818    1683    -135
tcp_v4_rcv                                  3478    3294    -184
reqsk_put                                    306      90    -216
tcp_get_cookie_sock                          551     318    -233
tcp_v6_rcv                                  3404    3141    -263
tcp_conn_request                            2677    2384    -293
Total: Before=24887415, After=24885302, chg -0.01%

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 include/net/request_sock.h      |  9 +--------
 net/ipv4/inet_connection_sock.c | 10 ++++++++++
 2 files changed, 11 insertions(+), 8 deletions(-)

diff --git a/include/net/request_sock.h b/include/net/request_sock.h
index 23bb909771fb..5a9c826a7092 100644
--- a/include/net/request_sock.h
+++ b/include/net/request_sock.h
@@ -123,14 +123,7 @@ static inline struct sock *skb_steal_sock(struct sk_buff *skb,
 	return sk;
 }
 
-static inline void __reqsk_free(struct request_sock *req)
-{
-	req->rsk_ops->destructor(req);
-	if (req->rsk_listener)
-		sock_put(req->rsk_listener);
-	kfree(req->saved_syn);
-	kmem_cache_free(req->rsk_ops->slab, req);
-}
+void __reqsk_free(struct request_sock *req);
 
 static inline void reqsk_free(struct request_sock *req)
 {
diff --git a/net/ipv4/inet_connection_sock.c b/net/ipv4/inet_connection_sock.c
index dc4e2c5725cd..3d0997c39418 100644
--- a/net/ipv4/inet_connection_sock.c
+++ b/net/ipv4/inet_connection_sock.c
@@ -918,6 +918,16 @@ struct request_sock *inet_reqsk_alloc(const struct request_sock_ops *ops,
 }
 EXPORT_SYMBOL(inet_reqsk_alloc);
 
+void __reqsk_free(struct request_sock *req)
+{
+	req->rsk_ops->destructor(req);
+	if (req->rsk_listener)
+		sock_put(req->rsk_listener);
+	kfree(req->saved_syn);
+	kmem_cache_free(req->rsk_ops->slab, req);
+}
+EXPORT_IPV6_MOD_GPL(__reqsk_free);
+
 static struct request_sock *inet_reqsk_clone(struct request_sock *req,
 					     struct sock *sk)
 {
-- 
2.53.0.rc1.225.gd81095ad13-goog


