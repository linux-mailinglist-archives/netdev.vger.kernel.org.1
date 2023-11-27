Return-Path: <netdev+bounces-51363-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4BF57FA555
	for <lists+netdev@lfdr.de>; Mon, 27 Nov 2023 16:55:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1BB481C209E3
	for <lists+netdev@lfdr.de>; Mon, 27 Nov 2023 15:55:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F5EC347A0;
	Mon, 27 Nov 2023 15:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IkA3SKIV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB80A92;
	Mon, 27 Nov 2023 07:55:02 -0800 (PST)
Received: by mail-oi1-x229.google.com with SMTP id 5614622812f47-3b861a3be3eso1181966b6e.0;
        Mon, 27 Nov 2023 07:55:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701100502; x=1701705302; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+99aoCcs4VcRRjnd4ABIm3+igMsBj2nosPKDWuod+R8=;
        b=IkA3SKIVW4Hsa1eRfeI9QDNPojKONP3L/sOGYrMjDuTR2L7Rh8ihNriu69lJHnQQUK
         4ZqqL39E37+YAQZ7NGvd+G5HKBHZ3NLvSO4fK04dvfyRCWZbRDMWPfrchqtvW+gPQ5nt
         iwvkNtMeynjdwiA9yA5P0c+vX1iDXppdhqSV4FwYUh1tCsksEeV7UuUbZggylMwoCNy9
         +k8bwwGQVBix3y9jLfaZze1OFWEdnAAsjkVppXR+oLJjSS6sSM2xpAgBmOjJE+yHrzGv
         5QSmYAgh3J8btaJCExdZGPgR8P/7iYoE2O3wO9EcfGJLYyUqpv2rDkxE8P7j0zrFl+Us
         SHdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701100502; x=1701705302;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+99aoCcs4VcRRjnd4ABIm3+igMsBj2nosPKDWuod+R8=;
        b=oPeIx5A2FUMiK9QJZ3AQ8CouW/efabC7wqIYlOqmJkn4ers6NlInN7n4GjzMT5MepM
         bsnlNwr5noRNZJj3kifvYrNwRFMHbIHaDQnhFsLFzsJonvRaoMntbmdm0mVZbu/dMSLZ
         3X+Kf/E4EjdyYp7SCY45qQt14tC8gO2d14Aq8WZZqODwwQ8167RLw31YOsTES5yZ3cSJ
         IPzwYRTesIOk+l7XWtV9BJsxeN71K7G8A4ju0t02iytDPoRruystFvQQToucwD19dBrZ
         SuLWP+sCE+0El8t5HJmGJd2QFpDd/Y8pZF8TmryAertPh2kKB5t1ygMfy9OdOiumaLiF
         u2Qw==
X-Gm-Message-State: AOJu0Yy/F49m3MUyaNNxtn1r2jhpQEPlCfZCKjDoZ+UUdmzwxSziga5T
	HOKhR9gmtzlZ4lnKIeDlITk=
X-Google-Smtp-Source: AGHT+IGpJjATOQuoZq9OiDhL4fJxgNVSZh3aegQLNrGHTmQ3rNYq18czjkieYGRC2vNFrGRE0IOlYQ==
X-Received: by 2002:a05:6808:3c9:b0:3b8:6380:e9ec with SMTP id o9-20020a05680803c900b003b86380e9ecmr6593757oie.55.1701100501957;
        Mon, 27 Nov 2023 07:55:01 -0800 (PST)
Received: from localhost (240.157.150.34.bc.googleusercontent.com. [34.150.157.240])
        by smtp.gmail.com with ESMTPSA id du3-20020a05621409a300b0067a2bda64a3sm2369426qvb.2.2023.11.27.07.55.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Nov 2023 07:55:01 -0800 (PST)
Date: Mon, 27 Nov 2023 10:55:01 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Shigeru Yoshida <syoshida@redhat.com>, 
 davem@davemloft.net, 
 dsahern@kernel.org, 
 edumazet@google.com, 
 kuba@kernel.org, 
 pabeni@redhat.com
Cc: netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Shigeru Yoshida <syoshida@redhat.com>
Message-ID: <6564bbd5580de_8a1ac29481@willemb.c.googlers.com.notmuch>
In-Reply-To: <20231126151652.372783-1-syoshida@redhat.com>
References: <20231126151652.372783-1-syoshida@redhat.com>
Subject: Re: [PATCH net] ipv4: ip_gre: Handle skb_pull() failure in
 ipgre_xmit()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Shigeru Yoshida wrote:
> In ipgre_xmit(), skb_pull() may fail even if pskb_inet_may_pull() returns
> true. For example, applications can create a malformed packet that causes
> this problem with PF_PACKET.

It may fail because because pskb_inet_may_pull does not account for
tunnel->hlen.

Is that what you are referring to with malformed packet? Can you
eloborate a bit on in which way the packet has to be malformed to
reach this?

FYI: I had a quick look at the IPv6 equivalent code.
ip6gre_tunnel_xmit is sufficiently different. It makes sense that this
is an IPv4 only patch.

> This patch fixes the problem by dropping skb and returning from the
> function if skb_pull() fails.
> 
> Fixes: c54419321455 ("GRE: Refactor GRE tunneling code.")
> Signed-off-by: Shigeru Yoshida <syoshida@redhat.com>
> ---
>  net/ipv4/ip_gre.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/net/ipv4/ip_gre.c b/net/ipv4/ip_gre.c
> index 22a26d1d29a0..95efa97cb84b 100644
> --- a/net/ipv4/ip_gre.c
> +++ b/net/ipv4/ip_gre.c
> @@ -643,7 +643,8 @@ static netdev_tx_t ipgre_xmit(struct sk_buff *skb,
>  		/* Pull skb since ip_tunnel_xmit() needs skb->data pointing
>  		 * to gre header.
>  		 */
> -		skb_pull(skb, tunnel->hlen + sizeof(struct iphdr));
> +		if (!skb_pull(skb, tunnel->hlen + sizeof(struct iphdr)))
> +			goto free_skb;
>  		skb_reset_mac_header(skb);
>  
>  		if (skb->ip_summed == CHECKSUM_PARTIAL &&
> -- 
> 2.41.0
> 



