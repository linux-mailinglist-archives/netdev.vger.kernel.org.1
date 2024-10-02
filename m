Return-Path: <netdev+bounces-131408-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CBE3498E767
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 01:52:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 12B9F1C24EA9
	for <lists+netdev@lfdr.de>; Wed,  2 Oct 2024 23:52:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2510119EEA1;
	Wed,  2 Oct 2024 23:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="2OhI591Q"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EF71199249;
	Wed,  2 Oct 2024 23:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727913154; cv=none; b=bPAiftgTpA/nF9wWAGgv0LgKhWByT7hZR/0fzmlXj9emWvu/ctvsBdsZA26Dk/wcRK1xB45pqSsmW/O75vgtfwujKGs8tLQ1JvVV9N75sRSwhVlBbkn3rDl+3UPe/TuQnhb0BBRCvjrI2xUMqcKWNHrye2FPH6hlMcgYLxZuvVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727913154; c=relaxed/simple;
	bh=IBROIkb5Ew3LqAFJ1cdUoDl2TdyQHPz7txpzC1EHsQg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gn2derCSP39V7zMtgC0s7x3+WtfI7vsesKFHuSIhOzp2odPGeHfqWMOt6DKnjWVbyFpbGo3rWxV80d2xNqBPbarD8mSklUpdKhjmze8+4elMF76reoTaCWJf+wGeiTcz8IN9C1al57XhMUdiLjB+4RZDtcQARLHmVfgxpY5gJn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=2OhI591Q; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=sHbh2EfhKti6ujjbBEFCRGLNM3yJFTi2GCxJ5mg4DtY=; b=2OhI591Q831KErF1StUB9STYpa
	EGnajy5dMH0OmbUfPqzA/V0IuA4Wn9JPlabGgnvYWAluyDd8HB298xHyafuyGViC4xDFUjQKmqVqG
	Ba6pE3j4zyMnYtSLfiHGrt+NxBOTnFPqsjID84D2Rwm/y1qJtugLDAx18OMQ5C8dIYyI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sw98m-008uGe-Q6; Thu, 03 Oct 2024 01:52:20 +0200
Date: Thu, 3 Oct 2024 01:52:20 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Kory Maincent <kory.maincent@bootlin.com>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Donald Hunter <donald.hunter@gmail.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	linux-doc@vger.kernel.org, Kyle Swenson <kyle.swenson@est.tech>,
	Dent Project <dentproject@linuxfoundation.org>,
	kernel@pengutronix.de
Subject: Re: [PATCH net-next 11/12] net: pse-pd: Add support for event
 reporting using devm_regulator_irq_helper
Message-ID: <f56780af-b2d4-42d7-bc5d-c35b295d7c52@lunn.ch>
References: <20241002-feature_poe_port_prio-v1-0-787054f74ed5@bootlin.com>
 <20241002-feature_poe_port_prio-v1-11-787054f74ed5@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241002-feature_poe_port_prio-v1-11-787054f74ed5@bootlin.com>

> +int devm_pse_irq_helper(struct pse_controller_dev *pcdev, int irq,
> +			int irq_flags, int supported_errs,
> +			const struct pse_irq_desc *d)
> +{
> +	struct regulator_dev **rdevs;
> +	void *irq_helper;
> +	int i;
> +
> +	rdevs = devm_kcalloc(pcdev->dev, pcdev->nr_lines,
> +			     sizeof(struct regulator_dev *), GFP_KERNEL);
> +	if (!rdevs)
> +		return -ENOMEM;
> +
> +	for (i = 0; i < pcdev->nr_lines; i++)
> +		rdevs[i] = pcdev->pi[i].rdev;
> +
> +	/* Register notifiers - can fail if IRQ is not given */
> +	irq_helper = devm_regulator_irq_helper(pcdev->dev, d, irq,
> +					       0, supported_errs, NULL,
> +					       &rdevs[0], pcdev->nr_lines);

Should irq_flags be passed through? I'm guessing one usage of it will
be IRQF_SHARED when there is one interrupt shared by a number of
controllers.

	Andrew

