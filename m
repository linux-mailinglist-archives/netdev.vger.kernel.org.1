Return-Path: <netdev+bounces-219515-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 972CDB41ADF
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 11:58:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4582C1BA594E
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 09:59:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BA462D2382;
	Wed,  3 Sep 2025 09:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="WWOeJ/es";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="bm7kR/26"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD6CF26E716;
	Wed,  3 Sep 2025 09:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756893453; cv=none; b=WrQQnEGWCNs1IPx+5aj+24VApWcxwVxUvWvt/bpRJPe7uYaPrBYqo9MoYVgRHdAQrEXtBsjCMWu0FGQsnkHRavntcraNhv2HsqG98XFgBBOJpKKZm+WFdb+Xg/5WtKyCyPe3nsMTypjQAe0SKVV/qKwL0a34swBX5he4SX9JBqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756893453; c=relaxed/simple;
	bh=/0FyGGHWcDrgxz10Urh5OV1MMiUdH5HDCFT5DAmKvuI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=AYLbyjwLJ7jl+AHidTJvt/TSJ/9WqMyMACudzua6wR6y9Zh6qUw+/vX48PdZxYRw9LQelkHl5hSpWTL4Hm6jMrChfGQyQyl0Sr8XfVRkq76zFhxRiCm4gxQ1yykbvAhDpdARbtXooqxVQJ5n+ERHJyPfM/mdUiJ7Fc8KUYcSIx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=WWOeJ/es; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=bm7kR/26; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1756893449;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/0FyGGHWcDrgxz10Urh5OV1MMiUdH5HDCFT5DAmKvuI=;
	b=WWOeJ/esyFTr51QXP37ODlRH7ABL2Yen4uDulWpqlXI2IGmDGm4I5x2S6ArN6tgwkjemKp
	4hBP4TGK/P4Uurbs9941mrBz1+dy+UNFnGx8oZ69cimD8tqbee3vuzSEFD49zIrr69kSJy
	zxT5mzLLVXsr1OWKlGXN0DOtnG1+dH8YPW/n1jjXB3OFwhgTHkqBktmtdyWquQtxGm6pt3
	VrY74UKlTx057usWdP7FljDaQYVYQUwFMEE1WTRsX+nSVHJNAd3iqS114CHlf9CnEpUD3b
	SxVe/wOysR0+aGuuxLE1t6Qcu9NgoVXiyORMyv/bKuSASPh+wZMIPkZ4eDhDhg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1756893449;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/0FyGGHWcDrgxz10Urh5OV1MMiUdH5HDCFT5DAmKvuI=;
	b=bm7kR/26YIrTFvAFsmmUReGzi+ASqn5d2A6PPqovQGU7SfvAv39Ti03OsNUqWaclyOJbNw
	HEWw2SzRe2QcZsDA==
To: Gatien Chevallier <gatien.chevallier@foss.st.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>, Richard Cochran
 <richardcochran@gmail.com>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, John
 Stultz <jstultz@google.com>, Stephen Boyd <sboyd@kernel.org>
Cc: netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, Gatien Chevallier
 <gatien.chevallier@foss.st.com>
Subject: Re: [PATCH net-next v4 1/3] time: export timespec64_add_safe() symbol
In-Reply-To: <20250901-relative_flex_pps-v4-1-b874971dfe85@foss.st.com>
References: <20250901-relative_flex_pps-v4-0-b874971dfe85@foss.st.com>
 <20250901-relative_flex_pps-v4-1-b874971dfe85@foss.st.com>
Date: Wed, 03 Sep 2025 11:57:28 +0200
Message-ID: <877byfzwmv.ffs@tglx>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, Sep 01 2025 at 11:16, Gatien Chevallier wrote:

> Export the timespec64_add_safe() symbol so that this function can be used
> in modules where computation of time related is done.
>
> Signed-off-by: Gatien Chevallier <gatien.chevallier@foss.st.com>

Acked-by: Thomas Gleixner <tglx@linutronix.de>

