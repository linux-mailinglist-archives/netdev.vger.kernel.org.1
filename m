Return-Path: <netdev+bounces-135610-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5264599E663
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 13:42:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 843901C23AF6
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 11:42:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C47771EF92F;
	Tue, 15 Oct 2024 11:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vJMcicB6"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 988521EF92C;
	Tue, 15 Oct 2024 11:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728992427; cv=none; b=kj4Arwr4WHqOjYhlLIGVifEEZ9kypzQEd+KIJawV+rbDQIV+mbqUQIdSicGWyjlM/i31L0thV0oOD0HbcOAY0qzs0IR/uNI/Oaa/veAS7cEBU7ceZei3jRGit5PZONP8t5ClLT8vUt0BsiWBeIkJYGFgBr5VtdDiwKIimlKiPZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728992427; c=relaxed/simple;
	bh=GgyyALiAHROOJ4yh2oDN4TdDkXimmPQpOKDE8hSo+0g=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=tDhCgqWid+TmHjHUmG7VhRFcou/VrH968+W2R96D8ulMvh4k/wVEJ5cVfGCrFoDZtLltAszNFjXBKIjASerFC4dTseCFCXKQ2xWYtE0bIExCsmd8i/mrm++5if9L8uyH2uNf9b58aIqxYmV8IZa07WcfBoxpYe+dcHISHLKFumQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vJMcicB6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60DD3C4CEC6;
	Tue, 15 Oct 2024 11:40:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728992427;
	bh=GgyyALiAHROOJ4yh2oDN4TdDkXimmPQpOKDE8hSo+0g=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=vJMcicB6bn3kPZ8QfQGe3RjEytZWp7S3wU8vb9858KuBlpO+gxFbVWT6nLxmRi7Y0
	 V97xNVd1Ltb6OpZeCL8fJwcjGajKHUxINzoYye3DdrlpDCfI+Bplkil5PrWr7Z+V5c
	 /yJQRqfPUSC3q4/4Ks7rM7ny5VJlAYwqrBVWBB1qMSaSjyniGvrxWiKfu6klYak/PA
	 0j4mdBX384YvAgSfqHGksZTVcU/AXUKEyBfyRj9AFoQVdzumoKZLXSmfr9Oo6smws8
	 M213ahC44JctsthJfLDEJCe1yv1fu+t433q6TFrgLl4FNsNRjsDDRoKl8LqVXvxiCD
	 LAl6jiYSPFsUA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AF4133809A8A;
	Tue, 15 Oct 2024 11:40:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH][next][V2] octeontx2-af: Fix potential integer overflows on
 integer shifts
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172899243250.1129876.14057410014037534113.git-patchwork-notify@kernel.org>
Date: Tue, 15 Oct 2024 11:40:32 +0000
References: <20241010154519.768785-1-colin.i.king@gmail.com>
In-Reply-To: <20241010154519.768785-1-colin.i.king@gmail.com>
To: Colin Ian King <colin.i.king@gmail.com>
Cc: sgoutham@marvell.com, lcherian@marvell.com, gakula@marvell.com,
 jerinj@marvell.com, hkelam@marvell.com, sbhatta@marvell.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 naveenm@marvell.com, netdev@vger.kernel.org, kernel-janitors@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Thu, 10 Oct 2024 16:45:19 +0100 you wrote:
> The left shift int 32 bit integer constants 1 is evaluated using 32 bit
> arithmetic and then assigned to a 64 bit unsigned integer. In the case
> where the shift is 32 or more this can lead to an overflow. Avoid this
> by shifting using the BIT_ULL macro instead.
> 
> Fixes: 019aba04f08c ("octeontx2-af: Modify SMQ flush sequence to drop packets")
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
> 
> [...]

Here is the summary with links:
  - [next,V2] octeontx2-af: Fix potential integer overflows on integer shifts
    https://git.kernel.org/netdev/net/c/637c4f6fe40b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



