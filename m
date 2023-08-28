Return-Path: <netdev+bounces-30973-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 04E2078A4A9
	for <lists+netdev@lfdr.de>; Mon, 28 Aug 2023 04:42:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C4F551C20750
	for <lists+netdev@lfdr.de>; Mon, 28 Aug 2023 02:42:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55976654;
	Mon, 28 Aug 2023 02:42:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EF10182
	for <netdev@vger.kernel.org>; Mon, 28 Aug 2023 02:42:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D376C433C8;
	Mon, 28 Aug 2023 02:42:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1693190524;
	bh=HvWMFbnHWeaaDj0HaHMaVmdEV4mE6i496eCxTVfv3uY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=VhsIJJJvfT2MbwItt8ovDnFJrCZkNPsk7I6kXAGTiK+UOlRxH+C6krkhMiRF+oB0I
	 w881A+AM+OSCYluWldoPuPvR899z9E3rHjb1C2FlZl7wBuap5lmQqRN9/zMF8wZmOz
	 3aZMlvuHiEhPiK3gDdBupM6GVKZjHgci7QFjvpnwU0Qj6leRNLUKr5/PtBZz9GBfFT
	 ScKejfBwb9zO+RAOuefDjd70F/+xNIcne3Bl4w8jTSITpjxVuKWye9cVn+RSPRAxQI
	 j+zYNTwcMhaDUC9aPrQz2WKHGhD2mJjlsn9Xg8ncryV4UEqbT/oiYoAMQ6qroyWWX1
	 zhb+H2/nZPQfA==
Message-ID: <a576811a-91ca-9153-afd8-c9738d6eb92b@kernel.org>
Date: Sun, 27 Aug 2023 20:42:03 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
Subject: Re: High Cpu load when run smartdns : __ipv6_dev_get_saddr
Content-Language: en-US
To: Martin Zaharinov <micron10@gmail.com>
Cc: netdev <netdev@vger.kernel.org>, Eric Dumazet <edumazet@google.com>,
 pymumu@gmail.com
References: <164ECEA1-0779-4EB8-8B2B-387F7CEC7A89@gmail.com>
 <b82afbaf-c548-5b7e-8853-12c3e6a8f757@kernel.org>
 <4898B1F7-2EB5-4182-9D8D-FC8FC780E9B7@gmail.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <4898B1F7-2EB5-4182-9D8D-FC8FC780E9B7@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 8/27/23 1:17 PM, Martin Zaharinov wrote:
> Hi David,
> 
> 
> 
>> On 27 Aug 2023, at 19:51, David Ahern <dsahern@kernel.org> wrote:
>>
>> On 8/27/23 7:20 AM, Martin Zaharinov wrote:
>>> Hi Eric 
>>>
>>>
>>> i need you help to find is this bug or no.
>>>
>>> I talk with smartdns team and try to research in his code but for the moment not found ..
>>>
>>> test system have 5k ppp users on pppoe device
>>>
>>> after run smartdns  
>>>
>>> service got to 100% load 
>>>
>>> in normal case when run other 2 type of dns server (isc bind or knot ) all is fine .
>>>
>>> but when run smartdns  see perf : 
>>>
>>>
>>> PerfTop:    4223 irqs/sec  kernel:96.9%  exact: 100.0% lost: 0/0 drop: 0/0 [4000Hz cycles],  (target_pid: 1208268)
>>> ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
>>>
>>>    28.48%  [kernel]        [k] __ipv6_dev_get_saddr
>>>    12.31%  [kernel]        [k] l3mdev_master_ifindex_rcu
>>>     6.63%  [pppoe]         [k] pppoe_rcv
>>>     3.82%  [kernel]        [k] ipv6_dev_get_saddr
>>>     2.07%  [kernel]        [k] __dev_queue_xmit
>>
>> Can you post stack traces for the top 5 symbols?
> 
> If write how i will get.

While running traffic load:
    perf record -a -g -- sleep 5
    perf report --stdio

> 
>>
>> What is the packet rate when the above is taken?
> 
> its normal rate of dns query… with both other dns server all is fine 

That means nothing to me. You will need to post packet rates.

> 
>>
>> 4,223 irqs/sec is not much of a load; can you add some details on the
>> hardware and networking setup (e.g., l3mdev reference suggests you are
>> using VRF)?
> No system is very simple:
> 
> eth0 (Internet) Router (smartDNS + pppoe server ) - eth1 ( User side with pppoe server ) here have 5000 ppp interface .
> 
> with both other service i dont see all work fine.

ip link sh type vrf
--> that does not show any devices? It should because the majority of
work done in l3mdev_master_ifindex_rcu is for vrf port devices. ie., it
should not appear in the perf-top data you posted unless vrf devices are
in play.


