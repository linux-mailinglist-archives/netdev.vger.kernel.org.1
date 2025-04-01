Return-Path: <netdev+bounces-178474-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9222AA771B8
	for <lists+netdev@lfdr.de>; Tue,  1 Apr 2025 02:11:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CB6547A3D6A
	for <lists+netdev@lfdr.de>; Tue,  1 Apr 2025 00:10:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 820C4149C53;
	Tue,  1 Apr 2025 00:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AYOOuLRz"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E59D14375C
	for <netdev@vger.kernel.org>; Tue,  1 Apr 2025 00:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743466219; cv=none; b=EH05saMwSqPjtEcVYzmxps8uVxsHfinW0Gs99AGbim9gOewne2go++aeiTH6vALhAfgUgNWkoBBN5OTrfdHLXN0LnPMcBmgIEgDe75qOTXiMBYKvMnv4pvcgVG6Nt2uQHT6iWhR1OydnCqBv5fHewtIuwTW6fVmUBudzWAaKU0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743466219; c=relaxed/simple;
	bh=peYxA5IarDal1SqcCZfcSFb6BhaDKnBG2wKBscym9TU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=k0lCFZ4/gezqLHo1LBbUXGT2IAS66LQxtsiSvL+n+rTfw3hdXu0ffQtnmCb0oPCwqD9xuU7gWe5uedjoaeY7xkKm0j2WMR4t7pEjNuZ1cwHnbP2Jhk/kKUl7PHii8jve0dhztfxMuiJkctcKycXeGJIgect4IwlfCRfzRL6nJe4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AYOOuLRz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAF77C4CEEA;
	Tue,  1 Apr 2025 00:10:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743466216;
	bh=peYxA5IarDal1SqcCZfcSFb6BhaDKnBG2wKBscym9TU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=AYOOuLRz6sjL8s8abm0La70XM0MJs3LOC0u4aO19gbFASTEjye+ac+vAW4A+dMVp5
	 3Ju6yxQ+jOBPoCr6hcLLBR9T6mWEXKQZTzkWSIdU1r5ci+YMpFRByLSUUueXhCHciM
	 sBsBJ2IapZ5kYY+WIC6yjHr8R1LU6/qbk7b1r6nfy2Iq0hTiQvues/0LgiVAlVNIr1
	 ZtsD+j5fwVk543guD10wXaJE18jhmfWxtB85Zf4IX/hvF9RtFNK4UmHpitjjdzwrEh
	 3fbjcx3YF1C3jjCISyQw8c/kq2s6GQrr0HyQQy5A/bmRRUqELyfD8JRWPKexXUo6Gn
	 FuRtyrYuACpvg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE0C7380AA7A;
	Tue,  1 Apr 2025 00:10:54 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: fix use-after-free in the
 netdev_nl_sock_priv_destroy()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174346625325.178192.3318310238239193156.git-patchwork-notify@kernel.org>
Date: Tue, 01 Apr 2025 00:10:53 +0000
References: <20250328062237.3746875-1-ap420073@gmail.com>
In-Reply-To: <20250328062237.3746875-1-ap420073@gmail.com>
To: Taehee Yoo <ap420073@gmail.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, andrew+netdev@lunn.ch, horms@kernel.org,
 netdev@vger.kernel.org, jdamato@fastly.com, sdf@fomichev.me,
 almasrymina@google.com, xuanzhuo@linux.alibaba.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 28 Mar 2025 06:22:37 +0000 you wrote:
> In the netdev_nl_sock_priv_destroy(), an instance lock is acquired
> before calling net_devmem_unbind_dmabuf(), then releasing an instance
> lock(netdev_unlock(binding->dev)).
> However, a binding is freed in the net_devmem_unbind_dmabuf().
> So using a binding after net_devmem_unbind_dmabuf() occurs UAF.
> To fix this UAF, it needs to use temporary variable.
> 
> [...]

Here is the summary with links:
  - [net] net: fix use-after-free in the netdev_nl_sock_priv_destroy()
    https://git.kernel.org/netdev/net/c/42f342387841

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



