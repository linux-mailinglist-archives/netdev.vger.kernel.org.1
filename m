Return-Path: <netdev+bounces-252210-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6Jf9LDqvcWlmLQAAu9opvQ
	(envelope-from <netdev+bounces-252210-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 06:01:46 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 607ED61DE2
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 06:01:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 933265431FB
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 04:59:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAE64466B53;
	Thu, 22 Jan 2026 04:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tWL/Fznn"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f202.google.com (mail-qk1-f202.google.com [209.85.222.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AE2931691C
	for <netdev@vger.kernel.org>; Thu, 22 Jan 2026 04:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769057845; cv=none; b=Kmk1+aLM5mG1A77k/BxiT1kRfrSZakRmnVyizpDmtHLdaocnJy1Zc236dgNxRM7nFdFLenJFNuLmkaXlKcECG8ONH9ILDaC6bEsL4/EGbr1HQ2h9Zk4/X5a4VBaD9lX9aiN5FMoKdyx8E5VckXebJVgpNfnBqmEa0ws5Shs3sWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769057845; c=relaxed/simple;
	bh=D2NOi11yD27++o7tqdwSmEAGHDz4mJJRR/AyhoLWdsA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=jqybxshk17gB75rRW2MQdRyxzxWAW7zDPij7M0oXbOEcPYlnonkIwABnh3iiuIfvF1zDjp5ggGuq3XWwdetBgZHiSQQPCVhKkNL0pzjO047hvNU+E74Kgf4hGkebHr7bWbaSCcrASYap8CaAlbbmAn75cplsNd7g9zOo6sG9X8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tWL/Fznn; arc=none smtp.client-ip=209.85.222.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qk1-f202.google.com with SMTP id af79cd13be357-8c6a341ac9fso169340185a.3
        for <netdev@vger.kernel.org>; Wed, 21 Jan 2026 20:57:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769057843; x=1769662643; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=kfdxqumEexKePX9xZCNXVyjmn2uiu37OzaOXMZkkTio=;
        b=tWL/FznnaOsAx1Mz6pgbmZ18VJ0fwwsAP4Q1P1+IjA/PtNSwnDqdICrkiRaFGsHssU
         WeYpXm0PrUxCHquUy+6jO45fJw8oay89RcxqJsZT2rKKCFhzrh/7GSOC5FfQB28vvxG8
         AnPKO3Pgt5vF5vlSX+t62oB2KYmimn8u02OFHrhhzC0lTg0S63Vu2vgny4kkbwsGH0Vm
         eBNBYtAwiKkJQjMeUMAN4eYIxHpR7Ogwfo3UYWIcZeTmIrQ48tH5d7kqmU6UZ7Zi98n8
         L2cej6KuL4ATRurffvBlyVJakkKRBGS3GVVoq45WqO7SO3Kkp9iIEnILgCp+BXEvlAh4
         0vdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769057843; x=1769662643;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kfdxqumEexKePX9xZCNXVyjmn2uiu37OzaOXMZkkTio=;
        b=JA/nttG6KqPfSoPrcLXW37vji0EQVUe3PJkaAftRmRrhjLtUOiHfsguSmRpv9SwcOG
         JF2TQWklMFi/GWKQZSSlzxEKn9VE74xIDLaZGZ7Uc8T5fYszqU3+S2kLkpN05CQ34z/u
         ps1Lkv+FgQT0USD1raRpNzkZYtXCaMilAQGHwxBWzN2iCbL91eSyQP3/2Tp6l1BgRyV9
         a9N9y6JoxhWQDtT4BvIUW+KYLgv0fAMq9hSPMDyoggsyM15tXfKAnkTzcZw6eyhuaURN
         OUEnpnMc0dYNdaGFhUPza4Y7/Ha4RU4TCBuqeCDEE+0XWl4d6ZB7mXqzJlvIxli8QQIw
         ctaQ==
X-Forwarded-Encrypted: i=1; AJvYcCUdjPFgU710e+eRATwzycgwF7IX3eJ7/x/N2CEH2QCZGwhnrLj6V4ClpJOag1/YidjBQahEqzE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKz0J01fXyS29MoUBDZ7wJxL09L7cbSgdrzYDZ8SvtiSk03yqr
	xTgi0lfNX2qlmmt7Vj7k5xKPKN/HYovub3bKKGh/OQU2y/Oa6f31Lc0HvB+5Ck8KM4+ZIpay2u8
	DmdOTVe8+onJ1Qg==
X-Received: from qkbbl7.prod.google.com ([2002:a05:620a:1a87:b0:8b2:e470:aa2])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:4455:b0:8c5:2e83:d023 with SMTP id af79cd13be357-8c6cce3b6d3mr1033579485a.64.1769057842851;
 Wed, 21 Jan 2026 20:57:22 -0800 (PST)
Date: Thu, 22 Jan 2026 04:57:16 +0000
In-Reply-To: <20260122045720.1221017-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260122045720.1221017-1-edumazet@google.com>
X-Mailer: git-send-email 2.52.0.457.g6b5491de43-goog
Message-ID: <20260122045720.1221017-2-edumazet@google.com>
Subject: [PATCH net-next 1/4] net: always inline skb_frag_unref() and __skb_frag_unref()
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
	TAGGED_FROM(0.00)[bounces-252210-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:7979, ipnet:2a01:60a::/32, country:US];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:helo,ams.mirrors.kernel.org:rdns]
X-Rspamd-Queue-Id: 607ED61DE2
X-Rspamd-Action: no action

clang is not inlining skb_frag_unref() and __skb_frag_unref()
in gro fast path.

It also does not inline gro_try_pull_from_frag0().

Using __always_inline fixes this issue, makes the
kernel faster _and_ smaller.

Also change __skb_frag_ref(), skb_frag_ref() and skb_page_unref()
to let them inlined for the last patch in this series.

$ scripts/bloat-o-meter -t vmlinux.0 vmlinux.1
add/remove: 2/6 grow/shrink: 1/2 up/down: 218/-511 (-293)
Function                                     old     new   delta
gro_pull_from_frag0                            -     188    +188
__pfx_gro_pull_from_frag0                      -      16     +16
skb_shift                                   1125    1139     +14
__pfx_skb_frag_unref                          16       -     -16
__pfx_gro_try_pull_from_frag0                 16       -     -16
__pfx___skb_frag_unref                        16       -     -16
__skb_frag_unref                              36       -     -36
skb_frag_unref                                59       -     -59
dev_gro_receive                             1608    1514     -94
napi_gro_frags                               892     771    -121
gro_try_pull_from_frag0                      153       -    -153
Total: Before=22566192, After=22565899, chg -0.00%

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 include/linux/skbuff_ref.h | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/include/linux/skbuff_ref.h b/include/linux/skbuff_ref.h
index 9e49372ef1a05efdfd4cb42973fbce109332d5bf..05c8486bafac83dba4e52ffee23d8a19c92b8f27 100644
--- a/include/linux/skbuff_ref.h
+++ b/include/linux/skbuff_ref.h
@@ -15,7 +15,7 @@
  *
  * Takes an additional reference on the paged fragment @frag.
  */
-static inline void __skb_frag_ref(skb_frag_t *frag)
+static __always_inline void __skb_frag_ref(skb_frag_t *frag)
 {
 	get_netmem(skb_frag_netmem(frag));
 }
@@ -27,14 +27,14 @@ static inline void __skb_frag_ref(skb_frag_t *frag)
  *
  * Takes an additional reference on the @f'th paged fragment of @skb.
  */
-static inline void skb_frag_ref(struct sk_buff *skb, int f)
+static __always_inline void skb_frag_ref(struct sk_buff *skb, int f)
 {
 	__skb_frag_ref(&skb_shinfo(skb)->frags[f]);
 }
 
 bool napi_pp_put_page(netmem_ref netmem);
 
-static inline void skb_page_unref(netmem_ref netmem, bool recycle)
+static __always_inline void skb_page_unref(netmem_ref netmem, bool recycle)
 {
 #ifdef CONFIG_PAGE_POOL
 	if (recycle && napi_pp_put_page(netmem))
@@ -51,7 +51,7 @@ static inline void skb_page_unref(netmem_ref netmem, bool recycle)
  * Releases a reference on the paged fragment @frag
  * or recycles the page via the page_pool API.
  */
-static inline void __skb_frag_unref(skb_frag_t *frag, bool recycle)
+static __always_inline void __skb_frag_unref(skb_frag_t *frag, bool recycle)
 {
 	skb_page_unref(skb_frag_netmem(frag), recycle);
 }
@@ -63,7 +63,7 @@ static inline void __skb_frag_unref(skb_frag_t *frag, bool recycle)
  *
  * Releases a reference on the @f'th paged fragment of @skb.
  */
-static inline void skb_frag_unref(struct sk_buff *skb, int f)
+static __always_inline void skb_frag_unref(struct sk_buff *skb, int f)
 {
 	struct skb_shared_info *shinfo = skb_shinfo(skb);
 
-- 
2.52.0.457.g6b5491de43-goog


