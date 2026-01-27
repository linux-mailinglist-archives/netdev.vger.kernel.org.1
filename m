Return-Path: <netdev+bounces-253681-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sG43GKQzeGlRowEAu9opvQ
	(envelope-from <netdev+bounces-253681-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 04:40:20 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 18EE68FABC
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 04:40:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 33E3D302BDEA
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 03:40:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2D0030C36B;
	Tue, 27 Jan 2026 03:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LVGahqPi"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F9603093AE;
	Tue, 27 Jan 2026 03:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769485211; cv=none; b=JCmyahpaJsDLVlj+bH+GlbrUdEzTV0um208VTDzxlSaZiazpqMOduJfjGe4EIEs7MT9pS7UI7LWfi1O0Dpe2L/PHB9b1UN8wyIBWx8xNo9jjgD94nTn7wKzRBypfysFTOKt7he6q9IWk+5ymRBF8fBcxLaJJjZA/0FTg6DF/mvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769485211; c=relaxed/simple;
	bh=/Wn3GHD1l5REXXLbsHKtIpOIjuedPFqB6JakCmSbMYI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=C7gAJ4DgTTyZN2/Zf5s6bAloi3y/jUQY4VGkzxkgha/f7hTcdMTCpxJUdb6saScRw9ug/g7IiSV30kiMJ+wCqVIOiowZIjstO+R2ydGEsLPBfLbiM2Yc+wfjo85w/eAOlm4oMWr9ifCFyAEtQ9SBShJCj5r+pkZJtNlUMNQ5Lzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LVGahqPi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBF01C116C6;
	Tue, 27 Jan 2026 03:40:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769485210;
	bh=/Wn3GHD1l5REXXLbsHKtIpOIjuedPFqB6JakCmSbMYI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=LVGahqPiuhZIKHEeQfXRuX7h4eiJQBymJAnT3rPA9oynroAILR7jbQn1mWaRZ64rj
	 9aDc+BNPcjltjxfYyo1bLv/6v27ncWlatehId9lWeDYmLYF0W8Lpn/CO2C0zDr9XSZ
	 1nJG34/GUMYQNMEh1cyLir7snVqB7KWucR/FyRnqj4xYphQ9cRjqs91tcqBxc8tXal
	 nN6naHfIlQfMSOMPIVpGAQgVmodvch7KZsKHNUuliC9Qmb5TDMvXgbapcYGQcVmcv2
	 ZZckls99DfUQj+fCShRADIOCvm6JIg76bsYmfddrHUzx4vZkip2TODRMsA6StilD8d
	 lmepvxjCvUhUQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 4EA0D380A961;
	Tue, 27 Jan 2026 03:40:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] rocker: fix memory leak in rocker_world_port_post_fini()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176948520510.672496.9010356926289272974.git-patchwork-notify@kernel.org>
Date: Tue, 27 Jan 2026 03:40:05 +0000
References: <20260123211030.2109-2-qikeyu2017@gmail.com>
In-Reply-To: <20260123211030.2109-2-qikeyu2017@gmail.com>
To: Kery Qi <qikeyu2017@gmail.com>
Cc: jiri@resnulli.us, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-253681-lists,netdev=lfdr.de,netdevbpf];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FROM_NO_DN(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 18EE68FABC
X-Rspamd-Action: no action

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat, 24 Jan 2026 05:10:31 +0800 you wrote:
> In rocker_world_port_pre_init(), rocker_port->wpriv is allocated with
> kzalloc(wops->port_priv_size, GFP_KERNEL). However, in
> rocker_world_port_post_fini(), the memory is only freed when
> wops->port_post_fini callback is set:
> 
>     if (!wops->port_post_fini)
>         return;
>     wops->port_post_fini(rocker_port);
>     kfree(rocker_port->wpriv);
> 
> [...]

Here is the summary with links:
  - rocker: fix memory leak in rocker_world_port_post_fini()
    https://git.kernel.org/netdev/net/c/8d7ba71e4621

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



