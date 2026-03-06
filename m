Return-Path: <netdev+bounces-264827-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CBerNa7mqmlgYAEAu9opvQ
	(envelope-from <netdev+bounces-264827-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 06 Mar 2026 15:37:34 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 78895222CC4
	for <lists+netdev@lfdr.de>; Fri, 06 Mar 2026 15:37:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6664D300D77F
	for <lists+netdev@lfdr.de>; Fri,  6 Mar 2026 14:35:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A77D3A0B34;
	Fri,  6 Mar 2026 14:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mQ/8nSHB"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6778B34BA5B;
	Fri,  6 Mar 2026 14:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772807698; cv=none; b=es2QCbbmKABJ8gGibvIdNcZt8ti44gcaMlLsTfB0OiAF/5f8/LnY/2OCJNdlT4upSxkmawyA+HNUxzVlE54wZZzDlo6Jnw4ANSz7wdQip6YpMS0krevcj2ALiMDr4bZv4Jp1yVExIjxoVEMrmKYyi/lP9cp+rY6S0DZyt9zR5pM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772807698; c=relaxed/simple;
	bh=sBucqM3rI0E0bs+xWumm5X7Yw4YeWBjhy0nkysJaHTo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NhexwuK/d2Q/losurpcKJYsdWWMj5Bej2tTCaD0X9iH41yLgvj39T8E4kxR0G9dNjUOElt9HlJ77GH9j6rexI51gFsrldH4WeYyGTuvDLbUAi54cfFmB0HQw+xg3dSw04olXp8DTGIcDpLS2tMT6xvU+Z9aJ7n4ZyvpuN6lqCWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mQ/8nSHB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2F3DC4CEF7;
	Fri,  6 Mar 2026 14:34:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772807698;
	bh=sBucqM3rI0E0bs+xWumm5X7Yw4YeWBjhy0nkysJaHTo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mQ/8nSHBcnve2cyDs2qnAleZx6eiK9+HYkoQoEa7AkumPNz1UZuMhhog0tjnAFawd
	 fazBbin+qHFFSMWNUOicRBWLHXgH3F7kqJTbxu9Fr7E5OydZfmebfUnzf4brh6uJUZ
	 YobP3pFuPnGlqoE+vx2Dv777o+F4kR9rAc3mZ0AyGYlM1lLTZ5MgTK4uEtWjqPG6xv
	 pKUG05eMMuLDOL+k55Q6dvT5CwD8zEz2REBuEcYVQxLV7NmGW0EM6LV3ijMAhf7wpv
	 uxGve7Rfjy36GnVl0ToBREmM31kdDloRhcWOalcGcE/9Jsi3mDm3vLQ74CppwAMwjK
	 XsKBVsmibRkbA==
From: Simon Horman <horms@kernel.org>
To: rkannoth@marvell.com
Cc: Simon Horman <horms@kernel.org>,
	cjubran@nvidia.com,
	edumazet@google.com,
	donald.hunter@gmail.com,
	shshitrit@nvidia.com,
	netdev@vger.kernel.org,
	matttbe@kernel.org,
	jiri@resnulli.us,
	chuck.lever@oracle.com,
	saeedm@nvidia.com,
	kuba@kernel.org,
	linux-kernel@vger.kernel.org,
	davem@davemloft.net,
	sgoutham@marvell.com,
	pabeni@redhat.com
Subject: Re: [v2,net-next,4/5] octeontx2-af: npc: cn20k: dynamically allocate and free default MCAM entries
Date: Fri,  6 Mar 2026 14:28:05 +0000
Message-ID: <20260306142803.500805-3-horms@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260304043032.3661647-5-rkannoth@marvell.com>
References: <20260304043032.3661647-5-rkannoth@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 78895222CC4
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,nvidia.com,google.com,gmail.com,vger.kernel.org,resnulli.us,oracle.com,davemloft.net,marvell.com,redhat.com];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[16];
	TAGGED_FROM(0.00)[bounces-264827-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:url,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Action: no action

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.

For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-local.html
---
octeontx2-af: npc: cn20k: dynamically allocate and free default MCAM entries

This commit improves MCAM utilization by tying default entry lifetime to
NIX LF usage. Default entries are allocated when NIX LF is allocated and
freed when NIX LF is freed, with a new flag to allow the kernel PF driver
to retain entries across suspend/resume.

> diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
> index badfa1d64252..0fb2d71116f4 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c

[ ... ]

> @@ -1684,6 +1685,12 @@ int rvu_mbox_handler_nix_lf_alloc(struct rvu *rvu,
>  	if (is_sdp_pfvf(rvu, pcifunc))
>  		intf = NIX_INTF_TYPE_SDP;
>
> +	if (is_cn20k(rvu->pdev)) {
> +		rc = npc_cn20k_dft_rules_alloc(rvu, pcifunc);
> +		if (rc)
> +			goto free_dft;
> +	}
> +
>  	err = nix_interface_init(rvu, pcifunc, intf, nixlf, rsp,
>  				 !!(req->flags & NIX_LF_LBK_BLK_SEL));
>  	if (err)

Does this leak the cn20k default MCAM entries if nix_interface_init()
fails? The npc_cn20k_dft_rules_alloc() call succeeds and allocates entries
into the xa_pf2dfl_rmap xarray and hardware MCAM slots. When
nix_interface_init() subsequently fails, the error path jumps to 'free_mem'
rather than 'free_dft', skipping npc_cn20k_dft_rules_free().

> @@ -1699,6 +1706,10 @@ int rvu_mbox_handler_nix_lf_alloc(struct rvu *rvu,
>
>  	goto exit;
>
> +free_dft:
> +	if (is_cn20k(rvu->pdev))
> +		npc_cn20k_dft_rules_free(rvu, pcifunc);
> +
>  free_mem:
>  	nix_ctx_free(rvu, pfvf);
>  	rc = -ENOMEM;

The free_dft cleanup path exists and would handle the release, so should
the nix_interface_init() failure case use 'goto free_dft' instead?

