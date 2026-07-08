Return-Path: <netdev+bounces-305951-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id VAAyGM+ZTmphQQIAu9opvQ
	(envelope-from <netdev+bounces-305951-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Jul 2026 20:41:19 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E877B7299DC
	for <lists+netdev@lfdr.de>; Wed, 08 Jul 2026 20:41:18 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=tFfZ5hZX;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305951-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-305951-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D96B63061D41
	for <lists+netdev@lfdr.de>; Wed,  8 Jul 2026 18:36:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E02D4CA276;
	Wed,  8 Jul 2026 18:36:16 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F10DC4C8FE6
	for <netdev@vger.kernel.org>; Wed,  8 Jul 2026 18:36:14 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783535776; cv=none; b=UApTvOxPAM6Tc274Lk+4XKtCr0UV+MHenIIlJtpe3/y/hYlsJWI/tgzlxCaODOOWGMw+VbqDfUpC7XvNzDsZgvMpGfUmTkaZ9+iYjSB0L4Ae4raj3TM1Xv0AMi+vUczYGHmA88yag4D0avSNd7F4wLODvhInCcJ5PmNUVyXPvXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783535776; c=relaxed/simple;
	bh=G2H2imZ4fo8dNzfLfERwGQavgPhokh01V8hq8+UsP8A=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=f4NGW0IaVp7Z3bsCswyc1jeLW9HRt8F+b7zzYk5xy82E3lV+JDqNMi77XCd0WIxT5n5N7xP/48zwvoSFc/QV1ZOCQBLeg8QbkmmiJ3hLPZAHci8hlcqloVTHzdbWgAWYYTslXmyfB+MOxDXbh4kXfMH5aCaLRGusQuWSTY/TgOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=tFfZ5hZX; arc=none smtp.client-ip=209.85.208.54
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-698aa8d4dafso1034642a12.0
        for <netdev@vger.kernel.org>; Wed, 08 Jul 2026 11:36:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783535773; x=1784140573; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ynaYupb3vfef1dEfTEhXs8EICy43K01H4C9YfW8Cml0=;
        b=tFfZ5hZXXxjXj1+2wdRAyN2GVcbzCsw7+Gr2Wf6qpf5Zprc03EGfVy1BPA/0cV3iXd
         0iujq5DPIteY0fIevU1sk+HKCuI956fQ3KSx3TB0gmmQoc58L6csZXp09pGigoiCsYGl
         bd1mWNO67FdKPTyrkfq9F8G41ufwGi+BBF+aEOONepGCykwdEUV+AC3K0dg1O2PJagKZ
         358rAap0xLsamRi/Pi0KSY/yhdRcGoVVOjbA7keI52/ETmFituwZXWYxF1yguwgTHs8s
         W8Bq/nCgyglAdpCZT/OZ7LmoZobDAgULLy8cFhLzys0K0QkzeNYRnfbaQloe8WS+1Mf3
         vY6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783535773; x=1784140573;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:from:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ynaYupb3vfef1dEfTEhXs8EICy43K01H4C9YfW8Cml0=;
        b=sbqzyg1cGJsjZkUYnVxSzLNwum3/rvdPVlE4eqv5S84XW1WS/OFt8VjyEvKQPaKbqT
         bg/utcGxUuuqXTyXwXljq8TVaIdvIdFy3ZzsSy1PormnVMmsr45rjEq2/DCMv6vNT+Yh
         5umCDRmprqFpuoByAAJjYRjo1b3QkXPMqUeCSRarGqjoS2NfnEDdcV3pJ6qPcgXDscYM
         dOERM7ecq6yk/5+V2vLZsh3rxGY8h5ta7aRZKT8bLREyaJdjpyXzpIPmZAdJLBn1ILx+
         AP6gFeVXmuR+RMHMRR++SCMsGHvcc0yuJndM4Tnw6er9laa4jprVryN/J/SQqpta+ZuA
         K7Yg==
X-Forwarded-Encrypted: i=1; AHgh+RqL1jDBf7kGCCvYZ2+arwa9GPAqqSLRfKbaVWhmSJgZFuc95w09NQYRbO9lfhQn2DqjPaOk4bw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwrsURQn7UVY/6Jbz48sIAtDpcMSxmD0qYfRT1PzpstIAs2J9UD
	UQ1Fa7pz5mMAjsHI/Uvb4WXwgJ0fDO/h9s2J8m4+zSNCVwVTGggbCdar
X-Gm-Gg: AfdE7cn6OvpvEXiCDau9BaLp0MZwr+NMwJBnzhvEqDUWKbgL5nkBxRaEEX1bKOaQUF0
	o8D30Pi/dkhUnxK5xhoZW6XU9D9kw82d+JtEJ7y1JZpiGgTuco2PzM90M84w7gTPRbbKgoDFXRl
	hYyoGzbZN8EDI9r+H1EAeRsjN++otmKT1DoPwjQsfB+gf1hYNnqeBd/T3O5fdhGg7LA76Cp2+nG
	NMLb7zI4DFna70fM6UGFJ/d7U09jnhUIUGTQxdKsjGaR+Mmg4zMJNUYmliHOjwQciCpAQYn0BLz
	5iMTHZ3IV8XYYM92mpnAMiP40CvOgMptj9z8v4xo/PxMFGGTb9Kzhgn3/6uaNaBwkkSYnQL7CEZ
	rA+Iwu1NcSpHBWkx20uw9dBqldczZkZhToL+N2ICSTbHyp1GA0Ti7//XTBfsuMSXr/xFWSbwu/W
	6QBlnQA96Mf8sD0jYCifTYmU3lJwp6+q7uV9gnmrC7MWQTXc1TVCncVpuL+9vq9VvLvGXWy8Fxg
	GY4pEXrk9T1Ps3yCpxlsTsiVrL9AZHmSEo8NH5CNB9QMyj5ZvMuZIdFN2dQ6SW+APEBu7LWyM+4
	DmjgZmOYdyhzapaN8pB1+jxMk5zxvCYu/w==
X-Received: by 2002:a17:906:2e9a:b0:c15:c3bb:c90a with SMTP id a640c23a62f3a-c15ce18c8b7mr128361266b.35.1783535773134;
        Wed, 08 Jul 2026 11:36:13 -0700 (PDT)
Received: from ?IPV6:2001:1c00:20d:1300:1b1c:4449:176a:89ea? (2001-1c00-020d-1300-1b1c-4449-176a-89ea.cable.dynamic.v6.ziggo.nl. [2001:1c00:20d:1300:1b1c:4449:176a:89ea])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c15d5de95e6sm115505766b.39.2026.07.08.11.36.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Jul 2026 11:36:12 -0700 (PDT)
Message-ID: <81c3bf65-b19b-4f80-aa8e-c0c4b3f5d6a7@gmail.com>
Date: Wed, 8 Jul 2026 20:36:11 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Eric Woudstra <ericwouds@gmail.com>
Subject: Re: [PATCH v12 nf-next 3/7] netfilter: nf_flow_table_offload: Add
 nf_flow_rule_bridge()
To: Pablo Neira Ayuso <pablo@netfilter.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Florian Westphal <fw@strlen.de>,
 Phil Sutter <phil@nwl.cc>, Nikolay Aleksandrov <razor@blackwall.org>,
 Ido Schimmel <idosch@nvidia.com>, Kuniyuki Iwashima <kuniyu@google.com>,
 Stanislav Fomichev <sdf.kernel@gmail.com>,
 Samiullah Khawaja <skhawaja@google.com>, Hangbin Liu <liuhangbin@gmail.com>,
 Krishna Kumar <krikku@gmail.com>, Martin Karsten <mkarsten@uwaterloo.ca>,
 netdev@vger.kernel.org, netfilter-devel@vger.kernel.org,
 bridge@lists.linux.dev
References: <20260707091045.967678-1-ericwouds@gmail.com>
 <20260707091045.967678-4-ericwouds@gmail.com> <ak4dAXHDmTDRr7-b@chamomile>
Content-Language: en-US
In-Reply-To: <ak4dAXHDmTDRr7-b@chamomile>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-305951-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:pablo@netfilter.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:fw@strlen.de,m:phil@nwl.cc,m:razor@blackwall.org,m:idosch@nvidia.com,m:kuniyu@google.com,m:sdf.kernel@gmail.com,m:skhawaja@google.com,m:liuhangbin@gmail.com,m:krikku@gmail.com,m:mkarsten@uwaterloo.ca,m:netdev@vger.kernel.org,m:netfilter-devel@vger.kernel.org,m:bridge@lists.linux.dev,m:andrew@lunn.ch,m:sdfkernel@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[ericwouds@gmail.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,strlen.de,nwl.cc,blackwall.org,nvidia.com,gmail.com,uwaterloo.ca,vger.kernel.org,lists.linux.dev];
	RCPT_COUNT_TWELVE(0.00)[20];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ericwouds@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,bridge_fastpath.sh:url,vger.kernel.org:from_smtp,blackwall.org:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E877B7299DC



On 7/8/26 11:48 AM, Pablo Neira Ayuso wrote:
> Hi,
> 
> On Tue, Jul 07, 2026 at 11:10:41AM +0200, Eric Woudstra wrote:
>> Add nf_flow_rule_bridge().
>>
>> It only calls the common rule and adds the redirect.
> 
> I decided to use the new _unsupp() function, so we don't pretend
> bridge hw offload is already supported. We will need a driver before
> we can add this, this stub does not provide much. I guess your goal
> was just to avoid a crash here.
> 

No, I am already using hw_offload between bridged interfaces
on the mt7986 succesfully for almost 2 years.
It works dsa-port to direct interface (lan1 to eth1 on Bananapi R3) and
between direct interfaces (eth0 to eth1 on Bananapi-R3-mini)

It can also be tested with my bridge_fastpath.sh selftest script.
This script uses veth-device pairs to test the software fastpath.
It can also use 2 real interfaces interconnected in a loop of copper,
when chosen with commandline arguments. Then it tests software- and
hardware-fastpath. It also tests many different scenarios.

So this is why I've added it, as it is already functional. If a software
fastpath is setup correctly, the hardware fastpath is also functional.

>> Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>
>> Signed-off-by: Eric Woudstra <ericwouds@gmail.com>
>> ---
>>  include/net/netfilter/nf_flow_table.h |  3 +++
>>  net/netfilter/nf_flow_table_offload.c | 13 +++++++++++++
>>  2 files changed, 16 insertions(+)
>>
>> diff --git a/include/net/netfilter/nf_flow_table.h b/include/net/netfilter/nf_flow_table.h
>> index 7b23b245a5a86..5c6e3b65ae85b 100644
>> --- a/include/net/netfilter/nf_flow_table.h
>> +++ b/include/net/netfilter/nf_flow_table.h
>> @@ -368,6 +368,9 @@ void nf_flow_table_offload_flush_cleanup(struct nf_flowtable *flowtable);
>>  int nf_flow_table_offload_setup(struct nf_flowtable *flowtable,
>>  				struct net_device *dev,
>>  				enum flow_block_command cmd);
>> +int nf_flow_rule_bridge(struct net *net, struct flow_offload *flow,
>> +			enum flow_offload_tuple_dir dir,
>> +			struct nf_flow_rule *flow_rule);
>>  int nf_flow_rule_route_ipv4(struct net *net, struct flow_offload *flow,
>>  			    enum flow_offload_tuple_dir dir,
>>  			    struct nf_flow_rule *flow_rule);
>> diff --git a/net/netfilter/nf_flow_table_offload.c b/net/netfilter/nf_flow_table_offload.c
>> index 002ec15d988bd..5566ebda7b7d3 100644
>> --- a/net/netfilter/nf_flow_table_offload.c
>> +++ b/net/netfilter/nf_flow_table_offload.c
>> @@ -740,6 +740,19 @@ nf_flow_rule_route_common(struct net *net, const struct flow_offload *flow,
>>  	return 0;
>>  }
>>  
>> +int nf_flow_rule_bridge(struct net *net, struct flow_offload *flow,
>> +			enum flow_offload_tuple_dir dir,
>> +			struct nf_flow_rule *flow_rule)
>> +{
>> +	if (nf_flow_rule_route_common(net, flow, dir, flow_rule) < 0)
>> +		return -1;
>> +
>> +	flow_offload_redirect(net, flow, dir, flow_rule);
>> +
>> +	return 0;
>> +}
>> +EXPORT_SYMBOL_GPL(nf_flow_rule_bridge);
>> +
>>  int nf_flow_rule_route_ipv4(struct net *net, struct flow_offload *flow,
>>  			    enum flow_offload_tuple_dir dir,
>>  			    struct nf_flow_rule *flow_rule)
>> -- 
>> 2.53.0
>>


