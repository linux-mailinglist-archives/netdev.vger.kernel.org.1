Return-Path: <netdev+bounces-258677-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OSk3EKiKj2nzRQEAu9opvQ
	(envelope-from <netdev+bounces-258677-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 13 Feb 2026 21:33:44 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 990D3139724
	for <lists+netdev@lfdr.de>; Fri, 13 Feb 2026 21:33:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DDBF0315EA9B
	for <lists+netdev@lfdr.de>; Fri, 13 Feb 2026 20:30:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C1002BDC2C;
	Fri, 13 Feb 2026 20:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M8X8TZWP"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7878929B228;
	Fri, 13 Feb 2026 20:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771014619; cv=none; b=AKzWuVEO2P/6jdDMhboCZ1uG84poz4KS6RZgvdNcKxjVY8iOwVY/3yJRX8XyVtD9KbKz2WcD+2fJnmLypodqMZ793onit0V6hWjOdcRM7frsFzLWzy5WSiK/Sysfjsf1GXk3y/Tl4pvkNO1p3qqPWxrKi2n2nYS7A4K4QQfdeu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771014619; c=relaxed/simple;
	bh=5Kt/TKVWBsSUqUTIqLI1iXg/DdngCWvR0T0lEzWHZaU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=j3mw/H9/bOCq5uGstQ9D4rKb3CxYlqwss/8eSGdf8jb4WVxOD7nfmfiJecuVFNpiDB5obI1FGHmA3k+5En9D4wFzURZ5QKPQ5S3TFMGN/qPd6nnB2+L+nxSFG8gZQCKku/g1ssSQB6i0cjRwcgZy2lVdn6fmAHfm5na3H7/Zm+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M8X8TZWP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F365C116C6;
	Fri, 13 Feb 2026 20:30:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771014619;
	bh=5Kt/TKVWBsSUqUTIqLI1iXg/DdngCWvR0T0lEzWHZaU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=M8X8TZWPP8U9DqfALFNzdqFyTEpBxb10+urNwyCc0BN4oIuknrcTkx8k9srjaD9jb
	 jw3CIsP5jD81VrAQeeRZsiJMQuadq73wQ2SG+EExyIpegGmAaG/yFSC3ZsRRof1O+9
	 h5IytQokhVQzsaqEVjCz/T0lWtdVTXU0xggrnBiAhNchpV+1Mp/RjfhDi6OmOR9nDB
	 wK9ib83/OMQSfHweN1oqM3k8VTjlTY8NrG1rjfZ2ePzgHe7eQCnboaAcBin37CVZ9q
	 J9juAVa6Vp3Lf6TsAHzLrV4B/usTPAC4tan7jUWsTJqC6kTbQUTZwX1DbtnC1K8dgh
	 foJTi+u7pEROQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 0B18D3811A44;
	Fri, 13 Feb 2026 20:30:14 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: sparx5/lan969x: fix PTP clock max_adj value
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177101461282.2548179.9241300584725576319.git-patchwork-notify@kernel.org>
Date: Fri, 13 Feb 2026 20:30:12 +0000
References: <20260212-sparx5-ptp-max-adj-v2-v1-1-06b200e50ce3@microchip.com>
In-Reply-To: <20260212-sparx5-ptp-max-adj-v2-v1-1-06b200e50ce3@microchip.com>
To: Daniel Machon <daniel.machon@microchip.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, Steen.Hegelund@microchip.com,
 UNGLinuxDriver@microchip.com, richardcochran@gmail.com,
 horatiu.vultur@microchip.com, netdev@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-258677-lists,netdev=lfdr.de,netdevbpf];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,microchip.com,gmail.com,vger.kernel.org,lists.infradead.org];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_NO_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 990D3139724
X-Rspamd-Action: no action

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 12 Feb 2026 12:02:30 +0100 you wrote:
> The max_adj field in ptp_clock_info tells userspace how much the PHC
> clock frequency can be adjusted. ptp4l reads this and will never request
> a correction larger than max_adj.
> 
> On both sparx5 and lan969x the clock offset may never converge because
> the servo needs a frequency correction larger than the current max_adj
> of 200000 (200 ppm) allows. The servo rails at the max and the offset
> stays in the tens of microseconds.
> 
> [...]

Here is the summary with links:
  - [net] net: sparx5/lan969x: fix PTP clock max_adj value
    https://git.kernel.org/netdev/net/c/a49d2a2c37a6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



