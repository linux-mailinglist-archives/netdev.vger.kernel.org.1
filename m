Return-Path: <netdev+bounces-87074-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A25DA8A1A21
	for <lists+netdev@lfdr.de>; Thu, 11 Apr 2024 18:38:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D02C282ADE
	for <lists+netdev@lfdr.de>; Thu, 11 Apr 2024 16:38:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE4BA1CAE85;
	Thu, 11 Apr 2024 15:38:46 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 943721CA6CF
	for <netdev@vger.kernel.org>; Thu, 11 Apr 2024 15:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712849926; cv=none; b=JLzreImc/l+iaJ/AJMvPEHtpUQSdgzlsLKibiRxbQNC7CDi3zBw/qDhVfhNkTz07SKPzdT26fqgBCZ9Bsbr5LRC8I1oyAa/PIMR2Ne07863cjvCsVlT1E7R3EYCW3tHrLXrR51pXo9dNZgK09bv/SQlMbcsQjHyA6JyThuTekek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712849926; c=relaxed/simple;
	bh=jzwK8eP5A+OKWCbpa1EFlNgY0dlZlVext7JKXzDZLo4=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=XHNCDt3S5lGf28eex0uwqLMXAcouqrL95IqNNnjILGLISwUQT/cybYsk/3iQ8MTlR5JmAf9GvApMz9JL4DBkblBIXWlQDwTjNs0QOwVwEHo8ko10w+34RG6UX4OyY5kwfDA7cjbD227SddqeoN7JW1daijJzjvbM8SGvXdJWMjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org; spf=pass smtp.mailfrom=ovn.org; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ovn.org
Received: by mail.gandi.net (Postfix) with ESMTPSA id EE129FF806;
	Thu, 11 Apr 2024 15:38:36 +0000 (UTC)
Message-ID: <b2e7f22c-6da3-4f48-9940-f3cc1aea2af2@ovn.org>
Date: Thu, 11 Apr 2024 17:39:20 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: i.maximets@ovn.org, Eric Dumazet <edumazet@google.com>,
 Stefano Brivio <sbrivio@redhat.com>, davem@davemloft.net,
 netdev@vger.kernel.org, pabeni@redhat.com, jiri@resnulli.us,
 idosch@idosch.org, johannes@sipsolutions.net, fw@strlen.de,
 pablo@netfilter.org, Martin Pitt <mpitt@redhat.com>,
 Paul Holzinger <pholzing@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCH net-next v2 3/3] genetlink: fit NLMSG_DONE into same
 read() as families
To: Jakub Kicinski <kuba@kernel.org>
References: <20240303052408.310064-1-kuba@kernel.org>
 <20240303052408.310064-4-kuba@kernel.org> <20240315124808.033ff58d@elisabeth>
 <20240319085545.76445a1e@kernel.org>
 <CANn89i+afBvqP564v6TuL3OGeRxfDNMuwe=EdH_3N4UuHsvfuA@mail.gmail.com>
 <20240319104046.203df045@kernel.org>
 <02b50aae-f0e9-47a4-8365-a977a85975d3@ovn.org>
 <20240411081610.71818cfc@kernel.org>
Content-Language: en-US
From: Ilya Maximets <i.maximets@ovn.org>
Autocrypt: addr=i.maximets@ovn.org; keydata=
 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
In-Reply-To: <20240411081610.71818cfc@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-GND-Sasl: i.maximets@ovn.org

On 4/11/24 17:16, Jakub Kicinski wrote:
> On Thu, 4 Apr 2024 00:52:15 +0200 Ilya Maximets wrote:
>> /usr/sbin/ipsec auto --config ipsec.conf --ctlsocket pluto.ctl \
>>                      --start --asynchronous tun-in-1
>>
>> recvfrom(7, 
>> [
>>   [{nlmsg_len=52, nlmsg_type=RTM_NEWROUTE, nlmsg_flags=NLM_F_MULTI, ...],
>>   ...
>>   [{nlmsg_len=52, nlmsg_type=RTM_NEWROUTE, nlmsg_flags=NLM_F_MULTI, ...],
>>   [{nlmsg_len=20, nlmsg_type=NLMSG_DONE, nlmsg_flags=NLM_F_MULTI, ...]
>> ], 40960, 0, {sa_family=AF_NETLINK, nl_pid=0, nl_groups=00000000}, [12])
>>
>> recvfrom(7, <-- Stuck here forever
> 
> I think we should probably fix this..
> Would you mind sharing the sendmsg() call? Eyeballing rtnl_dump_all() -
> it does seem to coalesce DONE..

Sure, the whole sequence looks like this in strace:

socket(AF_NETLINK, SOCK_DGRAM|SOCK_CLOEXEC, NETLINK_ROUTE) = 7

sendto(7, [
  {
    nlmsg_len=36, nlmsg_type=0x1a /* NLMSG_??? */,
    nlmsg_flags=NLM_F_REQUEST|0x300, nlmsg_seq=0, nlmsg_pid=138040
  },
  "\x02\x20\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x08\x00\x01\x00\x0a\x01\x01\x02"
], 36, 0, NULL, 0) = 36

recvfrom(7, [
 [
   {nlmsg_len=52, nlmsg_type=RTM_NEWROUTE, nlmsg_flags=NLM_F_MULTI, nlmsg_seq=0, nlmsg_pid=138040},
   {rtm_family=AF_INET, rtm_dst_len=0, rtm_src_len=0, rtm_tos=0, rtm_table=RT_TABLE_MAIN,
    rtm_protocol=RTPROT_BOOT, rtm_scope=RT_SCOPE_UNIVERSE, rtm_type=RTN_UNICAST, rtm_flags=0},
   [
     [{nla_len=8, nla_type=RTA_TABLE}, RT_TABLE_MAIN],
     [{nla_len=8, nla_type=RTA_GATEWAY}, inet_addr("10.1.1.2")],
     [{nla_len=8, nla_type=RTA_OIF}, if_nametoindex("p0")]
   ]
 ],
 [
   {nlmsg_len=60, nlmsg_type=RTM_NEWROUTE, nlmsg_flags=NLM_F_MULTI, nlmsg_seq=0, nlmsg_pid=138040},
   {rtm_family=AF_INET, rtm_dst_len=24, rtm_src_len=0, rtm_tos=0, rtm_table=RT_TABLE_MAIN,
    rtm_protocol=RTPROT_KERNEL, rtm_scope=RT_SCOPE_LINK, rtm_type=RTN_UNICAST, rtm_flags=0},
   [
     [{nla_len=8, nla_type=RTA_TABLE}, RT_TABLE_MAIN],
     [{nla_len=8, nla_type=RTA_DST}, inet_addr("10.1.1.0")],
     [{nla_len=8, nla_type=RTA_PREFSRC}, inet_addr("10.1.1.1")],
     [{nla_len=8, nla_type=RTA_OIF}, if_nametoindex("p0")]
   ]
 ],
 [
   {nlmsg_len=60, nlmsg_type=RTM_NEWROUTE, nlmsg_flags=NLM_F_MULTI, nlmsg_seq=0, nlmsg_pid=138040},
   {rtm_family=AF_INET, rtm_dst_len=32, rtm_src_len=0, rtm_tos=0, rtm_table=RT_TABLE_LOCAL,
    rtm_protocol=RTPROT_KERNEL, rtm_scope=RT_SCOPE_HOST, rtm_type=RTN_LOCAL, rtm_flags=0},
   [
     [{nla_len=8, nla_type=RTA_TABLE}, RT_TABLE_LOCAL],
     [{nla_len=8, nla_type=RTA_DST}, inet_addr("10.1.1.1")],
     [{nla_len=8, nla_type=RTA_PREFSRC}, inet_addr("10.1.1.1")],
     [{nla_len=8, nla_type=RTA_OIF}, if_nametoindex("p0")]
   ]
 ],
 [
   {nlmsg_len=60, nlmsg_type=RTM_NEWROUTE, nlmsg_flags=NLM_F_MULTI, nlmsg_seq=0, nlmsg_pid=138040},
   {rtm_family=AF_INET, rtm_dst_len=32, rtm_src_len=0, rtm_tos=0, rtm_table=RT_TABLE_LOCAL,
    rtm_protocol=RTPROT_KERNEL, rtm_scope=RT_SCOPE_LINK, rtm_type=RTN_BROADCAST, rtm_flags=0},
   [
     [{nla_len=8, nla_type=RTA_TABLE}, RT_TABLE_LOCAL],
     [{nla_len=8, nla_type=RTA_DST}, inet_addr("10.1.1.255")],
     [{nla_len=8, nla_type=RTA_PREFSRC}, inet_addr("10.1.1.1")],
     [{nla_len=8, nla_type=RTA_OIF}, if_nametoindex("p0")]
   ]
 ],
 [
   {nlmsg_len=20, nlmsg_type=NLMSG_DONE, nlmsg_flags=NLM_F_MULTI, nlmsg_seq=0, nlmsg_pid=138040}, 0
 ]
], 40960, 0, {sa_family=AF_NETLINK, nl_pid=0, nl_groups=00000000}, [12]) = 252

recvfrom(7,  <unfinished ...>


nlmsg_type=0x1a /* NLMSG_??? */  --> RTM_GETROUTE
nlmsg_flags=NLM_F_REQUEST|0x300  --> NLM_F_REQUEST|NLM_F_DUMP

Best regards, Ilya Maximets.

