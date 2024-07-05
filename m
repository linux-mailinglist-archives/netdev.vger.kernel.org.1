Return-Path: <netdev+bounces-109576-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 71435928F1F
	for <lists+netdev@lfdr.de>; Sat,  6 Jul 2024 00:01:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 009061F23B44
	for <lists+netdev@lfdr.de>; Fri,  5 Jul 2024 22:01:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73DCC13DDB5;
	Fri,  5 Jul 2024 22:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=waldekranz-com.20230601.gappssmtp.com header.i=@waldekranz-com.20230601.gappssmtp.com header.b="SYfbTbYD"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CA7F13C904
	for <netdev@vger.kernel.org>; Fri,  5 Jul 2024 22:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720216862; cv=none; b=tFyKlUJ6DPy+eLnr+bbvO8K6aNp+Yv2que0N7kRTV271TVhqzZjiENeg/YVSehswtxxjcvNuKSIj3Pnnfs1ugZktwRtAEjWluXkIMrSh1hV79uf6ofKZlkNjwVWUEA+CMpE1X4ERhL31pn5T1v52+NTMEmiXEsV9dCl6M1+UYgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720216862; c=relaxed/simple;
	bh=cRlLcPvgdYI+0d5Q121mKPf07KB4cpgC4kaVtDmI6ao=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=spcpAgJfl0GaX76/LODcqXxNmHqESzeF86NVHxfHr7asDk5qXTz2V/tusjUjZX+qNBk1dPCqAyby8Bd5NxCucaj4HNZR/LP58/t3sWykCosVy5fPYs+2ey8qTpm8qf0PgFE1eoKZ6QBdlVGHQdn569cXk9M5iDUjMqXKLS6v1Zw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=waldekranz.com; spf=pass smtp.mailfrom=waldekranz.com; dkim=pass (2048-bit key) header.d=waldekranz-com.20230601.gappssmtp.com header.i=@waldekranz-com.20230601.gappssmtp.com header.b=SYfbTbYD; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=waldekranz.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=waldekranz.com
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-52ea2f58448so2279836e87.1
        for <netdev@vger.kernel.org>; Fri, 05 Jul 2024 15:00:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=waldekranz-com.20230601.gappssmtp.com; s=20230601; t=1720216858; x=1720821658; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=wBckyEFwh/Rys/nHKmjk7v967dXh+ZDDYWaIn/2UGq0=;
        b=SYfbTbYDQz/axrX9XOQUknkEm+d1tTBjJWWXVSyIa1At+3bylle2WqWNxuISyDerK7
         ynTu9RnePZlJGCNuphhLdn/S0PppuzUG1Jnmg2qkVLLILven1cYx3CXPr1AfW8vo2ppR
         zGbMa/Tc1wuuM6AoNgpYpy7/sPuRVanF3eIMpy31043E5aC1YmP/JvPkSMTbBzEhOOG0
         B6Jx3l4IbjVHohMW+ALxGT7ZD7858pQil+5WYbeDuy63gG8FxIUqFRH514wP+fFwRwzl
         g5+NKIgNEYArfKKkDXD9WgTiBmAoVNX7C8x4C26uDWRGkBNDoMikq0LEzslTVV6JakeJ
         ynXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720216858; x=1720821658;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wBckyEFwh/Rys/nHKmjk7v967dXh+ZDDYWaIn/2UGq0=;
        b=e1toYzkKMkN1ix/ieDX6fd2ZWv8hBP9pIoGA2pKBZ3fHYQVC4A1jjtewpXKobdjeFF
         SEiYN7DSOrRRA9thQBLPq8PNu/DbJZLPsTs/ut7R8snC+XeOTmcxoaUoZkuAhdrwdepp
         um5hhrHIyLrdavFMBxhM8SnkXy6QrQrW27TbP0mJQtXsJjEoCr5ee8WlyeP6JTKfM79j
         LWJib5CG2/OtmCUveIbu0RjZhPKffR2j9yChW/hZWzIo2hQTVGsRF3eVTHBh1w/TRp6u
         PE1+ay/vENuNpQ8QjHuTcnUdIREQ3uyoOgOMKo9sxqTiKmYE4ENSUrvBJpyKqqu8bM+0
         Zuuw==
X-Forwarded-Encrypted: i=1; AJvYcCXGvVXIj63x8w5a9p1uWIaRvdvcJBcm0SMIV2W3Byq0WNCSMxVSueUUF3a8N4wU25arqsoS/0bKTuCL2XjhjME6u7fI1kYB
X-Gm-Message-State: AOJu0YyEw/GM2enPTRP0dwFbjRzcOsZ4T882R3BANm95isqH+k58FpGF
	lv4ESB19N0EWksIScvEsz0AwmYI5xEHuUv6qV++vSFIq6WftbyAIazce8rll8TKvABUc97TBg92
	0
X-Google-Smtp-Source: AGHT+IEmnD1pltRm+NG29AdDzUwJcwOOmeDoXT57EhZSgEaLlRepCcFYfu+F9IeP4PfKXOWtcSR0TA==
X-Received: by 2002:a19:ca43:0:b0:52c:e1d4:8ecd with SMTP id 2adb3069b0e04-52ea061309bmr4021943e87.8.1720216858175;
        Fri, 05 Jul 2024 15:00:58 -0700 (PDT)
Received: from wkz-x13 (h-176-10-146-181.NA.cust.bahnhof.se. [176.10.146.181])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52ea6493c4esm287838e87.113.2024.07.05.15.00.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jul 2024 15:00:57 -0700 (PDT)
From: Tobias Waldekranz <tobias@waldekranz.com>
To: Elliot Ayrey <elliot.ayrey@alliedtelesis.co.nz>, davem@davemloft.net
Cc: Elliot Ayrey <elliot.ayrey@alliedtelesis.co.nz>, Roopa Prabhu
 <roopa@nvidia.com>, Nikolay Aleksandrov <razor@blackwall.org>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, bridge@lists.linux.dev, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: bridge: mst: Check vlan state for egress decision
In-Reply-To: <20240705030041.1248472-1-elliot.ayrey@alliedtelesis.co.nz>
References: <20240705030041.1248472-1-elliot.ayrey@alliedtelesis.co.nz>
Date: Sat, 06 Jul 2024 00:00:55 +0200
Message-ID: <87plrrfqi0.fsf@waldekranz.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On fre, jul 05, 2024 at 15:00, Elliot Ayrey <elliot.ayrey@alliedtelesis.co.nz> wrote:
> If a port is blocking in the common instance but forwarding in an MST
> instance, traffic egressing the bridge will be dropped because the
> state of the common instance is overriding that of the MST instance.

Can't believe I missed this - thanks!

> Fix this by temporarily forcing the port state to forwarding when in
> MST mode to allow checking the vlan state via br_allowed_egress().
> This is similar to what happens in br_handle_frame_finish() when
> checking ingress traffic, which was introduced in the change below.
>
> Fixes: ec7328b59176 ("net: bridge: mst: Multiple Spanning Tree (MST) mode")
> Signed-off-by: Elliot Ayrey <elliot.ayrey@alliedtelesis.co.nz>
> ---
>  net/bridge/br_forward.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/net/bridge/br_forward.c b/net/bridge/br_forward.c
> index d97064d460dc..911b37a38a32 100644
> --- a/net/bridge/br_forward.c
> +++ b/net/bridge/br_forward.c
> @@ -22,10 +22,16 @@ static inline int should_deliver(const struct net_bridge_port *p,
>  				 const struct sk_buff *skb)
>  {
>  	struct net_bridge_vlan_group *vg;
> +	u8 state;
> +
> +	if (br_mst_is_enabled(p->br))
> +		state = BR_STATE_FORWARDING;
> +	else
> +		state = p->state;
>  
>  	vg = nbp_vlan_group_rcu(p);
>  	return ((p->flags & BR_HAIRPIN_MODE) || skb->dev != p->dev) &&

I think it might read a bit better if we model it like the hairpin check
above. I.e. (special_mode || regular_condition)

It's not really that the state is forwarding when mst is enabled, we
simply ignore the port-global state in that case.

> -		p->state == BR_STATE_FORWARDING && br_allowed_egress(vg, skb) &&
> +		state == BR_STATE_FORWARDING && br_allowed_egress(vg, skb) &&

so something like:

    ...
    (br_mst_is_enabled(p->br) || p->state == BR_STATE_FORWARDING) &&
    br_allowed_egress(vg, skb) && nbp_switchdev_allowed_egress(p, skb) &&
    ...

>  		nbp_switchdev_allowed_egress(p, skb) &&
>  		!br_skb_isolated(p, skb);
>  }

