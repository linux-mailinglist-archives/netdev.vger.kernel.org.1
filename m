Return-Path: <netdev+bounces-286025-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mAjFJopm/mk9qQAAu9opvQ
	(envelope-from <netdev+bounces-286025-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 09 May 2026 00:41:14 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 175F94FC6D0
	for <lists+netdev@lfdr.de>; Sat, 09 May 2026 00:41:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 649483019B90
	for <lists+netdev@lfdr.de>; Fri,  8 May 2026 22:41:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC9EC38BF6C;
	Fri,  8 May 2026 22:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hWVnn6yc"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA71536EAAB
	for <netdev@vger.kernel.org>; Fri,  8 May 2026 22:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778280059; cv=none; b=SRdfDUkxSJcoygMX3+P+hfdTReYivUxrupi/zbFzwyxgsePbJ0AE0fy13siJX3ay24WwrP1NHeTNncM4ieo6PyRShrtLkld/p8z8QDkKprZd2BX75P12mJQ52QbFIkqkgbrbtWCpm8AMuhGnz2inIwoSaofUuwoPKPUXeQoCkK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778280059; c=relaxed/simple;
	bh=aHFjIP8Uhi/R3+zj2qmTyppwEebhAQYAmpMMYW9Qbe8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=T+kfvIA/KJ7XC4+rBrVL5a4NFwRoUe4+XheBSkqDLGHesfcahqOq5HJa/fQP2fkB+RzOR9SaGkEjYxIFGiQwJj/cYcVPOUa6DV+xJ/vPxREOUIQnc4k1XIcBnzq+GEUZT8D5rX+BG70qaRk1FzKLCxhd0tc3biCZ0BLc9nrv/aQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hWVnn6yc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 624C2C2BCB0;
	Fri,  8 May 2026 22:40:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778280059;
	bh=aHFjIP8Uhi/R3+zj2qmTyppwEebhAQYAmpMMYW9Qbe8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=hWVnn6yckD8Tca6YG4uSt57TaJXeXCGH0wKFkjqGhEj8LacM0RnbFp//KOytSLEfc
	 72bLJUkc8qSHHpsDno59BO9b23z+P6LGA+fYS4JxjmWUd5Hz4VTUbTPu1VpOy7fLHB
	 /flYqjg/vhc2p9/ELNMBKrj0WeNtXQSUt7mwXcoKlTzMQuIKi0/45Dm4yvi8C6Ne8k
	 GzN14lxems1GATHIZPi5Lc/gk2iPJpHCQprtbVqxUCtLM/ZrgHSAyWMNDj45soB82i
	 8uwThB3qL5VUK6GUj8ZEebq3VLxXYN+pUYKxeSiPbGIp9Dnk4WrqJ51cPZ9fKSTCZt
	 RSJOgYQpjCmGw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 02C5138119D3;
	Fri,  8 May 2026 22:40:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] net: ethtool: fix NULL pointer dereference in
 phy_reply_size
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177828000780.878212.13962692522047721706.git-patchwork-notify@kernel.org>
Date: Fri, 08 May 2026 22:40:07 +0000
References: <20260507131738.1173835-1-2022090917019@std.uestc.edu.cn>
In-Reply-To: <20260507131738.1173835-1-2022090917019@std.uestc.edu.cn>
To: Quan Sun <2022090917019@std.uestc.edu.cn>
Cc: netdev@vger.kernel.org, maxime.chevallier@bootlin.com, andrew@lunn.ch,
 kuba@kernel.org, edumazet@google.com, pabeni@redhat.com
X-Rspamd-Queue-Id: 175F94FC6D0
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	MISSING_XM_UA(0.00)[];
	TAGGED_FROM(0.00)[bounces-286025-lists,netdev=lfdr.de,netdevbpf];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NO_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu,  7 May 2026 21:17:38 +0800 you wrote:
> In phy_prepare_data(), several strings such as 'name', 'drvname',
> 'upstream_sfp_name', and 'downstream_sfp_name' are allocated using
> kstrdup(). However, these allocations were not checked  for failure.
> 
> If kstrdup() fails for 'name', it returns NULL while the function
> continues. This leads to a kernel NULL pointer dereference and panic
> later in phy_reply_size() when it unconditionally calls strlen() on
> the NULL pointer.
> 
> [...]

Here is the summary with links:
  - [net,v2] net: ethtool: fix NULL pointer dereference in phy_reply_size
    https://git.kernel.org/netdev/net/c/4908f1395fb1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



