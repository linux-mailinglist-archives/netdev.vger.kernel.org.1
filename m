Return-Path: <netdev+bounces-294067-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qCmjF5aGHmqhkQkAu9opvQ
	(envelope-from <netdev+bounces-294067-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 09:30:30 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AD479629B6A
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 09:30:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7F353300F5FF
	for <lists+netdev@lfdr.de>; Tue,  2 Jun 2026 07:24:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43D9C363C72;
	Tue,  2 Jun 2026 07:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tu-berlin.de header.i=@tu-berlin.de header.b="fwOPFrj5"
X-Original-To: netdev@vger.kernel.org
Received: from mailrelay.tu-berlin.de (mailrelay.tu-berlin.de [130.149.7.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D82534BA20;
	Tue,  2 Jun 2026 07:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.149.7.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780385057; cv=none; b=jVQ4cBpELeuCetR/7IGKlkYjSsK6ecURhkIv+X2vBitI9n/dyiJYY2DSYp+HAyOw9exqraxZscurc/2raQ7jBY8j4sDeuaUULmiLuMDgtG+xG0DZM5CkovkX6un4Xq6FJ8txvMOZkKpZbejGEA3CBMR/t9B5A/rbuoRerht8sOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780385057; c=relaxed/simple;
	bh=oQna0RVvrecZnyebxJ9KjhtcwD+dEoj05VuZnEkj1SA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=EWa5dT6ypRUPZKV/5HDnUAWni+cI75oP1unOZjOq56lACJUFtOKudYUL93JHra7yoot+u7CBd+hoZBJxUUOC5iMNei6mfNenOmBjKcZspXx124c1L+AWgSFBaOaXROOsnU5rUNr0enPdD1w0oow6EfQ8Y8GcfTMu0cD2pRlb4gk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tu-berlin.de; spf=pass smtp.mailfrom=tu-berlin.de; dkim=pass (2048-bit key) header.d=tu-berlin.de header.i=@tu-berlin.de header.b=fwOPFrj5; arc=none smtp.client-ip=130.149.7.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tu-berlin.de
DKIM-Signature: v=1; a=rsa-sha256; c=simple/relaxed;
  d=tu-berlin.de; s=dkim-tub26; t=1780385053;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=yQTb2FuY0vYWT4UGQMIuYs5KgW23Da4orzcpQOLj9tI=;
  b=fwOPFrj5WdKr8GC6WH6Zkbn/eDE3X+BNImkUtKD29AzTp5PSw/RrlFOw
   h5er9HkjMl2uVi2D0JFMRbGzDV0yzpmwJM6N9VUSCc0/Jz3zsIHjAlzoj
   7UthdzSM331l1fXijiBQSMuyERjdyb2Ms681xQkWBYMB8Euwk3+dCyyqQ
   qWvbmMxdfnmW1YfiD4YPQJRf0igPSROBHyO+Ldd14xCT2McNNLyXdXmLM
   /KzKl46FGNHt70QHqsThZFDiQLnSd2ASOXJI7rdAHT1OxezZQQh2SSQA7
   tYaLS77cteOx5j4/yviHNRQKPOD1rAdDFWg8d4U7qKRN7IEQPvlFNBgOu
   g==;
X-CSE-ConnectionGUID: 8KbqUswITqGrTCiFWhDfEA==
X-CSE-MsgGUID: y3A5SAgZSoiIRvdisVC3Gw==
X-IronPort-AV: E=Sophos;i="6.24,182,1774306800"; 
   d="scan'208";a="62067161"
Received: from postcard.tu-berlin.de (HELO mail.tu-berlin.de) ([141.23.12.142])
  by mailrelay.tu-berlin.de with ESMTP; 02 Jun 2026 09:24:10 +0200
Message-ID: <e3d28da7-0fe3-4970-865c-9f51346e01fd@tu-berlin.de>
Date: Tue, 2 Jun 2026 09:24:08 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v6 5/5] veth: time-based BQL completion
 coalescing via ethtool tx-usecs
To: Simon Schippers <simon.schippers@tu-dortmund.de>, <hawk@kernel.org>,
	<netdev@vger.kernel.org>
CC: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Alexei Starovoitov
	<ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, John Fastabend
	<john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>,
	<linux-kernel@vger.kernel.org>, <bpf@vger.kernel.org>
References: <20260527135418.1166665-1-hawk@kernel.org>
 <20260527135418.1166665-6-hawk@kernel.org>
 <2affe9f4-56a7-4482-931f-9d98cfdf09fd@tu-berlin.de>
 <db5b7f7e-135c-40f0-a740-057bc6623e6c@tu-dortmund.de>
 <865f31e5-4e90-4dc0-890f-b5796948b590@tu-berlin.de>
 <55b23925-9676-4005-8c13-ea7001190abb@tu-dortmund.de>
Content-Language: en-US
From: =?UTF-8?Q?Jonas_K=C3=B6ppeler?= <j.koeppeler@tu-berlin.de>
In-Reply-To: <55b23925-9676-4005-8c13-ea7001190abb@tu-dortmund.de>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[tu-berlin.de,quarantine];
	R_DKIM_ALLOW(-0.20)[tu-berlin.de:s=dkim-tub26];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-294067-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,iogearbox.net,gmail.com,fomichev.me,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[j.koeppeler@tu-berlin.de,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[tu-berlin.de:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tu-berlin.de:email,tu-berlin.de:mid,tu-berlin.de:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,tu-dortmund.de:email]
X-Rspamd-Queue-Id: AD479629B6A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 6/1/26 6:16 PM, Simon Schippers wrote:

> On 6/1/26 16:03, Jonas Köppeler wrote:
>> On 6/1/26 2:00 PM, Simon Schippers wrote:
>>> On 5/28/26 09:46, Jonas Köppeler wrote:
>>>> On 5/27/26 3:54 PM, hawk@kernel.org wrote:
>>>>> From: Simon Schippers <simon.schippers@tu-dortmund.de>
>>>>>
>>>>> Per-packet BQL completion forces DQL to converge on limit=2, causing
>>>>> excessive NAPI scheduling overhead and qdisc requeues.
>>>>>
>>>>> Accumulate BQL completions and flush them when a configurable time
>>>>> threshold is exceeded, letting DQL discover a limit that bounds actual
>>>>> queuing delay to the configured interval. Coalescing state persists
>>>>> across NAPI polls in struct veth_rq so completions can accumulate
>>>>> beyond a single budget=64 cycle.
>>>>>
>>>>> Add ethtool tx-usecs support for runtime tuning. Default is 100 us;
>>>>> setting tx-usecs to 0 disables coalescing and falls back to per-packet
>>>>> completion.
>>>>>
>>>>>      ethtool -C <veth-dev> tx-usecs 500  # 500us coalescing
>>>>>      ethtool -C <veth-dev> tx-usecs 0    # per-packet (no coalescing)
>>>>>
>>>>> Co-developed-by: Jesper Dangaard Brouer <hawk@kernel.org>
>>>>> Signed-off-by: Jesper Dangaard Brouer <hawk@kernel.org>
>>>>> Signed-off-by: Simon Schippers <simon.schippers@tu-dortmund.de>
>>>> Tested-by: Jonas Köppeler<j.koeppeler@tu-berlin.de>
>>>>
>>> Thanks for your testing!
>>>
>>> However, I have issues reproducing.
>>> I run bare metal (without virtme) with v6 + your pktgen patch
>>> and I am on the branch pktgen-and-benchmark, commit
>>> "results: add veth-bql measurements":
>>>
>>> 1. ping fails with 100% packet loss ~20% of the times with --pktgen.
>>>      When this happens the avg ping of this run is mistakenly set
>>>      to 0.0 ms, which distorts the results.
>>>      I fixed it locally by rerunning when this happens.
>>>
>>> 2. pktgen runs with > 3 Mpps even with --nrules 10000, see log below.
>>>      I see that this is because of qdisc drops.
>>>      I also tried pfifo and sfq but with the same result.
>>>      I spent quite some time on it but I do not know a fix.
>>>
>>> Do you have an idea?
>>> Thanks!
>> Hi,
>> yes there are some changes missing in the test script.
>> I have pushed it now, sorry. This should fix 1.
> I pulled it and ran...
>
> sudo ./veth_bql_sweep.sh --runs 1 --pktgen --duration 20 --qdisc fq_codel --no-bpftrace
>
> ... but still 8/32=1/4 of the pings are zero, I do not see
> a pattern.
>
>
> I grabbed the logs from /tmp and this is what a failing
> ping looks like:
>
> PING 10.99.0.2 (10.99.0.2) 56(84) bytes of data.
>
> --- 10.99.0.2 ping statistics ---
> 97 packets transmitted, 0 received, 100% packet loss, time 19967ms
>
>
> Feels like a race or something..
> Can you reproduce with the exact command?
> I think you need --runs 1, else it just averages over multiple
> runs.

Sorry, no I could not reproduce this. I used the exact same
command as you did, and I am using net-next/main + v6 patches.
I have 0% ping loss across all tests. Does the ping loss
happen regardless of the qdisc?

>
>> Regarding 2.: do not look at the pktgen output, in the
>> new version you will see something like "goodput",
>> which is the number you should look for.
>> Pktgen will report at what speed it enqueued packets in
>> the qdisc.
> Exactly. Now it works. Had a single outlier but apart from that
> everything is fine.
>
> Thanks,
> Simon
>
>> Let me know if it worked.
>> Best,
>> Jonas
>>

