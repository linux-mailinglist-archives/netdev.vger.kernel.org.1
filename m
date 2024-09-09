Return-Path: <netdev+bounces-126568-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30EBB971DEB
	for <lists+netdev@lfdr.de>; Mon,  9 Sep 2024 17:20:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DCC19284C1C
	for <lists+netdev@lfdr.de>; Mon,  9 Sep 2024 15:20:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3E0258ABF;
	Mon,  9 Sep 2024 15:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gYDZdc6j"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92F9C6F06B;
	Mon,  9 Sep 2024 15:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725895194; cv=none; b=OOR5hywUVdl7+YnNmSzszmWBMf44PYLniO1Du4fY+qoTA7ZQY48HYvbdVPupaXajXPvgtIs2zc1pfyS21244N6BkdgxpphJEkYbY4m8I15Ssy1M4H4FUk1e6zDbgDY8IM50PxaOgfeHoe3qIw9TdFRmK9+5wdAQJ9vG5467nfwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725895194; c=relaxed/simple;
	bh=wABUbDTc2MWy53eJpIlN7ApcrhCgZe5xlQSeqQ9ZzvI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hGT3W83Od69MblIeZ1bVqiVOYyUoa7QShFh1LBdRJO0L2ysiyWqnWLUpbzFTuqhBGM1tunQZrT+fgQlfeg4UsQS2kTkZ1c3XuTs6pQNT2kEgGm/FgCfgYMKqsu/hNmOdELprb5LEuMoATe5KljPsHgvorCbESYL8zMsdS5nvdXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gYDZdc6j; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-718d6ad6050so2358879b3a.0;
        Mon, 09 Sep 2024 08:19:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725895193; x=1726499993; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hMRHJ/EQJhBcNBFS9E0uE3m50xBNSRBU68KCDDA/iVk=;
        b=gYDZdc6jrSDcev8YaM0ufYLMaz0IegZUAgvcbi+dQQ1dCnZRJYW5EhyC3UrqXXDYS/
         fuo1d9UlIphT485oJoxuakHpIRjx4VL9QE1pc95zkusIOZGuU5SrNm1w+RwYLjYxFsVw
         U0okb+J/TAVYqsi+4jZmJyhrhZazWrGn1CZANMjIrqGYmGf8gjLSN2M7bUUVlGBKls47
         YFZ1mYP6gNb5n+1lxR/ILl4B8OWdUWor8vVu6up0foQi3z3LnyG2+8WhMOL+VSsbL/th
         y2PMd+3CqS2fyGBl408hyLZJR68gnPAv3RK47JjS9Ghk/Y0OHAc1iakX9YHR/8+ajBZD
         mTUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725895193; x=1726499993;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hMRHJ/EQJhBcNBFS9E0uE3m50xBNSRBU68KCDDA/iVk=;
        b=GMM67sVGpt6Mz8oXiIO2h5DaBRE9q9ljgyTwirrVPuPo1fAyavWIglL/BiiIuSDgHZ
         pYRdgAs9LMcNeuVVjSAWIoeV/8zFx9vudWr9Q03iUbGGCQM/F++5bCJ5Hw6mrBSXFUFE
         wWJVnQWVXeYU7hXubnEB5ni69DhUYOyUm9xvBxxj6Ou3AL9uw//HcphRXDh/C8nwXKdN
         MhmuyBYGI0V/wiPjOJAXxWfBss50CG2UpXSlFjqOn5kCvolpJ5sUGcNoiJ1GlvN8aN33
         nDDiHFQozxdjERlrhSh/KZ3vrDBIHJwl8Nn/zc29M0BnFSl+sPenpW0hztgYP0hMwIee
         Z/vg==
X-Forwarded-Encrypted: i=1; AJvYcCUK/iT3TeoYgcWVD34BUEqRyOxVcpUG6scOIN4sp85geAlQbq/jiszJL6LAZoxsZjXW+iTGR8Hb@vger.kernel.org, AJvYcCW+0vBV9dlyyMbfZNY2ImrErUd6qK8qxckERzcqolZQDbO5C95PjiyTEMSe+oOX8S58wtrbXD2/K2srG1U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1X2PydOv67FsvLrH7gEsTqrFRPUM+d2V0ZDX0H+H4SHb4nYXJ
	e2AL3xx+Eat7jjWfy4AJWljRlw253UL97wF4Ecx9VwmmWW5XpJ+I
X-Google-Smtp-Source: AGHT+IEpEXAjeGiJ3L5m8L2KBdzu8E8AbPcUrNqQOEC+jo8zhu1+5lNoXpb5O6bHJtdihw17c6is/A==
X-Received: by 2002:a05:6a20:c89b:b0:1cf:2901:2506 with SMTP id adf61e73a8af0-1cf29012546mr10771675637.14.1725895192747;
        Mon, 09 Sep 2024 08:19:52 -0700 (PDT)
Received: from hoboy.vegasvil.org ([2600:1700:2430:6f6f:e2d5:5eff:fea5:802f])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-718e5982ed0sm3772079b3a.148.2024.09.09.08.19.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2024 08:19:52 -0700 (PDT)
Date: Mon, 9 Sep 2024 08:19:49 -0700
From: Richard Cochran <richardcochran@gmail.com>
To: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: bryan.whitehead@microchip.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, anna-maria@linutronix.de,
	frederic@kernel.org, tglx@linutronix.de,
	UNGLinuxDriver@microchip.com, mbenes@suse.cz, jstultz@google.com,
	andrew@lunn.ch, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next v3 1/2] posix-timers: Check timespec64 before call
 clock_set()
Message-ID: <Zt8SFUpFp7JDkNbM@hoboy.vegasvil.org>
References: <20240909074124.964907-1-ruanjinjie@huawei.com>
 <20240909074124.964907-2-ruanjinjie@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240909074124.964907-2-ruanjinjie@huawei.com>

On Mon, Sep 09, 2024 at 03:41:23PM +0800, Jinjie Ruan wrote:
> diff --git a/kernel/time/posix-timers.c b/kernel/time/posix-timers.c
> index 1cc830ef93a7..34deec619e17 100644
> --- a/kernel/time/posix-timers.c
> +++ b/kernel/time/posix-timers.c
> @@ -1137,6 +1137,9 @@ SYSCALL_DEFINE2(clock_settime, const clockid_t, which_clock,
>  	if (get_timespec64(&new_tp, tp))
>  		return -EFAULT;
>  
> +	if (!timespec64_valid(&new_tp))
> +		return -ERANGE;

Why not use timespec64_valid_settod()?

Thanks,
Richard

