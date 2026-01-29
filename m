Return-Path: <netdev+bounces-254689-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MEeaNEs0e2lJCQIAu9opvQ
	(envelope-from <netdev+bounces-254689-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 11:19:55 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A5E5CAE82B
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 11:19:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 998FD305EC0B
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 10:16:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31AB92749ED;
	Thu, 29 Jan 2026 10:16:35 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B338A22A7E4
	for <netdev@vger.kernel.org>; Thu, 29 Jan 2026 10:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769681795; cv=none; b=ba9NJfGKaIyKfL349NbZBn3Px2qmKrQR/wGN7GtHJR2fJVR0NmKldE123XojlHKaGkdmRg0UQd493bIsoMmIbw+d1aBzNrbF/dVJC7knA33tTQBeMczcsdPFCWuwV9LKBk+Lh9nTiIXngcwkqHcrSfPiHUkMMTr4gVsUcOgUs6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769681795; c=relaxed/simple;
	bh=sv+5GU+1B/FWvyWCE7lvr2zO1CWRi6lch4R+W5q0W8U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=odBzrRy/yxATbvUGUCx4bQl7kUSMiEb/z5DLyYGZJ/NnPo1fupE1UFNMWZ0ZLoqaPG0UgCSwWVn6jw1so3YXc3pnlFbkxZ/CSma7/5eNJ3gPClLqekjk9miqggAlNmtXwfns6iEB5lWY/n+DjiEOmWK95sBl8zKk2yfJUEX1NW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 60TAGUVN027372;
	Thu, 29 Jan 2026 19:16:30 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from [192.168.1.10] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 60TAGUFj027368
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Thu, 29 Jan 2026 19:16:30 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <d0aa3c51-291b-40fd-82b4-15024dc4404b@I-love.SAKURA.ne.jp>
Date: Thu, 29 Jan 2026 19:16:30 +0900
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] xfrm: always flush state and policy upon
 NETDEV_DOWN/NETDEV_UNREGISTER events
To: Leon Romanovsky <leon@kernel.org>
Cc: Sabrina Dubroca <sd@queasysnail.net>,
        Steffen Klassert <steffen.klassert@secunet.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
        Ilan Tayari <ilant@mellanox.com>, Guy Shapiro <guysh@mellanox.com>,
        Yossi Kuperman <yossiku@mellanox.com>,
        Network Development <netdev@vger.kernel.org>
References: <1de734e2-1da6-4b5c-8e03-66af7f88d074@I-love.SAKURA.ne.jp>
 <20260128102404.GC12149@unreal>
 <83d06aca-4437-4d61-9c99-ac19b797a243@I-love.SAKURA.ne.jp>
 <20260128123546.GC40916@unreal>
 <b91432c3-5ed4-4669-8d7c-02cf7ea6f8fa@I-love.SAKURA.ne.jp>
 <20260129090959.GD10992@unreal>
Content-Language: en-US
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <20260129090959.GD10992@unreal>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Anti-Virus-Server: fsav405.rs.sakura.ne.jp
X-Virus-Status: clean
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-254689-lists,netdev=lfdr.de];
	TO_DN_ALL(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	DMARC_NA(0.00)[i-love.sakura.ne.jp];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[penguin-kernel@I-love.SAKURA.ne.jp,netdev@vger.kernel.org];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,bootlin.com:url,ffff888052f24618:email]
X-Rspamd-Queue-Id: A5E5CAE82B
X-Rspamd-Action: no action

On 2026/01/29 18:09, Leon Romanovsky wrote:
> On Thu, Jan 29, 2026 at 05:06:08PM +0900, Tetsuo Handa wrote:
>> On 2026/01/28 21:35, Leon Romanovsky wrote:
>>> On Wed, Jan 28, 2026 at 07:44:02PM +0900, Tetsuo Handa wrote:
>>>> On 2026/01/28 19:24, Leon Romanovsky wrote:
>>>>> I think this can work, but IMHO the more robust approach is to ensure that all
>>>>> states and policies are removed when the NETIF_F_HW_ESP feature bit is cleared.
>>>>
>>>> The transaction will become complicated, for dev->features manipulation
>>>> function can fail.
>>>
>>> Line above returning NOTIFY_OK, check that NETIF_F_HW_ESP is cleared,
>>> and remove everything.
>>
>> That answer needs more clarification. I came to get confused about what we should do.
>>
>> Question 1:
>>
>>   Since NETIF_F_HW_ESP is a hardware dependent flag, not all "struct net_device"
>>   support NETIF_F_HW_ESP flag. Is this interpretation correct?
> 
> Yes, however any device (SW or HW) should set this flag if they want to
> provide IPsec offload.

OK. There are "IPsec with offload" and "IPsec without offload".
Both cases use code in net/xfrm/ directory.

Users (not the kernel source but Linux administrator) can choose
"IPsec without offload" by clearing the NETIF_F_HW_ESP bit via
"ethtool -K $dev esp-hw-offload off" command even if $dev supports
both "IPsec with offload" and "IPsec without offload".

> 
>>
>> Question 2:
>>
>>   Sabrina Dubroca commented
>>
>>     But the current behavior ("ignore NETIF_F_HW_ESP and call
>>     xdo_dev_state_add for new states anyway") has been established for
>>     multiple years. Changing that now seems a bit risky.
>>
>>   at https://lkml.kernel.org/r/aXd3QjzwOVm0Q9LF@krikkit .
>>
>>   Is that comment saying that we have been permitting a "struct net_device"
>>   to be selected by xfrm_dev_state_add() even if that "struct net_device"
>>   does not support NETIF_F_HW_ESP flag. Is this interpretation correct?
> 
> I don't understand what does it mean "device doesn't support offload but
> state was offloaded anyway".

Users (not the kernel source but Linux administrator) who are using $dev
which supports only "IPsec without offload" can call xfrm_dev_state_add()
because xfrm_dev_state_add() does not check for the NETIF_F_HW_ESP bit.

Therefore such users can create "struct xfrm_state" with a reference to
"struct net_device" held at
https://elixir.bootlin.com/linux/v6.19-rc5/source/net/xfrm/xfrm_user.c#L986 .

> 
>>
>> Question 3:
>>
>>   Leon Romanovsky suggested that, as a more robust approach, remove all states
>>   and policies when the NETIF_F_HW_ESP feature bit is cleared.
>>
>>   But I consider that such approach will not work, for (according to Q2 above)
>>   xfrm_dev_state_add() can be called even if the NETIF_F_HW_ESP feature bit is not
>>   set. Also, I think that there is no guarantee that dev->features manipulation
>>   function is called after xfrm_dev_state_add() was called.
>>
>>   Therefore, we need an event that are guaranteed to be called.
>>   The NETDEV_UNREGISTER event is guaranteed to be called when unregistring
>>   a "struct net_device", and therefore a good place to remove all states and
>>   policies.
>>
>>   Is this interpretation correct?

Since we don't have a syzbot reproducer, I can't tell whether syzbot is manually
clearing the NETIF_F_HW_ESP bit or not. But as described above, a syzbot report

  unregister_netdevice: waiting for netdevsim0 to become free. Usage count = 2
  ref_tracker: netdev@ffff888052f24618 has 1/1 users at
       __netdev_tracker_alloc include/linux/netdevice.h:4400 [inline]
       netdev_tracker_alloc include/linux/netdevice.h:4412 [inline]
       xfrm_dev_state_add+0x3a5/0x1080 net/xfrm/xfrm_device.c:316

indicates that "struct xfrm_state" with a reference to "struct net_device" held
is remaining because xfrm_dev_state_flush() is not called upon NETDEV_UNREGISTER
event.

>>
>> Question 4:
>>
>>   If Q1 is correct, Sabrina's comment
>>
>>     Changing that now seems a bit risky.
>>
>>   in Q2 might be applicable to xfrm_dev_down().
>>
>>   That is, someone who is using xfrm with a !NETIF_F_HW_ESP hardware might be
>>   expecting that state and policy are not flushed upon NETDEV_DOWN event.
> 
> Do we have such in-tree devices? If the answer is no, you shouldn't be
> worried about that case.

The "user" here is not "in-tree devices" but "Linux administrator" (such as Alice
and Bob).

We can't guess whether Alice is using $dev which supports only "IPsec without offload"
and is calling xfrm_dev_state_add(). If Alice is doing so, Alice might be expecting that
"struct xfrm_state" with a reference to "struct net_device" held is not released upon
NETDEV_DOWN event.

> 
>>
>>   If there is such possibility, I think we should avoid changing xfrm_dev_down()
>>   and instead re-introduce xfrm_dev_unregister(). What do you think?


