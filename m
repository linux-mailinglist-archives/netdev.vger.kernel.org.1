Return-Path: <netdev+bounces-272573-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CBS7KIqGxmlALQUAu9opvQ
	(envelope-from <netdev+bounces-272573-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 14:30:50 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C077434541D
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 14:30:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B0D363027688
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 13:29:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11E393E9295;
	Fri, 27 Mar 2026 13:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="aadqkOco";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="OZkyxgsh"
X-Original-To: netdev@vger.kernel.org
Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8C0B3EAC8D
	for <netdev@vger.kernel.org>; Fri, 27 Mar 2026 13:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774618185; cv=none; b=BR6Hyh26Qmt873Cl0VR29xc+Ew62Gi1vijMvXh+KVIx/OOhaJCT/+usqXzRIGKNj6t4eJILYp2IUJBdd2no9zhUEiswpJq6xens6/lVvL9Q9UMSQwi9BgveoIPEgI9PGIs6OR+2E2zfOzg+Mweh5o14dOwZTC1xNWLO+z82O5ko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774618185; c=relaxed/simple;
	bh=NJqVpvJhJBm0VShieAiUFCZ4442kUiTh0IjxnWGK4zk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RKWw1IHJBDfnn6FzaRIm7QdXiBLk500zHkPCxquKimWTclWQYDbhrBRUBLOkHi6Vf5RjcxJzbL1VFJdxizZ1Q3lvtUbz7lLKgZdEXGhIuQYTRP34j4aePzs0F+WaRhJTbxrgQy1/va56zqQBlfu98ITuGjLYDVag24PPvknWkTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=aadqkOco; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=OZkyxgsh; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfhigh.stl.internal (Postfix) with ESMTP id A707B7A0170;
	Fri, 27 Mar 2026 09:29:40 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-10.internal (MEProxy); Fri, 27 Mar 2026 09:29:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1774618180; x=
	1774704580; bh=2IXZxqukJb5w4rqqyV4J/rzB7JNGA6tYKyvKZ3+L5ZE=; b=a
	adqkOcoti1Opoh4vogjp6UqyGX7KUR57yG6lFjoqiT+PpsbDFkXhlRQrnk+yogCZ
	Noo+12e9DzcKEJ3javxDHNNx3efaJN2Y2f5h/SDBPu0ORJr5CMbxM79/9kgq6NOg
	U62RtoZmKx1agbOFUsysLdEbekQpslWUqY/3cN8nMR2UOahcAbbjz+mlsn1g5Mx1
	nJFd/aJhRZtf01jK4F1uDj3h+/21Idq2/DxsuEtAIAm5E1lL8tI2WSbai1CqaspP
	FjqDwLziHUMLPFDRXmzsgW/xymJJ6rHhE/IsQcYi9MowA2KEOR/fPGE7NyGalZtl
	BJaD5JCqJWJwAOazJX66A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1774618180; x=1774704580; bh=2IXZxqukJb5w4rqqyV4J/rzB7JNGA6tYKyv
	KZ3+L5ZE=; b=OZkyxgsh2VKpgj1jlyS8c/w+TRKh36By/bPXZK1kGFxxjs+obi5
	XJRF7p6Tj9+EzhhxZQ8rLsawPO4Ule88Oasz+a40tGX0yJ6/ny6C/xeO2atOmTsg
	ZNoLmhwoTQ2uWW/N5jKTTGzJNegO6tkypAWL1KU5BR65q1eQtQWlDQJpXWrREHgF
	nqGDXB8D38q3Q0vQXggnxK/mn1tlSkdwgutlme3tNgIFlj4ZJuruVlyC+nL72UcY
	+aRYrSIXFP7TCTUHYO/KdgN594GxdWXuRdsDYCdonRt7l+kSLd4sLI7IByaTaFOl
	hJz0aWJjtQQNW8ccQ03BfF9jPMbaSb7Upsg==
X-ME-Sender: <xms:Q4bGaUbDhOpMkSBW5UD7K6jREFIxDmLBPS7m8f2St6X4ZgblMznFAw>
    <xme:Q4bGabNzsZelcfzJ8w9XkIWYk_YUmhKq1KuRcm2dd6tA-DnDZLAzkgh1x8t8PTH5q
    vZi0IGxVYdg_z07DsCJ-FiPrfOp_4V1cJ6fXh16r5WVpzP1S8qHqA>
X-ME-Received: <xmr:Q4bGaaVO1q98NRDqFNKLpOrl8u0xgtBcWPj3xxyln1hQ3kNdO5-4935jUCrf>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeffedtgedtucetufdoteggodetrf
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
X-ME-Proxy: <xmx:Q4bGaYL3sTH74Ky0hbo95YO8qyoK_5odIs-lPEQarXFNbZV6C88NWg>
    <xmx:Q4bGadrEhzsRq_ycVY6_9xp4CwneZuCvdt5D6WpczaKXh5B3WYLlcg>
    <xmx:Q4bGaXx-oQNa3fia3kpdDqY_u3Xq7585CdYTFoGpedOjvp9vPU2WmA>
    <xmx:Q4bGaZtQT4_yq9PiqYnTTfCSqrJxohPL7Bx_EjFVKtvgG2R7X-Hwrw>
    <xmx:RIbGaSOOdZn58B9g-3SDhes_EumEt52XH03JBmI67nZI1tJL1HTVcNdQ>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 27 Mar 2026 09:29:39 -0400 (EDT)
Date: Fri, 27 Mar 2026 14:29:37 +0100
From: Sabrina Dubroca <sd@queasysnail.net>
To: Rishikesh Jethwani <rjethwani@purestorage.com>
Cc: netdev@vger.kernel.org, saeedm@nvidia.com, tariqt@nvidia.com,
	mbloch@nvidia.com, borisp@nvidia.com, john.fastabend@gmail.com,
	kuba@kernel.org, davem@davemloft.net, pabeni@redhat.com,
	edumazet@google.com, leon@kernel.org
Subject: Re: [PATCH v9 5/6] tls: add hardware offload key update support
Message-ID: <acaGQYExqMXEx7vZ@krikkit>
References: <20260320235706.636531-1-rjethwani@purestorage.com>
 <20260320235706.636531-6-rjethwani@purestorage.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260320235706.636531-6-rjethwani@purestorage.com>
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[queasysnail.net:s=fm2,messagingengine.com:s=fm1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-272573-lists,netdev=lfdr.de];
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
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C077434541D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

2026-03-20, 17:57:05 -0600, Rishikesh Jethwani wrote:
> Add TLS KeyUpdate (rekey) support for hardware offload connections.
> 
> When tls_dev_add() fails during hardware rekey, the connection
> gracefully degrades to software encryption/decryption while
> maintaining TLS_HW configuration.
> 
> Tested on Mellanox ConnectX-6 Dx (Crypto Enabled) with multiple
> TLS 1.3 key update cycles.

Now your commit messages have gone from "overly detailed descriptions
of every minor change" to not describing anything about a pretty
complex patch. This is also not helpful for reviewers.

Something like an overview of the parts that you're adding (flags,
extra SW context, saved sequence numbers, etc) and how they come
together to make the key transition work would probably help us figure
out what this patch does and if it does it correctly.

[short example: during the key transition a temporary SW ctx is used
because [...]. clean_acked keeps track of ACKs and sets the READY flag
when [...], then the next sendmsg call will complete the rekey in the
offload ctx and tear down the temporary SW ctx. etc]



Only a few comments on the rekey completion for now, I'm still looking
at the patch.

[...]
> +static int tls_device_complete_rekey(struct sock *sk, struct tls_context *ctx)
> +{
[...]
> +	rc = netdev->tlsdev_ops->tls_dev_add(netdev, sk, TLS_OFFLOAD_CTX_DIR_TX,
> +					     &offload_ctx->rekey_crypto_send.info,
> +					     tcp_sk(sk)->write_seq);
> +
[...]
> +	/* following this assignment tls_is_skb_tx_device_offloaded
> +	 * will return true and the context might be accessed
> +	 * by the netdev's xmit function.
> +	 */
> +	smp_store_release(&sk->sk_validate_xmit_skb, tls_validate_xmit_skb);
> +
> +	tls_sw_release_resources_tx(sk);

The write_seq we passed to tls_dev_add could be wrong if this ends up
pushing encrypted data on the socket?

> +	ctx->rekey_sw_ctx = NULL;
> +	ctx->rekey_cipher_ctx = NULL;
> +
> +	return 0;


[...]
> @@ -187,6 +404,32 @@ static void tls_tcp_clean_acked(struct sock *sk, u32 acked_seq)
>  	}
>  
>  	ctx->unacked_record_sn += deleted_records;
> +
> +	/* Track ACKs to determine when HW rekey can complete:
> +	 * complete_seq captures write_seq when old-key data is ACKed,
> +	 * REKEY_READY is set once all pending data (including any new) is
> +	 * ACKed.
> +	 */
> +	if (test_bit(TLS_TX_REKEY_PENDING, &tls_ctx->flags) &&
> +	    !test_bit(TLS_TX_REKEY_FAILED, &tls_ctx->flags)) {
> +		u32 boundary_seq = READ_ONCE(tls_ctx->rekey_boundary_seq);
> +		u32 complete_seq = READ_ONCE(tls_ctx->rekey_complete_seq);
> +
> +		if (!before(acked_seq, boundary_seq) && complete_seq == 0) {
> +			complete_seq = tcp_sk(sk)->write_seq;
> +			WRITE_ONCE(tls_ctx->rekey_complete_seq, complete_seq);
> +		}
> +
> +		if (complete_seq != 0) {
> +			u32 current_write_seq = tcp_sk(sk)->write_seq;
> +
> +			if (before(complete_seq, current_write_seq))
> +				WRITE_ONCE(tls_ctx->rekey_complete_seq, current_write_seq);
> +			else if (!before(acked_seq, complete_seq))
> +				set_bit(TLS_TX_REKEY_READY, &tls_ctx->flags);
> +		}

This is a really tricky part. AFAIU the rekey will only complete if
the peer manages to ACK fast enough, so that we don't already have
more data already in flight? And if not, we stay in SW mode "forever"?

Could we move to REKEY_READY as soon as acked >= boundary, and let
closing the SW context handle all the data that was sent since the
rekey was requested? Then we have a situation similar to the initial
setup, with some data floating in the queues that doesn't need to be
encrypted (in the initial setup case, because it's pre-encryption;
here, because it went through SW encrypt), and HW taking over after
that.

-- 
Sabrina

