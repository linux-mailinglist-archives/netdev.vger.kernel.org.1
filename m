Return-Path: <netdev+bounces-275889-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QGjpJ4+41GnQwgcAu9opvQ
	(envelope-from <netdev+bounces-275889-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 09:55:59 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1844E3AB03D
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 09:55:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 47C1D3008A6A
	for <lists+netdev@lfdr.de>; Tue,  7 Apr 2026 07:55:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA6503A0E93;
	Tue,  7 Apr 2026 07:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GXicfMcT";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="f71HlJTx"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67F043947BE
	for <netdev@vger.kernel.org>; Tue,  7 Apr 2026 07:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775548545; cv=none; b=KgkaBtEIHEihpAFrZKzFE8Vw+ChRHRZ3gmnNCizvBv1xw2+ppAo9kJafhdytF94l7Qlg7XWuujEl8thnUharkL2suV2VA+prP4CFUVBOZJAmPdZaSwkqPlRzt4qxpMGX1fjQCjybOp4TGAxuySw2Gp1ksGuWrYWA8Aw+Qcr32qg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775548545; c=relaxed/simple;
	bh=lZwE8+8fU1S6aNAMLGE29U23GXG1l+zBtEsRvywrXcI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=neEiTetytKX6uSeRFRMXvt5zXt9qBi/8WMx5j3VqzTI/kQDiSQCWCgQhSDxUOFrMqaGzM1Ag/DGEEXNCF7WcMYk6IvBMwK/+MBhRix9SZdz6INpQ6inP8XN+A848/qVBrkn9N/uyB/14ER0raWTC3JogBJF+qxXSYQ1GGqsx38Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GXicfMcT; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=f71HlJTx; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1775548543;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BvyRL/ekukwKUYPQCImIuLruuyX70KUh23jlsa4wAHk=;
	b=GXicfMcTqhQ8X/cYJ8NnqDafyhkTqGED0tYcfxNzRjQgYVxOepyXPl/LXA27FpVNVFd7+q
	ig7nMbfYv/wpM10Lr3/clxC83znrSO6vZ4aJb+FM+3VNxfW+SgMWkyoqlfkn3v/ebmjtzd
	6EG2zgTDSKXUhCB8e9K2WtzCHUHIZeY=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-671-R0YPW2efMWqLsjkpNblbzQ-1; Tue, 07 Apr 2026 03:55:42 -0400
X-MC-Unique: R0YPW2efMWqLsjkpNblbzQ-1
X-Mimecast-MFC-AGG-ID: R0YPW2efMWqLsjkpNblbzQ_1775548541
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-488c0fcc6deso1002965e9.2
        for <netdev@vger.kernel.org>; Tue, 07 Apr 2026 00:55:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1775548541; x=1776153341; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BvyRL/ekukwKUYPQCImIuLruuyX70KUh23jlsa4wAHk=;
        b=f71HlJTxwV1UjXpfz69TKcr5MZv7TuV/jlcvArpMDzDxHxG7cDvR5H7qUbDYkvliZS
         UY9teOcqKpEer/iOaTRMFvFAH9yFtw2zMjY1BVI/beCdpkoC87unzxHTzgvL9eFEgAUb
         EfRpOhu+32LOIVYPBoRJ+UcGv/9AEpyfqyVT+foXaP8hU4QG3ZWnp5sMu+lfmxrb8Li1
         ArnKDxE+qIos6Un2AKCMVhldOhbKNvPZ1+lUEcLWJYGrvXhnm3k5JFeTdjnDJJ70SQ+q
         bha1i+/6B9i35GJxZNEv5Fa9Xn7CjD9DHANX84ERYf85PgW7jyvfF8iPTPTqH86sVmXu
         CYCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775548541; x=1776153341;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BvyRL/ekukwKUYPQCImIuLruuyX70KUh23jlsa4wAHk=;
        b=YkM28a7Jtmkb04qWUnU2f7Iv2UWNfnOwIwIQNm363C8vxTXbEJI9jFAwBIg09bu/sa
         MP3OBeY5Uco7ZFatbHHBwbCKNtFpB8AvA1aJUNccoT0A5spk4OVHy0yljllX5dSz0x3B
         sKtt6wpBbijMkl2YQ9cSm3r16hVN9t6mMNe0HkbStG3jUb6WjZ01RLeUIqi3ogDJ+0Gs
         KMEY960gXHkXQd2SLTmDs/UzGyxR6ORsiZCd1ZC1SIHaVdHtMIQHZghlM9J3huA569cQ
         ge6WQTbt8XBDUos+cGTvxz6nqpxdWY3pHpWoK7c9IDCOUnZqvGciGe7A+kAQdk0VJDwD
         X2WQ==
X-Forwarded-Encrypted: i=1; AJvYcCWfDWvI3ERZwiBDD9JI5wSyo5TqlOOeaai1LY7clSnCYfNei8pmf0NImgA4GZE4tL1HEhlihs8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxkC+oqqZnBvmdD0Xp5Yc3OaLh74gTyoBNUijKV6J848ggZxeRt
	8uYZXGiHERGmRGVzTubgkUMwUfjvnboEOh185x78f0Q7a+cQz7WuYHYRtrlhSXbQi6srqSVq/zs
	J0Cc/iys31S2w+4hF3R38SsCjSWAnRujjPsXA5FhJz4hCQouydGmcp3iwsA==
X-Gm-Gg: AeBDietC4W/I8ZI/1y9Irc78QsnYffe1zO3wN2ETYLlIguVp/UkCZlPnKCSdMteQzCu
	mrInpUybmSe7UeP48ycLuWwS8hzKicPKbDhGjjRwhWG6Dg+IU7Fjh234i7yI3BCzYQ8AsrGnaNh
	fBjrxWrvaHlD9Xmy4/lLB54YbzL5bm4vS3Fu/Dc/cP0+dNO2xw1Vbxumg46kunhM7E5oqzz/VTC
	h1YeWf4bOzeofNi8m+IdDLuFWFcN5XyjgaGFCxXaieMf/22++DksZ3+pm3lXId4tCgbX61yZIZS
	oW/ZQw05oPvudywit+KOkWZVmU7eQqLLYrYqX4b166PvhLidl4xnaCxGe6n5v+kxEEZU1wiqMDL
	ukC412CHo5VJUePlPyMpBz9LfUSFvb2PZQvR1gg+gjWk1y1wwCuT1fWwVog==
X-Received: by 2002:a05:600c:1d1d:b0:487:55c:e0c1 with SMTP id 5b1f17b1804b1-488997854ebmr211150715e9.14.1775548540807;
        Tue, 07 Apr 2026 00:55:40 -0700 (PDT)
X-Received: by 2002:a05:600c:1d1d:b0:487:55c:e0c1 with SMTP id 5b1f17b1804b1-488997854ebmr211150265e9.14.1775548540265;
        Tue, 07 Apr 2026 00:55:40 -0700 (PDT)
Received: from [192.168.88.32] ([212.105.153.231])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48899ec1898sm112799895e9.33.2026.04.07.00.55.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Apr 2026 00:55:39 -0700 (PDT)
Message-ID: <4f744383-1dc1-415a-a8da-5fe8f59daa35@redhat.com>
Date: Tue, 7 Apr 2026 09:55:37 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] net: fix skb_ext_total_length() BUILD_BUG_ON with
 CONFIG_GCOV_PROFILE_ALL
To: Konstantin Khorenko <khorenko@virtuozzo.com>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>
Cc: Simon Horman <horms@kernel.org>, =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?=
 <linux@weissschuh.net>, Arnd Bergmann <arnd@arndb.de>,
 Peter Oberparleiter <oberpar@linux.ibm.com>,
 Mikhail Zaslonko <zaslonko@linux.ibm.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Pavel Tikhomirov <ptikhomirov@virtuozzo.com>,
 Vasileios Almpanis <vasileios.almpanis@virtuozzo.com>
References: <20260402140558.1437002-1-khorenko@virtuozzo.com>
 <20260402140558.1437002-2-khorenko@virtuozzo.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260402140558.1437002-2-khorenko@virtuozzo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[13];
	TAGGED_FROM(0.00)[bounces-275889-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1844E3AB03D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 4/2/26 4:05 PM, Konstantin Khorenko wrote:
> When CONFIG_GCOV_PROFILE_ALL=y is enabled, the kernel fails to build:
> 
>   In file included from <command-line>:
>   In function 'skb_extensions_init',
>       inlined from 'skb_init' at net/core/skbuff.c:5214:2:
>   ././include/linux/compiler_types.h:706:45: error: call to
>     '__compiletime_assert_1490' declared with attribute error:
>     BUILD_BUG_ON failed: skb_ext_total_length() > 255
> 
> CONFIG_GCOV_PROFILE_ALL adds -fprofile-arcs -ftest-coverage
> -fno-tree-loop-im to CFLAGS globally. GCC inserts branch profiling
> counters into the skb_ext_total_length() loop and, combined with
> -fno-tree-loop-im (which disables loop invariant motion), cannot
> constant-fold the result.
> BUILD_BUG_ON requires a compile-time constant and fails.
> 
> The issue manifests in kernels with 5+ SKB extension types enabled
> (e.g., after addition of SKB_EXT_CAN, SKB_EXT_PSP). With 4 extensions
> GCC can still unroll and fold the loop despite GCOV instrumentation;
> with 5+ it gives up.
> 
> Mark skb_ext_total_length() with __no_profile to prevent GCOV from
> inserting counters into this function. Without counters the loop is
> "clean" and GCC can constant-fold it even with -fno-tree-loop-im active.
> This allows BUILD_BUG_ON to work correctly while keeping GCOV profiling
> for the rest of the kernel.
> 
> This also removes the CONFIG_KCOV_INSTRUMENT_ALL preprocessor guard
> introduced by d6e5794b06c0, as __no_profile handles both GCOV and KCOV
> instrumentation at the root cause level rather than just disabling the
> check.
> 
> Fixes: 5d21d0a65b57 ("net: generalize calculation of skb extensions length")
> Fixes: d6e5794b06c0 ("net: avoid build bug in skb extension length calculation")
> 
> Signed-off-by: Konstantin Khorenko <khorenko@virtuozzo.com>

No empty lines in the tags area.

Also given the commit description, isn't the introduction of the 5th skb
extension a better fixes tag?

> Reviewed-by: Thomas Weißschuh <linux@weissschuh.net>
> ---
>  net/core/skbuff.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/net/core/skbuff.c b/net/core/skbuff.c
> index 0e217041958a..47c7f0ab6e84 100644
> --- a/net/core/skbuff.c
> +++ b/net/core/skbuff.c
> @@ -5145,7 +5145,7 @@ static const u8 skb_ext_type_len[] = {
>  #endif
>  };
>  
> -static __always_inline unsigned int skb_ext_total_length(void)
> +static __always_inline __no_profile unsigned int skb_ext_total_length(void)
>  {
>  	unsigned int l = SKB_EXT_CHUNKSIZEOF(struct skb_ext);
>  	int i;
> @@ -5159,9 +5159,7 @@ static __always_inline unsigned int skb_ext_total_length(void)
>  static void skb_extensions_init(void)
>  {
>  	BUILD_BUG_ON(SKB_EXT_NUM > 8);
> -#if !IS_ENABLED(CONFIG_KCOV_INSTRUMENT_ALL)
>  	BUILD_BUG_ON(skb_ext_total_length() > 255);
> -#endif

Sashiko notes that there could be still build breakage:

https://sashiko.dev/#/patchset/20260402140558.1437002-1-khorenko%40virtuozzo.com

Could you please double check the above?

I think a 'noinline' in skb_extensions_init() would address any
complains on patch 2/2

/P

>  
>  	skbuff_ext_cache = kmem_cache_create("skbuff_ext_cache",
>  					     SKB_EXT_ALIGN_VALUE * skb_ext_total_length(),


