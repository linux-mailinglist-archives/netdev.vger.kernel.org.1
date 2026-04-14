Return-Path: <netdev+bounces-278351-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0HWNHbYC3mkRmAkAu9opvQ
	(envelope-from <netdev+bounces-278351-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 11:02:46 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B55B43F79FD
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 11:02:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E0C2B304D702
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 09:00:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C04441DD525;
	Tue, 14 Apr 2026 09:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZWZf9eq5"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 943BB363C7A;
	Tue, 14 Apr 2026 09:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776157237; cv=none; b=I1HgjW8fU++H8D4xXnfuyrEKDl28I49ncvfaT/JIMYQHtDBCdK91IjWWJpRK0xIk85fRwqyuYcCp9r6T2938lDalYhNBPFjjGqi++fWhp2X0aD617aTDO5RV34Ulr8pmuW/7nT0pDzZNzwEn0e/mnd6aPhj6Ln3jokdcl6WWKdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776157237; c=relaxed/simple;
	bh=zdlo3W96ELYI1Fn/YDiVM4lAg7Ak4ObAMwHGqi668ag=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=B/Hh2/D83HZO1mY4iu+vNaf8j6MbsAkMLlfAcozYpELtoZLDtjYtqe9hgn2uPwd0IMgI99TLT5AhrJesGC0v9dIB7rfmAcFBtiu3Yrve808c4xx7haZVNYQOqwMqqIaj55dmgwCcOub6+PzrCUmKPyRiG7J23ZBqhuFerXi5LvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZWZf9eq5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32749C2BCB8;
	Tue, 14 Apr 2026 09:00:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776157237;
	bh=zdlo3W96ELYI1Fn/YDiVM4lAg7Ak4ObAMwHGqi668ag=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ZWZf9eq5oxhWlXD4nF9KwNW8yueehxVajGxgb4AFdgySiJdNBfnFle4VuOpMfnPYH
	 Vk7r858G5iRg7BEFRHmzIIzGgC+vOf5muZojJ1NOA1HMzHKoeJ3lq2krEQtvzbvV3y
	 TlesjKkg03i5dR6MTrsf3RwnLEB3h5gUfbGZ4V1RLGfXqFJSzwHbtSmspvUdC4Dzqo
	 2ZDiqD2fCiqRrF0SN0tDao2hIoCY5bdL3czlA1tKMCrF8aQP5GsW03baHXSEr2rd5P
	 WMo6pV6QDsN/SjiFn0FtYNj+hRMuSwUUx0jZyJJEKkZfzq0ypxWFULHN/zw7q8Hc1w
	 a2xS6El1ogjIg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3FE553809A0B;
	Tue, 14 Apr 2026 09:00:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v7 0/2] net,bpf: fix null-ptr-deref in
 xdp_master_redirect() for bonding and add selftest
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177615720804.778664.16896373121000918147.git-patchwork-notify@kernel.org>
Date: Tue, 14 Apr 2026 09:00:08 +0000
References: <20260411005524.201200-1-jiayuan.chen@linux.dev>
In-Reply-To: <20260411005524.201200-1-jiayuan.chen@linux.dev>
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: netdev@vger.kernel.org, jiayuan.chen@shopee.com, ast@kernel.org,
 daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev,
 eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev,
 john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me,
 haoluo@google.com, jolsa@kernel.org, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 hawk@kernel.org, shuah@kernel.org, joamaki@gmail.com, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-278351-lists,netdev=lfdr.de,netdevbpf];
	FREEMAIL_CC(0.00)[vger.kernel.org,shopee.com,kernel.org,iogearbox.net,linux.dev,gmail.com,fomichev.me,google.com,davemloft.net,redhat.com];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[26];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,shopee.com:email]
X-Rspamd-Queue-Id: B55B43F79FD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This series was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Sat, 11 Apr 2026 08:55:18 +0800 you wrote:
> From: Jiayuan Chen <jiayuan.chen@shopee.com>
> 
> This series has gone through several rounds of discussion and the
> maintainers hold different views on where the fix should live (in the
> generic xdp_master_redirect() path vs. inside bonding). I respect all
> of the suggestions, but I would like to get the crash fixed first, so
> this version takes the approach of checking whether the master device
> is up in xdp_master_redirect(), as suggested by Daniel Borkmann. If a
> different shape is preferred later it can be done as a follow-up, but
> the null-ptr-deref should not linger.
> 
> [...]

Here is the summary with links:
  - [net,v7,1/2] net, bpf: fix null-ptr-deref in xdp_master_redirect() for down master
    https://git.kernel.org/netdev/net/c/1921f91298d1
  - [net,v7,2/2] selftests/bpf: add test for xdp_master_redirect with bond not up
    https://git.kernel.org/netdev/net/c/8dd1bdde38af

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



