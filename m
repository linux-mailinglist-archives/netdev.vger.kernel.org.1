Return-Path: <netdev+bounces-242474-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 34700C909D6
	for <lists+netdev@lfdr.de>; Fri, 28 Nov 2025 03:23:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC8723A8A87
	for <lists+netdev@lfdr.de>; Fri, 28 Nov 2025 02:23:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13215271448;
	Fri, 28 Nov 2025 02:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G1q86IK+"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDA98257452;
	Fri, 28 Nov 2025 02:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764296600; cv=none; b=daaD4VjGfhiHkQjdpCtzeMTkwZHlLeKhsc1UrOe7r7cW1YQ2EaQMnbR+kq67fmGpmkxonKCVBQv5wA8O2vNt5rAt4j/EthyATgI1Pm/1HxtDa5ZdEnkdkJdTxxxLz+xU3IWysq2k5uazdevn52PBsbb8PeSxEHigD1xJaDjVitI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764296600; c=relaxed/simple;
	bh=JEGdvbU+qEtlJTKlyWA8ix/OhhxtPbID+5I1DrRfAZM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=gCXqizY1VWpxqcukxnOJeT/8q1jZoU+FHuRUwqjane9qWoFoME+Qzxp7DdRyheQ4jPKe7vNragBFnBaDtvUAMJpoLbbs3F+PcjMs3yepwAezvKf7h95VCI92X4shNV+cDYHACjZy1k0KJDy98v070CO3digzg1I1tW++UemHwds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G1q86IK+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D13AC4CEF8;
	Fri, 28 Nov 2025 02:23:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764296599;
	bh=JEGdvbU+qEtlJTKlyWA8ix/OhhxtPbID+5I1DrRfAZM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=G1q86IK+Sy4sIIgk478H+mhLuzH1kKudLbcIjCGBcY3k0X2+okBnnWUEUW6r64rE/
	 J8EWq3xAsIuX77BhXhaRiTozPfK/T2nZHeTc9IdXL8SUMCYI0KZSV5y1o0vsSYF8Qb
	 4FaBTfM7YP7tbl6Oa9x1i70UE9Ala5iEh3DxuavWKib10Ad6ODmSW6cyg2c5cgWL0X
	 LGDcIskTcMlCfgh5vJthXyJ2N8TbwHdj/u0+MAXJultFr0ASwOXtvE1IGg2w0qUI+h
	 riqQhZsVXCBJl4LldtmIAcaJbw6PYK/E4l2ZldblTT3KsErqfbH7yQp+iJtA9HS2zo
	 TR25NCIvwWvOw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B58A23808204;
	Fri, 28 Nov 2025 02:20:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] gve: Fix race condition on tx->dropped_pkt
 update
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176429642154.114872.15685538167774885821.git-patchwork-notify@kernel.org>
Date: Fri, 28 Nov 2025 02:20:21 +0000
References: <20251127000751.662959-1-hramamurthy@google.com>
In-Reply-To: <20251127000751.662959-1-hramamurthy@google.com>
To: Harshitha Ramamurthy <hramamurthy@google.com>
Cc: netdev@vger.kernel.org, joshwash@google.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 willemb@google.com, pkaligineedi@google.com, linux-kernel@vger.kernel.org,
 maxyuan@google.com, jordanrhee@google.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 27 Nov 2025 00:07:51 +0000 you wrote:
> From: Max Yuan <maxyuan@google.com>
> 
> The tx->dropped_pkt counter is a 64-bit integer that is incremented
> directly. On 32-bit architectures, this operation is not atomic and
> can lead to read/write tearing if a reader accesses the counter during
> the update. This can result in incorrect values being reported for
> dropped packets.
> 
> [...]

Here is the summary with links:
  - [net-next] gve: Fix race condition on tx->dropped_pkt update
    https://git.kernel.org/netdev/net-next/c/858b1d07e491

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



