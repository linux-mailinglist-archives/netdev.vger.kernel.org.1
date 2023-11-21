Return-Path: <netdev+bounces-49749-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 851107F35DE
	for <lists+netdev@lfdr.de>; Tue, 21 Nov 2023 19:24:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B5C521C20D4C
	for <lists+netdev@lfdr.de>; Tue, 21 Nov 2023 18:24:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0205822093;
	Tue, 21 Nov 2023 18:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fd9CfIlf"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 238B897
	for <netdev@vger.kernel.org>; Tue, 21 Nov 2023 10:24:09 -0800 (PST)
Received: by mail-qt1-x82c.google.com with SMTP id d75a77b69052e-41cd444d9d0so34247671cf.2
        for <netdev@vger.kernel.org>; Tue, 21 Nov 2023 10:24:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700591048; x=1701195848; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WnlM3z4xwkBnzJcR0HXYmhuC08BZvq4CiHKFX7J9S0Q=;
        b=Fd9CfIlfYt72awP22YAPGzO2VgkfXKavdASOv7f8eBl9T2KQLWTA4d7l06zo8APoLT
         ra7b0IL6E5esaLUlq36qIyxb3pNbQVZF++bP9jStGDW8Kaqq4cisjpm591EV+jHh+vA6
         hicTwg7utlZIaJvJ4/owbTMyqIzqKIgsFjEIEO5V1B1KTLhC1BXS7mKVo7e6igh86gfJ
         EipVOKDTn6ieVthW4GQLTNhJyeINAs4n2kSV3g9NKAVUgdlPfjm0XLiYh7zZV9qr15KQ
         qOm2FkZiOcowAUgTw7oEjgh7oo8QjFhSGOJFLjjyqaPKsVA6bahyX6jl1nmYiOUM/2bb
         vpAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700591048; x=1701195848;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=WnlM3z4xwkBnzJcR0HXYmhuC08BZvq4CiHKFX7J9S0Q=;
        b=RlZ9TB93GwvJgWNu07Y7KhYsAO+aop+nOOwfMNoYocBugI0rdiNcVDS5zAUfdrcAr7
         DJiqjyG0q/n3Y8mXxy90HSafCEKn+YpQ1WeAwLFUgu8o/feIbDr6r1OIP3SMzUTjGJxQ
         idSYgxdJnovV5K77poTu/gFLmW4SA8ROq+U/odeQdxVso/KvsyBaS8ayfwI51MX40v2h
         O7wZ96v5zbSoGPSGtOh/B06UtIilIp68TGdO+EL9l+Yr+KHrPlhcgw1ttavWHThL+1OK
         Vtm+jM3towjIXbI2N0q/q4MsXdM0FyD+tSFnuLB6vjDrjuP9G3XJxCihBL0rKHI/3mYb
         E9SQ==
X-Gm-Message-State: AOJu0Yzr8jIxCztApivBhzKGP85D3+PWj2aITcW4HZQJFSLXBCuBNTLl
	Pgcm4e9brpmPEb2Nk5+natw=
X-Google-Smtp-Source: AGHT+IFFBfVVwXADhGATKPS47bSRpWC5YDsXGog+TdG+OVtlAA9b3MVvtvGQimdaXkIyk24qaqdnig==
X-Received: by 2002:ac8:71c1:0:b0:423:724a:9a26 with SMTP id i1-20020ac871c1000000b00423724a9a26mr2131890qtp.68.1700591048227;
        Tue, 21 Nov 2023 10:24:08 -0800 (PST)
Received: from localhost (240.157.150.34.bc.googleusercontent.com. [34.150.157.240])
        by smtp.gmail.com with ESMTPSA id b9-20020ac86bc9000000b0041817637873sm3791438qtt.9.2023.11.21.10.24.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Nov 2023 10:24:07 -0800 (PST)
Date: Tue, 21 Nov 2023 13:24:07 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>, 
 davem@davemloft.net
Cc: netdev@vger.kernel.org, 
 edumazet@google.com, 
 pabeni@redhat.com, 
 almasrymina@google.com, 
 hawk@kernel.org, 
 ilias.apalodimas@linaro.org, 
 dsahern@gmail.com, 
 dtatulea@nvidia.com, 
 Jakub Kicinski <kuba@kernel.org>
Message-ID: <655cf5c7874bd_378cc9294f4@willemb.c.googlers.com.notmuch>
In-Reply-To: <20231121000048.789613-9-kuba@kernel.org>
References: <20231121000048.789613-1-kuba@kernel.org>
 <20231121000048.789613-9-kuba@kernel.org>
Subject: Re: [PATCH net-next v2 08/15] net: page_pool: add nlspec for basic
 access to page pools
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Jakub Kicinski wrote:
> Add a Netlink spec in YAML for getting very basic information
> about page pools.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
>  Documentation/netlink/specs/netdev.yaml | 46 +++++++++++++++++++++++++
>  1 file changed, 46 insertions(+)
> 
> diff --git a/Documentation/netlink/specs/netdev.yaml b/Documentation/netlink/specs/netdev.yaml
> index 14511b13f305..84ca3c2ab872 100644
> --- a/Documentation/netlink/specs/netdev.yaml
> +++ b/Documentation/netlink/specs/netdev.yaml
> @@ -86,6 +86,34 @@ name: netdev
>               See Documentation/networking/xdp-rx-metadata.rst for more details.
>          type: u64
>          enum: xdp-rx-metadata
> +  -
> +    name: page-pool
> +    attributes:
> +      -
> +        name: id
> +        doc: Unique ID of a Page Pool instance.
> +        type: uint
> +        checks:
> +          min: 1
> +          max: u32-max
> +      -
> +        name: ifindex
> +        doc: |
> +          ifindex of the netdev to which the pool belongs.
> +          May be reported as 0 if the page pool was allocated for a netdev
> +          which got destroyed already (page pools may outlast their netdevs
> +          because they wait for all memory to be returned).
> +        type: u32
> +        checks:
> +          min: 1
> +          max: s32-max
> +      -
> +        name: napi-id
> +        doc: Id of NAPI using this Page Pool instance.
> +        type: uint
> +        checks:
> +          min: 1
> +          max: u32-max

Do you want to introduce a separate ID for page pools? That brings some
issues regarding network namespace isolation.

As a user API, it is also possible (and intuitive?) to refer to a
page_pool by (namespacified) ifindex plus netdev_rx_queue index,
or napi_id.

In fairness, napi_id is also global, not per netns.

By iterating over "for_each_netdev(net, ..", dump already limits
output to pools in the same netns and get only reports pools that
match the netns.

So it's only a minor matter of visible numbering, and perhaps
superfluous new id.

No technical comments to this series. Looks solid to me.

