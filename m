Return-Path: <netdev+bounces-71155-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CB568527A6
	for <lists+netdev@lfdr.de>; Tue, 13 Feb 2024 04:11:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC7671F23E08
	for <lists+netdev@lfdr.de>; Tue, 13 Feb 2024 03:11:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D11B38C0A;
	Tue, 13 Feb 2024 03:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="J4IGelxP"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BC928BF3
	for <netdev@vger.kernel.org>; Tue, 13 Feb 2024 03:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707793908; cv=none; b=tUbwaz1cr+Tz7rfWpD7+x84JGZyPauNb3zG2mVLEDZcsfK3AHYY4vSkSd90NPQZgEcj38ZMBD31GSl/Y0fpLl72SPsGY7BjmFYLABJQ7uunc6aqGizxsZpy3rUJhbxlQsnOypnQajg38dPb7l25o67R4+e0PQdIJRMLHj4LhnzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707793908; c=relaxed/simple;
	bh=3lsy/k6lYUPhRqx+N/Hd49XYG1OZFeq1FQX7IJJ/4zA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F+vN/8apPviW5DJJrqvb/N9zpycpcnGmZJ/Oe1r2O/+mggjyyDIWrB00062YLS+/pYZOSni9TfiitmUACcKZ15vhQZ1F/av3y7ZBOSMBmcdBKUxb5xeFBH6jtXCppqIMIDY6iKrBGlI9sVnJv6k/K/T9NN2uB8UbAs8cm+ulOzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=J4IGelxP; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=zwixcgXoEEwgcLkB7Xvvi6qNIhoGM4qqlen3+NAu+2A=; b=J4IGelxPR1++8z3Y7I++TxGouv
	xDVRik5k52RBMBG9fhRdDyTwL9w2zcLAotjvRx+LYnTNoMwDh1Qig5ZFEAOHVzdEOkADh0mcnk5Nr
	8dh+krwzqz7LzxNp5PmHL3rcqDJlajAB5DtPbOkOCggYGZkfMJyZQP1TQ2JjLrnKrwcg=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rZjD0-007cxD-1S; Tue, 13 Feb 2024 04:11:46 +0100
Date: Tue, 13 Feb 2024 04:11:46 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Realtek linux nic maintainers <nic_swsd@realtek.com>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
	David Miller <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH net-next] r8169: add LED support for RTL8125/RTL8126
Message-ID: <26417c01-7da1-4c44-be31-9565b457f7ae@lunn.ch>
References: <f982602c-9de3-4ca6-85a3-2c1d118dcb15@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f982602c-9de3-4ca6-85a3-2c1d118dcb15@gmail.com>

> +static int rtl8125_get_led_reg(int index)
> +{
> +	static const int led_regs[] = { LEDSEL0, LEDSEL1, LEDSEL2, LEDSEL3 };
> +
> +	return led_regs[index];
> +}
> +
> +int rtl8125_set_led_mode(struct rtl8169_private *tp, int index, u16 mode)
> +{
> +	int reg = rtl8125_get_led_reg(index);
> +	struct device *dev = tp_to_dev(tp);
> +	int ret;
> +	u16 val;
> +
> +	ret = pm_runtime_resume_and_get(dev);
> +	if (ret < 0)
> +		return ret;
> +
> +	mutex_lock(&tp->led_lock);
> +	val = RTL_R16(tp, reg) & ~LEDSEL_MASK_8125;
> +	RTL_W16(tp, reg, val | mode);
> +	mutex_unlock(&tp->led_lock);

I'm wondering if this mutex is actually needed. Each LED has its own
register. So you don't need to worry about setting two different LEDs
in parallel. Its just a question of, can the LED core act on one LED
in parallel? I don't know the answer to this, but it does use delayed
work for some things, and that should not run in parallel.

Maybe you can look into this and see if its really needed. Otherwise,
lets keep it, it does no real harm.

     Andrew

