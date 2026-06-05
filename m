Return-Path: <netdev+bounces-295550-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id qj3GAk4pImpRTQEAu9opvQ
	(envelope-from <netdev+bounces-295550-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 03:41:34 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4654964478C
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 03:41:33 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=ldCZFTYL;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295550-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-295550-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D46193125D84
	for <lists+netdev@lfdr.de>; Fri,  5 Jun 2026 01:30:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98B9B3C945B;
	Fri,  5 Jun 2026 01:30:17 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7DE3199E89;
	Fri,  5 Jun 2026 01:30:12 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780623017; cv=none; b=nqaASEUo3OYaRRHexoWW0VNquISY93BAuY//o5EXn+VSEVOtNtmZL99HPt/GUOGSZZ+yg3bUAhM5/9hJzUvrgdS3jR5BwVgSuKdNLjGUwAY/4jc5bEwPb13nTcj3uS0jdIRyO4PbvTWbmtTzvmJSzmYC1W+TzCLdjX5HAfI4dac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780623017; c=relaxed/simple;
	bh=NR1Of+rdyifvrNHU+CMyh8ioNEGJEvFCUj6CFnZmLnY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=m2iaqMWdByVaEqkYOu9qPhpIJ7x+8/jdqJI9QGLwbqFnsu7P23XHji4ksH2lb7IdOg/5VHSinCa5ne5Qu0w8DVm6l7u7esm0I7ddVDPmpkOHoFqJHGFv/oRVpbjcSFuQP4RRN98b4ZXzRHDx3gJiBt2w2F/f9vEwHRo+pZpm6PE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ldCZFTYL; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 725171F00898;
	Fri,  5 Jun 2026 01:30:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780623012;
	bh=m5eDcKmT8v0dWgq+2KNXWmUfrlzqanG98WeRl2xFrWw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=ldCZFTYLckZDLWR3G8rUwz25SiOgJnAPz569s7TFkntkMRwQ9ufKIVEUmUoTlbm57
	 e6bWr477hB8eW3fg7jiQsoy1HVfnKGZBl6YB+GPVKrqfHRqZ3ocjBAaCSi0wADSJLX
	 +g5nNRG8vPhyyMC0XqAy7LLGUV5KXaK39pFaV2R9Du0N2Z6sNfnUm8wnFUo27mnQPu
	 q0NwcGAjWONTJqNBIZ4TqIuK1JDsCqJwHnhCfwRXXA6fzVFJ+ybWO+aXL3VgD3fEDU
	 fxpEuZNGikjpBlaoaaf4sgucu+BZek9F5cwmt1dPhLAzALxpcAxPF6lFS5Z7gUOwM5
	 Cygv/LkOdXuRA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 568343930A8A;
	Fri,  5 Jun 2026 01:30:14 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] inet: frags: remove redundant assignment in
 inet_frag_reasm_prepare()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178062301289.3093327.10586972224896342716.git-patchwork-notify@kernel.org>
Date: Fri, 05 Jun 2026 01:30:12 +0000
References: <20260603065323.2736839-1-yuan.gao@ucloud.cn>
In-Reply-To: <20260603065323.2736839-1-yuan.gao@ucloud.cn>
To: yuan.gao <yuan.gao@ucloud.cn>
Cc: dsahern@kernel.org, idosch@nvidia.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-295550-lists,netdev=lfdr.de,netdevbpf];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:yuan.gao@ucloud.cn,m:dsahern@kernel.org,m:idosch@nvidia.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_NO_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,ucloud.cn:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4654964478C

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed,  3 Jun 2026 14:53:23 +0800 you wrote:
> The assignment is redundant because skb_clone() already copies skb->cb.
> 
> Remove the unnecessary code.
> 
> Signed-off-by: yuan.gao <yuan.gao@ucloud.cn>
> ---
>  net/ipv4/inet_fragment.c | 2 --
>  1 file changed, 2 deletions(-)

Here is the summary with links:
  - [net] inet: frags: remove redundant assignment in inet_frag_reasm_prepare()
    https://git.kernel.org/netdev/net-next/c/831d557a3e40

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



