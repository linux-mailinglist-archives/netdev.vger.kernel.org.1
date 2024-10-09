Return-Path: <netdev+bounces-133382-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 48996995C4F
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 02:31:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB4C21F24E3C
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 00:31:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E16518EAD;
	Wed,  9 Oct 2024 00:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Zsu1dF1F"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01DA8E573
	for <netdev@vger.kernel.org>; Wed,  9 Oct 2024 00:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728433855; cv=none; b=ZW19VGSustEheZ3gJkTUFl9NcUnkFa1AXlvnXvdY9hwJJtM0KyBg3U6QKrkiUkLbLHRzvsO4jcbbua1u3v0BqtmemT9eAzzSJhdJENyEM9IdAwjrdZ2/ZLsE8UC6hDwwlVt6Ap8k9s7Y4P22ZFswZznC/VaqBmnf1tK2Qz9EpJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728433855; c=relaxed/simple;
	bh=URG0fvEJEdQV1QWKsX6LOW/8A/YUeslmrBphbQZXR6Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qLSnQ3NTV00stjLC5EX6LOnqnctI19hpybyhluTUhX7K7MmJl8A2ojk6SPnL+8vtXEeLwu2C3W+9No3cFZ56LQnmdCBg2Lr3oJ4bWQ1M2atdkFyWkPG5FOAKkizzi9YXQzNYQt2PR1Eu/Z5AmtWMSEp05cJpXoF9zWDxj9FTpoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=Zsu1dF1F; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=1dCQdiAohakR4r8shl44ML2JrrQKhCgF4jFCM2YYqE0=; b=Zsu1dF1FjwIj1IgjqnGYPzC+8h
	ZlVNUspjTW01eFreP9QvNz1qGOtINR5KIeO7O0DSffIee1zUztwX1EdIVXLty9S8wmSNwgA0fC3FN
	jzwJvs1JztueuW+2SvOZCFzHv/oVqyg/jS25pgoHQFm2PvAorDbE/srbI+lqOoC/n+ZE=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1syKbL-009Qck-4H; Wed, 09 Oct 2024 02:30:51 +0200
Date: Wed, 9 Oct 2024 02:30:51 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Tim Harvey <tharvey@gateworks.com>
Cc: Florian Fainelli <f.fainelli@gmail.com>,
	netdev <netdev@vger.kernel.org>
Subject: Re: Linux network PHY initial configuration for ports not 'up'
Message-ID: <dccfed75-bf35-49fc-b949-1067f4d7e794@lunn.ch>
References: <CAJ+vNU12DeT3QWp8aU+tSL-PF00yJu5M36Bmx_tw_3oXsyb76g@mail.gmail.com>
 <c572529e-78c4-42d5-a799-1027fd5fca29@gmail.com>
 <CAJ+vNU3qCKzsK2XFj6Gj0vr4JfE=URYadWsr3xvxOO__MVNsPw@mail.gmail.com>
 <009d90a1-16e6-4f6b-bfe7-8282e9deeeb3@gmail.com>
 <CAJ+vNU3u62Z6Nr=5AmWtBRC6M3bR_0SMf8RbKXe9os6Ru4w2Vw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJ+vNU3u62Z6Nr=5AmWtBRC6M3bR_0SMf8RbKXe9os6Ru4w2Vw@mail.gmail.com>

> So you are thinking the right place to address this is in boot
> firmware and the network switch init there should go and disable all
> PHY's by default then? I'm good with that approach and can code that
> up.

I've seen some use cases where the link should be up as fast as
possible. If you force the link down until it is configured up, you
can be adding a little over 1 second delay for autoneg to
complete. I've even see cases there u-boot kicks off autoneg, before
jumping into Linux so that by the time Linux userspace is running and
admin up the interface, autoneg has completed and the link is usable.

There are diverse requirements here and any changes somebody wants to
make is likely to cause a regression for somebody.

	Andrew

