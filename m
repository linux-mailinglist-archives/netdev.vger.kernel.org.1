Return-Path: <netdev+bounces-267261-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IB2YKv5qs2mPWAAAu9opvQ
	(envelope-from <netdev+bounces-267261-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 02:40:14 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FBFD27C490
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 02:40:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C2A2230221F4
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 01:40:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E1D72FC881;
	Fri, 13 Mar 2026 01:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QoQsDSeW"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B0362F532F;
	Fri, 13 Mar 2026 01:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773366010; cv=none; b=uLo9xQV7NFk82ylsavpUY494L6u8qeiEHeFfQ1Tb81lLgahow0zQmJhE3SerXGxQFWE+zwwlmDiOyOolbb25As3qFPfQELydG/fbvKUDSlWbqqZ+6nYTmo0kDTJ0j2Z3/wa2U9occjCDd3xdfwsOFFVGR61Q9Tm0TKKcMLLLaWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773366010; c=relaxed/simple;
	bh=9julhPHix0+n/imzVgiojmJlJVQn8OgQW7B4wlRNCxM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=U0TrwyGJI7ckEez53HEQUFgsMfe0r+GnJZvMTV0r5jza1meLI6xHRK1EgC1Jrg8Cejgkrh7d1ayn8WndhOHMs74ix4coL6RHlO5gwvqHILhuwk5eKwbuhK89jnnGZx41L+LrTXvVkmO3S+4Rlpa0mJqc+Psa0bFEE8B4gcK7w0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QoQsDSeW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1461AC4CEF7;
	Fri, 13 Mar 2026 01:40:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773366010;
	bh=9julhPHix0+n/imzVgiojmJlJVQn8OgQW7B4wlRNCxM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=QoQsDSeW9b5iSvak8E9HDpJCuBmmK+tGe/dfQ6Jkn5S67eC5AnhN88f9MV8MpGPW9
	 kKut4lFNP7UhcrkC/eyHcmiK0MO5NihXJTJ9ZAU688c4v+nuCksoO7/7u4lX14Rud5
	 h4nrbGK7IWMSfRMl0stPB1NPyWvvSqCqgFBX0TckSzXGwgd0pLmihhvE3wlSqNmd77
	 2/ix87JTA1uVCOqeKD4KEVaNlODQOuocjiPf9q9ByJwaOD/5CMWOMwE71WY9HEzBCD
	 ZGT+/nq6VTqJLV/NRdNPk8gtSswwoMXFdKZhcdwNwofwdmA7GAOG51K+WBy4f93701
	 baZIHKGojT6cQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7CF4E3808200;
	Fri, 13 Mar 2026 01:40:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] bridge: cfm: Fix race condition in peer_mep deletion
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177336600530.628795.16179964876225068685.git-patchwork-notify@kernel.org>
Date: Fri, 13 Mar 2026 01:40:05 +0000
References: <abBgYT5K_FI9rD1a@v4bel>
In-Reply-To: <abBgYT5K_FI9rD1a@v4bel>
To: Hyunwoo Kim <imv4bel@gmail.com>
Cc: razor@blackwall.org, idosch@nvidia.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 bridge@lists.linux.dev, netdev@vger.kernel.org
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-267261-lists,netdev=lfdr.de,netdevbpf];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NO_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0FBFD27C490
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 11 Mar 2026 03:18:09 +0900 you wrote:
> When a peer MEP is being deleted, cancel_delayed_work_sync() is called
> on ccm_rx_dwork before freeing. However, br_cfm_frame_rx() runs in
> softirq context under rcu_read_lock (without RTNL) and can re-schedule
> ccm_rx_dwork via ccm_rx_timer_start() between cancel_delayed_work_sync()
> returning and kfree_rcu() being called.
> 
> The following is a simple race scenario:
> 
> [...]

Here is the summary with links:
  - [net] bridge: cfm: Fix race condition in peer_mep deletion
    https://git.kernel.org/netdev/net/c/3715a0085531

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



