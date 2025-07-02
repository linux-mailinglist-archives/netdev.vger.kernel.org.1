Return-Path: <netdev+bounces-203515-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C10E1AF63F2
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 23:27:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F14E01C4487E
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 21:27:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EB3223C51A;
	Wed,  2 Jul 2025 21:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="4bL5LqjS"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7A111E5B72;
	Wed,  2 Jul 2025 21:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751491618; cv=none; b=Wjrg7pTtkLy5myGbQhzDHi0UuFr1HDsDLj9yBkmcCh6N+sv7smVnLQwQ5+Gj73RxEzypKTl6eozP6dGsFuY+a7jxLsAJYjeOirYsoRfSsr8L7wn30BlCo2ASDBrOeSyhdxNHV4ncurCBkfK0nQ1kKviXDcik3oRlHtALgvTU6EQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751491618; c=relaxed/simple;
	bh=ubcv531A0W3+7BMeK8QdrJzgPyyaklfbDSiVf1ogieE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jep5OKJxAk63q6ott4yQU1h19XutfdyjsLHJu1DWrVj1rb9bupM0++o/HJ46+f2+gnGq/+StrXN3PwucygL/r71gGfIrOInm3Z24Reg1SKOs4csFTO6ls9t+eUx6Hr4flL6osTqT+FoGVBdHF2cUGgn3agdwRDm2qOPgRlWt7n8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=4bL5LqjS; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=EK6pIKbSgIOibKMxhtf9EOr2/NgmGGS9epSF1C9VniQ=; b=4bL5LqjSsgWMCbBqSjnGEGV7iY
	j3L6/kjnWRfCLzShW/KjAmhrMoyp0Ob4TpTZx5HnK5We9FgcjmLWEqOBFraZZ980EqpmfQDRhB6cT
	7IT6PGXWPRFDBcjg5hjX8uBDJ/WGl9qQtYGxzKeBqNf/xS7Z+5utX4Gz4uHfuqTRVOws=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uX4yY-0001kh-LA; Wed, 02 Jul 2025 23:26:42 +0200
Date: Wed, 2 Jul 2025 23:26:42 +0200
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
Message-ID: <c6f5da79-df83-4fad-9bfc-6fd45940d10f@lunn.ch>
References: <20241122224829.457786-1-asmaa@nvidia.com>
 <7c7e94dc-a87f-425b-b833-32e618497cf8@lunn.ch>
 <CH3PR12MB7738C758D2A87A9263414AFBD78BA@CH3PR12MB7738.namprd12.prod.outlook.com>
 <6e3435a0-b04e-44cc-9e9d-981a8e9c3165@lunn.ch>
 <CH3PR12MB7738C25C6403C3C29538DA4BD78BA@CH3PR12MB7738.namprd12.prod.outlook.com>
 <CH3PR12MB773870BA2AA47223FF9A72D7D745A@CH3PR12MB7738.namprd12.prod.outlook.com>
 <668cd20c-3863-4d16-ab05-30399e4449f6@lunn.ch>
 <CH3PR12MB7738E1776CD326A2566254D5D740A@CH3PR12MB7738.namprd12.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CH3PR12MB7738E1776CD326A2566254D5D740A@CH3PR12MB7738.namprd12.prod.outlook.com>

> > You need to put the MDIO bus device into its own pm_domain. Try
> > calling dev_pm_domain_set() to separate the MDIO bus from the MAC
> > driver in terms of power domains. ethtool will then power on/off the
> > MAC but leave the MDIO bus alone.
> > 

> Using dev_pm_domain_set() has the same effect as SET_RUNTIME_PM_OPS. The dev struct is shared so ethtool is still calling the suspend/resume.
> 
> int mlxbf_gige_mdio_probe(struct platform_device *pdev, struct mlxbf_gige *priv)
>  {
>         struct device *dev = &pdev->dev;
> @@ -390,14 +418,27 @@ int mlxbf_gige_mdio_probe(struct platform_device *pdev, struct mlxbf_gige *priv)
>         snprintf(priv->mdiobus->id, MII_BUS_ID_SIZE, "%s",
>                  dev_name(dev));
> 
> +       pm_runtime_set_autosuspend_delay(priv->mdiobus->parent, 100);
> +       pm_runtime_use_autosuspend(priv->mdiobus->parent);

Why parent?

	Andrew

