Return-Path: <netdev+bounces-298823-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id uZ4oLWabLGrdTgQAu9opvQ
	(envelope-from <netdev+bounces-298823-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 01:51:02 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CE5C67D185
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 01:51:02 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=jm7YE1q5;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298823-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-298823-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 33416328C078
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 23:50:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FFE83093CB;
	Fri, 12 Jun 2026 23:50:15 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05F96351C2D
	for <netdev@vger.kernel.org>; Fri, 12 Jun 2026 23:50:13 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781308215; cv=none; b=LEGhIj/PF5tCUSPqSpPiqUfbsnFqXBRZ1eU4l/aKowlc7qu79IvTw4sKDGlFnW6ZqrIcxNLhm67WHKNmfFcUSxAmn9aXv3zFPQmPPVuMPRQz6bPsp1yufQLtDso8iGxyMPNJH4GYa2lOeaMQvPV8VwkjvEt+rNA0EBnYAl2jCWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781308215; c=relaxed/simple;
	bh=FcgZELyZTCrp+rFgA9DLp3MZbLWu47uCyt0m1uI86OM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ZU16bTpXEnSnHzc6vumwFSQyzk86EpWPoc9PJcrQY3dJ+Qh1Ui0jPbAWByKSfuTt58nGALvMpiWroQ/Gfc4YxcDHy2g+oFLfKoWtpjj+42oxVjtoE/7xAxB6TxmPxgOJmlA4AWXmalrjPFBCe4zgep4qN5BRfoPkWsv/4j90cNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jm7YE1q5; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA8401F000E9;
	Fri, 12 Jun 2026 23:50:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781308213;
	bh=8bw9kVe+AoSSt901WMPG5czOXjk0b2er9T3BJv+ppcs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=jm7YE1q5nveYUxH7UPz0aJhxDI0tUv9VQ8xOAipa/TB+Q8KJ9SgvvjcsEB4dI7MCi
	 tR50Q5wiHxu9laQ8M9K/T6i6gJsn1PgS7ooqKFs3xtoaXOjm6FZRQXyTTfbyihcttE
	 unfP8aNqJRAb7s0cu5K8LAA5wbkOQPcZ0GUpNZ2iaOp4dpk21iHPbLTolZ6LWlJTf4
	 51P3b4V3jffC7ZNqC3CVlfwNe9MERkK/rvBep7ex/zoqA0yCuHpvhnI1cXMa0QWgUI
	 FqKIJRsfCxlMJW2uDIDlVKrIpJKP07F7hIYRnfVCJmzt4Kf0ndTZkzxkjZzuK6OJjq
	 3ryXuv+Tu8WTQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 9399539E9602;
	Fri, 12 Jun 2026 23:50:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 1/1] net: atm: reject out-of-range traffic classes in
 QoS
 validation
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178130821013.1294761.10525972952558393875.git-patchwork-notify@kernel.org>
Date: Fri, 12 Jun 2026 23:50:10 +0000
References: 
 <58f02c6f73d9818fd5d2022e1116759fdde6116b.1780965530.git.zcliangcn@gmail.com>
In-Reply-To: 
 <58f02c6f73d9818fd5d2022e1116759fdde6116b.1780965530.git.zcliangcn@gmail.com>
To: Ren Wei <n05ec@lzu.edu.cn>
Cc: linux-atm-general@lists.sourceforge.net, netdev@vger.kernel.org,
 3chas3@gmail.com, yuantan098@gmail.com, bird@lzu.edu.cn, zcliangcn@gmail.com
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-298823-lists,netdev=lfdr.de,netdevbpf];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[lists.sourceforge.net,vger.kernel.org,gmail.com,lzu.edu.cn];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:n05ec@lzu.edu.cn,m:linux-atm-general@lists.sourceforge.net,m:netdev@vger.kernel.org,m:3chas3@gmail.com,m:yuantan098@gmail.com,m:bird@lzu.edu.cn,m:zcliangcn@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	TAGGED_RCPT(0.00)[netdev];
	FROM_NO_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0CE5C67D185

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue,  9 Jun 2026 16:34:37 +0800 you wrote:
> From: Zhengchuan Liang <zcliangcn@gmail.com>
> 
> Reject ATM traffic classes above ATM_ANYCLASS in check_tp().
> SO_ATMQOS stores the supplied QoS after check_qos() succeeds, so
> accepting larger values leaves invalid traffic_class values in
> vcc->qos.
> 
> [...]

Here is the summary with links:
  - [net,1/1] net: atm: reject out-of-range traffic classes in QoS validation
    https://git.kernel.org/netdev/net/c/cdf19f380e46

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



