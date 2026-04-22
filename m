Return-Path: <netdev+bounces-280515-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sDkHHgsB6Wl5SgIAu9opvQ
	(envelope-from <netdev+bounces-280515-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 19:10:35 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CEB424492E2
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 19:10:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 20DEE303F7CC
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 17:06:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 722C9382F20;
	Wed, 22 Apr 2026 17:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cq3dH9RI"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FC0A33F593;
	Wed, 22 Apr 2026 17:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776877616; cv=none; b=qvL8Pi+j0KrhvFVpgDzujGTC3JjeUvW/X1v3UnpvmhpWgntsZ45JvSfETJw7gPbXtwLwmETg176rTWTw5AIwmXgA10Owfzli6TGikJsa0oZeHrLGsmKaz3fW4gopxTFd5cpTw041k/uE4y4+yxWVwwT5PtG/zZm9QKoWWXQUPm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776877616; c=relaxed/simple;
	bh=1jJXo85jXbFFhSP6at4arBQQAL/KtSBYU+cDxLEzjRg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BeW6w++OeYzYAsYoT/3vJMnuZw6XorzSmupPbrwYs17HqPZcANJvacKBTS7PZajbIBNQd2ISkKFkSWtIWIQM3z5pYGxSAoB+u1Zyd9cRDka3VVSKS3ETE0BoajYSw12f9WRPspJumZQeg62hHWZbpFWScaR6PDDeS/oOqqEiuFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cq3dH9RI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C58FEC19425;
	Wed, 22 Apr 2026 17:06:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776877615;
	bh=1jJXo85jXbFFhSP6at4arBQQAL/KtSBYU+cDxLEzjRg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cq3dH9RIdZpd36w+Aa1lS8vqs6DsAlKh6NPY+uXbLxODjxT53cF6bBEoVIjT9OnJG
	 p90YgfnMVFZUjg6tjvBIUTcUS1NT/rvJW04CRnfMnf9EoID7bw9nPpWec205UpSCds
	 T3fSvLxavPMTFGYgltayMjxtw8bmMeVIYUsKHhl0ojqzZazqlnoo1EXPozP6Fz17EX
	 bXhFOYUD6eefLP62fJV5weGW1K21Xcf+6fSV+/G2P6h1mH67xRYbQi0OtlJalwJvVR
	 gkImzCIUp3NLL5nHHc/j9CT5+Pin56rI76DaHW1KoXTW3vfQVdj6wVOGVvLhU2TJz8
	 gbFFA5Vklf7gA==
From: Simon Horman <horms@kernel.org>
To: vikas.gupta@broadcom.com
Cc: 'Simon Horman' <horms@kernel.org>,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	vsrama-krishna.nemani@broadcom.com,
	bhargava.marreddy@broadcom.com,
	rajashekar.hudumula@broadcom.com,
	ajit.khaparde@broadcom.com,
	dharmender.garg@broadcom.com,
	rahul-rg.gupta@broadcom.com
Subject: Re: [PATCH net v3 1/2] bnge: fix initial HWRM sequence
Date: Wed, 22 Apr 2026 18:06:41 +0100
Message-ID: <20260422170641.846322-1-horms@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260418023438.1597876-2-vikas.gupta@broadcom.com>
References: <20260418023438.1597876-2-vikas.gupta@broadcom.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	TAGGED_FROM(0.00)[bounces-280515-lists,netdev=lfdr.de];
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
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,sashiko.dev:url]
X-Rspamd-Queue-Id: CEB424492E2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: 'Simon Horman' <horms@kernel.org>

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
Full review at: https://sashiko.dev
---
bnge: fix initial HWRM sequence

Firmware may not advertize correct resources if backing store is not
enabled before resource information is queried.
Fix the initial sequence of HWRMs so that driver gets capabilities
and resource information correctly.

> diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_core.c b/drivers/net/ethernet/broadcom/bnge/bnge_core.c
> index 1c14c5fe8d613..68b74eb2c3a29 100644
> --- a/drivers/net/ethernet/broadcom/bnge/bnge_core.c
> +++ b/drivers/net/ethernet/broadcom/bnge/bnge_core.c
[ ... ]
> @@ -133,23 +140,28 @@ static int bnge_fw_register_dev(struct bnge_dev *bd)
>  
>  	bnge_hwrm_fw_set_time(bd);
>  
> -	rc =  bnge_hwrm_func_drv_rgtr(bd);
> +	/* Get the resources and configuration from firmware */
> +	rc = bnge_func_qcaps(bd);
>  	if (rc) {
> -		dev_err(bd->dev, "Failed to rgtr with firmware rc: %d\n", rc);
> +		dev_err(bd->dev, "Failed querying caps rc: %d\n", rc);
>  		return rc;
>  	}
>  
>  	rc = bnge_alloc_ctx_mem(bd);
>  	if (rc) {
>  		dev_err(bd->dev, "Failed to allocate ctx mem rc: %d\n", rc);
> -		goto err_func_unrgtr;
> +		goto err_free_ctx_mem;
>  	}
>  
> -	/* Get the resources and configuration from firmware */
> -	rc = bnge_func_qcaps(bd);
> +	rc = bnge_hwrm_func_drv_rgtr(bd);
>  	if (rc) {
> -		dev_err(bd->dev, "Failed initial configuration rc: %d\n", rc);
> -		rc = -ENODEV;
> +		dev_err(bd->dev, "Failed to rgtr with firmware rc: %d\n", rc);
> +		goto err_free_ctx_mem;

Does this regression leave the hardware with active DMA pointers to freed
memory?

If bnge_alloc_ctx_mem() allocates host DMA memory and passes the addresses
to the firmware via bnge_hwrm_func_backing_store(), and then
bnge_hwrm_func_drv_rgtr() fails, the code jumps directly to err_free_ctx_mem.

> +	}
> +
> +	rc = bnge_func_qrcaps_qcfg(bd);
> +	if (rc) {
> +		dev_err(bd->dev, "Failed querying resources rc: %d\n", rc);
>  		goto err_func_unrgtr;
>  	}
>  
> @@ -158,7 +170,9 @@ static int bnge_fw_register_dev(struct bnge_dev *bd)
>  	return 0;
>  
>  err_func_unrgtr:
> -	bnge_fw_unregister_dev(bd);
> +	bnge_hwrm_func_drv_unrgtr(bd);
> +err_free_ctx_mem:
> +	bnge_free_ctx_mem(bd);

Since the err_func_unrgtr label is bypassed, is the firmware ever told to
drop the backing store configuration before the host frees the memory in
bnge_free_ctx_mem()?

In the pre-patch sequence, the driver was registered first, so any failure
subsequently triggered a driver unregister, which implicitly told the
firmware to drop the backing store configuration. With the new order, does
the firmware maintain active DMA pointers to the freed host memory?

