Return-Path: <netdev+bounces-114785-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BD65A9440EC
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 04:22:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EDEBB1C23D14
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 02:22:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D8E513C90C;
	Thu,  1 Aug 2024 02:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K8HEZmpQ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2940313790F
	for <netdev@vger.kernel.org>; Thu,  1 Aug 2024 02:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722477632; cv=none; b=MqK3rHrfMnweprNPv5jD116Yti9tVM41rVk5IlfQ1LO4xz7Xm/xIo64PIEz0QtxZPc92fUw+PPLZTLncA2+nSLFJGzwymrIvAdMhK1zA17sWm/1brIWjrlbOS7HoF/mEfZIqIE8yEwq4TbPR4sLEAnBcCMr6YJLDdkY3YRSvu9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722477632; c=relaxed/simple;
	bh=mFyspt5dHaPMcNxCj0yTg1Gb3oj6aXRxR5QnexPBgc8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=jBqfTg2Eqk1C8HIJylSzY88VrhBgaP2J3Hi7Q0DF1r5KYkpvlto20hXT0IW50GCtqbMdecfwkEeMnD4ZLBTS/xRiJ/VcRnpw4VB/08PnBMiAelIE+TMv8awCz5ZIXNlpBhiiSmLWhr6ghAJMX+P5N4/naDKduqn8ZQB5Pa+CtL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K8HEZmpQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id AE301C4AF0C;
	Thu,  1 Aug 2024 02:00:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722477631;
	bh=mFyspt5dHaPMcNxCj0yTg1Gb3oj6aXRxR5QnexPBgc8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=K8HEZmpQJAfwIuuDmgN+yBLJq+4mBViOIalKKF9hsjj70Xo6nAK6tIOG4ZesUqkd+
	 VIlzyryZpFYjmsQJvoAhgajoD93OhV+9qvse65OZ0I7PGTKb3SlHZvmDaziUIredQF
	 dmWQtjdcFZSDwBglMndW44Bg+GqXnnv1WZHKrhBd2+PRr9/POI8zDvrhkS+8NBLbTW
	 FZwPeDJsm4lGuqAIgYF2btKKUEDhzQkGN9RIOAPyoTD6/t/16Dngpf6T365Pa2VIOO
	 gf8DcjWEiqiB0mPzYucuFqG6TjCjsFxOC96XHYvMJDqN7YLEp/A/rPD7oW5On2jKSz
	 9RvLh2fkFYu/w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 9C3A8C6E398;
	Thu,  1 Aug 2024 02:00:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] igc: Fix double reset adapter triggered from a single
 taprio cmd
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172247763163.18900.5089503107659128818.git-patchwork-notify@kernel.org>
Date: Thu, 01 Aug 2024 02:00:31 +0000
References: <20240730173304.865479-1-anthony.l.nguyen@intel.com>
In-Reply-To: <20240730173304.865479-1-anthony.l.nguyen@intel.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, netdev@vger.kernel.org,
 faizal.abdul.rahim@linux.intel.com, sasha.neftin@intel.com,
 vinicius.gomes@intel.com, vladimir.oltean@nxp.com, morx.bar.gabay@intel.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 30 Jul 2024 10:33:02 -0700 you wrote:
> From: Faizal Rahim <faizal.abdul.rahim@linux.intel.com>
> 
> Following the implementation of "igc: Add TransmissionOverrun counter"
> patch, when a taprio command is triggered by user, igc processes two
> commands: TAPRIO_CMD_REPLACE followed by TAPRIO_CMD_STATS. However, both
> commands unconditionally pass through igc_tsn_offload_apply() which
> evaluates and triggers reset adapter. The double reset causes issues in
> the calculation of adapter->qbv_count in igc.
> 
> [...]

Here is the summary with links:
  - [net] igc: Fix double reset adapter triggered from a single taprio cmd
    https://git.kernel.org/netdev/net/c/b9e7fc0aeda7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



