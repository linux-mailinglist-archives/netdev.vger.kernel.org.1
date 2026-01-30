Return-Path: <netdev+bounces-254992-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6Fg2BqMcfGmAKgIAu9opvQ
	(envelope-from <netdev+bounces-254992-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 03:51:15 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8237DB692B
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 03:51:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9D03C302DF55
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 02:50:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB1BC310624;
	Fri, 30 Jan 2026 02:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jzJlGLQk"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E1A5337BAC
	for <netdev@vger.kernel.org>; Fri, 30 Jan 2026 02:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769741441; cv=none; b=u6R/b2K2mr0nC/x/kHfWafAlSEyLriB5DwkEbB9dwtCJBXpEP+C/KMZG0vnpLM5TysNEPnFKaNoL8hLnOM3qBGzCj5hHeQY9yAnDRkCGOkyj4y3Crzao7Wp95RQe+gMh8ySmNvOUjx+EeWnyXk5PxAcjc/iov43gKx6x2/QD3P8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769741441; c=relaxed/simple;
	bh=GLp0XVIJ3VALVzsEb9TUAwWViyaKaDYUbHHLzUrHapU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=dKqsC5jkTcvaz3V0DKJt7/auym3XfW0ng9SGLkLBmcc7a3vL32u5sc2wyORsLMoo1dOPSfGmzNlsAKSKhqUwxch0LULZdP0PZ3wrH1dh9GSpeXkD2B4raC1ZwZC/CDR0hqCmOAZj1by1RFdndYt369Rj2KApAozZlVmfc+80K/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jzJlGLQk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51C1AC19421;
	Fri, 30 Jan 2026 02:50:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769741441;
	bh=GLp0XVIJ3VALVzsEb9TUAwWViyaKaDYUbHHLzUrHapU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=jzJlGLQk0mcmaNEyx0+sDFiamcyM0IYEMoPI1DZn9BaKrWT9Qd4lKIxglseN4fqDb
	 6Hd43feFKQRNKNLEYCrtlWMMUE4diifD0e8cosBOmp4Sv7fTb6iYwnj8W1HHgCgVAL
	 r/1vO94zsGPJRj0CYUn7f/uIlzRrDE25ffDXusO/Ntqzkytq8/epNqgH6gJIxbNZTV
	 C8oVoPKgfBraWSHNw1+/6CHuk33lk3eWK4LBxPY2IuH/jlJGTKHdM304tnSy7Pdqqw
	 S9v8BxD2RiKg7Z0molvlMGe3G07WQkyE091hR7KZXw2siVdRsufiQvvdTzByorykvA
	 TpwalZrCOwWEg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 4EA63380CEE0;
	Fri, 30 Jan 2026 02:50:35 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: phylink: fix NULL pointer deref in
 phylink_major_config()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176974143385.3149010.11826632323269107863.git-patchwork-notify@kernel.org>
Date: Fri, 30 Jan 2026 02:50:33 +0000
References: <E1vl39Q-00000006utm-229h@rmk-PC.armlinux.org.uk>
In-Reply-To: <E1vl39Q-00000006utm-229h@rmk-PC.armlinux.org.uk>
To: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
Cc: andrew@lunn.ch, davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 netdev@vger.kernel.org, pabeni@redhat.com
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-254992-lists,netdev=lfdr.de,netdevbpf];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NO_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev,kernel];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8237DB692B
X-Rspamd-Action: no action

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 28 Jan 2026 10:51:56 +0000 you wrote:
> When a MAC driver returns a PCS for an interface mode, and then we
> attempt to switch to a different mode that doesn't require a PCS,
> this causes phylink to oops:
> 
> Unable to handle kernel NULL pointer dereference at virtual address 0000000000000010
> Mem abort info:
>   ESR = 0x0000000096000044
>   EC = 0x25: DABT (current EL), IL = 32 bits
>   SET = 0, FnV = 0
>   EA = 0, S1PTW = 0
>   FSC = 0x04: level 0 translation fault
> Data abort info:
>   ISV = 0, ISS = 0x00000044, ISS2 = 0x00000000
>   CM = 0, WnR = 1, TnD = 0, TagAccess = 0
>   GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
> user pgtable: 4k pages, 48-bit VAs, pgdp=0000000137f96000
> [0000000000000010] pgd=0000000000000000, p4d=0000000000000000
> Internal error: Oops: 0000000096000044 [#1]  SMP
> Modules linked in: --
> CPU: 1 UID: 0 PID: 55 Comm: kworker/u33:0 Not tainted 6.19.0-rc5-00581-g73cb8467a63e #1 PREEMPT
> Hardware name: Qualcomm Technologies, Inc. Lemans Ride Rev3 (DT)
> Workqueue: events_power_efficient phylink_resolve
> pstate: 60400005 (nZCv daif +PAN -UAO -TCO -DIT -SSBS    +BTYPE=--)
> pc : phylink_major_config+0x408/0x948
> lr : phylink_major_config+0x3fc/0x948
> sp : ffff800080353c60
> x29: ffff800080353cb0 x28: ffffb305068a8a00 x27: ffffb305068a8000
> x26: ffff000080092100 x25: 0000000000000000 x24: 0000000000000000
> x23: 0000000000000001 x22: 0000000000000000 x21: ffffb3050555b3d0
> x20: ffff800080353d10 x19: ffff0000b6059400 x18: 00000000ffffffff
> x17: 74756f2f79687020 x16: ffffb305045e4f18 x15: 6769666e6f632072
> x14: 6f6a616d203a3168 x13: 782d657361623030 x12: ffffb305068c6a98
> x11: 0000000000000583 x10: 0000000000000018 x9 : ffffb305068c6a98
> x8 : 0000000100006583 x7 : 0000000000000000 x6 : ffff00008083cc40
> x5 : ffff00008083cc40 x4 : 0000000000000001 x3 : 0000000000000001
> x2 : 0000000000000000 x1 : 0000000000000000 x0 : ffff0000b269e5a8
> Call trace:
>  phylink_major_config+0x408/0x948 (P)
>  phylink_resolve+0x294/0x6e4
>  process_one_work+0x148/0x28c
>  worker_thread+0x2d8/0x3d8
>  kthread+0x134/0x208
>  ret_from_fork+0x10/0x20
> Code: d63f0020 f9400e60 b4000040 f900081f (f9000ad3)
> 
> [...]

Here is the summary with links:
  - [net-next] net: phylink: fix NULL pointer deref in phylink_major_config()
    https://git.kernel.org/netdev/net-next/c/0e4d7df2f3b2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



