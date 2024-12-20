Return-Path: <netdev+bounces-153575-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EAC59F8AA3
	for <lists+netdev@lfdr.de>; Fri, 20 Dec 2024 04:34:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A2A6166428
	for <lists+netdev@lfdr.de>; Fri, 20 Dec 2024 03:34:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69CD328399;
	Fri, 20 Dec 2024 03:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eIDyX5ve"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4553F282F1
	for <netdev@vger.kernel.org>; Fri, 20 Dec 2024 03:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734665645; cv=none; b=PIdn3IZJ9DLQKE6olYA1hd9J1EMjp1x8ZhXPPFF3aCvmdH2/XIhRjjcf9scLW/E6A4nmVOHQgwJ913vk17/ZGRRnxFpEQ9C76ybOgtvl0kie8LZSTOjK5WocQsaVLUUAz/OgzOYr1BrZrjYg2ki3EpmjPraLfnAtKUEfVQZ/ERM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734665645; c=relaxed/simple;
	bh=+yhg/J/H/JiyymzZN5RtIGJ4fNLEM2C3IiQXtZlZygs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Fmyy3NJ52NE+qzJ8VrvLP0qTveKdA6YiXDJrNTJHBMoV5MVpuNE3VvcGm15vcM/qruoVbpSAhCjCd6j47SxlAt/Xd1BZQca3RIUlqVCK2Qf+ekKH7RzQQga9pdczHB2Bg1SWo03XLcU6uzHNH/FoCISqLkqBI82HquQaWgwwy6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eIDyX5ve; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52CC4C4CECE;
	Fri, 20 Dec 2024 03:34:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734665644;
	bh=+yhg/J/H/JiyymzZN5RtIGJ4fNLEM2C3IiQXtZlZygs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=eIDyX5vefJ7R9llhkmTQR8tb5gdBkhk3eHdcPjgBmo0jL9eQCTMoXLXzwKc9xj3bI
	 T2RbozKXv2dwB4aPYwnccgAWnB598+nFM+74w+la35okW6F4n1GISD7DDDrwo4phXs
	 blEs/Ruyh5e2XednQ8XfwNBBGjQb+0ueXb4kb4QpaaBabmsqzcxYQPSDSCRDYbOdct
	 mrBluDPil4eOFLVICDPApmRxN2Y0WAs5hV+m6QwKj52ZIKj1lyNHDTlsqf637K3kxm
	 Ju/NTxD50AOC6512QYulfPGD5YUPQsY1R1lu5hdYTWIpOqNLXnaLM+ZvIoL755z1Oj
	 Z8SQoHBq6J/lg==
Date: Thu, 19 Dec 2024 19:34:03 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Ahmed Zaki <ahmed.zaki@intel.com>
Cc: netdev@vger.kernel.org, intel-wired-lan@lists.osuosl.org,
 andrew+netdev@lunn.ch, edumazet@google.com, pabeni@redhat.com,
 davem@davemloft.net, michael.chan@broadcom.com, tariqt@nvidia.com,
 anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
 jdamato@fastly.com, shayd@nvidia.com, akpm@linux-foundation.org
Subject: Re: [PATCH net-next v2 1/8] net: napi: add irq_flags to napi struct
Message-ID: <20241219193403.10a52305@kernel.org>
In-Reply-To: <20241218165843.744647-2-ahmed.zaki@intel.com>
References: <20241218165843.744647-1-ahmed.zaki@intel.com>
	<20241218165843.744647-2-ahmed.zaki@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 18 Dec 2024 09:58:36 -0700 Ahmed Zaki wrote:
> Add irq_flags to the napi struct. This will allow the drivers to choose
> how the core handles the IRQ assigned to the napi via
> netif_napi_set_irq().

I haven't read all the code, but I think the flag should be for the
netdev as a while, not NAPI by NAPI. In fact you can combine it with
allocating the map, too.

int netif_enable_cpu_rmap(dev, num_queues)
{
#ifdef CONFIG_RFS_ACCEL
	WARN_ON(dev->rx_cpu_rmap);

	dev->rx_cpu_rmap = alloc_irq_cpu_rmap(adapter->num_queues);
	if ...
	
	dev->rx_cpu_rmap_auto = 1;
	return 0;
#endif
}

void netif_disable_cpu_rmap(dev)
{
	dev->rx_cpu_rmap_auto = 0;
	free_irq_cpu_rmap(dev->rx_cpu_rmap);
}

Then in the NAPI code you just:

void netif_napi_set_irq(...)
{
	...

	if (napi->dev->rx_cpu_rmap_auto) {
		err = irq_cpu_rmap_add(napi->dev->rx_cpu_rmap, irq);
		...
	}
}

