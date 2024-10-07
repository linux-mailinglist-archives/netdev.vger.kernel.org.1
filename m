Return-Path: <netdev+bounces-132652-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 852EF992A55
	for <lists+netdev@lfdr.de>; Mon,  7 Oct 2024 13:37:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4439E283A49
	for <lists+netdev@lfdr.de>; Mon,  7 Oct 2024 11:37:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF4841D1F40;
	Mon,  7 Oct 2024 11:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eYnzjZOD"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A334F101C4;
	Mon,  7 Oct 2024 11:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728301062; cv=none; b=G8OX0DT/yYNbuWjKypiWq0Kh9BExu1zPFC5uo6YsMUbD2kRipJM1rYRPiXHmpg3MkDzpK9arVEpdDYROI1+JFnZs4pVPtENgCv+o4sWBSjwW78hmezvpPNyHerznV0RBUaAnD26buixPQzF5RuYFxKS//HGITUmf+IPPOxhFK7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728301062; c=relaxed/simple;
	bh=gNaRh+TWesZQyT5URMrG4JQb0LVXLqWsLcf3AQR4oNo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=InAZxK/vXL23cfnGimu60h04Lb6DBWdf28UQWY8z3INz2tOaqEo7/kGxtgAhWXwTvuGfF1XVfemhRrF+siG9EdmDfSyYCguzL42iCEgSNMrX+RBBfb6TIGbIqaD4cUPUcYFB4v8+oIF69v9R8Bk/Qsgmk5DDrcI7vHQoZfbXbWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eYnzjZOD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09C91C4CEC6;
	Mon,  7 Oct 2024 11:37:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728301062;
	bh=gNaRh+TWesZQyT5URMrG4JQb0LVXLqWsLcf3AQR4oNo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=eYnzjZODRGEjgdMMFMHYzfRr8HsqXo+YxowygO8QE5u9jHNEjBRTwHwLU+atlKwWH
	 yuk/mJd3w9Ibo8Nu5pqTEKk6oBTWJeD8vCCS7v4DWzJeX+Ns6+vygb9j7HxsuqF1+R
	 ZDEyivfSBnNdQrxeOjJBUYBDZjksCLhmjrT08i86tCOXMk6AuLyqN+hUlMr46hwz8b
	 uK55pgDObs9R0l1A033c0qhV2t99XnnsLfogr1byTQehM0T7trJntLEm2SjVR637EI
	 YtjfGGnDagQLz2Cy8D6q10wo+kLI31tiFVLo9QliGdOIyxWdrdKupT+IIbiiuammh4
	 SwyM9og6fV6SA==
Message-ID: <ebd0bc6c-355e-4bd6-8eaa-b4ec0e5212f1@kernel.org>
Date: Mon, 7 Oct 2024 14:37:37 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v3 2/2] net: ethernet: ti: am65-cpsw: avoid
 devm_alloc_etherdev, fix module removal
To: Nicolas Pitre <nico@fluxnic.net>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Grygorii Strashko <grygorii.strashko@ti.com>,
 Vignesh Raghavendra <vigneshr@ti.com>
Cc: Nicolas Pitre <npitre@baylibre.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20241004041218.2809774-1-nico@fluxnic.net>
 <20241004041218.2809774-3-nico@fluxnic.net>
Content-Language: en-US
From: Roger Quadros <rogerq@kernel.org>
In-Reply-To: <20241004041218.2809774-3-nico@fluxnic.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 04/10/2024 07:10, Nicolas Pitre wrote:
> From: Nicolas Pitre <npitre@baylibre.com>
> 
> Usage of devm_alloc_etherdev_mqs() conflicts with
> am65_cpsw_nuss_cleanup_ndev() as the same struct net_device instances
> get unregistered twice. Switch to alloc_etherdev_mqs() and make sure
> am65_cpsw_nuss_cleanup_ndev() unregisters and frees those net_device
> instances properly.
> 
> With this, it is finally possible to rmmod the driver without oopsing
> the kernel.
> 
> Fixes: 93a76530316a ("net: ethernet: ti: introduce am65x/j721e gigabit eth subsystem driver")
> Signed-off-by: Nicolas Pitre <npitre@baylibre.com>

Reviewed-by: Roger Quadros <roger@kernel.org>

