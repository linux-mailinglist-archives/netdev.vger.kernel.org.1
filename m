Return-Path: <netdev+bounces-90473-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D12168AE39A
	for <lists+netdev@lfdr.de>; Tue, 23 Apr 2024 13:13:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 18272B231E3
	for <lists+netdev@lfdr.de>; Tue, 23 Apr 2024 11:13:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BD487E578;
	Tue, 23 Apr 2024 11:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="gkBB9/09"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74AEF7C09F
	for <netdev@vger.kernel.org>; Tue, 23 Apr 2024 11:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713870772; cv=none; b=ZDcPH9rJtD89FocVaJMb6+RNlKeoLW4xh6h6rxpJ5Rj3ty3204rwWDUpUhGVVDd7a232Jz7VZK6I5NWpfVv8grKGYcb4SKZeokIuWHj/7PaPghGmJDSDbD0M72w5mmVv+uY601kuviMbR7qEcy0aZZ6isHs1tNi43QZxSKtAYxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713870772; c=relaxed/simple;
	bh=WK4EztFBVAHg7eYRzkCerijhdminORv97CA/HPtekR0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Svph/Fc9w0jO3O3e5bL1xvLtIbeSJh6IVM68JKXXMH1xcOYzOUTTv8kTsOF7atjkxinZ3N/CQPMaKm6aiqMDM35oQZsjp/uYmrkD+hfypCkn/W+fi0zHiK83cue4vajWMFfR2ulkkTcDXhF3PLSnyDUfrNkQXF9Ess7Ob8KIYZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=gkBB9/09; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a5224dfa9adso936470966b.0
        for <netdev@vger.kernel.org>; Tue, 23 Apr 2024 04:12:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1713870768; x=1714475568; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1GbwA9AtFu4Yu/r6+eMwCiUFKh6Xn8xW9wVevaAyhDE=;
        b=gkBB9/09VmOcjQeiyZJnWiz8KUF59wHyDdJVu8uIHybYWzikm3us1PYKBlsR62sT6f
         TyuLhEWVd/ZM01OhqIpymd58GiWuC9QSINMaQGqKNaZ0PDtebqP032xWH/gC5bR/bdP8
         mMtW/wxOGnUHvfMot9tqY9q0OY3hX1RKbvnfKw2LLKDnLfUaN0ZYEAmYSkm6TWFC3KjB
         yZRjNqiOWSqBCsK3At3aJMmKPbGSazOBwdbSK+ygybKkseecdDKCZQ8z8wT2kiSIZJjz
         rE7XxukzxxXgu16rdLRdzaknu3pzDtrAcbFmXnM8t4L7laEGN9TX88hzenifQf67fbqw
         hH7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713870768; x=1714475568;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1GbwA9AtFu4Yu/r6+eMwCiUFKh6Xn8xW9wVevaAyhDE=;
        b=Dpnej4/ul1STz368lpJpTvsoDdoTkyrg4NyIpdEWWDZ5mSg/RE2s+fsA+DFNlUcj1F
         to9kNeeyZX0iTzcUNrg5bCPwLKjTzaeyHa/GDCtB7m+6z0mXgM3jMW50Mi/h6X9oHkbN
         PW5x9dcw+h8LdtFo46EnFTR0/aqG2dKPaRCEf49fKWy1ZgvFs+gXS/Lu5yFMvv9GMwXX
         yhD0KD0Q0qmk7v5SDVTHacLjRgtWYVbLbEdUT+o0hfNtzgwVgEzm6IRVyAK2ZLGSuLNF
         T3yJnS4eC3w8gLrFcMgzlmmsyhN8USrIeu5MHvsqq2/gY6o1G+ouIj35LpcSq4Az1TWE
         5lIg==
X-Forwarded-Encrypted: i=1; AJvYcCVzL/cpXw34ejRxWZc4hRiApZ/1GRaOG0BmDqOadDb8qWugAwvu+9b3n5prm88JvNKuniHlVB66xUx9RH2lcvoaO3ARGACJ
X-Gm-Message-State: AOJu0YzY3sLu3+WDl3hSboc8wZrb02tETyWCYX0W15aPXSxtKWGqWly+
	F34NG/n5WZofo3nJsPQBuhXmzc5Y3UxBNT87SNfruJ/gRlI2ZA/hLuT5Ngxhpas=
X-Google-Smtp-Source: AGHT+IG+TtGWysDfdlawCem0S3HMY9EM/WsGwW7MbhgDMk8j9ZqeCViVLQ5g4hfRsmjhInG+O7du1A==
X-Received: by 2002:a17:906:af79:b0:a58:8602:ffa1 with SMTP id os25-20020a170906af7900b00a588602ffa1mr351273ejb.19.1713870767677;
        Tue, 23 Apr 2024 04:12:47 -0700 (PDT)
Received: from [10.100.1.125] (ip.82.144.213.21.stat.volia.net. [82.144.213.21])
        by smtp.gmail.com with ESMTPSA id t22-20020a1709063e5600b00a5209dc79c1sm7006898eji.146.2024.04.23.04.12.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Apr 2024 04:12:47 -0700 (PDT)
Message-ID: <b1fccc7c-3c9f-45e0-979f-f83dfc788613@blackwall.org>
Date: Tue, 23 Apr 2024 14:12:44 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: bridge: remove redundant check of f->dst
Content-Language: en-US
To: linke li <lilinke99@qq.com>
Cc: xujianhao01@gmail.com, Roopa Prabhu <roopa@nvidia.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 bridge@lists.linux.dev, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <tencent_616D84217798828E5D1021857C528B713406@qq.com>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <tencent_616D84217798828E5D1021857C528B713406@qq.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/23/24 13:53, linke li wrote:
> In br_fill_forward_path(), f->dst is checked not to be NULL, then
> immediately read using READ_ONCE and checked again. The first check is
> useless, so this patch aims to remove the redundant check of f->dst.
> 
> Signed-off-by: linke li <lilinke99@qq.com>
> ---
>   net/bridge/br_device.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/net/bridge/br_device.c b/net/bridge/br_device.c
> index 65cee0ad3c1b..ae33b30ff87c 100644
> --- a/net/bridge/br_device.c
> +++ b/net/bridge/br_device.c
> @@ -405,7 +405,7 @@ static int br_fill_forward_path(struct net_device_path_ctx *ctx,
>   	br_vlan_fill_forward_path_pvid(br, ctx, path);
>   
>   	f = br_fdb_find_rcu(br, ctx->daddr, path->bridge.vlan_id);
> -	if (!f || !f->dst)
> +	if (!f)
>   		return -1;
>   
>   	dst = READ_ONCE(f->dst);

This patch should target net-next (PATCH net-next in subject).
Other than that the patch seems fine.

Acked-by: Nikolay Aleksandrov <razor@blackwall.org>


