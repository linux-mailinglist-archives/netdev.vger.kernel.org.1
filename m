Return-Path: <netdev+bounces-115233-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7441C9458EE
	for <lists+netdev@lfdr.de>; Fri,  2 Aug 2024 09:35:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 12225B23B12
	for <lists+netdev@lfdr.de>; Fri,  2 Aug 2024 07:35:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D096945020;
	Fri,  2 Aug 2024 07:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=katalix.com header.i=@katalix.com header.b="hfJ/L3I5"
X-Original-To: netdev@vger.kernel.org
Received: from mail.katalix.com (mail.katalix.com [3.9.82.81])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07D7641760
	for <netdev@vger.kernel.org>; Fri,  2 Aug 2024 07:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=3.9.82.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722584133; cv=none; b=Qfojm9Mp9uMK5zrKHXzYI3Sx421UGlXbb1SeaJUbzaSGXsyt1l6fOVxnsKkxxeN/EQBO7U3DnxL2HVSKdwBOieBhEngo4M4s4ve10f1Dw4gl/CwOtPNaL1ldLOsPz4J0CLYOE+lZs59MJNN6EmyR04hLYh5lnplLmzIuYoJaG5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722584133; c=relaxed/simple;
	bh=b2MqOARwJjplWCgMNBav9jyB/LS57clCBkTKxbuNVqo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bgvaMIVWbJugUPOzWmlLhJQZSr+4Qkiskan/g90aUyoNIComGQRxCeino4SvkBbI7FiVdaY7+kHNYB0pezWcpJfV4SXtODuV93ywBpFY3iZBW/K4W9FmTJPilje4HPXUegGlpuxfKdYQP1PxEAlmiLu+rF76Rv8VpTfRtF0Jzfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=katalix.com; spf=pass smtp.mailfrom=katalix.com; dkim=pass (2048-bit key) header.d=katalix.com header.i=@katalix.com header.b=hfJ/L3I5; arc=none smtp.client-ip=3.9.82.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=katalix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=katalix.com
Received: from [IPV6:2a02:8010:6359:1:e533:7058:72ab:8493] (unknown [IPv6:2a02:8010:6359:1:e533:7058:72ab:8493])
	(Authenticated sender: james)
	by mail.katalix.com (Postfix) with ESMTPSA id 9F2B87D9B6;
	Fri,  2 Aug 2024 08:35:24 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=katalix.com; s=mail;
	t=1722584124; bh=b2MqOARwJjplWCgMNBav9jyB/LS57clCBkTKxbuNVqo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:From;
	z=Message-ID:=20<d828df18-64ec-9ed2-8159-ae0cb01302be@katalix.com>|
	 Date:=20Fri,=202=20Aug=202024=2008:35:24=20+0100|MIME-Version:=201
	 .0|Subject:=20Re:=20RFC:=20l2tp:=20how=20to=20fix=20nested=20socke
	 t=20lockdep=20splat|To:=20Eric=20Dumazet=20<edumazet@google.com>|C
	 c:=20netdev@vger.kernel.org,=20davem@davemloft.net,=20kuba@kernel.
	 org,=0D=0A=20pabeni@redhat.com,=20dsahern@kernel.org,=20jakub@clou
	 dflare.com,=0D=0A=20tparkin@katalix.com|References:=20<20240801152
	 704.24279-1-jchapman@katalix.com>=0D=0A=20<CANn89iJkFh4JmNO2gM-4c6
	 sbqgdjFzdNZUc-b6jupTMpUaC1mQ@mail.gmail.com>|From:=20James=20Chapm
	 an=20<jchapman@katalix.com>|In-Reply-To:=20<CANn89iJkFh4JmNO2gM-4c
	 6sbqgdjFzdNZUc-b6jupTMpUaC1mQ@mail.gmail.com>;
	b=hfJ/L3I5ETNDNshCP88DT1DKeO77G/ZiU4HfQcYxEvVlGywiKzZsps5/GR48H/LSo
	 5ZXSFZNDI0KxQFFs20OXVzk98Kh1sX4PVgFxKI0kqqIQQfqh+diyFjh8wy5AzcZCFE
	 wKGW2adHdwG72hOO2CGdTh/14QQfBBSFJYiZKTaLogUEWJHJXjco03TeO+Mmv4Xo0t
	 DLSVquq0DirCzYkEJeUPafPBOw5Itn09a2xDXrgOzOfaBdDDDUMQychBxarFgf3fyb
	 U2Pjwkl/gWPbav2QxmLwbcNku7eiPAdS7f4Ku2Y/o0rpRpvZ9noIh6DrlOCGZVbprg
	 TDeH0EBVVEygA==
Message-ID: <d828df18-64ec-9ed2-8159-ae0cb01302be@katalix.com>
Date: Fri, 2 Aug 2024 08:35:24 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: RFC: l2tp: how to fix nested socket lockdep splat
To: Eric Dumazet <edumazet@google.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 pabeni@redhat.com, dsahern@kernel.org, jakub@cloudflare.com,
 tparkin@katalix.com
References: <20240801152704.24279-1-jchapman@katalix.com>
 <CANn89iJkFh4JmNO2gM-4c6sbqgdjFzdNZUc-b6jupTMpUaC1mQ@mail.gmail.com>
Content-Language: en-US
From: James Chapman <jchapman@katalix.com>
Organization: Katalix Systems Ltd
In-Reply-To: <CANn89iJkFh4JmNO2gM-4c6sbqgdjFzdNZUc-b6jupTMpUaC1mQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 01/08/2024 16:57, Eric Dumazet wrote:
> On Thu, Aug 1, 2024 at 5:27 PM James Chapman <jchapman@katalix.com> wrote:
>>
>> When l2tp tunnels use a socket provided by userspace, we can hit lockdep splats like the below when data is transmitted through another (unrelated) userspace socket which then gets routed over l2tp.
>>
>> This issue was previously discussed here: https://lore.kernel.org/netdev/87sfialu2n.fsf@cloudflare.com/
>>
>> Is it reasonable to disable lockdep tracking of l2tp userspace tunnel sockets? Is there a better solution?
>>
>> diff --git a/net/l2tp/l2tp_core.c b/net/l2tp/l2tp_core.c
>> index e22e2a45c925..ab7be05da7d4 100644
>> --- a/net/l2tp/l2tp_core.c
>> +++ b/net/l2tp/l2tp_core.c
>> @@ -1736,6 +1736,16 @@ int l2tp_tunnel_register(struct l2tp_tunnel *tunnel, struct net *net,
>>          }
>>
>>          sk->sk_allocation = GFP_ATOMIC;
>> +
>> +       /* If the tunnel socket is a userspace socket, disable lockdep
>> +        * validation on the tunnel socket to avoid lockdep splats caused by
>> +        * nested socket calls on the same lockdep socket class. This can
>> +        * happen when data from a user socket is routed over l2tp, which uses
>> +        * another userspace socket.
>> +        */
>> +       if (tunnel->fd >= 0)
>> +               lockdep_set_novalidate_class(&sk->sk_lock.slock);
>> +
> 
> 
> I would rather use
> 
> // Must be different than SINGLE_DEPTH_NESTING
> #define L2TP_DEPTH_NESTED 2
> 
> diff --git a/net/l2tp/l2tp_core.c b/net/l2tp/l2tp_core.c
> index 5d2068b6c77859c0e2e3166afd8e2e1e32512445..4d747a0cf30c645e51c27e531d23db682259155f
> 100644
> --- a/net/l2tp/l2tp_core.c
> +++ b/net/l2tp/l2tp_core.c
> @@ -1171,7 +1171,7 @@ static int l2tp_xmit_core(struct l2tp_session
> *session, struct sk_buff *skb, uns
>          IPCB(skb)->flags &= ~(IPSKB_XFRM_TUNNEL_SIZE |
> IPSKB_XFRM_TRANSFORMED | IPSKB_REROUTED);
>          nf_reset_ct(skb);
> 
> -       bh_lock_sock_nested(sk);
> +       spin_lock_nested(&sk->sk_lock.slock, L2TP_DEPTH_NESTING);
>          if (sock_owned_by_user(sk)) {
>                  kfree_skb(skb);
>                  ret = NET_XMIT_DROP;
> 
Thanks Eric. I'll submit a patch with this fix later.


