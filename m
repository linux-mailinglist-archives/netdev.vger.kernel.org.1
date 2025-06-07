Return-Path: <netdev+bounces-195516-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E52BAD0E80
	for <lists+netdev@lfdr.de>; Sat,  7 Jun 2025 18:21:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 357E016BAD4
	for <lists+netdev@lfdr.de>; Sat,  7 Jun 2025 16:21:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A3381D86C6;
	Sat,  7 Jun 2025 16:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PZBiEfQq"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FD1E2F3E;
	Sat,  7 Jun 2025 16:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749313276; cv=none; b=I9fHi9nC2ys7A+6jtopEJziLRWuEoKxuLYBf/08ddL6QNnkM+ESR4UA0mWn5bCgIhCN3kbrDciVeHOgXdDwqikAyWi/yqbOyEYapQp3PFhrvkUITti5SNm2b3Jd0iu3sdkoTQ5YThcHqsPRiSmUKxJ3NKwCY4SOfYJR3qCbXlX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749313276; c=relaxed/simple;
	bh=oiI/UBIp22xDHCckuTpupPI1ZnNEyqHPaX1KMdJp0rE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t1apQ/scL4ADvViLxFyjoQYFv/Xno3PSeyoBMbdcMfjhvwDyzF23C4s4/TYo561gywMIYOeTGHU+WUv+9pSm2c/T55pVFHw5WEshQoIMdmhYhj/MKzwurGXqodLFCVBqeEq6JztQu4n+38qR0CyimZgO1jlvkZ6p3f0xYDvuYoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PZBiEfQq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD844C4CEE4;
	Sat,  7 Jun 2025 16:21:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749313275;
	bh=oiI/UBIp22xDHCckuTpupPI1ZnNEyqHPaX1KMdJp0rE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PZBiEfQqujGjVpyqz8adTEM705B7KVMUfSgJlzeViiwwh4N+aqa5a/Z44MmIE5W/c
	 wu1MduHg0/1b7KSea1myrHVzzyPHQ5ZSySxT0Qf7fDH8lfLwlKEpXpPrGtHEud1EPO
	 guAcoYvH5Fa/yuDMFv9ek+dAsNZdp/xrS6YSf2cdWM64frwnZ6DBmIINsbfaCLKVKt
	 qO33LH1aLdDgTMg/RzSXy+nOWBfZidZqCmunLrDXxD2Q5ldmLYD7Py7kpBWjRJ1ggg
	 2KXkk44C1BfY2FX0FFQRfUiDcpdyI9wL3kt7G7wiAGoRKnS+0wr+dI0SqwWpLHlp3e
	 6clzCiH8rFyug==
Date: Sat, 7 Jun 2025 17:21:10 +0100
From: Simon Horman <horms@kernel.org>
To: Bartlomiej Dziag <bartlomiejdziag@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Daniel Machon <daniel.machon@microchip.com>,
	Wojciech Drewek <wojciech.drewek@intel.com>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	Alexis =?utf-8?Q?Lothor=C3=A9?= <alexis.lothore@bootlin.com>,
	netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: stmmac: Change the busy-wait loops timing
Message-ID: <20250607162110.GB197663@horms.kernel.org>
References: <20250606102100.12576-1-bartlomiejdziag@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250606102100.12576-1-bartlomiejdziag@gmail.com>

On Fri, Jun 06, 2025 at 12:19:49PM +0200, Bartlomiej Dziag wrote:
> After writing a new value to the PTP_TAR or PTP_STSUR registers,
> the driver waits for the addend/adjust operations to complete.
> Sometimes, the first check operation fails, resulting in
> a 10 milliseconds busy-loop before performing the next check.
> Since updating the registers takes much less than 10 milliseconds,
> the kernel gets stuck unnecessarily. This may increase the CPU usage.
> Fix that with changing the busy-loop interval to 5 microseconds.
> The registers will be checked more often.

Hi Bartlomiej,

I am curious.

Does it always take much less than 10ms, or is that usually so.
If it is the former, then do we need to wait for in the order of
10000 x 5us = 50ms before giving up?

> 
> Signed-off-by: Bartlomiej Dziag <bartlomiejdziag@gmail.com>

...

