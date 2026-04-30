Return-Path: <netdev+bounces-282651-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gFScFsPW8mnIugEAu9opvQ
	(envelope-from <netdev+bounces-282651-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 06:12:51 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B0FDD49D3C7
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 06:12:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id ECB85300D156
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 04:10:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40E5C3314C2;
	Thu, 30 Apr 2026 04:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vLn/Oz48"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E53125B30D;
	Thu, 30 Apr 2026 04:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777522251; cv=none; b=kvpoSLFxar2Nh1OUz+gMPWKQtc2/RAzTGt/fwI59x2bRlErCpErAIkMol3OrtskVFjbB4VxfUM2hRNTUBSaU6300WBOklp1Xz8dOmgi2SC3a0WtZLnPL1pU1HGzXwZDPgeE91g3fbxBoOk3HBtNIDyjngxHGLqOr7vXMiDGDazE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777522251; c=relaxed/simple;
	bh=a830X5XN4JsuY01EQMgXXNh6EXgOGgXVgezpAmZ1EoE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=tnHTuai6gY8A8cK5NE1A4cCWE+5oK+ALOYIoqLBiJz7e2KezZl07auivrLWL3TL0RBAmI44vuQIxdsJ/4M1eT1ddCktp3C0a4FiGoChDaYdRV9CI1L23rhOiXk7CLXWSnu3s+Z5likPTr2zvgJgV83CqKFDsxUrB7La7nL1zx/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vLn/Oz48; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B445FC2BCB8;
	Thu, 30 Apr 2026 04:10:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777522250;
	bh=a830X5XN4JsuY01EQMgXXNh6EXgOGgXVgezpAmZ1EoE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=vLn/Oz48DlL+P/rqDhoi5GFNUZTDpVKiRXqAWXGuzS4z1sCs+EK8xm8Rn4/WiCXL6
	 k0GIWqvLUjxZLPTGt0Iro33G/Ig7Ao4u5k6bblOI6R4UfUQM4yLYR6MYSLDoucht9/
	 GBZDPEZPNjNKDLXPpE7zCvhQ61sa+WQaLo1KMRgURo7zu86wb1D1p2Z/vI4RJbGpL1
	 r/WgIbYpJn1a3MwLD+FYUE/ELDMgppPRel4LrmS7brlZzvTtoK/5VnYK5nl+KgxiIv
	 x3uLXgHwniki9rRAzcqKutjJSeWXGhuY4gpQ0junCSod4TP+F+Q/AwZgTnsKRWWmQn
	 eVoKaAmeJSOZA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 02C963809A07;
	Thu, 30 Apr 2026 04:10:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] page_pool: fix memory-provider leak in
 page_pool_create_percpu() error path
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177752220554.2344375.3558591784501370664.git-patchwork-notify@kernel.org>
Date: Thu, 30 Apr 2026 04:10:05 +0000
References: <20260428170739.34881-1-basbunarhasan@gmail.com>
In-Reply-To: <20260428170739.34881-1-basbunarhasan@gmail.com>
To: Hasan Basbunar <basbunarhasan@gmail.com>
Cc: hawk@kernel.org, ilias.apalodimas@linaro.org, kuba@kernel.org,
 pabeni@redhat.com, edumazet@google.com, davem@davemloft.net,
 horms@kernel.org, almasrymina@google.com, asml.silence@gmail.com,
 kaiyuanz@google.com, willemb@google.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
X-Rspamd-Queue-Id: B0FDD49D3C7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-282651-lists,netdev=lfdr.de,netdevbpf];
	FREEMAIL_CC(0.00)[kernel.org,linaro.org,redhat.com,google.com,davemloft.net,gmail.com,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 28 Apr 2026 19:07:39 +0200 you wrote:
> When page_pool_create_percpu() fails on page_pool_list(), it falls
> through to its err_uninit: label, which calls page_pool_uninit().
> At that point page_pool_init() has already taken two references
> when the user requested PP_FLAG_ALLOW_UNREADABLE_NETMEM:
> 
> 	pool->mp_ops->init(pool)
> 	static_branch_inc(&page_pool_mem_providers);
> 
> [...]

Here is the summary with links:
  - page_pool: fix memory-provider leak in page_pool_create_percpu() error path
    https://git.kernel.org/netdev/net/c/5ef343614db7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



