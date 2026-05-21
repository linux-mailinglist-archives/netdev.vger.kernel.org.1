Return-Path: <netdev+bounces-290212-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uLM3B8NsDmob+gUAu9opvQ
	(envelope-from <netdev+bounces-290212-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 04:24:03 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8712B59E09E
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 04:24:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 11BFF309BFDA
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 02:21:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 358F336A372;
	Thu, 21 May 2026 02:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JrL800Rf"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 799693672B1
	for <netdev@vger.kernel.org>; Thu, 21 May 2026 02:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779330035; cv=none; b=GDIuxXITnr7Bf+BE2dg1HaGNdFtUnv5T7SSsw5jVQa3yXPOXfJ+dMBUMySGq0PBJSo7iUriCDBjkgk0ScIAEqJz+ZB53X+In2MrtuKg5uyN7JLgeS99hGmSUsh9uLwxalbTF/3t2ftKdkTMExqPXmHW9UTELA7YTRFdcfPQw9vE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779330035; c=relaxed/simple;
	bh=TcYQl9X2SZ2hvBbp3TOMjCDRHScz/WrNUVVZuWEUU8U=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=rROEqrV4TNgiXTR0RCZe9L73IJref6ekNruTjMwY9NBI7DE66h5NIOGa0gRtxaByOiwJfMTLk/EpZLUz96eX03ZQeUscyTMAtq9NcXBGLNgF+oSjw3csA+WoJCHWSy3pvUZUpQAOjPU+HFoXmteoJC+U2C/UdB2cWWXCdjGJbl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JrL800Rf; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A89701F00A3C;
	Thu, 21 May 2026 02:20:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779330014;
	bh=/277KEkO6bByVh5h7ePAs12l5Xlz58eQTSj3xCqUlys=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=JrL800Rf8FkgCSCv2ZGg4pujWbxpKTZN+YD2YNpCxdubK69Hi0FjwB4cz9zMKC6ST
	 2GipBR8D3DTWuA9BsfbKygQvOR+EghFdvmrG09UeZ6bGefBsemx2kDPtUeucS0eq5r
	 27SoBoVErca6XU0hWIZhec+63qJAXrQzgqobumSIavKw9gctV90SRn7nlXVYUMe05Y
	 IPyRKD9INCjpobWFAEekAKqrcODrHAmaob+7VrdGLvRjUnKYdhN+VTmvrJ6YZQxY0v
	 Orn4dARqsAX2QsxLN8EmhrhhsCcncfe7RXIKDyg/5UDUTBuIoEg3tIPbN/P1Y7EHtv
	 qtpk2Wh8sEPYA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 197D43930C38;
	Thu, 21 May 2026 02:20:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/2] net/sched: sch_drr: lockless cl->deficit and
 cl->quantum
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177933002463.3834961.8475639807959531183.git-patchwork-notify@kernel.org>
Date: Thu, 21 May 2026 02:20:24 +0000
References: <20260519094618.2632073-1-edumazet@google.com>
In-Reply-To: <20260519094618.2632073-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 jhs@mojatatu.com, victor@mojatatu.com, jiri@resnulli.us,
 netdev@vger.kernel.org, eric.dumazet@gmail.com
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,mojatatu.com,resnulli.us,vger.kernel.org,gmail.com];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-290212-lists,netdev=lfdr.de,netdevbpf];
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
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 8712B59E09E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 19 May 2026 09:46:16 +0000 you wrote:
> First patch adds missing annotations around cl->deficit.
> 
> Second patch makes cl->quantum lockless, to prepare
> future lockless qdisc dumps.
> 
> Eric Dumazet (2):
>   net/sched: sch_drr: annotate data-races around cl->deficit
>   net/sched: sch_drr: make cl->quantum lockless
> 
> [...]

Here is the summary with links:
  - [net-next,1/2] net/sched: sch_drr: annotate data-races around cl->deficit
    https://git.kernel.org/netdev/net-next/c/c67b104fd798
  - [net-next,2/2] net/sched: sch_drr: make cl->quantum lockless
    https://git.kernel.org/netdev/net-next/c/a4d880b85089

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



