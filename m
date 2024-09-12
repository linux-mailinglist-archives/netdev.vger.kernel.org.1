Return-Path: <netdev+bounces-127795-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DC31976896
	for <lists+netdev@lfdr.de>; Thu, 12 Sep 2024 14:05:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 502701C23422
	for <lists+netdev@lfdr.de>; Thu, 12 Sep 2024 12:05:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 626A71A0BDD;
	Thu, 12 Sep 2024 12:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="hxkWB3D2";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0KjfqOQ7"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A05CB18E043;
	Thu, 12 Sep 2024 12:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726142700; cv=none; b=Iw283SwBTkDmEjdMVtl1yXVCCP6c1xo9DRZGkEcEgLulUTFapfBlc1zSanHbvQS+xYlmKobWKcM5EAc/T3UJQJKy94yxB3onBAj83HLyeetbPTvLB5G6k8OyadpkvTRFGURMIaN2uZYxawh6nc31u+uj9kmz5nij9+OGdEmAvLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726142700; c=relaxed/simple;
	bh=6ElcBIC1Y6mHAxXIoF87OEMWWuDZBtobn02T4HnDMxg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=KrE3/HfVPBmLC+gaANLqcQ26mrN1AV/qDaD8UNqlUj/bCbEkihJWCmAJMxRYSpI9wdERv0HUltMC2hPgVADkTJCceFFcRBCGK+rKSnYFE25VMA1LmloN/ejCRi3i4oORHjwbb/MIGq/N//VsnhG85F0xwq4ke3Pvr2HsNI8n9m0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=hxkWB3D2; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0KjfqOQ7; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1726142696;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WLNJKXffC/1phJTPsnafjkuYY3WKkcoBWZ0khVj1ZB0=;
	b=hxkWB3D2zLwUGMX2nBNuyHLr9iWimli81ahfEisFMAjSrd8i0UIvly55mCxwQzV29bJwa3
	ldhTs72yUVH+e9Ou6pdvKs2oUBOVBUV/1Ly0ohZuA+KbVULH3aqDKoP5Bdxqngo3qbZK+h
	X+aJpF1n/IdA2CojUNPWa8MNG0liKk3i87gFAPrtcSOIO9BDo8pSRN4PqrA3TykD4hHfbi
	Z8+Fd9+haYdLaEx0h3+Ya2I+SVByTsRo4qor27bAoiXr7nnl0fS+oDo/MIcJfmtKFtuQbO
	w2lKetCeLuYyMdnXRMQ6F2vhJvTfsjU3ShSosld0LpaOeedG5lqqUpz9U+2lbQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1726142696;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WLNJKXffC/1phJTPsnafjkuYY3WKkcoBWZ0khVj1ZB0=;
	b=0KjfqOQ7lpk6fVTk18oPVqg88aCGQbD1u8b3QTMfe0BGK+/Mw90lQDKnOBXpCZpL4051Ud
	vKfV6YYL32yGN0Dw==
To: Jinjie Ruan <ruanjinjie@huawei.com>, Richard Cochran
 <richardcochran@gmail.com>
Cc: bryan.whitehead@microchip.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, anna-maria@linutronix.de,
 frederic@kernel.org, UNGLinuxDriver@microchip.com, mbenes@suse.cz,
 jstultz@google.com, andrew@lunn.ch, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next v3 1/2] posix-timers: Check timespec64 before call
 clock_set()
In-Reply-To: <ea351ea0-5095-d7ae-5592-ec3bd45c771c@huawei.com>
References: <20240909074124.964907-1-ruanjinjie@huawei.com>
 <20240909074124.964907-2-ruanjinjie@huawei.com>
 <Zt8SFUpFp7JDkNbM@hoboy.vegasvil.org>
 <ea351ea0-5095-d7ae-5592-ec3bd45c771c@huawei.com>
Date: Thu, 12 Sep 2024 14:04:55 +0200
Message-ID: <874j6l9ixk.ffs@tglx>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu, Sep 12 2024 at 10:53, Jinjie Ruan wrote:

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
> There was already checks in following code, so it is not necessary to
> check NULL or timespec64_valid() in ptp core and its drivers, only the
> second patch is needed.
>
> 169 int do_sys_settimeofday64(const struct timespec64 *tv, const struct
> timezone *tz)
>  170 {
>  171 >-------static int firsttime = 1;
>  172 >-------int error = 0;
>  173
>  174 >-------if (tv && !timespec64_valid_settod(tv))
>  175 >------->-------return -EINVAL;

How does this code validate timespecs for clock_settime(clockid) where
clockid != CLOCK_REALTIME?

Thanks,

        tglx

