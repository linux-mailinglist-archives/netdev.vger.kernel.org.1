Return-Path: <netdev+bounces-251397-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 29684D3C2B6
	for <lists+netdev@lfdr.de>; Tue, 20 Jan 2026 09:57:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 279715C1135
	for <lists+netdev@lfdr.de>; Tue, 20 Jan 2026 08:42:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C1E03559CA;
	Tue, 20 Jan 2026 08:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dzQvYKJM"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C835828AB0B
	for <netdev@vger.kernel.org>; Tue, 20 Jan 2026 08:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768898555; cv=none; b=JzHPX1QUcRsErWdiwRyUa1d1qwn45FYFFVlX9kLqkxqmQzgEJ/iUrXgQEmyKG8RV35VZSv5trV5EZDqNWbDEeSsOZQoCjG9+zRypylL5gRW2FPwHAwIr9y4LHiKYDakEeucBTg2Q7FpCONgftzkZAxeV+JUxH48NqJk0Wa33vmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768898555; c=relaxed/simple;
	bh=GcURrIEm9qc4C4FHh8U13XmSp6AYgvTR05dw4sSmpIk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NZXfJkxM3tfpdePfvfcGm7kDYKuJ0FhXvmkNEEWCKqs09xiaTRE/RZPG00euP54pKC/j/YxyGwWkpbiDHw+vxuvsuzWqIIKN0hn2ZlAuQeNeSnucJDKpQK0b0HzkGQglE/GdLSrnxtGnhPYhIEli2cb1MYxSyVOnRDzgVBuiTUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dzQvYKJM; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-655b5094119so746590a12.2
        for <netdev@vger.kernel.org>; Tue, 20 Jan 2026 00:42:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768898551; x=1769503351; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Xxc76MSYJQhrdh5EUR+3rjpNU84KqL6b3u3m7jeyrTQ=;
        b=dzQvYKJMG4W9nfeaVGKCEfykzEwWztd+ELd+N2MfAzYX3mS/0pzYECyk6dmnggk1ho
         JqTyzr7OF5s0mMwEZA2EfePriWtGVqkbdJAmrgIzNakjSsf6VavMkv2VAn86Pf+niHGK
         uqqtagoOodqJz4rP4ddxICEJritmRxtKSfRKOAgxd0pRpuOp6VvbZCKkpBmenoEn7mUR
         QJ7VnK2ujmQCy4XUtmjD+ZdxnqWkHub+9LH1Ff/r9eNUiOedRNpBkhKOe4w71xq1RzNB
         UB9R83thH529msMJNciK8QPKvHTsGSaPWFvpDA3TLBLDAXIjI1VKD7k//p74LGLJjiFC
         LLTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768898551; x=1769503351;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Xxc76MSYJQhrdh5EUR+3rjpNU84KqL6b3u3m7jeyrTQ=;
        b=cYdtVAdcerFkYISuoBVI4pYaW1OslGy2wAWu/5NytHhsqulDkN83GtUXQ9rb9ps47J
         AuDDnOr14RAjKRCot3mvVyol7KoSm0ItWQU38x4hdkA0txfVs6QkW8QCeI4xeAS/ainu
         BbFMf8OWJZRMiJo0VtENYHPGGlf/bAJkvW6L2MnKmJLFxdYiOv+qMrI4vE6aU42Xy+cY
         oY+gpCOf80QEBY+WDxpz90gb5Gbz8UBoR4G1oeq1WaMSQHurcyjRkCkS+fSXsa1PD3R9
         qFEBBJsnF3JhO6wLTY0UniCZLbaKMKWAbtvvAiN1birqzPTKQdpTlU7GZtOMBLeFhdZL
         jBIA==
X-Forwarded-Encrypted: i=1; AJvYcCVh19NHarpsbLcOY8AHUnPR5KUawWixfV+TW9PO/k428suaNcF0nTy6JAfdU/PlJw3TNiqmvpw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNmtWjZcwRhbw88wJvDCRc+ecDj9H3fXblNwJlsxnYbpBt5Yoj
	0xMPLRBJLZ4yC7L2DB4f6aydSkg0ZDdwnCuDW2D720k8TQAcchPsyuBi
X-Gm-Gg: AZuq6aKJSYk0AMHQ49wfHTqEjqqcrqZDeQ7ySmipHzd0ZSOxDK9x0ttTJ52Ao4evDAB
	Sx1E47RE9M3DXcHBScBd9YshXToGGfHfHyE2T5PrZAGl/9Ie8HWZD5F9YSoRiMsjmEUD2nzXAZ5
	Ep6pCPvTEhWarREVyqNZ0QNOZg9+bVJGyS4Cmyo76hK3ELRd78BnIgGgEwix5D5yZa2WLjXXudu
	UknFrXtgKP41y25f23H8fUPfe/GEISv7vfbsPKpZ58gxBSgegayXE+jwpehU8qjo9rI4bxnsY77
	I78FpXRwx7jyeRRcFq1Pwbt8fx7el97w2qCYUXd98kuF6fy4qMZU67Z5fPbr7ToIrJufwxwgi0z
	nIjyOGPm52YGUJjURCP+RpVboJkZFMB4MUq9RLwGPF2MOivgVuEUdgBzSKJpEAl//3ioC9Tkqqa
	A5eDc=
X-Received: by 2002:a05:6402:348d:b0:64c:9e19:982d with SMTP id 4fb4d7f45d1cf-654523cc85bmr6267784a12.1.1768898550768;
        Tue, 20 Jan 2026 00:42:30 -0800 (PST)
Received: from skbuf ([2a02:2f04:d501:d900:619a:24df:1726:f869])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b879513e72asm1348612966b.11.2026.01.20.00.42.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jan 2026 00:42:30 -0800 (PST)
Date: Tue, 20 Jan 2026 10:42:27 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Jakub Kicinski <kuba@kernel.org>, linux-phy@lists.infradead.org,
	davem@davemloft.net, maxime.chevallier@bootlin.com,
	alexandre.torgue@foss.st.com, mohd.anwar@oss.qualcomm.com,
	neil.armstrong@linaro.org, hkallweit1@gmail.com,
	mcoquelin.stm32@gmail.com, netdev@vger.kernel.org,
	edumazet@google.com, linux-arm-msm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, vkoul@kernel.org,
	andrew@lunn.ch, pabeni@redhat.com, andrew+netdev@lunn.ch,
	linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [net-next,05/14] net: stmmac: add stmmac core serdes support
Message-ID: <20260120084227.j2wgbmjsrpmycpgn@skbuf>
References: <E1vhoSH-00000005H1f-2cq9@rmk-PC.armlinux.org.uk>
 <20260119192125.1245102-1-kuba@kernel.org>
 <aW8M9ZiiftGBQIRM@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aW8M9ZiiftGBQIRM@shell.armlinux.org.uk>

On Tue, Jan 20, 2026 at 05:04:53AM +0000, Russell King (Oracle) wrote:
> On Mon, Jan 19, 2026 at 11:21:25AM -0800, Jakub Kicinski wrote:
> > This is an AI-generated review of your patch. The human sending this
> > email has considered the AI review valid, or at least plausible.
> > 
> > For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-local.html
> > ---
> > net: stmmac: add stmmac core serdes support
> > 
> > This commit adds SerDes PHY support to the stmmac core driver, moving it
> > from platform glue into the integrated PCS driver. The SerDes is managed
> > through phy_init/phy_exit for lifecycle and phy_power_on/phy_power_off
> > for the power state.
> > 
> > > diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_pcs.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_pcs.c
> > > index 2f826fe7229b..4d1902f3a58f 100644
> > > --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_pcs.c
> > > +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_pcs.c
> > 
> > [ ... ]
> > 
> > > static int dwmac_integrated_pcs_enable(struct phylink_pcs *pcs)
> > > {
> > > 	struct stmmac_pcs *spcs = phylink_pcs_to_stmmac_pcs(pcs);
> > > +	struct stmmac_priv *priv = spcs->priv;
> > > +	int ret;
> > >
> > > -	stmmac_mac_irq_modify(spcs->priv, 0, spcs->int_mask);
> > > +	ret = dwmac_serdes_power_on(priv);
> > > +	if (ret)
> > > +		return ret;
> > > +
> > > +	if (spcs->interface != PHY_INTERFACE_MODE_NA) {
> > > +		ret = dwmac_serdes_set_mode(priv, spcs->interface);
> > > +		if (ret)
> > > +			return ret;
> >                         ^^^^^^^^^^
> > 
> > If dwmac_serdes_set_mode() fails here, doesn't this leave the SerDes in
> > a powered-on state? dwmac_serdes_power_on() succeeded at this point but
> > there's no corresponding dwmac_serdes_power_off() call before returning
> > the error.
> > 
> > Looking at phylink_major_config(), it appears to discard the return
> > value from phylink_pcs_enable(), so the caller won't know to call
> > pcs_disable() to clean up the power state.
> 
> This AI analysis is incorrect.
> 
> By the time phylink_pcs_enable() has been called, the PCS is already
> plumbed in to phylink. It _will_ have phylink_pcs_disable() called on
> it at some point in the future, either by having the PCS displaced
> by another in a subsequent phylink_major_config(), or by a driver
> calling phylink_stop().
> 
> If we clean up here, then we will call dwmac_serdes_power_off() twice.
> 
> Yes, it's not "nice" but that's the way phylink is right now, and
> without reworking phylink to record that pcs_enable() has failed
> to avoid a subsequent pcs_disable(), and to stop the major config
> (which then potentially causes a whole bunch of other issues). I
> don't even want to think about that horrid scenario at the moment.

More to the point, if dwmac_integrated_pcs_enable() fails at
dwmac_serdes_power_on() (thus, the SerDes is _not_ powered on), by your
own admission of this PCS calling convention, sooner or later
dwmac_integrated_pcs_disable() -> dwmac_serdes_power_off() will still be
called, leading to a negative phy->power_count.

That is to say, if the model is "irrespective of whether pcs_enable()
succeeds or fails mid way, pcs_disable is called anyway()", then these
methods are not prepared to handle that reliably.

