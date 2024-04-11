Return-Path: <netdev+bounces-86835-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 99DA98A0638
	for <lists+netdev@lfdr.de>; Thu, 11 Apr 2024 04:52:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4C2591F2579A
	for <lists+netdev@lfdr.de>; Thu, 11 Apr 2024 02:52:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F65413B28D;
	Thu, 11 Apr 2024 02:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kV0e3ttC"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BD9E5F870
	for <netdev@vger.kernel.org>; Thu, 11 Apr 2024 02:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712803968; cv=none; b=B2Hu84MuzBm1oApQz0lhhaSIF0tMZjhP7NaMLvOQkXRVsbck7I1fx+znTVtXTrKIMDL1Beih5tGbr3/+grgFJ+NCdAl21TRExRkjXMuDuL3QQUVEyIVay6emtWGw5apSmeHLq6sjTEn3E5xzLzpUQJiftlNa1XtfEbX4QbWNXwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712803968; c=relaxed/simple;
	bh=HsG1F+mYMZh3m/koao6pf7s5VFsSdNGH4BmOZWjnqeU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=M2tb1QSRwRndTEGaq/NNGSNNKuhE0tpphDcaLxDpuWCdqE/Uhv0N4fyoTrUpNWZ3bmvfILBrXoe8Hu5y8MybdXVcEEDmglYCOhIhlkE4PPpH7JJHoCz0iP2xrP/JqOi+GXmbn2j48YrslLBfynij9DddWJ83Azsnw3HqKCk1p3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kV0e3ttC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96B35C433C7;
	Thu, 11 Apr 2024 02:52:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712803968;
	bh=HsG1F+mYMZh3m/koao6pf7s5VFsSdNGH4BmOZWjnqeU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=kV0e3ttCvvXqjaytncSVNCCkypML+y7eGmcJwUQPEl6xmzZ9ZXky7Bew+6scWwQSR
	 1ICB0O6sudWvBfaXGaCyPGmSdReJBXXTsaZd7JJeQ/cnY9emUbKUlGGHTZQF2jeLsS
	 tgyVHBS5a6N1NEJ2g75CcH+NSI1JJnzFxsa8uzOVH7nqSlUD8PzV0wUwO9yNXFYfsA
	 hOIGNQHzDGTpFpjDU6Oe/pcLnCsE6yZvOSyk15jNhcXIQdL9ZYo58k5e7++Ulke8Um
	 XF1GSuw5P+VnEFy0E3rXI/X1OTfxHzGgDHb25puT/koCDk2A555+ace7ubLMFrF3//
	 IoI15+aVWjxlg==
Date: Wed, 10 Apr 2024 19:52:46 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Tariq Toukan <ttoukan.linux@gmail.com>
Cc: Dan Carpenter <dan.carpenter@linaro.org>, Tariq Toukan
 <tariqt@nvidia.com>, "David S. Miller" <davem@davemloft.net>, Paolo Abeni
 <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
 netdev@vger.kernel.org, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
 <gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>
Subject: Re: [PATCH net V2 12/12] net/mlx5: SD, Handle possible devcom
 ERR_PTR
Message-ID: <20240410195246.3ea983da@kernel.org>
In-Reply-To: <43f4a10f-b5d1-4a1e-a765-c2324d03c6a7@gmail.com>
References: <20240409190820.227554-1-tariqt@nvidia.com>
	<20240409190820.227554-13-tariqt@nvidia.com>
	<ebf275e7-f986-436d-b665-3320a04eb83e@moroto.mountain>
	<43f4a10f-b5d1-4a1e-a765-c2324d03c6a7@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 10 Apr 2024 21:16:37 +0300 Tariq Toukan wrote:
> Touching mlx5_devcom_register_component() as a fix for commit 
> d3d057666090 ("net/mlx5: SD, Implement devcom communication and primary 
> election") doesn't look right to me.
> In addition, I prefer minimal fixes to net.
> 
> After this one is accepted to net, we can enhance the code in a followup 
> patch to net-next.

I think the official guidance from Greg is "fix it right, worry about
size of the change when stable backport fails".
mlx5_devcom_register_component() has 4 callers, please follow Dan's advice.
I'll apply other 11 patches.

