Return-Path: <netdev+bounces-254526-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SGwVDqbWemnm+wEAu9opvQ
	(envelope-from <netdev+bounces-254526-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 04:40:22 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D8619AB787
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 04:40:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B9BF2301DDAC
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 03:40:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C63DD35DCEA;
	Thu, 29 Jan 2026 03:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V9pIiSYq"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3B9035D608
	for <netdev@vger.kernel.org>; Thu, 29 Jan 2026 03:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769658014; cv=none; b=mQeA/2ev+/UoEiTr+Pck2o2n9WR+C+FGHHcHByC2JQfsaqiLbYrMVyhAwSAkeg28Ztv4qsuBuqIVSdsjFfwKXQVesuuxqAOTOTJK1w7ky46vxuEXIfQnZ/bKZOxmeko+HpdcXNH+VnHwlGdItLC4zi8JAQNARS68tYHpb+yq7xQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769658014; c=relaxed/simple;
	bh=EXbOWvk3Z3zcYR+gEEIMz3FrKnU+4hImQEtcbpXM2es=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=MtxpVmg8L2zBmglcDrMj2UoKchqKP0Cxv5XskAQZNj5Gt6Zp2yTSeCW0+W3mObopY7Ew3J1+jGs+WpJl3lQgQQX9OLFZqHPVkinpNmnrqr4fzY22zd6owTpEJqTpmx7aJ+BLq/x8a7pPld5pmOzEHzN1eDpkb2whu8weYDHpAvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V9pIiSYq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51A7FC116D0;
	Thu, 29 Jan 2026 03:40:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769658014;
	bh=EXbOWvk3Z3zcYR+gEEIMz3FrKnU+4hImQEtcbpXM2es=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=V9pIiSYq7yh3cpxPsad8Nf5hK0ynf261yJO7cox79vTvXGCqqES2zH3lim9wKspp9
	 LUoOs0MU6aM+o5AA3nbkZPyH6QHVmXGTrDg4E7/x4h9dc4GSIexhSI5KnER4Hsci9m
	 Mouidm6ysbN3UZXLnNj3Hr1NC+Fmvyu7czL8BDZPv+0EtFtrANwwGOlloTLpY3KT1F
	 X6FsBJPSvYbFlVvyMO5a5gWRftYTbkEGybqMx3nAslQ0443aak/liUUIe0bN7vLpbo
	 kZCxmMdT8X6jlw56S4vM2XOxsx2M9TAdRn4sJo2vS1x6/24PjGh/6BSvrDqTh48mUT
	 z3IxZuVDnOYuA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id C8BDC380AA61;
	Thu, 29 Jan 2026 03:40:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 net] nfc: nci: Fix race between rfkill and
 nci_unregister_device().
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176965800760.2337808.1563059886923457213.git-patchwork-notify@kernel.org>
Date: Thu, 29 Jan 2026 03:40:07 +0000
References: <20260127040411.494931-1-kuniyu@google.com>
In-Reply-To: <20260127040411.494931-1-kuniyu@google.com>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, ilane@ti.com, kuni1840@gmail.com,
 netdev@vger.kernel.org, syzbot+f9c5fd1a0874f9069dce@syzkaller.appspotmail.com
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,ti.com,gmail.com,vger.kernel.org,syzkaller.appspotmail.com];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-254526-lists,netdev=lfdr.de,netdevbpf];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FROM_NO_DN(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev,f9c5fd1a0874f9069dce];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D8619AB787
X-Rspamd-Action: no action

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 27 Jan 2026 04:03:59 +0000 you wrote:
> syzbot reported the splat below [0] without a repro.
> 
> It indicates that struct nci_dev.cmd_wq had been destroyed before
> nci_close_device() was called via rfkill.
> 
> nci_dev.cmd_wq is only destroyed in nci_unregister_device(), which
> (I think) was called from virtual_ncidev_close() when syzbot close()d
> an fd of virtual_ncidev.
> 
> [...]

Here is the summary with links:
  - [v2,net] nfc: nci: Fix race between rfkill and nci_unregister_device().
    https://git.kernel.org/netdev/net/c/d2492688bb9f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



