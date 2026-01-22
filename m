Return-Path: <netdev+bounces-252213-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yDEPAbCvcWlmLQAAu9opvQ
	(envelope-from <netdev+bounces-252213-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 06:03:44 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CC4261E24
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 06:03:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 45AC4527C87
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 04:59:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DAFF46AEF2;
	Thu, 22 Jan 2026 04:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="asAvZJM0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f74.google.com (mail-yx1-f74.google.com [74.125.224.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CA3346AEE4
	for <netdev@vger.kernel.org>; Thu, 22 Jan 2026 04:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769057851; cv=none; b=ONou+mmCnuGMG6p4PdjYShRwYPrW61CEp11/uaoXknLGm4jswgKn9owBEVt/LW9Vf5mhN0Od+3GfQ3JQa57x8sI91xbniDUnnkGQ1KFnvysDxa7aBHZ9fiPoqi2Eip1Sl/0eUdavISVB2JCV8KNjT4OVvcz+KQfLdaX3KYNixqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769057851; c=relaxed/simple;
	bh=RTsqQ8NUY38yW5b1Ko3FAbo+XO51eEWo9HvBaJTyFc4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=oiVLvoI/tBLihPF2EBRmGGdyqL4XV9mz64D6wu34ULjW7A2tj35B+RX8ngidX+ao6N8vCldwG7s6qJSmjS0TLUoGVs3Ce3tiXuujYlL8FfQ8Q2RCzBbnDxeV2QJOhEH02vJXQrzuIDzlbXbSaROajV6pH1xq3EoqL4h0gd5stOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=asAvZJM0; arc=none smtp.client-ip=74.125.224.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yx1-f74.google.com with SMTP id 956f58d0204a3-64939d0cd02so911837d50.0
        for <netdev@vger.kernel.org>; Wed, 21 Jan 2026 20:57:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769057849; x=1769662649; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=QUvO229ISiDUN7s+56jrVUeMkwFZu6euFF2AnVu4UY4=;
        b=asAvZJM0kpfoMWynP9+FN84xkId57eynVd0M/ebKyEqwk1ASwpHstwpJew4NYM0v11
         6mhCs53Pi5ajo5AF9lPTH5JYT43hTDdMx6s2WFEK8zJOj5FTOIMbs6j+ZMj8Ohvqu1j/
         EjmiPlQV1TJPA6I79AlvGLVenjzDpBWw+yD5FsBTjYxH2QiB6oSf11fLhEEIZ+tyZXpd
         NJW2W+sXHvidLwHU223fz/RTuqP+ZvNUxbilLlPuDOxUryuwGz9a3kkQXuXPTxCHIuyY
         RHH3hMpu7pa0JXmXiERuUZuJNgH5x9S7vYI0UQjPb8WciSYHdguPqjK6+EPoqkBcZW0t
         7mgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769057849; x=1769662649;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QUvO229ISiDUN7s+56jrVUeMkwFZu6euFF2AnVu4UY4=;
        b=eGCHm3QuRa2wc3MEgKG6mr8hqVr5YbE8RgLGpwgJq+cmwvYlBuCNfD7/beQro0320S
         lP9WCY6+HPkNnP8yqgbnGUfit9qnfZX4Z/J9iCfXIng8uRnOXZdLxJ6z8DgpWVImSkNH
         vh6Y5OeubHdHClqHlCMF6+0XWHa03DfBQZfubHyRPF8ZFEW6beUhVlE6xsX2Btrdof3X
         Atdt8Iy49aiUcOerNhc6Xg6Pvwzqs3YtSG3uK/eM9EzSy/EcQoSkbuzbAnBF0Yeuxr6x
         /8hv0CEMvq3lyClRJ4Xq7sZc+MmEmum/TqsqONPdNpTdYiBxTu7u7XVIgXd3fds8v0S+
         SIDw==
X-Forwarded-Encrypted: i=1; AJvYcCUpIq5j1YoIaxvps/LoFf7o1XIy5AUj3ufZuK7fQsRHtH7RKJzx1XcNE+W4gQeSY0ufZ6+cxEg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxC9n0RpNG+zAtLBKgFxiaAqei9R+yJLDIN+mMANECOO/5t1mBI
	D/raAg+OS1/WJQ2FiCqfPpgQAJ5qDBaRngiCiPu/yFh/9jBKIiVbKSLTZiBCB5hTm+KJQ5BNp8M
	cuAy6jTgY/XV7Bg==
X-Received: from yxmh16.prod.google.com ([2002:a53:b410:0:b0:640:d681:9c0f])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:690e:e84:b0:649:393c:86b6 with SMTP id 956f58d0204a3-649393c8df1mr7454780d50.18.1769057849179;
 Wed, 21 Jan 2026 20:57:29 -0800 (PST)
Date: Thu, 22 Jan 2026 04:57:19 +0000
In-Reply-To: <20260122045720.1221017-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260122045720.1221017-1-edumazet@google.com>
X-Mailer: git-send-email 2.52.0.457.g6b5491de43-goog
Message-ID: <20260122045720.1221017-5-edumazet@google.com>
Subject: [PATCH net-next 4/4] net: inline get_netmem() and put_netmem()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-252213-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,gmail.com,google.com];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DMARC_POLICY_ALLOW(0.00)[google.com,reject];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:7979, ipnet:213.196.21.0/24, country:US];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:helo,ams.mirrors.kernel.org:rdns]
X-Rspamd-Queue-Id: 9CC4261E24
X-Rspamd-Action: no action

These helpers are used in network fast paths.

Only call out-of-line helpers for netmem case.

We might consider inlining __get_netmem() and __put_netmem()
in the future.

$ scripts/bloat-o-meter -t vmlinux.3 vmlinux.4
add/remove: 6/6 grow/shrink: 22/1 up/down: 2614/-646 (1968)
Function                                     old     new   delta
pskb_carve                                  1669    1894    +225
gro_pull_from_frag0                            -     206    +206
get_page                                     190     380    +190
skb_segment                                 3561    3747    +186
put_page                                     595     765    +170
skb_copy_ubufs                              1683    1822    +139
__pskb_trim_head                             276     401    +125
__pskb_copy_fclone                           734     858    +124
skb_zerocopy                                1092    1215    +123
pskb_expand_head                             892    1008    +116
skb_split                                    828     940    +112
skb_release_data                             297     409    +112
___pskb_trim                                 829     941    +112
__skb_zcopy_downgrade_managed                120     226    +106
tcp_clone_payload                            530     634    +104
esp_ssg_unref                                191     294    +103
dev_gro_receive                             1464    1514     +50
__put_netmem                                   -      41     +41
__get_netmem                                   -      41     +41
skb_shift                                   1139    1175     +36
skb_try_coalesce                             681     714     +33
__pfx_put_page                               112     144     +32
__pfx_get_page                                32      64     +32
__pskb_pull_tail                            1137    1168     +31
veth_xdp_get                                 250     267     +17
__pfx_gro_pull_from_frag0                      -      16     +16
__pfx___put_netmem                             -      16     +16
__pfx___get_netmem                             -      16     +16
__pfx_put_netmem                              16       -     -16
__pfx_gro_try_pull_from_frag0                 16       -     -16
__pfx_get_netmem                              16       -     -16
put_netmem                                   114       -    -114
get_netmem                                   130       -    -130
napi_gro_frags                               929     771    -158
gro_try_pull_from_frag0                      196       -    -196
Total: Before=22565857, After=22567825, chg +0.01%

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 include/net/netmem.h | 20 ++++++++++++++++++--
 net/core/skbuff.c    | 31 ++++++++++---------------------
 2 files changed, 28 insertions(+), 23 deletions(-)

diff --git a/include/net/netmem.h b/include/net/netmem.h
index 2113a197abb315f608ee3d6d3e8a60811b3781f8..a96b3e5e5574c1800ae7949c39366968707ab5d5 100644
--- a/include/net/netmem.h
+++ b/include/net/netmem.h
@@ -401,8 +401,24 @@ static inline bool net_is_devmem_iov(const struct net_iov *niov)
 }
 #endif
 
-void get_netmem(netmem_ref netmem);
-void put_netmem(netmem_ref netmem);
+void __get_netmem(netmem_ref netmem);
+void __put_netmem(netmem_ref netmem);
+
+static __always_inline void get_netmem(netmem_ref netmem)
+{
+	if (netmem_is_net_iov(netmem))
+		__get_netmem(netmem);
+	else
+		get_page(netmem_to_page(netmem));
+}
+
+static __always_inline void put_netmem(netmem_ref netmem)
+{
+	if (netmem_is_net_iov(netmem))
+		__put_netmem(netmem);
+	else
+		put_page(netmem_to_page(netmem));
+}
 
 #define netmem_dma_unmap_addr_set(NETMEM, PTR, ADDR_NAME, VAL)   \
 	do {                                                     \
diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index c57c806edba8524d3d498800e61ae6901fbfe5fb..2a8235c3d6f7fcee8b0b28607c10db985965b8d4 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -7422,31 +7422,20 @@ bool csum_and_copy_from_iter_full(void *addr, size_t bytes,
 }
 EXPORT_SYMBOL(csum_and_copy_from_iter_full);
 
-void get_netmem(netmem_ref netmem)
+void __get_netmem(netmem_ref netmem)
 {
-	struct net_iov *niov;
+	struct net_iov *niov = netmem_to_net_iov(netmem);
 
-	if (netmem_is_net_iov(netmem)) {
-		niov = netmem_to_net_iov(netmem);
-		if (net_is_devmem_iov(niov))
-			net_devmem_get_net_iov(netmem_to_net_iov(netmem));
-		return;
-	}
-	get_page(netmem_to_page(netmem));
+	if (net_is_devmem_iov(niov))
+		net_devmem_get_net_iov(netmem_to_net_iov(netmem));
 }
-EXPORT_SYMBOL(get_netmem);
+EXPORT_SYMBOL(__get_netmem);
 
-void put_netmem(netmem_ref netmem)
+void __put_netmem(netmem_ref netmem)
 {
-	struct net_iov *niov;
-
-	if (netmem_is_net_iov(netmem)) {
-		niov = netmem_to_net_iov(netmem);
-		if (net_is_devmem_iov(niov))
-			net_devmem_put_net_iov(netmem_to_net_iov(netmem));
-		return;
-	}
+	struct net_iov *niov = netmem_to_net_iov(netmem);
 
-	put_page(netmem_to_page(netmem));
+	if (net_is_devmem_iov(niov))
+		net_devmem_put_net_iov(netmem_to_net_iov(netmem));
 }
-EXPORT_SYMBOL(put_netmem);
+EXPORT_SYMBOL(__put_netmem);
-- 
2.52.0.457.g6b5491de43-goog


