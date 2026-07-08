Return-Path: <netdev+bounces-305678-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 3kmKEkUHTmqlBwIAu9opvQ
	(envelope-from <netdev+bounces-305678-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Jul 2026 10:16:05 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3023E7230AE
	for <lists+netdev@lfdr.de>; Wed, 08 Jul 2026 10:16:04 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=RwVZm9cC;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305678-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-305678-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 406273031567
	for <lists+netdev@lfdr.de>; Wed,  8 Jul 2026 08:10:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 789473FFAA6;
	Wed,  8 Jul 2026 08:10:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D33D73E1718;
	Wed,  8 Jul 2026 08:10:29 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783498231; cv=none; b=WTb3FbA9NU8jRVLY4KUB9DPTM6hnlwGJynQnhx4teWiiUZJtvejVu98dLA1DonHa5UMOwYHWkKN8TY/+8gEzrzzqxqyRfijc87qC7mySrrAWjIVqCj+DZQ0Jmx0wgpXcerEt1VgK1JZXKbcWvfxgqFDOSsDzALyeWaUZq8SzfIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783498231; c=relaxed/simple;
	bh=iLIjsb8tRTcX/YPNIypN3llBDzQOK/o6qMYkp7pjJdQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=SM0+MecKf6l/KTdlQotPyqB3dDa9ADqbT4FSNDdhg6Tj/dpb97pT/YX9hLHMo2h/CFcai6gwYAD7+VFbvsDPXy/G0ZZcz3D0rfLIqBrCkpRHp7abSnVFRxORbH6/LwSJ6tPPnee+7PWx1HmK8VX78B2y3EdJVgoQFA7DQXinj9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RwVZm9cC; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6E051F000E9;
	Wed,  8 Jul 2026 08:10:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783498229;
	bh=BWUQKtaGcIWy+3Ddut53BrtJ3jcIrpB39/3J4wJRA9c=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=RwVZm9cC6SmHA3bTPiMNYwTL4P1dFncP1udZRWx0HYzAFZ+AllKR54NbZBLEVnK0y
	 w0QqDCQ4CKC1U/cXz8bBx99FYAbjh8iaXKZjJVbdFDFG0Vh+lr174hUxWCrQbk1/DR
	 tlhtNq04usSmvgYMzehIAwl3d1FjcnkhgqaZkvtcP79kDYNaPsq3UyII0x1/GD5dhh
	 QgMlMr05fCoG49ON/SpOqqw6WfDOM+6aPVVSk6YgDUX05fJkcQ/jcuy03H6zid37xn
	 zgVBgX7jyizVeGVAWXZcGG5Sds4eYPK51xaHFio8NSXFjBSxodV6m3g3if5HtC68e6
	 DTV/ENpFtBZLg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 56A9A3926383;
	Wed,  8 Jul 2026 08:10:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v3] selftests/net/openvswitch: add output
 truncation
 test
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178349820913.2361978.12788467344075013470.git-patchwork-notify@kernel.org>
Date: Wed, 08 Jul 2026 08:10:09 +0000
References: <20260702074926.1174810-1-houminxi@gmail.com>
In-Reply-To: <20260702074926.1174810-1-houminxi@gmail.com>
To: Minxi Hou <houminxi@gmail.com>
Cc: netdev@vger.kernel.org, aconole@redhat.com, echaudro@redhat.com,
 i.maximets@ovn.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, shuah@kernel.org,
 dev@openvswitch.org, linux-kselftest@vger.kernel.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-305678-lists,netdev=lfdr.de,netdevbpf];
	FORGED_RECIPIENTS(0.00)[m:houminxi@gmail.com,m:netdev@vger.kernel.org,m:aconole@redhat.com,m:echaudro@redhat.com,m:i.maximets@ovn.org,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:shuah@kernel.org,m:dev@openvswitch.org,m:linux-kselftest@vger.kernel.org,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[13];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FROM_NO_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3023E7230AE

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Thu,  2 Jul 2026 03:49:26 -0400 you wrote:
> Add test_trunc exercising the OVS_ACTION_ATTR_TRUNC action. The test
> verifies truncation limits in four steps: reject trunc(1) and
> trunc(13) which are below ETH_HLEN, confirm normal forwarding works,
> apply trunc(14) which truncates packets to the Ethernet header and
> verify ping fails, then restore normal forwarding and verify recovery.
> 
> The kernel requires max_len >= ETH_HLEN (14 bytes). trunc(14) sets
> OVS_CB(skb)->cutlen so pskb_trim strips the IP payload at output
> time; the receiver drops the runt frame and no echo reply is
> generated.
> 
> [...]

Here is the summary with links:
  - [net-next,v3] selftests/net/openvswitch: add output truncation test
    https://git.kernel.org/netdev/net-next/c/a211b03fee2c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



