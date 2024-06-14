Return-Path: <netdev+bounces-103436-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B85C5908067
	for <lists+netdev@lfdr.de>; Fri, 14 Jun 2024 02:58:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D3AD1C213AC
	for <lists+netdev@lfdr.de>; Fri, 14 Jun 2024 00:58:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73CF319D89C;
	Fri, 14 Jun 2024 00:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hs9w6OOB"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AC504C6C;
	Fri, 14 Jun 2024 00:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718326702; cv=none; b=R2D0isyjyOZnS9iBHaHfZ3Xgg9c9Pa6472j69q1d2lIAdUVLrz6ipQ37QbDvVrHwmwc4kAvsj6EsAEOy7z9URx83fEbksHZGgFQ/8kG4rWF6j9fXrwm5gq8C3CvfC7TUQxA9Grt2oy4aICJxiz5AhUxUEaV6tcdU+D1wt9kXBbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718326702; c=relaxed/simple;
	bh=eZ0oO/hp8jBzO9spY4az2MZLGrlN+qaHba4qll3lrUs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ccrIFyXLfv00EWW+IJHpIyufN7oVnsZKo4JfX6VLFI5amGlmu/NugL3NT6kWeTbhfCMxpOmaOq+hA0GXzjq/xIPe5pfhB9i9lKJD0rSLeUb4sjhrCW8X0lAFWSzj402X6Gq3VYeKkjil23Ckpugm7Mtv5AX01MZtxa0IGpn060s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hs9w6OOB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0A0CC2BBFC;
	Fri, 14 Jun 2024 00:58:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718326701;
	bh=eZ0oO/hp8jBzO9spY4az2MZLGrlN+qaHba4qll3lrUs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=hs9w6OOB31nuIDTpPBfnS9broNlapG+tstyCX+ee6oy/npOlNIkdNH9lkSpfU6ikE
	 jvgeu6r2dSjze+eaGcB4O359HRq5Y1OLbdTjIr9Tsg4kcKHCLHUsmxtV/7Xqe79Na9
	 cHdgSTKbdK0nIs9XWyNL3DhcN/kb5Y66VL7WBLwNQahQ+abi60zzwYHSMLi5QOc0Lj
	 s1T1KTErE1kOyBSEvNu1leWyaOlGKFopl/4gTWIdlkbwDNYY4fTsjuQC7YGJXxYeRu
	 PJNboDQ4JpQJenPgcHr+HT3QAZKgK3uuhMwmZd0dQAJTbCnOT+UYQW0cJ81YU/9sOe
	 MPjbDh7EJzMfw==
Date: Thu, 13 Jun 2024 17:58:19 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com, Andrew Lunn
 <andrew@lunn.ch>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Russell King <linux@armlinux.org.uk>,
 linux-arm-kernel@lists.infradead.org, Christophe Leroy
 <christophe.leroy@csgroup.eu>, Herve Codina <herve.codina@bootlin.com>,
 Florian Fainelli <f.fainelli@gmail.com>, Heiner Kallweit
 <hkallweit1@gmail.com>, Vladimir Oltean <vladimir.oltean@nxp.com>,
 =?UTF-8?B?S8O2cnk=?= Maincent <kory.maincent@bootlin.com>, Jesse Brandeburg
 <jesse.brandeburg@intel.com>, Marek =?UTF-8?B?QmVow7pu?=
 <kabel@kernel.org>, Piergiorgio Beruto <piergiorgio.beruto@gmail.com>,
 Oleksij Rempel <o.rempel@pengutronix.de>, =?UTF-8?B?Tmljb2zDsg==?= Veronese
 <nicveronese@gmail.com>, Simon Horman <horms@kernel.org>,
 mwojtas@chromium.org, Nathan Chancellor <nathan@kernel.org>, Antoine Tenart
 <atenart@kernel.org>
Subject: Re: [PATCH net-next v13 01/13] net: phy: Introduce ethernet link
 topology representation
Message-ID: <20240613175819.035a1e8e@kernel.org>
In-Reply-To: <20240607071836.911403-2-maxime.chevallier@bootlin.com>
References: <20240607071836.911403-1-maxime.chevallier@bootlin.com>
	<20240607071836.911403-2-maxime.chevallier@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri,  7 Jun 2024 09:18:14 +0200 Maxime Chevallier wrote:
> +static inline struct phy_device
> +*phy_link_topo_get_phy(struct net_device *dev, u32 phyindex)

nit: * on the previous line

