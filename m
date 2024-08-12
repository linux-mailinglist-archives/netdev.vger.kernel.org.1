Return-Path: <netdev+bounces-117759-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 70DF594F1A9
	for <lists+netdev@lfdr.de>; Mon, 12 Aug 2024 17:28:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E263280E4F
	for <lists+netdev@lfdr.de>; Mon, 12 Aug 2024 15:28:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82FF6183CBF;
	Mon, 12 Aug 2024 15:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=katalix.com header.i=@katalix.com header.b="1Z/z8DKY"
X-Original-To: netdev@vger.kernel.org
Received: from mail.katalix.com (mail.katalix.com [3.9.82.81])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABC14183CC1
	for <netdev@vger.kernel.org>; Mon, 12 Aug 2024 15:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=3.9.82.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723476492; cv=none; b=DFkY9TqIDQF0TEztmlmWj+XxrhE+DkbipPNmvvbNtErx+OnVeesf3QgIKh9HPkAgfzT+e+l8G4DwYCKVYAGjhjWI4nc7kj+VfvyH7ELCh8YHC7KAqi5/pvOdUYQwdqay4oZUEcThNO4Z+wShcpAzzPSgT2JaApp+UnYkwZCFIio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723476492; c=relaxed/simple;
	bh=WNgdDlc2QIL7u8Ibcv9ZOh6+0lJmZQdTtAtHEs3kEiU=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:From:Subject:
	 In-Reply-To:Content-Type; b=a3VYV20uO2Wa3y4m8xTiE562zEpbroAutPOeY86wwNT1Tl7P9EtSETOOrzV5XDmobTn5xDbcsnjxzvRHR1Wuei7ISTUgs1FCfPd89Ttjf28zZ8d7WXMoYEQT1T7+pxqgmoBDiR2SwJdNFme2Uh8UDss7KoGHBrr3PVCQ2xRuKJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=katalix.com; spf=pass smtp.mailfrom=katalix.com; dkim=pass (2048-bit key) header.d=katalix.com header.i=@katalix.com header.b=1Z/z8DKY; arc=none smtp.client-ip=3.9.82.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=katalix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=katalix.com
Received: from [IPV6:2a02:8010:6359:1:e533:7058:72ab:8493] (unknown [IPv6:2a02:8010:6359:1:e533:7058:72ab:8493])
	(Authenticated sender: james)
	by mail.katalix.com (Postfix) with ESMTPSA id A85E37D9B6;
	Mon, 12 Aug 2024 16:28:09 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=katalix.com; s=mail;
	t=1723476489; bh=WNgdDlc2QIL7u8Ibcv9ZOh6+0lJmZQdTtAtHEs3kEiU=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:From:Subject:
	 In-Reply-To:From;
	z=Message-ID:=20<9bf3b940-ca7d-21f4-2317-d133a34b57eb@katalix.com>|
	 Date:=20Mon,=2012=20Aug=202024=2016:28:09=20+0100|MIME-Version:=20
	 1.0|To:=20Cong=20Wang=20<xiyou.wangcong@gmail.com>|Cc:=20netdev@vg
	 er.kernel.org,=20davem@davemloft.net,=20edumazet@google.com,=0D=0A
	 =20kuba@kernel.org,=20pabeni@redhat.com,=20dsahern@kernel.org,=20t
	 parkin@katalix.com|References:=20<cover.1722265212.git.jchapman@ka
	 talix.com>=0D=0A=20<8491d89e8ae68206971f35c572190ac8b7882c1d.17222
	 65212.git.jchapman@katalix.com>=0D=0A=20<Zrk9+7a0doax82Kd@pop-os.l
	 ocaldomain>|From:=20James=20Chapman=20<jchapman@katalix.com>|Subje
	 ct:=20Re:=20[PATCH=20net-next=2003/15]=20l2tp:=20have=20l2tp_ip_de
	 stroy_sock=20use=0D=0A=20ip_flush_pending_frames|In-Reply-To:=20<Z
	 rk9+7a0doax82Kd@pop-os.localdomain>;
	b=1Z/z8DKYxbTHx0KkhQx3TSLN62aP/P6B95iiLH3EWH45XdGZ1y8UhPH20F2miQ+6M
	 wQ46bSwLDtUhFjJjUisn0u6pzBRirZu+UbyBEoW/7In8i2ZIeRMvd9GIkZC39is4pw
	 Ye+8wHbxJtncs7cGRYm0IWMNoAEX/cv1fPxCzH6Ie+a7iNFob0Sx2MdybilRQFG0Dj
	 x/2EatJCna/u6ts56DHWJBEFuef7Yy0YUjGr+cC7IPNjoU6EzU0pT3jxhdwtrYNiUw
	 xPSBE3sjKHBen0kLszyeK1ydKjDvzwAqvW9c3MH26PstXQRHXJqhoO5x/XKyd0EBDi
	 WV6hGRgXf+Pfg==
Message-ID: <9bf3b940-ca7d-21f4-2317-d133a34b57eb@katalix.com>
Date: Mon, 12 Aug 2024 16:28:09 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Content-Language: en-US
To: Cong Wang <xiyou.wangcong@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, dsahern@kernel.org, tparkin@katalix.com
References: <cover.1722265212.git.jchapman@katalix.com>
 <8491d89e8ae68206971f35c572190ac8b7882c1d.1722265212.git.jchapman@katalix.com>
 <Zrk9+7a0doax82Kd@pop-os.localdomain>
From: James Chapman <jchapman@katalix.com>
Organization: Katalix Systems Ltd
Subject: Re: [PATCH net-next 03/15] l2tp: have l2tp_ip_destroy_sock use
 ip_flush_pending_frames
In-Reply-To: <Zrk9+7a0doax82Kd@pop-os.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/08/2024 23:40, Cong Wang wrote:
> On Mon, Jul 29, 2024 at 04:38:02PM +0100, James Chapman wrote:
>> Use the recently exported ip_flush_pending_frames instead of a
>> free-coded version and lock the socket while we call it.
> 
> Hmm? Isn't skb_queue_purge() closer to the original code?

It is, but I thought l2tp_ip should also be calling ip_cork_release, 
even if it doesn't use cork. Having looked again, prompted by your 
comments below, I realise I made a mistake.

> This is clearly not a trivial cleanup, so what are you trying to fix?

This commit wasn't to fix a specific problem. I'm trying to make l2tp 
easier to maintain tbh.

>> Signed-off-by: James Chapman <jchapman@katalix.com>
>> Signed-off-by: Tom Parkin <tparkin@katalix.com>
>> ---
>>   net/l2tp/l2tp_ip.c | 6 +++---
>>   1 file changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/net/l2tp/l2tp_ip.c b/net/l2tp/l2tp_ip.c
>> index 78243f993cda..f21dcbf3efd5 100644
>> --- a/net/l2tp/l2tp_ip.c
>> +++ b/net/l2tp/l2tp_ip.c
>> @@ -236,10 +236,10 @@ static void l2tp_ip_close(struct sock *sk, long timeout)
>>   static void l2tp_ip_destroy_sock(struct sock *sk)
>>   {
>>   	struct l2tp_tunnel *tunnel;
>> -	struct sk_buff *skb;
>>   
>> -	while ((skb = __skb_dequeue_tail(&sk->sk_write_queue)) != NULL)
>> -		kfree_skb(skb);
>> +	lock_sock(sk);
> 
> 
> Are you sure you really want this sock lock?

Hmm, you're right, it is unnecessary. I note l2tp_ip6 has similar 
unnecessary lock.

>> +	ip_flush_pending_frames(sk);
> 
> So who sets inet_sk(sk)->cork.base for l2tp socket?

I missed this. Thanks for catching it.

Since this series has already been applied to net-next, I'll work on a 
patch to address the issues raised.



