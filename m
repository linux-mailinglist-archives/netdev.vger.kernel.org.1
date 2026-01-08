Return-Path: <netdev+bounces-248087-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DCB5AD04051
	for <lists+netdev@lfdr.de>; Thu, 08 Jan 2026 16:49:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 72D5235A0AC1
	for <lists+netdev@lfdr.de>; Thu,  8 Jan 2026 15:26:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 883804A8F60;
	Thu,  8 Jan 2026 13:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="R5NhY23n";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="gjSaY0fL"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A405746BBE4
	for <netdev@vger.kernel.org>; Thu,  8 Jan 2026 13:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767879853; cv=none; b=YN0FuYts7FhI02y00MpZUlvcsPdCAadgRxQxbUmFR8r5M8hxJAl0q6GNdxlKthETp667jfMKyEnLaaysa07g/euVkRZoTjw/vl5bXNhwUtPfL85PhY/WfoEJQxJgRfVv5OluckxlJ5o66HzbSxPFFF51Ykp0WD8x2W6oE8G4DVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767879853; c=relaxed/simple;
	bh=NBVe8w4DXjKdDS41wFp7MgvMJgug9mnyzpq1ooHaol8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BB1TdNSTeSLgG7i3Db82CMhO2LCO7Obb6s0NJx83GpTRNFeiakuqMwLGQ3rtplk1NVcLBO+r6n6uB/AmrZlp6jJipr2ulzh2DhMmV4sasVpAWQV3PoX0uWN02hcDQDHxrd1fUYyPNCHmJTmiTFeYENR+De0QwCzug2jwdUfBvVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=R5NhY23n; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=gjSaY0fL; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767879847;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hlSWadO2jI0lmX/vuj3BAnPqCKtVKculqr9z4YSEzPc=;
	b=R5NhY23nRpqB1U0P6rUae2qfFR7xvtnMRFbxL/OtjaGrcCgPbyMdopLmdtINksFZyAm6LI
	l4BcREbtvMEdL/ps3fiLe7tEb6MQ9nenuNKsEPweg0sOLMM2nc4WifxMPxCRQ/wokT19HY
	YXTqKVP4fk4jhdDkJDLkimmzrc4KwJg=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-120-ETB5l5NBNEumY6YQGsDuIA-1; Thu, 08 Jan 2026 08:44:06 -0500
X-MC-Unique: ETB5l5NBNEumY6YQGsDuIA-1
X-Mimecast-MFC-AGG-ID: ETB5l5NBNEumY6YQGsDuIA_1767879845
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-430fd96b2f5so2307055f8f.3
        for <netdev@vger.kernel.org>; Thu, 08 Jan 2026 05:44:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1767879845; x=1768484645; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hlSWadO2jI0lmX/vuj3BAnPqCKtVKculqr9z4YSEzPc=;
        b=gjSaY0fLWZ31l5fNY0L2UKIG0m8kHy/9CRPXUpqiZI+a7ObPfLjGbMv4iO2zutu6cc
         /5sFADv1EZA3SrZkUGd/jFhGzTYAX4PvEGW3L3GuKLA7usMS8ksYq32cDds0gJ9rR/FD
         /oNJb0QUO3iCszND4cXShyodsTg/+PrR4jY9OauO+YFSRygO9GMWuA7OahUTy9joH5gF
         p3AF5ozb0A7jpR7qQhjND4EEf/mamAAyVveJaU1BS0NQN5RDX35MnxtBc1UWbWHM3W3g
         zxpyN679jtUvj3i0lf1FzFRFpXqVMOZi4DkSqZCObE9JV1NO/trW7fAqUAWPwMJUuuV5
         AGdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767879845; x=1768484645;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hlSWadO2jI0lmX/vuj3BAnPqCKtVKculqr9z4YSEzPc=;
        b=oVAm/H52n4nbtU/Au4feJRtlb10SQwDpI6qOxbZ5XRds2Iu6qlEMU7txmOIIgz1/V2
         l9wzQDGAI9V/zu1xHR87KErGDQtZscb8Dk0FwHz6ZNq82iJBQ5z4PnHmct1YNVVQn84N
         emHo009YMNffQBFhtppF4xXYrBMyNvg1LXMJiXNoeb8j7V6bCoo47YHCuoQ6L5BzARUm
         A7F6E0Jx56wFKkgJhC2ePcKZ30QDhx19+YHTspHA8mJzW39Dt89bdshr1PHPOJSOdHbI
         2YrSS9s1Bkok+UL75al4N8dWwdgKHkAHJlr/eKWW68MRaVeY5iSrKK180ZZOiTEcSQ55
         crvA==
X-Gm-Message-State: AOJu0YyfBF0oJvIS2j1Ay3tKXgsX+bAA/yZh0kHeNX+VdO5e0HvuEcfo
	OpRTDrK8LBPHLGrwIHcVBTVGv5kr1+GIeANdG1YiFpKxXG2TBx7QjopqcQbQJdOAdifPMSBzm2/
	FQ0s+JWh6aMSX3opLKeh9u7VMSX26nHqo60atDosX0tOrzBOYRMKtw0Q/Qg==
X-Gm-Gg: AY/fxX6s758iXYpk7hj3M/Spmciw5kyn+wyEZpZzyv/bEIyzh+z0FDWXYu5+eMU9IFl
	hDu5BZPbeqmtJ9aLtiL92pwOHM1H29wYMqBEE8L4gR3YegFut8UzKY115ZjU7aEvhvV+XEpmNNl
	totG61pmiodF0LM26QyPxRESXX9xlNeYxJfWt5/xWeT/RvVdadHSZG0Tx226hnIhRXP3QeU4ttA
	vlZlOzMgjl5vB8Wq/Zw3Fw1EUMQP6Awd95QU+a1ICR+HSCXEFDDAuAHWHPt6lWHukWzjnG4SfBP
	4fNupnu9klnGtwrTABMkXoCq+PkdIvZtkDcY+0KfPcEpzW4ePiTpr+BrT1cJLy8oMiUqITv+k74
	5RXCZSSAMgzErKmFQRQx578DI1ggX7DM97crpPcrGxc21vK5u/xun4Pe6J/qH25yxDu3R5Gu3iD
	iYy2BItwwYEv6Sfhqll7FtuWAccsxPVe1+dw==
X-Received: by 2002:a5d:6446:0:b0:432:7d2a:2be4 with SMTP id ffacd0b85a97d-432c38d2328mr6342124f8f.60.1767879844689;
        Thu, 08 Jan 2026 05:44:04 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFl2tuw64F2F3qleMCbnSHr1W5TRaUJUk+aNUMTqs4fa/lMXRhqPn1Ksrqhrn/8EXAt0IOA5A==
X-Received: by 2002:a5d:6446:0:b0:432:7d2a:2be4 with SMTP id ffacd0b85a97d-432c38d2328mr6342096f8f.60.1767879844190;
        Thu, 08 Jan 2026 05:44:04 -0800 (PST)
Received: from ?IPV6:2003:cc:9f4e:31f1:20:7a58:18f7:2e9b? (p200300cc9f4e31f100207a5818f72e9b.dip0.t-ipconnect.de. [2003:cc:9f4e:31f1:20:7a58:18f7:2e9b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-432bd0dad8bsm16943913f8f.8.2026.01.08.05.44.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Jan 2026 05:44:03 -0800 (PST)
Message-ID: <ad56f0fa-df33-45b8-aae5-7efac963ce2c@redhat.com>
Date: Thu, 8 Jan 2026 14:44:02 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC net 0/6] hsr: Implement more robust duplicate discard
 algorithm
To: Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, jkarrenpalo@gmail.com,
 tglx@linutronix.de, mingo@kernel.org, allison.henderson@oracle.com,
 matttbe@kernel.org, petrm@nvidia.com, bigeasy@linutronix.de
References: <cover.1766433800.git.fmaurer@redhat.com>
 <aV0chBkc20PCn-Is@horms.kernel.org>
Content-Language: en-US
From: Felix Maurer <fmaurer@redhat.com>
In-Reply-To: <aV0chBkc20PCn-Is@horms.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 06.01.26 15:30, Simon Horman wrote:
> On Mon, Dec 22, 2025 at 09:57:30PM +0100, Felix Maurer wrote:
>> The PRP duplicate discard algorithm does not work reliably with certain
>> link faults. Especially with packet loss on one link, the duplicate
>> discard algorithm drops valid packets. For a more thorough description
>> see patch 5.
>>
>> My suggestion is to replace the current, drop window-based algorithm
>> with a new one that tracks the received sequence numbers individually
>> (description again in patch 5). I am sending this as an RFC to gather
>> feedback mainly on two points:
>>
>> 1. Is the design generally acceptable? Of course, this change leads to
>>    higher memory usage and more work to do for each packet. But I argue
>>    that this is an acceptable trade-off to make for a more robust PRP
>>    behavior with faulty links. After all, PRP is to be used in
>>    environments where redundancy is needed and people are ready to
>>    maintain two duplicate networks to achieve it.
>> 2. As the tests added in patch 6 show, HSR is subject to similar
>>    problems. I do not see a reason not to use a very similar algorithm
>>    for HSR as well (with a bitmap for each port). Any objections to
>>    doing that (in a later patch series)? This will make the trade-off
>>    with memory usage more pronounced, as the hsr_seq_block will grow by
>>    three more bitmaps, at least for each HSR node (of which we do not
>>    expect too many, as an HSR ring can not be infinitely large).
> 
> Hi Felix,
> 
> Happy New Year!
> 
> We have spoken about this offline before and I agree that the situation
> should be improved.
> 
> IMHO the trade-offs you are making here seem reasonable.  And I wonder if
> it helps to think in terms of the expected usage of this code: Is it
> expected to scale to a point where the memory and CPU overhead becomes
> unreasonable; or do, as I think you imply above, we expect deployments to
> be on systems where the trade-offs are acceptable?

Happy new year to you as well!

As for the expected scale, there are two dimensions: the number of nodes
in the network and the data rate with which they send.

The number of nodes in the network affect the memory usage because each
node now has the block buffer. For PRP that's 64 blocks * 32 byte =
2kbyte for each node in the node table. A PRP network doesn't have an
explicit limit for the number of nodes. However, the whole network is a
single layer-2 segment which shouldn't grow too large anyways. Even if
one really tries to put 1000 nodes into the PRP network, the memory
overhead (2Mbyte) is acceptable in my opinion.

For HSR, the blocks would be larger because we need to track the
sequence numbers per port. I expect 64 blocks * 80 byte = 5kbyte per
node in the node table. There is no explicit limit for the size of an
HSR ring either. But I expect them to be of limited size because the
forwarding delays add up throughout the ring. I've seen vendors limiting
the ring size to 50 nodes with 100Mbit/s links and 300 with 1Gbit/s
links. In both cases I consider the memory overhead acceptable.

The data rates are harder to reason about. In general, the data rates
for HSR and PRP are limited because too high packet rates would lead to
very fast re-use of the 16bit sequence numbers. The IEC 62439-3:2021
mentions 100Mbit/s links and 1Gbit/s links. I don't expect HSR or PRP
networks to scale out to, e.g., 10Gbit/s links with the current
specification as this would mean that sequence numbers could repeat as
often as every ~4ms. The default constants in the IEC standard, which we
also use, are oriented at a 100Mbit/s network.

In my tests with veth pairs, the CPU overhead didn't lead to
significantly lower data rates. The main factor limiting the data rate
at the moment, I assume, is the per-node spinlock that is taken for each
received packet. IMHO, there is a lot more to gain in terms of CPU
overhead from making this lock smaller or getting rid of it, than we
loose with the more accurate duplicate discard algorithm in this patchset.

The CPU overhead of the algorithm benefits from the fact that in high
packet rate scenarios (where it really matters) many packets will have
sequence numbers in already initialized blocks. These packets just have
additionally: one xarray lookup, one comparison, and one bit setting. If
a block needs to be initialized (once every 128 packets plus their 128
duplicates if all sequence numbers are seen), we will have: one
xa_erase, a bunch of memory writes, and one xa_store.

In theory, all packets could end up in the slow path if a node sends
every 128th packet to us. If this is sent from a well behaving node, the
packet rate wouldn't be an issue anymore, though.

>> Most of the patches in this series are for the selftests. This is mainly
>> to demonstrate the problems with the current duplicate discard
>> algorithms, not so much about gathering feedback. Especially patch 1 and
>> 2 are rather preparatory cleanups that do not have much to do with the
>> actual problems the new algorithm tries to solve.
>>
>> A few points I know not yet addressed are:
>> - HSR duplicate discard (see above).
>> - The KUnit test is not updated for the new algorithm. I will work on
>>   that before actual patch submission.
> 
> FTR, the KUnit tests no longer compiles. But probably you already knew that.
> 
>> - Merging the sequence number blocks when two entries in the node table
>>   are merged because they belong to the same node.
>>
>> Thank you for your feedback already!
> 
> Some slightly more specific feedback:
> 
> * These patches are probably for net-next rather than net

They are, that was just a mistake when I sent them.

> * Please run checkpatch.pl --max-line-length=80 --codespell (on each patch)
>   - And fix the line lengths where it doesn't reduce readability.
>     E.g. don't split strings
> 
> * Please also run shellcheck on the selftests
>   - As much as is reasonable please address the warnings
>   - In general new .sh files should be shellcheck-clean
>   - To aid this, use "# shellcheck disable=CASE", for cases that don't match
>     the way selftests are written , e.g. SC2154 and SC2034
> 
> * I was curious to see LANG=C in at least one of the selftests.
>   And I do see limited precedence for that. I'm just mentioning
>   that I was surprised as I'd always thought it was an implied requirement.

Thanks for the feedback, I'll work on it for the next submission. The
LANG=C was in another hsr selftest, it can probably be removed. I agree
that probably a lot of selftests fail with any other LANG.

Thanks,
   Felix


