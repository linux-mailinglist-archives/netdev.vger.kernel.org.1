Return-Path: <netdev+bounces-260059-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gOcPH/pmnGmsFwQAu9opvQ
	(envelope-from <netdev+bounces-260059-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 15:40:58 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 13ECC17829F
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 15:40:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D4F4D3016D3F
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 14:40:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BEBB2BCF68;
	Mon, 23 Feb 2026 14:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="HlpNRq1e";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SBHUglle"
X-Original-To: netdev@vger.kernel.org
Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49375219303
	for <netdev@vger.kernel.org>; Mon, 23 Feb 2026 14:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771857655; cv=none; b=EoNVd534TuwVAYMC9bd7mnufi6N4i82PzcXtSZssdYmUAKbRHbOIBSSuQL4HFid8MRZRfCdIx/At/wizI8/XRYAjfsnS0LBz1qhbHceYTzJg/OCU6AODpfMj5fvmP1KAuedUYD0yOWuI0CpCpYvk4D/8P50Fk6tyVSbF78+UPTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771857655; c=relaxed/simple;
	bh=JuVOUZZOCBbdv8Sq8bppXf5/QqehZA5pv0LKlj7K16Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jWBxiso2RPVTOecirfl6WznJptjMa+szloUsZNIv/Tf28qP4YjH3aFtZBTNUDfeayEgcD7Odd6BRhW5WjK8dHq705jBWx3FHR1WcWnp1/6GKlZ+SO0+wbca3cEl0l2+A/nBvYp6KbEodvYBFRi6AxBoqri7ysGJ1GURqne9dM2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=HlpNRq1e; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=SBHUglle; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 8E62CEC0655;
	Mon, 23 Feb 2026 09:40:52 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Mon, 23 Feb 2026 09:40:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1771857652; x=
	1771944052; bh=ctdFUYKgqGOIytTReQO6HoZ810KAdlc7CCXov7Re70s=; b=H
	lpNRq1ejpleADg16QYpnQhNS+7xFgqeczdkZJc/lBvAdUNoMqQQwYZAWCmLxPKqR
	469Wvm/DFgxXaFYdlduadLOBVOuMdP4Ln+NoGCXDxdYOIe9wp+Ua7LqoMt7YOdnK
	r/2ubGsRmvIMT7Q9lpNGAbdc5Qu1HxQM/aEGvTcr+rqPrkv0z6ZgSzYfHhv9tB4G
	EGJULr8qnYKTutHB0aZon08ZJT0gPukL/vjokhjXpIZTjSvJdaUjJ0sBxuHQtZbD
	G3EL0vbweoZe9PojDbhsbne2mj/0XJz6NQ0/raK8yA3oCiC1mcOAxEFLkScDf1KF
	MmVHnQrHlPq93oGVyXyLg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1771857652; x=1771944052; bh=ctdFUYKgqGOIytTReQO6HoZ810KAdlc7CCX
	ov7Re70s=; b=SBHUglle9H6vG1wvzQSR3KXJY2LQ+OuyO0dVZZzrbYk9j4dOsqL
	gKuKfwMXT7x4K4cXeK2G0yzD8VYkMxuLGUnXeNMGrgFGQSuu2CITD2vG8SB86WBO
	VwAptWgIfHzlmoUaBMhuZS6tx/JnTAsqMsvt4aaxgy00Oxx2f7H+23Vrkvs1hO92
	gbc7siNHVBcr5UoQ840QJ9UMwUQAAA/KYNeowb/J8w7mdK5ctpGlzHeiC3unXT76
	fwO5iMYWf5zC+SQ/Q11FlAT1IyzyrHdb2Yf0rXkiW4pKNGwa8kiD1LwVoS3bcMoH
	n0M9nwSAnrrTCbseiamzNIEQRqMQvm/M30A==
X-ME-Sender: <xms:9GacaeHgahXrykw9KcngbKR_3LpnHsIWstO41gPuTt59btnNn1mFbg>
    <xme:9GacabJQKU_j1kF2lInkUricC97A4k_HSphtLsojYGMeVSt0YtcwZGrRwkh24fED4
    s4PY1LAZ76gasiHb_ChkOfQktFmIXUjYBqh225sVIi64gz93pTCAUs>
X-ME-Received: <xmr:9GacaTiBgFtBRUJAxD-0mi6zH9tvBFUCirdiUyamnAQRPMB0rxBR4gWhVlNN>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvfeejhedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtjeenucfhrhhomhepufgrsghrihhn
    rgcuffhusghrohgtrgcuoehsugesqhhuvggrshihshhnrghilhdrnhgvtheqnecuggftrf
    grthhtvghrnhepuefhhfffgfffhfefueeiudegtdefhfekgeetheegheeifffguedvueff
    fefgudffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epshgusehquhgvrghshihsnhgrihhlrdhnvghtpdhnsggprhgtphhtthhopeduvddpmhho
    uggvpehsmhhtphhouhhtpdhrtghpthhtoheprhhjvghthhifrghnihesphhurhgvshhtoh
    hrrghgvgdrtghomhdprhgtphhtthhopehnvghtuggvvhesvhhgvghrrdhkvghrnhgvlhdr
    ohhrghdprhgtphhtthhopehsrggvvggumhesnhhvihguihgrrdgtohhmpdhrtghpthhtoh
    epthgrrhhiqhhtsehnvhhiughirgdrtghomhdprhgtphhtthhopehmsghlohgthhesnhhv
    ihguihgrrdgtohhmpdhrtghpthhtohepsghorhhishhpsehnvhhiughirgdrtghomhdprh
    gtphhtthhopehjohhhnhdrfhgrshhtrggsvghnugesghhmrghilhdrtghomhdprhgtphht
    thhopehkuhgsrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepuggrvhgvmhesuggrvh
    gvmhhlohhfthdrnhgvth
X-ME-Proxy: <xmx:9GacaRmSHUwOC-FaxySj1rTMVcnE90iduMkhr3i4Xk-6YJO7ACCeJg>
    <xmx:9GacaSVBcJ1sFY95HqRi-RDVE4eYMyvR9vzX4RcccQl1nXcqBqq1Hg>
    <xmx:9GacaWvMbTIwlwwH6tHE1hG_z1jPnz6oXWcAIYfHXMdlLJaeT0Fp9Q>
    <xmx:9GacaV45pSSMH8ZEq06j6ORHDYfOtL3Q8SGSXdUBpF40pBO_7ReQwA>
    <xmx:9GacaV54Cf1gB0rdVI2Ef5csiQOlVvwlGgZPI_1t90cRJnClPN5F7eXp>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 23 Feb 2026 09:40:51 -0500 (EST)
Date: Mon, 23 Feb 2026 15:40:50 +0100
From: Sabrina Dubroca <sd@queasysnail.net>
To: Rishikesh Jethwani <rjethwani@purestorage.com>
Cc: netdev@vger.kernel.org, saeedm@nvidia.com, tariqt@nvidia.com,
	mbloch@nvidia.com, borisp@nvidia.com, john.fastabend@gmail.com,
	kuba@kernel.org, davem@davemloft.net, pabeni@redhat.com,
	edumazet@google.com, leon@kernel.org
Subject: Re: [RFC PATCH v7 2/4] tls: add hardware offload key update support
Message-ID: <aZxm8hSrVMkEIc2O@krikkit>
References: <20260205231558.139818-1-rjethwani@purestorage.com>
 <20260205231558.139818-3-rjethwani@purestorage.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260205231558.139818-3-rjethwani@purestorage.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[queasysnail.net:s=fm1,messagingengine.com:s=fm3];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-260059-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[messagingengine.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,queasysnail.net:dkim]
X-Rspamd-Queue-Id: 13ECC17829F
X-Rspamd-Action: no action

2026-02-05, 16:15:56 -0700, Rishikesh Jethwani wrote:
> Add TLS KeyUpdate (rekey) support for hardware offload connections,
> enabling key rotation on established TLS 1.3 connections without
> tearing down the hardware offload.
> 
> Key changes:
> 
> 1. Rekey API: Extended tls_set_device_offload() and
>    tls_set_device_offload_rx() with new_crypto_info parameter to
>    distinguish initial setup from key updates. During rekey, the old
>    HW context is deleted (tls_dev_del) and a new one is added
>    (tls_dev_add) with the updated key material.

I don't think the commit message needs that level of detail. You'll
probably want to look through the git log for net/ to get an idea of
what commit messages typically look like for kernel networking.


> 2. Graceful degradation: If hardware key update fails, the connection
>    gracefully degrades to software.

In do_tls_setsockopt_conf you have:

+		} else if (update && ctx->tx_conf == TLS_HW) {
+			/* HW rekey failed - return the actual error.
+			 * Cannot fall back to SW for an existing HW connection.
+			 */
 			goto err_crypto_info;

which doesn't look very graceful.

>  For TX, TLS_TX_DEV_CLOSED is set
>    and sk_validate_xmit_skb switches to tls_validate_xmit_skb_sw for
>    software encryption. For RX, TLS_RX_DEV_DEGRADED and TLS_RX_DEV_CLOSED
>    are set for software decryption. tx_conf/rx_conf remains TLS_HW.
> 
> 3. Record sequence management: During TX rekey, old pending records
>    are deleted and unacked_record_sn is reset to the new rec_seq.

So what happens if we need to retransmit them? We just give up?

There was quite some discussion about how rekey would work with HW
offload back when I implemented rekey for SW, which got recorded in
the cover letter and committed as da3e3186ef13 ("Merge branch
'tls1.3-key-updates'"). I would expect to either see those things
implemented in this series, or a justification for why they need to be
done differently (it's possible that things turn out different in
practice from what we discussed back then).

> 4. SW context refactoring: Split tls_set_sw_offload() into
>    tls_sw_ctx_init() and tls_sw_ctx_finalize() to allow the HW offload
>    RX path to initialize SW context first, attempt HW setup, then
>    finalize (memzero new_crypto_info, call tls_finish_key_update).

To ease reviews, maybe extract the refactoring into another patch to
separate it from the actual rekey implementation.

> 5. Added TLS_TX_DEV_CLOSED flag to track TX hardware context state,
>    to avoid double tls_dev_del call, symmetric with existing
>    TLS_RX_DEV_CLOSED.

AFAICT this bit is equivalent to having
    sk->sk_validate_xmit_skb == tls_validate_xmit_skb_sw

Do we need the bit or can we just check sk_validate_xmit_skb?

> This removes the rekey rejection checks added in the previous patch,
> replacing them with full rekey support including graceful degradation.

(nit: this precision is probably not needed)


[...]
> diff --git a/net/tls/tls_device.c b/net/tls/tls_device.c
> index 459963c254f4..4aaa51a35f1f 100644
[...]
>  	crypto_info = &ctx->crypto_send.info;
> -	if (crypto_info->version != TLS_1_2_VERSION &&
> -	    crypto_info->version != TLS_1_3_VERSION) {
> +	src_crypto_info = new_crypto_info ?: crypto_info;
> +	if (src_crypto_info->version != TLS_1_2_VERSION &&
> +	    src_crypto_info->version != TLS_1_3_VERSION) {
>  		rc = -EOPNOTSUPP;
>  		goto release_netdev;
>  	}
>  
> -	cipher_desc = get_cipher_desc(crypto_info->cipher_type);
> +	cipher_desc = get_cipher_desc(src_crypto_info->cipher_type);

This shouldn't be necessary, since do_tls_setsockopt_conf checks that
we're not changing cipher type during a rekey.


>  	/* Avoid offloading if the device is down
>  	 * We don't want to offload new flows after
> @@ -1182,29 +1194,91 @@ int tls_set_device_offload(struct sock *sk)
>  		goto release_lock;
>  	}
>  
> -	ctx->priv_ctx_tx = offload_ctx;
> +	if (!new_crypto_info) {
> +		ctx->priv_ctx_tx = offload_ctx;
> +	} else {
> +		char *key = crypto_info_key(src_crypto_info, cipher_desc);
> +
> +		offload_ctx = tls_offload_ctx_tx(ctx);
> +
> +		rc = crypto_aead_setkey(offload_ctx->aead_send, key,
> +					cipher_desc->key);
> +		if (rc)
> +			goto release_lock;
> +
> +		/* For rekey, delete old HW context before adding new one. */

As in the other patch, some unnecessary comments.

[...]
> +		memcpy(ctx->tx.iv + cipher_desc->salt, iv, cipher_desc->iv);
> +		memcpy(ctx->tx.rec_seq, rec_seq, cipher_desc->rec_seq);
> +
> +		spin_lock_irqsave(&offload_ctx->lock, flags);
> +		/* Delete old records, can't be retransmitted with new key */
> +		delete_all_records(offload_ctx);
> +
> +		/* Update unacked_record_sn for the new key's rec_seq.
> +		 * This is critical for SW fallback encryption to use
> +		 * the correct record sequence number after rekey.

The whole comment should probably be removed, but if it stays, it
should explain why this is critical, rather than just asserting that
it is. (but I guess this code will need to be changed to handle
unacked records anyway)

[...]
>  	dev_put(netdev);
>  
>  	return 0;
>  
>  release_lock:
>  	up_read(&device_offload_lock);
> +	if (new_crypto_info)
> +		goto release_netdev;

nit: not super elegant, but I'm not sure we can do much better :/

>  	clean_acked_data_disable(tcp_sk(sk));
>  	crypto_free_aead(offload_ctx->aead_send);
>  free_offload_ctx:
> @@ -1217,17 +1291,33 @@ int tls_set_device_offload(struct sock *sk)
>  	return rc;
>  }
>  

-- 
Sabrina

