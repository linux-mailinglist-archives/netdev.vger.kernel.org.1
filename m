Return-Path: <netdev+bounces-43063-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 905D57D13E9
	for <lists+netdev@lfdr.de>; Fri, 20 Oct 2023 18:21:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C14E11C20AB7
	for <lists+netdev@lfdr.de>; Fri, 20 Oct 2023 16:21:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 560851EA6F;
	Fri, 20 Oct 2023 16:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="txg7yZOP"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 389C7171C6
	for <netdev@vger.kernel.org>; Fri, 20 Oct 2023 16:21:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A44DC433C7;
	Fri, 20 Oct 2023 16:21:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697818912;
	bh=4U2Hcig7AOmbj97TCWnTmbt6ooNBVztm307/ivsP/2I=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=txg7yZOPZLkERJ/EGgmEuz/5o91LMSIKH2ak4SWH5k3yk7qsYYKmH4KKR5SAlx3md
	 cjc7zMYBGY/QjIjTAP1qhdesIKZ1kU3gN20J/7qPUcramLFu71st9id1FQGfuiTgD7
	 ainIXRpqLOrFrINarI8O72d5SXL+Pzxr8hhDujeoqBgNWtjqzbFQpfXS4HvuU7UFMr
	 ri5V+I7LwFtlIAt7/fmfE2o+A4bOQL21DoxfmKDfX1gmJPmfVFZTRIDDzRjqRKx82E
	 TYb8DGrp2pwE3BPKuvZakZ4m3ENRZ2AR7fz6n7dpA5PMSWv3GUy1u76/6XrT3dFWS6
	 0L463ie+iw52A==
Date: Fri, 20 Oct 2023 09:21:51 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew@lunn.ch, paul.greenwalt@intel.com,
 hkallweit1@gmail.com, linux@armlinux.org.uk, gal@nvidia.com
Subject: Re: [PATCH net-next] ethtool: untangle the linkmode and ethtool
 headers
Message-ID: <20231020092151.00a20fcf@kernel.org>
In-Reply-To: <20231020092429.3pitbl3s6x6aonss@skbuf>
References: <20231019152815.2840783-1-kuba@kernel.org>
	<20231020092429.3pitbl3s6x6aonss@skbuf>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 20 Oct 2023 12:24:29 +0300 Vladimir Oltean wrote:
> On Thu, Oct 19, 2023 at 08:28:15AM -0700, Jakub Kicinski wrote:
> > +EXPORT_SYMBOL_GPL(ethtool_forced_speed_maps_init);  
> 
> Is there a rule for EXPORT_SYMBOL() vs EXPORT_SYMBOL_GPL()? My rule of
> thumb was that symbols used by drivers should get EXPORT_SYMBOL() for
> maximum compatibility with their respective licenses, while symbols
> exported for other core kernel modules should get EXPORT_SYMBOL_GPL().

I think that Russell is right that it's author's preference. I don't
have a strong one so I just copy what's in the file. Luck would have 
it that the closest was EXPORT_SYMBOL_GPL(ethtool_set_ethtool_phy_ops);

We should perhaps have clearer guidance. You say drivers but even what
we put under drivers/net/ vs net/ is not crystal clear. With some
protocols leaving in one place and others in the other. Pretty core
things like netconsole are under drivers/ and qdiscs which have a
non-GPL API (IIRC) are under net/.

We'd need to consult with people who have more exposure to proprietary
code to figure out good rules. For better or worse I'm not one of them
:(

