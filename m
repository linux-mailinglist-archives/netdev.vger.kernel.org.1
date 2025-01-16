Return-Path: <netdev+bounces-159099-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92739A14570
	for <lists+netdev@lfdr.de>; Fri, 17 Jan 2025 00:21:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD45416399D
	for <lists+netdev@lfdr.de>; Thu, 16 Jan 2025 23:21:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 856C81DDC02;
	Thu, 16 Jan 2025 23:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y0bTgwOU"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6120024335E
	for <netdev@vger.kernel.org>; Thu, 16 Jan 2025 23:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737069698; cv=none; b=H988EyUQ2A5DM1R20l8gPk7a78YqXaa1D7WiJXbkf0M6d33ws5tpw783qcGV5ElcyShUBotsW+Op8XfPJ4gak95TLRgUhZGJXJYVD/jFsOL8JJasnqN/KhI/lAbQqVcubvWu7dcG3WMOQ6DE83cfELg8R32S4MNsA45EuAavKhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737069698; c=relaxed/simple;
	bh=GEH8SxCnJrnh8IdRarRxjGJShiARiUciH38q+TMYh0U=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=E234iVObxNVyh1AuXuziaF/ygcxuTkmQZHs3DuXa91d8GRVMDirTWwXRVvfDloz636FONkirfEunvXDmvWozDXQOupSCr/ROVWTFYgIBPqJnGlWWFI4FcLkmcMwyBRqsLyBOEjpogmFc2BPRbfYIQSHITQ65LKsO2pNNRg4iCoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y0bTgwOU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A6E8C4CEE4;
	Thu, 16 Jan 2025 23:21:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737069697;
	bh=GEH8SxCnJrnh8IdRarRxjGJShiARiUciH38q+TMYh0U=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Y0bTgwOUq95ATz0HeNgZMB2fzcvwf0ZZtnzd180TvnH121QKFNoa9wYG+wg+j+HW9
	 MKbqtZk7NBQJFBJ4oEEep/glQOhqgj6WQocp71XytSd+vOkYfCla6cgRT4GkI79Xks
	 ZV9Pdez+Rg2zZJ7Mg5opqDWm6bEDfdfLbv1FVSiaCG27COKKNiJ5WqvUaJNBupBSMp
	 6cKi+UM7PQd6ezSL12HePWEk/cDS+LxgSe0VJ52NTd8YlSGCtzrWDYHFMGWFfozCCC
	 wTN0Hzks0mluVKZ5jvoWifGSviDmnDBQfPrv9VumAfonLlCyKb58Fm7mcjPr6u8EgA
	 +6yBKzY6m1L4Q==
Date: Thu, 16 Jan 2025 15:21:36 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Saeed Mahameed <saeed@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>, Paolo Abeni
 <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, Saeed Mahameed
 <saeedm@nvidia.com>, netdev@vger.kernel.org, Tariq Toukan
 <tariqt@nvidia.com>, Gal Pressman <gal@nvidia.com>, Leon Romanovsky
 <leonro@nvidia.com>, Dragos Tatulea <dtatulea@nvidia.com>
Subject: Re: [net-next 10/11] net/mlx5e: Implement queue mgmt ops and single
 channel swap
Message-ID: <20250116152136.53f16ecb@kernel.org>
In-Reply-To: <20250116215530.158886-11-saeed@kernel.org>
References: <20250116215530.158886-1-saeed@kernel.org>
	<20250116215530.158886-11-saeed@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 16 Jan 2025 13:55:28 -0800 Saeed Mahameed wrote:
> +static const struct netdev_queue_mgmt_ops mlx5e_queue_mgmt_ops = {
> +	.ndo_queue_mem_size	=	sizeof(struct mlx5_qmgmt_data),
> +	.ndo_queue_mem_alloc	=	mlx5e_queue_mem_alloc,
> +	.ndo_queue_mem_free	=	mlx5e_queue_mem_free,
> +	.ndo_queue_start	=	mlx5e_queue_start,
> +	.ndo_queue_stop		=	mlx5e_queue_stop,
> +};

We need to pay off some technical debt we accrued before we merge more
queue ops implementations. Specifically the locking needs to move from
under rtnl. Sorry, this is not going in for 6.14.
-- 
pw-bot: defer

