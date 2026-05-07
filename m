Return-Path: <netdev+bounces-285237-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uAXEHrVs/GmMPwAAu9opvQ
	(envelope-from <netdev+bounces-285237-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 12:43:01 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id ED7E44E6F53
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 12:43:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2F90C3015D0A
	for <lists+netdev@lfdr.de>; Thu,  7 May 2026 10:40:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 477673E928C;
	Thu,  7 May 2026 10:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tcZmObXw"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 248A6348452;
	Thu,  7 May 2026 10:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778150456; cv=none; b=NE0jZtWpEelRnM1MW8KVWkPVtY2ULmBUPWk9YFuM+UzrnkkV06oq9yoP8A3AFlmu/Ntn63Zw+h6c7BE/XGlcO+FIiYG1XOzVldf6/U7R/baJoTnJnAVNGlGX6l/odfXaJcJRo1a/ULAal14EjRm6ThLRwe78+aYwspFH7VtOP14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778150456; c=relaxed/simple;
	bh=ty6ByMMwmHfdP/GbIPOO9csNm+wGLtW1oBh9hKKWCPE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=fdcvrX6OB6MF1UBD4dYy4lLAC/YjdcD4uui+WI0YOBveciJOZJziojaQZFXuBPeU5MR6WpnEdOHAAIGQu1xEtHupATqjwRPzkK3KYTfM1oWw92OzaEVwLMGIDqxeAaBg7JRpMjrU5wIzS1Qm6a0lbp2mOy8StlES45PxCVyyUMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tcZmObXw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0A9FC2BCB2;
	Thu,  7 May 2026 10:40:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778150455;
	bh=ty6ByMMwmHfdP/GbIPOO9csNm+wGLtW1oBh9hKKWCPE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=tcZmObXwz8Pm8CDKZ/AEjcyTe4CRNpTQGL//mbmAT0UOsto2c6H1Ya+cz7i7JwWzA
	 pErsavddvl3i7TFxXO9NP053huUM83hRawH871avt79gMHpnQiA4gGI5ABHsOrksUa
	 fCJWeWB7Iv9APxnERClAxj9pfjkSuWRB0toiYw9wTdzj+lS/j4jdMF4cSrLeFtJmDF
	 /qp7igK5f5fWwPUrAPdtLX7mCDdeOXF31ugQ9lcwNgTMRndPFR3hwNPIIgP0L02Vsa
	 hFFtoXtczhfrdSZtPaFoaTKQaFw2T5LL116Jx1PXu0Y3GQjXWhEoze+UoBdm1Ozi7s
	 fK5ovPsdDxAGw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3FCA839308E3;
	Thu,  7 May 2026 10:40:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] eth: fbnic: fix double-free of PCS on phylink
 creation failure
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177815040505.3460727.17923878150136810539.git-patchwork-notify@kernel.org>
Date: Thu, 07 May 2026 10:40:05 +0000
References: <20260504-fbnic-pcs-fix-v2-1-de45192821d9@meta.com>
In-Reply-To: <20260504-fbnic-pcs-fix-v2-1-de45192821d9@meta.com>
To: Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: alexanderduyck@fb.com, kuba@kernel.org, kernel-team@meta.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, linux@armlinux.org.uk, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, bobbyeshleman@meta.com
X-Rspamd-Queue-Id: ED7E44E6F53
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-285237-lists,netdev=lfdr.de,netdevbpf];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[meta.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Mon, 04 May 2026 18:42:11 -0700 you wrote:
> From: Bobby Eshleman <bobbyeshleman@meta.com>
> 
> fbnic_phylink_create() stores the newly allocated PCS in fbn->pcs and
> then calls phylink_create(). When phylink_create() fails, the error path
> correctly destroys the PCS via xpcs_destroy_pcs(), but the caller,
> fbnic_netdev_alloc(), responds by invoking fbnic_netdev_free() which
> calls fbnic_phylink_destroy(). That function finds fbn->pcs non-NULL and
> calls xpcs_destroy_pcs() a second time on the already-freed object,
> triggering a refcount underflow use-after-free:
> 
> [...]

Here is the summary with links:
  - [net,v2] eth: fbnic: fix double-free of PCS on phylink creation failure
    https://git.kernel.org/netdev/net/c/593dfd40a94c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



