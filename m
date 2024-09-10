Return-Path: <netdev+bounces-126966-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 17FC79736CA
	for <lists+netdev@lfdr.de>; Tue, 10 Sep 2024 14:05:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B71591F27CED
	for <lists+netdev@lfdr.de>; Tue, 10 Sep 2024 12:05:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15DC518DF8C;
	Tue, 10 Sep 2024 12:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="sMTGcJR3";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="iM2XFtId"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 898EC18E76F;
	Tue, 10 Sep 2024 12:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725969909; cv=none; b=UjvtmQ1tFg9jeJixM+Ya3oSm+JPrmcqd17DvPoKFpsyoutS+3/oRN74aB7BLrVGQdkoE1yMnSzzEQBWybKIqynktLGdxS667C9OX7keP0i16tPuxyQDjVKNEIZkVT8A8S6USY7BaLxQHlOuHqXPcivnku+uisdc04Sx202APc1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725969909; c=relaxed/simple;
	bh=fYiFsOP+Yx5RIAobm5TDbMdRmxNxoSv0KkVG19LWf88=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=atmdcRk39c1qfDomFtOuzQsOOISQC7OMkc575MIa1aQLKKINTwJNSrnuc+P0oFOj8FI20Uvq5N3s51LdYCvwpnvCgRx1vgm2audLx4z+WCSSAtJXkYHYNOCA/wW63rHRr6w74hofFjsbw7q4yh25Ax+EIVYcTXqjOGMSDrECH0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=sMTGcJR3; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=iM2XFtId; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1725969905;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YFu8BsT7eS6/kBUw8UpNUrw6HVjRkUax9lR4Q/qhmwk=;
	b=sMTGcJR3gL5MH2s2JFreZIoR0XiBdBs2qx+TpzqNvEIXDxs2PZ+xLcRCMk+KlnzBl98Ytd
	jmc++uewE+EqLvDdHAf4ALsTVIFUr5PHC1TSLiXFmSHpej+XkU+el08uMK6DLt/CV/umPl
	Gjz3rwxhG+eJC5E2i/hYcMQKJYC2xefQIlQX/D+kipmItdNXCiQO1c+I/oZGu102UfejE6
	2IFlOndzEqOG8Oo+WUX6oAfKJYWhExOuVjkksVcUwDvN1Zh8vXtwbuIB2XvuSgpbuKadEb
	abZdoXuFW4MjHl/64TD6RiOflzELsItWj0g4QC82YCb+tN7GkF5rzuf4KQplmg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1725969905;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YFu8BsT7eS6/kBUw8UpNUrw6HVjRkUax9lR4Q/qhmwk=;
	b=iM2XFtIdf+qPSQ+xUhWFPXG+NofroSb6EO9//IuvWpWfJzF6xCxazM8Zsqft11zMx3pnHt
	t18gmTFeiPDy5rBg==
To: Jinjie Ruan <ruanjinjie@huawei.com>, Richard Cochran
 <richardcochran@gmail.com>
Cc: bryan.whitehead@microchip.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, anna-maria@linutronix.de,
 frederic@kernel.org, UNGLinuxDriver@microchip.com, mbenes@suse.cz,
 jstultz@google.com, andrew@lunn.ch, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next v3 1/2] posix-timers: Check timespec64 before call
 clock_set()
In-Reply-To: <f2c219c8-0765-6942-8495-b5acf3756fb1@huawei.com>
References: <20240909074124.964907-1-ruanjinjie@huawei.com>
 <20240909074124.964907-2-ruanjinjie@huawei.com>
 <Zt8SFUpFp7JDkNbM@hoboy.vegasvil.org>
 <f2c219c8-0765-6942-8495-b5acf3756fb1@huawei.com>
Date: Tue, 10 Sep 2024 14:05:05 +0200
Message-ID: <875xr3btou.ffs@tglx>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, Sep 10 2024 at 19:23, Jinjie Ruan wrote:
> On 2024/9/9 23:19, Richard Cochran wrote:
>> On Mon, Sep 09, 2024 at 03:41:23PM +0800, Jinjie Ruan wrote:
>>> diff --git a/kernel/time/posix-timers.c b/kernel/time/posix-timers.c
>>> index 1cc830ef93a7..34deec619e17 100644
>>> --- a/kernel/time/posix-timers.c
>>> +++ b/kernel/time/posix-timers.c
>>> @@ -1137,6 +1137,9 @@ SYSCALL_DEFINE2(clock_settime, const clockid_t, which_clock,
>>>  	if (get_timespec64(&new_tp, tp))
>>>  		return -EFAULT;
>>>  
>>> +	if (!timespec64_valid(&new_tp))
>>> +		return -ERANGE;
>> 
>> Why not use timespec64_valid_settod()?
>
> It seems more limited and is only used in timekeeping or
> do_sys_settimeofday64().

For a very good reason.

> And the timespec64_valid() is looser and wider used, which I think is
> more appropriate here.

Can you please stop this handwaving and provide proper technical
arguments?

Why would PTP have less strict requirements than settimeofday()?

Thanks,

        tglx



