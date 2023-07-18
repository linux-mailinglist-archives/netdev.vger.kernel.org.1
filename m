Return-Path: <netdev+bounces-18622-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D2FB2757FF3
	for <lists+netdev@lfdr.de>; Tue, 18 Jul 2023 16:45:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C4942815B4
	for <lists+netdev@lfdr.de>; Tue, 18 Jul 2023 14:45:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5B45FBEE;
	Tue, 18 Jul 2023 14:45:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A142AD532
	for <netdev@vger.kernel.org>; Tue, 18 Jul 2023 14:45:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F803C433C8;
	Tue, 18 Jul 2023 14:45:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689691522;
	bh=N8/ukNvKYCBFYyc4s7u6mUZILifYMsHY/t/U61zCb9I=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=pp6f7ENjXYKlNKWT+Et6L1rhZBWqIR6fDrEKGlE8BBfq9YwSVKoxPKqjt0J7FrKol
	 7itaHew2q1s35Ys++YdMXhJj5AU+nx5jH82NTjlfiqHAEGVEL2I+gRiaz7YKkmqRJ+
	 8C7gm08iQ0L0aYL1x9GX58Th1Am2Gj/kweUmWHkLRT6As3segCZ6Y9Wsa6JMLCu1mh
	 W03mjXdjJ0iJhL0HnQrky2kfwwknesKIWK44IOqrSr/gCFIIZQq0Pr5QqWVzZGWeyz
	 a/cTAnWrHUujP5ut/1D8iUQP2GdQ0/6/AqNQ9nASdEjB3tqEKyOhQ4gEcAlKrmTK7K
	 GsaviW0Y9DVEw==
Message-ID: <7094b9cd-0ff0-0e5e-e3a6-efaa4a880062@kernel.org>
Date: Tue, 18 Jul 2023 08:45:21 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [PATCH net-next] ipv4/fib: send RTM_DELROUTE notify when flush
 fib
Content-Language: en-US
To: Ido Schimmel <idosch@idosch.org>, Hangbin Liu <liuhangbin@gmail.com>
Cc: netdev@vger.kernel.org, "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Thomas Haller <thaller@redhat.com>
References: <20230718080044.2738833-1-liuhangbin@gmail.com>
 <ZLZnGkMxI+T8gFQK@shredder> <ZLZqMw/wOjwtQg+K@shredder>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <ZLZqMw/wOjwtQg+K@shredder>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/18/23 4:32 AM, Ido Schimmel wrote:
>>> @@ -2088,6 +2089,8 @@ int fib_table_flush(struct net *net, struct fib_table *tb, bool flush_all)
>>>  
>>>  			fib_notify_alias_delete(net, n->key, &n->leaf, fa,
>>>  						NULL);
>>> +			rtmsg_fib(RTM_DELROUTE, htonl(n->key), fa,
>>> +				  KEYLENGTH - fa->fa_slen, tb->tb_id, &info, 0);
>>
>> fib_table_flush() isn't only called when an address is deleted, but also
>> when an interface is deleted or put down. The lack of notification in
>> these cases is deliberate. Commit 7c6bb7d2faaf ("net/ipv6: Add knob to
>> skip DELROUTE message on device down") introduced a sysctl to make IPv6
>> behave like IPv4 in this regard, but this patch breaks it.
>>
>> IMO, the number of routes being flushed because a preferred source
>> address is deleted is significantly lower compared to interface down /
>> deletion, so generating notifications in this case is probably OK. It
>> also seems to be consistent with IPv6 given that rt6_remove_prefsrc()
>> calls fib6_clean_all() and not fib6_clean_all_skip_notify().
> 
> Actually, looking closer at IPv6, it seems that routes are not deleted,
> but instead the preferred source address is simply removed from them
> (w/o a notification).
> 
> Anyway, my point is that a RTM_DELROUTE notification should not be
> emitted for routes that are deleted because of interface down /
> deletion.
> 

exactly.


