Return-Path: <netdev+bounces-135901-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F08999FB77
	for <lists+netdev@lfdr.de>; Wed, 16 Oct 2024 00:33:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E946CB219D4
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 22:33:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C815D21E3D8;
	Tue, 15 Oct 2024 22:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="sNV4hazi";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="nkVO2kyD"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A38D21E3A4;
	Tue, 15 Oct 2024 22:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729031586; cv=none; b=YE90So/M6pS9PZBU/fQlCALjHkxiH4hBKPfjtekIwI6g3FFtf4IyCZ1o2WEeJTIWLUQ0h1bnWH1ZW+q/lyHoVQh2egglv2ly47vP2bgFBZlJWO4dcJpO5eB5MzTpATWMrvukaR64Q0VC8uvhWObXOo7UFY4npwVaXA15HxakNMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729031586; c=relaxed/simple;
	bh=21aizJ5YYhhn9K5puew1ayyZTyLTfBXxhZOksdxbccs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=hMemEk+xdhPQc/TCwcJrAobHpyseLEMqHk/mpkizkDXbRVYhNmpQ2SbKsRTTAAK0D8D3J1BdyeGoP6aoItbYeaQq3roW5LaBhf4AC3LNJvhjmnalzrtDDge9O0PDbKAGAN95FhjsyGLRVymhloXkem2VQ05q+z1Rzouqrhbxdt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=sNV4hazi; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=nkVO2kyD; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1729031583;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nCsw8WsG67bUmKOynRzbJkIDd3tvleEozUUHLnGNguo=;
	b=sNV4hazio0R3LDNriyoTWB8Yh3xrhahtVegCJBJOJBCNfYNM6YKbvkM6m3BYTNFVEIy0Lb
	yTQCcegKephX5hh41MqPn4PXYnNYT3vk9nKu1vBrDoK8QwFbtCfCTfaWteMFh5cHI8QjuJ
	jj1mOP00F+mb7/DAgL7v+UPm9A1RBhrMcWu2RePbtGWKE7DwwSKNiF/jbdeYRTkPTmuGXf
	Y0lmv/fiD7V6eEBTPZn3MTDOq7tSbNR7F5cu2eLvvOBGUZRkurfRyVH0Mvz7ctGVesGZ6b
	s6hIiM1NZqgvIkVvVpvYMqtwHtrp/WbHtfbm3qo5V1VMBjJnx64JQDENYzR63A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1729031583;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nCsw8WsG67bUmKOynRzbJkIDd3tvleEozUUHLnGNguo=;
	b=nkVO2kyDZZveTRPEgvcljraHcB33uLVieWywE5nDUQNflPqW1QA+rIEgfuFyoIKV1jq6TA
	EumwgzDAmEEucGAQ==
To: Jakub Kicinski <kuba@kernel.org>, Jinjie Ruan <ruanjinjie@huawei.com>
Cc: bryan.whitehead@microchip.com, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, anna-maria@linutronix.de, frederic@kernel.org,
 richardcochran@gmail.com, johnstul@us.ibm.com,
 UNGLinuxDriver@microchip.com, jstultz@google.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 RESEND 1/2] posix-clock: Fix missing timespec64 check
 in pc_clock_settime()
In-Reply-To: <20241011125726.62c5dde7@kernel.org>
References: <20241009072302.1754567-1-ruanjinjie@huawei.com>
 <20241009072302.1754567-2-ruanjinjie@huawei.com>
 <20241011125726.62c5dde7@kernel.org>
Date: Wed, 16 Oct 2024 00:33:02 +0200
Message-ID: <87v7xtc7z5.ffs@tglx>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Fri, Oct 11 2024 at 12:57, Jakub Kicinski wrote:
> On Wed, 9 Oct 2024 15:23:01 +0800 Jinjie Ruan wrote:
>> As Andrew pointed out, it will make sense that the PTP core
>> checked timespec64 struct's tv_sec and tv_nsec range before calling
>> ptp->info->settime64().
>> 
>> As the man manual of clock_settime() said, if tp.tv_sec is negative or
>> tp.tv_nsec is outside the range [0..999,999,999], it should return EINVAL,
>> which include dynamic clocks which handles PTP clock, and the condition is
>> consistent with timespec64_valid(). As Thomas suggested, timespec64_valid()
>> only check the timespec is valid, but not ensure that the time is
>> in a valid range, so check it ahead using timespec64_valid_strict()
>> in pc_clock_settime() and return -EINVAL if not valid.
>> 
>> There are some drivers that use tp->tv_sec and tp->tv_nsec directly to
>> write registers without validity checks and assume that the higher layer
>> has checked it, which is dangerous and will benefit from this, such as
>> hclge_ptp_settime(), igb_ptp_settime_i210(), _rcar_gen4_ptp_settime(),
>> and some drivers can remove the checks of itself.
>
> I'm guessing we can push this into 6.12-rc and the other patch into
> net-next. I'll toss it into net on Monday unless someone objects.

Can you folks please at least wait until the maintainers of the code in
question had a look ?

Thanks,

        tglx

