Return-Path: <netdev+bounces-84652-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39430897BCA
	for <lists+netdev@lfdr.de>; Thu,  4 Apr 2024 00:51:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 563F01C26540
	for <lists+netdev@lfdr.de>; Wed,  3 Apr 2024 22:51:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E7B2156227;
	Wed,  3 Apr 2024 22:51:42 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4A311534E6
	for <netdev@vger.kernel.org>; Wed,  3 Apr 2024 22:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712184701; cv=none; b=kLn7MbMFWRsiXGr18BaXbvIENwg06zRcsfpUlSoaVZrD5ADcp9V1dEzV2FqPtcVmW8j1RnAGkxQU8pAp0uGCnEm/tB5bFasn5EbYEtMapuBckhxi9jFlkkICF5IPjL3jhIRJn/l2fYgO+HOZNXs929MgiYY74iYsdqWBfLm3RjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712184701; c=relaxed/simple;
	bh=MfJg87ch01yEVsTRwDiZ8o9dqKF27p9L9SRpcKfLSUE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qzTS5PEGR1lVM1xx2Eu7j298l1yltzvj17tZ3y4ojC+Q8A/nYNZgDHcx5IcpnvDzq/LQmq/JoIgy7Qc0M9l4aeRQkUlWmIpkR8TOhzfbxz6qq2mudkIChhF7mz23r2O7C+svfhJqDeLmqJaOYVm+9UGqDKh0svz5m0PZWpb1VbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org; spf=pass smtp.mailfrom=ovn.org; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ovn.org
Received: by mail.gandi.net (Postfix) with ESMTPSA id 497E460004;
	Wed,  3 Apr 2024 22:51:33 +0000 (UTC)
Message-ID: <02b50aae-f0e9-47a4-8365-a977a85975d3@ovn.org>
Date: Thu, 4 Apr 2024 00:52:15 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 3/3] genetlink: fit NLMSG_DONE into same
 read() as families
Content-Language: en-US
To: Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>
Cc: Stefano Brivio <sbrivio@redhat.com>, davem@davemloft.net,
 netdev@vger.kernel.org, pabeni@redhat.com, jiri@resnulli.us,
 idosch@idosch.org, johannes@sipsolutions.net, fw@strlen.de,
 pablo@netfilter.org, Martin Pitt <mpitt@redhat.com>,
 Paul Holzinger <pholzing@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>, i.maximets@ovn.org
References: <20240303052408.310064-1-kuba@kernel.org>
 <20240303052408.310064-4-kuba@kernel.org> <20240315124808.033ff58d@elisabeth>
 <20240319085545.76445a1e@kernel.org>
 <CANn89i+afBvqP564v6TuL3OGeRxfDNMuwe=EdH_3N4UuHsvfuA@mail.gmail.com>
 <20240319104046.203df045@kernel.org>
From: Ilya Maximets <i.maximets@ovn.org>
Autocrypt: addr=i.maximets@ovn.org; keydata=
 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
In-Reply-To: <20240319104046.203df045@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-GND-Sasl: i.maximets@ovn.org

On 3/19/24 18:40, Jakub Kicinski wrote:
> On Tue, 19 Mar 2024 18:17:47 +0100 Eric Dumazet wrote:
>>> Hi Stefano! I was worried this may happen :( I think we should revert
>>> offending commits, but I'd like to take it on case by case basis.
>>> I'd imagine majority of netlink is only exercised by iproute2 and
>>> libmnl-based tools. Does passt hang specifically on genetlink family
>>> dump? Your commit also mentions RTM_GETROUTE. This is not the only
>>> commit which removed DONE:
>>>
>>> $ git log --since='1 month ago' --grep=NLMSG_DONE --no-merges  --oneline
>>>
>>> 9cc4cc329d30 ipv6: use xa_array iterator to implement inet6_dump_addr()
>>> 87d381973e49 genetlink: fit NLMSG_DONE into same read() as families
>>> 4ce5dc9316de inet: switch inet_dump_fib() to RCU protection
>>> 6647b338fc5c netlink: fix netlink_diag_dump() return value  
>>
>> Lets not bring back more RTNL locking please for the handlers that
>> still require it.
> 
> Definitely. My git log copy/paste is pretty inaccurate, these two are
> better examples:
> 
> 5d9b7cb383bb nexthop: Simplify dump error handling
> 02e24903e5a4 netlink: let core handle error cases in dump operations
> 
> I was trying to point out that we merged a handful of DONE "coalescing"
> patches, and if we need to revert - let's only do that for the exact
> commands needed. The comment was raised on my genetlink patch while
> the discussion in the link points to RTM_GETROUTE.
> 
>> The core can generate an NLMSG_DONE by itself, if we decide this needs
>> to be done.
> 
> Exactly.

FWIW, it seems that Libreswan is suffering from the same issue on
RTM_GETROUTE dump.

On 6.9.0-rc1 I see:

/usr/sbin/ipsec auto --config ipsec.conf --ctlsocket pluto.ctl \
                     --start --asynchronous tun-in-1

recvfrom(7, 
[
  [{nlmsg_len=52, nlmsg_type=RTM_NEWROUTE, nlmsg_flags=NLM_F_MULTI, ...],
  ...
  [{nlmsg_len=52, nlmsg_type=RTM_NEWROUTE, nlmsg_flags=NLM_F_MULTI, ...],
  [{nlmsg_len=20, nlmsg_type=NLMSG_DONE, nlmsg_flags=NLM_F_MULTI, ...]
], 40960, 0, {sa_family=AF_NETLINK, nl_pid=0, nl_groups=00000000}, [12])

recvfrom(7, <-- Stuck here forever


On 6.8.0 the output is following:

recvfrom(7, 
[
  [{nlmsg_len=52, nlmsg_type=RTM_NEWROUTE, nlmsg_flags=NLM_F_MULTI, ...],
  ...
  [{nlmsg_len=52, nlmsg_type=RTM_NEWROUTE, nlmsg_flags=NLM_F_MULTI, ...]
], 40960, 0, {sa_family=AF_NETLINK, nl_pid=0, nl_groups=00000000}, [12])

recvfrom(7,
  [{nlmsg_len=20, nlmsg_type=NLMSG_DONE, nlmsg_flags=NLM_F_MULTI,}, 0],
  40728, 0, {sa_family=AF_NETLINK, nl_pid=0, nl_groups=00000000}, [12])
close(7)

So, it seems like it explicitly waits for NLMSG_DONE to be in a separate
message.

I reported the issue to Libreswan:
  https://github.com/libreswan/libreswan/issues/1675
but just wanted to let you know as well.

Found this since it breaks IPsec system tests in Open vSwitch.

Best regards, Ilya Maximets.

