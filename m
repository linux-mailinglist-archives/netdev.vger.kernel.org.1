Return-Path: <netdev+bounces-260057-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uMRbBMhlnGmsFwQAu9opvQ
	(envelope-from <netdev+bounces-260057-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 15:35:52 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 32B7A1781E1
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 15:35:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id AF0C0303DA8F
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 14:34:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E368F29B78B;
	Mon, 23 Feb 2026 14:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="aptyBQpy";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jnv7RBJd"
X-Original-To: netdev@vger.kernel.org
Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C9D935BDAF
	for <netdev@vger.kernel.org>; Mon, 23 Feb 2026 14:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771857248; cv=none; b=B6fsTSo5HPt1q9ftT514BtuKfCWiEK30sWhXpPyq97wqpaK72BXs4YgbifdaacSKz+5XEZYlIEqK+w7r5gqTZ/XOek0tTVOSWgq12vC5KnFohePykvtJPfo4gpCGaXYcgy1Sgh5ZavOg4MpfUakOjqFOmEMI6+UXr48r4f05aB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771857248; c=relaxed/simple;
	bh=EI8qD/04qtfV/DgguhG2MakSzKU5c8+mEgksh5JOpZw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hd2JAz7mw8vmHY6+BXbvGM8TliJTPyB1FC3BOTl25jebGZRr6FLVf7+m6AvE+3dtOTBZ+5y2Xy9m2lfl/xgU8zJbZ2zgig4uTxBcg0QfEONXBDGm5ncKnhmibHqr8GVkGDDKt281xC9eO6MKRrAEjyR7c8xJj5z/eGsUjYs8sPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=aptyBQpy; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jnv7RBJd; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 2BF6814001F5;
	Mon, 23 Feb 2026 09:34:04 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Mon, 23 Feb 2026 09:34:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1771857244; x=
	1771943644; bh=ao0UszTQjfFn9H52On1n2U6NTSqRSLMQyEUhNgfc8LI=; b=a
	ptyBQpyiRUIgsVyll071JtMwNdl19P9P9e7NiM26c6PvqabW/rt0SL3doXHsZ+sO
	3q6pcTnqmBEhFONOyR5p3t4oP+Kxc/1gPZ4RibazSRs0PUKWM1Pf/ZAI5BTATN+g
	ND/Q0W3joF1XT5EK9jA3kia1LbX4U60xpvXsLF0mS5z7D0nRxSXD5aiHb9WoHgtQ
	7DgJYAn7xrfJv0snPGFVe+u9y5jrDsWyWXrUs/sD8219SKr3KRa82kkqbsJdLY1L
	gtlvNn5BSNUWBDhff6uasLSE8KUW3B5jFQT+9amg3lh47pWzazowYYHnoeerjbzC
	bmX5tkTGkSZwav//o8AXQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1771857244; x=1771943644; bh=ao0UszTQjfFn9H52On1n2U6NTSqRSLMQyEU
	hNgfc8LI=; b=jnv7RBJdP2ZPBiEXtimMh1qhogr0GN8cd+R4j1WDJa+Y7ZciIP2
	7tO6ZsqMBBEriamgkLA6FpqPD7mOTvGi5KLln2qj0NjKdmVkhYvs0tjJG/N2BxKx
	VYFEFDen5ePYIuXdjat+r8cn2bAzMFOSmjaAmoblsq2uNvZnFOs0jDDU7Qzy80hS
	3mbWpx32DCZMZqaK06on3BrzTWmzVQC0YQKp0/t8p50WCQTDtZORlOX/G1bMslMW
	5s+82MviqNahscgONyQsU2HYV+f8/Y1nUKuiRqkJmAMo55jH2oQ+0zQmeTuO7wZ0
	rG5dTfxAPo1Tkv2YnE6bjlZQI7IJSYK63Qg==
X-ME-Sender: <xms:W2WcadacKkUSjFKRhIuaSEUVAyquKkdm4ncFdRkgHtf45f-9LlELRQ>
    <xme:W2WcaQN2hqKfYt7NoE7GLUe8tLie_BWt-ACxm16HY8j4FpOWQT19-MWIFgBV6vmTa
    LJ1d3jAZJWRw-y6m_Faf5XoJUvZGFX04LumyXEyB4MCUESTqkeAGA>
X-ME-Received: <xmr:W2WcabUqXC7mO0csipJzIc0VDzs66cIuqyxDSYH2WwqLeW0qjr_uTZ-GVIGh>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvfeejgeekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtjeenucfhrhhomhepufgrsghrihhn
    rgcuffhusghrohgtrgcuoehsugesqhhuvggrshihshhnrghilhdrnhgvtheqnecuggftrf
    grthhtvghrnhepgefhffdtvedugfekffejvdeiieelhfetffeffefghedvvefhjeejvdek
    feelgefgnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiii
    gvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehsugesqhhuvggrshihshhnrghilhdr
    nhgvthdpnhgspghrtghpthhtohepuddvpdhmohguvgepshhmthhpohhuthdprhgtphhtth
    hopehrjhgvthhhfigrnhhisehpuhhrvghsthhorhgrghgvrdgtohhmpdhrtghpthhtohep
    nhgvthguvghvsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshgrvggvug
    hmsehnvhhiughirgdrtghomhdprhgtphhtthhopehtrghrihhqthesnhhvihguihgrrdgt
    ohhmpdhrtghpthhtohepmhgslhhotghhsehnvhhiughirgdrtghomhdprhgtphhtthhope
    gsohhrihhsphesnhhvihguihgrrdgtohhmpdhrtghpthhtohepjhhohhhnrdhfrghsthgr
    sggvnhgusehgmhgrihhlrdgtohhmpdhrtghpthhtohepkhhusggrsehkvghrnhgvlhdroh
    hrghdprhgtphhtthhopegurghvvghmsegurghvvghmlhhofhhtrdhnvght
X-ME-Proxy: <xmx:W2WcaVIKJxPdBi9nw0PhiOnAEnU8WIW1c-SrLhxv_lZGH7GJJV887g>
    <xmx:W2WcaWqnByHcAOL0umHEMTY4CZckHdYXFTk7AL7dlE_aZ71pi78-7w>
    <xmx:W2WcacxVYl1X1U1SrVQtKawyOg1qQBEsSicvg5nL1f7Wb8HuV3eAEA>
    <xmx:W2WcaavdnOW1mRcxlLorTwLn6oIPwtAdbOSb6GmXebLe8HTREt6AYA>
    <xmx:XGWcabM16PCkDtLBYR1cuK4b8AWLAlLEOyZxkz-Yd_TFNL8JYeX2fHeG>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 23 Feb 2026 09:34:02 -0500 (EST)
Date: Mon, 23 Feb 2026 15:34:00 +0100
From: Sabrina Dubroca <sd@queasysnail.net>
To: Rishikesh Jethwani <rjethwani@purestorage.com>
Cc: netdev@vger.kernel.org, saeedm@nvidia.com, tariqt@nvidia.com,
	mbloch@nvidia.com, borisp@nvidia.com, john.fastabend@gmail.com,
	kuba@kernel.org, davem@davemloft.net, pabeni@redhat.com,
	edumazet@google.com, leon@kernel.org
Subject: Re: [RFC PATCH v7 1/4] tls: add TLS 1.3 hardware offload support
Message-ID: <aZxlWCVi4RZhRWB4@krikkit>
References: <20260205231558.139818-1-rjethwani@purestorage.com>
 <20260205231558.139818-2-rjethwani@purestorage.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260205231558.139818-2-rjethwani@purestorage.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[queasysnail.net:s=fm1,messagingengine.com:s=fm3];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-260057-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[queasysnail.net];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FREEMAIL_CC(0.00)[vger.kernel.org,nvidia.com,gmail.com,kernel.org,davemloft.net,redhat.com,google.com];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sd@queasysnail.net,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[queasysnail.net:+,messagingengine.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,messagingengine.com:dkim,queasysnail.net:dkim,purestorage.com:email]
X-Rspamd-Queue-Id: 32B7A1781E1
X-Rspamd-Action: no action

The subject prefix needs to contain "PATCH net-next" to tell which
tree this applies to (net-next since it's a new feature).

See https://docs.kernel.org/process/maintainer-netdev.html


2026-02-05, 16:15:55 -0700, Rishikesh Jethwani wrote:
> Add TLS 1.3 support to the kernel TLS hardware offload infrastructure,
> enabling hardware acceleration for TLS 1.3 connections on capable NICs.
> 
> TLS 1.3 differs from TLS 1.2 in several key ways that affect hardware
> offload:
> 
> 1. Content type handling: TLS 1.3 encrypts the content type as part of
>    the ciphertext (inner content type), with the outer header always
>    showing application_data. Added content type byte appending in
>    tls_device_record_close() before the authentication tag.
> 
> 2. Version validation: Extended tls_set_device_offload() and
>    tls_set_device_offload_rx() to accept TLS_1_3_VERSION in addition
>    to TLS_1_2_VERSION.
> 
> 3. Software fallback: Updated tls_device_fallback.c to handle TLS 1.3
>    IV construction (XOR with sequence number instead of explicit IV)
>    and version-specific AAD sizes (5 bytes for TLS 1.3 vs 13 bytes for
>    TLS 1.2).
> 
> 4. Reencrypt path: Modified tls_device_reencrypt() to use
>    prot->prepend_size and prot->tag_size instead of hardcoded
>    TLS 1.2 values.
> 
> 5. Memory fallback: Pre-populate dummy_page with identity mapping for
>    all 256 byte values, enabling safe fallback when memory allocation
>    fails during TLS 1.3 content type appending.
> 
> 6. Rekey handling: HW offload key update (rekey) is not yet supported.
>    Added upfront checks to reject rekey on HW offload connections with
>    -EOPNOTSUPP. For SW connections, rekey skips device offload attempts
>    and goes directly to software path.

Really not a fan of the LLM output. I don't think most of this needs
to be in the commit message, or at least it should be much less
verbose.

Most of the comments in this series are also LLM verbosity, and
entirely unnecessary.


> Tested on Mellanox ConnectX-6 Dx (Crypto Enabled) with TLS 1.3 AES-GCM-128
> and AES-GCM-256 cipher suites.
> 
> Signed-off-by: Rishikesh Jethwani <rjethwani@purestorage.com>
> ---
>  net/tls/tls_device.c          | 57 ++++++++++++++++++----
>  net/tls/tls_device_fallback.c | 36 ++++++++++----
>  net/tls/tls_main.c            | 89 +++++++++++++++++++++--------------
>  3 files changed, 129 insertions(+), 53 deletions(-)
> 
> diff --git a/net/tls/tls_device.c b/net/tls/tls_device.c
> index 82ea407e520a..459963c254f4 100644
> --- a/net/tls/tls_device.c
> +++ b/net/tls/tls_device.c
> @@ -319,6 +319,33 @@ static void tls_device_record_close(struct sock *sk,
>  	struct tls_prot_info *prot = &ctx->prot_info;
>  	struct page_frag dummy_tag_frag;
>  
> +	/* TLS 1.3: append content type byte before tag.
> +	 * Record structure: [Header (5)] + [Ciphertext + ContentType (1)]
> +	 * + [Tag (16)]
> +	 * The content type is encrypted with the ciphertext for authentication.
> +	 */
> +	if (prot->version == TLS_1_3_VERSION) {
> +		struct page_frag dummy_content_type_frag;
> +		struct page_frag *content_type_pfrag = pfrag;
> +
> +		if (unlikely(pfrag->size - pfrag->offset < prot->tail_size) &&
> +		    !skb_page_frag_refill(prot->tail_size, pfrag,
> +					  sk->sk_allocation)) {
> +			/* Out of memory: use pre-populated dummy_page */

nit: unnecessary comment

Maybe a silly question but if we have this fallback to the dummy_page,
why even bother trying to allocate?

> +			dummy_content_type_frag.page = dummy_page;
> +			dummy_content_type_frag.offset = record_type;
> +			content_type_pfrag = &dummy_content_type_frag;
> +		} else {
> +			/* Write content type to current pfrag */

nit: unnecessary comment

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
> @@ -335,7 +362,7 @@ static void tls_device_record_close(struct sock *sk,
>  
>  	/* fill prepend */
>  	tls_fill_prepend(ctx, skb_frag_address(&record->frags[0]),
> -			 record->len - prot->overhead_size,
> +			 (record->len - prot->overhead_size) + prot->tail_size,

nit: why the parens?

>  			 record_type);
>  }
>  
> @@ -883,6 +910,7 @@ static int
>  tls_device_reencrypt(struct sock *sk, struct tls_context *tls_ctx)
>  {
>  	struct tls_sw_context_rx *sw_ctx = tls_sw_ctx_rx(tls_ctx);
> +	struct tls_prot_info *prot = &tls_ctx->prot_info;
>  	const struct tls_cipher_desc *cipher_desc;
>  	int err, offset, copy, data_len, pos;
>  	struct sk_buff *skb, *skb_iter;
> @@ -894,7 +922,7 @@ tls_device_reencrypt(struct sock *sk, struct tls_context *tls_ctx)
>  	DEBUG_NET_WARN_ON_ONCE(!cipher_desc || !cipher_desc->offloadable);
>  
>  	rxm = strp_msg(tls_strp_msg(sw_ctx));
> -	orig_buf = kmalloc(rxm->full_len + TLS_HEADER_SIZE + cipher_desc->iv,
> +	orig_buf = kmalloc(rxm->full_len + prot->prepend_size,
>  			   sk->sk_allocation);
>  	if (!orig_buf)
>  		return -ENOMEM;
> @@ -909,9 +937,8 @@ tls_device_reencrypt(struct sock *sk, struct tls_context *tls_ctx)
>  	offset = rxm->offset;
>  
>  	sg_init_table(sg, 1);
> -	sg_set_buf(&sg[0], buf,
> -		   rxm->full_len + TLS_HEADER_SIZE + cipher_desc->iv);
> -	err = skb_copy_bits(skb, offset, buf, TLS_HEADER_SIZE + cipher_desc->iv);
> +	sg_set_buf(&sg[0], buf, rxm->full_len + prot->prepend_size);
> +	err = skb_copy_bits(skb, offset, buf, prot->prepend_size);
>  	if (err)
>  		goto free_buf;
>  
> @@ -922,7 +949,7 @@ tls_device_reencrypt(struct sock *sk, struct tls_context *tls_ctx)
>  	else
>  		err = 0;
>  
> -	data_len = rxm->full_len - cipher_desc->tag;
> +	data_len = rxm->full_len - prot->tag_size;

Does this actually need to be changed? prot->tag_size doesn't vary
based on TLS version.

>  
>  	if (skb_pagelen(skb) > offset) {
>  		copy = min_t(int, skb_pagelen(skb) - offset, data_len);
> @@ -1089,7 +1116,8 @@ int tls_set_device_offload(struct sock *sk)
>  	}
>  
>  	crypto_info = &ctx->crypto_send.info;
> -	if (crypto_info->version != TLS_1_2_VERSION) {
> +	if (crypto_info->version != TLS_1_2_VERSION &&
> +	    crypto_info->version != TLS_1_3_VERSION) {

You can get rid of this whole version check, it was only needed
because HW offload supported less than SW. tls_main already ensures
that the version is 1.2 or 1.3.

>  		rc = -EOPNOTSUPP;
>  		goto release_netdev;
>  	}
> @@ -1196,7 +1224,8 @@ int tls_set_device_offload_rx(struct sock *sk, struct tls_context *ctx)
>  	struct net_device *netdev;
>  	int rc = 0;
>  
> -	if (ctx->crypto_recv.info.version != TLS_1_2_VERSION)
> +	if (ctx->crypto_recv.info.version != TLS_1_2_VERSION &&
> +	    ctx->crypto_recv.info.version != TLS_1_3_VERSION)

And same here.

But on the topic of version checks, Jakub asked you previously [1] to
make sure all drivers reject 1.3, and your reply only mentioned 3
drivers. We have 5 in tree (and the 2 your reply didn't mention don't
seem to have a version check, based on a quick look).

[1] https://lore.kernel.org/netdev/20260105172745.5cc67e79@kernel.org/


[...]
> diff --git a/net/tls/tls_device_fallback.c b/net/tls/tls_device_fallback.c
> index 03d508a45aae..c8d18cce80ed 100644
> --- a/net/tls/tls_device_fallback.c
> +++ b/net/tls/tls_device_fallback.c
> @@ -55,7 +55,7 @@ static int tls_enc_record(struct aead_request *aead_req,
>  	cipher_desc = get_cipher_desc(prot->cipher_type);
>  	DEBUG_NET_WARN_ON_ONCE(!cipher_desc || !cipher_desc->offloadable);
>  
> -	buf_size = TLS_HEADER_SIZE + cipher_desc->iv;
> +	buf_size = prot->prepend_size;
>  	len = min_t(int, *in_len, buf_size);
>  
>  	memcpy_from_scatterwalk(buf, in, len);
> @@ -66,16 +66,24 @@ static int tls_enc_record(struct aead_request *aead_req,
>  		return 0;
>  
>  	len = buf[4] | (buf[3] << 8);
> -	len -= cipher_desc->iv;
> +	if (prot->version != TLS_1_3_VERSION)
> +		len -= cipher_desc->iv;
>  
>  	tls_make_aad(aad, len - cipher_desc->tag, (char *)&rcd_sn, buf[0], prot);
>  
> -	memcpy(iv + cipher_desc->salt, buf + TLS_HEADER_SIZE, cipher_desc->iv);
> +	/* For TLS 1.2, copy explicit IV from record header.
> +	 * For TLS 1.3, IV was already set up and we XOR with sequence number.
> +	 */
> +	if (prot->version == TLS_1_3_VERSION)
> +		tls_xor_iv_with_seq(prot, iv, (char *)&rcd_sn);

tls_sw calls this unconditionally. I think it would make sense to be
consistent for the whole iv generation.

> +	else
> +		memcpy(iv + cipher_desc->salt, buf + TLS_HEADER_SIZE,
> +		       cipher_desc->iv);
>  
>  	sg_init_table(sg_in, ARRAY_SIZE(sg_in));
>  	sg_init_table(sg_out, ARRAY_SIZE(sg_out));
> -	sg_set_buf(sg_in, aad, TLS_AAD_SPACE_SIZE);
> -	sg_set_buf(sg_out, aad, TLS_AAD_SPACE_SIZE);
> +	sg_set_buf(sg_in, aad, prot->aad_size);
> +	sg_set_buf(sg_out, aad, prot->aad_size);
>  	scatterwalk_get_sglist(in, sg_in + 1);
>  	scatterwalk_get_sglist(out, sg_out + 1);
>  
> @@ -112,7 +120,6 @@ static void tls_init_aead_request(struct aead_request *aead_req,
>  				  struct crypto_aead *aead)
>  {
>  	aead_request_set_tfm(aead_req, aead);
> -	aead_request_set_ad(aead_req, TLS_AAD_SPACE_SIZE);

Then please get rid of this function entirely. We don't need a wrapper
for a single call to the crypto API.

>  }
>  
>  static struct aead_request *tls_alloc_aead_request(struct crypto_aead *aead,
> @@ -303,9 +310,9 @@ static struct sk_buff *tls_enc_skb(struct tls_context *tls_ctx,
>  {
>  	struct tls_offload_context_tx *ctx = tls_offload_ctx_tx(tls_ctx);
>  	int tcp_payload_offset = skb_tcp_all_headers(skb);
> +	void *buf, *iv, *aad, *dummy_buf, *salt, *iv_src;
>  	int payload_len = skb->len - tcp_payload_offset;
>  	const struct tls_cipher_desc *cipher_desc;
> -	void *buf, *iv, *aad, *dummy_buf, *salt;
>  	struct aead_request *aead_req;
>  	struct sk_buff *nskb = NULL;
>  	int buf_len;
> @@ -317,7 +324,11 @@ static struct sk_buff *tls_enc_skb(struct tls_context *tls_ctx,
>  	cipher_desc = get_cipher_desc(tls_ctx->crypto_send.info.cipher_type);
>  	DEBUG_NET_WARN_ON_ONCE(!cipher_desc || !cipher_desc->offloadable);
>  
> -	buf_len = cipher_desc->salt + cipher_desc->iv + TLS_AAD_SPACE_SIZE +
> +	/* Set AAD size based on TLS version */

another unnecessary comment.

[...]
> +		/* HW rekey not yet supported */

(here too)

[...]
> +		/* Only try HW offload on initial setup, not rekey */

(here too)

-- 
Sabrina

