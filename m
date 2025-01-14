Return-Path: <netdev+bounces-158051-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 04CA1A10419
	for <lists+netdev@lfdr.de>; Tue, 14 Jan 2025 11:30:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E67218829BD
	for <lists+netdev@lfdr.de>; Tue, 14 Jan 2025 10:30:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 474B4284A72;
	Tue, 14 Jan 2025 10:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o9ecJzq1"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E1F422DC34
	for <netdev@vger.kernel.org>; Tue, 14 Jan 2025 10:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736850610; cv=none; b=YghIbUoL7nYB4CXdgAKzckBgHV/YmwPvu0eYL9fVf78/Q5sAHiRX8buAYC7qgNoZeXlHbIGr66V/aEA2/ehKxbo65Walogga0cnRRb3D/PFSB3fZHOjNRGsU2nXbMRj5CFeJQ3qmQTVCamdsZDQEvbDR3jWveJI0LpheNR4DVGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736850610; c=relaxed/simple;
	bh=TR7G6bpHHpt8BZkZv7Q3ZcpKfHl3xoFzd61tjYlNims=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=B8fzzxVGnQGxV4GQIKs/0Q9X5hZrkdeEvZ77ogTRq1ov1/5r324bl0dodCP4q+mmQf5xVQ/mc3gbQnDj9kBDrD2CKfjfh0VwY6U4vQNIUE9ybUCfgQ0NoraZQsvwENr/pVLSLW8OyPSUTT/kpqovCMtYInHphV3pp9AamRjgHhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o9ecJzq1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F683C4CEDD;
	Tue, 14 Jan 2025 10:30:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736850609;
	bh=TR7G6bpHHpt8BZkZv7Q3ZcpKfHl3xoFzd61tjYlNims=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=o9ecJzq1rzr8kGvOH1OviOejxtQz/DSOh6qsHPfu4fc76hv6szcOUa8XO9CDTNM83
	 8X/jo7tD9stNZ6I5MZYf4Io6W0+W0ASM8K9O13xDT3B7oZxConGUai5SfOZaI4VwFK
	 6pbtWO48Wsvsilq7HG7eSysg31zqJpZG9Cvm2uYgaA2E5oQ33sTvNGK9wEkAMmwOgS
	 sSbiyX0o6tL61S9EzZdytqyW5tea0V9hgu5xnwivhnVNQDlrlHJtMeCcsO6sNVRoUD
	 dXGmRszH7FwWC1/dKoSR/GoUj35/PjRhXuSnrkrIWu8BN0RajUl+ONNk0E4RQD2Rht
	 AjnXI87YyhoyA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 71045380AA5F;
	Tue, 14 Jan 2025 10:30:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 net 0/3] gtp/pfcp: Fix use-after-free of UDP tunnel socket.
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173685063227.4128008.14965771716621799592.git-patchwork-notify@kernel.org>
Date: Tue, 14 Jan 2025 10:30:32 +0000
References: <20250110014754.33847-1-kuniyu@amazon.com>
In-Reply-To: <20250110014754.33847-1-kuniyu@amazon.com>
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 shaw.leon@gmail.com, kuni1840@gmail.com, netdev@vger.kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Fri, 10 Jan 2025 10:47:51 +0900 you wrote:
> Xiao Liang pointed out weird netns usages in ->newlink() of
> gtp and pfcp.
> 
> This series fixes the issues.
> 
> Link: https://lore.kernel.org/netdev/20250104125732.17335-1-shaw.leon@gmail.com/
> 
> [...]

Here is the summary with links:
  - [v2,net,1/3] gtp: Use for_each_netdev_rcu() in gtp_genl_dump_pdp().
    https://git.kernel.org/netdev/net/c/46841c7053e6
  - [v2,net,2/3] gtp: Destroy device along with udp socket's netns dismantle.
    https://git.kernel.org/netdev/net/c/eb28fd76c0a0
  - [v2,net,3/3] pfcp: Destroy device along with udp socket's netns dismantle.
    https://git.kernel.org/netdev/net/c/ffc90e9ca61b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



