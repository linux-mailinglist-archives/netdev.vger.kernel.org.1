Return-Path: <netdev+bounces-200640-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D9EB0AE66B8
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 15:39:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 42B2518997CE
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 13:39:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 224912BFC7C;
	Tue, 24 Jun 2025 13:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="uZsDMoHM";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="IyPkjMKz"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A8941A2630;
	Tue, 24 Jun 2025 13:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750772362; cv=none; b=A+3z4X88L+0S2IwEhMw/d72WTA/1fW9FxBQYRuJaIxQNudVnJ0Zz6UScuOTnCArXEsmk0iGS1r1lf5+QAicnfLDbhr66XtkyaR4CeH6ZxtoYMC5AkWWtFN22kGg183NNuj1cJGYZgI9oAXCdvjAryanxtJ71RY60+4/BFTmQRh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750772362; c=relaxed/simple;
	bh=lZb/IHd26DlUQs3jSQ3nH8Cd91SGvgfm/EgMMhM+hh4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=K7TL6xL99e8SHmeodAxHTXtk48vkbeGy4FLQCzFWpT9pnyzS1JqhTon+sKVUq9av8xmEsHhBfT8ldC5xBUa2o2u5VXK5LTmF3RFmvNuU1/PDjQC/nqRKdps23KEHxiEtLe4IIsbxi1RNIAwfcDvLy8QRNp7fqsLl++1LFLMtcIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=uZsDMoHM; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=IyPkjMKz; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1750772355;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=49Y8TwdMNm7b6UQC5sRLMXc9hP1GhIKiDJExsmdPFAI=;
	b=uZsDMoHMY6aRAchotJEu+PPn0o33QgJf1Y7oOMnaGXRmPT3imdETGoTHC0QCu2IUXSGcQU
	nxscl3Pn8huwlnxvMtnDdtzNjjuD00+2BhFsxXCXfQw07eFvJg/Q9748M/4kcUU1l058NV
	dXEDZdPWkiaO7RAead/Ek12eguFow3J8f23Qt3JuCmBuX/ce3DOBihu6M+sKczXUlfkiTq
	P8DHJTayJfQvWF8QCaL6P3eKbF/CKDXAiE7bfNi/QrxdU2iw2QLcTfbla86K9MjFMQJjEZ
	Y8oULOLVzgzMRSrfFQEnTmUK8YRPCHBf16BYQ8hOw+9kVrODhiFLTPaPdRpMqQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1750772355;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=49Y8TwdMNm7b6UQC5sRLMXc9hP1GhIKiDJExsmdPFAI=;
	b=IyPkjMKzA6YoRQAOB8ZBnR0QR3riuF6wKcPeUh5/azq6Uj7sLZ7/NUblhx8b343FKKVSU9
	A8ZfPtyKZT+k1jCA==
To: Paolo Abeni <pabeni@redhat.com>, LKML <linux-kernel@vger.kernel.org>
Cc: Richard Cochran <richardcochran@gmail.com>, netdev@vger.kernel.org
Subject: Re: [patch 08/13] ptp: Split out PTP_PIN_GETFUNC ioctl code
In-Reply-To: <caef5686-961d-43aa-8141-c9c90ada2307@redhat.com>
References: <20250620130144.351492917@linutronix.de>
 <20250620131944.218487429@linutronix.de>
 <caef5686-961d-43aa-8141-c9c90ada2307@redhat.com>
Date: Tue, 24 Jun 2025 15:39:14 +0200
Message-ID: <87zfdxmf7h.ffs@tglx>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, Jun 24 2025 at 11:22, Paolo Abeni wrote:
> On 6/20/25 3:24 PM, Thomas Gleixner wrote:
>> Continue the ptp_ioctl() cleanup by splitting out the PTP_PIN_GETFUNC ioctl
>> code into a helper function. Convert to lock guard while at it.
>> 
>> No functional change intended.
>> 
>> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
>> ---
>>  drivers/ptp/ptp_chardev.c |   52 ++++++++++++++++++++--------------------------
>>  1 file changed, 23 insertions(+), 29 deletions(-)
>> 
>> --- a/drivers/ptp/ptp_chardev.c
>> +++ b/drivers/ptp/ptp_chardev.c
>> @@ -396,6 +396,28 @@ static long ptp_sys_offset(struct ptp_cl
>>  	return copy_to_user(arg, sysoff, sizeof(*sysoff)) ? -EFAULT : 0;
>>  }
>>  
>> +static long ptp_pin_getfunc(struct ptp_clock *ptp, unsigned int cmd, void __user *arg)
>> +{
>> +	struct ptp_clock_info *ops = ptp->info;
>> +	struct ptp_pin_desc pd;
>> +
>> +	if (copy_from_user(&pd, arg, sizeof(pd)))
>> +		return -EFAULT;
>> +
>> +	if (cmd == PTP_PIN_GETFUNC2 && !mem_is_zero(pd.rsv, sizeof(pd.rsv)))
>> +		return -EINVAL;
>> +	else
>> +		memset(pd.rsv, 0, sizeof(pd.rsv));
>
> Minor nit: I personally find the 'else' statement after return
> counter-intuitive and dropping it would save an additional LoC.

Of course ...

