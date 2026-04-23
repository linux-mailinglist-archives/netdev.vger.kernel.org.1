Return-Path: <netdev+bounces-280848-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CJ1/CLZv6mmLzQIAu9opvQ
	(envelope-from <netdev+bounces-280848-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 21:15:02 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 86DBF456905
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 21:15:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6581E301B14B
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 19:10:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75D8B391844;
	Thu, 23 Apr 2026 19:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T3QD459P"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52EE339182A;
	Thu, 23 Apr 2026 19:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776971456; cv=none; b=pPBrpu+6qha4Sqp54DisqiizSQU6NqB6nOgKgaP4L1pVlFITwlGEWudQSG50XN0EBSxLKWD0l7GNeH7sk+RKhN0AAG9VrSQy7Wq09IckrPkFaoY8qvgKaZYp/p0agApnD6RH67Ewzmu9/Mv3YOvZq6wd2sDD9sJjIMH2kbooGAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776971456; c=relaxed/simple;
	bh=6SGZbcsI37W5mNbIsWK/IxFSRNG5tDV0vfuw1Lv5Nnc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=M/syuC/9Fe9pFGqGm0mEEQs04w7M+AKMTNCl5Kq+lXniBsU/pSnXf4qAN7FMqimedAh6TxpE10H7OmgpsjbaXQf6k01DO3HEgRYEynzfifF8DSSuhngXbWKfIBlkhmTRO4zrMVIz/rxP5IiNqwVZPJW0xLeWGui55aux9wzTdjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T3QD459P; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E21B5C2BCAF;
	Thu, 23 Apr 2026 19:10:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776971456;
	bh=6SGZbcsI37W5mNbIsWK/IxFSRNG5tDV0vfuw1Lv5Nnc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=T3QD459PKrfs+NQyLDD+fC97K/AZ4b5/fgek2h480PGxIZYiwmnwR/OstDo2o342H
	 2xesb3oB+CY6dCufyKCyn90GOEQ6/oS15fP6GU+ZDWJWWEzObd0J63KTnY8VljDjvW
	 uzfnWhc0Rd7nFlAyAjE4su2F0/wA1d9GOFaSmJqo/JcvJHDfXhUoOtCOM6L4asRGi8
	 pkouqggF/ZVdgHwgjHMk80rPsD3lzTUHPRS4LG0Rg0Muh7UflUQHPc1iFi60NFVGgs
	 1ukKSbP54rOqWth4NOCqOW83KZMwHtpkb2Pom8lIfEshLMHJJbcBiOJ66ZnBOtE2Vc
	 hws8HsCQIzoig==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7CFCF3809A90;
	Thu, 23 Apr 2026 19:10:18 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 1/1] tipc: fix double-free in tipc_buf_append()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177697141705.724716.9960573430185428617.git-patchwork-notify@kernel.org>
Date: Thu, 23 Apr 2026 19:10:17 +0000
References: <20260421124528.162996-1-lee@kernel.org>
In-Reply-To: <20260421124528.162996-1-lee@kernel.org>
To: Lee Jones <lee@kernel.org>
Cc: jmaloy@redhat.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, ying.xue@windriver.com,
 netdev@vger.kernel.org, tipc-discussion@lists.sourceforge.net,
 linux-kernel@vger.kernel.org, tung.quang.nguyen@est.tech
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-280848-lists,netdev=lfdr.de,netdevbpf];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FROM_NO_DN(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 86DBF456905
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 21 Apr 2026 13:45:26 +0100 you wrote:
> tipc_msg_validate() can potentially reallocate the skb it is validating,
> freeing the old one.  In tipc_buf_append(), it was being called with a
> pointer to a local variable which was a copy of the caller's skb
> pointer.
> 
> If the skb was reallocated and validation subsequently failed, the error
> handling path would free the original skb pointer, which had already
> been freed, leading to double-free.
> 
> [...]

Here is the summary with links:
  - [v2,1/1] tipc: fix double-free in tipc_buf_append()
    https://git.kernel.org/netdev/net/c/d293ca716e7d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



