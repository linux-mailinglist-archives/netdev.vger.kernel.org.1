Return-Path: <netdev+bounces-259800-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +MuUEPb+mGmIOwMAu9opvQ
	(envelope-from <netdev+bounces-259800-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 21 Feb 2026 01:40:22 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E33A16B94B
	for <lists+netdev@lfdr.de>; Sat, 21 Feb 2026 01:40:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9EA1B303C600
	for <lists+netdev@lfdr.de>; Sat, 21 Feb 2026 00:40:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0146319850;
	Sat, 21 Feb 2026 00:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SSJBkmip"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D93EC8E6
	for <netdev@vger.kernel.org>; Sat, 21 Feb 2026 00:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771634404; cv=none; b=su33NWwPU/Z4bPIBDphltKLwCrAtVUoPx0YzAunNgHQVqkJzjPiTcBiVwXBi43NcbjigfDftmEURyaDA9E+JWPjL0zY/kA3Wanycnak/Gj27/VS4X4s8xTzpVPcZ1BqzAqkh1T2jFS9kUfa0X4ytpx6fCED7fy8i61EIZy8uLm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771634404; c=relaxed/simple;
	bh=LpRnJbQe0g36aY7uqTQdI8Z7qrthLDAF3lD0ZxdCt8k=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=im8HBuadIpfeM9J5ndixyPSs1/4A3HhWkR3J1Xsm5zcicCLD30WBuKvinZHJU0acc10idsTRddbhPfPDixslj0RttY9aCydYV93bxKmYEPd8gnHeNVWIhkAI3jy/1PUx6XYee+B1v5Lhgzf3namoMugD0s8RX8Es7+vZCn9JrT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SSJBkmip; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24276C116C6;
	Sat, 21 Feb 2026 00:40:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771634404;
	bh=LpRnJbQe0g36aY7uqTQdI8Z7qrthLDAF3lD0ZxdCt8k=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=SSJBkmipICyNXK1Rg+8qTuoBnjdkpCxgEL4MQgPsAQtTK/9pHE716SjzKWnMKX9aJ
	 J98yV30BSylwTyBd6+o8n8bijVgJJq2nQIdEMFpUhuh3ALkEEPkyHmIvAQFy0ESoul
	 x4j3SryY+9N/ad0yy6a8FkoLcUVoEiOVVrHE4U2+MvDH/LCT+UXPGL34+eic1SgeIP
	 d1nyPaW/FN3bo9Sl/+qS6RUR0ntt2R1NU25MU3HMNOeD3DhP2rncapsenvGORB5ikY
	 s8O1l5sz/2sUIVVhtlATx37wkdasLBWAL3LAQmpJPciQreKEX/EZKiRelcezCTxGZS
	 hBrAVqxrsivQQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3FE493808200;
	Sat, 21 Feb 2026 00:40:13 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v1 net] udplite: Fix null-ptr-deref in
 __udp_enqueue_schedule_skb().
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177163441179.959452.8036737167381859700.git-patchwork-notify@kernel.org>
Date: Sat, 21 Feb 2026 00:40:11 +0000
References: <20260219173142.310741-1-kuniyu@google.com>
In-Reply-To: <20260219173142.310741-1-kuniyu@google.com>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: willemb@google.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, kuni1840@gmail.com,
 netdev@vger.kernel.org, syzkaller@googlegroups.com
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	FREEMAIL_CC(0.00)[google.com,davemloft.net,kernel.org,redhat.com,gmail.com,vger.kernel.org,googlegroups.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-259800-lists,netdev=lfdr.de,netdevbpf];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
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
X-Rspamd-Queue-Id: 8E33A16B94B
X-Rspamd-Action: no action

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 19 Feb 2026 17:31:31 +0000 you wrote:
> syzbot reported null-ptr-deref of udp_sk(sk)->udp_prod_queue. [0]
> 
> Since the cited commit, udp_lib_init_sock() can fail, as can
> udp_init_sock() and udpv6_init_sock().
> 
> Let's handle the error in udplite_sk_init() and udplitev6_sk_init().
> 
> [...]

Here is the summary with links:
  - [v1,net] udplite: Fix null-ptr-deref in __udp_enqueue_schedule_skb().
    https://git.kernel.org/netdev/net/c/470c7ca2b4c3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



