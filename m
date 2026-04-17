Return-Path: <netdev+bounces-279206-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kCfBJ0+Z4WlavQAAu9opvQ
	(envelope-from <netdev+bounces-279206-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 17 Apr 2026 04:22:07 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EB2941632D
	for <lists+netdev@lfdr.de>; Fri, 17 Apr 2026 04:22:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 114893073610
	for <lists+netdev@lfdr.de>; Fri, 17 Apr 2026 02:22:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CB8828030E;
	Fri, 17 Apr 2026 02:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WIaIqLLY"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A3CD2580CF;
	Fri, 17 Apr 2026 02:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776392524; cv=none; b=NeElFsRWXemQLd/gOVkYpNURjdBAN4TQ4rSET12BSa/zFO7Zr5bRK1kMiFCXurEiUpJ042kOYUVdZEhPJoLmRR/mFzXvRapIgCjgWV4eKRcQwoEdH0s8yzCnd2v+6a/2/kguTzzSDXzXd9jkcIhg45UtVNNdte8Z6MqHQ37UoLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776392524; c=relaxed/simple;
	bh=tW8uDNfY92o5S6hLDT01VJ7EFuRfH7ansoC4IIIdG50=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HzLd5eagLkqeRJZy9fjVK+xAplTongLYzIIDTDPTCknWWimVTYAjOKUn8VF2RwounHfn2g947RpTyqH8xpRKrH3OC9y8jH1V5Hy+wzAuq1OZf/hiiM6Glzg7MfZBGcdHCo2PdRC4zovajcfy73qYxtZJE3i34ecG+c5xccfTdeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WIaIqLLY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EAE0C2BCB3;
	Fri, 17 Apr 2026 02:22:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776392523;
	bh=tW8uDNfY92o5S6hLDT01VJ7EFuRfH7ansoC4IIIdG50=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WIaIqLLY/gStjVg5y/LPNd5iLH/X5+xkFfZ6teN7CquC1Ac7X4jf9LyIg1cleuUdz
	 AONaH2cakroeWa/PANXCcYBP/NNuhcc8SzO5QFVazIjlZ1P/+trbchCVwS/J6FWgAW
	 E/sc7V8hwWfFoCy3Ta54cTyrXTk9SrtuxME4YFsce+5ho7viICCH2YXecrKyWi3ZPw
	 bDvVmfqF8LTUJOm+suLap2YKY2grfWkjbMBK/jWtAanvDB3Vy6JMJil3D6JRNQbpco
	 RVH6dWrkesuhfBXc/S15++3/EhmcxUNB+4eNSWujiw1Ey8vL8ns4i+qN11obcPl1/6
	 7O9lR596N+5EQ==
From: Jakub Kicinski <kuba@kernel.org>
To: vikas.gupta@broadcom.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	vsrama-krishna.nemani@broadcom.com,
	bhargava.marreddy@broadcom.com,
	rajashekar.hudumula@broadcom.com,
	ajit.khaparde@broadcom.com,
	dharmender.garg@broadcom.com,
	rahul-rg.gupta@broadcom.com
Subject: Re: [PATCH net v2 1/2] bnge: fix initial HWRM sequence
Date: Thu, 16 Apr 2026 19:22:01 -0700
Message-ID: <20260417022201.1807745-1-kuba@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260415151621.1104956-2-vikas.gupta@broadcom.com>
References: <20260415151621.1104956-2-vikas.gupta@broadcom.com>
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
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	TAGGED_FROM(0.00)[bounces-279206-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.998];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 1EB2941632D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
bnge: fix initial HWRM sequence

This commit modifies the initial HWRM sequence to allocate the context
memory before querying resource information. This addresses an issue where
firmware might not advertise correct resources.

> diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_core.c b/drivers/net/ethernet/broadcom/bnge/bnge_core.c
> --- a/drivers/net/ethernet/broadcom/bnge/bnge_core.c
> +++ b/drivers/net/ethernet/broadcom/bnge/bnge_core.c
> @@ -73,25 +73,35 @@ static int bnge_func_qcaps(struct bnge_dev *bd)

[ ... ]

>  	return 0;
> +
> +err_free_ctx_mem:
> +	bnge_free_ctx_mem(bd);
> +	return rc;
>  }

Could this error path leave the firmware with active DMA pointers to freed
memory?

Looking at bnge_alloc_ctx_mem(), it configures the firmware with host DMA
addresses for the backing store via bnge_backing_store_cfg(). If a
subsequent step like bnge_hwrm_func_resc_qcaps() fails, this new error path
directly frees the context memory.

Previously, errors in this sequence triggered bnge_fw_unregister_dev(),
which safely unregistered the firmware before freeing the memory. There is
even a comment in bnge_fw_unregister_dev() documenting this requirement:

static void bnge_fw_unregister_dev(struct bnge_dev *bd)
{
        /* ctx mem free after unrgtr only */
        bnge_hwrm_func_drv_unrgtr(bd);
        bnge_free_ctx_mem(bd);
}

Since the firmware isn't told to stop using the memory before it is freed
here, is there a risk the hardware might DMA into the freed host pages?

> @@ -132,32 +142,25 @@ static int bnge_fw_register_dev(struct bnge_dev *bd)

[ ... ]

> -err_func_unrgtr:
> -	bnge_fw_unregister_dev(bd);
> +err_free_ctx_mem:
> +	bnge_free_ctx_mem(bd);
>  	return rc;
>  }

This error path appears to have the same regression. If
bnge_hwrm_func_drv_rgtr() fails after bnge_func_qcaps() has already
configured the backing store, freeing the context memory directly without
unregistering might allow the hardware to access freed memory.
-- 
pw-bot: cr

