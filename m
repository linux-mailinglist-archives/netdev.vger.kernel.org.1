Return-Path: <netdev+bounces-268576-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EN5NN947uWkowQEAu9opvQ
	(envelope-from <netdev+bounces-268576-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 12:32:46 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 676FD2A8D97
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 12:32:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D5536304DCAC
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 11:30:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19FBE3AC0E4;
	Tue, 17 Mar 2026 11:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AcdvFa9y"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAFB033067A;
	Tue, 17 Mar 2026 11:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773747025; cv=none; b=h5z16OgYoKD0bjvZQyv48UST7QP2BbGPbRKqvihSvv+8OKyAhu+jdjx1eEBFUd/9v4WOL35YH0P67sz9J3u6EL4wkE+pcIEr1mAq65VGeiu7xhanpBHIEZ9t5ylfL4FafyJGKA1hNoz3qlIHtJaz9wwxskvm1gTHkb8wCVPELVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773747025; c=relaxed/simple;
	bh=ORfMpPaF0Qt6xiRAdpw+WGiMSw3Qolb/2HE5OsMh3sU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=SVb3MTT3EXKMIg2JmWjm3iB7DsYmbvRRjGCdIY+DnC9OEBhbql5BjMOTJUATmBcxTk4ygjkTExC+GLNBYMfvUBdrZUlxRdyCRjeTNh+6WcBQ73N51xWiHZkdzlNQfXMdIAdWYDRq4WbxDkqJv8wbsw74EVbl+B59zMIXDOwhWxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AcdvFa9y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93600C4CEF7;
	Tue, 17 Mar 2026 11:30:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773747024;
	bh=ORfMpPaF0Qt6xiRAdpw+WGiMSw3Qolb/2HE5OsMh3sU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=AcdvFa9yv0D4dwGxphKc0WHx5vhCGjXHZ26lVUOIaV6U3ZMELkd6lLz5zkGXLgjoY
	 HGcps+GzuGVLW+d53JxE+03xEuU/R+0MuYYSkZMrJb/x68SwcRG1Hupa3oMLZYeFP8
	 lurXR73ZuWoS3v0GkCI6tglXMej17sawgzxXk97OiwKWIUnmZC6LxQ+sAclMA/nydP
	 XunnhyLcTrqvdLJw1np64DdYRV0UhQlcQwWe0DpHGUgav0U0GAuU/FPubaUVMsEhdY
	 PNXVdbco61yxX1xPRZXOfnHexZQDhLcT5f61GJg4mCGyGBPE5KpDJaNfqeYHgvO8BC
	 rLKeExkeU9LFQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3FE413808200;
	Tue, 17 Mar 2026 11:30:18 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] clsact: Fix use-after-free in init/destroy rollback
 asymmetry
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177374701703.3570990.8171547310653646673.git-patchwork-notify@kernel.org>
Date: Tue, 17 Mar 2026 11:30:17 +0000
References: <20260313065531.98639-1-daniel@iogearbox.net>
In-Reply-To: <20260313065531.98639-1-daniel@iogearbox.net>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: kuba@kernel.org, bpf@vger.kernel.org, netdev@vger.kernel.org,
 jhs@mojatatu.com, keenanat2000@gmail.com, martin.lau@kernel.org
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,mojatatu.com,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-268576-lists,netdev=lfdr.de,netdevbpf];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
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
X-Rspamd-Queue-Id: 676FD2A8D97
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Fri, 13 Mar 2026 07:55:31 +0100 you wrote:
> Fix a use-after-free in the clsact qdisc upon init/destroy rollback asymmetry.
> The latter is achieved by first fully initializing a clsact instance, and
> then in a second step having a replacement failure for the new clsact qdisc
> instance. clsact_init() initializes ingress first and then takes care of the
> egress part. This can fail midway, for example, via tcf_block_get_ext(). Upon
> failure, the kernel will trigger the clsact_destroy() callback.
> 
> [...]

Here is the summary with links:
  - [net] clsact: Fix use-after-free in init/destroy rollback asymmetry
    https://git.kernel.org/netdev/net/c/a0671125d4f5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



