Return-Path: <netdev+bounces-105667-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E2A42912321
	for <lists+netdev@lfdr.de>; Fri, 21 Jun 2024 13:16:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8BEEA1F2368E
	for <lists+netdev@lfdr.de>; Fri, 21 Jun 2024 11:16:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2C4D173354;
	Fri, 21 Jun 2024 11:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aEqmmsy7"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF035172BA7
	for <netdev@vger.kernel.org>; Fri, 21 Jun 2024 11:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718968592; cv=none; b=i69iRuN1NuYr8/jElBKT0D99AXyxEb/lyZa0nCOejtlofuD2wKHSQ94JLTwC68OvHpvzQtjv4ij6F1R6JHKWge9tcuAr7/ajecOnizOqwgT1EJWEDE3d+Jg6+XyxmWET39h+8mhcYvM3yTibPu1NuWW0f8igVjm2GIs2CFHPOng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718968592; c=relaxed/simple;
	bh=z1/pooQUILhH0VFs1sDWrIZq+BIXMFfbUhIkzO2SVTQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rHpx5YEqh0YpdFd24Gb8ltx8dHDjjTiHK6mr/H1+LttUJmdTBZoJeh5Q0AmYuIMMKukqEoiwAxu3D/cLJfbU/P01rVpGze8zAKyOiWF1VNuHi2PjVz7OQ5Sx6jRNzAUY2dtHEtZS5dx7MHcqo0FplzvHwvIGA4r/vWBBFbTRhgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aEqmmsy7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED62BC4AF08;
	Fri, 21 Jun 2024 11:16:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718968591;
	bh=z1/pooQUILhH0VFs1sDWrIZq+BIXMFfbUhIkzO2SVTQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aEqmmsy720CNrjYJ9DwRXbcA4A7zjlS3eTNZcAaNZsVToOzVmlJwkpd9tVLJhaZZ8
	 ac4x74gqjnH+w5+yL55rLqtv3KaXDGAMS+ZbA9ehfJCshhYz+amrZqHHYGo3LQSBSX
	 7CDRFbSLrasaXvcq6BtuwumL86T4Kn2PBqrkwd+YeNBHaIEomc8jNbcrBzIoNhxM+e
	 y4BSuD9SPGAx6ial4wBYrh5LtNyNcD7q/2Iw+R2t6NjEt45ymgFJ1Vwt5mQoo7iViO
	 qv4SwRVUVOc0tEMtq9vco7f4KAwuZbiIAyZRto4O4ETADawuIYyATT649IdBftx6CJ
	 PBDDMftCeyJng==
Date: Fri, 21 Jun 2024 12:16:27 +0100
From: Simon Horman <horms@kernel.org>
To: Karol Kolacinski <karol.kolacinski@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
	Milena Olech <milena.olech@intel.com>,
	Jacob Keller <jacob.e.keller@intel.com>
Subject: Re: [PATCH v2 iwl-net 1/3] ice: Fix improper extts handling
Message-ID: <20240621111627.GC1098275@kernel.org>
References: <20240620123141.1582255-1-karol.kolacinski@intel.com>
 <20240620123141.1582255-2-karol.kolacinski@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240620123141.1582255-2-karol.kolacinski@intel.com>

On Thu, Jun 20, 2024 at 02:27:08PM +0200, Karol Kolacinski wrote:
> From: Milena Olech <milena.olech@intel.com>
> 
> Extts events are disabled and enabled by the application ts2phc.
> However, in case where the driver is removed when the application is
> running, channel remains enabled. As a result, in the next run of the
> app, two channels are enabled and the information "extts on unexpected
> channel" is printed to the user.
> 
> To avoid that, extts events shall be disabled when PTP is released.
> 
> Fixes: 172db5f91d5f ("ice: add support for auxiliary input/output pins")
> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> Co-developed-by: Jacob Keller <jacob.e.keller@intel.com>
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> Signed-off-by: Milena Olech <milena.olech@intel.com>
> Signed-off-by: Karol Kolacinski <karol.kolacinski@intel.com>
> ---
> V1 -> V2: removed extra space and fixed return value in
>           ice_ptp_gpio_enable_e823()

Reviewed-by: Simon Horman <horms@kernel.org>


