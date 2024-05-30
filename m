Return-Path: <netdev+bounces-99439-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B8B628D4E15
	for <lists+netdev@lfdr.de>; Thu, 30 May 2024 16:35:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 73DD8282788
	for <lists+netdev@lfdr.de>; Thu, 30 May 2024 14:35:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E08017C202;
	Thu, 30 May 2024 14:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P5/GsT9P"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE26B1E4AD;
	Thu, 30 May 2024 14:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717079729; cv=none; b=iPNlkV9ZBQRTQ+b5xs+P1DLuZ6B2eJChdD3z9ITxovaB7ER9IJVjE2/8FkUuyW91yvdtC2LppghVTWjOLAHQNYsyByzHt65d+Dk9VngD/SWdart6IIRy7r5C9JG4VTKqQ1dzsPuXkciH5CisEXLpXBLugtgxBJnO7kY92EjdTuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717079729; c=relaxed/simple;
	bh=9sWgSQa6TgS8KLWUQBeccq3Rfa7bq3zza/P8Pb2pEJA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XY0lScDfAxYzsrc87MaRDW+s33UOT7UFq/Qula4HJhrJVTmm+dYQctAFFlznSQW0lUvAz7IEKaphkg5Qyayug7UUTpJtLCmd6iMg4wZ7RIkIFq1fKd9ARK1LTVPH/iDrQ/BTQM6+tJ/4zuWSzciVsalebIRKEhok8qTgvaciXzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P5/GsT9P; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4202ca70318so9909595e9.1;
        Thu, 30 May 2024 07:35:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717079726; x=1717684526; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WYTiFuR4DPSHFGqvlJB8DMX9Y1O9jK1V/mJHl1kS0Pc=;
        b=P5/GsT9Pdf9csYeNfyfjcfXydEfEbHCfZAXVaKckA2trO5VAxWd6z28HtgQpB4O/nf
         sFeiMVL6UdUEzQHrzfT6VRXDUCgOtzxi06m5wuk8Hz4Qiwfek5yn8UVANZcftR4bWlCI
         SbuHeG3V4bYyEeRf1KbmDYc9/c6t5YkdhK31y7sdl6emGoXz4I7+jdTfkwSQbuqgvSaX
         grFhGAEkqEjrTlkddb9H6ukZKtzDusZDvRdH/btRGKKR8Ax4zGwM6rsDAzCR7owzVbWX
         lBUrB+zZQmISJygosh84qv6V7SEYP1yx1XnfY4MrIOHk6jmAypef0Ha5f1Q8dns3AGsS
         EpHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717079726; x=1717684526;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WYTiFuR4DPSHFGqvlJB8DMX9Y1O9jK1V/mJHl1kS0Pc=;
        b=CWNL6QyZXg7K721r1kP0yPg+/bq7O0L5fsThBXV9dLaYP+Jc4KyU3yqIe7A6FC5LQb
         zdwpBnGi4e3Jg2pASDC4fQybbPuqVd5mbdB68orAB58rAXhrKzg2qonXYqk3jA68EJYL
         I5/qfW9E8HL5wTB1TxLOTWR7eHgWQa7MtkWIkrhXqF35n+UDVDqPXGZDf7FkaTnL10tV
         zmA1zb6zl/PAkPWMklr6HIW6vtNVqyNb9wJ6XprdPv+WyqA5e/GQ3u8oFLD14gMciHGU
         BS8VU+3i3OKQfE5SekI6dcy0FRYP7iiURpBZKu4VNJ7L8JUWUOHpqGASiw2S59MlWRhe
         ToZg==
X-Forwarded-Encrypted: i=1; AJvYcCV/tlTfaRJBOX8+BSLP5yFc9jfhqHkHnSp2S+dTZrb0GjBCuH4inBgzbmj26KznAbZ5TpFWDr8LDmQWEc9MsVXPTeYPPLbRB7167PGxBFjJnuMH+fljNSkGgAaTkt7yuRQK3BBg
X-Gm-Message-State: AOJu0Ywdp7F1ZZSS+fTPO/uX8PsEa9XLI/Iji2Y69i9J2IOB8fRQiNSP
	cRpu+42QJlXMV8A98grl44fxleR/EEExi+naJwdVNNtdqTr6j8+F
X-Google-Smtp-Source: AGHT+IGaY+/PZA5mIGZDeKr/VUQRACFvFwkdzFPSepCWD2Pnl6K5q1TGTKBDO+05lApmOK2QjvmQQw==
X-Received: by 2002:a05:600c:4fc2:b0:41b:fea6:6526 with SMTP id 5b1f17b1804b1-4212792f6aemr22848325e9.33.1717079725585;
        Thu, 30 May 2024 07:35:25 -0700 (PDT)
Received: from skbuf ([188.25.55.166])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42127062f0dsm26826995e9.17.2024.05.30.07.35.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 May 2024 07:35:24 -0700 (PDT)
Date: Thu, 30 May 2024 17:35:22 +0300
From: Vladimir Oltean <olteanv@gmail.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Xiaolei Wang <xiaolei.wang@windriver.com>, Andrew Lunn <andrew@lunn.ch>,
	alexandre.torgue@foss.st.com, joabreu@synopsys.com,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, mcoquelin.stm32@gmail.com,
	netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [net v2 PATCH] net: stmmac: Update CBS parameters when speed
 changes after linking up
Message-ID: <20240530143522.32c5lhkg42yiggob@skbuf>
References: <20240530061453.561708-1-xiaolei.wang@windriver.com>
 <f8b0843f-7900-4ad0-9e70-c16175e893d9@lunn.ch>
 <20240530132822.xv23at32wj73hzfj@skbuf>
 <ZliBzo7eETml/+bl@shell.armlinux.org.uk>
 <20240530135335.yanffjb3ketmoo7u@skbuf>
 <ZliJ2O+bj18jQ0B8@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZliJ2O+bj18jQ0B8@shell.armlinux.org.uk>

On Thu, May 30, 2024 at 03:14:48PM +0100, Russell King (Oracle) wrote:
> > I don't see why the CBS parameters would need to be de-programmed from
> > hardware on a link down event. Is that some stmmac specific thing?
> 
> If the driver is having to do computation on the parameters based on
> the link speed, then when the link speed changes, the parameters
> no longer match what the kernel _thinks_ those parameters were
> programmed with.
> 
> What I'm trying to get over to you is that what you propose causes
> an inconsistency between how the hardware is _programmed_ to behave
> for CBS and what the kernel reports the CBS settings are if the
> link speed changes.
> 
> It's all very well saying that userspace should basically reconstruct
> the tc settings when the link changes, but not everyone is aware of
> that. I'm saying it's a problem if one isn't aware of this issue with
> this hardware, and one looks at tc qdisc show output, and assumes
> that reflects what is actually being used when it isn't.
> 
> It's quality of implmentation - as far as I'm concerned, the kernel
> should *not* mislead the user like this.

I was saying that the tc-cbs parameters input into the kernel should
already have the link speed baked into them:
portTransmitRate = idleSlope - sendSlope. In theory one could feed any
data into the kernel, but this is based on the IEEE 802.1Q formulas.

I had missed the fact that there is a calculation dependent on
priv->speed within tc_setup_cbs(), and I'm sorry for that. I thought
that the values were passed unaltered down to stmmac_config_cbs(). So
"make no change to the driver" is no longer my recommendation.

In that case, my recommendation is to do as sja1105_setup_tc_cbs() does:
replace priv->speed with the portTransmitRate recovered from the tc-cbs
parameters, and fully expect that when the link speed changes, user
space comes along and changes those parameters.

