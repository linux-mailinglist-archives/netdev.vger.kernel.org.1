Return-Path: <netdev+bounces-55406-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81B9980ACD3
	for <lists+netdev@lfdr.de>; Fri,  8 Dec 2023 20:22:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3CD882818AC
	for <lists+netdev@lfdr.de>; Fri,  8 Dec 2023 19:21:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7A324B137;
	Fri,  8 Dec 2023 19:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fwWuH2aV"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC6C5481D4
	for <netdev@vger.kernel.org>; Fri,  8 Dec 2023 19:21:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E676C433C7;
	Fri,  8 Dec 2023 19:21:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702063316;
	bh=m2N0reCrYzufIq74ZjOW3IINxWdpl5ajaPh74HTVtfY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=fwWuH2aVOfIx3ohpnJC1NML+Fk85e/5BlTVQBfMXZMP0C8QynLb5MpS0+Goirjyab
	 7SGNWrT1LVhLs1MSQvpieQyuAt3G9dIkT75nA42np9pmvg+6/Ouf3Xe3p7hDlf8mlJ
	 YrxuLfNdqij2cPy+JkKZ3qlkcnuPsSfEdyX+/pD2aFpxjwZ8Df0KJTATwRISCZ1zAq
	 ZvtNNUHxmzbMOIFh2AgKOa2HbgjlCLqaG4KcCF2M2JMGbdgFCaXVlcgF1TyDHi+GPw
	 +eZUrKy4Ow7kuyhkGZtFEZ86CZT05ip88D7AavU3gWIdmg4hhFH7ccmhaFqmWwBhZ/
	 g1STaHB8fg0hw==
Message-ID: <02ef5de4-d57f-4037-8968-d9bf791bd903@kernel.org>
Date: Fri, 8 Dec 2023 12:21:55 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: selftest fib_nexthop_multiprefix failed due to route mismatch
Content-Language: en-US
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: netdev@vger.kernel.org
References: <ZVxQ42hk1dC4qffy@Laptop-X1>
 <01240884-fcc9-46d5-ae98-305151112ebc@kernel.org>
 <ZW_u7VWTpWAuub4L@Laptop-X1>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <ZW_u7VWTpWAuub4L@Laptop-X1>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/5/23 8:47 PM, Hangbin Liu wrote:
> On Tue, Nov 21, 2023 at 09:40:02AM -0800, David Ahern wrote:
>> On 11/20/23 10:40 PM, Hangbin Liu wrote:
>>> Hi David,
>>>
>>> Recently when run fib_nexthop_multiprefix test I saw all IPv6 test failed.
>>> e.g.
>>>
>>> # ./fib_nexthop_multiprefix.sh
>>> TEST: IPv4: host 0 to host 1, mtu 1300                              [ OK ]
>>> TEST: IPv6: host 0 to host 1, mtu 1300                              [FAIL]
>>>
>>> With -v it shows
>>>
>>> COMMAND: ip netns exec h0 /usr/sbin/ping6 -s 1350 -c5 -w5 2001:db8:101::1
>>> PING 2001:db8:101::1(2001:db8:101::1) 1350 data bytes
>>> From 2001:db8:100::64 icmp_seq=1 Packet too big: mtu=1300
>>>
>>> --- 2001:db8:101::1 ping statistics ---
>>> 1 packets transmitted, 0 received, +1 errors, 100% packet loss, time 0ms
>>>
>>> Route get
>>> 2001:db8:101::1 via 2001:db8:100::64 dev eth0 src 2001:db8:100::1 metric 1024 expires 599sec mtu 1300 pref medium
>>> Searching for:
>>>     2001:db8:101::1 from :: via 2001:db8:100::64 dev eth0 src 2001:db8:100::1 .* mtu 1300
>>>
>>> TEST: IPv6: host 0 to host 1, mtu 1300                              [FAIL]
>>>
>>> So we can get the Packet too big from 2001:db8:100::64 successfully. There
>>> is no "from ::" anymore. I plan to fix this issue. But I can't find which
>>> commit changed the behavior and the client could receive Packet too big
>>> message with correct src address.
>>>
>>> Do you have any hints?
>>>
>>> Thanks
>>> Hangbin
>>
>> v6.3.12:
>>
>> $ sudo /mnt/hostshare/fib_nexthop_multiprefix.sh
>> TEST: IPv4: host 0 to host 1, mtu 1300                          [ OK ]
>> TEST: IPv6: host 0 to host 1, mtu 1300                          [ OK ]
>>
>> v6.4.13 all passed as well, so it is something recent. I do not have a
>> 6.5 or 6.6 kernels compiled at the moment.
> 
> Hi David,
> 
> I re-test this on 6.4.0 and it also failed. So this looks like an env issue
> on your side?
> 
> # uname -r
> 6.4.0
> # ./fib_nexthop_multiprefix.sh
> TEST: IPv4: host 0 to host 1, mtu 1300                              [ OK ]
> TEST: IPv6: host 0 to host 1, mtu 1300                              [FAIL]
> 
> And from the test result, it looks we should receive the Packet too big message
> from r1. So look the current checking is incorrect and the "from ::" checking
> should be removed.
> 
> Please fix me if I missed anything?
> 

I ran it in a ubuntu 20.04 VM. Do not recall any specific sysctl
settings to the VM, but maybe something is different between U20.04 and
your OS


