Return-Path: <netdev+bounces-124434-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DA029697DC
	for <lists+netdev@lfdr.de>; Tue,  3 Sep 2024 10:52:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 64C641C2087D
	for <lists+netdev@lfdr.de>; Tue,  3 Sep 2024 08:52:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4219B1C769A;
	Tue,  3 Sep 2024 08:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="yMZSZH/y"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B53F1C7669
	for <netdev@vger.kernel.org>; Tue,  3 Sep 2024 08:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725353532; cv=none; b=m8R2vujBkp8zhr8iTxzFbJbVja4NVoTlzoAY1bHQSfoJjQGMt1qh5VCdwfZ5RuA+uVmFe0T0zWO8VjFiMytGgBbhiZVLF9B7iyGLYd0bln31Uv7peVKiUS6MSqDAo/dneAvMKbkFxFvU7jiPsusCa6SkcIXZbLncdhoK5Q6afr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725353532; c=relaxed/simple;
	bh=6kk5VlDisA56DTM4hfMpwZ8VjhenCqrjla/XVC0EZ5c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fyASdYAUscR660kCU5yDUIA/6Ne+bh0mabCtYKjebtewUjQBiwYGFlQRuH0U9oZYnWdBuyZr79zqXg3iYgWLmS8PGlRcL9OpWLpA0NOg63U2bB2Ub+O+ZYD/Ia3WZQvYsuk3WEs73Bmz8apPYO9SsLODX2DnYAAc5/IXd7s/eyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=yMZSZH/y; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a868b8bb0feso606434866b.0
        for <netdev@vger.kernel.org>; Tue, 03 Sep 2024 01:52:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1725353528; x=1725958328; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iHMd3CmyF+UqSFpXp3YC4GWm8WtabyKorKiJxYaO3+A=;
        b=yMZSZH/ywxvJqJN8ZaDAS4Ehgkk6VOGVqZQzLDxMRPI6KcIpFZcUDlKW+UGTqycZmR
         ++NM5tBH85P4eSdL93qsl0SKbfr7+8zry6F5S1b3kUsVZcbQmDk0QZ8Kic/1+goAFGlu
         UpHbs70JnbX5V7IShap4imc67LDfcabZyLIe4TxFOdkqrnRqOMtfbM0cNDh9RPf1IN0S
         +Isl7JtCyqkcvk9g8MTWQ11yOhc16YYdIoGKgE+22k5p9mYbVwBCu5yh7xrFb2MyxH7u
         n+d6ns0d8hoU5i8HVwHY/iGoYCH6Fdl/7ZGa3z+TGsY/hxEbDjs5mmF4TGDNgrv0bbKe
         7QWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725353528; x=1725958328;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iHMd3CmyF+UqSFpXp3YC4GWm8WtabyKorKiJxYaO3+A=;
        b=A2EWijXkKplEZBPvx7ojeN0nV81+7wGj86h5g4gxM9rS8swClHZ91g8FeuwftkYKpI
         Vm/sakdjmv94xwtMjmfhCxwNJ02rRff5pa2PnSql2vI08OcPw68n+g/TMBib1fpRq1rv
         vjJ4UgzBO+EqhVG+TheZDPtOBik40EIzKadCtHsbCQdHv1yCWBaPll04YBw91lAaNO1O
         9c9P50+KePHZkbygrD+b/JwZca3nPJhJs16rXrrB50TPTaiSDrT1CHGpmRnrppQbZSiJ
         Dd4wYF6B6xOqRuhPZ+rIYzxxn8uFbAA2yGfiF0Swevz+Cbh5S43UiM1S2HpZanWn8bOx
         AKeg==
X-Forwarded-Encrypted: i=1; AJvYcCXUcgR9LcrD7NDYzrfFyXE4dLYBt788xjt865gjGnpWBDluhKQblBp8javhfS1hMzw/ePeN7ig=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxb60Z6oOAJYjf05zbIoRA3t/Ckdaf9q7xbBa8IneaW2rQEVKfF
	Da2yhXt8sx1W02S+swc9NCEsB9xCb9n2HsvN67V7CmvEjg8CZEktRGQ+clOfBLk=
X-Google-Smtp-Source: AGHT+IFkGNoCxh3jtKQW1b/cJ+gceEuYXUIU4qroSCyryYhzcTuRXG2ufP1+eQ3YqWuMZ/KD+8npyA==
X-Received: by 2002:a17:907:9407:b0:a86:96b3:86be with SMTP id a640c23a62f3a-a89a3826268mr783881966b.63.1725353527069;
        Tue, 03 Sep 2024 01:52:07 -0700 (PDT)
Received: from [192.168.0.105] (bras-109-160-30-236.comnet.bg. [109.160.30.236])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a898900f6b9sm653684866b.76.2024.09.03.01.52.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Sep 2024 01:52:06 -0700 (PDT)
Message-ID: <56ef0a03-500a-4f0d-a231-25b1f7d58758@blackwall.org>
Date: Tue, 3 Sep 2024 11:52:05 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net V2] net: bridge: br_fdb_external_learn_add(): always
 set EXT_LEARN
To: Jonas Gorski <jonas.gorski@bisdn.de>, Roopa Prabhu <roopa@nvidia.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Ido Schimmel <idosch@mellanox.com>, Petr Machata <petrm@mellanox.com>
Cc: bridge@lists.linux.dev, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240903081958.29951-1-jonas.gorski@bisdn.de>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20240903081958.29951-1-jonas.gorski@bisdn.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/3/24 11:19, Jonas Gorski wrote:
> When userspace wants to take over a fdb entry by setting it as
> EXTERN_LEARNED, we set both flags BR_FDB_ADDED_BY_EXT_LEARN and
> BR_FDB_ADDED_BY_USER in br_fdb_external_learn_add().
> 
> If the bridge updates the entry later because its port changed, we clear
> the BR_FDB_ADDED_BY_EXT_LEARN flag, but leave the BR_FDB_ADDED_BY_USER
> flag set.
> 
> If userspace then wants to take over the entry again,
> br_fdb_external_learn_add() sees that BR_FDB_ADDED_BY_USER and skips
> setting the BR_FDB_ADDED_BY_EXT_LEARN flags, thus silently ignores the
> update.
> 
> Fix this by always allowing to set BR_FDB_ADDED_BY_EXT_LEARN regardless
> if this was a user fdb entry or not.
> 
> Fixes: 710ae7287737 ("net: bridge: Mark FDB entries that were added by user as such")
> Signed-off-by: Jonas Gorski <jonas.gorski@bisdn.de>
> ---
> Changelog:
> V2:
>  * always allow setting EXT_LEARN regardless if user entry
>  * reworded the commit message a bit to match the new behavior
>  * dropped the redundant code excerpt from the commit message as it's
>    already in the context
> 
>  net/bridge/br_fdb.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/net/bridge/br_fdb.c b/net/bridge/br_fdb.c
> index c77591e63841..ad7a42b505ef 100644
> --- a/net/bridge/br_fdb.c
> +++ b/net/bridge/br_fdb.c
> @@ -1469,12 +1469,10 @@ int br_fdb_external_learn_add(struct net_bridge *br, struct net_bridge_port *p,
>  			modified = true;
>  		}
>  
> -		if (test_bit(BR_FDB_ADDED_BY_EXT_LEARN, &fdb->flags)) {
> +		if (test_and_set_bit(BR_FDB_ADDED_BY_EXT_LEARN, &fdb->flags)) {
>  			/* Refresh entry */
>  			fdb->used = jiffies;
> -		} else if (!test_bit(BR_FDB_ADDED_BY_USER, &fdb->flags)) {
> -			/* Take over SW learned entry */
> -			set_bit(BR_FDB_ADDED_BY_EXT_LEARN, &fdb->flags);
> +		} else {
>  			modified = true;
>  		}
>  

Although the curly braces aren't needed, I don't mind in this case.

Acked-by: Nikolay Aleksandrov <razor@blackwall.org>


