Return-Path: <netdev+bounces-66084-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2051C83D2A7
	for <lists+netdev@lfdr.de>; Fri, 26 Jan 2024 03:40:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 532B01C21B12
	for <lists+netdev@lfdr.de>; Fri, 26 Jan 2024 02:40:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDC948C02;
	Fri, 26 Jan 2024 02:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QnEUqWYe"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9AD6AD21
	for <netdev@vger.kernel.org>; Fri, 26 Jan 2024 02:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706236832; cv=none; b=Ou/lFF6H1KmFYADadItIcilnb0fh2EA3Jkk3ZO9mOGJaC/6CcZTlMgxzd7U5CtNwpuwkGLw8lISGGcHtiQ55wme3r8/xid9pcs1fUIthcM7hnMOQeRJ+rc80ZKTgfZaXGhh7nRFvy+Xr766Ad/43qpC6ke7Tuyx7yvfRT7LKf1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706236832; c=relaxed/simple;
	bh=l7G2s0EaRPs+Mgo2IZZntnCB01GO108zkohsGxkw9XI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iDi45nGy+SnPavmLAK5ple6Kx4F4B1kIeTvEHuPw+UxdiBPqI912i4IrZ1t8ZxYjPQXaNjyk//50VMmCjJhZ6QXnKMiFKGTyZlvj/zckxwDqfNjUuYP+9AYtG9O5xCyZ/svYa7husIgtqOsCV1yGILRigWBxBRhOnPGZVZTIB94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QnEUqWYe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E798DC433F1;
	Fri, 26 Jan 2024 02:40:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706236832;
	bh=l7G2s0EaRPs+Mgo2IZZntnCB01GO108zkohsGxkw9XI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=QnEUqWYey2ydukRZO+v+QhX1xioPK0IUhaXZ0NEMBAwd5nraSvq+cdkOAL7FARq6o
	 c90S3kSNSYHv8+vw7vBlGXfLgCxJrn35xpW57uV6IgRwbv94n17lhQH6YkJvi/NicT
	 dTkF8SfbWDlfiULsm0kQWSJ0Ykei/LiWg50C9jmZ2BAvoWfoVVIC8TukT47nt5nDN2
	 bbpDmYruCpYILJa7UTVvZaDF7inBsKtGN/rNjaV1Js+KU9lR0I4U/Ij+Ta5QNQcFpe
	 2WVXQbwX3dHpeKP4pASrlpxFAn8E5jhXgdJiXXx5602MSUNmxU7GCIlFtqutWXWZfv
	 2fk85AvZpSaYg==
Date: Thu, 25 Jan 2024 18:40:31 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Tariq Toukan <ttoukan.linux@gmail.com>
Cc: Gal Pressman <gal@nvidia.com>, Saeed Mahameed <saeed@kernel.org>, "David
 S. Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>, Eric
 Dumazet <edumazet@google.com>, Saeed Mahameed <saeedm@nvidia.com>,
 netdev@vger.kernel.org, Tariq Toukan <tariqt@nvidia.com>
Subject: Re: [net-next 10/15] net/mlx5e: Let channels be SD-aware
Message-ID: <20240125184031.5ddc5799@kernel.org>
In-Reply-To: <4bb155ee-f727-449f-bd88-ba117107a88f@gmail.com>
References: <20231221005721.186607-1-saeed@kernel.org>
	<20231221005721.186607-11-saeed@kernel.org>
	<20240104145041.67475695@kernel.org>
	<effce034-6bc5-4e98-9b21-c80e8d56f705@nvidia.com>
	<20240108190811.3ad5d259@kernel.org>
	<d0ce07a6-2ca7-4604-84a8-550b1c87f602@nvidia.com>
	<20240109080036.65634705@kernel.org>
	<9d29e624-fc02-44cd-9a92-01f813e66eed@nvidia.com>
	<4bb155ee-f727-449f-bd88-ba117107a88f@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 25 Jan 2024 10:01:05 +0200 Tariq Toukan wrote:
> Exactly. That's the desired configuration.
> Our driver has the logic to set it in default.
> 
> Here's the default XPS on my setup:
> 
> NUMA:
>    NUMA node(s):          2
>    NUMA node0 CPU(s):     0-11
>    NUMA node1 CPU(s):     12-23
> 
> PF0 on node0, PF1 on node1.

Okay, good that you took care of the defaults, but having a queue per
CPU thread is quite inefficient. Most sensible users will reconfigure
your NICs and remap IRQs and XPS. Which is fine, but we need to give
them the necessary info to do this right - documentation and preferably
the PCIe dev mapping in the new netlink queue API.

