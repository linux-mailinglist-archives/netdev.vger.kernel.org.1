Return-Path: <netdev+bounces-115051-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E2D55944FA8
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 17:51:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D27B2858A9
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 15:51:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32CAF19E7E3;
	Thu,  1 Aug 2024 15:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="feXFF6z4"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 077BD19478;
	Thu,  1 Aug 2024 15:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722527485; cv=none; b=SCvk0lEyEIqwyTvNfLmVeiNlMgj9Zs7v36EVrjKc0ZACOPathpQ16YA99FTMesHZVFX9Ty/HscIn3kQi2RCDfYYQphbUQU6VPRLbwdyo2VomOHrzoYXbACvmMg4KI1gjp2Heztr/6Mcf47h6U3h5kQepGiOnWis06SKpbORCy30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722527485; c=relaxed/simple;
	bh=t0HGpBuMRz0nLaqeeIb8Mp+3aCtDMUJ3ClS8fVtXzA4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rMPSZ54C8mecHOloMmsEcJoTJCPPb+Mu0b0wPlkEFnJJrdYDTHfEKfKClwJOEtEAahliSUBFwpxuC1BUk5jTLsz4vIV8YE0XBhzmMJGWJTyNtxwQP4ttiZOJpawX21BgdwACi8JhsfgN8yRKSwOaLqY94UV4kl7pebWaJwk5r18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=feXFF6z4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1302AC32786;
	Thu,  1 Aug 2024 15:51:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722527484;
	bh=t0HGpBuMRz0nLaqeeIb8Mp+3aCtDMUJ3ClS8fVtXzA4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=feXFF6z4zEDtq1yQBFpLr5sqSIqlBVB5cj933qZPHpoAp8Pz67MVIg6lfKPoZQMkX
	 4dd0yFF6RsLFHBPWFUAL5FKiTmjSL7kVoknbgnct20xompdIFAh18UXj0rMuYJb83v
	 e68m1o2sxkch4WdjmdP4A5JehG//0IB1m3xTixRwrX63v/0MZ+T3awZqCbp8o/qM/M
	 N9DyUb6yqfRNaSELCt57NIQo9210eI7XX89kojfYOZLIjMfdvo++kYSDHezDOxnIPp
	 yjPy0HWMd7HG1fSBLFwqBe/1vnQMe8Q9JWt+alYNY8bDCT9nOUDDjcjN99v6fa7nWX
	 DjQjstBD4Y3/g==
Date: Thu, 1 Aug 2024 08:51:23 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Youwan Wang <youwan@nfschina.com>
Cc: linux@armlinux.org.uk, andrew@lunn.ch, davem@davemloft.net,
 edumazet@google.com, hkallweit1@gmail.com, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, pabeni@redhat.com, Russell King
 <rmk+kernel@armlinux.org.uk>, Wojciech Drewek <wojciech.drewek@intel.com>
Subject: Re: [net-next,v4] net: phy: phy_device: fix PHY WOL enabled, PM
 failed to suspend
Message-ID: <20240801085123.6757d4c3@kernel.org>
In-Reply-To: <20240731091537.771391-1-youwan@nfschina.com>
References: <ZqdM1rwbmIED/0WC@shell.armlinux.org.uk>
	<20240731091537.771391-1-youwan@nfschina.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 31 Jul 2024 17:15:37 +0800 Youwan Wang wrote:
> +	/* If the PHY on the mido bus is not attached but has WOL enabled
> +	 * we cannot suspend the PHY.
> +	 */
> +	if (!netdev && phy_drv_wol_enabled(phydev))
> +		return false;

Not sure why you stopped setting phydev->wol_enabled between v2 and v3
but let's hear from phy maintainers..

