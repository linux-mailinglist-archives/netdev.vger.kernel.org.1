Return-Path: <netdev+bounces-124684-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EBA896A706
	for <lists+netdev@lfdr.de>; Tue,  3 Sep 2024 21:00:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C69B2855BB
	for <lists+netdev@lfdr.de>; Tue,  3 Sep 2024 19:00:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A99691CC14C;
	Tue,  3 Sep 2024 19:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AhIc89LB"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8608F1CC146
	for <netdev@vger.kernel.org>; Tue,  3 Sep 2024 19:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725390033; cv=none; b=j2BWEb+R7H+DWwAdRj1rvr1MLgFpT0crC8SHXLqoWX2gzafdDQEHq1yhWcls01wNgUlvdJhDgx9AqAXhe3Jnj5lgoBwHw2SPyNdkkWmzH+j9BRxRIZMNtFzr2EoUd+jr1YTl9RzhHqTfUF+4Mf49j6w41SrL4sSdYw6rHxdUP/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725390033; c=relaxed/simple;
	bh=2sSqxyzrOwN0Vz4v2uPQqFB/cRLVot52crerFUeP3Z0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=CG7nUL6h0VIrWKEqkGffOZ7/5yOZkywcHsK/Eic+zNlY+lrnro6NN10UXkzGYlqSBsBwJ23Du5gLtX+JYSHpGXqd6sP0uwS3tDNo2MhsxYfJ57MQWjntfvzLspb3vMB9uIXtiqJThnVIA/p/xB191SUsKngecZFZ0w8xa8/3fBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AhIc89LB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03454C4CECA;
	Tue,  3 Sep 2024 19:00:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725390033;
	bh=2sSqxyzrOwN0Vz4v2uPQqFB/cRLVot52crerFUeP3Z0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=AhIc89LB8PVRoUini0ofXhCbuETrMjQQYHVIq26Yvk3XE7OMyC2MC7sYYb4/2w1q1
	 yxvxJnRSoKLHqxXESU/rPvPQmKSa4Q35MF46i3XqALRWPqLxqCsz2h50h7Mwl5Eira
	 T5axVJspKgSeTJrHMd1/EGLupYXQdAw98Mf6Fdz/M/t2on0MJ1yJkEO/wcneSY+FEu
	 0+12zkbSpWkgoeOwITVYnNNQLprQ4h4WTrZ7Egm3aJnLJNrQrxy+FHIIRWIwOEqX0Z
	 PJHKYTJ/Zmc1KpAzJKdI8QT5jTkkUO+qRrvrwqY6DsdKyPctw7Nl5oTi3TwacGh6UN
	 tIM3oJDdp9E2g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB0FD3822D69;
	Tue,  3 Sep 2024 19:00:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] sch/netem: fix use after free in netem_dequeue
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172539003278.406759.11914616215036297713.git-patchwork-notify@kernel.org>
Date: Tue, 03 Sep 2024 19:00:32 +0000
References: <20240901182438.4992-1-stephen@networkplumber.org>
In-Reply-To: <20240901182438.4992-1-stephen@networkplumber.org>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: netdev@vger.kernel.org, edumazet@google.com, markovicbudimir@gmail.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sun,  1 Sep 2024 11:16:07 -0700 you wrote:
> If netem_dequeue() enqueues packet to inner qdisc and that qdisc
> returns __NET_XMIT_STOLEN. The packet is dropped but
> qdisc_tree_reduce_backlog() is not called to update the parent's
> q.qlen, leading to the similar use-after-free as Commit
> e04991a48dbaf382 ("netem: fix return value if duplicate enqueue
> fails")
> 
> [...]

Here is the summary with links:
  - sch/netem: fix use after free in netem_dequeue
    https://git.kernel.org/netdev/net/c/3b3a2a9c6349

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



