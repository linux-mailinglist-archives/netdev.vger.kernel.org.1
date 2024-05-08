Return-Path: <netdev+bounces-94430-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C3838BF733
	for <lists+netdev@lfdr.de>; Wed,  8 May 2024 09:39:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C01A1F22873
	for <lists+netdev@lfdr.de>; Wed,  8 May 2024 07:39:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 334B72C856;
	Wed,  8 May 2024 07:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1nuvvsDk";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="VhcHvm6K"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E5A73A1DA;
	Wed,  8 May 2024 07:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715153942; cv=none; b=qSJ9hzS/inqPb9UlrM7genso6Th88gUw0TB5n5OWcdsOCEgJ3zZgKy44CqgyKhBfrtcXz6NDsBJgnC8BZjCgXPWOHTTma/rUFAKfS8dt7zPscr2+T0ur4yHXosPTU2HZrshXB8ljIZXiSYwRWxZ8Q5vYQDI79Vd3ofUaymDkq30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715153942; c=relaxed/simple;
	bh=GRBM6Q9ulEa6b1C1AIlEe8Wdt4+S7xROw+0i92+JaGM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Vl2oIYOqyOkitW77ksIncoyWS3WdSqPuvnWaTgkGHmYgFKNyjqGKE8rB0z05nOpE2SOvzKqYi5uwUohh3wM5duRx8irqZOsI3mfzRYGi5zy0uFtGW//D7zEsFFUgK+WXC7dGsncrbZiKGy7fxj0JXMqu63aMEkDZhUEl+9Crtrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=1nuvvsDk; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=VhcHvm6K; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1715153938;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=H6hqXb9MCRTxs635sBkjBFmdNV/lsU4W+VAlI6NfWPc=;
	b=1nuvvsDkJk308I59qyuDDAY7raMXe58IJXHnvzks1l63fWs+dsBnkjDhXWyX+RkV5iwtA8
	T3RA3EpWWIdkiKp1cax73+1KK2ox+7wLrbrvMIvRG2TELc+w2JbgQjKEZq+5ZfvRrJD/8F
	F8jpJogjcxUpCQMQFrJMErIyKbaTyAenawxMeeWOe14p9gCqzdgaEKrp44L/1IWM1lalyL
	yw6OMkBZatjNT8rJ8aNZ4It2sMoGGoLVipfSUaTMOZCrVC869f7TDfA9R9MnAokrpPpt/B
	OJYBR/wOvl0N9uAd1+YZM4U0seXYiQfQ+tYgjvnzs9psZGw2RDjWoVeZPgz0Xw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1715153938;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=H6hqXb9MCRTxs635sBkjBFmdNV/lsU4W+VAlI6NfWPc=;
	b=VhcHvm6KLaVB6rBreMYUoEE64Vi598JqUzdOvrN74UVu4Cjh8nJs+xoFXBzFMTwf1LmnpH
	S/C3f/eYNLCT5VAA==
To: Richard Cochran <richardcochran@gmail.com>, Mahesh Bandewar
 <maheshb@google.com>
Cc: Netdev <netdev@vger.kernel.org>, Linux <linux-kernel@vger.kernel.org>,
 David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Arnd
 Bergmann <arnd@arndb.de>, Sagi Maimon <maimon.sagi@gmail.com>, Jonathan
 Corbet <corbet@lwn.net>, John Stultz <jstultz@google.com>, Mahesh Bandewar
 <mahesh@bandewar.net>
Subject: Re: [PATCHv4 net-next] ptp/ioctl: support MONOTONIC_RAW timestamps
 for PTP_SYS_OFFSET_EXTENDED
In-Reply-To: <ZjsDJ-adNCBQIbG1@hoboy.vegasvil.org>
References: <20240502211047.2240237-1-maheshb@google.com>
 <ZjsDJ-adNCBQIbG1@hoboy.vegasvil.org>
Date: Wed, 08 May 2024 09:38:58 +0200
Message-ID: <87cypwpxbh.ffs@tglx>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, May 07 2024 at 21:44, Richard Cochran wrote:
> On Thu, May 02, 2024 at 02:10:47PM -0700, Mahesh Bandewar wrote:
>> +/*
>> + * ptp_sys_offset_extended - data structure for IOCTL operation
>> + *			     PTP_SYS_OFFSET_EXTENDED
>> + *
>> + * @n_samples:	Desired number of measurements.
>> + * @clockid:	clockid of a clock-base used for pre/post timestamps.
>> + * @rsv:	Reserved for future use.
>> + * @ts:		Array of samples in the form [pre-TS, PHC, post-TS]. The
>> + *		kernel provides @n_samples.
>> + *
>> + * History:
>> + * v1: Initial implementation.
>> + *
>> + * v2: Use the first word of the reserved-field for @clockid. That's
>> + *     backward compatible since v1 expects all three reserved words
>> + *     (@rsv[3]) to be 0 while the clockid (first word in v2) for
>> + *     CLOCK_REALTIME is '0'.
>
> This is not really appropriate for a source code comment.  The
> un-merged patch series iterations are preserved at lore.kernel in case
> someone needs that.
>
> The "backward compatible" information really wants to be in the commit
> message.

I agree that it wants to be in the commit message, but having the
version information in the kernel-doc which describes the UAPI is
sensible and useful. That's where I'd look first and asking a user to
dig up this information on lore is not really helpful.

Thanks,

        tglx

