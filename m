Return-Path: <netdev+bounces-251745-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qIl8BkhIcGnXXAAAu9opvQ
	(envelope-from <netdev+bounces-251745-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 04:30:16 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id A89A350675
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 04:30:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 3260A3A48AD
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 03:30:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F6B43644AD;
	Wed, 21 Jan 2026 03:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KvMeGBHj"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32DCA364025;
	Wed, 21 Jan 2026 03:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768966208; cv=none; b=sH3+nimUixWqp0dlRv6KsR/36h5tAw+i2IJTF5pkL/tGntv1ptwjp12uxHOJvtBj/B54QeK2IgQEpS7+6rTX7Qx3o7dn4xJcu4DwtBKwugWlHDRRt1z3roWIvKB26cf68qcp+Gp2joHak5fo14yw1qVqa6Q9PAtFs4lmp8/3lm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768966208; c=relaxed/simple;
	bh=pmG8JFCS1u+FnByV/e/6pKfcMObTvK9VWIEVv5BJTWE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=F3jk2Ipet1tt5ytJiPrhZZpjJ4YQzffk23p7C2bk1azyBA2Llx4mVG0CAdbvPsRLWAJ+/qewYxmwf/StDah5i2ChirLskvE0mFWAWMLDm2oS3MSyZgcwCIBt//XXlhRBM+7JRaZ1p+2JFyDs09VWSsTKGIztqanT0N11Ab0t5oc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KvMeGBHj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAB08C16AAE;
	Wed, 21 Jan 2026 03:30:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768966207;
	bh=pmG8JFCS1u+FnByV/e/6pKfcMObTvK9VWIEVv5BJTWE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=KvMeGBHjfYvHEWpPOLZ+aTizoQnixGSzDMtfs8SCDdtg8Vx1tdjA+p58O6pd3oS/V
	 ntrOjN5d7c1MSKY7KcaHIfiYtlm6NBuK0WrKJ1+feQoKsAKDcbrF+Prbu3RZFUCB7a
	 NR8XobsKDWS4vb/sTdfE33wgqm6z53Uz+3rPFcMvkbC52rXQkaFmELfu8hpN+ajtr3
	 PffOjXJI5asexFfjCdNoDlo5n5J4ox7ApJOv+5N9TlH2ATP0+vnFem6fImK0ZS7Rtt
	 s6L93+slCaeKur9yhL4LC0+m1YNsyGJnIiPCLQFLe873bnOGR52Uo4gsD2ZgWErqKP
	 nCs6QtlyaDMrQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 4EBC8380820D;
	Wed, 21 Jan 2026 03:30:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] netrom: fix double-free in nr_route_frame()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176896620510.713092.169111915367029765.git-patchwork-notify@kernel.org>
Date: Wed, 21 Jan 2026 03:30:05 +0000
References: <20260119063359.10604-1-aha310510@gmail.com>
In-Reply-To: <20260119063359.10604-1-aha310510@gmail.com>
To: Jeongjun Park <aha310510@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, linux-hams@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 syzbot+999115c3bf275797dc27@syzkaller.appspotmail.com
X-Spamd-Result: default: False [-0.46 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_POLICY_ALLOW(0.00)[kernel.org,quarantine];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-251745-lists,netdev=lfdr.de,netdevbpf];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FROM_NO_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev,999115c3bf275797dc27];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:7979, ipnet:213.196.21.0/24, country:US];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo]
X-Rspamd-Queue-Id: A89A350675
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 19 Jan 2026 15:33:59 +0900 you wrote:
> In nr_route_frame(), old_skb is immediately freed without checking if
> nr_neigh->ax25 pointer is NULL. Therefore, if nr_neigh->ax25 is NULL,
> the caller function will free old_skb again, causing a double-free bug.
> 
> Therefore, to prevent this, we need to modify it to check whether
> nr_neigh->ax25 is NULL before freeing old_skb.
> 
> [...]

Here is the summary with links:
  - netrom: fix double-free in nr_route_frame()
    https://git.kernel.org/netdev/net/c/ba1096c31528

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



