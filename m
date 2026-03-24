Return-Path: <netdev+bounces-270824-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KCXDF1bcwWmJXQQAu9opvQ
	(envelope-from <netdev+bounces-270824-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 01:35:34 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B154A2FFBC6
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 01:35:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C62B33008A6A
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 00:30:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 475B21531C8;
	Tue, 24 Mar 2026 00:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q5QSsFDb"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE94D3074A1
	for <netdev@vger.kernel.org>; Tue, 24 Mar 2026 00:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774312219; cv=none; b=KPKprf6fOGmcmXjzykGLz3EruuPB+kAUA+u9BIWFbjv2/cC8Aj6W20lD9vR+Guf+k/soyQDBAjioxKxA50bop9jxXDg9ol9Vke3sOFWKrFsmQltrEwtJjLe7sn9WGbfCamcPjo6sIGZyEy7dJTzMbgUwsiexsjHfCH42RJOGZuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774312219; c=relaxed/simple;
	bh=rJXAUAHKP12XnC8hSCOlmPsbfvYA0AQKStzCw7+L4eE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=tjiNDo9x0L7u04yh8Jmg66WrbWjP1Z1ULf1Zpfvg2FWfVwCt6oteDgXcW7pHa+B5gq2nGJ+02CZtj3LTmfW2K9MpCyFJJg5Yegf6PjAPXj9++bl+fWAgBci8AvT2BKCialV/Bkc2/2KlAWhxsMsrxfVIEQ4zAumomv7HbU05LvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q5QSsFDb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E26BC4CEF7;
	Tue, 24 Mar 2026 00:30:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774312218;
	bh=rJXAUAHKP12XnC8hSCOlmPsbfvYA0AQKStzCw7+L4eE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=q5QSsFDb6HUQvAn+i4mYLcw+qn7f7rUbV9vHL3PMPPxD+CV1kcrBUEhe2zw6RnQmu
	 gLa3uSTlI4JDFKei+sAIuAAk72cX79UVelBEju14JdxlzOJBKmSJpLXBfuKizMf5Ny
	 Izi8XT9LdYkFEyc5Ro/dk8V6F8lrMFfrEb0xEtekeoFVI4Z93ZTaq0/SAoB9XtxDIV
	 7ranY4cPDgDMjCflme/ppNYtu8pSW4CqAObFtLxsecisLqs9/+8Buua9iUNyTx/aIK
	 0pF9RLnbnffTy1kfBazDLKP+e4r8A+hMIJycRhF0HTEU9lPIdtRSCVRb5H8nMciIun
	 UqJo255g/P6HQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B9E6C3808200;
	Tue, 24 Mar 2026 00:30:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] net: fix fanout UAF in packet_release() via NETDEV_UP
 race
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177431220654.388684.858242122188558644.git-patchwork-notify@kernel.org>
Date: Tue, 24 Mar 2026 00:30:06 +0000
References: <20260319200610.25101-1-echelonh@gmail.com>
In-Reply-To: <20260319200610.25101-1-echelonh@gmail.com>
To: Yochai E <echelonh@gmail.com>
Cc: willemdebruijn.kernel@gmail.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-270824-lists,netdev=lfdr.de,netdevbpf];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NO_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B154A2FFBC6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 19 Mar 2026 22:06:10 +0200 you wrote:
> `packet_release()` has a race window where `NETDEV_UP` can re-register a
> socket into a fanout group's `arr[]` array. The re-registration is not
> cleaned up by `fanout_release()`, leaving a dangling pointer in the fanout
> array.
> `packet_release()` does NOT zero `po->num` in its `bind_lock` section.
> After releasing `bind_lock`, `po->num` is still non-zero and `po->ifindex`
> still matches the bound device. A concurrent `packet_notifier(NETDEV_UP)`
> that already found the socket in `sklist` can re-register the hook.
> For fanout sockets, this re-registration calls `__fanout_link(sk, po)`
> which adds the socket back into `f->arr[]` and increments `f->num_members`,
> but does NOT increment `f->sk_ref`.
> 
> [...]

Here is the summary with links:
  - net: fix fanout UAF in packet_release() via NETDEV_UP race
    https://git.kernel.org/netdev/net/c/42156f93d123

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



