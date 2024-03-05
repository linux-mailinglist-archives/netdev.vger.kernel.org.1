Return-Path: <netdev+bounces-77418-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F085C871BF6
	for <lists+netdev@lfdr.de>; Tue,  5 Mar 2024 11:47:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 88964B2378E
	for <lists+netdev@lfdr.de>; Tue,  5 Mar 2024 10:47:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 337F354908;
	Tue,  5 Mar 2024 10:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="L4j/F6ib";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="WS46EzsH"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4EE654917
	for <netdev@vger.kernel.org>; Tue,  5 Mar 2024 10:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709634935; cv=none; b=KvQFfyikaF/2nQ248a5GaTuCpcbzds8UO87ZNRNPKnD6N2tN614lvR6hBeFwqIWN4CMnWzmyWB3Exnpj9yziUIJ9g3APcFhRlTzI5cHv+vfaOX67EvRNpifj6TFOQPRVZO7u9mSW3y9FgSfzPcusgDzrbnXItDp8pjGtIx2qniA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709634935; c=relaxed/simple;
	bh=oz3N6RHZZQkPOmBUEGFlGvjKaltIyvDlWApdvvt/zR0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VtupQbUY4hViRtzPHFZ86YcvMKC3K71aD1/o9MWKrVVE/fHbSNPgyEDvwau3R+0QzjqULP+RrMqPZxZmu/PGKR1CF49GgGhbwIvJXYRf5XnVSYPckUSJ49sXnrERBYsN7NQ+4m2ucYtKLvDBJf08JIw5KHj0wBD774CkJxvdaVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=L4j/F6ib; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=WS46EzsH; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 5 Mar 2024 11:35:30 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1709634931;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oz3N6RHZZQkPOmBUEGFlGvjKaltIyvDlWApdvvt/zR0=;
	b=L4j/F6ibwH1xAsMKKEEpAmVM1rhRrBfJIubr6Wb+zLjmJtNGsnV4aYUtAGPqbErBijlhHa
	FOLO956W+2wzyFBN0MF+cQaQ/4cc1ZwjuvDmkcyEI3taPbu61URAYUin60qHPqz8zhQQ9A
	iKQLvLLR8fLYUaSN48FMW8Q3AWgrh4Mw6kjCpz1tRGDjFHosZ/SWdWMraCsovpC+Zi0Y8F
	4n4+jUy0jNW0gRE9r+IutPbOQgR+QZmNslWxBB7qgbX8Cg7BLg2whTizG8pDhA43HqswDT
	LvLcNjeNmF0/dHgBz7tQa8PVSFwJV7+gZNhDTHeU98LY035WqSvKTk3ki/WISg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1709634931;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oz3N6RHZZQkPOmBUEGFlGvjKaltIyvDlWApdvvt/zR0=;
	b=WS46EzsH24rQjLn3+WcMMeyaCXpDcE0b2SvaceaPcQrP8NdrSr0WRvs0DrW2EaUZt0ylSS
	ZxxUWkIHWjJgGVBg==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Wander Lairson Costa <wander@redhat.com>,
	Yan Zhai <yan@cloudflare.com>
Subject: Re: [PATCH v3 net-next 2/4] net: Allow to use SMP threads for
 backlog NAPI.
Message-ID: <20240305103530.FEVh-64E@linutronix.de>
References: <20240228121000.526645-1-bigeasy@linutronix.de>
 <20240228121000.526645-3-bigeasy@linutronix.de>
 <c37223527d5b6bcf0ffce69c81f16fd0781fa2d6.camel@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <c37223527d5b6bcf0ffce69c81f16fd0781fa2d6.camel@redhat.com>

On 2024-03-05 11:08:35 [+0100], Paolo Abeni wrote:
>=20
> Does not apply cleanly after commit 1200097fa8f0d, please rebase and
> repost. Note that we are pretty close to the net-next PR, this is at
> risk for this cycle.

will do.

> Side note: is not 110% clear to me why the admin should want to enable
> the threaded backlog for the non RT case. I read that the main
> difference would be some small perf regression, could you clarify?

I am not aware of a perf regression.
Jakub was worried about a possible regression with this and while asking
nobody came up with an actual use case where this is used. So it is as
he suggested, optional for everyone but forced-enabled for RT where it
is required.
I had RH benchmarking this and based on their 25Gbe and 50Gbe NICs and
the results look good. If anything it looked a bit better with this on
the 50Gbe NICs but since those NICs have RSS=E2=80=A6

I have this default off so that nobody complains and yet has to
possibility to test and see if it leads to a problem. If not, we could
enable it by default and after a few cycles and then remove the IPI code
a few cycles later with absent complains.

> Thanks!
>=20
> Paolo

Sebastian

