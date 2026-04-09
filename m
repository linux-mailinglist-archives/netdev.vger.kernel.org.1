Return-Path: <netdev+bounces-276890-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8CCBJ8pj12nvNQgAu9opvQ
	(envelope-from <netdev+bounces-276890-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 09 Apr 2026 10:31:06 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0949D3C7C85
	for <lists+netdev@lfdr.de>; Thu, 09 Apr 2026 10:31:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7970E301226E
	for <lists+netdev@lfdr.de>; Thu,  9 Apr 2026 08:30:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6CBE3537C5;
	Thu,  9 Apr 2026 08:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dAY1eh/N"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A29252F549F
	for <netdev@vger.kernel.org>; Thu,  9 Apr 2026 08:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775723429; cv=none; b=Od03nIBmI9ktyE5pJUYQIkoV2f6kDhatTBX/p+jms2zH+aWwIciLEJtRzZpACTFsd8GdC0gXPVUKYdRPXEn+uk0OjRU2Kag4/ae+yrM44jHzxetHFPIxTkJHEuFxGByhAgi3FOiM1yVhHo+BLdH2tn00dBQ8XpTIc2Jn08pYZKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775723429; c=relaxed/simple;
	bh=kxUP5FRsQ8f2/OoTrKUv7qd7V+ZhKrNfkzqa1kUvFjY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=UbyiZ0bwTPbS2SRveIImwditJOC2C34r0zTkL5GNEeO8ZxgeH1ZvWdPK+ISOjeIqaWNAmrB4GKoQHrJTFAl/zoSnipR+0UI65FKFdN/ER0OoRQ3TbaNE2zmQyUPjajRnSgEcEZB1t8EQ+9HrDQbET/UNwOfYIT+VIxHys4ujJcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dAY1eh/N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 484DDC4CEF7;
	Thu,  9 Apr 2026 08:30:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775723429;
	bh=kxUP5FRsQ8f2/OoTrKUv7qd7V+ZhKrNfkzqa1kUvFjY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=dAY1eh/NHSTe58VxKQH6GL2KWfRlJK8pPTmyY6qjfo4V1LXrDi7sr2dmU7cdw1bbK
	 6AjmkurLcOjDp6pa3bgvlIWtpTcLBz5IusJ9V+HiSj93gPStCfdA7x33ispcIuz4aK
	 hJKLrTDo4BvX57D2gmKhETa4ZP6dtfUhq8Fvil3AegPFLjzpdCviT9DtByppgY3hFQ
	 u8AreLo5AJ7zkf8QFX7ruRSnjaee9U0Lw1BtPCRk4OJrxx/JwLo+oyJ/gAYEe4apYD
	 5gr5uGrfw3foHYfeGbi1fxDaQqAdF3rD7tDKGTIX6z6ISsTt9hE8jI9WS3nGD6qi/o
	 P0g9w0Z+RUQeg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7CD1B39307AD;
	Thu,  9 Apr 2026 08:30:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] l2tp: Drop large packets with UDP encap
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177572340530.1067582.789622967223201622.git-patchwork-notify@kernel.org>
Date: Thu, 09 Apr 2026 08:30:05 +0000
References: <20260403174949.843941-1-alice.kernel@fastmail.im>
In-Reply-To: <20260403174949.843941-1-alice.kernel@fastmail.im>
To: Alice Mikityanska <alice.kernel@fastmail.im>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, jchapman@katalix.com,
 netdev@vger.kernel.org, alice@isovalent.com,
 syzbot+ci3edea60a44225dec@syzkaller.appspotmail.com
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-276890-lists,netdev=lfdr.de,netdevbpf];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[fastmail.im];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_NO_DN(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev,ci3edea60a44225dec];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,isovalent.com:email]
X-Rspamd-Queue-Id: 0949D3C7C85
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Fri,  3 Apr 2026 20:49:49 +0300 you wrote:
> From: Alice Mikityanska <alice@isovalent.com>
> 
> syzbot reported a WARN on my patch series [1]. The actual issue is an
> overflow of 16-bit UDP length field, and it exists in the upstream code.
> My series added a debug WARN with an overflow check that exposed the
> issue, that's why syzbot tripped on my patches, rather than on upstream
> code.
> 
> [...]

Here is the summary with links:
  - [net-next] l2tp: Drop large packets with UDP encap
    https://git.kernel.org/netdev/net/c/ebe560ea5f54

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



