Return-Path: <netdev+bounces-230435-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E9496BE818E
	for <lists+netdev@lfdr.de>; Fri, 17 Oct 2025 12:40:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B433C4F8763
	for <lists+netdev@lfdr.de>; Fri, 17 Oct 2025 10:40:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AF053128B1;
	Fri, 17 Oct 2025 10:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="IrCwwfqA"
X-Original-To: netdev@vger.kernel.org
Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2C8E312830
	for <netdev@vger.kernel.org>; Fri, 17 Oct 2025 10:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760697615; cv=none; b=Qi85jcWXDqtZcuuiLnZsf0u1sPmxnOpfLDYoaB1JXR+gKlRGT4jNiArF9koxUOAIP+bqxn8woX5nrkPtNdkS7YqYwRDPH8ViW+2xlObXuNyW6AU+MQcjIdvqFwZgRHmD8qQXdFYG1J1zbB3DOdlcZcsV8y4vciDbxTaFCbyA3T0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760697615; c=relaxed/simple;
	bh=a+hvGxKx1Du6F+rVTvciS2Wx/2H8wYZ7X85wqZaoa1Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=L8A+J6yWDr1F5jFMguhVWrgJ+9WZAmGa+jMwByJ5zfRX6sCt05HIn1Xf/OyazG5u/BbeZp9X7m2R07l83AtZALm4SPosxaDdvsoWwFYh5plWJ2WPZPHGZCfD+/fESg8qSaXi3hgF6PigkUxhncP1Z9ZOqxm5YVQqaD4a+LIQB6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=IrCwwfqA; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <f1c42ecd-57c0-4cea-906e-aebcd583944a@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1760697610;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LFyQCMCCHGMPfi0FFUJoBlhmXM+s+mfhayyuqlJUZRM=;
	b=IrCwwfqATAnxjV3v6eo40dN7MQpExXvn4KpmsRLsj4P1yKbfRadQ5ZZbSPFqWT4GLdXB9K
	4/JcOwGtEoIoVkemQgx8voxN406BcWpa1zOAw0CN0IUfio6/J49iOyc9Ux9/WJqAUOQLga
	2lUVcYSkKR2mXdcjBUf5G+OVPRBCU+k=
Date: Fri, 17 Oct 2025 11:40:05 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next] bnxt_en: support PPS in/out on all pins
To: Pavan Chebbi <pavan.chebbi@broadcom.com>
Cc: Michael Chan <michael.chan@broadcom.com>, Jakub Kicinski
 <kuba@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Richard Cochran <richardcochran@gmail.com>,
 netdev@vger.kernel.org
References: <20251016222317.3512207-1-vadim.fedorenko@linux.dev>
 <CALs4sv2gcHTpGRhZOPQqd+JrNnL05xLFYWB3uaznNbcGt=x03A@mail.gmail.com>
 <20f633b9-8a49-4240-8cb8-00309081ab73@linux.dev>
 <CALs4sv0ehFVMMB2HPqUkGnv5iRW-VYKpeFf3QtRDgThVH=XQYQ@mail.gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <CALs4sv0ehFVMMB2HPqUkGnv5iRW-VYKpeFf3QtRDgThVH=XQYQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 17/10/2025 10:15, Pavan Chebbi wrote:
> On Fri, Oct 17, 2025 at 2:21 PM Vadim Fedorenko
> <vadim.fedorenko@linux.dev> wrote:
>>
>> On 17.10.2025 04:45, Pavan Chebbi wrote:
>>> On Fri, Oct 17, 2025 at 3:54 AM Vadim Fedorenko
>>> <vadim.fedorenko@linux.dev> wrote:
>>>>
>>>> n_ext_ts and n_per_out from ptp_clock_caps are checked as a max number
>>>> of pins rather than max number of active pins.
>>>
>>> I am not 100pc sure. How is n_pins going to be different then?
>>> https://elixir.bootlin.com/linux/v6.17/source/include/linux/ptp_clock_kernel.h#L69
>>
>> So in general it's more for the case where HW has pins connected through mux to
>> the DPLL channels. According to the bnxt_ptp_cfg_pin() bnxt HW has pins
>> hardwired to channels and NVM has pre-defined configuration of pins' functions.
>>
>> [host ~]# ./testptp -d /dev/ptp2 -l
>> name bnxt_pps0 index 0 func 0 chan 0
>> name bnxt_pps1 index 1 func 0 chan 1
>> name bnxt_pps2 index 2 func 0 chan 2
>> name bnxt_pps3 index 3 func 0 chan 3
>>
>> without the change user cannot configure EXTTS or PEROUT function on pins
>> 1-3 preserving channels 1-3 on them.
>>
>> The user can actually use channel 0 on every pin because bnxt driver doesn't
>> care about channels at all, but it's a bit confusing that it sets up different
>> channels during init phase.
> 
> You are right that we don't care about the channels. So I think
> ideally it should have been set to 0 for all the pins.
> Does that not make a better fix? Meaning to say, we don't care about
> the channel but/therefore please use 0 for all pins.
> What I am not sure about the proposed change in your patch is that it
> may be overriding the definition of the n_ext_ts and n_per_out in
> order to provide flexibility to users to change channels, no?

Well, yeah, the overriding exists, but that's mostly the artifact of not
so flexible API. But I agree, we can improve init part to make it clear.
But one more thing has just come to my mind - is it
really possible to configure PPS-in/PPS-out on pins 0-1?
AFAIU, there are functions assigned to each pin, which can only be
enabled or disabled by the user-space app, and in this case
bnxt_ptp_verify() should be improved to validate function per pin,
right?


