Return-Path: <netdev+bounces-270050-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KIAnK0OnvWkAAAMAu9opvQ
	(envelope-from <netdev+bounces-270050-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 21:00:03 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B0FD72E0A90
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 21:00:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5C49630DB270
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 19:44:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99C3734D4C2;
	Fri, 20 Mar 2026 19:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iseNEKqq"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7729B34CFD4
	for <netdev@vger.kernel.org>; Fri, 20 Mar 2026 19:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774035742; cv=none; b=c/zLSU0bZQogujrg5eVLOhj8B8YD8sU3kZQbTfeAD3+vFB4gxRHRSRzUi7Q8I9zAjzAIbbYLCxBwhCplxI8K7hcjul3L7A2gF5mLZImnjIrxCJ66DaRMzz4onGDQgD5e/jLU24P+nDpJjunXF7lQc0QA31Rolmm9KkQL33wppiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774035742; c=relaxed/simple;
	bh=/jn4txmOk77SOZ23jI9n9d1xsVinBCNoIt8ZYE+w2vs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mGoSiL9iqFJVnawVpRypa8d5uR+O3V9EiU/soxT97dR0aGtu3OM3ejrGSobzzx20C7EAyAEnDQs7m/FaCSC2UpsELMkMJvzt/OVbh3+lIySp0eRzNOY8+l/Boz2FSKcOqbxqVPC1kn5gD5xu88RgZBYVe+4B3A2l+MpUbJUSuiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iseNEKqq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2C8DC2BC87;
	Fri, 20 Mar 2026 19:42:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774035742;
	bh=/jn4txmOk77SOZ23jI9n9d1xsVinBCNoIt8ZYE+w2vs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iseNEKqq4u6bPid4PfTFdf7luCcTVN5m+X8rgMwChih6+J5pdjy8SkUvuKSfPT6gS
	 0YMMEL9HUkAO7xpy8nam4RDoIKMoQUDMofPNwj6SYK/Jz9WnAbNY4qMj6alCAcNY2s
	 fa24DCfD5uaRMQ5k3Lqt+D8lsRedRrxcWULVZ3iXVoa5cLAxgiOp7FvRv6NA1H1Z1f
	 vjciZ8sf1aCE/4MKOzAqTKA0/kRjksbiEwyTURUWoDPjo3d1FEpzPDz+nO7le1izfY
	 JOVzcNoc3BrzBxD0d+5b15e0RvZCdkx3Sc6wiV3Soynt6xpafHfZ4iPi8Y7bpjF5ZF
	 DKt7mrU6LDT9A==
From: Simon Horman <horms@kernel.org>
To: rjethwani@purestorage.com
Cc: Simon Horman <horms@kernel.org>,
	edumazet@google.com,
	kuba@kernel.org,
	mbloch@nvidia.com,
	john.fastabend@gmail.com,
	netdev@vger.kernel.org,
	davem@davemloft.net,
	sd@queasysnail.net,
	pabeni@redhat.com,
	saeedm@nvidia.com,
	borisp@nvidia.com,
	tariqt@nvidia.com,
	leon@kernel.org
Subject: Re: [PATCH v8 3/6] tls: add TLS 1.3 hardware offload support
Date: Fri, 20 Mar 2026 19:42:05 +0000
Message-ID: <20260320194205.175498-1-horms@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260319213323.235559-4-rjethwani@purestorage.com>
References: <20260319213323.235559-4-rjethwani@purestorage.com>
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
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,google.com,nvidia.com,gmail.com,vger.kernel.org,davemloft.net,queasysnail.net,redhat.com];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[14];
	TAGGED_FROM(0.00)[bounces-270050-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,linux.dev:url,dummy_content_type_frag.page:url]
X-Rspamd-Queue-Id: B0FD72E0A90
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.

For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-local.html
---
tls: add TLS 1.3 hardware offload support

Add TLS 1.3 support to the kernel TLS hardware offload infrastructure,
enabling hardware acceleration for TLS 1.3 connections on capable NICs.

> diff --git a/net/tls/tls_device.c b/net/tls/tls_device.c
> index 99c8eff9783e..5f5c0db118ff 100644
> --- a/net/tls/tls_device.c
> +++ b/net/tls/tls_device.c
> @@ -319,6 +319,27 @@ static void tls_device_record_close(struct sock *sk,
>  	struct tls_prot_info *prot = &ctx->prot_info;
>  	struct page_frag dummy_tag_frag;
>
> +	/* TLS 1.3: append content type byte before tag */
> +	if (prot->version == TLS_1_3_VERSION) {
> +		struct page_frag dummy_content_type_frag;
> +		struct page_frag *content_type_pfrag = pfrag;
> +
> +		if (unlikely(pfrag->size - pfrag->offset < prot->tail_size) &&
> +		    !skb_page_frag_refill(prot->tail_size, pfrag,
> +					  sk->sk_allocation)) {
> +			dummy_content_type_frag.page = dummy_page;
> +			dummy_content_type_frag.offset = record_type;
> +			content_type_pfrag = &dummy_content_type_frag;
> +		} else {
> +			unsigned char *content_type_addr;
> +
> +			content_type_addr = page_address(pfrag->page) +
> +					    pfrag->offset;
> +			*content_type_addr = record_type;
> +		}
> +		tls_append_frag(record, content_type_pfrag, prot->tail_size);
> +	}
> +
>  	/* append tag
>  	 * device will fill in the tag, we just need to append a placeholder
>  	 * use socket memory to improve coalescing (re-using a single buffer

For TLS 1.3, tls_device_record_close() now appends two separate fragments
instead of one. Looking at the caller tls_push_data():

net/tls/tls_device.c:tls_push_data() {
    ...
    if (record->num_frags >= MAX_SKB_FRAGS - 1 ||
        record->len >= data_limit)
        tls_device_record_close(sk, tls_ctx, ctx, record,
                                copied ? sg_data : NULL,
                                copied, record_type);
}

The caller closes the record when num_frags >= MAX_SKB_FRAGS - 1, reserving
only one slot for the close operation.

Under memory pressure, when both skb_page_frag_refill() calls fail (the new
one for content type and the existing one for tag), both fragments use
dummy_page but at different offsets:

    dummy_content_type_frag.offset = record_type (e.g., 23 for app data)
    dummy_tag_frag.offset = 0

These two dummy frags cannot coalesce in tls_append_frag() because their
offsets aren't contiguous (record_type+1 != 0 for any valid record_type).

Can this overflow the frags[] array in struct tls_record_info? If num_frags
starts at 16, the content type increment makes it 17, and the tag increment
makes it 18, but frags[MAX_SKB_FRAGS] only has valid indices 0-16. The
second tls_append_frag() call would write to frags[17], which is past the
end of the array.

Sabrina Dubroca noted in v7 review that you should ensure all 5 in-tree
drivers explicitly reject TLS 1.3 sessions. In v3, Jakub Kicinski asked
'Are all existing drivers rejecting TLS 1.3 sessions? These days we prefer
for drivers to explicitly opt into new features to avoid surprises.'

Your response mentioned only 3 drivers (chelsio/chtls, fungible/funeth,
mellanox/mlx5), but we have 5 drivers in tree. Sabrina noted the 2 your
reply didn't mention don't seem to have version checks. Without explicit
TLS 1.3 rejection in all drivers, the new TLS 1.3 path may be attempted by
drivers that don't support it.

Which drivers are the missing 2, and do they need version checks added?

[ ... ]

> @@ -1089,11 +1110,6 @@ int tls_set_device_offload(struct sock *sk)
>  	}
>
>  	crypto_info = &ctx->crypto_send.info;
> -	if (crypto_info->version != TLS_1_2_VERSION) {
> -		rc = -EOPNOTSUPP;
> -		goto release_netdev;
> -	}
> -
>  	cipher_desc = get_cipher_desc(crypto_info->cipher_type);
>  	if (!cipher_desc || !cipher_desc->offloadable) {
>  		rc = -EINVAL;

In v7 review, Sabrina Dubroca suggested this version check can be removed
entirely:

    'You can get rid of this whole version check, it was only needed
    because HW offload supported less than SW. tls_main already ensures
    that the version is 1.2 or 1.3.'

Was there a reason to keep this check in tls_set_device_offload() and
tls_set_device_offload_rx()?

[ ... ]

