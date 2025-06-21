Return-Path: <netdev+bounces-200042-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C2E38AE2C61
	for <lists+netdev@lfdr.de>; Sat, 21 Jun 2025 22:44:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6787016F87D
	for <lists+netdev@lfdr.de>; Sat, 21 Jun 2025 20:44:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E75C2701D0;
	Sat, 21 Jun 2025 20:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="TcFf+daJ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Jem5puHm"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2A581F5E6;
	Sat, 21 Jun 2025 20:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750538671; cv=none; b=pTgZaP5ZO0YM5qro5G7EKrPWyFNP2knR1z/6APFf6RQup+sj1jhueb0Q8xLz5VemOmMQLPqxa7opZrD0QErs0gKnVPRhBeypAX6oO6iPpovoYQuAAtKHEQVtGiO5zyoW7t5cmzKJeH9y6m+NEJtAVH9AO6IqA8bf8q1Y6SZKuIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750538671; c=relaxed/simple;
	bh=P89KZvCJZCwzhvtoknxL77RvxV6jVy7/qA7INZizj3Y=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=J3YoK36DQ3MUVAExyefj7VOD3SBwxUtRfD/0FJzrMWW7pR4O8nzgNJndU40cz557EA9DMCWQXh8OFD3CUPkGaZvrLFAGLNtTrSQ8Q7CNX6+c34cV1HOx5cRvI06j/I9dTK62VpiPqiZZcmvlxsfa4PhmhBtoYJw/lUeRW5X5668=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=TcFf+daJ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Jem5puHm; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1750538667;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ngcP24uDNqaeTF7ZEpDIvhpdOdD9ObmW7Xhx1/y8BFI=;
	b=TcFf+daJZQH0kPs201twgopdn3C3XKuKviz/BE5aZNxsGyw0EXX3KGMrHtnzQB0z+47Hde
	Cs2SBQID1vc1Udrix2pX1NW0AsofJ7hPAv+uCWTOmTap72yauJoEUrZoGJ/dNkQzqSS3rR
	ED6fl6yhEqx71uW0PQC/npjNb6jcepNJB1WK4HU0KOBCVjeEkV7jVcsED4Mer97MGwMIbY
	OqbPT1/Z0vibdu5bGZBBLfV3HELs1is/ZgiSnxwKWuKj2fOuKykUgLYXpwmDefgKZXmswA
	qt9M9SeGikB9goW4f/LcgggbIiQoJyilvZyd1eGwfvgKf7vBxxDWHpH6mml8zQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1750538667;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ngcP24uDNqaeTF7ZEpDIvhpdOdD9ObmW7Xhx1/y8BFI=;
	b=Jem5puHmK29iF20Nh/aabkqakF/Gnrni4T4JUoyGc3JuRBa83mrXhixr1ZjS1CGhCV3Gp9
	D4XgZZXx7PyX+OAQ==
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>, LKML
 <linux-kernel@vger.kernel.org>
Cc: Richard Cochran <richardcochran@gmail.com>, netdev@vger.kernel.org
Subject: Re: [patch 10/13] ptp: Split out PTP_MASK_CLEAR_ALL ioctl code
In-Reply-To: <80052862-683c-4a53-b7a2-8d767a057022@linux.dev>
References: <20250620130144.351492917@linutronix.de>
 <20250620131944.344887489@linutronix.de>
 <80052862-683c-4a53-b7a2-8d767a057022@linux.dev>
Date: Sat, 21 Jun 2025 22:44:27 +0200
Message-ID: <877c14q0yc.ffs@tglx>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Sat, Jun 21 2025 at 21:36, Vadim Fedorenko wrote:
> On 20/06/2025 14:24, Thomas Gleixner wrote:
>> Continue the ptp_ioctl() cleanup by splitting out the PTP_MASK_CLEAR_ALL ioctl
>> code into a helper function.
>>   	case PTP_MASK_CLEAR_ALL:
>> -		bitmap_clear(tsevq->mask, 0, PTP_MAX_CHANNELS);
>> -		break;
>> +		return ptp_mask_clear_all(pccontext->private_clkdata);
>>   
>>   	case PTP_MASK_EN_SINGLE:
>>   		if (copy_from_user(&i, (void __user *)arg, sizeof(i))) {
>> 
>
> Not quite sure there is a benefit of having a function for this type,
> apart from having one style. But it adds some LoC...

Sure it's debatable benefit, but it makes the code more consistent and
does not introduce this oddball in the middle of the other function
calls.

Thanks,

        tglx

