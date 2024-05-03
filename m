Return-Path: <netdev+bounces-93390-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 183B48BB7AD
	for <lists+netdev@lfdr.de>; Sat,  4 May 2024 00:42:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 495B51C2459B
	for <lists+netdev@lfdr.de>; Fri,  3 May 2024 22:42:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89F0912FB38;
	Fri,  3 May 2024 22:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pNIxemam"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65BC912FB1B
	for <netdev@vger.kernel.org>; Fri,  3 May 2024 22:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714776030; cv=none; b=PVVf0KiUx7DUVAttVjgfnaUJ6UD2Idhevv1aJrvUpsV115LxbKJurfGi7E2at2+BM3pVNODzcwjD4R1RSwBFRNU6RNBLWam6SHDm1qhGBC++SQb7GpeURbNP1MymXTO/huXQXtFkxkHZE8043uc4tjS26CbK7BZ5QIri3KFY/Zc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714776030; c=relaxed/simple;
	bh=pvPlzTfsQuqanqIQ8UE/1+p6TYj5j73N9WfYa5acyqw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=TOgeODBvi7wSXBj6nYAANBXH4eUCNu1/219xv71rH+5PDd8tU8s2ToEtFptL05PoLo70Fz0qcSQFX7LH6/wp80BP21ySG1g2B1kN/hG28oay/VSt1LBdQC7raQZiDHmMxqA3Ss01VuGUOv4IOmwqB+p12tBknRjh3Ncy5XfuSaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pNIxemam; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 186A9C4AF48;
	Fri,  3 May 2024 22:40:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714776030;
	bh=pvPlzTfsQuqanqIQ8UE/1+p6TYj5j73N9WfYa5acyqw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=pNIxemamZKItScmOG64162KXoK/UW7ykqubV9SveMcF0qPzWjmShkE/CQy9pSMU+4
	 7sEreO2OnHn7brDN+scenP6ScAXe7DtkdnJmy8XsKQRxZI4q1OC63UIhnJHKWco+C/
	 fcbnGaposjF15ySajH5YYmectSD/58JaFjo/57cnQQ8f5rZtsUxslZdlmD9/cKC3Sf
	 nIUWG+Zu2F4PS1ICJj9r1e7b6brAxmjTCagGwwtZFNJGVaeqSTkTsMihNI/Q+qpIuR
	 vjqGr6BVDo0edF0WnGMp/GDFjaKTd5u0QVMLcQCYHlcB1wRJ1YJd5p5wE112OIXdKe
	 T2MN9afnWjNfg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 0310CC43336;
	Fri,  3 May 2024 22:40:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: no longer acquire RTNL in threaded_show()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171477603000.29342.16959233916229668301.git-patchwork-notify@kernel.org>
Date: Fri, 03 May 2024 22:40:30 +0000
References: <20240502173926.2010646-1-edumazet@google.com>
In-Reply-To: <20240502173926.2010646-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, eric.dumazet@gmail.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu,  2 May 2024 17:39:26 +0000 you wrote:
> dev->threaded can be read locklessly, if we add
> corresponding READ_ONCE()/WRITE_ONCE() annotations.
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> ---
>  include/linux/netdevice.h | 2 +-
>  net/core/dev.c            | 4 ++--
>  net/core/net-sysfs.c      | 8 ++++----
>  3 files changed, 7 insertions(+), 7 deletions(-)

Here is the summary with links:
  - [net-next] net: no longer acquire RTNL in threaded_show()
    https://git.kernel.org/netdev/net-next/c/c1742dcb6bda

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



