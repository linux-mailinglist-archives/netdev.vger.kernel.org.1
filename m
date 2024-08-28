Return-Path: <netdev+bounces-122816-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC7D3962A7E
	for <lists+netdev@lfdr.de>; Wed, 28 Aug 2024 16:40:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4A709B2371C
	for <lists+netdev@lfdr.de>; Wed, 28 Aug 2024 14:40:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4AAB19AD4F;
	Wed, 28 Aug 2024 14:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ocqQ9RYV"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D36F45C1C;
	Wed, 28 Aug 2024 14:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724856029; cv=none; b=ru8AcikOEyPKb3QTRpQH3UjfEIPyvV5eRjvL+izC2Fdbgoj12m/m6/l4TFUETq73tMfZkbPR/51+rd9karZulxMmVWMQiKGbi3+dBRL8mwiXZB9hDQSBGvYfC7OOpKyn5RCWRS+hsX9n/e/a7JgozheMOc68NV0dBvOP1+I0ZvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724856029; c=relaxed/simple;
	bh=nCFz6dSlujuWd01lKB2NBqXbXkMEN9z0fagzamdOQRA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gvStuj0cX9AE8ZbCDPIpdHfV3fdEYtPzaqWfFq6kbo0lWICa4hjBVLdvGWuii5B3Pym8dK1lZtxwgGxDfgne4aLO3yU77r1typ1LoRLOsnXC3/BmIKa6rhn+AoNB14+LvQhKMobZfyfzWt3aimHIghXapBKlavlOorWzEie5N5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ocqQ9RYV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3379C4CAD3;
	Wed, 28 Aug 2024 14:40:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724856029;
	bh=nCFz6dSlujuWd01lKB2NBqXbXkMEN9z0fagzamdOQRA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ocqQ9RYVBeDBN5c38dSZF3GxwpRqwB0UpPzTXtdtZgnljpkfnmq6ZXSMCuWBcTdZt
	 RDRJer2vU0Pk0PBrr2RwkWEM+iqylxD2FfAHHFeQHaPqnELHRBXgB96EF2tjnTfbjH
	 ctCDVcFtsH7DZ8YeRcxY24QLD/VKM2HKbxaVbtlmFVv4nevEt6v9Xe+KFLRBtwuHXH
	 953mdwNECZAAPQUFN+PqMsH6ODb6lPnl7xiAx8wbfxaTylRUtoKaizr49JxsCkvPd5
	 n0rgzhFr21KGCyg9BhxwrKTEW3OMEVleVckHxIoOpduSdmvqf9CL22z0pHkyZO+oFn
	 Q+4SZz4GOub8A==
Date: Wed, 28 Aug 2024 15:40:25 +0100
From: Simon Horman <horms@kernel.org>
To: Stefan Wahren <wahrenst@gmx.net>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/5 next] net: vertexcom: mse102x: Fix random MAC address
 log
Message-ID: <20240828144025.GK1368797@kernel.org>
References: <20240827191000.3244-1-wahrenst@gmx.net>
 <20240827191000.3244-4-wahrenst@gmx.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240827191000.3244-4-wahrenst@gmx.net>

On Tue, Aug 27, 2024 at 09:09:58PM +0200, Stefan Wahren wrote:
> At the time of MAC address assignment the netdev is not registered yet,
> so netdev log functions won't work as expected. While we are at this
> downgrade the log level to a warning, because a random MAC address is
> not a real error.
> 
> Signed-off-by: Stefan Wahren <wahrenst@gmx.net>

Reviewed-by: Simon Horman <horms@kernel.org>


