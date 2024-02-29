Return-Path: <netdev+bounces-76266-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CC6D386D0B1
	for <lists+netdev@lfdr.de>; Thu, 29 Feb 2024 18:32:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 673FE1F212D0
	for <lists+netdev@lfdr.de>; Thu, 29 Feb 2024 17:32:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A29970AC9;
	Thu, 29 Feb 2024 17:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KfpzfVLc"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D90DB6CBF3
	for <netdev@vger.kernel.org>; Thu, 29 Feb 2024 17:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709227940; cv=none; b=fy9wvH24ZmPqaHdBG9Z7J9blHC839KdCpGYMEoMT2pSoLlUl8TnfZwdJ1ofTG3vF/NkwUe459I9dyCEHqFncOmNtW2lmEdzsV2+GK4ghIzExurrqtl8yMSLpR3ZsZUb9Xv+pO899dGmgwYJfLA954qCnAqGJKGY6fxP0MIIyMug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709227940; c=relaxed/simple;
	bh=6LGlImUK7rSKYWRoGsL/pBddKtG8DXuDhDX5LCAQHFw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Lyik8NZ1OIpPp0OOcGRebnGX6zNHSm4AEE6cmqEPHwlAN5iwn9E+CX5pbSg9aZJQcjBqzdPRkFxZO/MTUsdYUntvnjQ7YkHos2xH040iOZ029WnHt11PkpLQH5JeJLLnhsMbihSJb3zOD1ju0c+l1NF96/SHL2Ygqzt3jKBbzoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KfpzfVLc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EABC9C433F1;
	Thu, 29 Feb 2024 17:32:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709227940;
	bh=6LGlImUK7rSKYWRoGsL/pBddKtG8DXuDhDX5LCAQHFw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=KfpzfVLc3zNF3jBMVnTsJ/oGW0qRnnzYQc5ahB4WtE8VdaF2Rql0PV5Q9YcG0hxy9
	 M9XlKb+unOTgqEl8AEKPTFem+7Tuyu/s42IIwbqbwhqOIdsNQNQBpfAZZ973ys/adE
	 XgJgRgQwjA3DwKeyMKqpaOcT6AT3hZQD8W+ZvOi/I5fS82h85nYyK6LvjQBFlC3Uha
	 X9eMNqdImlbjK5z6osA+aKW4fiVm9Jej26lFDa66XqohE9hLsiJidUnGrOOJgklsJf
	 v2BDNIJ/gogrxiuLjJwZkIjKtT5NPgzwNsxBNydAUlw0fBsEuW+1P4JDOMbbNvJIvY
	 f0ravbQ5tN5Zg==
Date: Thu, 29 Feb 2024 09:32:19 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Aurelien Aptel <aaptel@nvidia.com>
Cc: linux-nvme@lists.infradead.org, netdev@vger.kernel.org,
 sagi@grimberg.me, hch@lst.de, kbusch@kernel.org, axboe@fb.com,
 chaitanyak@nvidia.com, davem@davemloft.net, aurelien.aptel@gmail.com,
 smalin@nvidia.com, malin1024@gmail.com, ogerlitz@nvidia.com,
 yorayz@nvidia.com, borisp@nvidia.com, galshalom@nvidia.com,
 mgurtovoy@nvidia.com, edumazet@google.com
Subject: Re: [PATCH v23 00/20] nvme-tcp receive offloads
Message-ID: <20240229093219.66d69339@kernel.org>
In-Reply-To: <20240228125733.299384-1-aaptel@nvidia.com>
References: <20240228125733.299384-1-aaptel@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 28 Feb 2024 12:57:13 +0000 Aurelien Aptel wrote:
> The next iteration of our nvme-tcp receive offload series.

drivers/net/ethernet/mellanox/mlx5/core/en_accel/nvmeotcp.c:1017:8-122: WARNING avoid newline at end of message in NL_SET_ERR_MSG_MOD
drivers/net/ethernet/mellanox/mlx5/core/en_accel/nvmeotcp.c:1023:8-109: WARNING avoid newline at end of message in NL_SET_ERR_MSG_MOD

