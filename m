Return-Path: <netdev+bounces-194748-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B13D6ACC40B
	for <lists+netdev@lfdr.de>; Tue,  3 Jun 2025 12:10:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 74DD93A23A6
	for <lists+netdev@lfdr.de>; Tue,  3 Jun 2025 10:09:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18424226CF5;
	Tue,  3 Jun 2025 10:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E7fq+/LR"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4B5D2AD02;
	Tue,  3 Jun 2025 10:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748945396; cv=none; b=jFUXGI02334n84PZhnOs1tgqPR+8SfZWihBHNXvWmkJ93wzuXep/gZYSyE8LsNwGrtNtmUQ979QIY0YV0i0BLkgLTSp6kz6ouD6EzabMGs/cKAjduARiX2tAVOZvfzfY6fqpYCd6jlwQXn/nkJoCNh/Q2ThEEo5l9sl+2aKzOUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748945396; c=relaxed/simple;
	bh=oh0bRcCIykJVRc1cbwHbTCypspvbnK4XaoO2CqyBCaI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=I8PmOYi+YZZ4sHIlDuTcHWb/us4nLXjVz0viV2SB+v0pxvTiw01fXMHhcXjq2PSR8xJp4hR22uVrv9cVI+1PjYdOHZCjtRvxsNnVohjA67/OSypQcKqTM/5sggEbkRs5u5jRNe3j1BD+8uRl+lpx73m2AP/oApv97yci2WulAIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E7fq+/LR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB7A0C4CEED;
	Tue,  3 Jun 2025 10:09:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748945395;
	bh=oh0bRcCIykJVRc1cbwHbTCypspvbnK4XaoO2CqyBCaI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=E7fq+/LRC1Trg3RPBUdKCLNUsEl0wnDkPUnI9dnGH9e4dj8+ch5E5G516D+d29Ehz
	 7NAe4VpxHmGGDaQCxpuKn4qwV+346zM26f0y0s71aoQAzNbRBOYORJUJmjxQcawwie
	 8wz87Ym0hwXtKvg/xh+n9xLxuLtdp74iii/DjFuoC9zTxKEnDIsmueSx9NhclqpfQq
	 jpB5jnQki6IegNUuS53wn45MN7unqsV4QKYW7W/+j8/cnNtxCxPENRu0VFO/X91fud
	 7bNJz32RJbFnw7rNyyKT6P03vW10SV9O+l4Y+Z6b571VRkcGPq05D0ahm/ChB/IQAZ
	 9u3lKnputHqqw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70CDE380DBEC;
	Tue,  3 Jun 2025 10:10:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v4] vmxnet3: correctly report gso type for UDP tunnels
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174894542826.1452627.13316542259674401176.git-patchwork-notify@kernel.org>
Date: Tue, 03 Jun 2025 10:10:28 +0000
References: <20250530152701.70354-1-ronak.doshi@broadcom.com>
In-Reply-To: <20250530152701.70354-1-ronak.doshi@broadcom.com>
To: Ronak Doshi <ronak.doshi@broadcom.com>
Cc: netdev@vger.kernel.org, guolin.yang@broadcom.com,
 bcm-kernel-feedback-list@broadcom.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Fri, 30 May 2025 15:27:00 +0000 you wrote:
> Commit 3d010c8031e3 ("udp: do not accept non-tunnel GSO skbs landing
> in a tunnel") added checks in linux stack to not accept non-tunnel
> GRO packets landing in a tunnel. This exposed an issue in vmxnet3
> which was not correctly reporting GRO packets for tunnel packets.
> 
> This patch fixes this issue by setting correct GSO type for the
> tunnel packets.
> 
> [...]

Here is the summary with links:
  - [net,v4] vmxnet3: correctly report gso type for UDP tunnels
    https://git.kernel.org/netdev/net/c/982d30c30eaa

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



