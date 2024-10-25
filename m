Return-Path: <netdev+bounces-139078-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 90F8C9B00BD
	for <lists+netdev@lfdr.de>; Fri, 25 Oct 2024 13:01:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B37281C22903
	for <lists+netdev@lfdr.de>; Fri, 25 Oct 2024 11:01:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DB881AE006;
	Fri, 25 Oct 2024 11:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jlKfz4sk"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40CB422B66D;
	Fri, 25 Oct 2024 11:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729854100; cv=none; b=oxsj2TwEtIq+aOHplk8AQgRZeTuPHM1GJlaVl/RfOfF+6TZfKangeOwiCCO/jD0sJo/FPWchfct/o1yRzJHgGPWZj/Pc4LIsNqGjCOBPtx4kVi7RgcjenrIwyJJ297rRCAiNx3KmevHoPyUKoRCEW/UNiFABzuQBIiiONlkHODg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729854100; c=relaxed/simple;
	bh=EpHGxI23HwWs0Hol513n9znHEe1tbFyOOGZIsqP4KqA=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CXKk0bOdQuWMxxWQhMxZNYF0T1nboVwskK6JRWgkcUfKBpjTWFpwHjzpr5qOjLbL8i03gr2c69trh1VPz5xv6W2zAUH/YqZNe+NiQ2XL1Tg17OCurSJDhEAbudAdYrnB7WLVbmfcoa8sCGUjw4bnVIR/Op2W4UynT5xeCvfIDXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jlKfz4sk; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-431695fa98bso18788505e9.3;
        Fri, 25 Oct 2024 04:01:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729854096; x=1730458896; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=q2MW9dBfGIjPH9ia2UnRa1xMIgs+qL+dRFmTpOXPkFQ=;
        b=jlKfz4skfBrhtKacLDEVybwUDUV76XHOq10r7bK7/75XFEfCF0rY/VTyM0f1FdLCEZ
         ikk7xvjnwKDfVn7Ff2i5/5l/WO7eK1oSoUKS/3ilRibAqRFTKyNBR51EkaIRSdt24LDV
         qVuIx5JyfesutlVsyEvMDz+jiROBz+JQZUzrmummDDz4kMQsHWv8HWGRxdoefLb1QpB5
         7ALuPxjvZXoN6o5gljBcZjIXzc9a1+82xbdpgFdpfSCD0wnBsmbM7wD9tEISqRJYjshE
         T/ngHSNYa4cBtcX782Q0xPPnVZx/5z6+rQAlVX6VmWqwDaRznYGVVNhISRggUfd4FJv9
         +UWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729854096; x=1730458896;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q2MW9dBfGIjPH9ia2UnRa1xMIgs+qL+dRFmTpOXPkFQ=;
        b=R5M1CCWOf5Q39Zb3xczjffjiLEmsm+obOkPwWoP/Lx2W1ie6lH6oC5RVC1IB8XopZA
         TvF4W0NosdoChKb2x7BFIAhLdSAuBF2/uPT1MYwGbQDOmuXgCBJft7h+ohlM0a2DHY01
         Yps0yLDpB1j4aOlwr70WY7PpXt3eVnRVGsE7nvsusDgZf1jUVFXrAADX99b+CH98QL1z
         /F1aBHwjj1h93LJHmRo+zovdPD8fjFKcjrjY3ZMgv2SKMQIm8lfAxSyzYJRLis/hDUlr
         DjT+rZJqtAIt8kGFjBV+ENKs+B/yL0ZOA4IO+nrS1K5XHyXkP/j6WZ+LtPROQydFgZGd
         +/yw==
X-Forwarded-Encrypted: i=1; AJvYcCUWrhPKb5bIC+F/sULoqm0ZjG0bfn3Z+HQ1SazFxZiK7CoZdwUfJNRXpu306su7mNyAV+a1bS6hMpvx@vger.kernel.org, AJvYcCUaBzY1wmVAV8xFYlshzuI9lyJkDOPlL7bE4P0lUJfDOs1IQqonf4dH66+tRf0pjHTWdSA+ZFwSXmLFlqr0@vger.kernel.org, AJvYcCXAvP3D9UiBW8scBR4bBAEFPFAvwQPAEdmvS9QU/zsFReINBesRz19Ur1NkMo+NDLn7RyYi4bCC@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2BIyQAbGksFMvPz7iEyvqhecxsEV4P67euuYreKsjkqW8fUNx
	u+dDjYQXlPdIeDTHgCwpbCnWVZ8K3EzQRtJ2P+X9CnOtcSMn67Et
X-Google-Smtp-Source: AGHT+IFNhA5S7E2asJvPBIxZKjdqjJxeVzeuZAGwlEL6Zq8xq/EZ0pf8rhhnc8extFgzX6L5U64l5g==
X-Received: by 2002:a05:600c:3b9c:b0:42f:7e87:3438 with SMTP id 5b1f17b1804b1-4318beac86fmr46015925e9.0.1729854096266;
        Fri, 25 Oct 2024 04:01:36 -0700 (PDT)
Received: from Ansuel-XPS. (93-34-91-161.ip49.fastwebnet.it. [93.34.91.161])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-431935f744esm14487515e9.34.2024.10.25.04.01.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Oct 2024 04:01:35 -0700 (PDT)
Message-ID: <671b7a8f.050a0220.5b160.446a@mx.google.com>
X-Google-Original-Message-ID: <Zxt6i6Rq3Ylr1jnV@Ansuel-XPS.>
Date: Fri, 25 Oct 2024 13:01:31 +0200
From: Christian Marangi <ansuelsmth@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [net-next RFC PATCH v2 3/3] net: phy: Add Airoha AN8855 Internal
 Switch Gigabit PHY
References: <20241023161958.12056-1-ansuelsmth@gmail.com>
 <20241023161958.12056-4-ansuelsmth@gmail.com>
 <4ad7b2e9-ddf1-4a82-9d60-7afd1856c770@lunn.ch>
 <67192d40.5d0a0220.33f6c1.23bc@mx.google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <67192d40.5d0a0220.33f6c1.23bc@mx.google.com>

On Wed, Oct 23, 2024 at 07:07:08PM +0200, Christian Marangi wrote:
> On Wed, Oct 23, 2024 at 07:00:22PM +0200, Andrew Lunn wrote:
> > > +static int an8855_config_init(struct phy_device *phydev)
> > > +{
> > > +	struct air_an8855_priv *priv = phydev->priv;
> > > +	int ret;
> > > +
> > > +	/* Enable HW auto downshift */
> > > +	ret = phy_write(phydev, AN8855_PHY_PAGE_CTRL, AN8855_PHY_EXT_PAGE);
> > > +	if (ret)
> > > +		return ret;
> > > +	ret = phy_set_bits(phydev, AN8855_PHY_EXT_REG_14,
> > > +			   AN8855_PHY_EN_DOWN_SHFIT);
> > > +	if (ret)
> > > +		return ret;
> > > +	ret = phy_write(phydev, AN8855_PHY_PAGE_CTRL, AN8855_PHY_NORMAL_PAGE);
> > > +	if (ret)
> > > +		return ret;
> > 
> > There are locking issues here, which is why we have the helpers
> > phy_select_page() and phy_restore_page(). The air_en8811h.c gets this
> > right.
> 
> Ugh didn't think about it... The switch address is shared with the PHY
> so yes this is a problem.
> 
> Consider that this page thing comes from my speculation... Not really
> use if 1f select page... 
> From what I observed
> 0x0 PHY page
> 0x1 this strange EXT
> 0x4 acess switch register (every PHY can access the switch)
>

Just to followup on this... I checked air_en8811h registers again and
they match MII access to the switch so yes my speculation is correct.

Also extra happy since I now know what those magic values means at least
for MII.

> > 
> > Is there anything in common with the en8811h? Does it also support
> > downshift? Can its LED code be used here?
> > 
> 
> For some reason part of the LED are controlled by the switch and some
> are by the PHY. I still have to investigate that (not giving priority to
> it... just on my todo)
> 
> For downshift as you notice it's a single bit with no count...
> From their comments in the original driver it's said "Enable HW
> autodownshift"
> 
> Trying to reach them but currently it's all very obscure.
> 
> -- 
> 	Ansuel

-- 
	Ansuel

