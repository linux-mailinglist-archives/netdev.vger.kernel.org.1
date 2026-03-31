Return-Path: <netdev+bounces-273407-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UBVqCKAVy2k1DwYAu9opvQ
	(envelope-from <netdev+bounces-273407-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 02:30:24 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D991362A9F
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 02:30:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 448483033274
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 00:30:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6CE8261B9B;
	Tue, 31 Mar 2026 00:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p2y7B7YP"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84716248886
	for <netdev@vger.kernel.org>; Tue, 31 Mar 2026 00:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774917021; cv=none; b=X5++xKxsnrX2VkYTy4e371h56Nrv4my/mOQKlMQSb0s1ytNIwopG3OZAR9J1kqsBpaUK9NMrjeM3tqDWriUBzRY6CwBPaKPo5JlS/fDVYiIEF+L5ZmsgrQl6uS7tGm5MaofPU0/W5MCVBsbO0K/bn7if7GR1q1axEuDc+8f0NZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774917021; c=relaxed/simple;
	bh=4mOXCi5CJ098FDGLM4laXUVed+0jDx5CXx8NXVjww8A=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Xki0xjYAGx2ULZ6yK0WcYe3nSUAXaParuP6Cv1MjoQITNvroRmvN9mzr9TVbpvRZxFFqh3WC0pa3gIY4dmPC3j65UdzJIRpcB0wmRx7mNo74hCqQlkg99WcVD7/5ZSyl4Xz/7R08rKu55lREqHijMGnZj5lBBbbOCQviSZHguJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p2y7B7YP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59B1DC4CEF7;
	Tue, 31 Mar 2026 00:30:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774917021;
	bh=4mOXCi5CJ098FDGLM4laXUVed+0jDx5CXx8NXVjww8A=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=p2y7B7YPz4Cx89vZJD7eZo04s7c0O7AcPbPC+Sc6ZTrfKXKy6e79sEw0RNjk5CExm
	 K/MeItm2Ysi5Ddx3hRJ5xlG7pVTFdpD+l0h66zeK6UXaBVhmbu+Vt5sbH6rOan5EJu
	 HEPH6QKE0/sLxOTXWoBoMEQqzznOD8/1NS5G30OhX39K6nGqsD2tmE0z7fBDIgc5Hy
	 JsxrwYJ6K90SQSqo/Falr8qmsURQP4nuIVF3YVGjg5WKIlaw5MvItZV9KbHV0+2fX2
	 IlkHhaYd41zdD0Gdr7sq1BMUt3a/Uofm609wbR66N/WFLVtd9kLmFWt+39E3vlbVyh
	 a+Rv+/oHcGVlA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7CDBD392FF85;
	Tue, 31 Mar 2026 00:30:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] ipv6: prevent possible UaF in
 addrconf_permanent_addr()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177491700529.2029365.10071989895590601223.git-patchwork-notify@kernel.org>
Date: Tue, 31 Mar 2026 00:30:05 +0000
References: 
 <ef973c3a8cb4f8f1787ed469f3e5391b9fe95aa0.1774601542.git.pabeni@redhat.com>
In-Reply-To: 
 <ef973c3a8cb4f8f1787ed469f3e5391b9fe95aa0.1774601542.git.pabeni@redhat.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, dsahern@kernel.org,
 edumazet@google.com, kuba@kernel.org, horms@kernel.org
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	URIBL_MULTI_FAIL(0.00)[tor.lore.kernel.org:server fail];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-273407-lists,netdev=lfdr.de,netdevbpf];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NO_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8D991362A9F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 27 Mar 2026 10:52:57 +0100 you wrote:
> The mentioned helper try to warn the user about an exceptional
> condition, but the message is delivered too late, accessing the ipv6
> after its possible deletion.
> 
> Reorder the statement to avoid the possible UaF; while at it, place the
> warning outside the idev->lock as it needs no protection.
> 
> [...]

Here is the summary with links:
  - [net] ipv6: prevent possible UaF in addrconf_permanent_addr()
    https://git.kernel.org/netdev/net/c/fd63f185979b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



