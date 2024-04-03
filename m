Return-Path: <netdev+bounces-84579-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E36BF897770
	for <lists+netdev@lfdr.de>; Wed,  3 Apr 2024 19:55:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1FDE71C21098
	for <lists+netdev@lfdr.de>; Wed,  3 Apr 2024 17:55:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8407152197;
	Wed,  3 Apr 2024 17:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="awINHtBK"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B46791514D9
	for <netdev@vger.kernel.org>; Wed,  3 Apr 2024 17:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712166565; cv=none; b=TtrkrZZD68g41OtyRH6njZ+C3f2PutxQj+ZVq5PvyjbS2KCYvtY4gJFXxWTZ/gynnkYLdTXvNzVSUVz8CYisFo6YCOn2IlPEFsthtQTIwS9DUAbaYNKBF+DTmw+dvQH69mGN4RqlY60r3VCbANYgP0bsqufA6Eo9VxTmXUo8z/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712166565; c=relaxed/simple;
	bh=iL8gRHTb3KBHDQsSPW0oEDOtjR1SjHesZ+uNlXMQIA8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SbK9bRzIOt2ldxBIQrCBaTAEpa9w/zysbEKZvtYMp2fTm1oun+5tcTACNffG+JRpdsL3vXKuilbAnUCeDyv+L9hZC1fRvhYrGBmhvzGUim9Y1xgHf7xPZ5m9kIXrBOwZjz9WUnhKOeQK8MSEWdj/sIVe7I/6XGDImvGHRVJd+p0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=awINHtBK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29FCFC433F1;
	Wed,  3 Apr 2024 17:49:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712166565;
	bh=iL8gRHTb3KBHDQsSPW0oEDOtjR1SjHesZ+uNlXMQIA8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=awINHtBK1RT5XDrWDmDtXtWHs0E/jAFatoNGPGA1ZMczn42+iooGIKe78veYB46qT
	 vhSMpIVH6DDNWu0k774gbMENnLIh0hzQDj3jAV/Ige7n69JfyDR5qYRlfp7k6qh3wg
	 LT9R/HA++Fm17S288dI+JkIzxjQMzw05OchTBOgJXVAF5nFmTFAk/3NZkF0qd0zevj
	 m/hjiyCkPNomfSR0E6uMU0p+299WAXl1U+IpCMy4u3cXHkg4j796l+EE+WnSVrDWRl
	 YSU0OwJeQMsyrr5sqZPqJcx0DeonLOz7qpTkI/jiIoFNA4yYKxSnnSACrNQQXLzp+k
	 URUeUbfMHKUsg==
Message-ID: <64ba0629-6481-41d2-ad99-38d296e93206@kernel.org>
Date: Wed, 3 Apr 2024 11:49:24 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] ipv6: remove RTNL protection from
 ip6addrlbl_dump()
Content-Language: en-US
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
 eric.dumazet@gmail.com
References: <20240403123913.4173904-1-edumazet@google.com>
 <67f5cb70-14a4-4455-8372-f039da2f15c2@kernel.org>
 <CANn89iLQuN43FFHvSgLLY+2b-Yu2Uhy13tmrY_Q-8zX7zUcPkg@mail.gmail.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <CANn89iLQuN43FFHvSgLLY+2b-Yu2Uhy13tmrY_Q-8zX7zUcPkg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 4/3/24 10:25 AM, Eric Dumazet wrote:
> On Wed, Apr 3, 2024 at 6:13 PM David Ahern <dsahern@kernel.org> wrote:
>>
>> On 4/3/24 6:39 AM, Eric Dumazet wrote:
>>> diff --git a/net/ipv6/addrlabel.c b/net/ipv6/addrlabel.c
>>> index 17ac45aa7194ce9c148ed95e14dd575d17feeb98..961e853543b64cd2060ef693ae3ad32a44780aa1 100644
>>> --- a/net/ipv6/addrlabel.c
>>> +++ b/net/ipv6/addrlabel.c
>>> @@ -234,7 +234,8 @@ static int __ip6addrlbl_add(struct net *net, struct ip6addrlbl_entry *newp,
>>>               hlist_add_head_rcu(&newp->list, &net->ipv6.ip6addrlbl_table.head);
>>>  out:
>>>       if (!ret)
>>> -             net->ipv6.ip6addrlbl_table.seq++;
>>> +             WRITE_ONCE(net->ipv6.ip6addrlbl_table.seq,
>>> +                        net->ipv6.ip6addrlbl_table.seq + 1);
>>>       return ret;
>>>  }
>>>
>>> @@ -445,7 +446,7 @@ static void ip6addrlbl_putmsg(struct nlmsghdr *nlh,
>>>  };
>>>
>>>  static int ip6addrlbl_fill(struct sk_buff *skb,
>>> -                        struct ip6addrlbl_entry *p,
>>> +                        const struct ip6addrlbl_entry *p,
>>>                          u32 lseq,
>>>                          u32 portid, u32 seq, int event,
>>>                          unsigned int flags)
>>> @@ -498,7 +499,7 @@ static int ip6addrlbl_dump(struct sk_buff *skb, struct netlink_callback *cb)
>>>       struct net *net = sock_net(skb->sk);
>>>       struct ip6addrlbl_entry *p;
>>>       int idx = 0, s_idx = cb->args[0];
>>> -     int err;
>>> +     int err = 0;
>>>
>>>       if (cb->strict_check) {
>>>               err = ip6addrlbl_valid_dump_req(nlh, cb->extack);
>>> @@ -510,7 +511,7 @@ static int ip6addrlbl_dump(struct sk_buff *skb, struct netlink_callback *cb)
>>>       hlist_for_each_entry_rcu(p, &net->ipv6.ip6addrlbl_table.head, list) {
>>>               if (idx >= s_idx) {
>>>                       err = ip6addrlbl_fill(skb, p,
>>> -                                           net->ipv6.ip6addrlbl_table.seq,
>>> +                                           READ_ONCE(net->ipv6.ip6addrlbl_table.seq),
>>
>> seems like this should be read once on entry, and the same value used
>> for all iterations.
> 
> I thought of that, but this will miss any update done concurrently (if
> all entries fit in a single skb)
> 
> It is unclear to me what user space can do with ifal_seq
> 
> There is no clear signal like :
> 
> Initial seq _before_ the dump, and seq seen _after_ the dump.

Since this a known change in behavior (however slight), it would be best
to add something in the commit message or a code comment so if someone
hits a problem and does a git bisect the problem and solution are clear.

