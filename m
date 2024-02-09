Return-Path: <netdev+bounces-70571-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8224784F98E
	for <lists+netdev@lfdr.de>; Fri,  9 Feb 2024 17:25:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 23CC11F2349A
	for <lists+netdev@lfdr.de>; Fri,  9 Feb 2024 16:25:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C9E776047;
	Fri,  9 Feb 2024 16:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="d6msdTGh"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A50A74E33
	for <netdev@vger.kernel.org>; Fri,  9 Feb 2024 16:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707495919; cv=none; b=nsavBEHu0zudaxNmo76EmCFaXyJ6L/J/c9Vmb2n/BiE6xKmSVXhmU9EFuZ+ssYtpqfzKVrVF9cCcZwh6uJIV0JnpOu+D/8yNLtabDfb7UvZFK08eqYruVOuzQ7xqPpW4DqLvzNdxwQM/tGnAXoDzOUrY4ymPcNczM9cVXXk8z60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707495919; c=relaxed/simple;
	bh=+RxRX4dUOLepISctpJHeurEw90VG6uXgksw0e+9W8lk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RbQN3IZp5GCFbs3trKNEHnwFADuyI+24uwJPH+dW+Kc3cGkKbYTM/k5gKVKuSn/02T5Lna2dVm4w8OXOGZZmffgP/9k7J9DthKMJtmRvafpDURFA/cwQuJkn4+u6iHY8Zlpz7NY7wgM11G6y0vnwvrKT2zZjsDl00FCWtkqFpz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=d6msdTGh; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5605c7b0ca2so1353338a12.3
        for <netdev@vger.kernel.org>; Fri, 09 Feb 2024 08:25:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1707495916; x=1708100716; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7iPZ/0YJ6UTQVKYzwDgswHhGmJtucsRjoYf5WHUtgR4=;
        b=d6msdTGhW2HTG4K/JMvg7jma488Itq4XV5r1E8trHNGq88QcUINDIbDQFLPkHEKvnX
         f1BZlSfalwY7/2BtO4gh2dXtfFmtT03KjYEr19Lzmq2LDZnECaQyKt2rwZbn+WAJ8lIZ
         PJ5IvARQeyCs8KHWFOPWOCwKcZH31GWsIJHdk4tapL+5iI18l3PQWt4B03iaR9jpP1Pz
         KJipnHz4VufKbCVC+JDOADWFsssfc+og0yTmGdx7P5ATQJFotVLMYA9O65XgSNSAAvA4
         TwpD92BSKP0Im6MrqbqOjMbq5U7CiW068Gk1mnRaLR0KNdb1DmEK/OHbUbU3T5jGkNat
         mKaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707495916; x=1708100716;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7iPZ/0YJ6UTQVKYzwDgswHhGmJtucsRjoYf5WHUtgR4=;
        b=UbOdf7CFjyIERecSz+B/DFAvUdAbbFkKwhhs7MUHb8JEgga/nIfSSifNL7iuOIW7bF
         nB01/A/2zCRhg+p3SZVqa51lJcUoqhjzexhIxIRsRurP0UTWoilEahgG3J5abCWSEkbs
         fNPRVzHSeFgWwSUAZ5pX/ZQvXRVQhvnp8H3sLDQma+kGbBUhYBjR9rGv+LvnLGIPfgNS
         5qh4cAh0QP5bSWYKqiU8+3tklVnUHBzcFuvs+WepVvBqyj0+poe6oP0xB8+nqTCm0oNX
         C6K6SOYVr502dRgvfgtDq6a99UzeIAfkSxnA/9mfdK3h3sIzVMDXQQDLqwqdmaTKPQwz
         bJUA==
X-Forwarded-Encrypted: i=1; AJvYcCXd+stD7s+EtblIzw3ZKsdUbeLMburr85xWw5mBSTBY14IyAzg1exU3AeCP8n3qaB7BcG9/1jsgMRfQv0WZMPMra74pfNqk
X-Gm-Message-State: AOJu0YyilCMNcxH8iTu9t83WyHx9ezyUZV/Jt6T3ubVTvbs1c8TxVXNO
	T5pDTgRKLWlnyKqox5eYOxSQbC9yIRExIUTWf+hLIVfO8XoEvXZx2MPARJN++34=
X-Google-Smtp-Source: AGHT+IHVQR/uhorMBmmlYP7AGMUHKwBfxa9yNWiktx45gY2aNCUQ1Q9z/qHA3qDVWGhb800N11oaHA==
X-Received: by 2002:a17:907:1750:b0:a38:41bf:f6f6 with SMTP id lf16-20020a170907175000b00a3841bff6f6mr1304680ejc.77.1707495916406;
        Fri, 09 Feb 2024 08:25:16 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUtLoT/WQeWutH+3HilUKbD0LUqJ9uFbhwNhPljoTgSr/2S+9zJse4kz3Yn8E2uc0B1lj9q36o13qwWb9NNkRY8sCS4fyDZBqbjordspQ/S0lltdsUOdmjsb6nlzzUW7hGCdpcbyJIQjl57mBVly8K7c/G0+fUTZoSZB23DUx+McBVpSWLMbxZ34TOJRo4AjxSfNfswj7GAkK0+bubNTCGIjvIQ4rCvyv3KtVNPCJ2a2Jx4n3eV25uZLkYdlhwc12Nvt8aUbFY+FPQ2lM4=
Received: from [192.168.0.106] (176.111.176.127.kyiv.volia.net. [176.111.176.127])
        by smtp.gmail.com with ESMTPSA id vu6-20020a170907a64600b00a3be92b07d8sm747211ejc.24.2024.02.09.08.25.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Feb 2024 08:25:15 -0800 (PST)
Message-ID: <591dbec1-7b34-4fc8-a68a-c8669f542218@blackwall.org>
Date: Fri, 9 Feb 2024 18:25:09 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 3/6] bridge: vlan: use synchronize_net() when
 holding RTNL
Content-Language: en-US
To: Eric Dumazet <edumazet@google.com>, "David S . Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: David Ahern <dsahern@kernel.org>, Pablo Neira Ayuso
 <pablo@netfilter.org>, Florian Westphal <fw@strlen.de>,
 netdev@vger.kernel.org, eric.dumazet@gmail.com,
 Roopa Prabhu <roopa@nvidia.com>
References: <20240209153101.3824155-1-edumazet@google.com>
 <20240209153101.3824155-4-edumazet@google.com>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20240209153101.3824155-4-edumazet@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/9/24 17:30, Eric Dumazet wrote:
> br_vlan_flush() and nbp_vlan_flush() should use synchronize_net()
> instead of syncronize_rcu() to release RTNL sooner.
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> ---
>   net/bridge/br_vlan.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/net/bridge/br_vlan.c b/net/bridge/br_vlan.c
> index 15f44d026e75a8818f958703c5ec054eaafc4d94..9c2fffb827ab195cf9a01281e4790361e0b14bfe 100644
> --- a/net/bridge/br_vlan.c
> +++ b/net/bridge/br_vlan.c
> @@ -841,7 +841,7 @@ void br_vlan_flush(struct net_bridge *br)
>   	vg = br_vlan_group(br);
>   	__vlan_flush(br, NULL, vg);
>   	RCU_INIT_POINTER(br->vlgrp, NULL);
> -	synchronize_rcu();
> +	synchronize_net();
>   	__vlan_group_free(vg);
>   }
>   
> @@ -1372,7 +1372,7 @@ void nbp_vlan_flush(struct net_bridge_port *port)
>   	vg = nbp_vlan_group(port);
>   	__vlan_flush(port->br, port, vg);
>   	RCU_INIT_POINTER(port->vlgrp, NULL);
> -	synchronize_rcu();
> +	synchronize_net();
>   	__vlan_group_free(vg);
>   }
>   

Also CCed Roopa. Thanks,
Acked-by: Nikolay Aleksandrov <razor@blackwall.org>

