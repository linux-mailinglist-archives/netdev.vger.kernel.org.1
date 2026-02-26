Return-Path: <netdev+bounces-261280-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +JhjJFAjoGkDfwQAu9opvQ
	(envelope-from <netdev+bounces-261280-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 11:41:20 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DC29B1A46E7
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 11:41:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1658D308A158
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 10:40:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDDB23A7F7A;
	Thu, 26 Feb 2026 10:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cNdywAOf"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC2DB3A7F57
	for <netdev@vger.kernel.org>; Thu, 26 Feb 2026 10:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772102400; cv=none; b=FZdKsCrQQ6lVFQGrHtUTdxsMbPUR1CtWGkjPV0+vpsf3nEjfdE/OKov/JUQsB0zyErFRqCDXeufkxAAChF9RisVO9Lw3u+Blp8UMLaSr8xh42Jrh5XxYeb4JtAdeP9Vd0We1OEP+G0Jabgc1XPDVN81e3Z4Hd4DYVmpkhfnBDu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772102400; c=relaxed/simple;
	bh=F3HrGAIU2tfaqiQKMyFnIuLdK/rMxiP1uTtgtBIesuc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=LqsRNRFTc1lnqLyKcrswCBSa9FM6HNXLJkDyRPnCmW2SqB2z4xiwUrAojOhcRrpRdmeD8JcT54PDAFDEmTzVX4EqLq/qvhwDxG6Dh0YsBg2w60cQg3mEUd6BEfUMlHFlWEjVWT+lxaD0In5ZpfFG/O9+fvywgSy+PyhE7HwavJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cNdywAOf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F3EEC116C6;
	Thu, 26 Feb 2026 10:40:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772102400;
	bh=F3HrGAIU2tfaqiQKMyFnIuLdK/rMxiP1uTtgtBIesuc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=cNdywAOfm8n8FdWGqCtZMnQl35m/76rpDRSlQNpCLXc+0HZcJnValSYwO2Fajv4GG
	 KFMFWEcPRobVXr8PKSbHJIC/gctnTjPr5rKCd9mdKBQfUVUKQHGo8V2on5LyoBw8N5
	 uc6uOJP+EGfmzSHj5mj/18d3Q/Xa4AtPcRNkidv9ft6ysihLU3tkQAb9uW4HQLYE0g
	 N0LuZww/1wxffO0F0kk7keV0OiYomIb7nw8TtlkSKd8JOzqbYQR+UMxZeiNIubR1UN
	 legQnFKZ2lD3jVXyhPvAV+mOoPWSOm6H7NPGpvfQN1DZcs4retHXNDnB61ZLTzrgYy
	 IysSH/v0Mdq1A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 02C1B380A977;
	Thu, 26 Feb 2026 10:40:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] net: consume xmit errors of GSO frames
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177210240479.1154168.3627638731313377314.git-patchwork-notify@kernel.org>
Date: Thu, 26 Feb 2026 10:40:04 +0000
References: <20260223235100.108939-1-kuba@kernel.org>
In-Reply-To: <20260223235100.108939-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org, sdf@fomichev.me,
 hawk@kernel.org, alexander.h.duyck@intel.com
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-261280-lists,netdev=lfdr.de,netdevbpf];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NO_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,udpgro_bench.sh:url,udpgro_frglist.sh:url]
X-Rspamd-Queue-Id: DC29B1A46E7
X-Rspamd-Action: no action

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Mon, 23 Feb 2026 15:51:00 -0800 you wrote:
> udpgro_frglist.sh and udpgro_bench.sh are the flakiest tests
> currently in NIPA. They fail in the same exact way, TCP GRO
> test stalls occasionally and the test gets killed after 10min.
> 
> These tests use veth to simulate GRO. They attach a trivial
> ("return XDP_PASS;") XDP program to the veth to force TSO off
> and NAPI on.
> 
> [...]

Here is the summary with links:
  - [net,v2] net: consume xmit errors of GSO frames
    https://git.kernel.org/netdev/net/c/7aa767d0d3d0

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



