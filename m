Return-Path: <netdev+bounces-299599-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id SyCUB95ZMGoFSAUAu9opvQ
	(envelope-from <netdev+bounces-299599-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 22:00:30 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 638CD689A32
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 22:00:29 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b="WrOnm/6K";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299599-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-299599-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BDF9A30C57A2
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 20:00:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 926E138B12E;
	Mon, 15 Jun 2026 20:00:14 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B4653B42F4
	for <netdev@vger.kernel.org>; Mon, 15 Jun 2026 20:00:13 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781553614; cv=none; b=TMEmq2twGPHEcHv5LI6Mdqr9JiNCyr7t//MrBwdsBfb25zKrOIqufuErgk+qcPImNEuS2xcITCa8yYXBRLUIZo/Q5X5VWbzGjHz0ifDdSxK9ET546P5DJul1AfbRsBGsebOQC2UOVL/5e9Dc4MAVXhNPcsLWDH5VLSbIGzWv810=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781553614; c=relaxed/simple;
	bh=qKfooVQO5FAQ2uKaXdb45oaw4bztcgFjZ/m6GeHu9lY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=H/7NoHQgM2RSeMSQfBHueIAidQY2SuT+2f6gwA+abGJTOpDjZ6HbEdYHNMcDoo2Mj0qn0K0MrFelk/PkpN1Lw08/c/lp4L71PSsTpmMP0Io08y/gEVkoHICdNhRPlP7G7tZBzb/UrxjxUyozPckNy901tRGGPy1gwCgUvmOa3Xc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WrOnm/6K; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11BFF1F000E9;
	Mon, 15 Jun 2026 20:00:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781553613;
	bh=cQwH9sD+aVZcat2wfR27rUr5vgLOt64pW/pgqA4vdEQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=WrOnm/6Kj7o9EWDnV9i4JJi8M/1HFlwWy+L/I0LKr9j4NsujvTkKjixDxjiRXDYep
	 IPfGZAJAuvnWWUwtk3zKyUsOKkJ88/8TnP5GNPZ0R9IoHdR2lraYf7miyXsfwolZrn
	 HeN3HHhz7deMYqvO6H29ZGoyXNF6U5xSrlY7q1QWk747hoXw21i8rhJaLzt1tUYl5k
	 VZexGLlfD97qAoNmmmXxxzjQn6vihtSPGTXuiQ4ecLOc8x0Z5ZVPpIplohuMVrmhba
	 vFWv5aeLswMccqYJ+IKN1FNahJSmxxXanQumU/8cJJADcwr2bDh+7gN/yP3niFvFIt
	 LpAw5KTL+QLfg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 5688C3839A06;
	Mon, 15 Jun 2026 20:00:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] tipc: fix UAF in tipc_l2_send_msg()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178155360788.272818.6185540664390740665.git-patchwork-notify@kernel.org>
Date: Mon, 15 Jun 2026 20:00:07 +0000
References: <20260612135949.4010482-1-edumazet@google.com>
In-Reply-To: <20260612135949.4010482-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 netdev@vger.kernel.org, eric.dumazet@gmail.com,
 syzbot+64ec81389cbad56a8c35@syzkaller.appspotmail.com, jmaloy@redhat.com
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,vger.kernel.org,gmail.com,syzkaller.appspotmail.com];
	TAGGED_FROM(0.00)[bounces-299599-lists,netdev=lfdr.de,netdevbpf];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:edumazet@google.com,m:davem@davemloft.net,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:netdev@vger.kernel.org,m:eric.dumazet@gmail.com,m:syzbot+64ec81389cbad56a8c35@syzkaller.appspotmail.com,m:jmaloy@redhat.com,m:ericdumazet@gmail.com,m:syzbot@syzkaller.appspotmail.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[netdev,64ec81389cbad56a8c35];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 638CD689A32

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 12 Jun 2026 13:59:49 +0000 you wrote:
> Syzbot reported a slab-use-after-free in ipvlan_hard_header() when
> called from tipc_l2_send_msg().
> 
> The root cause is that tipc_disable_l2_media() calls synchronize_net()
> while b->media_ptr is still valid. This allows concurrent RCU readers
> to obtain the device pointer after synchronize_net() has finished.
> The pointer is cleared later in bearer_disable(), but without any
> subsequent synchronization, allowing the device to be freed while
> still in use by readers.
> 
> [...]

Here is the summary with links:
  - [net] tipc: fix UAF in tipc_l2_send_msg()
    https://git.kernel.org/netdev/net/c/f4c3d89fc986

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



