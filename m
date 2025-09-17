Return-Path: <netdev+bounces-224211-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 184E2B823DC
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 01:10:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 940627A986C
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 23:08:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D65F930499D;
	Wed, 17 Sep 2025 23:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BDSO0sqH"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEF459478;
	Wed, 17 Sep 2025 23:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758150605; cv=none; b=k73qPjxNaXM6z0tctZAaHcMhKl2Br9lagVeyRC79IbAC1FBVk4MoPVCgd5ZxD3P+qJuCZIVGrFr9xKl8qzBTZlrfvKK5y5Mt5jHMn1dQqrL5jAhfm7Beyo6DzsoReWzfIy5gVY/kWb3QEK2Bkbu6ywOGW9v380a/K3Q1GGg1BKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758150605; c=relaxed/simple;
	bh=XQGe988UV4KR++Q6Tnhs84t75euV4QxSDQk5d0lbz1Q=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=stBzgKg9v0G7pSF9OfgO+Ld04Ssd3fFuSvKgvgLFIiRz5DnqByN0YwcXLsv+WLatpshKxlHBc2H/EibFzbRe3zwICnMAjSP4gzdn3yE2uIV/jX+30ZRnAvVrg4qpBr2qy/J2PltkUK9ti7F8lC83ZUSo0qQu7qYjc4Ji2f7Fers=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BDSO0sqH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8932FC4CEE7;
	Wed, 17 Sep 2025 23:10:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758150605;
	bh=XQGe988UV4KR++Q6Tnhs84t75euV4QxSDQk5d0lbz1Q=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=BDSO0sqHRxuhxwVq1BxHC4Gmb9DIu4BvwjjClhyfhZ3E46bXfvk33MSItIwPd0Mec
	 eCJpAY9/rbkHJEUrPV8bgLT389ktpBeAA/KyPolymVxLQCD/z3tUjFEf0TX/k7IVDL
	 IgrB73xObynZVfsNQXt94dpNxqNg5ROIdfE0dfhIVFwbN5xKDazrNZpfAHLo/AMQkU
	 NM/ZTEb1BHiNMJmsR+DZjd7qOe46gx5GkDtiuq/jbsmn2qrCkHpyVPU9t+aW92G4Nb
	 xgXiFJfzl3OHU1J51447M3NLqqw7TuAtTPEPRyp4ujjGhQ5+oJY05746X0fI4BiAnV
	 WYJfhIEthB5Bw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33D2239D0C28;
	Wed, 17 Sep 2025 23:10:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [net PATCH v2] octeon_ep: fix VF MAC address lifecycle handling
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175815060600.2181994.6456380473149087805.git-patchwork-notify@kernel.org>
Date: Wed, 17 Sep 2025 23:10:06 +0000
References: <20250916133207.21737-1-sedara@marvell.com>
In-Reply-To: <20250916133207.21737-1-sedara@marvell.com>
To: Sathesh B Edara <sedara@marvell.com>
Cc: linux-kernel@vger.kernel.org, sburla@marvell.com, vburru@marvell.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, hgani@marvell.com, andrew@lunn.ch,
 srasheed@marvell.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 16 Sep 2025 06:32:07 -0700 you wrote:
> Currently, VF MAC address info is not updated when the MAC address is
> configured from VF, and it is not cleared when the VF is removed. This
> leads to stale or missing MAC information in the PF, which may cause
> incorrect state tracking or inconsistencies when VFs are hot-plugged
> or reassigned.
> 
> Fix this by:
>  - storing the VF MAC address in the PF when it is set from VF
>  - clearing the stored VF MAC address when the VF is removed
> 
> [...]

Here is the summary with links:
  - [net,v2] octeon_ep: fix VF MAC address lifecycle handling
    https://git.kernel.org/netdev/net/c/a72175c98513

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



