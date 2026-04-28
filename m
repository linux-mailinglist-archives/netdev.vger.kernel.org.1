Return-Path: <netdev+bounces-281563-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6jHFNXQE8GlmNQEAu9opvQ
	(envelope-from <netdev+bounces-281563-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 02:51:00 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AACC47C3C0
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 02:50:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 294603029E47
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 00:50:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 350D0194C98;
	Tue, 28 Apr 2026 00:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bu8cVxV7"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 131CF192D97
	for <netdev@vger.kernel.org>; Tue, 28 Apr 2026 00:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777337457; cv=none; b=jGSQgxu3ZVni8+8B5mOE6LRYtuMygrGxJ6sLo4BmlIsljS/qJrHu+l0xuujo2wMyyHqrQH4BUpGP0EXwxZpX/D4YZ0o0vDUsF8LaOR0pojMX4QM6tn8HdeV++XJjdST1iF2ZsSk/3QCJGYhCi1K9GYkn3wWLScN65h4XtflJnx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777337457; c=relaxed/simple;
	bh=R7ADNX1jf9OhXrcafwcDoBnl6HyFNCWlQ2FTkyuUYmw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=irSk14Z+HKICU7gSi/SVUYkkNZgSPUuBkLF5pkfsF0DTW6pV+dUbphSATjWiqeZZJoalm863W1PPT1nolIADT80wTpnQ6gOE1tk/y4A1o3DgsIBi2riugUZOyAR1ANnPLTeFk4RM+GeGeA4b546yt7b/yFLPDDtS6aC2r3gy7AY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bu8cVxV7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8CCDC19425;
	Tue, 28 Apr 2026 00:50:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777337456;
	bh=R7ADNX1jf9OhXrcafwcDoBnl6HyFNCWlQ2FTkyuUYmw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Bu8cVxV74ti5wjzYFKSV/xL3s0otHRgIogfC31FaavyNg7w+5DD05pNfNbG1U0Hzd
	 xwa7wbIstmQhL2MwgEcuHyJrtG3YZ3dL69bZ1KHl4moHN6KCue28oZJBm8RnVtn91J
	 WIFeayOcaZbXIIKC3vpyAVQ6htVvF9YV+rzaJrWqKsmfbgtXifMVch1LRwFk4yB7yz
	 OK9D708n/m8Dc8cinSVkhGHaJWrbW9kFpdVZ3M6vXHjWIKPboWGGkrWA94zmGbk575
	 LgF0Z7ALVAIc2kGzZQyc0DYohF9M3BrZ4yj0yYqwgfPBV0/o1Vz/u7Bcki5Mlwx6St
	 C9GW1526D2xvg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3FCE038119DB;
	Tue, 28 Apr 2026 00:50:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] vrf: Fix a potential NPD when removing a port from a
 VRF
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177733741380.177472.14117657989720921940.git-patchwork-notify@kernel.org>
Date: Tue, 28 Apr 2026 00:50:13 +0000
References: <20260423063607.1208202-1-idosch@nvidia.com>
In-Reply-To: <20260423063607.1208202-1-idosch@nvidia.com>
To: Ido Schimmel <idosch@nvidia.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 pabeni@redhat.com, edumazet@google.com, dsahern@kernel.org, jiri@resnulli.us,
 andrew+netdev@lunn.ch, royenheart@gmail.com, yifanwucs@gmail.com,
 tomapufckgml@gmail.com, yuantan098@gmail.com
X-Rspamd-Queue-Id: 2AACC47C3C0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-281563-lists,netdev=lfdr.de,netdevbpf];
	FREEMAIL_CC(0.00)[vger.kernel.org,davemloft.net,kernel.org,redhat.com,google.com,resnulli.us,lunn.ch,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 23 Apr 2026 09:36:07 +0300 you wrote:
> RCU readers that identified a net device as a VRF port using
> netif_is_l3_slave() assume that a subsequent call to
> netdev_master_upper_dev_get_rcu() will return a VRF device. They then
> continue to dereference its l3mdev operations.
> 
> This assumption is not always correct and can result in a NPD [1]. There
> is no RCU synchronization when removing a port from a VRF, so it is
> possible for an RCU reader to see a new master device (e.g., a bridge)
> that does not have l3mdev operations.
> 
> [...]

Here is the summary with links:
  - [net] vrf: Fix a potential NPD when removing a port from a VRF
    https://git.kernel.org/netdev/net/c/2674d603a9e6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



