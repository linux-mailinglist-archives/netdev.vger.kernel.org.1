Return-Path: <netdev+bounces-49742-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 04CE07F350E
	for <lists+netdev@lfdr.de>; Tue, 21 Nov 2023 18:40:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 33A7A1C20B78
	for <lists+netdev@lfdr.de>; Tue, 21 Nov 2023 17:40:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C21D85B1ED;
	Tue, 21 Nov 2023 17:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k2nLE0Eh"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9913C482DE
	for <netdev@vger.kernel.org>; Tue, 21 Nov 2023 17:40:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05A4AC433C7;
	Tue, 21 Nov 2023 17:40:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700588403;
	bh=dFHy5i6PL96RRcxVEbjGSsh0DvPjK5fxlrD6qpb/cIo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=k2nLE0EhEQLLCVdwgnVMFc2J6pFu9i3/jc+OszvnIcPkh3MEveXDV1VVJpMj7Bj/u
	 v5MVVnBJZb4IsMK2y3Fj7UqLf2dlHhgASe695KQ1yW7XGSrWjmA0hS1Po8O8gHA4MW
	 5JavES/VmzXpwtcN1ETscczRKMRoe7ejhb4MLTnIDpkjnciCPIvKrxQVY7s3MJHqlr
	 wxqAwGM99eJjR49Fypz0iZAy6ZH10PeHI1tihUwRHJ6Ot9tIPh88orHFK3jGO124mT
	 OjHuU86YfqTCCsbtOjkYms3eakmcmO/vWV4Z/HlN0QvVEs3qztk5ci+lq88tqAA2iE
	 PWMZ4JCbFKtmA==
Message-ID: <01240884-fcc9-46d5-ae98-305151112ebc@kernel.org>
Date: Tue, 21 Nov 2023 09:40:02 -0800
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
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <ZVxQ42hk1dC4qffy@Laptop-X1>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/20/23 10:40 PM, Hangbin Liu wrote:
> Hi David,
> 
> Recently when run fib_nexthop_multiprefix test I saw all IPv6 test failed.
> e.g.
> 
> # ./fib_nexthop_multiprefix.sh
> TEST: IPv4: host 0 to host 1, mtu 1300                              [ OK ]
> TEST: IPv6: host 0 to host 1, mtu 1300                              [FAIL]
> 
> With -v it shows
> 
> COMMAND: ip netns exec h0 /usr/sbin/ping6 -s 1350 -c5 -w5 2001:db8:101::1
> PING 2001:db8:101::1(2001:db8:101::1) 1350 data bytes
> From 2001:db8:100::64 icmp_seq=1 Packet too big: mtu=1300
> 
> --- 2001:db8:101::1 ping statistics ---
> 1 packets transmitted, 0 received, +1 errors, 100% packet loss, time 0ms
> 
> Route get
> 2001:db8:101::1 via 2001:db8:100::64 dev eth0 src 2001:db8:100::1 metric 1024 expires 599sec mtu 1300 pref medium
> Searching for:
>     2001:db8:101::1 from :: via 2001:db8:100::64 dev eth0 src 2001:db8:100::1 .* mtu 1300
> 
> TEST: IPv6: host 0 to host 1, mtu 1300                              [FAIL]
> 
> So we can get the Packet too big from 2001:db8:100::64 successfully. There
> is no "from ::" anymore. I plan to fix this issue. But I can't find which
> commit changed the behavior and the client could receive Packet too big
> message with correct src address.
> 
> Do you have any hints?
> 
> Thanks
> Hangbin

v6.3.12:

$ sudo /mnt/hostshare/fib_nexthop_multiprefix.sh
TEST: IPv4: host 0 to host 1, mtu 1300                          [ OK ]
TEST: IPv6: host 0 to host 1, mtu 1300                          [ OK ]

TEST: IPv4: host 0 to host 2, mtu 1350                          [ OK ]
TEST: IPv6: host 0 to host 2, mtu 1350                          [ OK ]

TEST: IPv4: host 0 to host 3, mtu 1400                          [ OK ]
TEST: IPv6: host 0 to host 3, mtu 1400                          [ OK ]

TEST: IPv4: host 0 to host 1, mtu 1300                          [ OK ]
TEST: IPv6: host 0 to host 1, mtu 1300                          [ OK ]

TEST: IPv4: host 0 to host 2, mtu 1350                          [ OK ]
TEST: IPv6: host 0 to host 2, mtu 1350                          [ OK ]

TEST: IPv4: host 0 to host 3, mtu 1400                          [ OK ]
TEST: IPv6: host 0 to host 3, mtu 1400                          [ OK ]

v6.4.13 all passed as well, so it is something recent. I do not have a
6.5 or 6.6 kernels compiled at the moment.

