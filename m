Return-Path: <netdev+bounces-63352-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F316B82C5DC
	for <lists+netdev@lfdr.de>; Fri, 12 Jan 2024 20:26:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 256241C20AA7
	for <lists+netdev@lfdr.de>; Fri, 12 Jan 2024 19:26:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE2C414F6D;
	Fri, 12 Jan 2024 19:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V9vHbliY"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D50A716400
	for <netdev@vger.kernel.org>; Fri, 12 Jan 2024 19:26:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 518B4C433C7;
	Fri, 12 Jan 2024 19:26:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705087613;
	bh=0clwGcS8DaH4p0n6kFrU9RtwIPR0BMR1WdK/12/Vsws=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=V9vHbliY0wyr6CVTl1+v5x1nG8FtH6ML7Qcn+grHolV3i9e0cM8zE3krPekJzAI9Q
	 pwD4q7z+qenI170tTE8ga8ElSaySDFJf6PppOlA+xpMFyX0W4LZivxSZ8rKblfG3a1
	 N2A3gTU161YHWOdGsXhx61oc92OFMoGBguXGG6eJnkfHmn0Fr/xIu9LtqHQk7lyaCo
	 Z48AzhNGOd1f+wBURqkaEq0y2aNsSj1M4yUGW2uqbIA9MxFAuWmq23gCDhm2QCVMnT
	 v756Rzta3qnDt+Kd7FzQJlHmS4L4xiGfGZLCJaYcfHJjcu7YHsT3rtvrhTYv51Xj9Q
	 ueG1KhWpf/txA==
Date: Fri, 12 Jan 2024 19:26:49 +0000
From: Simon Horman <horms@kernel.org>
To: Dmitry Antipov <dmantipov@yandex.ru>
Cc: Derek Chickles <dchickles@marvell.com>,
	Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org
Subject: Re: [PATCH] net: liquidio: fix clang-specific W=1 build warnings
Message-ID: <20240112192649.GA392144@kernel.org>
References: <20240111162432.124014-1-dmantipov@yandex.ru>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240111162432.124014-1-dmantipov@yandex.ru>

On Thu, Jan 11, 2024 at 07:24:29PM +0300, Dmitry Antipov wrote:
> When compiling with clang-18 and W=1, I've noticed the following
> warnings:
> 
> drivers/net/ethernet/cavium/liquidio/cn23xx_pf_device.c:1493:16: warning: cast
> from 'void (*)(struct octeon_device *, struct octeon_mbox_cmd *, void *)' to
> 'octeon_mbox_callback_t' (aka 'void (*)(void *, void *, void *)') converts to
> incompatible function type [-Wcast-function-type-strict]
>  1493 |         mbox_cmd.fn = (octeon_mbox_callback_t)cn23xx_get_vf_stats_callback;
>       |                       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> and:
> 
> drivers/net/ethernet/cavium/liquidio/cn23xx_vf_device.c:432:16: warning: cast
> from 'void (*)(struct octeon_device *, struct octeon_mbox_cmd *, void *)' to
> 'octeon_mbox_callback_t' (aka 'void (*)(void *, void *, void *)') converts to
> incompatible function type [-Wcast-function-type-strict]
>   432 |         mbox_cmd.fn = (octeon_mbox_callback_t)octeon_pfvf_hs_callback;
>       |                       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> Fix both of the above by adjusting 'octeon_mbox_callback_t' to match actual
> callback definitions (at the cost of adding an extra forward declaration).
> 
> Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>

I'm not entirely sure changes line this
are appropriate for an orphaned driver [1].
But if so, these look good to me.

Reviewed-by: Simon Horman <horms@kernel.org>

[1] MAINTAINERS: eth: mark Cavium liquidio as an Orphan
    https://git.kernel.org/netdev/net/c/384a35866f3a

