Return-Path: <netdev+bounces-178885-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BBD76A79580
	for <lists+netdev@lfdr.de>; Wed,  2 Apr 2025 20:56:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9B0837A4EC8
	for <lists+netdev@lfdr.de>; Wed,  2 Apr 2025 18:55:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31E291DC198;
	Wed,  2 Apr 2025 18:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HNX5Eaue"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0814718A93F;
	Wed,  2 Apr 2025 18:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743620170; cv=none; b=k/GpLjfB6GrQs0CJ18u/3ZskHSo6MMjq4pSXc0lEXQOxKGV2gflmY2kC+uSvekugq9oOdMEQgI04NnOfK7972AH2bO5prfNy9F2xPICd6SPqMbEPAVgpdT3/Yr+XYHLRarluusk7EmXN6I0yE1/miuAVBV7ArAfpo53e7+tAvJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743620170; c=relaxed/simple;
	bh=E7/8k6fI8V+003berCviggYozc+RWD88WFCUvF/199s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gSPHp/cF3sdWwfgc2ljH7Z18n3zgcgTBEGJwu0/4NKK7RrfaBOkJ8yMfMw5PVXEgv1Q0gcB5fA67BuRa56prNraaYu7Avi9IRjLW2f7dVj+3+k1WvqYNBQBqnH9AavnkXJsAvpqP1RW+B3HNx/xvAxn15wYz1qjjvFMwALI8iXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HNX5Eaue; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B16B6C4CEDD;
	Wed,  2 Apr 2025 18:56:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743620169;
	bh=E7/8k6fI8V+003berCviggYozc+RWD88WFCUvF/199s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HNX5EaueWL2i/RVdYG8dXs9r/BeShZ4iXmpX2g8nw4sWEJ2dIpZPdkwanct6jPDKN
	 OFhKk7S0a172HMYpj9JKiR4r7xjfNd3D3FVQqiNhCGDlniEFA2C0ETZ3tVmR8gs8lF
	 v/vKbpNhCmxLfJNxYqYUp/b5sU+eVWTeT0pilTuRnR+0o44el84BQUclYJrkB50Vlx
	 o1z86+xo0GluNL4NolJRcYqcFBX33DlKNDQLlelXDbu1GuNZoOw6l2unw2xoWxJ6RJ
	 dFgd+wPc6v8j0z85sG+xq75lysdslDsCVHDCaANZh/BhAG4miDo3PXq0WNROBabSj5
	 pDpn52TnlPkPQ==
Date: Wed, 2 Apr 2025 19:56:04 +0100
From: Simon Horman <horms@kernel.org>
To: Jijie Shao <shaojijie@huawei.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, andrew+netdev@lunn.ch, shenjian15@huawei.com,
	wangpeiyang1@huawei.com, liuyonglong@huawei.com,
	chenhao418@huawei.com, jonathan.cameron@huawei.com,
	shameerali.kolothum.thodi@huawei.com, salil.mehta@huawei.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net 1/7] net: hibmcge: fix incorrect pause frame
 statistics issue
Message-ID: <20250402185604.GU214849@horms.kernel.org>
References: <20250402133905.895421-1-shaojijie@huawei.com>
 <20250402133905.895421-2-shaojijie@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250402133905.895421-2-shaojijie@huawei.com>

On Wed, Apr 02, 2025 at 09:38:59PM +0800, Jijie Shao wrote:
> The driver supports pause frames,
> but does not pass pause frames based on rx pause enable configuration,
> resulting in incorrect pause frame statistics.

I think it would be worth explaining why pause frames need
to be passed through in order for statistics to be correct.
I.e. which entity is passing them through to which other
entity that counts them.

> This patch fixes this problem.
> 
> Fixes: 3a03763f3876 ("net: hibmcge: Add pauseparam supported in this module")
> Signed-off-by: Jijie Shao <shaojijie@huawei.com>

...

