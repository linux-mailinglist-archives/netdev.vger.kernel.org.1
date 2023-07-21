Return-Path: <netdev+bounces-19714-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 27D2C75BD0D
	for <lists+netdev@lfdr.de>; Fri, 21 Jul 2023 06:01:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B40A1282130
	for <lists+netdev@lfdr.de>; Fri, 21 Jul 2023 04:01:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B98565A;
	Fri, 21 Jul 2023 04:01:09 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5F0A7F
	for <netdev@vger.kernel.org>; Fri, 21 Jul 2023 04:01:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20D78C433C8;
	Fri, 21 Jul 2023 04:01:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689912067;
	bh=SPnoJmGiFe/Shpnplx+jc98eIFEAdYRFoOMez3XI/JU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=HIUNiNNwywVNtfl4CORc6UpIsh0qZzSw5aotYd6qXz6h50bQO/YyqkFKKffZv9Z3L
	 Eggpq0xp0QCtkVCXD3W0Lx+cCBYGc91TbGHu+K41aloNmXQpCgFjak/gW4S6rbGF2Q
	 uOGe97dv4uZWogf5WAufNUH3Dl+8WYJbmSzxvprk9PwxclguwaLoUqdkm9vSNvN6+U
	 kmFHXDS2fgjeB8RWepOcS9ZN79qMaaafmvrEd+lBBAdSj3mVXPC0tr9chwGfRwqGyd
	 sduMNqonKEuNfPlpAVIa4x/t9XeHA/StkyfsPrAuhkOaQHSKp77kw9NRrsuLRcQT39
	 95ilp58nrlw4w==
Message-ID: <d6a204b1-e606-f6ad-660a-28cc5469be2e@kernel.org>
Date: Thu, 20 Jul 2023 22:01:06 -0600
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
To: Hangbin Liu <liuhangbin@gmail.com>, Ido Schimmel <idosch@idosch.org>
Cc: Stephen Hemminger <stephen@networkplumber.org>, netdev@vger.kernel.org,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Thomas Haller <thaller@redhat.com>
References: <20230718080044.2738833-1-liuhangbin@gmail.com>
 <ZLZnGkMxI+T8gFQK@shredder> <20230718085814.4301b9dd@hermes.local>
 <ZLjncWOL+FvtaHcP@Laptop-X1> <ZLlE5of1Sw1pMPlM@shredder>
 <ZLngmOaz24y5yLz8@Laptop-X1>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <ZLngmOaz24y5yLz8@Laptop-X1>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/20/23 7:34 PM, Hangbin Liu wrote:
> On Thu, Jul 20, 2023 at 05:29:58PM +0300, Ido Schimmel wrote:
>>>>> IMO, the number of routes being flushed because a preferred source
>>>>> address is deleted is significantly lower compared to interface down /
>>>>> deletion, so generating notifications in this case is probably OK. It
>>>
>>> How about ignore route deletion for link down? e.g.
>>>
>>> diff --git a/net/ipv4/fib_trie.c b/net/ipv4/fib_trie.c
>>> index 74d403dbd2b4..11c0f325e887 100644
>>> --- a/net/ipv4/fib_trie.c
>>> +++ b/net/ipv4/fib_trie.c
>>> @@ -2026,6 +2026,7 @@ void fib_table_flush_external(struct fib_table *tb)
>>>  int fib_table_flush(struct net *net, struct fib_table *tb, bool flush_all)
>>>  {
>>>         struct trie *t = (struct trie *)tb->tb_data;
>>> +       struct nl_info info = { .nl_net = net };
>>>         struct key_vector *pn = t->kv;
>>>         unsigned long cindex = 1;
>>>         struct hlist_node *tmp;
>>> @@ -2088,6 +2089,11 @@ int fib_table_flush(struct net *net, struct fib_table *tb, bool flush_all)
>>>
>>>                         fib_notify_alias_delete(net, n->key, &n->leaf, fa,
>>>                                                 NULL);
>>> +                       if (!(fi->fib_flags & RTNH_F_LINKDOWN)) {
>>> +                               rtmsg_fib(RTM_DELROUTE, htonl(n->key), fa,
>>> +                                         KEYLENGTH - fa->fa_slen, tb->tb_id, &info, 0);
>>> +                       }
>>
>> Will you get a notification in this case for 198.51.100.0/24?
> 
> No. Do you think it is expected with this patch or not?

The intent is that notifications are sent for link events but not route
events which are easily deduced from the link events.

