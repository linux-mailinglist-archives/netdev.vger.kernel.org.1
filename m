Return-Path: <netdev+bounces-94426-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC0108BF71C
	for <lists+netdev@lfdr.de>; Wed,  8 May 2024 09:35:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E3AE284650
	for <lists+netdev@lfdr.de>; Wed,  8 May 2024 07:35:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C2A02BB0E;
	Wed,  8 May 2024 07:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="svp+IF/T";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="8bcXkBMf"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C29A02838E;
	Wed,  8 May 2024 07:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715153750; cv=none; b=H60pd4fEQAyuTmbqkJ7622cd0uumLlwVNW4/46XFu9F0x4JiNrKnGLqDoGOrl/pkzztjd1TAYvgADh+a8xZmzq4wNgx4IMPz/vgtRZv20A8EVK1kgoBoEBP8D3RtmEdEZpmV5uJElu5yMyyGGgurK0qYaZ/eNhmLTpdCaOTY1aM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715153750; c=relaxed/simple;
	bh=+5g5QpxJMtaJvT70uE1ceROVuu2JiRFjGyRfAc6zepw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=OdJBDOKlgeC0b9bZnn0VevCaR7gCtmtGTAtZX8NLxEbZLJzwLy6Cd+9Y4WAKE10NpuEmMAdJWGfu9GQwJOCC+qYao8JGncoWBedVFkFOKqG3IvV9Fndwl/GbuatyOlp+uFJHT+LsAEtSf1FcfI+L9UXbgE0jEYNMW+JrtuRnPa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=svp+IF/T; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=8bcXkBMf; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1715153747;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KkZ21tBIn9t/kCg46TL0pTvrvKEB3JvG5pj/gvK9EIk=;
	b=svp+IF/TwErw6+p1C+x2zDMpO/0e+2PsvJZvRHYdiAfS/YlxoDliB3q4aISOIGvfSL7aCP
	bKvT+r3aIo1ycTG9bRJnjFDfVlyl5x3Jzx8gp4bZ0flm3Db8eZqWHgYEnEaivqgBR9WoSt
	5UfGt8zQmwzmmbbE6ZuL7DRv2wajz3rCfzJV/oZsYY5ul7ml4oIjLVrBg5XGGKvQKSvdFp
	T0bhHybkwqgPY3nyNLYEfFU2DepPkFz0UIfd9Cnqau7Oo9d/quBb5x+LzIQvqCL+abrK47
	aVIfq6hPz0KPzFmWXop+RvNrzmLlZRR3gmpUJdRyV8yD03Zz05Y/VuVXfC+2GA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1715153747;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KkZ21tBIn9t/kCg46TL0pTvrvKEB3JvG5pj/gvK9EIk=;
	b=8bcXkBMfK+OTmNCjndKlO3bV8kvHgUdCx3idGurjnVB54zcNtfbCBIu7hWyjAi48Zjp3R2
	3iD73MK47/4kafBg==
To: Mahesh Bandewar <maheshb@google.com>, Netdev <netdev@vger.kernel.org>,
 Linux <linux-kernel@vger.kernel.org>, David Miller <davem@davemloft.net>,
 Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Richard Cochran
 <richardcochran@gmail.com>, Arnd Bergmann <arnd@arndb.de>, Sagi Maimon
 <maimon.sagi@gmail.com>
Cc: Jonathan Corbet <corbet@lwn.net>, John Stultz <jstultz@google.com>,
 Mahesh Bandewar <mahesh@bandewar.net>, Mahesh Bandewar
 <maheshb@google.com>
Subject: Re: [PATCHv4 net-next] ptp/ioctl: support MONOTONIC_RAW timestamps
 for PTP_SYS_OFFSET_EXTENDED
In-Reply-To: <20240502211047.2240237-1-maheshb@google.com>
References: <20240502211047.2240237-1-maheshb@google.com>
Date: Wed, 08 May 2024 09:35:46 +0200
Message-ID: <87fruspxgt.ffs@tglx>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu, May 02 2024 at 14:10, Mahesh Bandewar wrote:
> The ability to read the PHC (Physical Hardware Clock) alongside
> multiple system clocks is currently dependent on the specific
> hardware architecture. This limitation restricts the use of
> PTP_SYS_OFFSET_PRECISE to certain hardware configurations.
>
> The generic soultion which would work across all architectures
> is to read the PHC along with the latency to perform PHC-read as
> offered by PTP_SYS_OFFSET_EXTENDED which provides pre and post
> timestamps.  However, these timestamps are currently limited
> to the CLOCK_REALTIME timebase. Since CLOCK_REALTIME is affected
> by NTP (or similar time synchronization services), it can
> experience significant jumps forward or backward. This hinders
> the precise latency measurements that PTP_SYS_OFFSET_EXTENDED
> is designed to provide.

This is really a handwavy argument.

Fact is that the time jumps of CLOCK_REALTIME caused by NTP (etc) are
rare and significant enough to be easily filtered out. That's why this
interface allows you to retrieve more than one sample.

Can you please explain which problem you are actually trying to solve?

It can't be PTP system time synchronization as that obviously requires
CLOCK_REALTIME.

Thanks,

        tglx

