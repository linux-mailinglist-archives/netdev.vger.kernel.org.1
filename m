Return-Path: <netdev+bounces-143960-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79CD89C4D70
	for <lists+netdev@lfdr.de>; Tue, 12 Nov 2024 04:43:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3DD9128A0CC
	for <lists+netdev@lfdr.de>; Tue, 12 Nov 2024 03:43:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 853AF204F7B;
	Tue, 12 Nov 2024 03:42:56 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 293EB1A072A
	for <netdev@vger.kernel.org>; Tue, 12 Nov 2024 03:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731382976; cv=none; b=uK/9lPOYBn5nnnt3L2DgkvCLrG9XeuCTckSvo4B8rorT+n597GlMFV8NCxQ5yQXhlthnbpd2LGqgz7oLvRgq5QqzFvMNKdbVWsYrG/5R/0QnuLkGZ2LHSZRsCgIlsn0hdGv80aYVwkU+YfDV46zfD1rR9RZ0IRamnBvKYpavWb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731382976; c=relaxed/simple;
	bh=cdyFoGxNvi14YeRgfGFxYQpmXf9MXjANIdkgZl/BesQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=UHVDB026ZpzcCU45WFA5nD00A10OljreNub/QXlxz/owxRalnWzuTth2BYH/oeq4Qjr/LRD7ryHmdNeko9wO3F+A6yZmWhpr6FMlTE+h88YJGYN1RXzPyF1LdNl+UK8LVoJDyOsQdwORzAoB3KlpzdFEQTLIVXhiK0m8y1O9zJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4XnXJC6BzMz1hwQW;
	Tue, 12 Nov 2024 11:40:59 +0800 (CST)
Received: from kwepemd100023.china.huawei.com (unknown [7.221.188.33])
	by mail.maildlp.com (Postfix) with ESMTPS id C67C71A0188;
	Tue, 12 Nov 2024 11:42:48 +0800 (CST)
Received: from [10.174.177.223] (10.174.177.223) by
 kwepemd100023.china.huawei.com (7.221.188.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 12 Nov 2024 11:42:47 +0800
Message-ID: <8acfac66-bd2f-44a0-a113-89951dcfd2d3@huawei.com>
Date: Tue, 12 Nov 2024 11:42:47 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: Fix icmp host relookup triggering ip_rt_bug
To: Herbert Xu <herbert@gondor.apana.org.au>
CC: <davem@davemloft.net>, <dsahern@kernel.org>, <edumazet@google.com>,
	<pabeni@redhat.com>, <horms@kernel.org>, <netdev@vger.kernel.org>,
	<yuehaibing@huawei.com>, <zhangchangzhong@huawei.com>
References: <20241111123915.3879488-1-dongchenchen2@huawei.com>
 <ZzK5A9DDxN-YJlsk@gondor.apana.org.au>
From: "dongchenchen (A)" <dongchenchen2@huawei.com>
In-Reply-To: <ZzK5A9DDxN-YJlsk@gondor.apana.org.au>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemd100023.china.huawei.com (7.221.188.33)


On 2024/11/12 10:10, Herbert Xu wrote:
> On Mon, Nov 11, 2024 at 08:39:15PM +0800, Dong Chenchen wrote:
>> arp link failure may trigger ip_rt_bug while xfrm enabled, call trace is:
>>
>> WARNING: CPU: 0 PID: 0 at net/ipv4/route.c:1241 ip_rt_bug+0x14/0x20
>> Modules linked in:
>> CPU: 0 UID: 0 PID: 0 Comm: swapper/0 Not tainted 6.12.0-rc6-00077-g2e1b3cc9d7f7
>> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
>> BIOS rel-1.13.0-0-gf21b5a4aeb02-prebuilt.qemu.org 04/01/2014
>> RIP: 0010:ip_rt_bug+0x14/0x20
>> Call Trace:
>>   <IRQ>
>>   ip_send_skb+0x14/0x40
>>   __icmp_send+0x42d/0x6a0
>>   ipv4_link_failure+0xe2/0x1d0
>>   arp_error_report+0x3c/0x50
>>   neigh_invalidate+0x8d/0x100
>>   neigh_timer_handler+0x2e1/0x330
>>   call_timer_fn+0x21/0x120
>>   __run_timer_base.part.0+0x1c9/0x270
>>   run_timer_softirq+0x4c/0x80
>>   handle_softirqs+0xac/0x280
>>   irq_exit_rcu+0x62/0x80
>>   sysvec_apic_timer_interrupt+0x77/0x90
>>
>> The script below reproduces this scenario:
>> ip xfrm policy add src 0.0.0.0/0 dst 0.0.0.0/0 \
>> 	dir out priority 0 ptype main flag localok icmp
>> ip l a veth1 type veth
>> ip a a 192.168.141.111/24 dev veth0
>> ip l s veth0 up
>> ping 192.168.141.155 -c 1
>>
>> icmp_route_lookup() create input routes for locally generated packets
>> while xfrm relookup ICMP traffic.Then it will set input route
>> (dst->out = ip_rt_bug) to skb for DESTUNREACH.
>>
>> Similar to commit ed6e4ef836d4("netfilter: Fix ip_route_me_harder
>> triggering ip_rt_bug"), avoid creating input routes with
>> icmp_route_lookup() to fix it.
>>
>> Fixes: 8b7817f3a959 ("[IPSEC]: Add ICMP host relookup support")
>> Signed-off-by: Dong Chenchen <dongchenchen2@huawei.com>
>> ---
>>   net/ipv4/icmp.c | 35 ++++++++++-------------------------
>>   1 file changed, 10 insertions(+), 25 deletions(-)
>>
>> diff --git a/net/ipv4/icmp.c b/net/ipv4/icmp.c
>> index e1384e7331d8..11ef4eb5b659 100644
>> --- a/net/ipv4/icmp.c
>> +++ b/net/ipv4/icmp.c
>> @@ -490,6 +490,7 @@ static struct rtable *icmp_route_lookup(struct net *net,
>>   	struct dst_entry *dst, *dst2;
>>   	struct rtable *rt, *rt2;
>>   	struct flowi4 fl4_dec;
>> +	unsigned int addr_type;
>>   	int err;
>>   
>>   	memset(fl4, 0, sizeof(*fl4));
>> @@ -528,31 +529,15 @@ static struct rtable *icmp_route_lookup(struct net *net,
>>   	if (err)
>>   		goto relookup_failed;
>>   
>> -	if (inet_addr_type_dev_table(net, route_lookup_dev,
>> -				     fl4_dec.saddr) == RTN_LOCAL) {
>> -		rt2 = __ip_route_output_key(net, &fl4_dec);
>> -		if (IS_ERR(rt2))
>> -			err = PTR_ERR(rt2);
>> -	} else {
> So you're saying that your packet triggered the else branch?
>
> That I think is the bug here, not the input route lookup which
> is the whole purpose of the original patch (simulate an input route
> lookup in order to determine the correct policy).
>
> AFAIK the packet that triggered the crash has a source address
> of 192.168.141.111, which should definitely be local.  So why
> is the RTN_LOCAL check failing?
>
> Cheers,

Hi,Herbert. Thanks for your review! As described in rfc4301:
"The implementation extracts the header for the
packet that triggered the error (from the ICMP message payload),
reverses the source and destination IP address fields, extracts the
protocol field, and reverses the port fields (if accessible).  It
then uses this extracted information to locate an appropriate, active
outbound SA, and transmits the error message via this SA" icmp_route_lookup reverse IP address fields of skb_in

skb_in: A -> B

icmp_err: B -> A

icmp_route_lookup

     xfrm_decode_session_reverse(net, skb_in, flowi4_to_flowi(&fl4_dec), 
AF_INET);

     //fl4_dec: saddr=B, daddr=A

If skb_in is outbound, fl4_dec.saddr is not nolocal. It may be no input 
route from B to A for

first communication.

If skb_in is inbound, fl4_dec.saddr is rtn_local.


cheers!




