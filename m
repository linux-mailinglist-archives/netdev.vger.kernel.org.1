Return-Path: <netdev+bounces-99456-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E9DC8D4F5D
	for <lists+netdev@lfdr.de>; Thu, 30 May 2024 17:46:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CE550B28A09
	for <lists+netdev@lfdr.de>; Thu, 30 May 2024 15:46:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A0131CA9E;
	Thu, 30 May 2024 15:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g/Ikush+"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C9CE187560;
	Thu, 30 May 2024 15:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717083956; cv=none; b=jwiIl//HZKcT/kr/taQzG+khjlRk5G50igmBGs8GUZgGyvc/Isn3DSBVvfPF6hacpQ30167XUzFm1Zcfu/B8cvwqMyHAl5Z6aZDnxkv7usr6XOi7FUS95AjJYBosKbjTEZdYYy0eCTKNOqrcl4yM6OoginuKvykDUIlm/7tBB40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717083956; c=relaxed/simple;
	bh=xsSwkUyeq1nQUoOErCP//MKePEhkvAUWLNfLc8T0PRw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HPx4vRN39F2LG4pfLZtXlDndzaBT6TJCIceiuGETyvSlKJhEv8Iioqr+ySD8QKsnB9D3wT8AYg/egsxBVJD7o6Dng9x+mSyNTOOGdZ+1LHqIEg+AvR1ssHlkUTk+C2cwKcmwUlwaP5miFZQj3ou8j9Pru4LED74HcdBWuuiFbRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g/Ikush+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CF86C2BBFC;
	Thu, 30 May 2024 15:45:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717083955;
	bh=xsSwkUyeq1nQUoOErCP//MKePEhkvAUWLNfLc8T0PRw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=g/Ikush+zKUa+GCP1lDlqOhGaISQyGEezWdeyn+6j6UKyGFNaaIaYmbbmgZC88olM
	 bJG4nSfy2bqJx0grAwCh5Za1T3WD32v9xk6kqUpoapslpcBeTpmS18b9YLp0nZr9/A
	 f/uaKuq5jn2kNfRwdMx031VfiPZNl3onKb6Lo+cHtUu0XaBElTYV3oV1p0h9Z3uBu/
	 6GBHJHaobWD6HIjTVD0ZnyfA6t0DMgezZJBeYJc7z/9RIy9QbTIStbC0eXH+YH/VDx
	 bWGOix8Gcz19Pcs6ffRplr7yqvow1VCaMQ3rPhtPHtzAJIsIC5jBoc48bYDFrb7+CZ
	 p+gaToO+g2Ylg==
Date: Thu, 30 May 2024 08:45:53 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Kory Maincent <kory.maincent@bootlin.com>
Cc: Sai Krishna Gajula <saikrishnag@marvell.com>, Florian Fainelli
 <florian.fainelli@broadcom.com>, Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, Andrew Lunn <andrew@lunn.ch>,
 Heiner Kallweit <hkallweit1@gmail.com>, Russell King
 <linux@armlinux.org.uk>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Richard
 Cochran <richardcochran@gmail.com>, Radu Pirea
 <radu-nicolae.pirea@oss.nxp.com>, Jay Vosburgh <j.vosburgh@gmail.com>, Andy
 Gospodarek <andy@greyhouse.net>, Nicolas Ferre
 <nicolas.ferre@microchip.com>, Claudiu Beznea <claudiu.beznea@tuxon.dev>,
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Jonathan Corbet
 <corbet@lwn.net>, Horatiu Vultur <horatiu.vultur@microchip.com>,
 "UNGLinuxDriver@microchip.com" <UNGLinuxDriver@microchip.com>, Simon Horman
 <horms@kernel.org>, Vladimir Oltean <vladimir.oltean@nxp.com>, Thomas
 Petazzoni <thomas.petazzoni@bootlin.com>, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "linux-doc@vger.kernel.org"
 <linux-doc@vger.kernel.org>, Maxime Chevallier
 <maxime.chevallier@bootlin.com>, Rahul Rameshbabu <rrameshbabu@nvidia.com>
Subject: Re:  [PATCH net-next v13 12/14] net: ptp: Move ptp_clock_index() to
 builtin symbol
Message-ID: <20240530084553.5e437938@kernel.org>
In-Reply-To: <20240530145350.6341746f@kmaincent-XPS-13-7390>
References: <20240529-feature_ptp_netnext-v13-0-6eda4d40fa4f@bootlin.com>
	<20240529-feature_ptp_netnext-v13-12-6eda4d40fa4f@bootlin.com>
	<BY3PR18MB47074528CBB38F55A3F58A19A0F32@BY3PR18MB4707.namprd18.prod.outlook.com>
	<20240530145350.6341746f@kmaincent-XPS-13-7390>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 30 May 2024 14:53:50 +0200 Kory Maincent wrote:
> > Please check the "build_clang - FAILED", "build_32bit - FAILED" build errors.  
> 
> Could you be more explicit? Which config are you using?
> What is the build error?
> 
> I don't really see how this patch can bring a 32bit or clang build error. 

Must be the same build problem I reported.

