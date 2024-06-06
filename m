Return-Path: <netdev+bounces-101300-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 12B5B8FE13B
	for <lists+netdev@lfdr.de>; Thu,  6 Jun 2024 10:40:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7FC0728B8CB
	for <lists+netdev@lfdr.de>; Thu,  6 Jun 2024 08:40:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A5A113A418;
	Thu,  6 Jun 2024 08:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BIhs+dZK"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1E9A3C28;
	Thu,  6 Jun 2024 08:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717663229; cv=none; b=bTrVFD2zMyf+V6EUIRUOPyly8sCbV4Ws1GaC/s7+uDd1JNmqHDfdFkBl2pAZ/Pyihzn3Q2P1ip3ICFbSsYse7C86G0FXllJsfq43W0rCpl1OyeWLkU4knLq1NvyORpc/TTRQsn46ADCgFThHScZi6D283Kxo56rUGHvRGDoDbW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717663229; c=relaxed/simple;
	bh=0Y/L82EZCzB7GC6FsONHbm8i7buVGAVbnHUvf/I9Mz8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=WC1r8cVHJ9RUJlNm72YzUQgIEGBktXBg+y9Qo6CE5GkpoOLien0yqzZV05+EEoxZVo5rydhUqOJqcLzrauaK5maC/SXAIY6O4GdJ2n21gL0MZS4nbkvezOexuVKbSDeIQ7rFGKy0s8PrxLhebicmGt6WezZAJQrtpueevoSrk8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BIhs+dZK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5D8FFC4AF0E;
	Thu,  6 Jun 2024 08:40:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717663228;
	bh=0Y/L82EZCzB7GC6FsONHbm8i7buVGAVbnHUvf/I9Mz8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=BIhs+dZKaa+O0ikeonaN4TrMCWY/cLqXOEj5R+Y2714/T30RknNkPRpI1Tkb+RF/8
	 DAdSeivumD8qVifHs68rfAXsiN+X6R8NNmPPimt9hGboskkHRbAHZj1pwC577e3DlI
	 W/Hup34OaQA+7nTlhYB6+CcyOY2xNz11KG/PIVNh+f6NEri8n9deiPJz6oqxCWGT4X
	 FzpqNY7EkfMfVCvLhMmXDYKKWEcqG1Jpws5TQWOVmVKtDhUN/sfmS0YFeAKAE4/qYd
	 THkQQLpZaYaq4BBzbsvml0NfB1exb91YSERmouXQSIeb/AXcjmpagfDLGzRiQmjSQ/
	 3iqKa64b2ySHg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 4B7D0C4332D;
	Thu,  6 Jun 2024 08:40:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: wwan: iosm: Fix tainted pointer delete is case of
 region creation fail
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171766322830.14664.190993997949157639.git-patchwork-notify@kernel.org>
Date: Thu, 06 Jun 2024 08:40:28 +0000
References: <20240604082500.20769-1-amishin@t-argos.ru>
In-Reply-To: <20240604082500.20769-1-amishin@t-argos.ru>
To: Aleksandr Mishin <amishin@t-argos.ru>
Cc: m.chetan.kumar@intel.com, loic.poulain@linaro.org, ryazanov.s.a@gmail.com,
 johannes@sipsolutions.net, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Tue, 4 Jun 2024 11:25:00 +0300 you wrote:
> In case of region creation fail in ipc_devlink_create_region(), previously
> created regions delete process starts from tainted pointer which actually
> holds error code value.
> Fix this bug by decreasing region index before delete.
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> [...]

Here is the summary with links:
  - [net] net: wwan: iosm: Fix tainted pointer delete is case of region creation fail
    https://git.kernel.org/netdev/net/c/b0c9a2643541

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



