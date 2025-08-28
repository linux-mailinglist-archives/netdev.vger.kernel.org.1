Return-Path: <netdev+bounces-217794-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 20E0FB39D8A
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 14:41:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 88F1A985EF0
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 12:41:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 518E030F95B;
	Thu, 28 Aug 2025 12:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HZVpIPZA"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BDB930F940
	for <netdev@vger.kernel.org>; Thu, 28 Aug 2025 12:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756384883; cv=none; b=E+cUsufs88umgQTFeRMgyyVopcAuqhepupcTQUMVjBZ98vIuVv7NZzRg1WiNywLbxRoIvLDw3KEd5AFPmyWa9H7bEt5fbFBZ9YQgubp1YW614Y9WG31/vipEhgi1R2blYxGDJeETwsiCVjSrYNwgmhTnpsRa2HRhoAnQs+0+lKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756384883; c=relaxed/simple;
	bh=U4whXLIBxXZUBK60jMsmHVBJudPyhO1Q5uErtKyTrtA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JIo1EYnTTH7N9J5rXkA1+gD3a/rCQJN80uhsU1H4Q/ZKnE+B+LHlGlFuHeoNMulvKT5FgYysz8/9vL1B00VqXC5UTh8gzrtHC5e38oqh4eBF3MiXS4Vi1BccU7icsslW16Y5Ngw8d0V2HvAY829tUEZOh2WQpf9xt61pS6y0luI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HZVpIPZA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C01EC4CEEB;
	Thu, 28 Aug 2025 12:41:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756384882;
	bh=U4whXLIBxXZUBK60jMsmHVBJudPyhO1Q5uErtKyTrtA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HZVpIPZAlOaMccuJAtoxwaqW3kbQ0LwsrON57ROyYBhmgvMunDiqUkLyxYjT+x4NS
	 0acbj2pSma2E3k9XXFhfwfiyjBY/bOn0xkq7sQY+vrkBO70aF0n9MbHSmRPImsxjaA
	 8ZtvX5uKvsAYiS/ekzZH7ogczZtUpigE/tdBb4bGNbOtblCAOT0/knLHOx0oKzENZw
	 NSCFphFtrzN3H+lI2ovRXHpitv6syNeKPabUs0lEqNVQ9Fvw/katW+GGO1QzNE3Vzs
	 Twsj2Ja6tY+R+iXneAILYOHg+u2fcQ059e+hJUyS+axWw6ehiLagTdr1ACVT1XbomP
	 sjLJnLQYBjrvg==
Date: Thu, 28 Aug 2025 13:41:18 +0100
From: Simon Horman <horms@kernel.org>
To: Saeed Mahameed <saeed@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	Saeed Mahameed <saeedm@nvidia.com>, netdev@vger.kernel.org,
	Tariq Toukan <tariqt@nvidia.com>, Gal Pressman <gal@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>, mbloch@nvidia.com
Subject: Re: [PATCH net-next V2 7/7] net/mlx5: {DR,HWS}, Use the cached
 vhca_id for this device
Message-ID: <20250828124118.GH10519@horms.kernel.org>
References: <20250827044516.275267-1-saeed@kernel.org>
 <20250827044516.275267-8-saeed@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250827044516.275267-8-saeed@kernel.org>

On Tue, Aug 26, 2025 at 09:45:16PM -0700, Saeed Mahameed wrote:
> From: Saeed Mahameed <saeedm@nvidia.com>
> 
> The mlx5 driver caches many capabilities to be used by mlx5 layers.
> 
> In SW and HW steering we can use the cached vhca_id instead of invoking
> FW commands.
> 
> Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>

Reviewed-by: Simon Horman <horms@kernel.org>


