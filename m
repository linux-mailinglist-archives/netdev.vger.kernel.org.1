Return-Path: <netdev+bounces-278985-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OGXaD8Ov4GkRkwAAu9opvQ
	(envelope-from <netdev+bounces-278985-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 11:45:39 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B344F40C933
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 11:45:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 61C9C31521D2
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 09:40:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88D7A37C108;
	Thu, 16 Apr 2026 09:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QGp4wFNy"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66D251EF091
	for <netdev@vger.kernel.org>; Thu, 16 Apr 2026 09:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776332437; cv=none; b=u7WEYyo+7Ge7Yv6C+lCbd/T1ABcRMo8W7FD9/5cZ0mlKprYVI055Cy7ukG8aPYi+SpJqX0WRwKE2oYg71jEBT6QM139ELTz3VwgktcnHoj6W83R4keAg9BZ1ONRBaHgbk3H9CQEP9FoIr1XT8A5yKlKa8UeyOFJ1Dc+ACJOq/Pw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776332437; c=relaxed/simple;
	bh=4cm7N4+2KetiOTDMzw3C8XcqQyKC6SnW0eiww7y1F/0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=nCR1djIkPvRucK6Z4dY8Xs97kEO4BsdDT3Pt7a6CFF7TeBjhE1J+kCIYw7QfDjMFTG4JB15v43asgc2CM11KfN8MQ9SMmTB5rDDY0hyl5cEiBYE9olRxdh5tDZcIA5DDY8LSoo1e2nNXQB/tKtrS6IlfH2IdRKOERN5qv/DsyLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QGp4wFNy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02BF4C2BCAF;
	Thu, 16 Apr 2026 09:40:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776332437;
	bh=4cm7N4+2KetiOTDMzw3C8XcqQyKC6SnW0eiww7y1F/0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=QGp4wFNyqA98U2Xp7kM/O6Z8Jfvt/PEHi8hPJ2Cxrapj1jzuQosESQBvDGHwQcIKg
	 rdjooxaKDZQkAYUQETUl+zirgToXceeuCLmmH/9iYoW5aHKlf+ZEPLnnmT/GPm7Q67
	 OVoKsnn4kapS6bl0gfzYavvJbAYb2MLi49bR21mJllzHCywr31cMhH6XZQFYB4UwmS
	 GbqhKXspnyjrW+/vh4yGhg1Rl2EiXGHPzAmj1UKFQfBwa2TsGkajOrgW3dGl8eZwL4
	 N4qX0vPlB85lA4YMnWc3LqIg98QO+iPz0gsnnsNXZDzqH1Jgi05RNr9FHiEN1dDVHZ
	 bG3E5mpOOPWDw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 02C54380A979;
	Thu, 16 Apr 2026 09:40:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] net/sched: act_mirred: fix wrong device for
 mac_header_xmit
 check in tcf_blockcast_redir
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177633240555.2710724.8790736448507828329.git-patchwork-notify@kernel.org>
Date: Thu, 16 Apr 2026 09:40:05 +0000
References: <20260413084927.71353-1-phx0fer@gmail.com>
In-Reply-To: <20260413084927.71353-1-phx0fer@gmail.com>
To: Dudu Lu <phx0fer@gmail.com>
Cc: netdev@vger.kernel.org, jhs@mojatatu.com, jiri@resnulli.us
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-278985-lists,netdev=lfdr.de,netdevbpf];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_NO_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B344F40C933
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Mon, 13 Apr 2026 16:49:27 +0800 you wrote:
> In tcf_blockcast_redir(), when iterating block ports to redirect
> packets to multiple devices, the mac_header_xmit flag is queried
> from the wrong device. The loop sends to dev_prev but queries
> dev_is_mac_header_xmit(dev) — which is the NEXT device in the
> iteration, not the one being sent to.
> 
> This causes tcf_mirred_to_dev() to make incorrect decisions about
> whether to push or pull the MAC header. When the block contains
> mixed device types (e.g., an ethernet veth and a tunnel device),
> intermediate devices get the wrong mac_header_xmit flag, leading to
> skb header corruption. In the worst case, skb_push_rcsum with an
> incorrect mac_len can exhaust headroom and panic.
> 
> [...]

Here is the summary with links:
  - net/sched: act_mirred: fix wrong device for mac_header_xmit check in tcf_blockcast_redir
    https://git.kernel.org/netdev/net/c/4510d140524c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



