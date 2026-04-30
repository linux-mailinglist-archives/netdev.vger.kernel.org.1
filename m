Return-Path: <netdev+bounces-282598-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gCHuKS668mkYtwEAu9opvQ
	(envelope-from <netdev+bounces-282598-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 04:10:54 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 03B5549C379
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 04:10:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5E6683013D7A
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 02:10:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 163BD2765FF;
	Thu, 30 Apr 2026 02:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xn05qJ7v"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E78D125FA29
	for <netdev@vger.kernel.org>; Thu, 30 Apr 2026 02:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777515051; cv=none; b=auWDx7I5BkjJL7POb2YqFexH3XreDS7eKIwIviJ7JR3XlBM06TyVRUEtFhFSz6ZD8tqvO+IGoWBhu1t7gwx/zmvT8jQariaB5NP0Z/VWUAtZjEYHVaL8i+Y6vLP8YU7MjDiKLCCOQVbRzgR4a3OkJYDe+65zHlFw7luRYhWTSY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777515051; c=relaxed/simple;
	bh=a1UzXaYYxk8eew7tH6jlILm+q1oKKsetaZ6dGSzp9sg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=bTyTn4km2NpPMQWsy6woNtV/DiGOygj62LKE3t2fH9wh/p0aH4clYjUZ04nEd54qOn7dE8/XsTU3JlquNiWd/h6JRdyuzU9T/PnzddtUpP9mDlHmUIO1KGHSR1ndN1Z6CJs+qf95iXe9nsg/xXphS9HpWP1XlpUTMWvf1LyBquQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xn05qJ7v; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9962BC19425;
	Thu, 30 Apr 2026 02:10:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777515050;
	bh=a1UzXaYYxk8eew7tH6jlILm+q1oKKsetaZ6dGSzp9sg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Xn05qJ7vAcgYPxLznWRllP4Mhyq1kDF7Bwq76iNCRnIwTxEhhorKD9zeprKj70fAD
	 paCo8UCJ0Oo8pMqwjsDOjLMXqag/ybQLExsJndAhtwpZMUk1oycntHwFgqnhF3wGuR
	 s5qatD6bdK5c6IgOBI+Q/vknFVJD2umKpBA2oXoZ8XIQ/SczibDddB8kc49GyMI7Wv
	 DKvWvkd+IkS1F+spu3rGFeXqXUdJXYj7Tnele9vvNbrFrgVi70vWSSn/zM8SXLLiJO
	 RbT3EYSLmPWG25VtpgvmgFDpE7LGxENmZ+t1uf7LABZ6+NR5lh8tblNDCdJw5qTby1
	 4H4/G7Q0HPjTQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 02E6B3809A33;
	Thu, 30 Apr 2026 02:10:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] bonding: 3ad: implement proper RCU rules for
 port->aggregator
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177751500580.2264184.2818208802204710307.git-patchwork-notify@kernel.org>
Date: Thu, 30 Apr 2026 02:10:05 +0000
References: <20260428123207.3809211-1-edumazet@google.com>
In-Reply-To: <20260428123207.3809211-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 netdev@vger.kernel.org, eric.dumazet@gmail.com,
 syzbot+9bb2ff2a4ab9e17307e1@syzkaller.appspotmail.com, jv@jvosburgh.net,
 andrew+netdev@lunn.ch
X-Rspamd-Queue-Id: 03B5549C379
X-Rspamd-Action: no action
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
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,vger.kernel.org,gmail.com,syzkaller.appspotmail.com,jvosburgh.net,lunn.ch];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-282598-lists,netdev=lfdr.de,netdevbpf];
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
	TAGGED_RCPT(0.00)[netdev,9bb2ff2a4ab9e17307e1];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 28 Apr 2026 12:32:07 +0000 you wrote:
> syzbot found a data-race in bond_3ad_get_active_agg_info /
> bond_3ad_state_machine_handler [1] which hints at lack of proper
> RCU implementation.
> 
> Add __rcu qualifier to port->aggregator, and add proper RCU API.
> 
> [1]
> 
> [...]

Here is the summary with links:
  - [net] bonding: 3ad: implement proper RCU rules for port->aggregator
    https://git.kernel.org/netdev/net/c/c4f050ce06c5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



