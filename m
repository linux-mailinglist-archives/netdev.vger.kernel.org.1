Return-Path: <netdev+bounces-203066-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E45C0AF0736
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 02:19:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C3E1170BA6
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 00:19:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EB3C139D;
	Wed,  2 Jul 2025 00:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hStABVNg"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9BE41361;
	Wed,  2 Jul 2025 00:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751415583; cv=none; b=WpaCTyADZf7yH8jvM1BrVAjuw8sxmkxnO14O0Iiy5s5+W/qAT2HfRxkd83rE9pOHpBinE24PQMB2xqrdJjbnz22787WmTVlNJjuV4DQ9TT4QwrTNS0IDLwhy3/Uhm1s06YINFJIP0/oLkSR8r0cNxh7vKit0P3J0uM116VL8iLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751415583; c=relaxed/simple;
	bh=n7DLtblJarknb0Q5uRpwjYPmadJvBAA9kwiemkkq1Sg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=rZJtfCWTUgeQIbCXwSVqNGtx0tuEI79PNBB/Bj/eTTXiwJCex5AcmGpY7OnAKjJ4hL9cm4FTyTRcecFKDjxmsN3FxPY6xw4oeM3cpwSAdlf7IARpIoLBBRDwi0+ZlC95qYspZYP3y0J8HqiccnkViI/FKoNzTBnoZzUo4vhoQI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hStABVNg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72797C4CEEB;
	Wed,  2 Jul 2025 00:19:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751415582;
	bh=n7DLtblJarknb0Q5uRpwjYPmadJvBAA9kwiemkkq1Sg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=hStABVNgwCDSSo8YMYjMBxToSJW0n/WEFDLeS+swv4Ye8k80/K6BSXH+2/ZjO8gVo
	 bnyEIU3nr0g6r3ADbUFIU2NZdk7teQJZb3Mf55ELBuYyoKBaLMMeLTxAJD6psfAZzi
	 1LuwVSEsK8KQB+IqCQ0MslPHA4xyci/b5oEUlZwKfOQsHvNb0vzQDjQRAjnai//r0B
	 8NHP3MPfL6+9k6oii7asikBf8rX8XGZpKkILGeNI18wNzBaEIcTGkQlBnOTZkGRwLo
	 PEYE+WWCTu4PiucD67NsSB2LVR2AHMLQCom2xoQCE8LAH54giBQosAQdIntIw/mcM1
	 7bNoD6aY1Zxiw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70C78383BA06;
	Wed,  2 Jul 2025 00:20:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] sfc: eliminate xdp_rxq_info_valid using XDP base
 API
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175141560722.155437.15564826328810854140.git-patchwork-notify@kernel.org>
Date: Wed, 02 Jul 2025 00:20:07 +0000
References: <20250628051016.51022-1-wangfushuai@baidu.com>
In-Reply-To: <20250628051016.51022-1-wangfushuai@baidu.com>
To: Fushuai Wang <wangfushuai@baidu.com>
Cc: ecree.xilinx@gmail.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-net-drivers@amd.com,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat, 28 Jun 2025 13:10:16 +0800 you wrote:
> Commit eb9a36be7f3e ("sfc: perform XDP processing on received packets")
> use xdp_rxq_info_valid to track failures of xdp_rxq_info_reg().
> However, this driver-maintained state becomes redundant since the XDP
> framework already provides xdp_rxq_info_is_reg() for checking registration
> status.
> 
> Signed-off-by: Fushuai Wang <wangfushuai@baidu.com>
> 
> [...]

Here is the summary with links:
  - [net-next] sfc: eliminate xdp_rxq_info_valid using XDP base API
    https://git.kernel.org/netdev/net-next/c/582643672deb

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



