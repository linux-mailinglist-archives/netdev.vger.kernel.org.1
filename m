Return-Path: <netdev+bounces-166683-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D0FAA36F1F
	for <lists+netdev@lfdr.de>; Sat, 15 Feb 2025 16:29:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 247A81891DB5
	for <lists+netdev@lfdr.de>; Sat, 15 Feb 2025 15:29:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3B331DE2C7;
	Sat, 15 Feb 2025 15:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="EBunxhHB"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4774F42AA5
	for <netdev@vger.kernel.org>; Sat, 15 Feb 2025 15:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739633388; cv=none; b=qooZ5biY6Wj52t1ZAGPoHz8ZK8f3PTB7zLCJQls/WVMOGudrmJb4FrJbDJA9yU85UiK2uZ0xB3Om0OEHBWUmEl5t2Ib8JyxiUEVkse0LkcGNxaFzEF0lgt4xs37wd4YZP4SzYG+SUPk3v8k5/ByMZSIXeIbSyhg4nX7fIgJes6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739633388; c=relaxed/simple;
	bh=hz3ZOumg/E0odtwlLSJj3r8sYIUlcX4bjxd2o/f7S3o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ocTitHcu42sNcz45oMnj1goMlS9FNHRUzCfzz7o6PenolEQN/oclnQYpfVTYj+qmGvkdAheUNVl9gdnGlfA4vO2g4ccj9dbMXTi5XNFunBcn6LXCrTl3XIChTYguSU4Jzeygjg+8LEh/0uTVx3HpUX5yMXQ55MV7HD4ZEZ/sXJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=EBunxhHB; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=rBdco+tY5/Z57bPCdHN8e7c3WhYvfabcGsCRPO6LyuU=; b=EB
	unxhHB2AYmXqfZRsCI7RKPfkCHoqJunyQGYpX1Vhal7q0Z88UkiLT0PPA06b3XJrbfh8n5TsRhzRX
	rp8GtSF5wvi1uMnJCiJjSMhvUmO2Fme5/8K2Jamqo4r0Fu3m9EAhEL5wBidvO4vb/pPV09XhNQJ9G
	yamt3gkeb72adbQ=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tjK6g-00EPw9-Nj; Sat, 15 Feb 2025 16:29:26 +0100
Date: Sat, 15 Feb 2025 16:29:26 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Alvin =?utf-8?Q?=C5=A0ipraga?= <alsi@bang-olufsen.dk>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Luiz Angelo Daros de Luca <luizluca@gmail.com>,
	netdev@vger.kernel.org, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] net: dsa: rtl8366rb: Fix compilation problem
Message-ID: <dce33cab-5d8d-48a2-9554-1ef8c23d35b7@lunn.ch>
References: <20250214-rtl8366rb-leds-compile-issue-v1-1-c4a82ee68588@linaro.org>
 <ca426cd1-124a-483e-9426-4a59ed7d7ba4@lunn.ch>
 <CACRpkdYWXyw6qZBmkf_uN0WcXL3v2iRWbsHjqvmkZ1bWC8Bbmw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACRpkdYWXyw6qZBmkf_uN0WcXL3v2iRWbsHjqvmkZ1bWC8Bbmw@mail.gmail.com>

On Sat, Feb 15, 2025 at 01:07:32AM +0100, Linus Walleij wrote:
> On Fri, Feb 14, 2025 at 3:06 PM Andrew Lunn <andrew@lunn.ch> wrote:
> > On Fri, Feb 14, 2025 at 09:59:57AM +0100, Linus Walleij wrote:
> > > When the kernel is compiled without LED framework support the
> > > rtl8366rb fails to build like this:
> > >
> > > rtl8366rb.o: in function `rtl8366rb_setup_led':
> > > rtl8366rb.c:953:(.text.unlikely.rtl8366rb_setup_led+0xe8):
> > >   undefined reference to `led_init_default_state_get'
> > > rtl8366rb.c:980:(.text.unlikely.rtl8366rb_setup_led+0x240):
> > >   undefined reference to `devm_led_classdev_register_ext'
> > >
> > > As this is constantly coming up in different randconfig builds,
> > > bite the bullet and add some nasty ifdefs to rid this issue.
> >
> > At least for DSA drivers, it is more normal to put the LED code into a
> > separate compilation unit and provide stubs for when it is not
> > used. That avoids a lot of nasty #ifdefs. Could you do the same here?
> 
> I can pull out *some* code to a separate file like that, but
> some LED-related registers are also accessed when the LED
> framework is disabled, so it would lead to a bit of unnatural
> split between the two files with some always-available
> LED code staying in the main file.

So there is some low level code for basic LED register access which
you need to keep in rtl8366rb.c, and then a layer on top of that for
led_classdev which goes into a file of its own. At first glance, it
does not look too bad, but the devil is in the details.

In the end, you need to make a style call. Is #ifdef better than an
unnatural splitting.

Hummm..

In the example above, you are getting linker errors. So the code at
least compiles, in this example. Rather than #ifdef, can you use

	if (IS_ENABLED(CONFIG_LEDS_CLASS)) {
	....
	}
	
That looks less ugly, and allows compile testing, which is what we
don't like about #ifdef.

	Andrew


