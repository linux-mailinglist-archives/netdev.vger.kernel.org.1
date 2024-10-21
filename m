Return-Path: <netdev+bounces-137443-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EDF89A667B
	for <lists+netdev@lfdr.de>; Mon, 21 Oct 2024 13:20:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 449171C21178
	for <lists+netdev@lfdr.de>; Mon, 21 Oct 2024 11:20:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA2EB1E47C6;
	Mon, 21 Oct 2024 11:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gFM73l/B"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B66341E3787;
	Mon, 21 Oct 2024 11:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729509625; cv=none; b=ir89snDvKDrkPJCQHiRbjP139zRHU0rjJ6zTFcHSQIRPrd+Fixs3K2TX2sGj96thioqVC0Ped1YEcEuOLlHrR9nDCYxlAIDNBnBhmETm/KNhHEORhY1CPnsXApZ+6mk4TBLWgIGP+A9HqB0TvYh6gecGzFJnlj7TM6j03UpA3dQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729509625; c=relaxed/simple;
	bh=hoylwdeO+4UCHP8hfqECEFKP9uT5H2q9+JA5ehD/yA0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=rXxnSzxLP8Xj5pPKaLHLdNDaSeY/S21dERn5EaAEx/mylsaZTp/NpWKZM4sqOL92sjCXZplTKIcHkmFjhevV+8KnUSsJei1Uq4+08e3c6QJYGdxRt83jkRXHeJwfzqWCmyusqqO2WYzkoKU7dccrFGn3H2nrZGdQLOqdQP/zSUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gFM73l/B; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 497CEC4CEC3;
	Mon, 21 Oct 2024 11:20:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729509625;
	bh=hoylwdeO+4UCHP8hfqECEFKP9uT5H2q9+JA5ehD/yA0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=gFM73l/BbP+lF2eKn/xPt7wGrJRcG5CHDlTctZcwszn8hDu3Hq+Qw4mEpCJG31rpc
	 Tyzco5Eq2yB1/AESePa8Bh08q8RAliUO4Np1vL1pVhvzwdeB7pYVszSGY1yF+rS4Ua
	 SSK7udYTaVcrXZryJR5tlwUDKU27yQ6gogP5hG0ijKM9Xrz675rx1olCuELmSgOiVC
	 3LFJ1ak5GLd2SIHm5E3iX9U281FB+q4Dxnn95NiAQmKE3KoYJQco2ir9V0i3vhx0Ts
	 IIx2iAZ0EaWO9Hy/vMu8jM4zL04SiMwI/a3Sdfzon7XyLo8vwCP1GbIVH7Purcm24J
	 +/7NiJd5N7MlQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70E113809A8A;
	Mon, 21 Oct 2024 11:20:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] virtio_net: fix integer overflow in stats
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172950963128.220882.1931223325921327261.git-patchwork-notify@kernel.org>
Date: Mon, 21 Oct 2024 11:20:31 +0000
References: <53e2bd6728136d5916e384a7840e5dc7eebff832.1729099611.git.mst@redhat.com>
In-Reply-To: <53e2bd6728136d5916e384a7840e5dc7eebff832.1729099611.git.mst@redhat.com>
To: Michael S. Tsirkin <mst@redhat.com>
Cc: linux-kernel@vger.kernel.org, colin.i.king@gmail.com, jasowang@redhat.com,
 xuanzhuo@linux.alibaba.com, eperezma@redhat.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 virtualization@lists.linux.dev, netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Wed, 16 Oct 2024 13:27:07 -0400 you wrote:
> Static analysis on linux-next has detected the following issue
> in function virtnet_stats_ctx_init, in drivers/net/virtio_net.c :
> 
>         if (vi->device_stats_cap & VIRTIO_NET_STATS_TYPE_CVQ) {
>                 queue_type = VIRTNET_Q_TYPE_CQ;
>                 ctx->bitmap[queue_type]   |= VIRTIO_NET_STATS_TYPE_CVQ;
>                 ctx->desc_num[queue_type] += ARRAY_SIZE(virtnet_stats_cvq_desc);
>                 ctx->size[queue_type]     += sizeof(struct virtio_net_stats_cvq);
>         }
> 
> [...]

Here is the summary with links:
  - virtio_net: fix integer overflow in stats
    https://git.kernel.org/netdev/net/c/d95d9a31aceb

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



