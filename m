Return-Path: <netdev+bounces-241524-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A05EC84F0E
	for <lists+netdev@lfdr.de>; Tue, 25 Nov 2025 13:19:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5B8484E16B8
	for <lists+netdev@lfdr.de>; Tue, 25 Nov 2025 12:19:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB7BF239E65;
	Tue, 25 Nov 2025 12:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toke.dk header.i=@toke.dk header.b="ddV770/P"
X-Original-To: netdev@vger.kernel.org
Received: from mail.toke.dk (mail.toke.dk [45.145.95.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8A461E49F
	for <netdev@vger.kernel.org>; Tue, 25 Nov 2025 12:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.145.95.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764073152; cv=none; b=Tjy0X2vGI9nPzIfX2VtyZtlazrfZ1N9JO2SoaqGFprjdni50fY2eGR7Cv/A23wfin/YVSiMphzWJO9VLTi3DEyA6cjq/Vos8/SJlN1fFdw591+oB1Szd7ei+sByX7v1aYtck1s/EDTNW9bned/EydQERd8tgeOfIS7JhWcNvAC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764073152; c=relaxed/simple;
	bh=BxJu4QGS4DNMjF5m5xPvxINTbKIPSihKmtj0x6mFxrY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=nxKO8qA+QA+cXVR3nHToDiNTIowk39SZtmqwzYCAi40HuMeIOwDQAN5FPdCDXc/0FfwLKkntfSiMf+InsCsjxnjcwR/qp0Sbe9zLy0cXFkdISmYkGDSTczu0a7MTM1acUDAuBh7imkQ1PK2jvrIHHXeHLgR7wXrsMNzKdOHDvJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=toke.dk; spf=pass smtp.mailfrom=toke.dk; dkim=pass (2048-bit key) header.d=toke.dk header.i=@toke.dk header.b=ddV770/P; arc=none smtp.client-ip=45.145.95.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=toke.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toke.dk
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=toke.dk; s=20161023;
	t=1764073136; bh=BxJu4QGS4DNMjF5m5xPvxINTbKIPSihKmtj0x6mFxrY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=ddV770/Pu6BvI9vPqrOrtD42U2ahxONPBicZH2+qXpTU+B7ahjeBtYv8l/Pk7YMs0
	 tYjh+r836hVUp3Na50SRcyxpfpKiQ4cIEVz7upz0EgkSiy2Zw74XbOBajqPWGGDUE3
	 3ubsiN+IOu7wJaYVtgf7Iv2M+vnSERN7RxoBHnAXckpGv/APJ4/WSH8JihxCaMqxms
	 DRWb+8YXcpKqgXfxrxfzNUYnKrdgcNN+xXsYoOgGRNwVZH1JL7QLIfVtHJT+O9rTwX
	 MOuaQdOixG+O3qJ0dTOGpmWTlUb7lUZzT4KSNrHBtPGRvJvSNjpxUt/TiBq5k8iAwT
	 XabPcckLKOLRA==
To: David Ahern <dsahern@gmail.com>, Stephen Hemminger
 <stephen@networkplumber.org>
Cc: cake@lists.bufferbloat.net, netdev@vger.kernel.org, Jonas =?utf-8?Q?K?=
 =?utf-8?Q?=C3=B6ppeler?=
 <j.koeppeler@tu-berlin.de>
Subject: Re: [PATCH iproute2-next] tc: cake: add cake_mq support
In-Reply-To: <fb5fc99e-fa3b-4499-80be-4731a8c7a297@gmail.com>
References: <20251124-mq-cake-sub-qdisc-v1-0-a2ff1dab488f@redhat.com>
 <20251124150350.492522-1-toke@redhat.com>
 <fb5fc99e-fa3b-4499-80be-4731a8c7a297@gmail.com>
Date: Tue, 25 Nov 2025 13:18:56 +0100
X-Clacks-Overhead: GNU Terry Pratchett
Message-ID: <87jyzecnkf.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

David Ahern <dsahern@gmail.com> writes:

> On 11/24/25 8:03 AM, Toke H=C3=B8iland-J=C3=B8rgensen wrote:
>> diff --git a/include/uapi/linux/pkt_sched.h b/include/uapi/linux/pkt_sch=
ed.h
>> index 15d1a37ac6d8..fb07a8898225 100644
>> --- a/include/uapi/linux/pkt_sched.h
>> +++ b/include/uapi/linux/pkt_sched.h
>> @@ -1036,6 +1036,7 @@ enum {
>>  	TCA_CAKE_STATS_DROP_NEXT_US,
>>  	TCA_CAKE_STATS_P_DROP,
>>  	TCA_CAKE_STATS_BLUE_TIMER_US,
>> +	TCA_CAKE_STATS_ACTIVE_QUEUES,
>>  	__TCA_CAKE_STATS_MAX
>>  };
>>  #define TCA_CAKE_STATS_MAX (__TCA_CAKE_STATS_MAX - 1)
>
> uapi changes should be a separate patch that I can drop when applying.

OK, sure.

>> diff --git a/tc/q_cake.c b/tc/q_cake.c
>> index e2b8de55e5a2..1c143e766888 100644
>> --- a/tc/q_cake.c
>> +++ b/tc/q_cake.c
>> @@ -525,7 +525,6 @@ static int cake_print_opt(const struct qdisc_util *q=
u, FILE *f, struct rtattr *o
>>  	    RTA_PAYLOAD(tb[TCA_CAKE_FWMARK]) >=3D sizeof(__u32)) {
>>  		fwmark =3D rta_getattr_u32(tb[TCA_CAKE_FWMARK]);
>>  	}
>> -
>>  	if (wash)
>>  		print_string(PRINT_FP, NULL, "wash ", NULL);
>>  	else
>
> why remove the spacing? whitespace helps readability.

That was a mistake that crept in when editing the patch; will put it
back :)

-Toke

