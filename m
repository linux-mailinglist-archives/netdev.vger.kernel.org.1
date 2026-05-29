Return-Path: <netdev+bounces-292978-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iLQoIkkgGWqnqggAu9opvQ
	(envelope-from <netdev+bounces-292978-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 07:12:41 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A3205FD43C
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 07:12:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id DFF0D301642D
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 05:12:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0881B39E9C3;
	Fri, 29 May 2026 05:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="uqfYwV3/"
X-Original-To: netdev@vger.kernel.org
Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A54039E6D4
	for <netdev@vger.kernel.org>; Fri, 29 May 2026 05:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780031558; cv=none; b=LBxko5fm4vcyHgqxljPpt0lRBwKXm0BIHfxC+sx7WY2V58bOFXC4JFJI4Vteny8ImsJrJSnaKvv5Dxv2Svu148y0Vubl6S+pEqsxdYpgo4Cu3BuAAId3pddk20Uu6Pvy6CE4RSgpGo2Shpp5xahVnxBjvBRRWiWaVxHyIkuI+ho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780031558; c=relaxed/simple;
	bh=oU2AMy4t4gZMI5sHNKxb46+ca5KXphKznVnyxwi9PUg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HiIzjyoPI8Ke2Vj1ChzOKlX84snMzo1LkMha0IeNmx/O1vrq3a+wq/xy94cqVK9DPUwPBAH3AywgC52faJA5+rKUO4sbEdNLQqFkq8wPbUDfXMWHSKSqshG1cvS18yOk0uDHNKMpZ/o7DywRx1PY/wupnyBZd01c3gsbqUiUNTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=uqfYwV3/; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <2a49dc12-da42-4113-b191-41ebd00c8d90@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1780031554;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7vkXWXXjuY1xM+N6I834Ud1A/LAg/+P/Lc0BN6iguHg=;
	b=uqfYwV3/vJyMF20u9Jy3Er6sCdA9/xaFHnGdJ8wOjbehNHsAdvPeL5g+SC48kYTVo2F31k
	d4VYcHPUlm2xX8Sfbr5gFh7UJQjGSxdwS6XAqr//lmJ0As4u561lTZmyYzOdbLC4rrLbht
	e+uT+k9WiyAjiHZzWhQmxsL2ljPldN0=
Date: Fri, 29 May 2026 13:12:17 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net] ipv6: anycast: insert aca into global hash under
 idev->lock
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: netdev@vger.kernel.org, David Ahern <dsahern@kernel.org>,
 Ido Schimmel <idosch@nvidia.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 linux-kernel@vger.kernel.org
References: <20260529032026.363856-1-jiayuan.chen@linux.dev>
 <CAAVpQUCJxaPTsA8DJ-KzPpWM2_GQr1LBHfdyEo9ziCA4sEqv-w@mail.gmail.com>
 <2a64dc4a-ad65-4fbf-a505-f4813886629b@linux.dev>
 <CAAVpQUDHX9o-hRJr8=OFOCac9jSTU-Cu7OUyZSJLf+r6HPFfZQ@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Jiayuan Chen <jiayuan.chen@linux.dev>
In-Reply-To: <CAAVpQUDHX9o-hRJr8=OFOCac9jSTU-Cu7OUyZSJLf+r6HPFfZQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-292978-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	DKIM_TRACE(0.00)[linux.dev:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiayuan.chen@linux.dev,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[syzkaller.appspot.com:url,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,linux.dev:email,linux.dev:mid,linux.dev:dkim]
X-Rspamd-Queue-Id: 2A3205FD43C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


On 5/29/26 1:10 PM, Kuniyuki Iwashima wrote:
> On Thu, May 28, 2026 at 10:03 PM Jiayuan Chen <jiayuan.chen@linux.dev> wrote:
>> On 5/29/26 11:41 AM, Kuniyuki Iwashima wrote:
>>> On Thu, May 28, 2026 at 8:20 PM Jiayuan Chen <jiayuan.chen@linux.dev> wrote:
>>>> syzbot reported a splat [1]: a slab-use-after-free in
>>>> ipv6_chk_acast_addr(), which walks the global inet6_acaddr_lst[] hash
>>>> under RCU and dereferences a struct ifacaddr6 that has already been
>>>> freed while still linked in the hash, so a later reader walks into a
>>>> dangling node.
>>>>
>>>> In __ipv6_dev_ac_inc() the aca is allocated with refcount 1, then
>>>> aca_get() bumps it to 2 to keep it alive across the unlocked region.
>>>> It is published to idev->ac_list under idev->lock, but
>>>> ipv6_add_acaddr_hash() runs after write_unlock_bh(). A concurrent
>>>> teardown (ipv6_ac_destroy_dev() from addrconf_ifdown(), under RTNL)
>>>> can slip into that window:
>>>>
>>>>     CPU0 __ipv6_dev_ac_inc           CPU1 ipv6_ac_destroy_dev (RTNL)
>>>>     ------------------------------   ------------------------------------
>>>>     aca_alloc()              refcnt 1
>>>>     aca_get()               refcnt 2
>>>>     write_lock_bh(idev->lock)
>>>>       add aca to ac_list
>>>>     write_unlock_bh(idev->lock)
>>>>                                      write_lock_bh(idev->lock)
>>>>                                        pull aca off ac_list
>>>>                                      write_unlock_bh(idev->lock)
>>>>                                      ipv6_del_acaddr_hash(aca)
>>>>                                        hlist_del_init_rcu() is a no-op,
>>>>                                        aca is not in the hash yet
>>>>                                      aca_put()           refcnt 2->1
>>>>     ipv6_add_acaddr_hash(aca)
>>>>       aca now inserted into the hash
>>>>     aca_put()                refcnt 1->0
>>>>       call_rcu(aca_free_rcu) -> kfree(aca)
>>>>
>>>> The hash removal becomes a no-op because the insertion has not
>>>> happened yet, so once CPU0 inserts and drops the last reference, the
>>>> aca is freed while still linked in inet6_acaddr_lst[], and readers
>>>> dereference freed memory after the slab slot is reused.
>>>>
>>>> This window opened once RTNL stopped serializing the join path against
>>>> device teardown. Move ipv6_add_acaddr_hash() inside the idev->lock
>>>> section so the ac_list and hash insertions are atomic with respect to
>>>> teardown: a racing remover now either misses the aca entirely or finds
>>>> it in both lists.
>>>>
>>>> [1] https://syzkaller.appspot.com/bug?extid=a01df04303c131efbf3a
>>> Closes: and Reported-by ?
>>
>>
>> It has already been closed automatically, so I didn't add a Closes tag.
>> As for the Reported-by tag, it should be carried along with the patch.
> Closes: is not related to the status in the syzbot dashboard.
>
> Also, the moderation is the stage before being sent upstream,
> not that the report is closed, I just published it.
>
> So please add both tags using this link and Reported-by
> tag there.
>
> https://lore.kernel.org/netdev/6a191f87.ce022c6e.138e56.0003.GAE@google.com/T/

Thanks, I find this report now.

I will carry both tags.

>
>>
>> I'll pay attention next time. :)
>>
>>>> Fixes: eb1ac9ff6c4a ("ipv6: anycast: Don't hold RTNL for IPV6_JOIN_ANYCAST.")
>>>> Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
>>> Change itself looks good, thanks
>>>
>>> Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>
>>>
>>>
>>>> ---
>>>>    net/ipv6/anycast.c | 4 ++--
>>>>    1 file changed, 2 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/net/ipv6/anycast.c b/net/ipv6/anycast.c
>>>> index 67a42e01dfc3..cd8c02a1ad4c 100644
>>>> --- a/net/ipv6/anycast.c
>>>> +++ b/net/ipv6/anycast.c
>>>> @@ -371,10 +371,10 @@ int __ipv6_dev_ac_inc(struct inet6_dev *idev, const struct in6_addr *addr)
>>>>           aca->aca_next = idev->ac_list;
>>>>           rcu_assign_pointer(idev->ac_list, aca);
>>>>
>>>> -       write_unlock_bh(&idev->lock);
>>>> -
>>>>           ipv6_add_acaddr_hash(net, aca);
>>>>
>>>> +       write_unlock_bh(&idev->lock);
>>>> +
>>>>           ip6_ins_rt(net, f6i);
>>>>
>>>>           addrconf_join_solict(idev->dev, &aca->aca_addr);
>>>> --
>>>> 2.43.0
>>>>

