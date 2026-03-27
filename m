Return-Path: <netdev+bounces-272363-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8CRMDYL+xWktFAUAu9opvQ
	(envelope-from <netdev+bounces-272363-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 04:50:26 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 849CD33EEA7
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 04:50:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E7001303276C
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 03:50:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4802372667;
	Fri, 27 Mar 2026 03:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OkVZguWm"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B29B623BF9F
	for <netdev@vger.kernel.org>; Fri, 27 Mar 2026 03:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774583422; cv=none; b=d3uZxmKoLVnE3g5fmvKs7JFd7MV6VBI5Nbwtc/RmsY93zPpT8Crv8roeBEH+ds2G7K2/bzoSmKFHyIXSuSZxVPRc48sYoiL+3Qgnt6unA8L8roVFYj9OIHZ0VDt1Kqwkd/UFU9g42jjhb9xj5amvI8RSh4YR4doIp+vk/8HW+3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774583422; c=relaxed/simple;
	bh=K+UdFI2hEPJSprNbPSERzW8rvWzEGbAZtWKdJrgbANM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=a62VTeaMOMOvOOnP3DYEiX4Rr8fcZL490HQD7OPzk/h2UwBYIdou48yrjrJ17kZ9Zy6/OhlFRtg3MKO3fpvuuzpt065XN56tWnK6L9ByK0YHNfSJFwSgGCoS1FLK+zln8teGCuNAZBokI7FmVheWlfw4kjeNnMcAUsh6zvDOy4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OkVZguWm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49186C19423;
	Fri, 27 Mar 2026 03:50:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774583422;
	bh=K+UdFI2hEPJSprNbPSERzW8rvWzEGbAZtWKdJrgbANM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=OkVZguWmc/AKcBgxWtntHIACcNVdaicnmj68GM4TukOQz4TpsCTBuGx7tkWjxcpCE
	 /YybDkqT8iP6NIPknXM7ePcWvx5F9Qy8zhtTdNQUlQoXQYjq0WZnelGMH8IYDVRzx6
	 V66k5FC4l+JQgRy9hi+F2F6WTHAsL33ccdTQNDiXRx51dHmMILNSCiC+jq7H21Of8R
	 iVhiDaDMqXrs3PpxCR9Tlo3ohpyHfpaYax4vS2lo1farynq6Z2s6aekKIjjfc38lZ5
	 YL7G+QtQu0wWm8xZVXCX8JzkBRhrY0R08ZFOw4zftCMQnXyKGDeDIb+0gs5aWEP63H
	 pHkSzJy49HKGQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B9E823809A0B;
	Fri, 27 Mar 2026 03:50:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] net: ipv6: ndisc: fix ndisc_ra_useropt to initialize
 nduseropt_padX fields to zero to prevent an info-leak
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177458340854.3291104.1692418192730790806.git-patchwork-notify@kernel.org>
Date: Fri, 27 Mar 2026 03:50:08 +0000
References: <20260324224925.2437775-1-echelonh@gmail.com>
In-Reply-To: <20260324224925.2437775-1-echelonh@gmail.com>
To: Yochai Eisenrich <echelonh@gmail.com>
Cc: davem@davemloft.net, dsahern@kernel.org, security@kernel.org,
 netdev@vger.kernel.org
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-272363-lists,netdev=lfdr.de,netdevbpf];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FREEMAIL_TO(0.00)[gmail.com];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_NO_DN(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5]
X-Rspamd-Queue-Id: 849CD33EEA7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 25 Mar 2026 00:49:25 +0200 you wrote:
> When processing Router Advertisements with user options the kernel
> builds an RTM_NEWNDUSEROPT netlink message. The nduseroptmsg struct
> has three padding fields that are never zeroed and can leak kernel data
> 
> The fix is simple, just zeroes the padding fields.
> 
> Fixes: 31910575a9de ("[IPv6]: Export userland ND options through netlink
>     (RDNSS support)")
> Signed-off-by: Yochai Eisenrich <echelonh@gmail.com>
> 
> [...]

Here is the summary with links:
  - net: ipv6: ndisc: fix ndisc_ra_useropt to initialize nduseropt_padX fields to zero to prevent an info-leak
    https://git.kernel.org/netdev/net/c/ae05340ccaa9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



