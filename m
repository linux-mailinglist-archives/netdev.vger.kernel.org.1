Return-Path: <netdev+bounces-192214-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A565DABEF43
	for <lists+netdev@lfdr.de>; Wed, 21 May 2025 11:13:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 53B9A3A9AB7
	for <lists+netdev@lfdr.de>; Wed, 21 May 2025 09:12:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2AEE238D53;
	Wed, 21 May 2025 09:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y8+9ljIE"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 986492343BE;
	Wed, 21 May 2025 09:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747818775; cv=none; b=AKDTIXgNz6L84tmq2X1mHUl6ZOvBpq0eBQOELytIjFKuK7x7oZEKvccm2tP1oag/xzXMvGK4NeJnhVh1fnDe/CYo79CUFeqJtuuGdv36umU0udP8xjIBxpCCXyVQ2l7H3zeQlutD5pbaHkd4+6qkN8Ua9DBn9pjWfbU6ffCltUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747818775; c=relaxed/simple;
	bh=gx5MmDJv49+IdFprNwhaD0Z3zaBUOM5InwhvPfZ3TH8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=apoM5znN17RlGfJ/hyH20ESy5UUzzbCPPWn0/knrfllHw/QCTWHWiF8ia+RE/q79jGIcdbNLhVXTM/f1KZIDKM6Vyr1c0Qwqq1cJ51bfXQljPm8VCBAOMQIm/qF6Lav+6u3cJsB8P1Kx7MemMqXAJqGPllZDPICfUYoAQ26GnXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y8+9ljIE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BDFBC4CEEA;
	Wed, 21 May 2025 09:12:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747818774;
	bh=gx5MmDJv49+IdFprNwhaD0Z3zaBUOM5InwhvPfZ3TH8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Y8+9ljIENsbbGqVUqx2DH3iah8HtB1+JwIRF/Bex73joh1thhmsxg3R7rzGusGdex
	 LE2HlQOhjlB0Czt/TnEdEy3dtDkYMKrVZgFoTODW2rSDj5nJB2bSGJpliDJ1TP3CoL
	 G5BZHE5d0QLhzVXNQafluxEZ4egnMFRHNliL/Tqn0ZoWXAx9KW7e98kznRuRYjvxzm
	 fWGd6t0z1OmMSnQmqEMtL8Pi8n87OIpWM+QpyVdRjSbyBIoIroREQKHBX9+UplunDb
	 0dTom5VC/6Ah8L6VzfIEbvuY260Vwcj2XD8mnOXn9POEMfU/x0JKdOIxYvvDC43IPo
	 54HsBZVZCLcXw==
Date: Wed, 21 May 2025 10:12:49 +0100
From: Simon Horman <horms@kernel.org>
To: Jijie Shao <shaojijie@huawei.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, andrew+netdev@lunn.ch, shenjian15@huawei.com,
	wangpeiyang1@huawei.com, liuyonglong@huawei.com,
	chenhao418@huawei.com, jonathan.cameron@huawei.com,
	shameerali.kolothum.thodi@huawei.com, salil.mehta@huawei.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 net 2/2] net: hibmcge: fix wrong ndo.open() after
 reset fail issue.
Message-ID: <20250521091249.GT365796@horms.kernel.org>
References: <20250517095828.1763126-1-shaojijie@huawei.com>
 <20250517095828.1763126-3-shaojijie@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250517095828.1763126-3-shaojijie@huawei.com>

On Sat, May 17, 2025 at 05:58:28PM +0800, Jijie Shao wrote:
> If the driver reset fails, it may not work properly.
> Therefore, the ndo.open() operation should be rejected.
> 
> In this patch, the driver calls netif_device_detach()
> before the reset and calls netif_device_attach()
> after the reset succeeds. If the reset fails,
> netif_device_attach() is not called. Therefore,
> netdev does not present and cannot be opened.
> 
> If reset fails, only the PCI reset (via sysfs)
> can be used to attempt recovery.
> 
> Fixes: 3f5a61f6d504 ("net: hibmcge: Add reset supported in this module")
> Signed-off-by: Jijie Shao <shaojijie@huawei.com>
> ---
> ChangeLog:
> v1 -> v2:
>   - Use netif_device_detach() to block netdev callbacks after reset fails, suggested by Jakub.
>   v1: https://lore.kernel.org/all/20250430093127.2400813-1-shaojijie@huawei.com/

Reviewed-by: Simon Horman <horms@kernel.org>


