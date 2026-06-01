Return-Path: <netdev+bounces-293830-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6BsGKNazHWqkdAkAu9opvQ
	(envelope-from <netdev+bounces-293830-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 18:31:18 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E95D2622950
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 18:31:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EF79B308839A
	for <lists+netdev@lfdr.de>; Mon,  1 Jun 2026 16:17:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BDDE299A82;
	Mon,  1 Jun 2026 16:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=tu-dortmund.de header.i=@tu-dortmund.de header.b="Lj5S6Tii"
X-Original-To: netdev@vger.kernel.org
Received: from unimail.uni-dortmund.de (mx1.hrz.uni-dortmund.de [129.217.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2A5328C854;
	Mon,  1 Jun 2026 16:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=129.217.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780330621; cv=none; b=fOTw0dt0ObwvY/oe8bD9Wh21kTkykUYTY2nj+5MJHKygh4u+5lA4/n3uEFW+cR09Dvs4/iua3xO+//TDOpuZQzKe/nwQtouldUaobKUbuhiZlPDa/JhNWKpdillb18XNowIJj+vSJikY14xlqYqSLVEgerxxuEZBqtsQAqmY7zA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780330621; c=relaxed/simple;
	bh=qnX9OBr2YzgB1Y9Syidryj2KKo59v8mKgbHhyAeSTRs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RGg9lysO0TaxG9uxIEi2ZOINTU2iyWHeCgcscNqhNOxNUDZHWrHkwEQKKSzYnwLudUHvDSIbvedy9oN4781+IOM3Kxqz8Wv8nX0dssIUm8X/5EBRMC2hFQz1TyvLhUWbVXOoebsmIAiyWQCITbxAjlLf4+GdrBZ1ksUwyUPGI1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tu-dortmund.de; spf=pass smtp.mailfrom=tu-dortmund.de; dkim=pass (1024-bit key) header.d=tu-dortmund.de header.i=@tu-dortmund.de header.b=Lj5S6Tii; arc=none smtp.client-ip=129.217.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tu-dortmund.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tu-dortmund.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tu-dortmund.de;
	s=unimail; t=1780330595;
	bh=qnX9OBr2YzgB1Y9Syidryj2KKo59v8mKgbHhyAeSTRs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=Lj5S6TiiI99IOcAVRA9upjIAwWX6QWdF36QmgI7MtuPPOAD48NH5gaQCN/m/1oSaA
	 Y7YyWoAQ7FsS6bS0923vTOGRPpIwoiklKxlQzobgG0+9fQF6sKP+6rFOnhqHSkkdAq
	 7pU95xJFsPP0Dt2IH03wM9pX0Mwp/PL1/YdHE+i8=
Received: from [129.217.186.133] ([129.217.186.133])
	(authenticated bits=0)
	by unimail.uni-dortmund.de (8.19.0.1/8.19.0.1) with ESMTPSA id 651GGY3o021703
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 1 Jun 2026 18:16:34 +0200 (CEST)
Message-ID: <55b23925-9676-4005-8c13-ea7001190abb@tu-dortmund.de>
Date: Mon, 1 Jun 2026 18:16:34 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v6 5/5] veth: time-based BQL completion
 coalescing via ethtool tx-usecs
To: =?UTF-8?Q?Jonas_K=C3=B6ppeler?= <j.koeppeler@tu-berlin.de>,
        hawk@kernel.org, netdev@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller"
 <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>,
        Stanislav Fomichev <sdf@fomichev.me>, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org
References: <20260527135418.1166665-1-hawk@kernel.org>
 <20260527135418.1166665-6-hawk@kernel.org>
 <2affe9f4-56a7-4482-931f-9d98cfdf09fd@tu-berlin.de>
 <db5b7f7e-135c-40f0-a740-057bc6623e6c@tu-dortmund.de>
 <865f31e5-4e90-4dc0-890f-b5796948b590@tu-berlin.de>
Content-Language: en-US
From: Simon Schippers <simon.schippers@tu-dortmund.de>
In-Reply-To: <865f31e5-4e90-4dc0-890f-b5796948b590@tu-berlin.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[tu-dortmund.de,none];
	R_DKIM_ALLOW(-0.20)[tu-dortmund.de:s=unimail];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-293830-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,iogearbox.net,gmail.com,fomichev.me,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[simon.schippers@tu-dortmund.de,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[tu-dortmund.de:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,tu-dortmund.de:email,tu-dortmund.de:mid,tu-dortmund.de:dkim,tu-berlin.de:email]
X-Rspamd-Queue-Id: E95D2622950
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 6/1/26 16:03, Jonas Köppeler wrote:
> On 6/1/26 2:00 PM, Simon Schippers wrote:
>> On 5/28/26 09:46, Jonas Köppeler wrote:
>>> On 5/27/26 3:54 PM, hawk@kernel.org wrote:
>>>> From: Simon Schippers <simon.schippers@tu-dortmund.de>
>>>>
>>>> Per-packet BQL completion forces DQL to converge on limit=2, causing
>>>> excessive NAPI scheduling overhead and qdisc requeues.
>>>>
>>>> Accumulate BQL completions and flush them when a configurable time
>>>> threshold is exceeded, letting DQL discover a limit that bounds actual
>>>> queuing delay to the configured interval. Coalescing state persists
>>>> across NAPI polls in struct veth_rq so completions can accumulate
>>>> beyond a single budget=64 cycle.
>>>>
>>>> Add ethtool tx-usecs support for runtime tuning. Default is 100 us;
>>>> setting tx-usecs to 0 disables coalescing and falls back to per-packet
>>>> completion.
>>>>
>>>>     ethtool -C <veth-dev> tx-usecs 500  # 500us coalescing
>>>>     ethtool -C <veth-dev> tx-usecs 0    # per-packet (no coalescing)
>>>>
>>>> Co-developed-by: Jesper Dangaard Brouer <hawk@kernel.org>
>>>> Signed-off-by: Jesper Dangaard Brouer <hawk@kernel.org>
>>>> Signed-off-by: Simon Schippers <simon.schippers@tu-dortmund.de>
>>> Tested-by: Jonas Köppeler<j.koeppeler@tu-berlin.de>
>>>
>> Thanks for your testing!
>>
>> However, I have issues reproducing.
>> I run bare metal (without virtme) with v6 + your pktgen patch
>> and I am on the branch pktgen-and-benchmark, commit
>> "results: add veth-bql measurements":
>>
>> 1. ping fails with 100% packet loss ~20% of the times with --pktgen.
>>     When this happens the avg ping of this run is mistakenly set
>>     to 0.0 ms, which distorts the results.
>>     I fixed it locally by rerunning when this happens.
>>
>> 2. pktgen runs with > 3 Mpps even with --nrules 10000, see log below.
>>     I see that this is because of qdisc drops.
>>     I also tried pfifo and sfq but with the same result.
>>     I spent quite some time on it but I do not know a fix.
>>
>> Do you have an idea?
>> Thanks!
> 
> Hi,
> yes there are some changes missing in the test script.
> I have pushed it now, sorry. This should fix 1.

I pulled it and ran...

sudo ./veth_bql_sweep.sh --runs 1 --pktgen --duration 20 --qdisc fq_codel --no-bpftrace

... but still 8/32=1/4 of the pings are zero, I do not see
a pattern.


I grabbed the logs from /tmp and this is what a failing
ping looks like:

PING 10.99.0.2 (10.99.0.2) 56(84) bytes of data.

--- 10.99.0.2 ping statistics ---
97 packets transmitted, 0 received, 100% packet loss, time 19967ms


Feels like a race or something..
Can you reproduce with the exact command?
I think you need --runs 1, else it just averages over multiple
runs.

> Regarding 2.: do not look at the pktgen output, in the
> new version you will see something like "goodput",
> which is the number you should look for.
> Pktgen will report at what speed it enqueued packets in
> the qdisc.

Exactly. Now it works. Had a single outlier but apart from that
everything is fine.

Thanks,
Simon

> 
> Let me know if it worked.
> Best,
> Jonas
> 


