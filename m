Return-Path: <netdev+bounces-192213-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E89EFABEF42
	for <lists+netdev@lfdr.de>; Wed, 21 May 2025 11:12:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 234CB1656D1
	for <lists+netdev@lfdr.de>; Wed, 21 May 2025 09:12:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F23DC2397BE;
	Wed, 21 May 2025 09:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZEc+xk//"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8B281A9B4C;
	Wed, 21 May 2025 09:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747818753; cv=none; b=B+4X5qpBPbuLPjxumRF6qIrK48SXprjUj8I4Yd/VSuLDZAJw/PsJ4QNo/LXiMU5HQvi6zgGSci4tnR0BARAOWmYsDf8udJ8Qzv0MHPXcRNgtmMszHSqXqmVtJZ3QSnnbifeCvr4ilayDf8F06job2JvvN9Ih6umzKGfaDHpwsRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747818753; c=relaxed/simple;
	bh=ikhygHFZ9rkod/U2Fm9+LcynIwgOWRtuw85hfh8xlFI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NdwPIURF/ezp+WNnaZrbJFj2sfAsxVc3vTnxZSzaAVHCVVOkLd3Umn39hgwQFibOry2wvAw0pJD625DmENCzA3WLLYB+1tMNFopBGztzgmKM4KaGapUDwhGTmneVAOXXiJwh7xlZluP75/tK6P7dpw0hYUo4cr2bzjNUVI/z1f4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZEc+xk//; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81DC6C4CEE4;
	Wed, 21 May 2025 09:12:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747818753;
	bh=ikhygHFZ9rkod/U2Fm9+LcynIwgOWRtuw85hfh8xlFI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZEc+xk//2FDV1smvV+SbO7L/jlMiX0+LJgXCZXKaAnU7gmB7rpcmkX3jEDGQC/LHp
	 BQ4KxbdKxLjTPqRxSeH7JRWT8LqB5VY4LiVDbHU0fZCubn/IhChovJ9hc/hd5wSmjy
	 DBxUu2tBNpT8+ryRw796niU5rXRNAGA44F69qub8e/LlyxlC5ww5Sza5kklyHvCHsI
	 ysln0q2RBRMvtdFLeZbSNuyiHFrAeLkghcK1L0Q2SIoKyLYOtrmX08IuKtY2AZ74tp
	 Ipvw5niNVqkYGQ/Rb4Z9TD3d7UZmjo/pHpzZwsqdxLvcTa6dt/fYzo2BL2tQer4wTd
	 F1elYkxuNhqNg==
Date: Wed, 21 May 2025 10:12:28 +0100
From: Simon Horman <horms@kernel.org>
To: Jijie Shao <shaojijie@huawei.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, andrew+netdev@lunn.ch, shenjian15@huawei.com,
	wangpeiyang1@huawei.com, liuyonglong@huawei.com,
	chenhao418@huawei.com, jonathan.cameron@huawei.com,
	shameerali.kolothum.thodi@huawei.com, salil.mehta@huawei.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 net 1/2] net: hibmcge: fix incorrect statistics update
 issue
Message-ID: <20250521091228.GS365796@horms.kernel.org>
References: <20250517095828.1763126-1-shaojijie@huawei.com>
 <20250517095828.1763126-2-shaojijie@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250517095828.1763126-2-shaojijie@huawei.com>

On Sat, May 17, 2025 at 05:58:27PM +0800, Jijie Shao wrote:
> When the user dumps statistics, the hibmcge driver automatically
> updates all statistics. If the driver is performing the reset operation,
> the error data of 0xFFFFFFFF is updated.
> 
> Therefore, if the driver is resetting, the hbg_update_stats_by_info()
> needs to return directly.
> 
> Fixes: c0bf9bf31e79 ("net: hibmcge: Add support for dump statistics")
> Signed-off-by: Jijie Shao <shaojijie@huawei.com>

Reviewed-by: Simon Horman <horms@kernel.org>


