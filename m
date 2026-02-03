Return-Path: <netdev+bounces-256065-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GHrSGAZOgWlMFgMAu9opvQ
	(envelope-from <netdev+bounces-256065-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 02:23:18 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BC7C6D3577
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 02:23:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B3F803046503
	for <lists+netdev@lfdr.de>; Tue,  3 Feb 2026 01:20:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8105A1B4223;
	Tue,  3 Feb 2026 01:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="itLtELL7"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E0C4145355
	for <netdev@vger.kernel.org>; Tue,  3 Feb 2026 01:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770081609; cv=none; b=f0WT72sGIgULK/WSe0XFZaS3wosOqFCiCKS8trVMY/1WgoiDgtctDgWnyDXa7dWxFCG0bOSOLTWV0mZ6uBsTwQzdWmOd/dqWQJY4LzKCIQy6DkuNasfNqNFiQSUyTS8WR/UE+pIJFNkvxYp5vN3w1NVeLdEE72o50hNNxnsxtIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770081609; c=relaxed/simple;
	bh=BA6nAkFkOEq1nXydj/aEhmpiyNnmGq5deX8+ZGt0L/Y=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=uyFKSrz1VcXFQncRrALkG82OvwPtfhDFgZY6LEn1bNmJKVWFH3/V4Rt2DwOnM4ot5oiz8ZLbWa+uYwdqkRXOSg6Qv6hfNChiAQ/wZjdqPj+kUNMtYH77JRDlyEwv8xdjVuYRoMAo9SgukrQDd85Mp+UlzPcS2NuVzL6a++ASkRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=itLtELL7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3DF5C116C6;
	Tue,  3 Feb 2026 01:20:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770081609;
	bh=BA6nAkFkOEq1nXydj/aEhmpiyNnmGq5deX8+ZGt0L/Y=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=itLtELL7Vq33hKzrvAD6x65Mqh4aVcBFsY/B10j6mzn6ykIJ/M9XIm++5aDm42CE1
	 NP5a5zgugK41tNy8O7j6QnQDMRkDVqqwm+kyJjNKTOIQuWCY/yoJvzg3W8DYDvT3dd
	 PwaTMmvNsga9loffiFw8qSk9qBLqdFpFEh6blMlVcPbEs9j4C+OcNTUHDsXesJiMNf
	 Q5D/TwLSYGENWhxeEGIympvroR/ntKegB4DEJo2HEx010brCczyHlzsywAfxz/7uAv
	 1DMlFptUwODeGwuI0KRKtvn6jfdgSEpjXvLeqRV7EfxKEipq+kIvqpZRxQjG+vxKAe
	 e6+F8GUzMZ6rA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id E6A983808200;
	Tue,  3 Feb 2026 01:20:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: rss: fix reporting RXH_XFRM_NO_CHANGE as
 input_xfrm
 for contexts
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177008160562.1261691.14643963263135767884.git-patchwork-notify@kernel.org>
Date: Tue, 03 Feb 2026 01:20:05 +0000
References: <20260130190311.811129-1-kuba@kernel.org>
In-Reply-To: <20260130190311.811129-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org, andrew@lunn.ch,
 maxime.chevallier@bootlin.com, gal@nvidia.com
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
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-256065-lists,netdev=lfdr.de,netdevbpf];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
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
X-Rspamd-Queue-Id: BC7C6D3577
X-Rspamd-Action: no action

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 30 Jan 2026 11:03:11 -0800 you wrote:
> Initializing input_xfrm to RXH_XFRM_NO_CHANGE in RSS contexts is
> problematic. I think I did this to make it clear that the context
> does not have its own settings applied. But unlike ETH_RSS_HASH_NO_CHANGE
> which is zero, RXH_XFRM_NO_CHANGE is 0xff. We need to be careful
> when reading the value back, and remember to treat 0xff as 0.
> 
> Remove the initialization and switch to storing 0. This lets us
> also remove the workaround in ethnl_rss_set(). Get side does not
> need any adjustments and context get no longer reports:
> 
> [...]

Here is the summary with links:
  - [net] net: rss: fix reporting RXH_XFRM_NO_CHANGE as input_xfrm for contexts
    https://git.kernel.org/netdev/net/c/1c172febdf06

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



