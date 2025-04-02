Return-Path: <netdev+bounces-178886-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F1B5BA79585
	for <lists+netdev@lfdr.de>; Wed,  2 Apr 2025 20:56:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 496CC1888170
	for <lists+netdev@lfdr.de>; Wed,  2 Apr 2025 18:57:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A90E1DDC00;
	Wed,  2 Apr 2025 18:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I1xq8r7M"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 721CE1DB92A;
	Wed,  2 Apr 2025 18:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743620213; cv=none; b=sZL9Rbi68vvVMzj3CY8fAr08fcb/jlKLo5n0CWjhieL7+IPkF8PKxNwF2EdPm3NF9YEljyxvy2aGF03cmDfvngF7o20qPaz4Mt+E5G4AZDXdcblyeZgWtz3fUFA/XN0Rt3EsAdTojjVv92fcxSZ9QLmUPddLd7FwMDlWJXaStBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743620213; c=relaxed/simple;
	bh=cz0x8uEQhsD9AvaX4nn6mYGilvPUd8AoSrVT+BjCaUk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EO1HconLadPKE+5E9+LOZfgM2S16EmAuXSmCE46SZx/Tzt+Z8DfyW3dx0oREoUj5vamePsb/4oVPzNoWeyiqacrRZOPQ4Kdxiz9MK7DKTJBv/Sbrn2ydxLbl2aQJWkNcTH4+DKpgUD1dgYYnpeL6/QM0Z020Ibcom7avkecYqyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I1xq8r7M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 292AEC4CEDD;
	Wed,  2 Apr 2025 18:56:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743620212;
	bh=cz0x8uEQhsD9AvaX4nn6mYGilvPUd8AoSrVT+BjCaUk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=I1xq8r7MCzhFbYR8FBrdhKZASZTJJW/ZT0mVF5kgE04ZGefS1LzhalPV8vKANSM5M
	 5awJhfQVvcF82bxmmZA/D37K9+ziA26kAgXYfCOlhi7qfRfgJjMpIUJ2qCjzy+GWOe
	 8z/eTn2RsFRbvh3FZBqw7YJp3tssDHrFEl81jS3PxBvQX1R2sHXMbYVRU1yRX3Xrsw
	 qHUS0sxxWMt2Lgm6DDZ7rUc0U/oY5VnPn3ZWnGYpx622z7XhhWoOtFQSwY/DkBS+6M
	 76wJn40r1s4nUImwXOGPsvvOjxNe75scz2N1Vk2YI5P38aM8sxCsRnqvAhcKM8qQj+
	 WLJ/T7Sm3WMiQ==
Date: Wed, 2 Apr 2025 19:56:47 +0100
From: Simon Horman <horms@kernel.org>
To: Jijie Shao <shaojijie@huawei.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, andrew+netdev@lunn.ch, shenjian15@huawei.com,
	wangpeiyang1@huawei.com, liuyonglong@huawei.com,
	chenhao418@huawei.com, jonathan.cameron@huawei.com,
	shameerali.kolothum.thodi@huawei.com, salil.mehta@huawei.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net 2/7] net: hibmcge: fix incorrect multicast filtering
 issue
Message-ID: <20250402185647.GV214849@horms.kernel.org>
References: <20250402133905.895421-1-shaojijie@huawei.com>
 <20250402133905.895421-3-shaojijie@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250402133905.895421-3-shaojijie@huawei.com>

On Wed, Apr 02, 2025 at 09:39:00PM +0800, Jijie Shao wrote:
> The driver does not support multicast filtering,
> the mask must be set to 0xFFFFFFFF. Otherwise,
> incorrect filtering occurs.
> 
> This patch fixes this problem.
> 
> Fixes: 37b367d60d0f ("net: hibmcge: Add unicast frame filter supported in this module")
> Signed-off-by: Jijie Shao <shaojijie@huawei.com>

Reviewed-by: Simon Horman <horms@kernel.org>

