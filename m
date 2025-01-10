Return-Path: <netdev+bounces-157072-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B479A08D24
	for <lists+netdev@lfdr.de>; Fri, 10 Jan 2025 10:57:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE4453AA18B
	for <lists+netdev@lfdr.de>; Fri, 10 Jan 2025 09:55:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29BFB209F49;
	Fri, 10 Jan 2025 09:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QItRPsT0"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01E5E18A95A;
	Fri, 10 Jan 2025 09:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736502917; cv=none; b=FUT1oJUkb/Lpe7iJeiWvaVBTLjx3TY7o8TwmXTNQKfbfHaJWFNZxoMIUbxTSUZbMvIaYfigNyS4fU5aBofcyWNh8GmkixbGn0AHleS4+VHG5dicXjrYxbXGlkPNjT7zgy00AlTpUHUuVxbOm/M+P6Y+erX7fPT0efmqmOAjrN7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736502917; c=relaxed/simple;
	bh=gkpmHwnR8Yh/n2rNCUGtcEYp1sllwOnm/9K7DGRRUzE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oFoLjYR0F+Ci3RJyrTEeABa7PXO+CSgXOTEMTPQ40tpbT7NVDZCbxxPd9+6MMLkM0kG+QPRNcFaVLDHO7i15nn6jrYMH4QGWuc47pYYTKsC2EgL0GANhW+Pae+qhf2cVlfd+WUfITgMVBcxlYQ3hRNJRHFe5lohHh/zjM0zXeUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QItRPsT0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26485C4CED6;
	Fri, 10 Jan 2025 09:55:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736502913;
	bh=gkpmHwnR8Yh/n2rNCUGtcEYp1sllwOnm/9K7DGRRUzE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QItRPsT0l45znuNh9ylybQ2raG04cRGacxDaULTQjfASc3ljcAcN3fEPXrtBXqb+p
	 WxPuyaE0d8IDZ9MAqTXM+ZQTPBfIW21sWkmX9gpzLgaVHsRTX7ks8+rvu9wwOOc9fn
	 Om5dh2yMYMF+cojubaOPFKgzmpdIxvUz3V5E1yEyi1r9PpA7xSc0oOWcjcMBgCsgYU
	 RZZMEbBz/DYif8pmzqYtRvpPgEIK5Gku1mEmKYs2bVtTfuxnzcN0FUUWh5RyT2fFWS
	 MJT5XB4gIOXEBD8ws0bhuFQdxyf+BUzugMTS9xSdJmRPtAHAQ6SK9/fEMHEh9KHYAz
	 kjva7Qi2GRWTw==
Date: Fri, 10 Jan 2025 09:55:08 +0000
From: Simon Horman <horms@kernel.org>
To: Raphael Gallais-Pou <rgallaispou@gmail.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] net: stmmac: sti: Switch from CONFIG_PM_SLEEP guards
 to pm_sleep_ptr()
Message-ID: <20250110095508.GT7706@kernel.org>
References: <20250109155842.60798-1-rgallaispou@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250109155842.60798-1-rgallaispou@gmail.com>

On Thu, Jan 09, 2025 at 04:58:42PM +0100, Raphael Gallais-Pou wrote:
> Letting the compiler remove these functions when the kernel is built
> without CONFIG_PM_SLEEP support is simpler and less error prone than the
> use of #ifdef based kernel configuration guards.
> 
> Signed-off-by: Raphael Gallais-Pou <rgallaispou@gmail.com>
> ---
> Changes in v2:
>   - Split serie in single patches
>   - Remove irrelevant 'Link:' from commit log
>   - Link to v1: https://lore.kernel.org/r/20241229-update_pm_macro-v1-5-c7d4c4856336@gmail.com

Reviewed-by: Simon Horman <horms@kernel.org>

