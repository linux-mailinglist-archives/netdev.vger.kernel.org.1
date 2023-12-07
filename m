Return-Path: <netdev+bounces-54953-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A73E5809007
	for <lists+netdev@lfdr.de>; Thu,  7 Dec 2023 19:36:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 576B51F2117E
	for <lists+netdev@lfdr.de>; Thu,  7 Dec 2023 18:36:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC86B4D59F;
	Thu,  7 Dec 2023 18:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cGkUMrw1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B5871715
	for <netdev@vger.kernel.org>; Thu,  7 Dec 2023 10:36:14 -0800 (PST)
Received: by mail-yb1-xb30.google.com with SMTP id 3f1490d57ef6-dbc4df9fb11so23333276.0
        for <netdev@vger.kernel.org>; Thu, 07 Dec 2023 10:36:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701974174; x=1702578974; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=93LvvP12Ac3Tby4GFgXAifPDWgq2KvHyFxxYKOzAxC0=;
        b=cGkUMrw1UMbnCJqd3+DqnL+oE/w83lrXH1lNND+Z8RNd1OHOTjx8fMOPdmc46dERzj
         7EbRFJRdFruDDbeUeJkZH9MdgKwLWsiHSBXtEw+xqy9GrmHiT8rnZhr1HhDe9nemoDPA
         KIxAW7CueAydo64oLdB14OMjTVA5j1BfG6p7CjfjirtmbGoXN1rGCX3vyp3MygDH1Kbt
         Ga+apl88VgAnu55v/YY972nx7Dk9X+mV4GvhwXOjkEfzqisMq+MrrnVh0sVoj0VjZcJd
         PMuggI7QCtpD1Z0mnAMoP2Rwz58TQnpeOb8WM+Z7PXairV5zDvZC0jua5iJE4d0kXp0R
         +QcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701974174; x=1702578974;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=93LvvP12Ac3Tby4GFgXAifPDWgq2KvHyFxxYKOzAxC0=;
        b=DroAJKEPDrx/wXcmIJ1tyr9qUgYRtJglTqF7yJFpYyjiJP2ZaqzW302VKvdW9as2bf
         KF3eRtFG0TF0Iw1lpGho8HN5f6M5IzmpzADinTGHHEmuTqLvM/TWVqY40qhpsWmZsENj
         hfx2M2lP6IfLtW4oleCtARO9N9hhLt6zCkKdOvKkqhE3pW3lgRX4wq0LI3WRcRRtqki7
         j3qY6MxrpYFy7j8LR2ww3//Xak0VflBqM8RvEZxlgJ4jRsLgEEymCjMIn0vedjyXi3TT
         3q1qwacaVZAg7dMaLVWcJcii+UVHn+c5XpEN21OVwlHqK/JfJzptThoj7ajC1nIIxV7B
         eHWQ==
X-Gm-Message-State: AOJu0YyMKB8n2K6djX396WaKzW2fWlpa3JS63f19X4DrChxDysJXp9FN
	n1tg9UZ5ba8PL0w0OgGwAKU=
X-Google-Smtp-Source: AGHT+IEmlBV7yKf0P2nZK+9AXgZYclidDo4DKor7rJeifASY/Hlw/U5wKEca9Ge+3HXFyMBp+9zvBA==
X-Received: by 2002:a25:2457:0:b0:db5:3825:fd17 with SMTP id k84-20020a252457000000b00db53825fd17mr2517180ybk.8.1701974173668;
        Thu, 07 Dec 2023 10:36:13 -0800 (PST)
Received: from ?IPV6:2600:1700:6cf8:1240:57df:3a91:11ad:dcd? ([2600:1700:6cf8:1240:57df:3a91:11ad:dcd])
        by smtp.gmail.com with ESMTPSA id k5-20020a5b0385000000b00d7b957d8ed9sm77751ybp.17.2023.12.07.10.36.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Dec 2023 10:36:13 -0800 (PST)
Message-ID: <d7ffcd2b-55b0-4084-a18d-49596df8b494@gmail.com>
Date: Thu, 7 Dec 2023 10:36:11 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] ipv6: add debug checks in fib6_info_release()
Content-Language: en-US
To: David Ahern <dsahern@kernel.org>, Eric Dumazet <edumazet@google.com>
Cc: patchwork-bot+netdevbpf@kernel.org, Kui-Feng Lee <thinker.li@gmail.com>,
 davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, eric.dumazet@gmail.com
References: <20231205173250.2982846-1-edumazet@google.com>
 <170191862445.7525.14404095197034927243.git-patchwork-notify@kernel.org>
 <CANn89iKcFxJ68+M8UvHzqp1k-FDiZHZ8ujP79WJd1338DVJy6w@mail.gmail.com>
 <c4ca9c7d-12fa-4205-84e2-c1001242fc0d@gmail.com>
 <CANn89iKpM33oQ+2dwoLHzZvECAjwiKJTR3cDM64nE6VvZA99Sg@mail.gmail.com>
 <2ba1bbde-0e80-4b73-be2b-7ce27c784089@gmail.com>
 <CANn89i+2NJ4sp8iGQHG9wKakRD+uzvo7juqAFpE4CdRbg8F6gQ@mail.gmail.com>
 <590c27ae-c583-4404-ace7-ea68548d07a2@kernel.org>
From: Kui-Feng Lee <sinquersw@gmail.com>
In-Reply-To: <590c27ae-c583-4404-ace7-ea68548d07a2@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 12/7/23 10:25, David Ahern wrote:
> On 12/7/23 11:22 AM, Eric Dumazet wrote:
>> Feel free to amend the patch, but the issue is that we insert a fib
>> gc_link to a list, then free the fi6 object without removing it first
>> from the external list.
> 
> yes, move the insert down:
> 
> diff --git a/net/ipv6/route.c b/net/ipv6/route.c
> index b132feae3393..7257ba0e72b7 100644
> --- a/net/ipv6/route.c
> +++ b/net/ipv6/route.c
> @@ -3762,12 +3762,6 @@ static struct fib6_info
> *ip6_route_info_create(struct fib6_config *cfg,
>          if (cfg->fc_flags & RTF_ADDRCONF)
>                  rt->dst_nocount = true;
> 
> -       if (cfg->fc_flags & RTF_EXPIRES)
> -               fib6_set_expires_locked(rt, jiffies +
> -
> clock_t_to_jiffies(cfg->fc_expires));
> -       else
> -               fib6_clean_expires_locked(rt);
> -

fib6_set_expires_locked() here actually doesn't insert a fib gc_link
since rt->fib6_table is not assigned yet.  The gc_link will
be inserted by fib6_add() being called later.


>          if (cfg->fc_protocol == RTPROT_UNSPEC)
>                  cfg->fc_protocol = RTPROT_BOOT;
>          rt->fib6_protocol = cfg->fc_protocol;
> @@ -3824,6 +3818,12 @@ static struct fib6_info
> *ip6_route_info_create(struct fib6_config *cfg,
>          } else
>                  rt->fib6_prefsrc.plen = 0;
> 
> +
> +       if (cfg->fc_flags & RTF_EXPIRES)
> +               fib6_set_expires_locked(rt, jiffies +
> +
> clock_t_to_jiffies(cfg->fc_expires));
> +       else
> +               fib6_clean_expires_locked(rt);
>          return rt;
>   out:
>          fib6_info_release(rt);

However, this should fix the warning messages.

