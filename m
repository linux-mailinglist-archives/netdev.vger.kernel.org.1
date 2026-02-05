Return-Path: <netdev+bounces-257303-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6DKbEvMEhWlW7gMAu9opvQ
	(envelope-from <netdev+bounces-257303-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 22:00:35 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D3825F7534
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 22:00:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 283283027DAF
	for <lists+netdev@lfdr.de>; Thu,  5 Feb 2026 21:00:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D5B733030C;
	Thu,  5 Feb 2026 21:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gJ3uyD6c"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AFFF32FA38
	for <netdev@vger.kernel.org>; Thu,  5 Feb 2026 21:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770325212; cv=none; b=ODCnA80f1baPnW1hUFQbp+rZbgtBBh9URuo6VLNdpAsbXDvI34Wnw8IPORxJnqS4GuZAuziYZxgX82KSbOZysfTxj+YR6rpz/dl9puWLtMG8X/GwXEX7CHwTxPPp4UMWaza3L22rdmYAcnLW9pKPe/183Bhl4mfetnkv0GrehjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770325212; c=relaxed/simple;
	bh=SE2b5vnJqCgpkVOHRPp/g2g4+XZamYkOyEGa5Y5VW6A=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=jZLFjgPKmI4sPaF0ivRhDk63H10ZKHb4WWTI/dwAq8r7PO0MSCyHT0uRkxnTkMpS60K5ti2z4exmeObSc6c243CIWjkrS2h4Dc5+Go5gaqY/rMB3MF4rzOI142TbGHecs1rLQLOuDPBFvzsnDNAGtfIlIj6d9PiEFidF4ffpzhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gJ3uyD6c; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCFF9C19424;
	Thu,  5 Feb 2026 21:00:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770325212;
	bh=SE2b5vnJqCgpkVOHRPp/g2g4+XZamYkOyEGa5Y5VW6A=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=gJ3uyD6c0qoy9OyxHNisq70yxTOwDKYwHeLNjbNWYDyNP9HgCXvJJS5f2E1LJC7CS
	 TU3TGUodHe9aSS26vTz9aY+V1dZ/W50Od3HAruyzox3w7/amuv+W0yeQYcUxEq++tI
	 DSrSo8iQxqrzAnP1DGc4CxvJj5rvpKNpexQYhlooQW8FDLYK3kZlK+z6Mg4UncwazW
	 jUyPw0mINTe72khA+VXuDtAtuqBhZnTWrT+9MlzetHc0ev4V1K9Y2R/lvJHrVRMhSH
	 c/w2X975vl06ENYObUfQ9TGncgmJy78z3+hzCrw8TMPFDfPuN9vRFpdKV+n1nRW3/H
	 hA76GM7xYYPbQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id C22FC3808200;
	Thu,  5 Feb 2026 21:00:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] inet: RAW sockets using IPPROTO_RAW MUST drop
 incoming
 ICMP
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177032520958.564062.6619260477658993593.git-patchwork-notify@kernel.org>
Date: Thu, 05 Feb 2026 21:00:09 +0000
References: <20260203192509.682208-1-edumazet@google.com>
In-Reply-To: <20260203192509.682208-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 willemb@google.com, netdev@vger.kernel.org, eric.dumazet@gmail.com,
 zhaoyz24@mails.tsinghua.edu.cn, idosch@nvidia.com, dsahern@kernel.org
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
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,google.com,vger.kernel.org,gmail.com,mails.tsinghua.edu.cn,nvidia.com];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-257303-lists,netdev=lfdr.de,netdevbpf];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FROM_NO_DN(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D3825F7534
X-Rspamd-Action: no action

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue,  3 Feb 2026 19:25:09 +0000 you wrote:
> Yizhou Zhao reported that simply having one RAW socket on protocol
> IPPROTO_RAW (255) was dangerous.
> 
>   socket(AF_INET, SOCK_RAW, 255);
> 
> A malicious incoming ICMP packet can set the protocol field to 255
> and match this socket, leading to FNHE cache changes.
> 
> [...]

Here is the summary with links:
  - [net] inet: RAW sockets using IPPROTO_RAW MUST drop incoming ICMP
    https://git.kernel.org/netdev/net/c/c89477ad7944

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



