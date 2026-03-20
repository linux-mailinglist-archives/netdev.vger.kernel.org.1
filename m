Return-Path: <netdev+bounces-269985-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oKrDMoB+vWnH+QIAu9opvQ
	(envelope-from <netdev+bounces-269985-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 18:06:08 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 47A4A2DE3D0
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 18:06:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D8E2E31D1BE6
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 16:55:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF0D23D34A6;
	Fri, 20 Mar 2026 16:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pFKZDJC+"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBF1B3D3007;
	Fri, 20 Mar 2026 16:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774025446; cv=none; b=Xha/WNA9xFHV/gEJcOh+1LeQDFLHCMENxefWneUpMlVAacyOeG5KSzzztGYYlDFg5p1K62HKez/VCT7H2WPOa/Vh9FhwHHCFIxfrv/eDJWGtUTKNnjSUZxOiXPSXU8EFWjgLIUdUeB8wn7dlazULJfyahVW5gJXoDsZbpgYOuqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774025446; c=relaxed/simple;
	bh=NvXiFEhMPEMac1ptYcQNcCVPg/PeOfMJZ1/weyixYxc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g3q4coLmq915YUGRObQ62dhXxwDY6xDdEcMspgMMdvWuiusbxn0Jf6WKra/DdEW17k7x1GAgAfl8KwRH/GM5zYdg4VtRvGIu8IoVOA+hIf3i7NRU/TF24kwSp8f5qcynZwsNutKE2yhOQsKRuKJZTFW2U4wKzXE1CS2pajQtpR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pFKZDJC+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2E99C4CEF7;
	Fri, 20 Mar 2026 16:50:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774025446;
	bh=NvXiFEhMPEMac1ptYcQNcCVPg/PeOfMJZ1/weyixYxc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pFKZDJC+20E1M7hPSQhZgk8hj4QjvpGL9jVHd2bsgv0FhTBMGOxAr4mRjgoFl6kR5
	 QTAW/AxUEItXm1znK29pji85wBYvrPk2EfwnXRxykjOwJmQvLMGucZxto47pcsRHLg
	 dWBHy0HbfTRUrH/xsx6q2rwr715SB3d4h7fQlF+9pXNJVEjsRr1Yy1n5KmnL8uY81K
	 AXGBxw6+ISuOrNcNlvqTTOPRsRUlOXcphDa8x8WArHMldA+W6P9dVSm5NEk/mwJuT9
	 BnPFHbVc750dFqoyJCb03YZWEatmLGxGqeEX8y58SMstXwJIpqxNoeBdoT/YpMkOWv
	 O9n8xinL3HnaA==
From: Simon Horman <horms@kernel.org>
To: sbhatta@marvell.com
Cc: Simon Horman <horms@kernel.org>,
	kuba@kernel.org,
	gakula@marvell.com,
	bbhushan2@marvell.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	davem@davemloft.net,
	lcherian@marvell.com,
	andrew+netdev@lunn.ch,
	edumazet@google.com,
	pabeni@redhat.com,
	sgoutham@marvell.com
Subject: Re: [net-next PATCH v2 4/4] octeontx2-pf: cn20k: Use unified Halo context
Date: Fri, 20 Mar 2026 16:50:37 +0000
Message-ID: <20260320165037.96305-1-horms@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <1773920826-16985-5-git-send-email-sbhatta@marvell.com>
References: <1773920826-16985-5-git-send-email-sbhatta@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	TAGGED_FROM(0.00)[bounces-269985-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.977];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 47A4A2DE3D0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.

For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-local.html
---
octeontx2-pf: cn20k: Use unified Halo context

Use unified Halo context present in CN20K hardware for
octeontx2 netdevs instead of aura and pool contexts.

> diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/cn20k.c b/drivers/net/ethernet/marvell/octeontx2/nic/cn20k.c
> --- a/drivers/net/ethernet/marvell/octeontx2/nic/cn20k.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/nic/cn20k.c

[ ... ]

> +int cn20k_npa_alloc_dpc(struct otx2_nic *nic)
> +{
> +	struct npa_cn20k_dpc_alloc_req *req;
> +	struct npa_cn20k_dpc_alloc_rsp *rsp;
> +	int err;
> +
> +	req = otx2_mbox_alloc_msg_npa_cn20k_dpc_alloc(&nic->mbox);
> +	if (!req)
> +		return -ENOMEM;
> +
> +	/* Count successful ALLOC requests only */
> +	req->dpc_conf = 1ULL << 4;
> +
> +	err = otx2_sync_mbox_msg(&nic->mbox);
> +	if (err)
> +		return err;
> +
> +	rsp = (struct npa_cn20k_dpc_alloc_rsp *)otx2_mbox_get_rsp(&nic->mbox.mbox,
> +								  0, &req->hdr);
> +	if (IS_ERR(rsp))
> +		return PTR_ERR(rsp);
> +
> +	nic->npa_dpc = rsp->cntr_id;
> +
> +	return 0;
> +}

[ ... ]

> diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
> --- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
> @@ -1651,6 +1651,9 @@ int otx2_init_hw_resources(struct otx2_nic *pf)
>  	if (!is_otx2_lbkvf(pf->pdev))
>  		otx2_nix_config_bp(pf, true);
>
> +	if (is_cn20k(pf->pdev))
> +		cn20k_npa_alloc_dpc(pf);
                ^^^^^^^^^^^^^^^^^^^^^

Should the return value of cn20k_npa_alloc_dpc() be checked here?

Looking at cn20k_npa_alloc_dpc(), it can return -ENOMEM or errors from
otx2_sync_mbox_msg() or PTR_ERR() from otx2_mbox_get_rsp(). If the DPC
counter allocation fails, pf->npa_dpc remains 0 (from struct
zero-initialization).

Then cn20k_halo_aq_init() configures all NPA auras with
aq->halo.op_dpc_set = pfvf->npa_dpc (= 0), referencing an unallocated
DPC performance counter. On teardown, cn20k_npa_free_dpc() sends a mbox
message to free counter ID 0, which was never allocated.

Every other error-returning mbox operation in this function checks the
return value and jumps to an error label on failure. Should this follow
the same pattern?

> +
>  	/* Init Auras and pools used by NIX RQ, for free buffer ptrs */
>  	err = otx2_rq_aura_pool_init(pf);
>  	if (err) {

[ ... ]

