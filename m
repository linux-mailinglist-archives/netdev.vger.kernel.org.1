Return-Path: <netdev+bounces-121898-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B8AA495F270
	for <lists+netdev@lfdr.de>; Mon, 26 Aug 2024 15:10:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE9611C21B11
	for <lists+netdev@lfdr.de>; Mon, 26 Aug 2024 13:10:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2438017BEC1;
	Mon, 26 Aug 2024 13:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lp0r03es"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE45E17ADE3;
	Mon, 26 Aug 2024 13:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724677829; cv=none; b=rJSw3AUWZ04HYzPTc+AcTeklkxtqwAh5hBbX3pF5c/gTaWXbTs/3eu3/yDMexMAPblgDXYS3FgPfFs8h1qir2cqZ0g2Hoj5CxIMO1/3/dujzKP3xnTeosUe0nBxmtCwvQeOii6y7DpRkEaeCBru5l+3gmEMW1Qw/08DNPJqP/+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724677829; c=relaxed/simple;
	bh=xREHIIJEpy2OD2PXTPX2340JM5kQauymL1OSdfIPvKg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=IK4BOjz+5VW4rvg+6gmWA0QQA0z1FSwhpD8zRH9kXCIK65iE5PNVazfR4JRo/5ivaiCAqb3Wc4D3UDd5BKJW5LLyRb+ZIDao95QHqN2s+aLQfKdfE6bSlUS+MWQ4K2LJL0tQzoilAP6GBMRqp8IasQL1slL/GMfDYx2jw3bWzJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lp0r03es; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72E4DC58281;
	Mon, 26 Aug 2024 13:10:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724677828;
	bh=xREHIIJEpy2OD2PXTPX2340JM5kQauymL1OSdfIPvKg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Lp0r03esCYeq4u5R7lzFduvLSmPEwWtljU4D5IMdInfiIAS9cbCUioaRVWnoZd40B
	 bHiiuZ+Msn1+hqdrtdkchWDe4l0jrmDAXSvhWeuPQMc+9byvfo9UaL3zamRSUSiLKf
	 483cgWG+hvDxE6apRleEVS9eQPTFD5ud1dvJJLOfr2hTfuPzVPVkoVfXHOiUfI0tOr
	 6hW4ThPbqqLfUm0rvdOUdrSgrNn/5H7GXPDhV7cwKEHKPfQhzOdsNsHWL/B3VfZXYO
	 ElXejTAoD4oY5Sr68aaRHJEioyBtfALnwccOY5SweHBfXJGwJI3eE3jhVAH2V9n19s
	 zlj17rj6Ye9SA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE04A3822D6D;
	Mon, 26 Aug 2024 13:10:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] net: ftgmac100: Ensure tx descriptor updates are visible
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172467782825.7852.12721685155366652197.git-patchwork-notify@kernel.org>
Date: Mon, 26 Aug 2024 13:10:28 +0000
References: <20240822073006.817173-1-jacky_chou@aspeedtech.com>
In-Reply-To: <20240822073006.817173-1-jacky_chou@aspeedtech.com>
To: Jacky Chou <jacky_chou@aspeedtech.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, u.kleine-koenig@pengutronix.de, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Thu, 22 Aug 2024 15:30:06 +0800 you wrote:
> The driver must ensure TX descriptor updates are visible
> before updating TX pointer and TX clear pointer.
> 
> This resolves TX hangs observed on AST2600 when running
> iperf3.
> 
> Signed-off-by: Jacky Chou <jacky_chou@aspeedtech.com>
> 
> [...]

Here is the summary with links:
  - net: ftgmac100: Ensure tx descriptor updates are visible
    https://git.kernel.org/netdev/net/c/4186c8d9e6af

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



