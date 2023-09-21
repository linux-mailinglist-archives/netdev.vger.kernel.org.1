Return-Path: <netdev+bounces-35396-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA9177A944D
	for <lists+netdev@lfdr.de>; Thu, 21 Sep 2023 14:37:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B1A391C2080C
	for <lists+netdev@lfdr.de>; Thu, 21 Sep 2023 12:37:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 189B5B641;
	Thu, 21 Sep 2023 12:37:39 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01F6D8832
	for <netdev@vger.kernel.org>; Thu, 21 Sep 2023 12:37:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4403C32781;
	Thu, 21 Sep 2023 12:37:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1695299858;
	bh=w1tR5jK0F9xlfdN/Mw0+SVK7U9y62CEBAumesqozlIA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=nHXRTHdM1Uxbn4yqcLk3PfqRXfV+7LwBUQTaxDwyUKSr8yxp+SxrSGp4MEflwaeN3
	 LjSTeduyw2KgNxPUD0+3I57hLpV3ehmu6H150O50VQFKPsWLtB4dplIQHh8ZYz/Nc5
	 x/B44aYXSkzRkVUIZgoqgD0uApqCfMUoN8aYF4AxGTma51r2MnnDBOOFzUDjkat080
	 YyTwubTEZVYouxIJBRUjrps++QrMkbL+WBEC3e5DEeuaYCW5Ttk/2jy8nho0Oh36ow
	 lbhqDLVE0EQiD2Nn4DNGckq8JIqfmoTY9GRY6qWwrwJraajiAq/ZySzUZrjB8DIHm1
	 61RQ4cbp31IvQ==
Message-ID: <e4aeef69-9656-d291-82a3-a86367210a81@kernel.org>
Date: Thu, 21 Sep 2023 06:37:37 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH net-next 3/3] tcp: derive delack_max from rto_min
Content-Language: en-US
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Soheil Hassas Yeganeh <soheil@google.com>,
 Neal Cardwell <ncardwell@google.com>, Yuchung Cheng <ycheng@google.com>,
 netdev@vger.kernel.org, eric.dumazet@gmail.com
References: <20230920172943.4135513-1-edumazet@google.com>
 <20230920172943.4135513-4-edumazet@google.com>
 <89a3cbd7-fd82-d925-b916-e323033ffdbe@kernel.org>
 <CANn89i+-3saYRN9YUuujYnW8PvmkyUTHmRDX3bUXdbYoGfo=iA@mail.gmail.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <CANn89i+-3saYRN9YUuujYnW8PvmkyUTHmRDX3bUXdbYoGfo=iA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 9/20/23 8:16 PM, Eric Dumazet wrote:
> On Wed, Sep 20, 2023 at 11:57 PM David Ahern <dsahern@kernel.org> wrote:
>>
>> On 9/20/23 11:29 AM, Eric Dumazet wrote:
>>> diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
>>> index 1fc1f879cfd6c28cd655bb8f02eff6624eec2ffc..2d1e4b5ac1ca41ff3db8dc58458d4e922a2c4999 100644
>>> --- a/net/ipv4/tcp_output.c
>>> +++ b/net/ipv4/tcp_output.c
>>> @@ -3977,6 +3977,20 @@ int tcp_connect(struct sock *sk)
>>>  }
>>>  EXPORT_SYMBOL(tcp_connect);
>>>
>>> +u32 tcp_delack_max(const struct sock *sk)
>>> +{
>>> +     const struct dst_entry *dst = __sk_dst_get(sk);
>>> +     u32 delack_max = inet_csk(sk)->icsk_delack_max;
>>> +
>>> +     if (dst && dst_metric_locked(dst, RTAX_RTO_MIN)) {
>>> +             u32 rto_min = dst_metric_rtt(dst, RTAX_RTO_MIN);
>>> +             u32 delack_from_rto_min = max_t(int, 1, rto_min - 1);
>>
>> `u32` type with max_t type set as `int`
> 
> That is because we allow "rto_min 0" in ip route ...
> 
> rto_min - 1 is then 0xFFFFFFFF
> 
> We could argue that "rto_min 0" would be illegal, but this is orthogonal.

My comment is solely about mismatch on data types. I am surprised use of
max_t with mixed data types does not throw a compiler warning.

