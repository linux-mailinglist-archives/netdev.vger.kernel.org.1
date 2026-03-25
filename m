Return-Path: <netdev+bounces-271394-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CHhAF4Zhw2m1qQQAu9opvQ
	(envelope-from <netdev+bounces-271394-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 05:16:06 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D057431F917
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 05:16:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A6A523133080
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 04:10:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E345C30596F;
	Wed, 25 Mar 2026 04:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ST/pPAuk"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0E4C304BCB
	for <netdev@vger.kernel.org>; Wed, 25 Mar 2026 04:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774411822; cv=none; b=IENdRZgIqk6qp4xmJWnXf3XGkIL//jAgBzwF8vqR72AGdLfhaWTKvRgetxFPOPRXClusAj2ALCjXDQNsUb78Q9+NfhhTvljkX7DUichAIT6wP8VH6NC1WwSJzQTfGk4XwfjLTd4kGYNmZmTRZBLqKzeTRqcfHiQ95J2JH/PEfE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774411822; c=relaxed/simple;
	bh=jYKfzvh+GY2opyJ14MTi+0lboEJgdj+Pqs/mGQs/j2g=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=IpVjVx0ITit+YTP+YhKYeqexezNWMdxXIcLkl/QehpNyezo7KP7rDNfwUcZqlAGA/9IKJvQX97sOJ1Nr4tCchQqcwPGrVkNnqCz3mwc1bp0BO6ObhZ1dePzDhJHcUtTxbB0ZxnHpE6DwczEMtmbSeBLL6UigeZL9MXtI+u+vC+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ST/pPAuk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76173C2BC9E;
	Wed, 25 Mar 2026 04:10:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774411822;
	bh=jYKfzvh+GY2opyJ14MTi+0lboEJgdj+Pqs/mGQs/j2g=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ST/pPAukANm/Na+4AaFAR0gYtEAqlx/gWi1KBn23xTeqhoEVa8mMDExFawWL6qLqn
	 avRKywALQi5+CMrLvJmk04dDZ3IQUdmIGtvnyMEcJZatiy5+cCDlswjwnR+sYCULM4
	 XItuaJlN4J3pRgaqwYnD8CqiYeiSvUtlEuRgXrW9TIOR8YSqSHLVmGqpja00jIFHR+
	 dAU+mEpLa4vxdfkdF4ZswoxXeIzpkqmosGCYNcylGyNgV7lGJdynIGvH9dbG/WpdUr
	 YzVgqYr1NEUAgaDBG4n26axyqcrnfvqJRAYkW4iz7LgwN++izgq7up0hHxgZLzgcBl
	 3jmb6HgdRaxVQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3FF963808203;
	Wed, 25 Mar 2026 04:10:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 net] rtnetlink: fix leak of SRCU struct in
 rtnl_link_register
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177441180978.1422230.12088697952037517136.git-patchwork-notify@kernel.org>
Date: Wed, 25 Mar 2026 04:10:09 +0000
References: 
 <e77fe499f9a58c547b33b5212b3596dad417cec6.1774025341.git.sd@queasysnail.net>
In-Reply-To: 
 <e77fe499f9a58c547b33b5212b3596dad417cec6.1774025341.git.sd@queasysnail.net>
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: netdev@vger.kernel.org, kuniyu@google.com, kuba@kernel.org
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-271394-lists,netdev=lfdr.de,netdevbpf];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_NO_DN(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,queasysnail.net:email]
X-Rspamd-Queue-Id: D057431F917
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 23 Mar 2026 16:19:43 +0100 you wrote:
> Commit 6b57ff21a310 ("rtnetlink: Protect link_ops by mutex.") swapped
> the EEXIST check with the init_srcu_struct, but didn't add cleanup of
> the SRCU struct we just allocated in case of error.
> 
> Fixes: 6b57ff21a310 ("rtnetlink: Protect link_ops by mutex.")
> Signed-off-by: Sabrina Dubroca <sd@queasysnail.net>
> 
> [...]

Here is the summary with links:
  - [v2,net] rtnetlink: fix leak of SRCU struct in rtnl_link_register
    https://git.kernel.org/netdev/net/c/09474055f261

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



