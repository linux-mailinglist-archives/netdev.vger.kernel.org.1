Return-Path: <netdev+bounces-277915-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CFjIHVoR3GkTMAkAu9opvQ
	(envelope-from <netdev+bounces-277915-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 12 Apr 2026 23:40:42 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C52DC3E633A
	for <lists+netdev@lfdr.de>; Sun, 12 Apr 2026 23:40:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C04FD300B9EB
	for <lists+netdev@lfdr.de>; Sun, 12 Apr 2026 21:40:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5C5F314A79;
	Sun, 12 Apr 2026 21:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fFbxdNm7"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90D8D2D877B;
	Sun, 12 Apr 2026 21:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776030032; cv=none; b=jFxOraFszeN9xTJr3dMVWAGa56oEeC3tWtkuBWCOudtWZHnIBCXcEA3M/CklQa9ktjMYBFDGhKOnctHjNRu9D+x+qn2v4qJJRGmiAWEDAKzZzQU4E75IkAmwG1QGXZJmWzF3pISFBjcaHA4D4ryyY+8Utq9UTPVos48r/Cj/RRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776030032; c=relaxed/simple;
	bh=dk8SMi0d6I2ZxoqFk/c6rqZX3J92eEr0bmC9wAtgvfY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=kNNKyphSPHgSAN+nfFbUW+0DPp7SEPuqZMpL10uIWrcsAxZwMrMzPzefN6pDQqJeZUSRWo2b7lbcdb49lqi3Vr5eyGCAID2c9mXJfrTrfOIYA0SCJW0BNLA/rWjuqePafKcaAvW+4wHGibT8wCeqVncArLR+Pca9xLr/rFxUuoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fFbxdNm7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36F98C19424;
	Sun, 12 Apr 2026 21:40:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776030032;
	bh=dk8SMi0d6I2ZxoqFk/c6rqZX3J92eEr0bmC9wAtgvfY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=fFbxdNm79OSni5Hbs+a3O+Ws6BT/Kt9EXm8iszNTrqZvGXE3E9lmkOvm5IlYlCfsb
	 O/lDufDgYg1Y6Nz+r0t6kCOxHFlEGCaJekX1B+IQFsnq3NJ43d96C0VohL2Hhx2UNy
	 wQaDSjXV5DvY7hnxFtIIozI3730vA9m77agRXLNqqxVzOGcqbTggH2i2XIAZCzJ46c
	 V4csqQmzDkryzcDAps8nHTo2679lgaHfvOXVuBksaBoQjD+a3yNc2z5VP/Ym/jIiZt
	 4FDVwMyrO2Gkjwgf94PI9ia7kWDSB5jPbgjof6YyKLM7wn4xTfTdD7FY7Tbp+ssVPA
	 izWvbhSXa8vBA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B9E413809A8C;
	Sun, 12 Apr 2026 21:40:05 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3 net] vsock: fix buffer size clamping order
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177603000455.3830830.9281764062768430447.git-patchwork-notify@kernel.org>
Date: Sun, 12 Apr 2026 21:40:04 +0000
References: <180118C5-8BCF-4A63-A305-4EE53A34AB9C@doyensec.com>
In-Reply-To: <180118C5-8BCF-4A63-A305-4EE53A34AB9C@doyensec.com>
To: Norbert Szetei <norbert@doyensec.com>
Cc: sgarzare@redhat.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 virtualization@lists.linux.dev, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	MISSING_XM_UA(0.00)[];
	TAGGED_FROM(0.00)[bounces-277915-lists,netdev=lfdr.de,netdevbpf];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NO_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C52DC3E633A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 9 Apr 2026 18:34:12 +0200 you wrote:
> In vsock_update_buffer_size(), the buffer size was being clamped to the
> maximum first, and then to the minimum. If a user sets a minimum buffer
> size larger than the maximum, the minimum check overrides the maximum
> check, inverting the constraint.
> 
> This breaks the intended socket memory boundaries by allowing the
> vsk->buffer_size to grow beyond the configured vsk->buffer_max_size.
> 
> [...]

Here is the summary with links:
  - [v3,net] vsock: fix buffer size clamping order
    https://git.kernel.org/netdev/net/c/d114bfdc9b76

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



