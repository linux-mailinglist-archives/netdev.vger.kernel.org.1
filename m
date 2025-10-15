Return-Path: <netdev+bounces-229676-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D4155BDF9A9
	for <lists+netdev@lfdr.de>; Wed, 15 Oct 2025 18:16:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 286FD40135F
	for <lists+netdev@lfdr.de>; Wed, 15 Oct 2025 16:16:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A12FD2F60A4;
	Wed, 15 Oct 2025 16:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XP5soyJs"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72AD32E4279;
	Wed, 15 Oct 2025 16:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760544965; cv=none; b=p63ZUnu8jyowrLWkchbrfTTrQzy/vQFBy9yGi45xOqZIyMOct3aTAc0CYgDNVLdUCc50URkV2eTjjPYHQb2QVmaN/UtQQV0cePAKTqlUvmpHuDEdqFHLDsI1ivnw5tksvuE2Xrgre6EnfiJU92VYH5gNMYnb/Zi0pcGoIIuygsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760544965; c=relaxed/simple;
	bh=mh2p56RFHNMS2T3Y3D/s7unv9Kw8fsakAhRbESmfhGU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XW5hNA2AC6IjxxrfmKl/yaiLIeL3c8ARnM3VDt/lY1LdedOL4MDySOHfj/buYZu8bZqqyhuCbVTZAuilrDcYIYfIIyzCTdCIWPWS24nR/GJavR4hg+rdr+9ulNcBY9opwHG0PDOmcnuDmLC6makIVFjiY5tJCVqvl0gExwoCvro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XP5soyJs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F406EC16AAE;
	Wed, 15 Oct 2025 16:16:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760544965;
	bh=mh2p56RFHNMS2T3Y3D/s7unv9Kw8fsakAhRbESmfhGU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XP5soyJstRjA+4jh/pYRKC3icDr5UMOcRaf6fKwzZM2ixRepmPznj1Bu+MdbmFR79
	 y4Tmf2oOQHPGWsxnL7vXP8qh7M13XkdoQIAKjnF985BtQwh0Xxra5tD4BYwPCUH2dn
	 uWdP0n7FcG4rrNCuc4rRdSewGNxA8Rkw8++WuRPbujdDLGeb/1CC+8zoMzRw6/gSXt
	 4PAdAUcqRMeciTTYjn9zo5lbApS8YoPtSKwILoCsrts7oWsSHOxhkKAK6kRgMH0V8b
	 x5xsoetaRGUs5HDb3fe2Bx+wn8CMpq70sxHZjIVS60sYMUyIoGxbDxOrHFwd1GFgyB
	 +ziYJVN3uSfBQ==
Date: Wed, 15 Oct 2025 17:15:59 +0100
From: Simon Horman <horms@kernel.org>
To: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Cc: Sunil Goutham <sgoutham@marvell.com>,
	Linu Cherian <lcherian@marvell.com>,
	Geetha sowjanya <gakula@marvell.com>,
	Jerin Jacob <jerinj@marvell.com>, hariprasad <hkelam@marvell.com>,
	Subbaraya Sundeep <sbhatta@marvell.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Nithya Mani <nmani@marvell.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, dan.carpenter@linaro.org,
	kernel-janitors@vger.kernel.org, error27@gmail.com
Subject: Re: [PATCH v2] Octeontx2-af: Fix pci_alloc_irq_vectors() return
 value check
Message-ID: <aO_Iv3FshxBPkmjs@horms.kernel.org>
References: <20251015090117.1557870-1-harshit.m.mogalapalli@oracle.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251015090117.1557870-1-harshit.m.mogalapalli@oracle.com>

On Wed, Oct 15, 2025 at 02:01:17AM -0700, Harshit Mogalapalli wrote:
> In cgx_probe() when pci_alloc_irq_vectors() fails the error value will
> be negative and that check is sufficient.
> 
> 	err = pci_alloc_irq_vectors(pdev, nvec, nvec, PCI_IRQ_MSIX);
>         if (err < 0 || err != nvec) {
>         	...
> 	}
> 
> When pci_alloc_irq_vectors() fail to allocate nvec number of vectors,
> -ENOSPC is returned, so it would be safe to remove the check that
> compares err with nvec.
> 
> Fixes: 1463f382f58d ("octeontx2-af: Add support for CGX link management")
> Suggested-by: Paolo Abeni <pabeni@redhat.com>
> Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
> ---
> Only compile tested.
> 
> v1->v2: Improve the commit message

Thanks for the update.

Reviewed-by: Simon Horman <horms@kernel.org>

