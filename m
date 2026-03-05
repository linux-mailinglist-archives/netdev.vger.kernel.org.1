Return-Path: <netdev+bounces-264132-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gBJfIgXkqGnzyAAAu9opvQ
	(envelope-from <netdev+bounces-264132-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 03:01:41 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EE60220A13E
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 03:01:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1F0BE30B3D7C
	for <lists+netdev@lfdr.de>; Thu,  5 Mar 2026 02:00:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35A6225C818;
	Thu,  5 Mar 2026 02:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bq7iSfE5"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1345D256C9E;
	Thu,  5 Mar 2026 02:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772676011; cv=none; b=jEPzcnwvvFJxSIuCY7iDojn2PVl2IkMWY3N0H5RZPD9ZZBjY3qmG0fBv3JcUgxBKuLhLAmaWMhL88Cl3Ky1RlKhoLwFe70DiV6fji2xolAplz85tZo+PXlWIkMUEBx6uKOsZEv3g1oe29cLZUM0W0vHlXD/Mo/1RcW4RXWZxyBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772676011; c=relaxed/simple;
	bh=oHwBeEG7hi2UYyT5X2j2MKbyCbmqh2978pXvqg/fwqs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=LcPJSGnda1KnktbeofZJGSD7D5i/sWoki1sdAR6Yz3yoW0Xep8cjsJhfM2iD7Hme9rgNKG0Tr8iirYcasZn+WBdfA+Q7rg1DTmfUexxsYY08N1Y+IjQO/3TN/YnRqo8bVwyB6nw8utiLEyJMXJbLokQCIvX00Hzrg5fjMBW0kso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bq7iSfE5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2727C4CEF7;
	Thu,  5 Mar 2026 02:00:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772676010;
	bh=oHwBeEG7hi2UYyT5X2j2MKbyCbmqh2978pXvqg/fwqs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Bq7iSfE50k3cIEjFFUst1lcCB003tyV8nrPwBaP+2VVDZJRfmfJXvbYIbAUVN9h+L
	 u4weH+mGtSu7sW68CikJpqgJGLSGGY+N6DJsp6DDDpdI3afZLtC/SW2T4iLuB/gCdo
	 WBDRdDOH86Oe03WeLGtDAyXeGG6bMevaWo9qp1fFpqMUQq5VEs6yDjgrfBhNUP4DeO
	 GakwN0hcTZBboukJZ1fK5SC373V0S//+PoJW2JLTLtvOrwi89ihDcVwvwCxe4cnKA+
	 99ycImx0kbd6gloh9wyE08oN4ptPDA6L2QfvQsk+Z74zycT2TYDVeljOJGKqGSEqxm
	 7fYrCN0BWWPIA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3FDC53808200;
	Thu,  5 Mar 2026 02:00:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] net: sched: avoid qdisc_reset_all_tx_gt() vs dequeue race
 for
 lockless qdiscs
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177267601079.2478763.11827132188689746208.git-patchwork-notify@kernel.org>
Date: Thu, 05 Mar 2026 02:00:10 +0000
References: <20260228145307.3955532-1-den@valinux.co.jp>
In-Reply-To: <20260228145307.3955532-1-den@valinux.co.jp>
To: Koichiro Den <den@valinux.co.jp>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, john.fastabend@gmail.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
X-Rspamd-Queue-Id: EE60220A13E
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
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,gmail.com,vger.kernel.org];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-264132-lists,netdev=lfdr.de,netdevbpf];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_NO_DN(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat, 28 Feb 2026 23:53:07 +0900 you wrote:
> When shrinking the number of real tx queues,
> netif_set_real_num_tx_queues() calls qdisc_reset_all_tx_gt() to flush
> qdiscs for queues which will no longer be used.
> 
> qdisc_reset_all_tx_gt() currently serializes qdisc_reset() with
> qdisc_lock(). However, for lockless qdiscs, the dequeue path is
> serialized by qdisc_run_begin/end() using qdisc->seqlock instead, so
> qdisc_reset() can run concurrently with __qdisc_run() and free skbs
> while they are still being dequeued, leading to UAF.
> 
> [...]

Here is the summary with links:
  - net: sched: avoid qdisc_reset_all_tx_gt() vs dequeue race for lockless qdiscs
    https://git.kernel.org/netdev/net/c/7f083faf59d1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



