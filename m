Return-Path: <netdev+bounces-257737-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gK3uM9zGhmkNQwQAu9opvQ
	(envelope-from <netdev+bounces-257737-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 07 Feb 2026 06:00:12 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EB7F104F8B
	for <lists+netdev@lfdr.de>; Sat, 07 Feb 2026 06:00:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BA67E30247C8
	for <lists+netdev@lfdr.de>; Sat,  7 Feb 2026 05:00:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CA80286D53;
	Sat,  7 Feb 2026 05:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A4ZfExvt"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A2892D5940;
	Sat,  7 Feb 2026 05:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770440410; cv=none; b=e3m3VjxB3ftNe6jnGQMPg/QVFydiVcTd5XuSFTbN86FMan7Ndu9B8Jy5lGxHN9qa83yyD5dDwkWcvZr2c5/7IWzhQG4wDBFtFv95um2IAkeW5z50W0ohm+cYrHkLAdfouJ6yQ0EZyKdXXgvboUDXnySnSfFS/OQgn19M9CCSUQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770440410; c=relaxed/simple;
	bh=yW6a/iFiWTnIULLGg+yk1KBevUQLK5BxnsKLtpj0JW4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=DSTwUBGO94ixpwMXKg2Lcm2ZhitHvOiwD3uZDCguqQJ6C5zzZtT2/QBMo74F7SFTS4jW/V1hSzDACkwBhLQz7rUqL89XAa2ah3FkDvx/3coUB0vRFlh7tdhOfPoVBvbil3Q5jvo3Fy+o67uviIKqjDlh6cuGF3/LEBpRa46NZ4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A4ZfExvt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 886DEC116D0;
	Sat,  7 Feb 2026 05:00:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770440409;
	bh=yW6a/iFiWTnIULLGg+yk1KBevUQLK5BxnsKLtpj0JW4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=A4ZfExvtmY5fmOyMys3f4jcwBWUYRKmYgnTKf+ZlJa2nu3/1f9DYZq24lk7GLaQTJ
	 +160xhENKVMMJvGoo6ibC0WDD8CeoDLSKY5sUPgsrQ/yKdzzZhVgjVPB4ugDqj0MFk
	 cX4BWk9OCZWXqHEHOCKr9XxkLh3IaZ4K2e2RPANnDlRRuaSzntjkYlwYQphri2HVcV
	 o9hHXkcAQ5/iG4c4cGmLGhFf9DHft5+30pDePwCkFIVZd8/hNz1MJ1nVEBgGGSz3N2
	 sEWOSEjkZrWLqTEQ6KIVPx6izxs7rVjjdjdK+h9C5mcuVfRNwtVonSOKZR9z9w0VH1
	 HSzjnAyiqyg2Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id C22C63809A1A;
	Sat,  7 Feb 2026 05:00:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH V2 net] net: hns3: fix double free issue for tx spare
 buffer
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177044040658.1192787.9336634399183206608.git-patchwork-notify@kernel.org>
Date: Sat, 07 Feb 2026 05:00:06 +0000
References: <20260205121719.3285730-1-shaojijie@huawei.com>
In-Reply-To: <20260205121719.3285730-1-shaojijie@huawei.com>
To: Jijie Shao <shaojijie@huawei.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 shenjian15@huawei.com, liuyonglong@huawei.com, chenhao418@huawei.com,
 lantao5@huawei.com, huangdonghua3@h-partners.com,
 yangshuaisong@h-partners.com, jonathan.cameron@huawei.com,
 salil.mehta@huawei.com, jacob.e.keller@intel.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
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
	TAGGED_FROM(0.00)[bounces-257737-lists,netdev=lfdr.de,netdevbpf];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_TWELVE(0.00)[18];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NO_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.987];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[huawei.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2EB7F104F8B
X-Rspamd-Action: no action

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 5 Feb 2026 20:17:19 +0800 you wrote:
> From: Jian Shen <shenjian15@huawei.com>
> 
> In hns3_set_ringparam(), a temporary copy (tmp_rings) of the ring structure
> is created for rollback. However, the tx_spare pointer in the original
> ring handle is incorrectly left pointing to the old backup memory.
> 
> Later, if memory allocation fails in hns3_init_all_ring() during the setup,
> the error path attempts to free all newly allocated rings. Since tx_spare
> contains a stale (non-NULL) pointer from the backup, it is mistaken for
> a newly allocated buffer and is erroneously freed, leading to a double-free
> of the backup memory.
> 
> [...]

Here is the summary with links:
  - [V2,net] net: hns3: fix double free issue for tx spare buffer
    https://git.kernel.org/netdev/net/c/6d2f142b1e4b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



