Return-Path: <netdev+bounces-287784-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gCa8C5UxBWonTQIAu9opvQ
	(envelope-from <netdev+bounces-287784-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 04:21:09 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 86ED853CFAA
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 04:21:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1EA4A3022967
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 02:21:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 679E0282F35;
	Thu, 14 May 2026 02:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XxnSKloO"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44CBD3F4124;
	Thu, 14 May 2026 02:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778725266; cv=none; b=di6igkJAMcxEQE+gHibSrEdqA/VI/sqEmoiS4cnl+p4YL7vsj2Td58MOQoheGhLdGOLKaV+/l4yWbhzT275ydBzYpW9oUSm5bj2Jx23k+D5Z5P3eds1LCkVqBWfV7BlqaLO6AmQky0QI6df14TUR5USvXeysr0g1u6iypfF0W6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778725266; c=relaxed/simple;
	bh=udpvWuRUrmt4xq73g3wuRW0TvKOE6Z/NjukPjXdKnUQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=bpdN54KSjES54OPsbR7TbogYBZq7JGNl+jc8DBtCo7Rr1WZSEaNWzpOa6ARTLsaWtzes0UcDTCgtwuVfYVw/PNtWgZLXct3xdR8flMp/bhBw7LS1Fvr9b2n0faWfdFX5Tr7jtl5jThTI7A/rWJF7B3aC7U7aA8/TGTfe/trrQLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XxnSKloO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E53DCC19425;
	Thu, 14 May 2026 02:21:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778725266;
	bh=udpvWuRUrmt4xq73g3wuRW0TvKOE6Z/NjukPjXdKnUQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=XxnSKloOvwVXsLPYvZX19jcqTD73atpzOj6OxEEg15Lv3i1iugyt01qVpApZSj6n4
	 IddGfkM91+b/vO0+WIIYOfOid6LRG2NEDpCqA6T1wEosLecr7b3Snh7OnOZO1Rtrgq
	 7UFpm1hS85ixJxlGl+xEoQ2ehlDKOor2kwkycF+2v3swE+MMyOXEp7R9ckUv+tnPIn
	 wJ2F6KdcM1FZhoL4ZTAOoFs5Q9PVCunuNzuNuRN6kRjvZPsd6RV9NNBVb/OaYa6/Ba
	 fUjOenkJ/+yy24R6AkVDVy3ut7wD7fTC+pi3+zSGzmEVBL3o7XoZW9+qznQAGXEfb/
	 mkTNqt98j87Yw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3FC34382330B;
	Thu, 14 May 2026 02:20:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v4 0/3] macsec: use rcu_work to fix crypto cleanup in
 softirq context
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177872520983.3924965.8052758539606429571.git-patchwork-notify@kernel.org>
Date: Thu, 14 May 2026 02:20:09 +0000
References: <20260511153102.2640368-1-alexjlzheng@tencent.com>
In-Reply-To: <20260511153102.2640368-1-alexjlzheng@tencent.com>
To: Jinliang Zheng <alexjlzheng@gmail.com>
Cc: sd@queasysnail.net, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 hannes@stressinduktion.org, albinwyang@tencent.com, shenyangyang4@huawei.com,
 kuniyu@google.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 alexjlzheng@tencent.com
X-Rspamd-Queue-Id: 86ED853CFAA
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
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-287784-lists,netdev=lfdr.de,netdevbpf];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 11 May 2026 23:30:57 +0800 you wrote:
> From: Jinliang Zheng <alexjlzheng@tencent.com>
> 
> crypto_free_aead() can internally call vunmap() (e.g. via dma_free_attrs()
> in hardware crypto drivers like hisi_sec2), which must not be invoked from
> softirq context. Both free_rxsa() and free_txsa() are RCU callbacks that
> run in softirq, causing a kernel crash on affected hardware.
> 
> [...]

Here is the summary with links:
  - [net,v4,v4,1/3] macsec: introduce dedicated workqueue for SA crypto cleanup
    https://git.kernel.org/netdev/net/c/c6690a9030d7
  - [net,v4,v4,2/3] macsec: use rcu_work to defer RX SA crypto cleanup out of softirq
    https://git.kernel.org/netdev/net/c/6624bba469a3
  - [net,v4,v4,3/3] macsec: use rcu_work to defer TX SA crypto cleanup out of softirq
    https://git.kernel.org/netdev/net/c/552cc2306c3d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



