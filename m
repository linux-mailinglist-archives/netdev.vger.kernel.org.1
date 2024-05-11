Return-Path: <netdev+bounces-95689-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A41D8C307A
	for <lists+netdev@lfdr.de>; Sat, 11 May 2024 12:00:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6EE7D281EFF
	for <lists+netdev@lfdr.de>; Sat, 11 May 2024 10:00:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A0165380F;
	Sat, 11 May 2024 10:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="IDP0bkji";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="flfZViOH"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF3B1610B;
	Sat, 11 May 2024 10:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715421604; cv=none; b=PuZyHwrtweApkosRLVYTvABXrbCnGLiMSv7XAYQlk7kSXqn1ZNnntbQffrZxGWzGYNJ1AD4AuPHJp5enyakbo09LRZ3VbktBPLJNYg47jsBqe/sihDgo6OWpwfXb9Sk1ugYrfsSNfjjU1GGfgoLz50TKLR5ykaWrHG2a2s7vqbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715421604; c=relaxed/simple;
	bh=hK/ieWnnZVN7cwkcOFnBicbzi3d35Qr4kCBNGFXXp4c=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Ry2yuuJXQrqETvyrrwLIZyvkma7aRDWAPalXCP/AbMvmWGemf3g1xmfLanCN+DlK/S3amyao0FjNKpSclNDRDmeANeFgO2hGiwwWXuAKIOIv6tz7PkXz8hUWBNovotAx6cV0Y3zu0H3AxmmpeXKLq3r5rI5i6az5HkOX5Vs9ebU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=IDP0bkji; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=flfZViOH; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1715421600;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Anfm4LvA1aUMYuXO8S87/+mCtFjr/yXNMh3PSEH0HhQ=;
	b=IDP0bkjiJIBSIRrGYaj05oBl9pss/QLjrppqiN7j2JLWTWzhnUZZ9Qbv6/JGeT+a7ymsRp
	nGh9zZZ3wVCDklb5uZGeWOhaoyG7Ux4k6yHaf27xT6yimXoc290zlbC0auy3OQKCX6YpVK
	ths1MuB6UKiEfe03rojr4Ww58HgPkKetnKf4nqJ64qhSVqPV4AY8KwqRVmGnbO96vIgMJh
	nBHeKucCC9C+gYwsB+yvE7Qy8UbzLxpHntdtzY2DsPgJIhcWMcXhFHHiTQTdVZXqDlwXOR
	iwtlyE4bXVYLCTmDDytehwwLS7B4j6A6Nh8CXWw1fHc+R3cDfkVjGKO4Vu/MXQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1715421600;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Anfm4LvA1aUMYuXO8S87/+mCtFjr/yXNMh3PSEH0HhQ=;
	b=flfZViOHbnBKvydj+C/EQuyHGG6DmzZZzsEjaVvtvwatzEEr7QgrafEO0kpC39gjjpFnaf
	BGXkiJ2HVueS0iDg==
To: =?utf-8?B?TWFoZXNoIEJhbmRld2FyICjgpK7gpLngpYfgpLYg4KSs4KSC4KSh4KWH4KS1?=
 =?utf-8?B?4KS+4KSwKQ==?= <maheshb@google.com>
Cc: Richard Cochran <richardcochran@gmail.com>, Netdev
 <netdev@vger.kernel.org>, Linux <linux-kernel@vger.kernel.org>, David
 Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Arnd
 Bergmann <arnd@arndb.de>, Sagi Maimon <maimon.sagi@gmail.com>, Jonathan
 Corbet <corbet@lwn.net>, John Stultz <jstultz@google.com>, Mahesh Bandewar
 <mahesh@bandewar.net>
Subject: Re: [PATCHv4 net-next] ptp/ioctl: support MONOTONIC_RAW timestamps
 for PTP_SYS_OFFSET_EXTENDED
In-Reply-To: <CAF2d9jjnB7hkjzAdynSMOWwiy9OZEbTrfSQxsVxhF8wwatW9_g@mail.gmail.com>
References: <20240502211047.2240237-1-maheshb@google.com>
 <ZjsDJ-adNCBQIbG1@hoboy.vegasvil.org> <87cypwpxbh.ffs@tglx>
 <Zj2dZJAfOdag-M1H@hoboy.vegasvil.org> <878r0inm1c.ffs@tglx>
 <CAF2d9jjnB7hkjzAdynSMOWwiy9OZEbTrfSQxsVxhF8wwatW9_g@mail.gmail.com>
Date: Sat, 11 May 2024 11:59:59 +0200
Message-ID: <87ttj4mzxc.ffs@tglx>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Fri, May 10 2024 at 09:45, Mahesh Bandewar (=E0=A4=AE=E0=A4=B9=E0=A5=87=
=E0=A4=B6 =E0=A4=AC=E0=A4=82=E0=A4=A1=E0=A5=87=E0=A4=B5=E0=A4=BE=E0=A4=B0) =
wrote:

> On Fri, May 10, 2024 at 12:50=E2=80=AFAM Thomas Gleixner <tglx@linutronix=
.de> wrote:
>>
>> On Thu, May 09 2024 at 21:07, Richard Cochran wrote:
>>
>> > Thomas,
>> >
>> > On Wed, May 08, 2024 at 09:38:58AM +0200, Thomas Gleixner wrote:
>> >> On Tue, May 07 2024 at 21:44, Richard Cochran wrote:
>> >> > On Thu, May 02, 2024 at 02:10:47PM -0700, Mahesh Bandewar wrote:
>> >> >> + * History:
>> >> >> + * v1: Initial implementation.
>> >> >> + *
>> >> >> + * v2: Use the first word of the reserved-field for @clockid. Tha=
t's
>> >> >> + *     backward compatible since v1 expects all three reserved wo=
rds
>> >> >> + *     (@rsv[3]) to be 0 while the clockid (first word in v2) for
>> >> >> + *     CLOCK_REALTIME is '0'.
>> >
>> > ..
>> >
>> >> I agree that it wants to be in the commit message, but having the
>> >> version information in the kernel-doc which describes the UAPI is
>> >> sensible and useful. That's where I'd look first and asking a user to
>> >> dig up this information on lore is not really helpful.
>> >
>> > But writing "v1, v2" doesn't make sense for this code.  There never
>> > was a "v1" for this ioctl.  At the very least, the change should be
>> > identified by kernel version (or git SHA).
>>
>> Adding the git SHA before committing the change is going to be
>> challenging :)
>
> Instead of v1/v2, how about I can make it 'prior to kernel 6.10' and
> 'from 6.10 onwards' etc. (as Richard proposed)?

Sure

