Return-Path: <netdev+bounces-208348-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31EC9B0B1AF
	for <lists+netdev@lfdr.de>; Sat, 19 Jul 2025 22:00:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7441C3B4903
	for <lists+netdev@lfdr.de>; Sat, 19 Jul 2025 19:59:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 392C822D7A5;
	Sat, 19 Jul 2025 20:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="DqffrOIH";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="KVNZ9gc3"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC64622D7B1;
	Sat, 19 Jul 2025 20:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752955207; cv=none; b=k/1PUi5FUhAL4QwbwdMMcKMulZqxQsU7kkcitu63ek+h/Q0IPexSNpHpHIPLkN63HNnuQXvW2uF5m5cT2CcMBYXRz8PjgI+bpSCaAeuFfAqKhqqpUdSLPfqUxl+izb0pSb2xwJV1vl7YMjzRzlqrI03bqprPHYJKiPAQPQzHCkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752955207; c=relaxed/simple;
	bh=trKgn9wFZ9o39XTS77tPA/b9wbDJPWjgDVHnBcgVX6g=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=f7BU8LI2587jdPWN+iFuogdogxSoEOj0F2x8UyTdsYf+V7hanL/Z/kOB5MheJWG2B+CbxiIxGWPNghxYQMpHPC4AdslAEgjRPSxdOKQd+zkaFKzvnI04IXu9HkInEzXDb9CND1viDBqYlKbfcB9pv7GnMaYy/AgjPORwvjkdMJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=DqffrOIH; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=KVNZ9gc3; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1752955203;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=trKgn9wFZ9o39XTS77tPA/b9wbDJPWjgDVHnBcgVX6g=;
	b=DqffrOIH5d/T0eaNuzXb24+AOr6tqWAIFA1kNE5nbjesD9vJWq+g2pJ50/9NGQojFURx7Y
	dtM+HbJ3pSjcOHaSKKZCzc87PuLxb+Bwk1veq/8hnxAgDTfu5KCIuCEMj649nLLhRPcnsS
	4KbRJuUoWSpOfb6mZ78lMQq0iGmn2fcLcgy2vFsQLxry8TDs7DYJJwbnNYG9fQwrLwOk9Q
	eS+EYRmT5MFYMDMlFwXj36R/sP11IWD6jSqmDLmuv1kDhHMRq4wOcSUKdC+n74gEl3oI3c
	lWDnXL5Y2FGlOfHsaInhM5dfgOP9rd/esONpN2k6owDSNtu07zJ45LzsskURww==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1752955203;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=trKgn9wFZ9o39XTS77tPA/b9wbDJPWjgDVHnBcgVX6g=;
	b=KVNZ9gc3y71iyqP9P6vcq8GnI2oZ677aSw+q5/n7M22IkOMMcWklu5t8dmY5hLtCmAfvZi
	xLKrLtM0/JO9FWDg==
To: Markus =?utf-8?Q?Bl=C3=B6chl?= <markus@blochl.de>, Andrew Lunn
 <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc: Lakshmi Sowjanya D <lakshmi.sowjanya.d@intel.com>, Richard Cochran
 <richardcochran@gmail.com>, John Stultz <jstultz@google.com>,
 netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 markus.bloechl@ipetronik.com, Markus =?utf-8?Q?Bl=C3=B6chl?=
 <markus@blochl.de>
Subject: Re: [PATCH net] net: stmmac: intel: populate entire
 system_counterval_t in get_time_fn() callback
In-Reply-To: <20250713-stmmac_crossts-v1-1-31bfe051b5cb@blochl.de>
References: <20250713-stmmac_crossts-v1-1-31bfe051b5cb@blochl.de>
Date: Sat, 19 Jul 2025 22:00:02 +0200
Message-ID: <87o6tguf25.ffs@tglx>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Sun, Jul 13 2025 at 22:21, Markus Bl=C3=B6chl wrote:
> get_time_fn() callback implementations are expected to fill out the
> entire system_counterval_t struct as it may be initially uninitialized.
>
> This broke with the removal of convert_art_to_tsc() helper functions
> which left use_nsecs uninitialized.

Sigh. As I explained in the other thread, the proper fix is to
zero initialize the data structure at the call site and fix this whole
class of issues in one go.


