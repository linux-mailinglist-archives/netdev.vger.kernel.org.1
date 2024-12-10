Return-Path: <netdev+bounces-150637-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 208A09EB0A5
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 13:21:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C6A8283F50
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 12:21:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ECE81A2398;
	Tue, 10 Dec 2024 12:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bFKZOVGo"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 253C823DE9A;
	Tue, 10 Dec 2024 12:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733833300; cv=none; b=fls2FF2bnRaU0hi7LveixBwXluMCphpjRLmjVcZPZGH8Zj9AVcZZY5t4XTQk4wuTiveFKQXM2yxG2OzF70AOFfvnCrIwpuU+CYjKLTy1UN2WZZYsmMX2jgYndTQEl1CF7w734OzK0/pJIW4Ufm1erBRHnsrNVlm5EYukqr2/cM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733833300; c=relaxed/simple;
	bh=gWuZXjzbrSItMqrfZVwujMN9AEzFQWy/s25eg2BVsuQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EvDi5UmIxbi1PLcG+TiAzC82kXfy9dfOw36l8XwjE4Mf8OlKEMMqKZeFshy7XAYsJTbOEZ0Zl0P+7MMyFqUyIOi2Hy+JriBiKdCL0FtXVo+psojMR0ggRMVM5qgP+JvaHFrT1nGDO1p5nhtxv0OoxGF6IVwm6cp0FIwuQdgE4ng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bFKZOVGo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A90B0C4CED6;
	Tue, 10 Dec 2024 12:21:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733833299;
	bh=gWuZXjzbrSItMqrfZVwujMN9AEzFQWy/s25eg2BVsuQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bFKZOVGoKtme0F/LBtZQtu67KZi/xKesSJEeaBgnnKtxEyzbP75rVmpgpJNP2ZSYt
	 pSKRxAfwqje/nxnDbAovr0VApy+vN+wRTDRZXYkZU9I0YEKSLet7XTCA1e75l4JgMM
	 BnuAtmyTBBkWBvINc4G1U93NwgU1SP+odRndbWarF2sjZugFa1R4cIJrG/H14bHPr3
	 V8wkT5x/GQcKeOQCs2shW4zWpm2w20POkLIU5DkYuePQFljEdPmgpQDEEVFrl1oR6t
	 cJp7ExNuQD7P3H6PwWdnKt14jGeue/dwm/IEeg/qi/YqlsX9xFr+VI5CXbuRIbr2Xv
	 cqLcMLrROPyVg==
Date: Tue, 10 Dec 2024 12:21:34 +0000
From: Simon Horman <horms@kernel.org>
To: Philipp Stanner <pstanner@redhat.com>
Cc: Chandrashekar Devegowda <chandrashekar.devegowda@intel.com>,
	Chiranjeevi Rapolu <chiranjeevi.rapolu@linux.intel.com>,
	Liu Haijun <haijun.liu@mediatek.com>,
	M Chetan Kumar <m.chetan.kumar@linux.intel.com>,
	Ricardo Martinez <ricardo.martinez@linux.intel.com>,
	Loic Poulain <loic.poulain@linaro.org>,
	Sergey Ryazanov <ryazanov.s.a@gmail.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: wwan: t7xx: Replace deprecated PCI functions
Message-ID: <20241210122134.GB4202@kernel.org>
References: <20241206195712.182282-2-pstanner@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241206195712.182282-2-pstanner@redhat.com>

On Fri, Dec 06, 2024 at 08:57:13PM +0100, Philipp Stanner wrote:
> pcim_iomap_regions() and pcim_iomap_table() have been deprecated by the
> PCI subsystem.
> 
> Replace them with pcim_iomap_region().
> 
> Additionally, pass the actual driver name to that function to improve
> debug output.
> 
> Signed-off-by: Philipp Stanner <pstanner@redhat.com>

Reviewed-by: Simon Horman <horms@kernel.org>


