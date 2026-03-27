Return-Path: <netdev+bounces-272609-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kOHvLwSmxmk4NQUAu9opvQ
	(envelope-from <netdev+bounces-272609-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 16:45:08 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F06B1346F4A
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 16:45:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 41D5330E628F
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 15:38:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8237E30E821;
	Fri, 27 Mar 2026 15:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tu-berlin.de header.i=@tu-berlin.de header.b="Oi4mmtc7"
X-Original-To: netdev@vger.kernel.org
Received: from mailrelay.tu-berlin.de (mailrelay.tu-berlin.de [130.149.7.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98B872C032E
	for <netdev@vger.kernel.org>; Fri, 27 Mar 2026 15:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.149.7.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774625925; cv=none; b=fc7kQRntkh0++nloI+JBqH3D3Zl0F8/dI34mk9B0BgRFRZKWdcuyfohAFV2m9tcR39vJHC1n4n3VU0Bx7XczlEuqi1HsBtBLovLJnZxQeA6HC9yj3exbtwDTnsWuGKQdgbUDVn6KnTIt2edE1anvz9dWX9Sk4GLL3d75T+PFOow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774625925; c=relaxed/simple;
	bh=oxrd/FXIG2NtKUOPfAUtII/76xr+fJ/T0TMKVaYDwAs=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:CC:References:
	 In-Reply-To:Content-Type; b=JcrRkEPy4FG7mQYMUmHclGcbpPtGYKwzWg9tGUyY60hsxk+7hRsdtgtLzWXfGFSR8oLGbOEz8WbmPs/X4REoihd0cNP/ixobMs2yKTTmx7vymqRlj2X8sIoHdnSv68fYMj2F4pzYxRfAHIgfFUfOJO245rJbur3fcXsXDDoRzZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tu-berlin.de; spf=pass smtp.mailfrom=tu-berlin.de; dkim=pass (2048-bit key) header.d=tu-berlin.de header.i=@tu-berlin.de header.b=Oi4mmtc7; arc=none smtp.client-ip=130.149.7.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tu-berlin.de
DKIM-Signature: v=1; a=rsa-sha256; c=simple/relaxed;
  d=tu-berlin.de; s=dkim-tub26; t=1774625921;
  h=message-id:date:mime-version:from:subject:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=WueNSf/BJNtUXGDLFHv8M7KTPLmHzdEemSEASsvGJis=;
  b=Oi4mmtc7vwObJ2h3Izy/K/0IUqoYasif1VL135mfJ8oEgIDkez8wMg+d
   Os+Phwn7Ikp6ROn1pKgiuPVC4xIxDqURxaXwmoe5+V5p+trcJJpr4ww2K
   yvfZYtrfiVaCB7BXlJ9Ux2YYosMl0EGNr032rIK31ansQPbOqmVfk3Nam
   jEbET+1UV/gGsLfdzKlkrsuvJWY9Qz0MT9+MMPFZiL4pwn5aAeFO4BNyZ
   oAXtxWOZFLbYe4A45HkrHNLVK4F1b6bmHvC9JOAVyXL0zo4y654Nkwzv5
   Updk5hqtzwdV3phVHRhSksbl2iZYKLSnx0vTomieLkxN/cQSi74BFbJG2
   Q==;
X-CSE-ConnectionGUID: pY8xpNSeRGqfgBZLluT4IA==
X-CSE-MsgGUID: U3qityjAS9qYUHQJqFpYcA==
X-IronPort-AV: E=Sophos;i="6.23,144,1770591600"; 
   d="scan'208";a="59049920"
Received: from mail.tu-berlin.de ([141.23.12.141])
  by mailrelay.tu-berlin.de with ESMTP; 27 Mar 2026 16:37:30 +0100
Message-ID: <7d404bd3-4444-464e-8831-c8304ecf5b40@tu-berlin.de>
Date: Fri, 27 Mar 2026 16:37:28 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: =?UTF-8?Q?Jonas_K=C3=B6ppeler?= <j.koeppeler@tu-berlin.de>
Subject: Re: [PATCH net-next 0/5] veth: add Byte Queue Limits (BQL) support
To: Jesper Dangaard Brouer <hawk@kernel.org>,
	=?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
	<netdev@vger.kernel.org>
CC: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <horms@kernel.org>,
	<jhs@mojatatu.com>, <jiri@resnulli.us>, <kernel-team@cloudflare.com>, Chris
 Arges <chris.arges@gmail.com>, Mike Freemon <mike.freemon@cloudflare.com>
References: <20260324174719.1224337-1-hawk@kernel.org>
 <87h5q1d2j9.fsf@toke.dk> <7f00346d-5dc6-421b-8d61-75c1c3898c30@kernel.org>
Content-Language: en-US
Autocrypt: addr=j.koeppeler@tu-berlin.de; keydata=
 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
In-Reply-To: <7f00346d-5dc6-421b-8d61-75c1c3898c30@kernel.org>
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
	TAGGED_FROM(0.00)[bounces-272609-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,mojatatu.com,resnulli.us,cloudflare.com,gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[j.koeppeler@tu-berlin.de,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[tu-berlin.de:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,tu-berlin.de:dkim,tu-berlin.de:mid]
X-Rspamd-Queue-Id: F06B1346F4A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/27/26 13:49, Jesper Dangaard Brouer wrote:
>
>
> On 27/03/2026 10.50, Toke Høiland-Jørgensen wrote:
>> hawk@kernel.org writes:
>>
>>> From: Jesper Dangaard Brouer <hawk@kernel.org>
>>>
>>> This series adds BQL (Byte Queue Limits) to the veth driver, reducing
>>> latency by dynamically limiting in-flight bytes in the ptr_ring and
>>> moving buffering into the qdisc where AQM algorithms can act on it.
>>>
>>> Problem:
>>>    veth's 256-entry ptr_ring acts as a "dark buffer" -- packets queued
>>>    there are invisible to the qdisc's AQM.  Under load, the ring fills
>>>    completely (DRV_XOFF backpressure), adding up to 256 packets of
>>>    unmanaged latency before the qdisc even sees congestion.
>>>
>>> Solution:
>>>    BQL (STACK_XOFF) dynamically limits in-flight bytes, stopping the
>>>    queue before the ring fills.  This keeps the ring shallow and pushes
>>>    excess packets into the qdisc, where sojourn-based AQM can measure
>>>    and drop them.
>>
>> So one question here: Is *Byte* queue limits really the right thing for
>> veth? As you mention above, the ptr_ring is sized in a number of
>> packets. On a physical NIC, accounting bytes makes sense because there's
>> a fixed line rate, so bytes turn directly into latency.
>>
>> But on a veth device, the stack processing is per packet, and most
>> processing takes the same amount of time regardless of the size of the
>> packet (e.g., netfilter rules that operate on the skb only).
>>
>> So my worry would be that when you're accounting in bytes, if there's a
>> mix of big and small packets, you'd end up with the BQL algorithm
>> scaling to a "too large" value, which would allow a lot of small packets
>> to be queued up, adding extra latency (or even overflowing the ring
>> buffer if the ratio is large enough).
>>
>> Have you run any such experiments? 
>
> Thank for bring this up.
> Yes, we have considered this (and agree).
>
> Jonas is conduction some experiments.
> I will let Jonas answer?
Hi,

I used the provided selftest, modified so that the payload size alternates
between 1400 bytes and sizeof(struct pkt_hdr) = 24 bytes every 5000 packets.

The receiver was slowed down using 10K iptables rules. I could confirm that
the receive queue filled up to ~66 packets, whereas the BQL limit is around
2884 bytes, corresponding to approximately 2 x 1400-byte packets.

I compared two accounting strategies: using skb->len vs. a fixed size of 1.

Ping results over 5 runs using skb->len accounting:

   rtt min/avg/max/mdev = 0.636/2.784/ 9.543/1.735 ms
   rtt min/avg/max/mdev = 0.629/2.947/10.587/1.927 ms
   rtt min/avg/max/mdev = 0.587/2.966/11.625/1.963 ms
   rtt min/avg/max/mdev = 0.589/3.006/10.694/1.979 ms

Ping results over 5 runs using fixed size (1) accounting:

   rtt min/avg/max/mdev = 0.587/2.446/6.261/1.065 ms
   rtt min/avg/max/mdev = 0.641/2.339/6.008/0.950 ms
   rtt min/avg/max/mdev = 0.688/2.527/5.506/1.086 ms
   rtt min/avg/max/mdev = 0.596/2.411/5.228/1.041 ms

The avg and max RTT are consistently lower with the fixed-size accounting.
This suggests that the excess buffered packets contribute to some latency.

Jonas
>
> > And have you tried just accounting> the queue in packets, so instead 
> of:
>>
>> +        netdev_tx_sent_queue(txq, skb->len);
>>
>> you'd just do:
>>
>> +        netdev_tx_sent_queue(txq, 1);
>
> I've been playing with using 1000 instead of 1, as that seems to work
> better with the DQL algorithm[1].
>
> --Jesper
>
> [1] 
> https://medium.com/@tom_84912/byte-queue-limits-the-unauthorized-biography-61adc5730b83
>
>

