Return-Path: <netdev+bounces-292036-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cPjtMCdJFmqUkQcAu9opvQ
	(envelope-from <netdev+bounces-292036-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 03:30:15 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 333075DE3BE
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 03:30:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2E175300E159
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 01:30:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D8C030C631;
	Wed, 27 May 2026 01:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JR/ZKIqS"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42A35282F05
	for <netdev@vger.kernel.org>; Wed, 27 May 2026 01:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779845412; cv=none; b=Yd/2atGs+blmAxnYEXcSdbTTwhS2Y0LK1e6Kzx8WbxKKBBC6njjmSTSTroepp4EAmXYkR51XX4CWibcU/D+5mIWrXH+uN+o+bxvjLzF5RSXskqZ4B7QkU7r3jFTDKT5jlD84nsmxubbihOfgpEb7nfd8ZCvBmqb4rR2TmW4HbNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779845412; c=relaxed/simple;
	bh=vP7C3iIO5/7V7KmA0+/jvloki/rfYjQ5on120Ahskcw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=QqhL5pCTyLWnyr4d0dHEN3ytJVCkz9lyJQTwBledU8DxEZ0l4THW9cuNXLKldcWjDP6X9SAUPc0LRhVnOIsWijm9du9QKy6rQXNhV0bzt9QoNuTcjRlwzAntSkUqAd03/GagjCEkTgXOclmuJFxWb+uqVv7IQeIG+L3xBgXWnys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JR/ZKIqS; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E02831F000E9;
	Wed, 27 May 2026 01:30:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779845410;
	bh=RQlcrnqB+/73jKpFT+qgG9dofR+WPlo6NDazTcBpX/8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=JR/ZKIqSR1U2Dp3LVtqlVU++TxFdUR9zVAyxXzF4QW2V1rHjQeDIcAVefSHBibtH/
	 OmCn1xIx4yy9CHbjh+YC3isdcZwnh+KafHHdJAELaoBuJm0sAO4zcSL8Oa7aPnqH2P
	 q1Uhl2MyTOxnDa8m3wCWQmz3HbhsiFqndAGc+oRYedM4dtKmxcsPHmoKQRrnyQDA3V
	 YssoBY/GjQ1AHDAySsQa3aUWZ+BumCZ9jhtDZV5jhd85O3y4RB0Epfm3E7HByMCJle
	 fp08fRpc5dUp1hJxOhcwUZtOIw0tnP+SVlImB9HX3vg+UiA7g0+/cbjYzZwOuRcqtV
	 1EP98m1rcoV0Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0F87380CEED;
	Wed, 27 May 2026 01:30:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] tunnels: do not assume transport header in
 iptunnel_pmtud_check_icmp()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177984541639.4041297.15456776118551433178.git-patchwork-notify@kernel.org>
Date: Wed, 27 May 2026 01:30:16 +0000
References: <20260522115512.1519110-1-edumazet@google.com>
In-Reply-To: <20260522115512.1519110-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 willemb@google.com, kuniyu@google.com, netdev@vger.kernel.org,
 eric.dumazet@gmail.com, melotti@google.com
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,google.com,vger.kernel.org,gmail.com];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-292036-lists,netdev=lfdr.de,netdevbpf];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FROM_NO_DN(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 333075DE3BE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 22 May 2026 11:55:12 +0000 you wrote:
> In some cases, iptunnel_pmtud_check_icmp() can be called while
> skb transport header is not set.
> 
> This triggers an out-of-bound access, because
> (typeof(skb->transport_header))~0U is 65535.
> 
> Access the icmp header based on IPv4 network header,
> after making sure icmp->type is present in skb linear part.
> 
> [...]

Here is the summary with links:
  - [net] tunnels: do not assume transport header in iptunnel_pmtud_check_icmp()
    https://git.kernel.org/netdev/net/c/509323077ef7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



