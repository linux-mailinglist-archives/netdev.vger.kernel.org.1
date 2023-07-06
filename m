Return-Path: <netdev+bounces-15691-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D28874941E
	for <lists+netdev@lfdr.de>; Thu,  6 Jul 2023 05:20:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EDDD92811C4
	for <lists+netdev@lfdr.de>; Thu,  6 Jul 2023 03:20:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D9C0A5F;
	Thu,  6 Jul 2023 03:20:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 413C3A5A
	for <netdev@vger.kernel.org>; Thu,  6 Jul 2023 03:20:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7102EC433C7;
	Thu,  6 Jul 2023 03:20:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1688613627;
	bh=5O6cTxQB7xCqipUxg5XXoLR9CJwTYL046nVAGAx4szI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=gHoApyT/aFRh9+b+VNFMurHUf5KSG0twH99icPN/CrFLniXMt9q0dsbEt2x71AYUR
	 gPqqvqOygxVnyueuR8JbNfe0dO965Pjt/8E60vnfb5daeSn9bPG8AKfHklYm84n0yd
	 GyY93IQe5cBdh2ncbayY1w++PWEVjhIHKo5XNrZ/BVOm4hKzqyWgcmak9xgiVmf8Zf
	 q9qXHtGhz1ZUtLwnWzlZz+QiitgSpTPeTD/8aSjeN3lQenxRqnf4sgNkrl0+5I+LM8
	 mkgKgaFFQtcR6nIT7VAi2KUAP1fvCCW7u9MaxbOo0s8fPr8GdgdGtWlfJypQ5seyL8
	 x+23BIQNvlvOg==
Date: Wed, 5 Jul 2023 20:20:26 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Saeed Mahameed <saeed@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>, Paolo Abeni
 <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, Saeed Mahameed
 <saeedm@nvidia.com>, netdev@vger.kernel.org, Tariq Toukan
 <tariqt@nvidia.com>, Sandipan Patra <spatra@nvidia.com>
Subject: Re: [net V2 5/9] net/mlx5: Register a unique thermal zone per
 device
Message-ID: <20230705202026.4afaff91@kernel.org>
In-Reply-To: <20230705175757.284614-6-saeed@kernel.org>
References: <20230705175757.284614-1-saeed@kernel.org>
	<20230705175757.284614-6-saeed@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed,  5 Jul 2023 10:57:53 -0700 Saeed Mahameed wrote:
> Prior to this patch only one "mlx5" thermal zone could have been
> registered regardless of the number of individual mlx5 devices in the
> system.
> 
> To fix this setup a unique name per device to register its own thermal
> zone.
> 
> In order to not register a thermal zone for a virtual device (VF/SF) add
> a check for PF device type.
> 
> The new name is a concatenation between "mlx5_" and "<PCI_DEV_BDF>", which
> will also help associating a thermal zone with its PCI device.
> 
> $ lspci | grep ConnectX
> 00:04.0 Ethernet controller: Mellanox Technologies MT2892 Family [ConnectX-6 Dx]
> 00:05.0 Ethernet controller: Mellanox Technologies MT2892 Family [ConnectX-6 Dx]
> 
> $ cat /sys/devices/virtual/thermal/thermal_zone0/type
> mlx5_0000:00:04.0
> $ cat /sys/devices/virtual/thermal/thermal_zone1/type
> mlx5_0000:00:05.0

Damn, that's strange. What's the reason you went with thermal zone
instead of a hwmon device?

