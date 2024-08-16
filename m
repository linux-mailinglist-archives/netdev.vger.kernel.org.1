Return-Path: <netdev+bounces-119081-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D492953FA7
	for <lists+netdev@lfdr.de>; Fri, 16 Aug 2024 04:30:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8235C1C2120B
	for <lists+netdev@lfdr.de>; Fri, 16 Aug 2024 02:30:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E61423612D;
	Fri, 16 Aug 2024 02:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N51vbFM+"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7AC226AEC;
	Fri, 16 Aug 2024 02:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723775430; cv=none; b=rMhorextXK5OsDyWLEw3cYVg2Ui5kbbFs3DyUvMzb59zCI2TgIEQHow1kCb3pmg+MR4owjv4smuiKOg439JtnmelYNErWVB/DywLM9kJXv/blLJjhNraOltdltEeJXMz6F/if9q2K1kviZ0psCKl7NP+ycL8PoNlW5jc3UfyCEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723775430; c=relaxed/simple;
	bh=hzUJ/E2eUKeArWi0F2V9BHPbmRWaVSw9I47k+z0KSIQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=K6LjIKNAYCCxemzdmrrSfncuNJWmV7jrmMWF/sp0pMaQzk/LW6lzjgLDi6qh7I8tncJUeN39A1tafRVlOTatSHmSKCwoymiVJ0AQpvy87CPXod6/anTIyjDuGBs71RK8j2UH2e0KoLP84da3sDh4qrB/VDqWDfy79ZlF5izdwMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N51vbFM+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34585C32786;
	Fri, 16 Aug 2024 02:30:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723775430;
	bh=hzUJ/E2eUKeArWi0F2V9BHPbmRWaVSw9I47k+z0KSIQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=N51vbFM+burVcbcX0eUAQuB4jYwayU465oQ1beIs9J55/doOCcPr2zDPHRRLWdOOD
	 aVJtsrEqCMFqWMF4pv8mfIAZhIuctMOKmQY/ZAkmTNb8GxIb8NXFslXVyuEH8o935z
	 vNN9XdoJzHVZQ5jGp/QwGQx531B3PGCBcdhf8wIkqX4hie2+k5Aa8Ilzz8MH6kZwlI
	 RdF3aeopCh4MmJBTo1ZxeASeaZxrQbwjgU6vR9AQWrLI42gzrbS3ckXgcrf+2oHkVr
	 /Yo+1KzUMUImcGGfrWjop+aUUKqde90P35ReXB1YUGH/cQ7yIIsdh/edeTfSzwwvHW
	 ozj1Ako3I+7Eg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADD18382327A;
	Fri, 16 Aug 2024 02:30:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v7 0/4] virtio-net: synchronize op/admin state
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172377542949.3096750.12975894410138970761.git-patchwork-notify@kernel.org>
Date: Fri, 16 Aug 2024 02:30:29 +0000
References: <20240814052228.4654-1-jasowang@redhat.com>
In-Reply-To: <20240814052228.4654-1-jasowang@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: mst@redhat.com, xuanzhuo@linux.alibaba.com, eperezma@redhat.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 virtualization@lists.linux.dev, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, venkat.x.venkatsubra@oracle.com,
 gia-khanh.nguyen@oracle.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 14 Aug 2024 13:22:24 +0800 you wrote:
> Hi All:
> 
> This series tries to synchronize the operstate with the admin state
> which allows the lower virtio-net to propagate the link status to the
> upper devices like macvlan.
> 
> This is done by toggling carrier during ndo_open/stop while doing
> other necessary serialization about the carrier settings during probe.
> 
> [...]

Here is the summary with links:
  - [net-next,v7,1/4] virtio: rename virtio_config_enabled to virtio_config_core_enabled
    https://git.kernel.org/netdev/net-next/c/0cb70ee4a6ee
  - [net-next,v7,2/4] virtio: allow driver to disable the configure change notification
    https://git.kernel.org/netdev/net-next/c/224de6f886f8
  - [net-next,v7,3/4] virtio-net: synchronize operstate with admin state on up/down
    https://git.kernel.org/netdev/net-next/c/df28de7b0050
  - [net-next,v7,4/4] virtio-net: synchronize probe with ndo_set_features
    https://git.kernel.org/netdev/net-next/c/c392d6019398

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



