Return-Path: <netdev+bounces-39230-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88C657BE5BC
	for <lists+netdev@lfdr.de>; Mon,  9 Oct 2023 18:01:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A6972818F4
	for <lists+netdev@lfdr.de>; Mon,  9 Oct 2023 16:01:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA40537C9C;
	Mon,  9 Oct 2023 16:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="D6leI24v"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10B49374F0
	for <netdev@vger.kernel.org>; Mon,  9 Oct 2023 16:01:38 +0000 (UTC)
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56251B7
	for <netdev@vger.kernel.org>; Mon,  9 Oct 2023 09:01:37 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-690bf8fdd1aso3375557b3a.2
        for <netdev@vger.kernel.org>; Mon, 09 Oct 2023 09:01:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1696867297; x=1697472097; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fIq4Z5Y2KCiwFjSNvRCcRrRGWFulfAYmkI5Tl6YV8HY=;
        b=D6leI24vqLEOAn243F2jarb07Fa5no+OEmqLI+jsm7APEM85NtiL6Wjq61JeneHWJL
         SOdmBVHeqmruX8hTNsJXqZ12Rkwqj4dIDDMBZqtAofFT5Ht5fOqTgrLXyL2/qm0IbYcW
         duzUhu9xUJeySDjBvIeXCEREkkwulTX6rCQwc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696867297; x=1697472097;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fIq4Z5Y2KCiwFjSNvRCcRrRGWFulfAYmkI5Tl6YV8HY=;
        b=cVpdu6pDlEOyaC+00VVGEhx/Aj9EFhaKev6Hl4yL0A+wSUsAQQnumvK1nJbU41nm2J
         PnwmHCwJG8enY05cHskz8O3mv4OlQCdMMIde1ZkUxKhroa9E9ljafma1YFYyroXS8oRF
         tbqRz2bNUrYB5y8dMydKK+NUcu4hPaNA0ylRZK6AJPQvEpjgpilgp74ESLE9HOSjIGaP
         14XTQokJr8ZbomdTv1CR6evrY1wckO5TEs8modsO0xsb2YPlX/ArSpsD7iGxsTUP8AzD
         UwH8FmqSDE9ALbtYvZkJe6aRlzQO1RzmferD/F8gt3ebhY5y5Su27C+XDf0lRjEudGPR
         tY5w==
X-Gm-Message-State: AOJu0YxUAj/ESp3qsJkZIKBWy9LwbR7Fl5LJHQlaOu/FnveGr1HLIvJX
	jdawaY+k/fkKxgV6BS228IpuKg==
X-Google-Smtp-Source: AGHT+IGzWMhg2YBxKZpnPCicy+u6EYSsmxQ4VBOiMQgc178btuiuE2aejaE6C1t+/qa5G4gqgzNYNw==
X-Received: by 2002:a05:6a00:99c:b0:68f:cc67:e723 with SMTP id u28-20020a056a00099c00b0068fcc67e723mr16129844pfg.17.1696867296723;
        Mon, 09 Oct 2023 09:01:36 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id r19-20020aa78453000000b00688965c5227sm6574028pfn.120.2023.10.09.09.01.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Oct 2023 09:01:36 -0700 (PDT)
Date: Mon, 9 Oct 2023 09:01:34 -0700
From: Kees Cook <keescook@chromium.org>
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Simon Horman <horms@kernel.org>,
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org,
	Sergei Trofimovich <slyich@gmail.com>
Subject: Re: [PATCH v1 net] af_packet: Fix fortified memcpy() without flex
 array.
Message-ID: <202310090852.E9A6558@keescook>
References: <20231009153151.75688-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231009153151.75688-1-kuniyu@amazon.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Oct 09, 2023 at 08:31:52AM -0700, Kuniyuki Iwashima wrote:
> Sergei Trofimovich reported a regression [0] caused by commit a0ade8404c3b
> ("af_packet: Fix warning of fortified memcpy() in packet_getname().").
> 
> It introduced a flex array sll_addr_flex in struct sockaddr_ll as a
> union-ed member with sll_addr to work around the fortified memcpy() check.
> 
> However, a userspace program uses a struct that has struct sockaddr_ll in
> the middle, where a flex array is illegal to exist.
> 
>   include/linux/if_packet.h:24:17: error: flexible array member 'sockaddr_ll::<unnamed union>::<unnamed struct>::sll_addr_flex' not at end of 'struct packet_info_t'
>      24 |                 __DECLARE_FLEX_ARRAY(unsigned char, sll_addr_flex);
>         |                 ^~~~~~~~~~~~~~~~~~~~
> To fix the regression, let's go back to the first attempt [1] telling
> memcpy() the actual size of the array.
> 
> Reported-by: Sergei Trofimovich <slyich@gmail.com>
> Closes: https://github.com/NixOS/nixpkgs/pull/252587#issuecomment-1741733002 [0]

Eww. That's a buggy definition -- it could get overflowed.

But okay, we don't break userspace.

> Link: https://lore.kernel.org/netdev/20230720004410.87588-3-kuniyu@amazon.com/ [1]
> Fixes: a0ade8404c3b ("af_packet: Fix warning of fortified memcpy() in packet_getname().")
> Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
> ---
>  include/uapi/linux/if_packet.h | 6 +-----
>  net/packet/af_packet.c         | 7 ++++++-
>  2 files changed, 7 insertions(+), 6 deletions(-)
> 
> diff --git a/include/uapi/linux/if_packet.h b/include/uapi/linux/if_packet.h
> index 4d0ad22f83b5..9efc42382fdb 100644
> --- a/include/uapi/linux/if_packet.h
> +++ b/include/uapi/linux/if_packet.h
> @@ -18,11 +18,7 @@ struct sockaddr_ll {
>  	unsigned short	sll_hatype;
>  	unsigned char	sll_pkttype;
>  	unsigned char	sll_halen;
> -	union {
> -		unsigned char	sll_addr[8];
> -		/* Actual length is in sll_halen. */
> -		__DECLARE_FLEX_ARRAY(unsigned char, sll_addr_flex);
> -	};
> +	unsigned char	sll_addr[8];
>  };

Yup, we need to do at least this.

>  
>  /* Packet types */
> diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
> index 8f97648d652f..a84e00b5904b 100644
> --- a/net/packet/af_packet.c
> +++ b/net/packet/af_packet.c
> @@ -3607,7 +3607,12 @@ static int packet_getname(struct socket *sock, struct sockaddr *uaddr,
>  	if (dev) {
>  		sll->sll_hatype = dev->type;
>  		sll->sll_halen = dev->addr_len;
> -		memcpy(sll->sll_addr_flex, dev->dev_addr, dev->addr_len);
> +
> +		/* Let __fortify_memcpy_chk() know the actual buffer size. */
> +		memcpy(((struct sockaddr_storage *)sll)->__data +
> +		       offsetof(struct sockaddr_ll, sll_addr) -
> +		       offsetofend(struct sockaddr_ll, sll_family),
> +		       dev->dev_addr, dev->addr_len);
>  	} else {
>  		sll->sll_hatype = 0;	/* Bad: we have no ARPHRD_UNSPEC */
>  		sll->sll_halen = 0;

I still think this is a mistake. We're papering over so many lies to the
compiler. :P If "uaddr" is actually "struct sockaddr_storage", then we
should update the callers... and if "struct sockaddr_ll" doesn't have a
fixed size trailing array, we should make a new struct that is telling
the truth. ;)

Perhaps add this to the UAPI:

+struct sockaddr_ll_flex {
+       unsigned short  sll_family;
+       __be16          sll_protocol;
+       int             sll_ifindex;
+       unsigned short  sll_hatype;
+       unsigned char   sll_pkttype;
+       unsigned char   sll_halen;
+       unsigned char   sll_addr[] __counted_by(sll_halen);
+};

And update the memcpy():

-       DECLARE_SOCKADDR(struct sockaddr_ll *, sll, uaddr);
+       struct sockaddr_ll_flex * sll = (struct sockaddr_ll_flex *)uaddr;

?

-- 
Kees Cook

