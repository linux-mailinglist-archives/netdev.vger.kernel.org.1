Return-Path: <netdev+bounces-132081-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BBCD9990568
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 16:09:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5EE8B1F22EE3
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 14:09:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01D7C217338;
	Fri,  4 Oct 2024 14:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tV50QnDt"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C70EA215F43;
	Fri,  4 Oct 2024 14:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728050928; cv=none; b=IrqmmCVhzmJ61K6CYwGV6aBkTLZMGp3JfNFp276HdpTECCc95dlkPF7eou7tl0k9Pf2MTydBTTIKEmP19dRf8L1otXsBHmTrYtopk5uvghMPXq579+bvAYpCPlZsLCdK7BgxJ6pTAUKyj46t+S12pK+zAa6c4L6FvZmK3m4oPvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728050928; c=relaxed/simple;
	bh=RqtN0IiayrMqwFC0YAGSB1NwED1SqgkSMsUtIuQEZxQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iEdWrFCMvL+HKdnkhUeok++JMY5WL6HzkU/QeqxqMLGNgCO7xbaLkzXm2t+DOpOwaAQicgktgwtTFXTz1beR1lKF64QuN5BEJf1ziKy5coWCAUgzlDo3raZ+VMft4GED6tyk9iujMXH6UzbuSN5iZhDBeeJJ16hlFHAVCZnsE3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tV50QnDt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AD08C4CEC6;
	Fri,  4 Oct 2024 14:08:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728050928;
	bh=RqtN0IiayrMqwFC0YAGSB1NwED1SqgkSMsUtIuQEZxQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=tV50QnDtI0FPg/I2E+nUTsQhaqinxg4bvX6OxXRmtL3IM1ZB7+EhSfuy1+bpm1LHG
	 rSenjrHbD51tCh/cJhmLWlyu4tdQNnT+gVYNd13Dn3zo8SfsNnd9UIU8YxqHda6NfR
	 y1w5zzh2I7BlMTk3gAYFj1eEsezPrFI8tkzH9l8cnVMATQbweZ/Hx7e1pMfwVHYOIa
	 ZCjfq+KRaB+Sz7LJUk1+sGIKm+8z+h7zibo7MTR5ZECCFXD2NVOcLChzmqUGX+DbvB
	 D7B5sUPm/xA2nS5qVKGkKhG78osuWbhJq/9T1LkowVHDQgVRsVZYVAomYXz5cmPl3h
	 9qKbBHUnLzJdg==
Date: Fri, 4 Oct 2024 07:08:46 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jon Hunter <jonathanh@nvidia.com>
Cc: Furong Xu <0x1207@gmail.com>, Ong Boon Leong <boon.leong.ong@intel.com>,
 "David S. Miller" <davem@davemloft.net>, Alexandre Torgue
 <alexandre.torgue@foss.st.com>, Jose Abreu <joabreu@synopsys.com>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Maxime
 Coquelin <mcoquelin.stm32@gmail.com>, Joao Pinto <jpinto@synopsys.com>,
 netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 rmk+kernel@armlinux.org.uk, linux@armlinux.org.uk, xfr@outlook.com,
 "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
 regressions@lists.linux.dev, Thierry Reding <treding@nvidia.com>
Subject: Re: [PATCH net v2] net: stmmac: set PP_FLAG_DMA_SYNC_DEV only if
 XDP is enabled
Message-ID: <20241004070846.2502e9ea@kernel.org>
In-Reply-To: <28f05bbe-78f6-408a-ae53-c40f6a86eed9@nvidia.com>
References: <20240919121028.1348023-1-0x1207@gmail.com>
	<28f05bbe-78f6-408a-ae53-c40f6a86eed9@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 1 Oct 2024 11:22:32 +0100 Jon Hunter wrote:
> We have noticed a boot regression in both -next and mainline v6.12-rc1. 
> Bisect is pointing to this commit. Reverting this commit fixes the problem.
> 
> This boot regression is seen on our Tegra234 Jetson AGX Orin platform 
> that uses the drivers/net/ethernet/stmicro/stmmac/dwmac-tegra.c driver. 
> We are booting with NFS and although the network interface does come up, 
> we fail to mount the rootfs via NFS.
> 
> So it would appear that we need to set this flag for this device. Any 
> thoughts?

This patch doesn't make sense to me. I'll send a revert shortly.

