Return-Path: <netdev+bounces-115919-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DB5DA948661
	for <lists+netdev@lfdr.de>; Tue,  6 Aug 2024 01:54:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 95E772838E6
	for <lists+netdev@lfdr.de>; Mon,  5 Aug 2024 23:54:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A124B15ECF8;
	Mon,  5 Aug 2024 23:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ttRLkhc+"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7456D14B06C;
	Mon,  5 Aug 2024 23:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722902054; cv=none; b=Jky6lurb3g+yT5aJrLgeldgpV0IHyepQY9B/3Rv3QCytka7du0U5P4UnKbBscKRMXAFvFztOLN449ZmsIkne7xG1CAiztCBLjJdGLqC19AkpR7yrZ1HNDD0o2BxVr+fFZcGr9nk+VbET2qJIUDVH6gw/9vf3ed9kB3KlWn9b/tw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722902054; c=relaxed/simple;
	bh=2vRF7jI/lF7mBk0Iz/Uhun1IRgWJWVH8pM+TVtNIU7c=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=MllsNpzwY3kcFEYHvVfjgg5MTZPJs0BTUi2AbSou73qr0DTtVqT6BDyQRhxKZERZuK1NElaMp2n7bAL5coRbV40t3HTVB8lF4rTKi1XzpH/6WmIL1O/FHHw6WbKdbgcRgiel77MKyhubFShx/UvWNV1z7G9U1sVAM7E/SXOxphs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ttRLkhc+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id E519AC32782;
	Mon,  5 Aug 2024 23:54:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722902054;
	bh=2vRF7jI/lF7mBk0Iz/Uhun1IRgWJWVH8pM+TVtNIU7c=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ttRLkhc+y5TozpgGICJmweE6vUet1qH+zHS+8ZfrQWA4/7sp6ur3lz2ccyRGU1s3G
	 PeT/tMyJkMdgiau9Ra9bxpenXlWRMd2tDx9eAd/0746Q5PHrinSR9i6Gcy/0xWeRPs
	 WAR5N8sAVlQNfMdUS15G7OPEjuTFhIln3BYqsKbgz3IvQfzcu0PGfIWbQBeAM26yOJ
	 wXTFfJSNbztSaupJOlrfMmRZ8Zwd8wnv3wTA/7Wz/EiNLU2yu7uywUQPQLqTUtk8Ut
	 EmZ/975KCMMNFL3NF/BLl0cpN30sRKOaGcu+UQ2UG4kb2wBf6yLMZO1sdtusJIQtgL
	 2TWBNI6m//eVQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D3EBEC43337;
	Mon,  5 Aug 2024 23:54:13 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: bridge: mcast: wait for previous gc cycles when
 removing port
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172290205386.12421.6444083492470398504.git-patchwork-notify@kernel.org>
Date: Mon, 05 Aug 2024 23:54:13 +0000
References: <20240802080730.3206303-1-razor@blackwall.org>
In-Reply-To: <20240802080730.3206303-1-razor@blackwall.org>
To: Nikolay Aleksandrov <razor@blackwall.org>
Cc: netdev@vger.kernel.org, kuba@kernel.org, roopa@nvidia.com,
 bridge@lists.linux.dev, edumazet@google.com, pabeni@redhat.com,
 syzbot+263426984509be19c9a0@syzkaller.appspotmail.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri,  2 Aug 2024 11:07:30 +0300 you wrote:
> syzbot hit a use-after-free[1] which is caused because the bridge doesn't
> make sure that all previous garbage has been collected when removing a
> port. What happens is:
>       CPU 1                   CPU 2
>  start gc cycle           remove port
>                          acquire gc lock first
>  wait for lock
>                          call br_multicasg_gc() directly
>  acquire lock now but    free port
>  the port can be freed
>  while grp timers still
>  running
> 
> [...]

Here is the summary with links:
  - [net] net: bridge: mcast: wait for previous gc cycles when removing port
    https://git.kernel.org/netdev/net/c/92c4ee25208d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



