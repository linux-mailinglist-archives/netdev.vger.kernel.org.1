Return-Path: <netdev+bounces-137129-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2FA29A47BC
	for <lists+netdev@lfdr.de>; Fri, 18 Oct 2024 22:17:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EBB9B1C219A8
	for <lists+netdev@lfdr.de>; Fri, 18 Oct 2024 20:17:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DDBC18C32A;
	Fri, 18 Oct 2024 20:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kpc0O5n2"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33F2118C01D
	for <netdev@vger.kernel.org>; Fri, 18 Oct 2024 20:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729282661; cv=none; b=hyNPqXaBDOsPCZiElhDk3X7Zja2ZP3/H7lSywYb2qq+uFV1PIhY5lookwnFFeH4ar9ZpHCU7s3LVbQiRaQzrkpS5cKU/xeYO4UmNZnaNIif24dFBZT10xSL+966mNPn6JroLycGmJ8W/9mxuPMj7v1cu79VHd36CHTiP2xCRtR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729282661; c=relaxed/simple;
	bh=b7TGjLw8iFHWwiY5d27tYuhhIoV0yldOInuJnxDhYac=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nR/7pviek9c/KESxV354eNWSoDi71x+Ho/kdY0sT4u/1R1CHR27MHGQ9XRczGrf35Pw0uC6MH6ctPRoLY2C6WU8ek7KwSMY9bZJXjq80A2y+691tT5U/synFMjW/mN6ye2OiqAznevQf2nWFlEWCGOdsPCwozvi/Dad9CR5OqvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kpc0O5n2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B82F5C4CEC3;
	Fri, 18 Oct 2024 20:17:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729282660;
	bh=b7TGjLw8iFHWwiY5d27tYuhhIoV0yldOInuJnxDhYac=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kpc0O5n2pwR04lAnJsthG8X9rkMrl17HZ76UrvDqhaHxtoKFfvQo5dTgtpYWGJ0Uo
	 dW6fV/GmsK2aAOoi/R35m7Z4tyHx2AeQkkNuT+hieKzLPTEAGn358osmD/mRaRcq4D
	 wAl5hU7H6bMhBZq1wcaQwIXPAmb5UKasLFAB6GK4sLta1RJleoTosNiEhZeV4Y0lPR
	 GLM9qOF5l+IsYFhvtgOVevBcG4q3WoHdeqnlOd8hl6GkkCYr9LxgPSYhNQ8YRQ0pJK
	 DFSR/VkwJR3BLok+/lkmyBvLzPEj/xPWSIxrxP6hwr3q/V7Hr9i5oQ1x4A2wiv5nX/
	 PunT4Kl2tNWeQ==
Date: Fri, 18 Oct 2024 21:17:36 +0100
From: Simon Horman <horms@kernel.org>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Realtek linux nic maintainers <nic_swsd@realtek.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
	David Miller <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	Francois Romieu <romieu@fr.zoreil.com>
Subject: Re: [PATCH net v2] r8169: avoid unsolicited interrupts
Message-ID: <20241018201736.GD1697@kernel.org>
References: <78e2f535-438f-4212-ad94-a77637ac6c9c@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <78e2f535-438f-4212-ad94-a77637ac6c9c@gmail.com>

On Fri, Oct 18, 2024 at 11:08:16AM +0200, Heiner Kallweit wrote:
> It was reported that after resume from suspend a PCI error is logged
> and connectivity is broken. Error message is:
> PCI error (cmd = 0x0407, status_errs = 0x0000)
> The message seems to be a red herring as none of the error bits is set,
> and the PCI command register value also is normal. Exception handling
> for a PCI error includes a chip reset what apparently brakes connectivity
> here. The interrupt status bit triggering the PCI error handling isn't
> actually used on PCIe chip versions, so it's not clear why this bit is
> set by the chip. Fix this by ignoring this bit on PCIe chip versions.
> 
> Fixes: 0e4851502f84 ("r8169: merge with version 8.001.00 of Realtek's r8168 driver")
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=219388
> Tested-by: Atlas Yu <atlas.yu@canonical.com>
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>

Reviewed-by: Simon Horman <horms@kernel.org>


