Return-Path: <netdev+bounces-269228-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wHNsHhNHu2kliQIAu9opvQ
	(envelope-from <netdev+bounces-269228-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 01:45:07 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F7922C4282
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 01:45:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1EA113025125
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 00:44:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DE0F259C80;
	Thu, 19 Mar 2026 00:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aUmhpZHR"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ACAB23B62C;
	Thu, 19 Mar 2026 00:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773881069; cv=none; b=jaTVm+nuEup64C8NVUNQMprYTKyb0pnZsFaLp537eI8So/xLfZjC/uB9SNdXxIAwk+HLwwjOuYXe56+4CcRhPa/Vt/74nU7neybBupNVYEBKNdcabxM0HdF0KGB7yY5otsjTXaXN9WTkxO8Oj41nh66V89RQjxPbiykXY3JsOo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773881069; c=relaxed/simple;
	bh=QyvoHK+CRCQGQDwhy9eOgNgbqaj1UunQNZKLcT6IG8M=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=XyKPJPo2rbIIi5JDz2LlIDK0dl6HxvNZEs0s1INX8UGMKhM8vXBvS3dg5+tsPSLyPR1QC4HptcQ5MZQLFnudUYAhEICRmUaDXuYXb4/J5V/RoXsOMZoDGv3I43BzYR9inubGPL2kKYXiZcSBpmZewlcigmLLWOu28aNGimk+fIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aUmhpZHR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DBA0C2BC9E;
	Thu, 19 Mar 2026 00:44:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773881068;
	bh=QyvoHK+CRCQGQDwhy9eOgNgbqaj1UunQNZKLcT6IG8M=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=aUmhpZHRJSvHj8WSnAk/Br2aUTpPfT79YV7JP3DnJ5OPMTG28qpLecyO5UkZGnNM+
	 8K2RSjPZO6b7seTpxJvwE6ymyi1FoD21yOMnCBG7VlZ1MnCPtotMH111XDVtV9Q4Ek
	 W93NTL520RJzYS3QsLlukDknYTyKJl/G3ontBcPNtWY6pyhNPRLmAkloyHrn7v2hkA
	 l0os/ImVPN+Y7kGK9qeDCf4BpFt2+b2JNtvn1+8ReOXYifMv/KY3POwYy5Vf0L8CDH
	 Ny6UR3SU4KTy9ic5tjOQLW/TG+vmK5HMpZ/TIZ25jksrAsNpUZpcnmPdnmq9cWscfM
	 sz1wjciArmiig==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3FE833808200;
	Thu, 19 Mar 2026 00:44:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] netdevsim: drop PSP ext ref on forward failure
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177388105978.935482.17109055611230059426.git-patchwork-notify@kernel.org>
Date: Thu, 19 Mar 2026 00:44:19 +0000
References: <20260317061431.1482716-1-atwellwea@gmail.com>
In-Reply-To: <20260317061431.1482716-1-atwellwea@gmail.com>
To: Wesley Atwell <atwellwea@gmail.com>
Cc: kuba@kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, willemb@google.com,
 daniel.zahka@gmail.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,lunn.ch,davemloft.net,google.com,redhat.com,gmail.com,vger.kernel.org];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-269228-lists,netdev=lfdr.de,netdevbpf];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NO_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.965];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7F7922C4282
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 17 Mar 2026 00:14:31 -0600 you wrote:
> nsim_do_psp() takes an extra reference to the PSP skb extension so the
> extension survives __dev_forward_skb(). That forward path scrubs the skb
> and drops attached skb extensions before nsim_psp_handle_ext() can
> reattach the PSP metadata.
> 
> If __dev_forward_skb() fails in nsim_forward_skb(), the function returns
> before nsim_psp_handle_ext() can attach that extension to the skb, leaving
> the extra reference leaked.
> 
> [...]

Here is the summary with links:
  - [net] netdevsim: drop PSP ext ref on forward failure
    https://git.kernel.org/netdev/net/c/7d9351435ebb

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



