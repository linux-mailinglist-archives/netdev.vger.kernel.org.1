Return-Path: <netdev+bounces-111345-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 65D81930A68
	for <lists+netdev@lfdr.de>; Sun, 14 Jul 2024 16:41:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E9B5A1F21911
	for <lists+netdev@lfdr.de>; Sun, 14 Jul 2024 14:41:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95F42139D09;
	Sun, 14 Jul 2024 14:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sZ+Tnqg5"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CAFB139597
	for <netdev@vger.kernel.org>; Sun, 14 Jul 2024 14:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720968096; cv=none; b=lbAhkYPydIo6hNXbhafhgg5rxhiF8XiN2Z8TFd3NlY52DoWo3EQ64AS1KGNTh+HSP79xL3Ads07fcTPxzIW3YkYyU0Iz+McDVrOWXO+dw1UDKcVPasE1Bbn+q5HlB+hHVGL/oIEVAgyNB8oEloAjwfaKrtJdq5pQHwa36XD9xu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720968096; c=relaxed/simple;
	bh=FSuMMRUedtZz89TJhuciq1Psp+b6MTVzDZRZlQeVM9s=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=OGCVuUGz8y/TlZ3e81JlD0QeA6CiMugoMprB6AeFr6PK4McW/TbpyTrspnn2W27hKyST3rmA/u8cvHg7kd+plYp++l1stWlWwomI/bHv4ku7Xh0wTcyJ7K/rYt8N4B3hQzrjnWPhIA6BMc3ELmCSK1GjkoEj9XwnJHg6G1jgobo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sZ+Tnqg5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id D60F5C4AF09;
	Sun, 14 Jul 2024 14:41:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720968095;
	bh=FSuMMRUedtZz89TJhuciq1Psp+b6MTVzDZRZlQeVM9s=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=sZ+Tnqg5nXORPyCHT45PXD+WodJYGh/4+4lODQ991enEpw2eW4pvQoKTn4+o122UF
	 rqUgpFjaYVFAcQuKOLKjfitBmko4ZdgAnw/EGXcPyoaD8XdxSQBC7y8FR2Ev7oUeJI
	 gmlxRRs/NdUaV+74g2N7x2H9Q42di51GZSxMc/aU3jj4syoJFq5x+S2FWxx1d5fwBE
	 0neQXQFv4kiWZ5zfhut4MAT38RdCSI4oRNPJI6T1Wo9HvflOYWYlIO2a0ygrH++1r1
	 lVgG6z1jqAGrwDUh66NDrNxsO0jFFnDSYmDpdp1Rnx8S5csMpPClYN4AWv7+Z2C/DN
	 b/SrcfhwDbLgg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id BD90EC43168;
	Sun, 14 Jul 2024 14:41:35 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v4 0/4] vrf: fix source address selection with route leak
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172096809576.533.5025481642505106509.git-patchwork-notify@kernel.org>
Date: Sun, 14 Jul 2024 14:41:35 +0000
References: <20240710081521.3809742-1-nicolas.dichtel@6wind.com>
In-Reply-To: <20240710081521.3809742-1-nicolas.dichtel@6wind.com>
To: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, dsahern@kernel.org, netdev@vger.kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 10 Jul 2024 10:14:26 +0200 you wrote:
> For patch 1 and 2, I didn't find the exact commit that introduced this bug, but
> I suspect it has been here since the first version. I arbitrarily choose one.
> 
> v3 -> v4:
>  patch 2: set 'dev' only when needed
> 
> v2 -> v3:
>  patch 1: enforce 80 columns limit
>  patch 2: fix coding style
>  patch 4: add tcp and udp tests
> 
> [...]

Here is the summary with links:
  - [net,v4,1/4] ipv4: fix source address selection with route leak
    https://git.kernel.org/netdev/net/c/680735235356
  - [net,v4,2/4] ipv6: fix source address selection with route leak
    https://git.kernel.org/netdev/net/c/252442f2ae31
  - [net,v4,3/4] ipv6: take care of scope when choosing the src addr
    https://git.kernel.org/netdev/net/c/abb9a68d2c64
  - [net,v4,4/4] selftests: vrf_route_leaking: add local test
    https://git.kernel.org/netdev/net/c/39367183aecf

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



