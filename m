Return-Path: <netdev+bounces-230251-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 38604BE5C70
	for <lists+netdev@lfdr.de>; Fri, 17 Oct 2025 01:20:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DCF984E69A4
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 23:20:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17B97257AC6;
	Thu, 16 Oct 2025 23:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XRkwUjBr"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E35A21CEAD6;
	Thu, 16 Oct 2025 23:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760656823; cv=none; b=jCat9IYFiBcQ6KGzdjmPiD1bPiTmpHgb0TSxV2L8ofLjrb02ZzyVaAJE3myDssq/X/9XNMA/gq3s3OFA/waRmm04q4awX1j70YSmhFoJjZCvYUxkAyycd2dVQypz2d18V1ULrKQJ0weOerRZUpYGVlazvl8Sq5UMY+iJbwr29is=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760656823; c=relaxed/simple;
	bh=y/YxJPj5VdBLKAgWE4bW/o0p8leXPwEEIu0mXBg++Bg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=hDfMlXdONyyzgilVwayeQr/lPUfD7XuABSHBGc4cilmj+KtOM11wTOYFSpR9otvsBJ/qRtZkuneV3vmNUBzVQGPD6iffwM2Dzhkj7kiFKF77pIXov1Bsv+3JqWzLopJ/2mS33caOLdacjMVv8lMbKvW56PBnAoxf3CeGdjZPv1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XRkwUjBr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFB70C4CEF1;
	Thu, 16 Oct 2025 23:20:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760656822;
	bh=y/YxJPj5VdBLKAgWE4bW/o0p8leXPwEEIu0mXBg++Bg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=XRkwUjBrbsBq6lrg9uqgqf6mI9sBNfdNAucNUh3gpJcWObLHKfVuzQInsp9WR/dRD
	 L5N7Ytg4IaosvaCtKBrJxKPdmpmJK3bqtukbCUfLP+gUv+q4BLoRBM1/Ddo8N/WE2L
	 14y29vBXd9KOBcBoHp/QvE+KXrs0pUK+Oi9fUSJZh2/kp1g3yMP5rvwa4rJFaxQHcH
	 nEU9ipMxy/F9t3esTuuvcjPvMCOxob+a7RWoQNITP6A/ryy1DXTZZDFruC/osmRSue
	 1NmpEj0erJmVeeRIsEmbb7XoF0yVyWJSQLRl5caSKqJGXw3JqDDv0VWlxcoImn1oOi
	 QB5LXcgLyn+Qg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EBD0839D0C31;
	Thu, 16 Oct 2025 23:20:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] rtnetlink: Allow deleting FDB entries in user
 namespace
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176065680676.1942659.14087403270853212647.git-patchwork-notify@kernel.org>
Date: Thu, 16 Oct 2025 23:20:06 +0000
References: <20251015201548.319871-1-johannes.wiesboeck@aisec.fraunhofer.de>
In-Reply-To: <20251015201548.319871-1-johannes.wiesboeck@aisec.fraunhofer.de>
To: =?utf-8?q?Johannes_Wiesb=C3=B6ck_=3Cjohannes=2Ewiesboeck=40aisec=2Efraunhofe?=@codeaurora.org,
	=?utf-8?q?r=2Ede=3E?=@codeaurora.org
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, kuniyu@google.com, sdf@fomichev.me,
 shaw.leon@gmail.com, vyasevic@redhat.com, jitendra.kalsaria@qlogic.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 gyroidos@aisec.fraunhofer.de, sw@simonwunderlich.de,
 michael.weiss@aisec.fraunhofer.de, hg@simonwunderlich.de

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 15 Oct 2025 22:15:43 +0200 you wrote:
> Creating FDB entries is possible from a non-initial user namespace when
> having CAP_NET_ADMIN, yet, when deleting FDB entries, processes receive
> an EPERM because the capability is always checked against the initial
> user namespace. This restricts the FDB management from unprivileged
> containers.
> 
> Drop the netlink_capable check in rtnl_fdb_del as it was originally
> dropped in c5c351088ae7 and reintroduced in 1690be63a27b without
> intention.
> 
> [...]

Here is the summary with links:
  - [net,v2] rtnetlink: Allow deleting FDB entries in user namespace
    https://git.kernel.org/netdev/net/c/bf29555f5bdc

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



