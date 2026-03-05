Return-Path: <netdev+bounces-264108-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kCUJI+nVqGnpxgAAu9opvQ
	(envelope-from <netdev+bounces-264108-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 02:01:29 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E9BF9209A8D
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 02:01:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4938C304EA84
	for <lists+netdev@lfdr.de>; Thu,  5 Mar 2026 01:01:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22B7A233721;
	Thu,  5 Mar 2026 01:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C+bipLKS"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0133D1A38F9
	for <netdev@vger.kernel.org>; Thu,  5 Mar 2026 01:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772672461; cv=none; b=LbNr+fKIqBJ6phE+txeJY8R90SRcmOtEBBOoDvj5SqxlHg2RZ6Mdas8e0gI6OZ7FQRYnGU+fyd1da2cbMxDtTqIrJI7QumCTRkISRjoLPCqAJkxvamnHNFF9j/UpRIe9KCMnUmmmzlwkJYSI4rAKjn+RNdnEgQIXejcvf0A3MSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772672461; c=relaxed/simple;
	bh=MTtDnm3jYUI2VaDwgIo+RSUd9ml7UD3KKQtZ19GwWBY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=SgOumq01HtXOdl79AuC8tVMb8QxoCEBIyFepjB8B8dXG7mbbIVeL6pgSBZTw6MlW7ytEcmglGx9h33VcO+1WHUgUJa3/5Y4P0NUnkpFm7Crjbo5xDWlLrDRFImMzScWG4Qth3stzsJhI6jHzXdTb5hjxS58N1eQ6O82iUAoeBE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C+bipLKS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DCF6C4CEF7;
	Thu,  5 Mar 2026 01:01:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772672460;
	bh=MTtDnm3jYUI2VaDwgIo+RSUd9ml7UD3KKQtZ19GwWBY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=C+bipLKSDPiPPSpId3MlY8wtN7TMP/NzQecDAbKJR25AZy3918HGsbZ9YK8TUji5u
	 cVf04QxvCXs+5cnYCTjThDQOlP75AH0Ftyy588mu5ZLIySkS/7j6VBYJuTwF9HGPzG
	 XBnqF+H7kzlZ3SGzLoQ+ONkROkReSwGsHx1LMP9qXv68n5TmWJMhWFVYVAjKSFBBrZ
	 497rZA0dIvrOGS6mGci6P5tJx2IRzH88S0T3BTzFX3BJIL65cLxbv407vWuZ2k3sS0
	 zAGuYDakkYpbCgLX5eBWVZ8iibjtKhrVdjbAoFvdWwMYYrLYMPrEi8CskF96z6wBCm
	 le8ZsGJE4GZTA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3FDCD3808200;
	Thu,  5 Mar 2026 01:01:02 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: fix off-by-one in udp_flow_src_port() /
 psp_write_headers()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177267246075.2463633.14284718831138812661.git-patchwork-notify@kernel.org>
Date: Thu, 05 Mar 2026 01:01:00 +0000
References: <20260302163933.1754393-1-edumazet@google.com>
In-Reply-To: <20260302163933.1754393-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 kuniyu@google.com, netdev@vger.kernel.org, eric.dumazet@gmail.com
X-Rspamd-Queue-Id: E9BF9209A8D
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
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,google.com,vger.kernel.org,gmail.com];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-264108-lists,netdev=lfdr.de,netdevbpf];
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
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon,  2 Mar 2026 16:39:33 +0000 you wrote:
> udp_flow_src_port() and psp_write_headers() use ip_local_port_range.
> 
> ip_local_port_range is inclusive : all ports between min and max
> can be used.
> 
> Before this patch, if ip_local_port_range was set to 40000-40001
> 40001 would not be used as a source port.
> 
> [...]

Here is the summary with links:
  - [net-next] net: fix off-by-one in udp_flow_src_port() / psp_write_headers()
    https://git.kernel.org/netdev/net-next/c/c26b8c4e291c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



