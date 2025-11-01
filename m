Return-Path: <netdev+bounces-234803-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 766C1C27511
	for <lists+netdev@lfdr.de>; Sat, 01 Nov 2025 02:00:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2DB2A400E5B
	for <lists+netdev@lfdr.de>; Sat,  1 Nov 2025 01:00:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE0BA1C28E;
	Sat,  1 Nov 2025 01:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ctm//usY"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B473934D3A2;
	Sat,  1 Nov 2025 01:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761958830; cv=none; b=MW9LsGNqEEStjKIPOm7xEMGnBPZvbFd6VfBh//SV8r8cGSOHYZ7rsWU0hhnbGtVrF6OrkPstLNYdidoJYoWyyd9moc1AIHLHG91vHIjGu+WbXDVMdy7xv58dKol0YC4ULC6RX5mMLe1WhIBbSV9/wPnhcAE1o6IxiZh8tObJcZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761958830; c=relaxed/simple;
	bh=pF4PI1tVZCo9B1kyiC3VQSzNkn1SKB8mlJ3ksNAiJFg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=DB+VM8lxQOrRAgjiGsdaplectwRImT/Sh6jaBq1/SqDMqyWFBw9TbQ/WgIYgWrzCDCbajduNV2AAH5dvkLqBwiaCp8Mbx4VvHEoUS5FM4lscbcIyXNYQkfuBSTZwsfPg8PlrZAKN1ROzDAGZfRrtg8DcM0B2hk1HCGKVa/CtROQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ctm//usY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83B55C4CEE7;
	Sat,  1 Nov 2025 01:00:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761958830;
	bh=pF4PI1tVZCo9B1kyiC3VQSzNkn1SKB8mlJ3ksNAiJFg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Ctm//usYalF9j36rVWb8BvQ9XON5q4bDI53LPEN2ZzykODyLJLmD7HA4Cht8iXUYC
	 SyGvgurcVb5tL0Pqwa8olKpFM27H5MvZP5JPcFUlVlBorO2CWHG3I3oSJNgyZdUy37
	 991zlPnMmWnJMka7S1FU6Y7dKuHPNejSwnb5RlabWd8UlEWRpJeDPTYKeoT8cFPPCT
	 WG1/+oBR5yLY9FOHsZoPm6LpqQOG9d7Re5mUkmFmlOqDcWYHJx31JlNazKlu9Ln5Zk
	 xXkXC9dM8loYTTbPfZt90/6nCINCCIrkNMmcfi62HBoRaS2b9DoE+rEpMY1oAIF/9t
	 raI9w1KI8yf1w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADCFD3809A00;
	Sat,  1 Nov 2025 01:00:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] netconsole: Acquire su_mutex before navigating
 configs
 hierarchy
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176195880651.684055.2420166688271014327.git-patchwork-notify@kernel.org>
Date: Sat, 01 Nov 2025 01:00:06 +0000
References: <20251029-netconsole-fix-warn-v1-1-0d0dd4622f48@gmail.com>
In-Reply-To: <20251029-netconsole-fix-warn-v1-1-0d0dd4622f48@gmail.com>
To: Gustavo Luiz Duarte <gustavold@gmail.com>
Cc: leitao@debian.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 thepacketgeek@gmail.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 29 Oct 2025 13:50:24 -0700 you wrote:
> There is a race between operations that iterate over the userdata
> cg_children list and concurrent add/remove of userdata items through
> configfs. The update_userdata() function iterates over the
> nt->userdata_group.cg_children list, and count_extradata_entries() also
> iterates over this same list to count nodes.
> 
> Quoting from Documentation/filesystems/configfs.rst:
> > A subsystem can navigate the cg_children list and the ci_parent pointer
> > to see the tree created by the subsystem.  This can race with configfs'
> > management of the hierarchy, so configfs uses the subsystem mutex to
> > protect modifications.  Whenever a subsystem wants to navigate the
> > hierarchy, it must do so under the protection of the subsystem
> > mutex.
> 
> [...]

Here is the summary with links:
  - [net] netconsole: Acquire su_mutex before navigating configs hierarchy
    https://git.kernel.org/netdev/net/c/d7d2fcf7ae31

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



