Return-Path: <netdev+bounces-251665-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0HIgEEIYcGkEVwAAu9opvQ
	(envelope-from <netdev+bounces-251665-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 01:05:22 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 85D284E458
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 01:05:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 349C6B6107E
	for <lists+netdev@lfdr.de>; Tue, 20 Jan 2026 23:50:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81F8541C31E;
	Tue, 20 Jan 2026 23:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dwWOC4yb"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57F6341C308;
	Tue, 20 Jan 2026 23:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768952994; cv=none; b=uuCKwO3GpG90wcqZVR2wSsSTkiLDdtMmFGzsbUVRb01/LtH0aDFumsGz0CJIQN2sL3SWA7TvGlnUocr9Oq33fwab4etLwlb4ekarPMKnDBCMuexUGJ/aeYBllPqNGPJKRLA7josDOzsyrPj7R6A3ZEQLMSL7zTvhEdHlPd9SvSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768952994; c=relaxed/simple;
	bh=5zU+WsJJ28hMIpWmkyn7aFI1z6afsLSoYftbFxQnd2c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CjWk8/LFptcLQkbn03+atSGs0e5k0S/7aZJ38KTY9L5+XaVhDFXPjqTfoIKtV3uh1DONwNcCLRIfBytUxtR9nGcwEUYuk9g6zHf9udvGKJN6kK/zyLLB1WDgG4eXmAGYdzej89V6zUz4SuMWSmyfnv65YXfe1K5uAYAV3n4wqRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dwWOC4yb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6DD9C16AAE;
	Tue, 20 Jan 2026 23:49:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768952993;
	bh=5zU+WsJJ28hMIpWmkyn7aFI1z6afsLSoYftbFxQnd2c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dwWOC4ybAFPqiF7Pk5lgzTCGUSjQxEbOkvYkNQePabo+694H4E+EGf0jYrALhKeyC
	 9V1HVezVqXYu1GjLf4/DPKzr8GfUJMO+SV+pDwQCr/oZFlv5FA0b71TEF9GRioAv8Z
	 XY/HIfTCjzaWeAJ0ewxBdPdIpNEDeCMvMwJGNfRaA938t7IuT6LYGK1ltUIZBwRPWp
	 CM6BT4TIvURpPrP8VOC0syqmcpRO+tjY3TcLvKTO1cmTINOFC8gaiiGGRT9fia2+Eq
	 DcaHclTbb9aOVayo+/AGJ+mmRDN44RMbF/zuGK7be5Ahw2b9ldoqtndlceuBWuBsX5
	 Z2iQo1k8A9ibQ==
From: Jakub Kicinski <kuba@kernel.org>
To: rkannoth@marvell.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [net] octeontx2-af: Fix error handling
Date: Tue, 20 Jan 2026 15:49:51 -0800
Message-ID: <20260120234951.1888325-1-kuba@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260120024012.1292307-1-rkannoth@marvell.com>
References: <20260120024012.1292307-1-rkannoth@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-251665-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	PRECEDENCE_BULK(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DMARC_POLICY_ALLOW(0.00)[kernel.org,quarantine];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	RCPT_COUNT_THREE(0.00)[4];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo,linux.dev:url]
X-Rspamd-Queue-Id: 85D284E458
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.

For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-local.html
---
octeontx2-af: Fix error handling

This commit adds error handling and rollback logic to
rvu_mbox_handler_attach_resources() to properly clean up partially
attached resources when rvu_attach_block() fails.

> diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu.c
> index 2d78e08f985f..9b898d718fbf 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/af/rvu.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu.c

[ ... ]

> @@ -1724,22 +1725,31 @@ int rvu_mbox_handler_attach_resources(struct rvu *rvu,
>  	int err;
>
>  	/* If first request, detach all existing attached resources */
> -	if (!attach->modify)
> -		rvu_detach_rsrcs(rvu, NULL, pcifunc);
> +	if (!attach->modify) {
> +		err = rvu_detach_rsrcs(rvu, NULL, pcifunc);
> +		if (err)
> +			return err;
> +	}
>
>  	mutex_lock(&rvu->rsrc_lock);

[ ... ]

> +		err = rvu_attach_block(rvu, pcifunc, BLKTYPE_CPT,
> +				       attach->cptlfs, attach);
> +		if (err)
> +			goto fail6;
>  	}
>
> -exit:
> +	return 0;
                ^^^^

The success path returns here without calling mutex_unlock(). The mutex
was acquired earlier via mutex_lock(&rvu->rsrc_lock) but the success
path bypasses the unlock at fail1. Will this cause rvu->rsrc_lock to
remain held after a successful attach, leading to a deadlock on the
next call?

> +
> +fail6:

[ ... ]

> +fail1:
>  	mutex_unlock(&rvu->rsrc_lock);
>  	return err;
>  }
-- 
pw-bot: cr

