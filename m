Return-Path: <netdev+bounces-292672-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aIPGNFMsGGqwfAgAu9opvQ
	(envelope-from <netdev+bounces-292672-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 13:51:47 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D4E8D5F194D
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 13:51:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3CC643001CD1
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 11:50:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD61E3E1691;
	Thu, 28 May 2026 11:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bzl248sX"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8015731E848;
	Thu, 28 May 2026 11:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779969020; cv=none; b=hBsHpLrGfS9+d0npUcd1eLHAX0qocBUZJyjVWWaHSssRz5Q3sqSnmDaHwee+NdcHCiGP54Shl4w0zPwLKG4ySvbOFwF5YcYcs6ppXONrrNSMyEYarDypVmiC41YrTAV7VFM6taPGJ43ibTgV4tK+Jf7zM5hZEwyNEeH357tA/h4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779969020; c=relaxed/simple;
	bh=T5lpdSKsoEaXIxJpnBr/2q7vWZCB7q0zqz3tMazoVrg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=pCDsq60/5qk5A8oZtic593kkEtC5fbLF7TB4ZCQGywShlaz3wbBMJ3lMHYlpq39sDiuylvPK7dIsvADvu5JtVR/LWY4XJtHqLpU8+59yGr7GtFz55hUAVMf6bEUPGFB16BHSEjkP6eupUfo3TQ6+ksLEqygT0jQno3yya4xehoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bzl248sX; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A0E51F000E9;
	Thu, 28 May 2026 11:50:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779969019;
	bh=iTEH889qdyjQuOYuPdCeZWG7mcxcunl8XrScgzNxwwU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=bzl248sXAa3UsUsND4J7ufxCXCDIAJLLAS1Yyacj2SFB2yMB1pgqsluRZZAnRpWr8
	 eImQq13Vtp7mGv6oTx03e+E4Pxjbs2jdXeVFE2PWTa6D6jRNQTpw2nqfS0XCrnpIR8
	 3KLau5qSkgb1Q9wq/hsXd9yTKOud5hKtJehVQGTGQX3QNNTfOn5WJecXaNLkupaCpa
	 qRBuoq48kftWLRZHUUnSVPfZQZqQL90R9do9pBaKMS1S40nXWHIm2asI8Mgz/NaFNk
	 Bf84uKsWyZsl+wL3qWzlLpr2pUWHxvjIKVd1BC6oo5bACVccXDuK9dU/raQwEW0yo5
	 K2KPGK6gFcEEA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 19CC53811959;
	Thu, 28 May 2026 11:50:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v3 0/8] net/handshake: anchor request lifetime to a
 pinned file reference
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177996902389.890175.13707702597875560897.git-patchwork-notify@kernel.org>
Date: Thu, 28 May 2026 11:50:23 +0000
References: <20260525-handshake-file-pin-v3-0-66c616906ead@oracle.com>
In-Reply-To: <20260525-handshake-file-pin-v3-0-66c616906ead@oracle.com>
To: Chuck Lever <cel@kernel.org>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, clm@meta.com, brauner@kernel.org,
 kernel-tls-handshake@lists.linux.dev, linux-nvme@lists.infradead.org,
 netdev@vger.kernel.org, chuck.lever@oracle.com, hare@kernel.org,
 alistair.francis@wdc.com
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-292672-lists,netdev=lfdr.de,netdevbpf];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FROM_NO_DN(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Queue-Id: D4E8D5F194D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This series was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Mon, 25 May 2026 12:51:14 -0400 you wrote:
> handshake_nl_accept_doit() has accumulated four follow-on fixes
> since 3b3009ea8abb ("net/handshake: Create a NETLINK service for
> handling handshake requests"): 7ea9c1ec66bc, 7798b59409c3,
> fe67b063f687, and dabac51b8102.  Each was a local refcount or
> NULL-check correction; none moved where the file reference is
> owned, and the same code keeps producing the same class of bug.
> Reworking the ownership is what breaks the pattern.
> 
> [...]

Here is the summary with links:
  - [net,v3,1/8] net/handshake: Use spin_lock_bh for hn_lock
    https://git.kernel.org/netdev/net/c/cc993e0927ec
  - [net,v3,2/8] nvme-tcp: store negative errno in queue->tls_err
    https://git.kernel.org/netdev/net/c/9015985b5eb1
  - [net,v3,3/8] net/handshake: Pass negative errno through handshake_complete()
    https://git.kernel.org/netdev/net/c/6b22d433aa13
  - [net,v3,4/8] net/handshake: Take a long-lived file reference at submit
    https://git.kernel.org/netdev/net/c/09dba37eee70
  - [net,v3,5/8] net/handshake: hand off the pinned file reference to accept_doit
    https://git.kernel.org/netdev/net/c/f4251190e58b
  - [net,v3,6/8] net/handshake: Close the submit-side sock_hold race
    https://git.kernel.org/netdev/net/c/5da98f55b131
  - [net,v3,7/8] net/handshake: Verify file-reference balance in submit paths
    https://git.kernel.org/netdev/net/c/204a5efde5ed
  - [net,v3,8/8] net/handshake: Drain pending requests at net namespace exit
    https://git.kernel.org/netdev/net/c/ea5fe6a73ca5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



