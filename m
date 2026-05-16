Return-Path: <netdev+bounces-288532-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kCoFJwfEB2pEHwMAu9opvQ
	(envelope-from <netdev+bounces-288532-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 16 May 2026 03:10:31 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BF2EE559ACF
	for <lists+netdev@lfdr.de>; Sat, 16 May 2026 03:10:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 935483004072
	for <lists+netdev@lfdr.de>; Sat, 16 May 2026 01:10:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9432829827E;
	Sat, 16 May 2026 01:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VSq7ZZke"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 718471EA84
	for <netdev@vger.kernel.org>; Sat, 16 May 2026 01:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778893815; cv=none; b=RCK1JeCamt0fQWCxs7pie+3y/a5OI7jQvjOaQzF3QBFCwse5PDMUCjPwUWaQU7OXF+0WnGN6n3MZ7KRG8QyAfLoxCjPwFXJ7n6juX/UdNmCpEYK0sS75DRHN7xS7KITAO/UB0N6SIVk2YrtLzg//KzqljPOVFksXqi/U0MW652M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778893815; c=relaxed/simple;
	bh=jL7mFYf3rVR+JxDgkv4UI6YD9VctbCA7j+C0BaFG30A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NV/6uF5bEJTwOxYPUVsD/Kms2pfm4C2e8i8rccvQmpkyWeTFWDujut2a0ZvWWWF1658YmRSYcMM5up3Het4aOveBw6yeteD5OxkkOaCXqdlyfEBfpMhWqRDmn2/kpuvXmRGdFRFnD+FZvttS9tHPius9y3K6vcubgLfd4zkBcFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VSq7ZZke; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2F30C2BCB0;
	Sat, 16 May 2026 01:10:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778893815;
	bh=jL7mFYf3rVR+JxDgkv4UI6YD9VctbCA7j+C0BaFG30A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VSq7ZZkeltpjpr8Fj/pZndyfAhVM4IbWmW1xbXCIln3XCf/kEJ2EDmoedjGnrczsI
	 ak1lQherbj4Gdw57l7lX7EIsQnV2UGD+3wkGURR6Ovk2229+9ALmcPAmXBwyp+U+bL
	 McaFC6V/L6CfkvaFcCGZXAgIveyftcCmDuzO9Ok6GlYge3e43o0x1+Z52/Yxk8IY7S
	 oFIR2CRJwVn3RdcRmW4KVQYlpuKHiZhJ4WEC+AhT8SeNE5YhLuv3GQiJL3OK7//8es
	 vV2MFDv0gbLyfrxKXHkcZlZSZGZJ7ZVg3WiSoZEOd1uZ3tLQWDb4BaD2M4vtBko+90
	 b+TaxufDfVjwg==
From: Jakub Kicinski <kuba@kernel.org>
To: michael.chan@broadcom.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	davem@davemloft.net,
	netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	pavan.chebbi@broadcom.com,
	andrew.gospodarek@broadcom.com
Subject: Re: [PATCH net-next v2 07/15] bnxt_en: Allocate crypto structure and backing store
Date: Fri, 15 May 2026 18:10:13 -0700
Message-ID: <20260516011013.1857516-1-kuba@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260512212105.3488258-8-michael.chan@broadcom.com>
References: <20260512212105.3488258-8-michael.chan@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: BF2EE559ACF
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-288532-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Action: no action

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
bnxt_en: Allocate crypto structure and backing store

If the chip and firmware support crypto (TLS) offload, allocate a
bp->crypto_info software structure and backing store to support the RX
and TX contexts.  Each offloaded TLS connection requires a backing store
context for each direction.

> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_crypto.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_crypto.c
> new file mode 100644
> index 000000000000..a5fee08eaa67
> --- /dev/null
> +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_crypto.c

[ ... ]

> +static u32 bnxt_get_max_crypto_key_ctx(struct bnxt *bp, int key_type)
> +{
> +	u32 fw_maj = BNXT_FW_MAJ(bp);
> +
> +	if (key_type == BNXT_TX_CRYPTO_KEY_TYPE)
> +		return (fw_maj < 233) ? BNXT_MAX_TX_CRYPTO_KEYS_PRE_233FW :
> +		       BNXT_MAX_TX_CRYPTO_KEYS;
> +
> +	return (fw_maj < 233) ? BNXT_MAX_RX_CRYPTO_KEYS_PRE_233FW :
> +	       BNXT_MAX_RX_CRYPTO_KEYS;
> +}

[ ... ]

> +void bnxt_alloc_crypto_info(struct bnxt *bp,
> +			    struct hwrm_func_qcaps_output *resp)
> +{
> +	u16 max_keys = le16_to_cpu(resp->max_key_ctxs_alloc);
> +	struct bnxt_crypto_info *crypto = bp->crypto_info;
> +
> +	if (BNXT_VF(bp))
> +		return;
> +	if (!crypto) {
> +		struct bnxt_kctx *kctx;
> +		int i;
> +
> +		crypto = kzalloc_obj(*crypto);
> +		if (!crypto) {
> +			netdev_warn(bp->dev,
> +				    "Unable to allocate crypto info\n");
> +			return;
> +		}
> +		for (i = 0; i < BNXT_MAX_CRYPTO_KEY_TYPE; i++) {
> +			kctx = &crypto->kctx[i];
> +			kctx->type = i;
> +			kctx->max_ctx = bnxt_get_max_crypto_key_ctx(bp, i);
> +		}
> +		bp->crypto_info = crypto;
> +	}
> +	crypto->max_key_ctxs_alloc = max_keys;
> +}

[Medium]
Should the kctx[].max_ctx values be refreshed on every call, rather than
only when bp->crypto_info is first allocated?

bnxt_alloc_crypto_info() can be invoked multiple times for a given bp.
__bnxt_hwrm_func_qcaps() is the caller, and it runs from paths such as
bnxt_resume(), bnxt_restore_pf_fw_resources(), bnxt_io_resume(), and
during SR-IOV enable, in addition to initial probe.

On the second and later calls, the crypto pointer is non-NULL, so the
loop that calls bnxt_get_max_crypto_key_ctx(bp, i) is skipped and only
crypto->max_key_ctxs_alloc is refreshed.

If BNXT_FW_MAJ(bp) crosses the 233 boundary between two qcaps queries on
the same driver instance (for example after a firmware update applied
across suspend/resume, or after a firmware reset that re-reads
fw_ver_code), the cached kctx[].max_ctx retains the pre-233 value of
65535 instead of being recomputed to 204800.

bnxt_backing_store_cfg_v2() then sizes the TCK/RCK backing stores from
those cached values:

	if (crypto) {
		ctxm = &ctx->ctx_arr[BNXT_CTX_TCK];
		rc = bnxt_setup_ctxm_pg_tbls(bp, ctxm,
					     BNXT_TCK(crypto).max_ctx, 1);
		...
		ctxm = &ctx->ctx_arr[BNXT_CTX_RCK];
		rc = bnxt_setup_ctxm_pg_tbls(bp, ctxm,
					     BNXT_RCK(crypto).max_ctx, 1);

and bnxt_setup_ctxm_pg_tbls() applies clamp_t(u32, entries,
ctxm->min_entries, ctxm->max_entries), so the stale 65535 caps the
allocation even if firmware now advertises a larger ctxm->max_entries.

Would moving the kctx[] initialization out of the if (!crypto) block, or
running it unconditionally, be a better fit for the function name and
kerneldoc which describe it as 'Allocate and initialize crypto offload
context' without noting the once-only initialization?

