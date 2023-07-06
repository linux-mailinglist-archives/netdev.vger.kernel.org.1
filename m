Return-Path: <netdev+bounces-15717-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8092074955C
	for <lists+netdev@lfdr.de>; Thu,  6 Jul 2023 08:09:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B16BF1C20CB6
	for <lists+netdev@lfdr.de>; Thu,  6 Jul 2023 06:09:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0A7610EF;
	Thu,  6 Jul 2023 06:09:39 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CFE0137C
	for <netdev@vger.kernel.org>; Thu,  6 Jul 2023 06:09:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1335C433C8;
	Thu,  6 Jul 2023 06:09:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1688623777;
	bh=gsKDq6JhAdjrQfpwPnMwuUbkGAWdvyvJIMkbRtxPZY4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VePN/xW70ls5zeafO7Ee0n+igIkQtWMRzEoWqBKnwoDpRKApWXrCbQDx3V4D59r0b
	 0Rlf+RkIxz61p5AvaYTrtFCizGRPdRwU707i4Y9GTwKQ1Pel5bLMsN3AnHpNStiKlV
	 Hoyf1W33/0Xxkj5uegBSdfbN64AxemZPlpIe9WpKiM7wl4tTuE9TK3lK8HEIt+mPCM
	 kGAa0JmUCxSLpATdLxHwcL9kG73YASIE2tGiHG4ClwhJynDsaOsqTMjoyFF2KPAPoo
	 wQf6urCqopIofRMX1J81yfGHNLOyNKdA/UBjUYHdM0xUpmCeNCYyCXJH9h8lDePhoA
	 rhMr8LNYBtSSg==
Date: Wed, 5 Jul 2023 23:09:36 -0700
From: Saeed Mahameed <saeed@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
	Saeed Mahameed <saeedm@nvidia.com>, netdev@vger.kernel.org,
	Tariq Toukan <tariqt@nvidia.com>,
	Sandipan Patra <spatra@nvidia.com>
Subject: Re: [net V2 5/9] net/mlx5: Register a unique thermal zone per device
Message-ID: <ZKZaoIw86D1b6EXn@x130>
References: <20230705175757.284614-1-saeed@kernel.org>
 <20230705175757.284614-6-saeed@kernel.org>
 <20230705202026.4afaff91@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20230705202026.4afaff91@kernel.org>

On 05 Jul 20:20, Jakub Kicinski wrote:
>On Wed,  5 Jul 2023 10:57:53 -0700 Saeed Mahameed wrote:
>> Prior to this patch only one "mlx5" thermal zone could have been
>> registered regardless of the number of individual mlx5 devices in the
>> system.
>>
>> To fix this setup a unique name per device to register its own thermal
>> zone.
>>
>> In order to not register a thermal zone for a virtual device (VF/SF) add
>> a check for PF device type.
>>
>> The new name is a concatenation between "mlx5_" and "<PCI_DEV_BDF>", which
>> will also help associating a thermal zone with its PCI device.
>>
>> $ lspci | grep ConnectX
>> 00:04.0 Ethernet controller: Mellanox Technologies MT2892 Family [ConnectX-6 Dx]
>> 00:05.0 Ethernet controller: Mellanox Technologies MT2892 Family [ConnectX-6 Dx]
>>
>> $ cat /sys/devices/virtual/thermal/thermal_zone0/type
>> mlx5_0000:00:04.0
>> $ cat /sys/devices/virtual/thermal/thermal_zone1/type
>> mlx5_0000:00:05.0
>
>Damn, that's strange. What's the reason you went with thermal zone
>instead of a hwmon device?

hwmon is planned for next release, it will replace the thermal. Internal
code review is almost done.
I just wanted to fix this so those who still have old kernel will at least
enjoy the thermal interface :) ..


