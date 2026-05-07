Return-Path: <netdev+bounces-285408-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mMlJHUm1/Gm0SwAAu9opvQ
	(envelope-from <netdev+bounces-285408-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 17:52:41 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 227364EB793
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 17:52:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E4D433027FEF
	for <lists+netdev@lfdr.de>; Thu,  7 May 2026 15:51:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE0E945090A;
	Thu,  7 May 2026 15:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LWchBoNF"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B5BB4508F2
	for <netdev@vger.kernel.org>; Thu,  7 May 2026 15:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778169071; cv=none; b=oW2GrZiQJFqHREvuoJhsbK6ONbAxWgwLxhzYEo32/RdKxdZBv7IuvFqNzVJM40CXhXDrjSB6YyLIppCqSbUrNnCqnfw0YpoY366n0kcPdHiSz35zo4S3JYRPne5I6BfSn1XVrMF/GVuKUwJwHu5UZC97eVqGpg7TAinvUgvYDE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778169071; c=relaxed/simple;
	bh=IMFgus74OpnbQ6x5X1sh7hJ8iEcoMxKidPYzqPPnJyc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=uhkJeS8OYBzPXvAgtesXF1Ae5xV8euAP3gjMj4Qkv9WZFOTe56vlpTWW+biiD4O2Ie42LredNzs5kXO8cWKyTMmVDw8Ii48ziEOhqNP5jRbu8KbVloA51RqYwX4eNt0B7dR9eKP0gNLnZmBnsdwHYv8vSysNaG+CVR86vKpDm7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LWchBoNF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49729C2BCC9;
	Thu,  7 May 2026 15:51:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778169071;
	bh=IMFgus74OpnbQ6x5X1sh7hJ8iEcoMxKidPYzqPPnJyc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=LWchBoNFdXjkZA70Qdwrc+wMzAZ0bgujHD8WPWK2/mlvrhnBp8CwiwJVyF9kNLOec
	 MgcfsZwWasdPWlCgCNoRmkQRVYNfcTwu1JJFjKTtsSdT5OTOpEMClZnyJRfyemGTVD
	 Yanl23KG/oNxd7hA1dD7qnpB+kZgj3cyd65NbQxVyuTYn2Yq3JqKgSrqXnPIaMeSnK
	 d1cqKdU4DTtgwkP/jbcLKv4ys8+xwhXGoUt5cvz409HX/blth33yT3cDZOezJ1XU7+
	 YeMfDit78ZbzN2r1Vw0CEVCHpRKresYGB5Kbq5PirCHVj3Bwyrz4SHh1ZsUlRsbbhT
	 t1T1UGsJDrV8A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B9F563930909;
	Thu,  7 May 2026 15:50:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v3] af_unix: Reject SIOCATMARK on non-stream sockets
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177816902034.4048611.2784760047754282020.git-patchwork-notify@kernel.org>
Date: Thu, 07 May 2026 15:50:20 +0000
References: <20260506140825.2987635-1-n05ec@lzu.edu.cn>
In-Reply-To: <20260506140825.2987635-1-n05ec@lzu.edu.cn>
To: Ren Wei <n05ec@lzu.edu.cn>
Cc: netdev@vger.kernel.org, kuniyu@google.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 rao.shoaib@oracle.com, yuantan098@gmail.com, yifanwucs@gmail.com,
 tomapufckgml@gmail.com, bird@lzu.edu.cn, wangjiexun2025@gmail.com
X-Rspamd-Queue-Id: 227364EB793
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,google.com,davemloft.net,kernel.org,redhat.com,oracle.com,gmail.com,lzu.edu.cn];
	TAGGED_FROM(0.00)[bounces-285408-lists,netdev=lfdr.de,netdevbpf];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_TWELVE(0.00)[14];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NO_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed,  6 May 2026 22:08:23 +0800 you wrote:
> From: Jiexun Wang <wangjiexun2025@gmail.com>
> 
> SIOCATMARK reports whether the receive queue is at the urgent mark for
> MSG_OOB.
> 
> In AF_UNIX, MSG_OOB is supported only for SOCK_STREAM sockets.
> SOCK_DGRAM and SOCK_SEQPACKET reject MSG_OOB in sendmsg() and recvmsg(),
> so they should not support SIOCATMARK either.
> 
> [...]

Here is the summary with links:
  - [net,v3] af_unix: Reject SIOCATMARK on non-stream sockets
    https://git.kernel.org/netdev/net/c/d119775f2bad

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



