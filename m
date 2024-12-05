Return-Path: <netdev+bounces-149274-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A26699E4FD2
	for <lists+netdev@lfdr.de>; Thu,  5 Dec 2024 09:35:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E46E18821FF
	for <lists+netdev@lfdr.de>; Thu,  5 Dec 2024 08:35:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0AA81CFEDB;
	Thu,  5 Dec 2024 08:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uaGX72rD"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82A27189B94;
	Thu,  5 Dec 2024 08:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733387732; cv=none; b=d+u7/oOlKwpCeM4izYCj5wkTv1P6wTFk12iRxcJlGoOAtHomMJMk4reTM+Llkv7XuNff6b1iDz/M3wM2Ts31ySu4KMM32UzGbIPNyNuYC+v1MzhZFab4jjYPnfwx3lGNzeilvfyyfn9phRs5Z+ZeA9nD6q/iJIkLVXJ88W/+96c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733387732; c=relaxed/simple;
	bh=ML/ardD0z1uosu6M7tcYExFvbVAVmCfVLhbevAHBJXU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Dl97BHSnwdm9DDqliL6VgclL8Gph072lA62KpEIa2VAUh5KHbtMvHNMIYXi4NA0uBNZC0+Gx3qgeb/AbRtvMwN5D6PtTmuXMqcCshtectmS+6FpS2NGMmKpCq3I5qWfjXY3v59iw7WgNzaLEBHP+yGV/dG9W0PBx8uBrW3FdCnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uaGX72rD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2072C4CED1;
	Thu,  5 Dec 2024 08:35:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733387732;
	bh=ML/ardD0z1uosu6M7tcYExFvbVAVmCfVLhbevAHBJXU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=uaGX72rDQvKiVI+YVEcw86p3Lis2LkRb36c6mek7WaNbGD2ZlTEBTjsaQinNCCudW
	 T+xfXjB7IZxHVQ9JJ7ZYADrTj2qWcdlf6+zho6ke4MZGLyt3Dc+ci/rxSwz0+Lvnlk
	 e9HfmSTq2Hme7ETtSfwisbXHEACvJyLTQgzWMIzYz4GWFOzLPQx3MtUN81Lhz/VpDY
	 NEPN/G/ZiY/9Q+8GtXSUtYYPlX6FC8WMOl82OAdLwh61ho6O5nPo4DDdtoZowZkKr5
	 dre0xHVpDcjoVV8Af7ehl7ZG0O0uHeEeTYN3xOHD1dzBqaAZk85hA/582vY2vWi3PR
	 FCnAhiBNXGPAw==
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>
Cc: Patrisious Haddad <phaddad@nvidia.com>, 
 Daniel Jurgens <danielj@mellanox.com>, linux-rdma@vger.kernel.org, 
 Mark Bloch <mbloch@nvidia.com>, netdev@vger.kernel.org, 
 Parav Pandit <parav@mellanox.com>, Saeed Mahameed <saeedm@nvidia.com>, 
 Tariq Toukan <tariqt@nvidia.com>
In-Reply-To: <88699500f690dff1c1852c1ddb71f8a1cc8b956e.1733233480.git.leonro@nvidia.com>
References: <88699500f690dff1c1852c1ddb71f8a1cc8b956e.1733233480.git.leonro@nvidia.com>
Subject: Re: [PATCH mlx5-next] RDMA/mlx5: Enforce same type port
 association for multiport RoCE
Message-Id: <173338772880.3901067.3597231014649994088.b4-ty@kernel.org>
Date: Thu, 05 Dec 2024 03:35:28 -0500
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-37811


On Tue, 03 Dec 2024 15:45:37 +0200, Leon Romanovsky wrote:
> Different core device types such as PFs and VFs shouldn't be affiliated
> together since they have different capabilities, fix that by enforcing
> type check before doing the affiliation.
> 
> 

Applied, thanks!

[1/1] RDMA/mlx5: Enforce same type port association for multiport RoCE
      https://git.kernel.org/rdma/rdma/c/e05feab22fd7da

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>


