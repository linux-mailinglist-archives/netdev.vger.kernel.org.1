Return-Path: <netdev+bounces-126952-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 049759735CF
	for <lists+netdev@lfdr.de>; Tue, 10 Sep 2024 13:00:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C13E52856D0
	for <lists+netdev@lfdr.de>; Tue, 10 Sep 2024 11:00:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0ACC18661A;
	Tue, 10 Sep 2024 11:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ExTfI7h0"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5D5D5674D;
	Tue, 10 Sep 2024 11:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725966028; cv=none; b=WT2OzyEphzXeEQ7oqY1pDal9K9u9On7oYejA6LX4jjb3/7iOSQSUd3Anvo3VU4gvdWA3Db7kVGcnVhLmuVftXF0LF/MKmkCSWGHycs3o2gNljwvzQbXTNJEKvdFL5fQV+BoO8ffP/CcGwgdUcsjkn/05GehXOB9NKunEmSmY5pU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725966028; c=relaxed/simple;
	bh=9csnjUCkCKmeabR2m9J+TlToNGiQQRGyTeVjHqfsHCQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=VRutVu3RpsPevhE2SbiwbCCDabP+uLGhxQ0tDuB4LpDe1ajcsCoZPGGPSjZXS8RW79FiU0p/WKNkHA+vCNBac/2vrAgAZPYpM0cG1Px0PpqyCKEbtUX9cgAkW4Q21Ckxlj0bWdT7I+h4gVtBaTYTaAV00pwmmytYCRT2MS4C+Ec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ExTfI7h0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32AB3C4CEC3;
	Tue, 10 Sep 2024 11:00:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725966028;
	bh=9csnjUCkCKmeabR2m9J+TlToNGiQQRGyTeVjHqfsHCQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ExTfI7h024FusAGaGr6uiouB6LhP/r7281fwC/WzQNd08YuVR4HIKxsnMF9Ge6BEj
	 fJ8vUouAs7fLKNMShGlYCfuE5BXfLDLKU6uPRxTJh5YiQxt929XiRkJy2ano9kbGP2
	 rVgF8M+R3q87cpMn44GOXDW8bXTGvyEWfmWHkKD5ZjEEnlzuxN7U6kN/X1wQH6DPKm
	 SBaHdnhVp0xlELX5evZPcLKX6vGWwld7Y88C9XPEkeKuIIo+bBu6RUUB8yGgLD0t32
	 HByK7f+vqONcmI33v1IaqAUFpWO22agOmWNIMedYs2cyyvu0tNG1iSKrVWVG/jTmuq
	 L+xCTNcqkxqGA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70CF23806654;
	Tue, 10 Sep 2024 11:00:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] net: ftgmac100: Enable TX interrupt to avoid TX timeout
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172596602927.216475.4554072341389364414.git-patchwork-notify@kernel.org>
Date: Tue, 10 Sep 2024 11:00:29 +0000
References: <20240906062831.2243399-1-jacky_chou@aspeedtech.com>
In-Reply-To: <20240906062831.2243399-1-jacky_chou@aspeedtech.com>
To: Jacky Chou <jacky_chou@aspeedtech.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 benh@kernel.crashing.org

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Fri, 6 Sep 2024 14:28:31 +0800 you wrote:
> Currently, the driver only enables RX interrupt to handle RX
> packets and TX resources. Sometimes there is not RX traffic,
> so the TX resource needs to wait for RX interrupt to free.
> This situation will toggle the TX timeout watchdog when the MAC
> TX ring has no more resources to transmit packets.
> Therefore, enable TX interrupt to release TX resources at any time.
> 
> [...]

Here is the summary with links:
  - [v2] net: ftgmac100: Enable TX interrupt to avoid TX timeout
    https://git.kernel.org/netdev/net/c/fef2843bb49f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



