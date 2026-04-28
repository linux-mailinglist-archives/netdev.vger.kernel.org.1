Return-Path: <netdev+bounces-281578-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uvaMB2UM8GmiNgEAu9opvQ
	(envelope-from <netdev+bounces-281578-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 03:24:53 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 65F2547C5D2
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 03:24:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1744A3020D77
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 01:24:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 761D32C2349;
	Tue, 28 Apr 2026 01:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KUntDx0L"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAF3B29D29F
	for <netdev@vger.kernel.org>; Tue, 28 Apr 2026 01:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777339490; cv=none; b=cNjqxH5u32psylvlQXAnjS2hrKL1ZgId0aNfA6tnY20BI+9TdZR/OppyKhQwCuAhL2Z0Wtq/qZ3Zv9mgi0DvrUQGkAGZ/HITeXV1wKDAAW9OwcvwTD5o1kysYewJQMbQOdYlmoJGydCKXF0+9yeDOpTA1rERJZrQ8YcTmI/cl0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777339490; c=relaxed/simple;
	bh=Jrr5vozgfTInFQ8tY3V01o9YID5j5pE0ZSEW05djYFA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=p18tHcRP+IEZvr0mPu5NJpMqhXD/5UGvsN4DKIR3Xrs9ofjU3NJzL60v6n6osAdkI2/a9r8OLqqhLaXh0Wu4Tjrhi5264zVIJ2JJAThpDtD/SSfFOXOgbvphstrd0/jUi6aPaPOapmR38NIzhf0j3jbndaI2FatXyG8REGsQi3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KUntDx0L; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-488b150559bso85840765e9.1
        for <netdev@vger.kernel.org>; Mon, 27 Apr 2026 18:24:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777339487; x=1777944287; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=weDQ2uowpmJWEW0ohZ4PRY9xm0tEvW01Qf+utiRvTWI=;
        b=KUntDx0LWOSjDrwiK7AOLoztTzKWOKD6r1TTSiesmdBvp1V/UPWE5sKSLvZSZIhtXm
         APXyUwGshnbQWVyfoXn4EJrvvJqLsX8pVIkylkM6tUN0eh/NjR7RQNog9p47pHw8WCb8
         jkoD+L6CNzvXgMvSwSyHaF0hXlUWkgKRQMXea5oJDxYm6sSzw/ihV5nx97vIJ+HYrteR
         4GTcsfKC4LHHQRQpLxzU5avx5er+Wf/aL6GOvW1PJOECO6n5UDunQCx05KAmCAEjTmqf
         sV0CvhFuMYulueCgkPf2Kn8mEJzIlsEczbz2wXvAcNfv/TTQGuh1z+3E5oBr/n9so6Pa
         CM5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777339487; x=1777944287;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=weDQ2uowpmJWEW0ohZ4PRY9xm0tEvW01Qf+utiRvTWI=;
        b=e7jAZPrZx/Z6xuyLmO7RzwbY5IQIbYFS2T5BsrZVFVla2UBC1aRxVLMtxkeOQGt/H/
         kfYpVukNr+pXcMX1fD7AALRW68ofFdBT6f8XS+Kf/OuLluoS3ptYc7OrB8pcf6HeVc5R
         9osHs0O9q+CG/DiT43tp+OlwOTslOpEK7DLucaOc+7vp/UpsGkmSuTJPOEK4RxxIuD8K
         41GssTN4/HB/Np7DLy3hOiSoV1fsGmpsfyhCtDI8TeJqfSmFR3uos1MwlzY7L7Pp0rds
         D8oDFSBqpIEczhVwWZlLK9uipPQ2Zoph0+RwH0uUpqe276Gjxo5TxEcBrcqAd4OmSnKv
         ChUA==
X-Gm-Message-State: AOJu0YxI327fshfjfOegrfNYqmB4EUDc0R+JXB8XK+X9dnSLo91mpVI0
	Fhv88rGJbwtyQoQLjILoA0L8wfnqDbndl0vyYVa+KMmycCl6BEyPFvKwD0NYhVy4
X-Gm-Gg: AeBDievwM3RCu2iG5tAbR1igQmJWlMKSZXHlTeEXxq6OPGrVHcp4rgqGb9O5dSkt3xr
	L0kbtoDR5sIDg8LQB0ay5SRicLMCnK8/odKniC07TSGy+PCimN4EDj2NEdDvx41neZ/oNtmxKkG
	anfRQ7qcgWG9gCu+TqVVFWrOgtZ1QR31Pq1KhCrS6yLh4EW5KGzsbecDpU0uw27sXgzI4hi0tQl
	nUnBLYlpHocnOVsiBxs/kfkZTX/Y2lOhNyvK99yyWyNDaFFKDJRnxICdXVxljhGMAiqX3HstQk9
	ZFZhCgo+3ysOu1ZhybV3gNMG8u6c4DcrCfvBaevqceaW7qB9bMVT3MzQhhmno7kKAOpVoexXBzJ
	hg0P1XhGG5CsREbxkJtaJIBzvPhC4s8+kjuE4Z600GqL9nrMCXkcu8LnBJ+mSpAkcG5MbvBKNtg
	agj2enYRw2NUwWX/pcZyU4qJ4iIqeNK9XI6O7EbZBZEMYH53SavTSpy2Vn1gT2AKfMKF8KDRlxZ
	p/jZHWAn9N3tg==
X-Received: by 2002:a05:600c:5251:b0:488:81b1:ae36 with SMTP id 5b1f17b1804b1-48a77b19cf8mr13046995e9.23.1777339487108;
        Mon, 27 Apr 2026 18:24:47 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a774d9bd1sm10577525e9.3.2026.04.27.18.24.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Apr 2026 18:24:46 -0700 (PDT)
Date: Tue, 28 Apr 2026 02:24:45 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Eric Biggers <ebiggers@kernel.org>
Cc: netdev@vger.kernel.org, linux-crypto@vger.kernel.org,
 linux-kernel@vger.kernel.org, Eric Dumazet <edumazet@google.com>, Neal
 Cardwell <ncardwell@google.com>, Kuniyuki Iwashima <kuniyu@google.com>,
 "David S . Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon
 Horman <horms@kernel.org>, Ard Biesheuvel <ardb@kernel.org>, "Jason A .
 Donenfeld" <Jason@zx2c4.com>, Herbert Xu <herbert@gondor.apana.org.au>,
 Dmitry Safonov <0x7f454c46@gmail.com>
Subject: Re: [PATCH net-next v2 2/5] net/tcp-ao: Use crypto library API
 instead of crypto_ahash
Message-ID: <20260428022445.65e14a27@pumpkin>
In-Reply-To: <20260427172727.9310-3-ebiggers@kernel.org>
References: <20260427172727.9310-1-ebiggers@kernel.org>
	<20260427172727.9310-3-ebiggers@kernel.org>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 65F2547C5D2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-281578-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,google.com,davemloft.net,kernel.org,redhat.com,zx2c4.com,gondor.apana.org.au,gmail.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[16];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[davidlaightlinux@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

On Mon, 27 Apr 2026 10:27:24 -0700
Eric Biggers <ebiggers@kernel.org> wrote:

> Currently the kernel's TCP-AO implementation does the MAC and KDF
> computations using the crypto_ahash API.  This API is inefficient and
> difficult to use, and it has required extensive workarounds in the form
> of per-CPU preallocated objects (tcp_sigpool) to work at all.
> 
> Let's use lib/crypto/ instead.  This means switching to straightforward
> stack-allocated structures, virtually addressed buffers, and direct
> function calls.  It also means removing quite a bit of error handling.
> This makes TCP-AO quite a bit faster.
> 
> This also enables many additional cleanups, which later commits will
> handle: removing tcp-sigpool, removing support for crypto_tfm cloning,
> removing more error handling, and replacing more dynamically-allocated
> buffers with stack buffers based on the now-statically-known limits.
> 
> Reviewed-by: Ard Biesheuvel <ardb@kernel.org>
> Signed-off-by: Eric Biggers <ebiggers@kernel.org>
...
> @@ -344,33 +444,26 @@ static int tcp_v4_ao_calc_key(struct tcp_ao_key *mkt, u8 *key,
>  	struct kdf_input_block {
>  		u8                      counter;
>  		u8                      label[6];
>  		struct tcp4_ao_context	ctx;
>  		__be16                  outlen;
> -	} __packed * tmp;

That looks a bit horrid.
I also had a feeling that the compiler sometimes rejects non-packed structures
inside packed ones.
Perhaps nest the whole thing inside another structure that has an initial
u8 pad and is marked __packed __aligned(4).
Then the assignments to the fields of 'ctx' will be known to be aligned
even when tcp4_ao_context is also __packed.

	David

> -	struct tcp_sigpool hp;
> -	int err;
> -
> -	err = tcp_sigpool_start(mkt->tcp_sigpool_id, &hp);
> -	if (err)
> -		return err;
> -
> -	tmp = hp.scratch;
> -	tmp->counter	= 1;
> -	memcpy(tmp->label, "TCP-AO", 6);
> -	tmp->ctx.saddr	= saddr;
> -	tmp->ctx.daddr	= daddr;
> -	tmp->ctx.sport	= sport;
> -	tmp->ctx.dport	= dport;
> -	tmp->ctx.sisn	= sisn;
> -	tmp->ctx.disn	= disn;
> -	tmp->outlen	= htons(tcp_ao_digest_size(mkt) * 8); /* in bits */
> -
> -	err = tcp_ao_calc_traffic_key(mkt, key, tmp, sizeof(*tmp), &hp);
> -	tcp_sigpool_end(&hp);
> -
> -	return err;
> +	} __packed input = {
> +		.counter = 1,
> +		.label = "TCP-AO",
> +		.ctx = {
> +			.saddr = saddr,
> +			.daddr = daddr,
> +			.sport = sport,
> +			.dport = dport,
> +			.sisn = sisn,
> +			.disn = disn,
> +		},
> +		.outlen = htons(tcp_ao_digest_size(mkt) * 8), /* in bits */
> +	};
> +
> +	tcp_ao_calc_traffic_key(mkt, key, &input, sizeof(input));
> +	return 0;
>  }

