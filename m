Return-Path: <netdev+bounces-203930-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 20363AF8222
	for <lists+netdev@lfdr.de>; Thu,  3 Jul 2025 22:50:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A340D1C85A44
	for <lists+netdev@lfdr.de>; Thu,  3 Jul 2025 20:50:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EAC12BCF7B;
	Thu,  3 Jul 2025 20:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="4Qr61vG/"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34647298CB6;
	Thu,  3 Jul 2025 20:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751575810; cv=none; b=YuWCx821D4jc9/uPcaI0Kj1PP5O2Vs8UG5fLCPE8CTW8oVGadexo6RePvVzPcLmeoRc3i2DXtUTlQgfVZ4aIhxNEKv6oHsIcbugx88CQC+/WuSbVOXBmgtCPHJGOjpYDGF2MbaVm93pwk50f5r9OYvXSrByTvGocNSY2e/7aQDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751575810; c=relaxed/simple;
	bh=4o9iyxz5qR0fTPYep1v4H9rotKmvSnUzoM9c/reZWbU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ANkbKj+4fm2jB//wBPuH0Bl74rp/Ct5YnpsrrSQsG+IAM8M0ojm+aHaQjggBXaHeLIc36v8D040a/bmwWAjH4Jy8+9aQmD81SiUiGC1YIE2lh+1iQWsQkL/PcK1xy3QyzhwArqSrvhiW5NcFf/TU3ulWzErWvRN1Lt2lqnADIbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=4Qr61vG/; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=nqaZgCdbl/q/xizW75aQsdYUUQjV4Mg7xA5lLYJ8o6c=; b=4Qr61vG/g+shXKVtMgfiuyOAeN
	HAaMOXpezrWOqHeyHZ7vZehfCbHLSez/OJkQ4dP7iYnkWcD7ZW34i3GRl3/e3xdA9QbJGLVSk/VLu
	Fxn2s+Ss6PCeSASugY0GR5rYr+5wnKWhVjvo8jimDuCZsblizkc8ijZFKzrAWEJf0L/Y=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uXQsY-0008IF-Vp; Thu, 03 Jul 2025 22:49:58 +0200
Date: Thu, 3 Jul 2025 22:49:58 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Asmaa Mnebhi <asmaa@nvidia.com>
Cc: "davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	David Thompson <davthompson@nvidia.com>
Subject: Re: [PATCH net v1] mlxbf-gige: Support workaround for MDIO GPIO
 degradation bug
Message-ID: <3251e228-8ca5-4e33-be90-5e262c47722e@lunn.ch>
References: <20241122224829.457786-1-asmaa@nvidia.com>
 <7c7e94dc-a87f-425b-b833-32e618497cf8@lunn.ch>
 <CH3PR12MB7738C758D2A87A9263414AFBD78BA@CH3PR12MB7738.namprd12.prod.outlook.com>
 <6e3435a0-b04e-44cc-9e9d-981a8e9c3165@lunn.ch>
 <CH3PR12MB7738C25C6403C3C29538DA4BD78BA@CH3PR12MB7738.namprd12.prod.outlook.com>
 <CH3PR12MB773870BA2AA47223FF9A72D7D745A@CH3PR12MB7738.namprd12.prod.outlook.com>
 <668cd20c-3863-4d16-ab05-30399e4449f6@lunn.ch>
 <CH3PR12MB7738E1776CD326A2566254D5D740A@CH3PR12MB7738.namprd12.prod.outlook.com>
 <c6f5da79-df83-4fad-9bfc-6fd45940d10f@lunn.ch>
 <CH3PR12MB7738A206A5EFCD81318DC463D743A@CH3PR12MB7738.namprd12.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CH3PR12MB7738A206A5EFCD81318DC463D743A@CH3PR12MB7738.namprd12.prod.outlook.com>

On Thu, Jul 03, 2025 at 06:51:52PM +0000, Asmaa Mnebhi wrote:
>  > > > You need to put the MDIO bus device into its own pm_domain. Try
> > > > calling dev_pm_domain_set() to separate the MDIO bus from the MAC
> > > > driver in terms of power domains. ethtool will then power on/off the
> > > > MAC but leave the MDIO bus alone.
> > > >
> > 
> > > Using dev_pm_domain_set() has the same effect as
> > SET_RUNTIME_PM_OPS. The dev struct is shared so ethtool is still calling the
> > suspend/resume.
> > >
> > > int mlxbf_gige_mdio_probe(struct platform_device *pdev, struct
> > > mlxbf_gige *priv)  {
> > >         struct device *dev = &pdev->dev; @@ -390,14 +418,27 @@ int
> > > mlxbf_gige_mdio_probe(struct platform_device *pdev, struct mlxbf_gige
> > *priv)
> > >         snprintf(priv->mdiobus->id, MII_BUS_ID_SIZE, "%s",
> > >                  dev_name(dev));
> > >
> > > +       pm_runtime_set_autosuspend_delay(priv->mdiobus->parent, 100);
> > > +       pm_runtime_use_autosuspend(priv->mdiobus->parent);
> > 
> > Why parent?
> 
> That was just an experiment. I tried priv->dev, same result but I guess that is expected because it is the MAC dev. priv->mdiobus->dev is only set in mdiobus_register which:
> - sets dev struct and calls device_register
> - device_register calls device_pm_init and device_add
> - device_add calls device_pm_add
> - device_pm_check_callbacks sets dev->power.no_pm_callbacks based on if pm_domain/pm_ops were defined or not.
> 
> So I have to call dev_pm_domain_set before mdiobus_register for it to be registered properly. But then, priv->mdiobus->dev is not set up yet so we cannot call dev_pm_domain_set.

You are the first needing this, so i'm not surprised. Please look at
how priv->mdiobus->dev can be made to work. Maybe the
device_register() needs moving into mdiobus_alloc_size()?

	Andrew

