Return-Path: <netdev+bounces-131267-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AE61B98DECC
	for <lists+netdev@lfdr.de>; Wed,  2 Oct 2024 17:22:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E0A6F1C232E0
	for <lists+netdev@lfdr.de>; Wed,  2 Oct 2024 15:22:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50FDF1D094D;
	Wed,  2 Oct 2024 15:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="J+NJebXK";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="N2Cqtt72"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D40231D079C;
	Wed,  2 Oct 2024 15:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727882553; cv=none; b=YwdRiKtONhs1CIZ4OHxhv0jrjmbUbU29VKysQSwyqcWmSWz8yvonp/N7nDbRxnRO+LlS6Yu73oVr4NPunScxEt9FvfRxD3NrKLusAeJXfFsN+sJXMTauEVYNSAszqcL0CBpvru+43AHH252YS81NiO9BmtkmAcdUfSbHfdQWb3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727882553; c=relaxed/simple;
	bh=WclxE16WKEkLYnwHFA5dLg2fbQUaHKCODu+lWQvh6SA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=qQ7YUdGBnxKndxNrwlXWzo4It3TzYNowUp+wduJtQC1CTjfFu/1N57fcljs7KnTB5hS9KkIX6Q2FyZKavqdieQbq7KIs6RvagstB4dtkPB4a/0oXFCw0iYc053hCLsO9tMHmUOHi+UU0e9u8Q2ijEEX7qebd+1eU46lD7B8EqLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=J+NJebXK; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=N2Cqtt72; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1727882550;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mZfcKNflp5Ki1JmOrBWRUX/lZQcujVg4OfuBc/KOEH0=;
	b=J+NJebXKV+PtZQf2FxDCsoHl7EqM+QMaOcaD7AnwmtiqBivLL6vZixWMXZEGLa670AbP1z
	tkHNvptQCkoodBdV5lo1gHgPhxHo/tMCUF6dRNGmtWyMqWyABKLmU22PStFkfIvBwiDi0P
	3YNSTu8DCr3XeZSxYTf2WeE8dpCgxmcDgAC1evlf/KQcUaiUoVA4EHawnFXX7pN9Bqh50h
	EmeCXzPQFTG9ZPTYHqgsB2yculWSW7zODlfnD8/wjzKQh+gX2PeiWSd+dgJfVn83x6+oZ6
	5DBBPuSQgvFFhcJ3Gz/XDzsnZDH+WKl11J4xxqFHtPJHXP8yGdUAPf8gP2iw2A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1727882550;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mZfcKNflp5Ki1JmOrBWRUX/lZQcujVg4OfuBc/KOEH0=;
	b=N2Cqtt72kjdK3WVaeuvovr0/ALl8wAX5djgrQjqwgbYzOH4uttFs62bFf0s6M116ph/BaL
	O8/rVBJ11P0pQ/DQ==
To: Jinjie Ruan <ruanjinjie@huawei.com>, bryan.whitehead@microchip.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, anna-maria@linutronix.de, frederic@kernel.org,
 richardcochran@gmail.com, UNGLinuxDriver@microchip.com, mbenes@suse.cz,
 jstultz@google.com, andrew@lunn.ch, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: ruanjinjie@huawei.com
Subject: Re: [PATCH -next v4 1/2] posix-clock: Check timespec64 before call
 clock_settime()
In-Reply-To: <20240914100625.414013-2-ruanjinjie@huawei.com>
References: <20240914100625.414013-1-ruanjinjie@huawei.com>
 <20240914100625.414013-2-ruanjinjie@huawei.com>
Date: Wed, 02 Oct 2024 17:22:29 +0200
Message-ID: <87ldz6wmve.ffs@tglx>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Sat, Sep 14 2024 at 18:06, Jinjie Ruan wrote:
> As Andrew pointed out, it will make sense that the PTP core
> checked timespec64 struct's tv_sec and tv_nsec range before calling
> ptp->info->settime64().
>
> As the man mannul of clock_settime() said, if tp.tv_sec is negative or
> tp.tv_nsec is outside the range [0..999,999,999], it shuld return EINVAL,
> which include Dynamic clocks which handles PTP clock, and the condition is
> consistent with timespec64_valid(). So check it ahead using
> timespec64_valid() in pc_clock_settime() and return -EINVAL if not valid.
>
> There are some drivers that use tp->tv_sec and tp->tv_nsec directly to
> write registers without validity checks and assume that the higher layer
> has checked it, which is dangerous and will benefit from this, such as
> hclge_ptp_settime(), igb_ptp_settime_i210(), _rcar_gen4_ptp_settime(),
> and some drivers can remove the checks of itself.
  
> +	if (!timespec64_valid(ts))
> +		return -EINVAL;

This just makes sure, that the timespec is valid. But it does not ensure
that the time is in a valid range.

This should at least use timespec64_valid_strict() if not
timespec64_valid_gettod().

Thanks,

        tglx

