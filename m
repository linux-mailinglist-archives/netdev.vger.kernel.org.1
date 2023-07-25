Return-Path: <netdev+bounces-20749-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D553760E1E
	for <lists+netdev@lfdr.de>; Tue, 25 Jul 2023 11:14:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BDD701C20D4D
	for <lists+netdev@lfdr.de>; Tue, 25 Jul 2023 09:14:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 560C014A8C;
	Tue, 25 Jul 2023 09:14:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 490478C1B
	for <netdev@vger.kernel.org>; Tue, 25 Jul 2023 09:14:21 +0000 (UTC)
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E403410C9
	for <netdev@vger.kernel.org>; Tue, 25 Jul 2023 02:14:17 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-98e39784a85so1344963366b.1
        for <netdev@vger.kernel.org>; Tue, 25 Jul 2023 02:14:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google; t=1690276456; x=1690881256;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:from:to:cc:subject:date:message-id:reply-to;
        bh=90N1opdApkJ6sofZeZLN2gsjrZklninJ72RskdGs+7M=;
        b=UPDLtLnhvE37z3PFQELXEQVb8YquW5JpuvtoFr9iv0obwYIY+gIrdJFeRZNXzVJYYp
         l0iHf/qqttV965ifMacfBlMTrUEasWcc9uULu1gCzbdYdm2gWlQ6C3ep1USnbjP0hy/q
         yIwpDDy41gNXW6+BJPKvEyEYtSGnsWTawtIqQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690276456; x=1690881256;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=90N1opdApkJ6sofZeZLN2gsjrZklninJ72RskdGs+7M=;
        b=PbiLCltjXiWoiNtYrSpyVBPoevZQBhYuvw9K11e0GMbvWjvAsYFi3bbiB+alAwDdSo
         rGCdciFnswxW7FBF8ViDPuT7WvFuhoqED5JYMloe/AtQEbwE2LDIdbyLTvabMExJ7xR4
         ZLEFzzJdQ7nC3qMnz/9Gd61g/8Gu3IBMNDk1mhemuczcxYyaSF+sIAuOYYjc90Sm/csf
         W5SW6+Gu/KdX5S0RP3cW/CzfIKt5D/U1zUARuQxiK5sWFuCCVpOhHJLwG271AqY0VSn8
         uUVpOToM+0YWPypdd9slFW2i6Wp79JEpfHuxula4oSzD2bBWSQ2WQmCIIlWvc7mjbkrB
         U7Pg==
X-Gm-Message-State: ABy/qLatMaS9MNnAukg1/uLkxS3LyNMaQ8hPxhh+7Brj4s/UUT+O25qO
	iZbRPhef6mLN/t/BAiQUQZWqZQ==
X-Google-Smtp-Source: APBJJlE0BXPyh3d6xZ70mVilCUjvGA2mpPz33nUwaLBBcFccwg8UktLJu68ohKn6RQ3Y2pDbdKDTDA==
X-Received: by 2002:a17:907:7744:b0:994:1805:1fad with SMTP id kx4-20020a170907774400b0099418051fadmr1555473ejc.10.1690276456161;
        Tue, 25 Jul 2023 02:14:16 -0700 (PDT)
Received: from cloudflare.com (79.184.214.102.ipv4.supernova.orange.pl. [79.184.214.102])
        by smtp.gmail.com with ESMTPSA id f22-20020a1709067f9600b009920f18a5f0sm7764654ejr.185.2023.07.25.02.14.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jul 2023 02:14:15 -0700 (PDT)
References: <cover.1690255889.git.yan@cloudflare.com>
 <cdbbc9df16044b568448ed9cd828d406f0851bfb.1690255889.git.yan@cloudflare.com>
User-agent: mu4e 1.6.10; emacs 28.2
From: Jakub Sitnicki <jakub@cloudflare.com>
To: Yan Zhai <yan@cloudflare.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, Daniel
 Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yhs@fb.com>, John Fastabend <john.fastabend@gmail.com>, KP
 Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo
 <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Mykola Lysenko
 <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 linux-kselftest@vger.kernel.org, Jordan Griege <jgriege@cloudflare.com>,
 kernel-team@cloudflare.com
Subject: Re: [PATCH v3 bpf 1/2] bpf: fix skb_do_redirect return values
Date: Tue, 25 Jul 2023 11:08:15 +0200
In-reply-to: <cdbbc9df16044b568448ed9cd828d406f0851bfb.1690255889.git.yan@cloudflare.com>
Message-ID: <87v8e8xsih.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Jul 24, 2023 at 09:13 PM -07, Yan Zhai wrote:
> skb_do_redirect returns various of values: error code (negative), 0
> (success), and some positive status code, e.g. NET_XMIT_CN, NET_RX_DROP.
> Such code are not handled at lwt xmit hook in function ip_finish_output2
> and ip6_finish_output, which can cause unexpected problems. This change
> converts the positive status code to proper error code.
>
> Suggested-by: Stanislav Fomichev <sdf@google.com>
> Reported-by: Jordan Griege <jgriege@cloudflare.com>
> Signed-off-by: Yan Zhai <yan@cloudflare.com>
>
> ---
> v3: converts also RX side return value in addition to TX values
> v2: code style change suggested by Stanislav Fomichev
> ---
>  net/core/filter.c | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
>
> diff --git a/net/core/filter.c b/net/core/filter.c
> index 06ba0e56e369..3e232ce11ca0 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
> @@ -2095,7 +2095,12 @@ static const struct bpf_func_proto bpf_csum_level_proto = {
>  
>  static inline int __bpf_rx_skb(struct net_device *dev, struct sk_buff *skb)
>  {
> -	return dev_forward_skb_nomtu(dev, skb);
> +	int ret = dev_forward_skb_nomtu(dev, skb);
> +
> +	if (unlikely(ret > 0))
> +		return -ENETDOWN;
> +
> +	return 0;
>  }
>  
>  static inline int __bpf_rx_skb_no_mac(struct net_device *dev,
> @@ -2106,6 +2111,8 @@ static inline int __bpf_rx_skb_no_mac(struct net_device *dev,
>  	if (likely(!ret)) {
>  		skb->dev = dev;
>  		ret = netif_rx(skb);
> +	} else if (ret > 0) {
> +		return -ENETDOWN;
>  	}
>  
>  	return ret;
> @@ -2129,6 +2136,9 @@ static inline int __bpf_tx_skb(struct net_device *dev, struct sk_buff *skb)
>  	ret = dev_queue_xmit(skb);
>  	dev_xmit_recursion_dec();
>  
> +	if (unlikely(ret > 0))
> +		ret = net_xmit_errno(ret);
> +
>  	return ret;
>  }

net_xmit_errno maps NET_XMIT_DROP to -ENOBUFS. It would make sense to me
to map NET_RX_DROP to -ENOBUFS as well, instead of -ENETDOWN, to be
consistent.

It looks like the Fixes tag for this should point to the change that
introduced BPF for LWT:

Fixes: 3a0af8fd61f9 ("bpf: BPF for lightweight tunnel infrastructure")


