Return-Path: <netdev+bounces-138387-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32F679AD42B
	for <lists+netdev@lfdr.de>; Wed, 23 Oct 2024 20:43:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 93BC9B23417
	for <lists+netdev@lfdr.de>; Wed, 23 Oct 2024 18:43:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C7991E285B;
	Wed, 23 Oct 2024 18:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FSKfgCiO"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B4AD1E2836;
	Wed, 23 Oct 2024 18:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729708954; cv=none; b=bMNWYVPZz1a/mXeWaWsigwxbDwDZsc04WJ452MNkR346cZXS6EBg99VOS3PBDh4tXvbAwvc2ei9lXE6OiBCCM3TbA25T3G3iJHQYm1POcW2Q/VCDjw8XOvR2SHIbfgYt7zdDcJWm4cg9ZG/FuBFBvEuHypepoLz7qgpJ5UGaBB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729708954; c=relaxed/simple;
	bh=JFuMTy5+3Dd7T2V8KHoEqrnYNn8WdWTXjiTBI9jcQKQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ORbcuVzI+/UEPmWMa9uUBBiZBCCx8jfZJbagEoostmRzT2sETl5k6Q+H30T9X5xzdwv7BP+LcuR/BSbFGp9Tw4EjhRvMjnzrW40yrZ8w27wug5oCo+8naC+MsHvEwz0QrOLFytnciViQ1MnGOsOunSRW/TuGaUt0DmBLaiz4fQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FSKfgCiO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE528C4CEE5;
	Wed, 23 Oct 2024 18:42:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729708953;
	bh=JFuMTy5+3Dd7T2V8KHoEqrnYNn8WdWTXjiTBI9jcQKQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FSKfgCiOAStUT/GroWNuz2dlbMEvcq6rL3d+R2wmh7w6BSf+SXISO2YQmt4/jy1BO
	 g/4Mo2gEKLZ0PPmzfS08Diw6dMyn3iEDtC1kPdtdsFobqmj2ZeSkU5uNaJzb+FPu83
	 42UwoNBAiyaKBYCRwCGPJlImsPGvsSVm0CEp8qtdBETcMeTN6G3/1F/9Xci17TV01D
	 Q1PmYccQzugv5Yoe5S5F9G/0upvTu5c09dDv75+Q4SeRlYlDyTXUnTywTG0VPnnV9D
	 mrxGFnSNVakW0ajkpI/WAzRADakt7FNo8+gURcPxjlP8Sq90nPVmJJtuqBQ5zZPqqg
	 qScYYYyGmb/bQ==
Date: Wed, 23 Oct 2024 19:42:28 +0100
From: Simon Horman <horms@kernel.org>
To: Florian Fainelli <florian.fainelli@broadcom.com>
Cc: netdev@vger.kernel.org, Vladimir Oltean <vladimir.oltean@nxp.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:CLANG/LLVM BUILD SUPPORT:" <llvm@lists.linux.dev>
Subject: Re: [PATCH net-next v2 2/2] net: systemport: Move IO macros to
 header file
Message-ID: <20241023184228.GB402847@kernel.org>
References: <20241021174935.57658-1-florian.fainelli@broadcom.com>
 <20241021174935.57658-3-florian.fainelli@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241021174935.57658-3-florian.fainelli@broadcom.com>

On Mon, Oct 21, 2024 at 10:49:35AM -0700, Florian Fainelli wrote:
> Move the BCM_SYSPORT_IO_MACRO() definition and its use to bcmsysport.h
> where it is more appropriate and where static inline helpers are
> acceptable. While at it, make sure that the macro 'offset' argument does
> not trigger a checkpatch warning due to possible argument re-use.
> 
> Suggested-by: Vladimir Oltean <vladimir.oltean@nxp.com>
> Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>

Reviewed-by: Simon Horman <horms@kernel.org>


