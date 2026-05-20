Return-Path: <netdev+bounces-289722-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AFnIM+8cDWrZtQUAu9opvQ
	(envelope-from <netdev+bounces-289722-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 04:31:11 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FD59586D82
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 04:31:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A283E3014946
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 02:29:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42C382FD1B3;
	Wed, 20 May 2026 02:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CXdMOnMb"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 332932EBBA4
	for <netdev@vger.kernel.org>; Wed, 20 May 2026 02:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779244197; cv=none; b=DO9u3AVM8hDS6Wa2XpulJIvQU4pRDEXNq45pXtu0mW038PDml+bYODCOH6fS/7LCqBYRF5skDx+MV05HaBMwszSByUfB/QXegcWrKTLswm3YqnbO15vCikUXQH0kSkHS8w9jOOSPfIjTdg7o4elyWnb9GjV5u6BvjX8P5IkksB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779244197; c=relaxed/simple;
	bh=JcbPP9T7TpYC6NxFR1DhgsBEBuo45EvaUIMITSOn8Kg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=GqjhTldyQXjNfjERWI12imx4DUpTxXGsUq8jeO0FbxwgjrYAFqU1fr24soUhUMX+dQG5ca939L/OjrtQnOZfWydCBObBawwo7SvcgTJJCK/KtfNYId4XGE3YNNy6hHuwKEh+Xq05Ko96eEAayA3+tZsSvStocR1qg6UZxf2/e3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CXdMOnMb; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C70731F000E9;
	Wed, 20 May 2026 02:29:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779244195;
	bh=ltYAn1OZCQBvyqjoDcgQL4KJs4O3NKxVunolegqEpx8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=CXdMOnMb7AipOBVNV/v/rBhaEBZNcgvsfW89/Y7w3sL2v7LfZ7UN43Vp+wfyfsOkk
	 M83cTQa3lZgN8ThCvvsLF+MOQbWLHPriv1is8tg7RM+kOPohgfxQU+kB6qRfaupxf4
	 buRiVxAXhE1adkbSFFYHR2syyIw0yww10+cFuSl1SoAYAFMT8o+CFcxV579Hq2C14c
	 +SfT4e+M22Zp8dck6l2gZIl9pKmfvbG8vaPHAly/u38vve7gQXD+LZrV53pr4UsYrY
	 rYTOz1GhQXzFyu3df6WgEfgLXlbXPeak3q9bsZviMl+bezpl6E7FKTndc4Fp5eJuDN
	 NfNjvilyGreiA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D09FB383BF53;
	Wed, 20 May 2026 02:30:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] pds_core: fix debugfs_lookup dentry leak and error
 handling
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177924420640.2955096.13277020048491236931.git-patchwork-notify@kernel.org>
Date: Wed, 20 May 2026 02:30:06 +0000
References: <20260515212907.998028-3-nikhil.rao@amd.com>
In-Reply-To: <20260515212907.998028-3-nikhil.rao@amd.com>
To: Nikhil P. Rao <nikhil.rao@amd.com>
Cc: netdev@vger.kernel.org, brett.creeley@amd.com, eric.joyner@amd.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-289722-lists,netdev=lfdr.de,netdevbpf];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NO_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 2FD59586D82
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 15 May 2026 21:29:07 +0000 you wrote:
> debugfs_lookup() returns a dentry with an elevated reference count that
> must be released with dput(). The current code discards the returned
> dentry without calling dput(), causing a reference leak on every
> firmware reset recovery.
> 
> Additionally, when CONFIG_DEBUG_FS is disabled, debugfs_lookup()
> returns ERR_PTR(-ENODEV), not NULL. The current check passes for error
> pointers and would call dput() on an invalid pointer, causing a crash.
> 
> [...]

Here is the summary with links:
  - [net] pds_core: fix debugfs_lookup dentry leak and error handling
    https://git.kernel.org/netdev/net/c/dc416e32baae

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



