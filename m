Return-Path: <netdev+bounces-123614-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68E81965A7F
	for <lists+netdev@lfdr.de>; Fri, 30 Aug 2024 10:37:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 22E38287081
	for <lists+netdev@lfdr.de>; Fri, 30 Aug 2024 08:37:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D85D1170A19;
	Fri, 30 Aug 2024 08:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kob7DTOh"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1420170A00;
	Fri, 30 Aug 2024 08:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725007007; cv=none; b=BQ7LiHy7qKgHIvCmUY2GN5u+wtuykSGE4jxZiQQP3jg+3Dktunpmbi0DfDwvR+iBKu2MlkFF2N5zUnCqp5NBF0I9dJA/n6nTmiNtbQErQjxOV0bLyywD0RzkpamgD2XJgihlorG76hgQwD0UAvwzT0AO7FMAJR7LJB7P2bkbLL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725007007; c=relaxed/simple;
	bh=1a2JOCmMwUGJNO60kmTzz/sqotfRqeia2mSRSozIqcM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LSen+msqi3RxZYcu5QZ38iJa9/gUriVTEMIu1mJTrT2/WA5UT3hlZ9rMTljGCSBQafnE4nA3iFJSbRjxEgQ3vSy7JE0i62Fgp2daBu2LwuANT5mFMfwb29/DFsI0VcSIyZA3eMiNjgz2yGTcEOMNOJFwBn9GeO3W9pn6lfLDBuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kob7DTOh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18672C4CEC2;
	Fri, 30 Aug 2024 08:36:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725007007;
	bh=1a2JOCmMwUGJNO60kmTzz/sqotfRqeia2mSRSozIqcM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kob7DTOhbqsAaSjdfwGZvf6ryZb6RlAdR/z5yrlQ6I+NLuRHGGZIrrP3/0LDjG6BA
	 s9Z6dvtw9amMJD0PIVt2Ir9Ebacx6jnwD3PT/OQwNqfR9F5b7AWD3KQGKUWUingNSc
	 OZyCpU976P3wr5e1K3XKhM/uvjb3zLKdKprp6jwNwUdkC6H22+qsbRxxZ8Wox8JkKR
	 k3NEUdPzoXew3cT+z27xek1cnHo4Tfb8FWt7bSRe6ybnN0UpD3JPaXP27mqGzbj+h1
	 6EQxvq9TjTDtlAEQWmIkrghHn+Rxk7y/IwOBoIEHaMYKa2mwHDIPG2FSmrKcb6Kudk
	 sH+gfj7LSMPnA==
Date: Fri, 30 Aug 2024 09:36:41 +0100
From: Simon Horman <horms@kernel.org>
To: Joe Damato <jdamato@fastly.com>
Cc: netdev@vger.kernel.org, edumazet@google.com, amritha.nambiar@intel.com,
	sridhar.samudrala@intel.com, sdf@fomichev.me, bjorn@rivosinc.com,
	hch@infradead.org, willy@infradead.org,
	willemdebruijn.kernel@gmail.com, skhawaja@google.com,
	kuba@kernel.org, Martin Karsten <mkarsten@uwaterloo.ca>,
	"David S. Miller" <davem@davemloft.net>,
	Paolo Abeni <pabeni@redhat.com>, Jiri Pirko <jiri@resnulli.us>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Breno Leitao <leitao@debian.org>,
	Johannes Berg <johannes.berg@intel.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next 1/5] net: napi: Make napi_defer_hard_irqs
 per-NAPI
Message-ID: <20240830083641.GI1368797@kernel.org>
References: <20240829131214.169977-1-jdamato@fastly.com>
 <20240829131214.169977-2-jdamato@fastly.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240829131214.169977-2-jdamato@fastly.com>

On Thu, Aug 29, 2024 at 01:11:57PM +0000, Joe Damato wrote:
> Allow per-NAPI defer_hard_irqs setting.
> 
> The existing sysfs parameter is respected; writes to sysfs will write to
> all NAPI structs for the device and the net_device defer_hard_irq field.
> Reads from sysfs will read from the net_device field.
> 
> sysfs code was updated to guard against what appears to be a potential
> overflow as the field is an int, but the value passed in is an unsigned
> long.
> 
> The ability to set defer_hard_irqs on specific NAPI instances will be
> added in a later commit, via netdev-genl.
> 
> Signed-off-by: Joe Damato <jdamato@fastly.com>
> Reviewed-by: Martin Karsten <mkarsten@uwaterloo.ca>
> Tested-by: Martin Karsten <mkarsten@uwaterloo.ca>
> ---
>  include/linux/netdevice.h | 23 +++++++++++++++++++++++
>  net/core/dev.c            | 29 ++++++++++++++++++++++++++---
>  net/core/net-sysfs.c      |  5 ++++-
>  3 files changed, 53 insertions(+), 4 deletions(-)

...

> @@ -534,6 +535,28 @@ static inline void napi_schedule_irqoff(struct napi_struct *n)
>  		__napi_schedule_irqoff(n);
>  }
>  
> +/**
> + * napi_get_defer_hard_irqs - get the NAPI's defer_hard_irqs
> + * @n: napi struct to get the defer_hard_irqs field from
> + *
> + * Returns the per-NAPI value of the defar_hard_irqs field.
> + */
> +int napi_get_defer_hard_irqs(const struct napi_struct *n);

Hi Joe,

As it looks like there will be a v2 anyway, a minor nit from my side.

Thanks for documenting the return value, but I believe that
./scripts/kernel-doc -none -Wall expects "Return: " or "Returns: "

Likewise in patch 3/5.

...

