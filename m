Return-Path: <netdev+bounces-131420-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E545898E7C3
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 02:30:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9EBC12825C0
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 00:30:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFACE8BFC;
	Thu,  3 Oct 2024 00:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ESumWo1s"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB84B4C92
	for <netdev@vger.kernel.org>; Thu,  3 Oct 2024 00:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727915430; cv=none; b=VNcKUNi8IdkIbLg/I/p5+glfh/bgozzaoxwTbyI0BlDNkk42kFFJpv+xkwvUqxE/6wdfLcJE02PqKFCJWh4QTSjvgpvYaWOq61y1igkx1og+yoESPY4oawSc2bAXyqxZOPncG4b82w2e2a9YdQMj6O2DddCxNCqpxdAJ6HbF7Eo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727915430; c=relaxed/simple;
	bh=r2QTzHwsTQY9nlDkerrDlic0/tX+dlkOtbZc3ZwaK7Q=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=i1L4Tn9CSyXEcGRf1o+7gdfe2Ak3B6x6wryY7iOFivEQ0g0LbHiUsOSyxfgHl22SS6dMPcbIaidaF8vlPUjQIoKxEPQMCz8tnsSCj5LpNrALJ/2ICP+jh5ZzAjyffm2ASCaYaf59coILIsVmW/RxzReyvwrEk2yQbY6rYmtItVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ESumWo1s; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A2F3C4CEC2;
	Thu,  3 Oct 2024 00:30:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727915430;
	bh=r2QTzHwsTQY9nlDkerrDlic0/tX+dlkOtbZc3ZwaK7Q=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ESumWo1sRp7XW26l0gU52rbCXlO9dRWBOKwzYcFa20PT5egsyDPLrIQewDcotiTJE
	 i2yUZK0/VTHQLMt36M6Hjsw+zgSpu0mlFVzWRKXXyiNxIAFEhk5U3yeogw+SPbWWIL
	 /znvd8mrHwKcEupZYDePnMyveDj897vc/F6l5oDJAYzdxFqoF4zbxGB4iA1triExxA
	 jTTUEIBF2LLqM0cRlmjNmVFaSbHsHymbIkwvP8LdBBBa8TL10M2b9p+NeZwD0pm+ss
	 /DvOZ9Ahmq0rZjzac+VwNfUWzycpoJTpdSA4n3CPc4EfB4rhRhXNsUhXo31NCQ7oQQ
	 IabUDxIY1qTmQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE3BF380DBD1;
	Thu,  3 Oct 2024 00:30:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [net 1/8] net/mlx5: Fix error path in multi-packet WQE transmit
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172791543351.1385485.12951789236369378613.git-patchwork-notify@kernel.org>
Date: Thu, 03 Oct 2024 00:30:33 +0000
References: <20240925202013.45374-2-saeed@kernel.org>
In-Reply-To: <20240925202013.45374-2-saeed@kernel.org>
To: Saeed Mahameed <saeed@kernel.org>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, saeedm@nvidia.com, netdev@vger.kernel.org,
 tariqt@nvidia.com, gal@nvidia.com, leonro@nvidia.com, gbayer@linux.ibm.com,
 yanjun.zhu@linux.dev, maxtram95@gmail.com

Hello:

This series was applied to netdev/net.git (main)
by Saeed Mahameed <saeedm@nvidia.com>:

On Wed, 25 Sep 2024 13:20:06 -0700 you wrote:
> From: Gerd Bayer <gbayer@linux.ibm.com>
> 
> Remove the erroneous unmap in case no DMA mapping was established
> 
> The multi-packet WQE transmit code attempts to obtain a DMA mapping for
> the skb. This could fail, e.g. under memory pressure, when the IOMMU
> driver just can't allocate more memory for page tables. While the code
> tries to handle this in the path below the err_unmap label it erroneously
> unmaps one entry from the sq's FIFO list of active mappings. Since the
> current map attempt failed this unmap is removing some random DMA mapping
> that might still be required. If the PCI function now presents that IOVA,
> the IOMMU may assumes a rogue DMA access and e.g. on s390 puts the PCI
> function in error state.
> 
> [...]

Here is the summary with links:
  - [net,1/8] net/mlx5: Fix error path in multi-packet WQE transmit
    https://git.kernel.org/netdev/net/c/2bcae12c795f
  - [net,2/8] net/mlx5: Added cond_resched() to crdump collection
    https://git.kernel.org/netdev/net/c/ec7931558941
  - [net,3/8] net/mlx5e: Fix NULL deref in mlx5e_tir_builder_alloc()
    https://git.kernel.org/netdev/net/c/f25389e77950
  - [net,4/8] net/mlx5: Fix wrong reserved field in hca_cap_2 in mlx5_ifc
    https://git.kernel.org/netdev/net/c/19da17010a55
  - [net,5/8] net/mlx5: HWS, fixed double-free in error flow of creating SQ
    https://git.kernel.org/netdev/net/c/d8c561741ef8
  - [net,6/8] net/mlx5: HWS, changed E2BIG error to a negative return code
    https://git.kernel.org/netdev/net/c/d15525f30010
  - [net,7/8] net/mlx5e: SHAMPO, Fix overflow of hd_per_wq
    https://git.kernel.org/netdev/net/c/023d2a43ed0d
  - [net,8/8] net/mlx5e: Fix crash caused by calling __xfrm_state_delete() twice
    https://git.kernel.org/netdev/net/c/7b124695db40

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



