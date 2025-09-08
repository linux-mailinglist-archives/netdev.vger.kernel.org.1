Return-Path: <netdev+bounces-220895-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AE300B49607
	for <lists+netdev@lfdr.de>; Mon,  8 Sep 2025 18:48:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4FC083408B0
	for <lists+netdev@lfdr.de>; Mon,  8 Sep 2025 16:47:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B750C30F929;
	Mon,  8 Sep 2025 16:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="XDx42iKz"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1308530F7F5
	for <netdev@vger.kernel.org>; Mon,  8 Sep 2025 16:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757350059; cv=none; b=tEAKJXIUu40/I8Q9BCYeTDfuZRkBsPnrS9KWQutBO1lZAFe6xfpFL44D4ljyDMFRzWhkiE4CtrT4AhT76uzrW9x717720MAgfPh+CB1dGgTTwl99tCr+Rke/UUSNQq62Nrx5973IdiTkXAJ1+a7TYzKvOHP0T2H79/qYzAzbz8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757350059; c=relaxed/simple;
	bh=qxoTlAGsqXKcEqIstoWU2Z85GHullqPwm2YL67ncDUw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pxoIfN6OvRmFja/Nm4EVBFI6SZ1BdyS0KwHhtxtBsvs1C1krfQ1t95c2+nheLoqlkMXH6d6F7+0s5EO7Bgbbyrq/bJJlM/A+mGibbnF0OR9pTAAUXV9Pr0o1nyEkJ1Jef+03d+ANSjTHZxJizSuSctpfP15NMkdlHkpaJdjWE5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=XDx42iKz; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=/u5AQIai1HRb95AsGPoewpc6br1Ojaok+gPX0CM2nPk=; b=XDx42iKzbJgFG3SaKLMOrBIAxg
	tF3l44SeFJoymz52z7ZeoAUiGqJ/PHjQ5zGYCfDA+3ESGhX+X7TPT0Q0HWVmhZxE0/RHYe9RRoWvk
	txvOed+HKGL1WO2knB5FIYLdzGzAmTAPg0Fa31UH0Cu8yqTMyvTWjtmM39hXUw7hTgbc=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uvf1a-007gqz-2I; Mon, 08 Sep 2025 18:47:26 +0200
Date: Mon, 8 Sep 2025 18:47:26 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Sergey Shtylyov <s.shtylyov@omp.ru>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH net] net: stmmac: prevent division by 0 in
 stmmac_init_tstamp_counter()
Message-ID: <c3183a23-21da-435d-b599-7003ae7ba79b@lunn.ch>
References: <58116e65-1bca-4d87-b165-78989e1aa195@omp.ru>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <58116e65-1bca-4d87-b165-78989e1aa195@omp.ru>

On Fri, Sep 05, 2025 at 07:06:50PM +0300, Sergey Shtylyov wrote:
> In stmmac_init_tstamp_counter(), the sec_inc variable is initialized to 0,
> and if stmmac_config_sub_second_increment() fails to set it to some non-0
> value, the following div_u64() call would cause a kernel oops (because of
> the divide error exception).  Let's check sec_inc for 0 before dividing by
> it and just return -EINVAL if so...
> 
> Found by Linux Verification Center (linuxtesting.org) with the Svace static
> analysis tool.
> 
> Fixes: df103170854e ("net: stmmac: Avoid sometimes uninitialized Clang warnings")
> Signed-off-by: Sergey Shtylyov <s.shtylyov@omp.ru>
> 
> ---
> The patch is against the master branch of Linus Torvalds' linux.git repo.

Wrong tree. Please see:

https://www.kernel.org/doc/html/latest/process/maintainer-netdev.html

This also needs reviewing by somebody who know the STMMAC
hardware. There is a comment:

	/* For GMAC3.x, 4.x versions, in "fine adjustement mode" set sub-second
	 * increment to twice the number of nanoseconds of a clock cycle.
	 * The calculation of the default_addend value by the caller will set it
	 * to mid-range = 2^31 when the remainder of this division is zero,
	 * which will make the accumulator overflow once every 2 ptp_clock
	 * cycles, adding twice the number of nanoseconds of a clock cycle :
	 * 2000000000ULL / ptp_clock.

So i'm wondering if the subsecond adjustment is sufficient, the
sec_inc might be zero, and rather than returning an error, the
hardware just needs programming differently?

    Andrew

---
pw-bot: cr

