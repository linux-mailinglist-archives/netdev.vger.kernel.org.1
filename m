Return-Path: <netdev+bounces-98166-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 69DD88CFDA4
	for <lists+netdev@lfdr.de>; Mon, 27 May 2024 12:00:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 25FC8280C81
	for <lists+netdev@lfdr.de>; Mon, 27 May 2024 10:00:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68A6913AA22;
	Mon, 27 May 2024 10:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PrRjYfVv"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 398D81755A;
	Mon, 27 May 2024 10:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716804028; cv=none; b=Ch4YCjWFxBP3XI0kfwZT0WmrLXvnjl4rCpoanZUe8jID8JNNtKQhaY6xI+9Xfu1SeydOLoMqaSywlraT8MbJZATOrn00V//dTYjhtwU5/dxvOp5flemClWrNuSgjEGRQXtCpE4Iov0Wwxz78cc9YkHURlJcUbeqgD3CABrdK2GE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716804028; c=relaxed/simple;
	bh=TYzY/jG5bEF0qerxvadO3ZjWnJoBMCqkrRNX0LtFqTU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=SyC3JbRtLi7fiJ/SNAreuUSzizWQaH54ujCq+tjugZj66Zl8+OacnQ+GDG/PgejHfIQ0zx8OpJBJJZnTqatB3rcrLeOc1Knc+Y+liMyJT0YBfxYZGY52lBKZF52wRtoizRINbRfNVj+F8i9/vufO33qzoTt9edN5YMHgmQwjzIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PrRjYfVv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 87C27C32781;
	Mon, 27 May 2024 10:00:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716804027;
	bh=TYzY/jG5bEF0qerxvadO3ZjWnJoBMCqkrRNX0LtFqTU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=PrRjYfVvF5DoY7aFDjdPA9qj3LyT5z23MAGeyaPoejjGEDOHgCeeUx8fFA6RAM422
	 EFkOGmYxaZ57Vrws4q5MWxZ5jBwj3M8wywMXuc2mbtK6fYCnDt9DwQ37XqK+l6HvhP
	 paLTXX2M4Ipf3Wf0Cmi+Nuf0lBYdvFQBn7GTafG8n7ReVNR3VQz1uAD7bl0RIPbXOU
	 05N5k4QoE4sltl4Wst2ur4HrPt2wxKl/DhWfWQiQGj2P35/PaXzCA89hptCt8p98FL
	 LvkRhuDNCJ0x0ml/4NDLCUqYX5jBGQyPAVQf7/lN4zKVhEyYl4l/9I6HX/z9mth3NQ
	 StQCtNblGCxyA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 74CA2D40190;
	Mon, 27 May 2024 10:00:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [net] Octeontx2-pf: Free send queue buffers incase of leaf to inner
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171680402747.13407.7062644706315340440.git-patchwork-notify@kernel.org>
Date: Mon, 27 May 2024 10:00:27 +0000
References: <20240523073626.4114-1-hkelam@marvell.com>
In-Reply-To: <20240523073626.4114-1-hkelam@marvell.com>
To: Hariprasad Kelam <hkelam@marvell.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, pabeni@redhat.com,
 kuba@kernel.org, edumazet@google.com, davem@davemloft.net,
 sbhatta@marvell.com, gakula@marvell.com, sgoutham@marvell.com,
 naveenm@marvell.com

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Thu, 23 May 2024 13:06:26 +0530 you wrote:
> There are two type of classes. "Leaf classes" that are  the
> bottom of the class hierarchy. "Inner classes" that are neither
> the root class nor leaf classes. QoS rules can only specify leaf
> classes as targets for traffic.
> 
> 			 Root
> 		        /  \
> 		       /    \
>                       1      2
>                              /\
>                             /  \
>                            4    5
>                classes 1,4 and 5 are leaf classes.
>                class 2 is a inner class.
> 
> [...]

Here is the summary with links:
  - [net] Octeontx2-pf: Free send queue buffers incase of leaf to inner
    https://git.kernel.org/netdev/net/c/168484214767

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



