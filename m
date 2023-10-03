Return-Path: <netdev+bounces-37747-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B520F7B6F23
	for <lists+netdev@lfdr.de>; Tue,  3 Oct 2023 18:58:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 26D212812BF
	for <lists+netdev@lfdr.de>; Tue,  3 Oct 2023 16:58:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B7A837CB3;
	Tue,  3 Oct 2023 16:58:39 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1740D2EB
	for <netdev@vger.kernel.org>; Tue,  3 Oct 2023 16:58:37 +0000 (UTC)
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14559D3
	for <netdev@vger.kernel.org>; Tue,  3 Oct 2023 09:58:35 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-690d8fb3b7eso894365b3a.1
        for <netdev@vger.kernel.org>; Tue, 03 Oct 2023 09:58:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1696352314; x=1696957114; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xB+S1YCmVNYqbqAQ+T3/ufqEOj65Grfc2veRvmhXV5E=;
        b=A7k4esaBepFg9Ms+jKEKL/+s/kFhoNew3h8xjX8SUh2uq2oh4rlpJ/IS0EqijK6h/4
         XYzBxNeqc6tmm+GFiP+DPgvKSuD3BGqK2eiNQSdAY/jLyEyJ3rCCbQv3xsTlTZXkV9or
         ENDAadaF1k2ZZB0yqOTTilxMJcO8Lj1bVLPAmFgOlJmb+4ABlLZXxVZf9oqy0+fdHO4B
         URgaCpg5xVbp19bUezC2yZoZ+E41I3ZS9Wp83q56s/NTjXyhHF/VErODL42TKPFUagJv
         /x4u8NM+N0VREyhS3HhDkFqvrb9uA+/TfGOUc7iprkPp0ahFyZ/FZTq+vgrwSU+DWtqJ
         I9tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696352314; x=1696957114;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xB+S1YCmVNYqbqAQ+T3/ufqEOj65Grfc2veRvmhXV5E=;
        b=oe3e8/an8Ok1nH4gZS0fMo7QBebUa1Z9bncLbEVqpa+ODzsbVBe1KMujaWFP7gGl41
         0J/W5p624miD5rLsN24bAI8IpYkgkq3o2+y2biNRVY+DlrwuJyD+vk5FgQ7g4VoYINaC
         o/V/YzrcPhEm+mN2CMCEY5ggmfBgqy61K17bGcAbbxQR4WEaM/2HyqeibMQa3jMN5P/Y
         x2tjTc69rtp7g4D0PHdfPejspUYHQVKg6kDkWATl0tPpKEXVTJUfSanNhsyxxrRY4e4z
         a9Tw/WrIIFJinKbbVq9ldU2T2y7gpHprOH1shvlY33vfuK6yZdSeQgTb6lLtpADpuoUI
         UFrQ==
X-Gm-Message-State: AOJu0YzGjrI0LLb8kEZOsR8iIdsxPx2UNWXN4kbAdCHGkJZoxNHc5P9A
	Bz1Pfhx46rj4TEzJqG4O4V388A==
X-Google-Smtp-Source: AGHT+IHJTXVcg0erc8ScctpbfOr4hzSjMSi6Uc5LT6rdnqMehBDMTcjvTkv0ZK5e6iy2SR4qgnr9SQ==
X-Received: by 2002:a05:6a00:b84:b0:68c:49e4:bd71 with SMTP id g4-20020a056a000b8400b0068c49e4bd71mr137218pfj.34.1696352314477;
        Tue, 03 Oct 2023 09:58:34 -0700 (PDT)
Received: from hermes.local (204-195-126-68.wavecable.com. [204.195.126.68])
        by smtp.gmail.com with ESMTPSA id j7-20020a62b607000000b0068bbd43a6e2sm1651877pff.10.2023.10.03.09.58.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Oct 2023 09:58:34 -0700 (PDT)
Date: Tue, 3 Oct 2023 09:58:32 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Michael Pratt <mcpratt@protonmail.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Rafal Milecki <zajec5@gmail.com>, Christian Marangi
 <ansuelsmth@gmail.com>, Michael Pratt <mcpratt@pm.me>
Subject: Re: [PATCH 1/2] mac_pton: support MAC addresses with other
 delimiters
Message-ID: <20231003095832.2fce1e16@hermes.local>
In-Reply-To: <20231002233946.16703-2-mcpratt@protonmail.com>
References: <20231002233946.16703-1-mcpratt@protonmail.com>
	<20231002233946.16703-2-mcpratt@protonmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, 02 Oct 2023 23:40:02 +0000
Michael Pratt <mcpratt@protonmail.com> wrote:

> From: Michael Pratt <mcpratt@pm.me>
> 
> Some network hardware vendors may do something unique
> when storing the MAC address into hardware in ASCII,
> like using hyphens as the delimiter.
> 
> Allow parsing of MAC addresses with a non-standard
> delimiter (punctuation other than a colon).
> 
> e.g. aa-bb-cc-dd-ee-ff
> 
> Signed-off-by: Michael Pratt <mcpratt@pm.me>
> ---
>  lib/net_utils.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/lib/net_utils.c b/lib/net_utils.c
> index 42bb0473fb22..ecb7625e1dec 100644
> --- a/lib/net_utils.c
> +++ b/lib/net_utils.c
> @@ -18,7 +18,7 @@ bool mac_pton(const char *s, u8 *mac)
>  	for (i = 0; i < ETH_ALEN; i++) {
>  		if (!isxdigit(s[i * 3]) || !isxdigit(s[i * 3 + 1]))
>  			return false;
> -		if (i != ETH_ALEN - 1 && s[i * 3 + 2] != ':')
> +		if (i != ETH_ALEN - 1 && !ispunct(s[i * 3 + 2]))

Having looked at same thing in DPDK already, this looks overly broad.
There are only two common formats in the standards (isn't it fun
when standards disagree). IETF uses colon separator and IEEE uses
hyphen separator. Linux convention is colon, and  Windows convention
is hyphen. There is also the old Cisco 3 part format with periods
but adding that makes no sense.

Also, it would be bad to allow bogus values where two different
types of punctuation are used.

