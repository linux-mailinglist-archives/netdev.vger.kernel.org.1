Return-Path: <netdev+bounces-147123-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 154E09D795C
	for <lists+netdev@lfdr.de>; Mon, 25 Nov 2024 01:41:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD55F161DA5
	for <lists+netdev@lfdr.de>; Mon, 25 Nov 2024 00:41:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C506391;
	Mon, 25 Nov 2024 00:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nv6XG+MV"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48B3317D2
	for <netdev@vger.kernel.org>; Mon, 25 Nov 2024 00:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732495267; cv=none; b=rXXLKCCRScLi1QL7sP5MeXNuDSketeSaJfUedSTNcq4FVybZBxuAemmk87gkMmwZ9H3H0KQRQcG+H/joYcPffXuX7xbtvqEWsBz2KG8UcCnBBS1uB7J6fCUnxKYwZp30PBzeIeeXXQMadXFeCIelZ1dkEMiHCYz5+itACh/Vjsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732495267; c=relaxed/simple;
	bh=4l33L5wwV9QyLaWYa4m6erhiD7Rf/lMpiuR68wgCF1k=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WsSfTmynLW86/o47Knu+FYT9P6m7Zjzygu8GYoq+nsLol8t71UpuCWzi2FmFHZr0IDlEF5nXZF4uD3BTioAaG4pSqO/BvLVmrF+N3Puj7USg3FTIcNIVIAeMref0/X3o9rhLM0meOOMHZszlMdnQy1Mpzl03cjff8qhSGiVcEnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nv6XG+MV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FAA9C4CED1;
	Mon, 25 Nov 2024 00:41:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732495265;
	bh=4l33L5wwV9QyLaWYa4m6erhiD7Rf/lMpiuR68wgCF1k=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=nv6XG+MVr2+WisoaupNbAar4T0pjaWfHV/U1SMF7Xos+A5g7qGDLCRAkVuq9CQJyn
	 3K7P1zWUzwrSO/mYiYNy8CER0AelR0Q+cC7LRRBJpW+fCWbtGPo+hDDKGhOFz0FFbo
	 1xC1PDP13IeTCj7Pvvm9LKh0HBNmWFaMjPPSAW1PDDxfj2hYHZpkEHzN3k53vLPZcf
	 4Uai/BrcQjj1bt7xnylc+2oCvbNo10/YWd535d5kA5b814pMTVL6lhLpHhuMI99dZF
	 9S/CK3gwKoaJcdrVBq3f55Gu3tgpmuONB+NFM0625Tnk+yBlvNl6WzxcEro3CVEMCV
	 Dhj5aq58tmpRw==
Date: Sun, 24 Nov 2024 16:41:04 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
 Simon Horman <horms@kernel.org>, David Miller <davem@davemloft.net>,
 Russell King <rmk+kernel@armlinux.org.uk>, Andrew Lunn <andrew@lunn.ch>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>
Subject: Re: [PATCH net] net: phy: ensure that
 genphy_c45_an_config_eee_aneg() sees new value of
 phydev->eee_cfg.eee_enabled
Message-ID: <20241124164104.0ec5d36f@kernel.org>
In-Reply-To: <a9ef58a2-62d8-4122-be04-d7e61a63f16f@gmail.com>
References: <a9ef58a2-62d8-4122-be04-d7e61a63f16f@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 16 Nov 2024 19:37:29 +0100 Heiner Kallweit wrote:
> This is a follow-up to 41ffcd95015f ("net: phy: fix phylib's dual
> eee_enabled") and resolves an issue with genphy_c45_an_config_eee_aneg()
> (called from genphy_c45_ethtool_set_eee) not seeing the new value of
> phydev->eee_cfg.eee_enabled.
> 
> Fixes: 49168d1980e2 ("net: phy: Add phy_support_eee() indicating MAC support EEE")
> Reviewed-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>

Applied, thanks!

