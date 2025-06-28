Return-Path: <netdev+bounces-202130-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 06A16AEC5DC
	for <lists+netdev@lfdr.de>; Sat, 28 Jun 2025 10:40:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED5B06E2779
	for <lists+netdev@lfdr.de>; Sat, 28 Jun 2025 08:39:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9DB0221D96;
	Sat, 28 Jun 2025 08:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="A9DBfYVV"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BC69288A0;
	Sat, 28 Jun 2025 08:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751100013; cv=none; b=bvggUFyO1rZmeOJ5LkoiJJpr4AIdeLpdZC5zYtZswCm+iIOAFD1BQnSWruLSZQXu/4uYv/KgNc6tX+EBx3/WdloThJ+4G64IUW8sSCVrBUtoXKGbpG32kZUal6SoY/6Rcwa4cOZKnTI0VvP424U0xFLcORUgNfTbZ3fFGqxqCv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751100013; c=relaxed/simple;
	bh=seYJ+h3ptgXyrs/Ol/cIp8Sn6+8xe6POhQhfvKZYpOo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CJyCCa0E561WIF7UmK0QP/MH8+OVFWzwygEsMOwFJz3373MPvrv29i/D1VHlgarxV/mphnwXdCeldnNoo0Cg0ed7bxEeFchHjf4GUgfUSicXMln3GDucR6A6GQEXk14umQHA1DrOj990y9XWkIUwi7AyBB/epcDCuOLIL/oHzu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=A9DBfYVV; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=KsixbDkdM3PEAz+rUYpeXnOwGsmmR9wNcvEDjtbPvJw=; b=A9DBfYVVRHTLvgbeQmK9fE6SPw
	qEdD2qnstz1flvG5tClmk9Q28P2ngpbiJ1BQfWL1C/+ZLkS7usvsl4tpNCsbYhwEwEduA6PyyhXpV
	D8aeBiWRmd58poQrfWsI3D+8XRo+L6ZX9Jc1z1+kD8x/I3EvKYVeYa2bCMT76L7dapjU=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uVR6Q-00HDxH-Uj; Sat, 28 Jun 2025 10:40:02 +0200
Date: Sat, 28 Jun 2025 10:40:02 +0200
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
Message-ID: <668cd20c-3863-4d16-ab05-30399e4449f6@lunn.ch>
References: <20241122224829.457786-1-asmaa@nvidia.com>
 <7c7e94dc-a87f-425b-b833-32e618497cf8@lunn.ch>
 <CH3PR12MB7738C758D2A87A9263414AFBD78BA@CH3PR12MB7738.namprd12.prod.outlook.com>
 <6e3435a0-b04e-44cc-9e9d-981a8e9c3165@lunn.ch>
 <CH3PR12MB7738C25C6403C3C29538DA4BD78BA@CH3PR12MB7738.namprd12.prod.outlook.com>
 <CH3PR12MB773870BA2AA47223FF9A72D7D745A@CH3PR12MB7738.namprd12.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CH3PR12MB773870BA2AA47223FF9A72D7D745A@CH3PR12MB7738.namprd12.prod.outlook.com>

> Hi Andrew, 
> 

> I implemented and tested the changes you suggested and the
> runtime_resume/suspend work smoothly for MDIO.

> However, we have another issue. I noticed that even if
> mdio_read/write() functions are not being called,
> runtime_resume/suspend() are still called regularly. After
> investigation, I found out that this is due to ethtool being called
> regularly. Ethtool automatically triggers the resume/suspend even if
> we do no MDIO access. A different team wrote a script which monitors
> "ethtool -S eth0" every 60 seconds. So every minute, we are running
> resume/suspend and enabling/disabling the MDIO clock. Seems counter
> productive. That team said that it is a requirement that they
> collect these statistics about the mlxbf_gige interface.

> Is there any way to prevent ethtool from calling resume/suspend
> without changing core kernel code?

> If not, what would you suggest? 

You need to put the MDIO bus device into its own pm_domain. Try
calling dev_pm_domain_set() to separate the MDIO bus from the MAC
driver in terms of power domains. ethtool will then power on/off the
MAC but leave the MDIO bus alone.

	Andrew

