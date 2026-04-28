Return-Path: <netdev+bounces-281772-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4JU5BSSN8Gl4UwEAu9opvQ
	(envelope-from <netdev+bounces-281772-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 12:34:12 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B996482B5A
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 12:34:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C6101320A982
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 10:10:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC79D3E4C94;
	Tue, 28 Apr 2026 10:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZhepOoVP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57BF43E5EC6
	for <netdev@vger.kernel.org>; Tue, 28 Apr 2026 10:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777371013; cv=none; b=kMpvtNPeJJF44B/PHQbUc2PtTUrmDVXLyowWAIbC2uQ6vkuv3wRHfPaySEQZerypfdL5LcejyhdE11VM9eAGNcM6ZDQABT+Sz5rRxGXOiOwApG3DbW/JRn/TbrZoCEJRQSIlbl8zDSo4cHF7A0Yl+68HYqVAbpBPyB0GDjTXDeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777371013; c=relaxed/simple;
	bh=ZqIskksECjgqlrMhpopw9+qM4q+q5+z+/1bdrmopkhs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uBJme2HuilC8/ffUum3N80QEKU8/KyyvabWRQO4bQYqXRnuOmIW2kEZl35TDI/q8dtCJTORDbhjWYKetDllGnq/MKPaZ0svCHLoWbk2SfhV4ng50XcqdiEXjXfLkXriT9pW7+Ntnlw8wESf/P2GIAq0c2/LUcjsgNqo/8DHVYmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZhepOoVP; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4891c00e7aeso85448985e9.2
        for <netdev@vger.kernel.org>; Tue, 28 Apr 2026 03:10:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777371011; x=1777975811; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DeU99boB6vx+XraW8EtOdcOn2iNfoMQwjQgjHwduqTo=;
        b=ZhepOoVPA4tGdGP67TnV8ZntNhU513tu4Wiw5NW/BqJfoMz9kJSdf9FIUqiABxu4ZZ
         sImDMQO11AFBnSy1N2RfHEKIEoN9pjw6ig3glKzRGX0BUUD6x5Wehf/Hx6nbJIPKmSlT
         57MUaHB6h5SDQa9t2bcS2hEEa0Su06QiUro46rcZsagBdL9sHI3jz5aGQD9xSE14dLCh
         B63/nvEG9s8zlymEogin+0onAFW6vAVg9QLrLPhNWwt19etqmCLoZibfpSWta9vSZbwM
         CW3WsenROTHaFR1/drAkOB9z11BFobJMgeme4oQPW7rNUG66R8zzRcKb6U1oyqHJayB8
         3oqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777371011; x=1777975811;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DeU99boB6vx+XraW8EtOdcOn2iNfoMQwjQgjHwduqTo=;
        b=FooAwkbUdVX4n+PFY0HT4YAxsEIQ+pRY3f8xlPIgxUaKZ2bIn/mincS9INQY8LE984
         zuuzXb6970Jn8+TiXh+pHzSP9JjqqXZqrwAbGctAdWB5dASx5q2k9kMY3mXu+TKHyLoU
         mw6Rza0cwJ8QD0PwQIOnjg19hAoyc8IssRevaswct0O4Rz5BKffotDO6lmDm7j0/6sk8
         GL0Z3MqtHBpoJdjeM8sAnmFlBBSkNjkDRd9fYqfqij0C2q7vwDvO4uyHSPyCAMvhyYJ5
         Fj98qERilScajrZU3bc5xhvpQozDDgd67X7tvFZwUzg4apphMZ1xiDRcYVEENqvUGPOj
         ILkQ==
X-Forwarded-Encrypted: i=1; AFNElJ/f73+0P8AqI0GNQrfSaylJ2cjDmtXMjk0Dv3J3SEUsRRWxhwU1vVuRJMI1xSiJqySnBbj7CpQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwanKtycxNYf3Jveb/wECTN+tr9Q6811/9zepD1R7SCg8QPvqjL
	Ww3Zwz697ukywHHanQTPE5TQejWpW+QzG5JWQGbvj56SDAXIWvBhxIv7NfC4RlKk
X-Gm-Gg: AeBDievw07j23azdszz/ErFBsWZB9fLzucegTQpOl0HmyTNpTZjWIgdPGaSaWgoaIMC
	HfBWd1FJpcsqtjRfnvPsldaAd7qdf5cawjCCiHsPjiEqz2dyIJMljyEc8bEmHuJG0NPAk1OI8sS
	rDs8YH7nE8o6sFOHjiOe7XL/Dd4v+nWVKUPnQqB903nZ6kZqLEBqWHO2E4KGC+OZOOB2jqg4eWe
	Ru1pjHPR2X2JJgc6f9vv1gLA1N8xn3D0lmCf5N2CIPR/HoA7wwMx0tx7XIfgFZPgkp2qIoPoalP
	0kiE2T8P7RGoHtWrkFy9jztrsFGwN4uZNd7EV0/BlHPtdoFCrz0aipi4Zhq0asEIaoi2kVUqxbG
	uzHU0T6v6jo+nyl8eaufbUhCU6+NgWoH+IkDb5YseXpLBbxP/yBQ3SeJCO2EKb2EhEYS9rMvzY4
	/XiPEcbOf3t2CwEzvJ21NTlrY9hst0sAccxoS/Q8rVkTUVfrouj4igUjfl0b1GIi4HuGo81DLB8
	m8=
X-Received: by 2002:a05:600c:8b85:b0:487:243f:dc3e with SMTP id 5b1f17b1804b1-48a77af3dcdmr39658525e9.6.1777371010611;
        Tue, 28 Apr 2026 03:10:10 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a775eb91dsm15268125e9.20.2026.04.28.03.10.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2026 03:10:10 -0700 (PDT)
Date: Tue, 28 Apr 2026 11:10:08 +0100
From: David Laight <david.laight.linux@gmail.com>
To: "Ard Biesheuvel" <ardb@kernel.org>
Cc: "Eric Biggers" <ebiggers@kernel.org>, netdev@vger.kernel.org,
 linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org, "Eric Dumazet"
 <edumazet@google.com>, "Neal Cardwell" <ncardwell@google.com>, "Kuniyuki
 Iwashima" <kuniyu@google.com>, "David S . Miller" <davem@davemloft.net>,
 "David Ahern" <dsahern@kernel.org>, "Jakub Kicinski" <kuba@kernel.org>,
 "Paolo Abeni" <pabeni@redhat.com>, "Simon Horman" <horms@kernel.org>,
 "Jason A . Donenfeld" <Jason@zx2c4.com>, "Herbert Xu"
 <herbert@gondor.apana.org.au>, "Dmitry Safonov" <0x7f454c46@gmail.com>
Subject: Re: [PATCH net-next v2 2/5] net/tcp-ao: Use crypto library API
 instead of crypto_ahash
Message-ID: <20260428111008.6ab7981b@pumpkin>
In-Reply-To: <bab8b5b6-6ee7-4e0b-9999-becf8f28ce71@app.fastmail.com>
References: <20260427172727.9310-1-ebiggers@kernel.org>
	<20260427172727.9310-3-ebiggers@kernel.org>
	<20260428022445.65e14a27@pumpkin>
	<bab8b5b6-6ee7-4e0b-9999-becf8f28ce71@app.fastmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 6B996482B5A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-281772-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,google.com,davemloft.net,redhat.com,zx2c4.com,gondor.apana.org.au,gmail.com];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

On Tue, 28 Apr 2026 08:34:47 +0200
"Ard Biesheuvel" <ardb@kernel.org> wrote:

> On Tue, 28 Apr 2026, at 03:24, David Laight wrote:
> > On Mon, 27 Apr 2026 10:27:24 -0700
> > Eric Biggers <ebiggers@kernel.org> wrote:
> >  
> >> Currently the kernel's TCP-AO implementation does the MAC and KDF
> >> computations using the crypto_ahash API.  This API is inefficient and
> >> difficult to use, and it has required extensive workarounds in the form
> >> of per-CPU preallocated objects (tcp_sigpool) to work at all.
> >> 
> >> Let's use lib/crypto/ instead.  This means switching to straightforward
> >> stack-allocated structures, virtually addressed buffers, and direct
> >> function calls.  It also means removing quite a bit of error handling.
> >> This makes TCP-AO quite a bit faster.
> >> 
> >> This also enables many additional cleanups, which later commits will
> >> handle: removing tcp-sigpool, removing support for crypto_tfm cloning,
> >> removing more error handling, and replacing more dynamically-allocated
> >> buffers with stack buffers based on the now-statically-known limits.
> >> 
> >> Reviewed-by: Ard Biesheuvel <ardb@kernel.org>
> >> Signed-off-by: Eric Biggers <ebiggers@kernel.org>  
> > ...  
> >> @@ -344,33 +444,26 @@ static int tcp_v4_ao_calc_key(struct tcp_ao_key *mkt, u8 *key,
> >>  	struct kdf_input_block {
> >>  		u8                      counter;
> >>  		u8                      label[6];
> >>  		struct tcp4_ao_context	ctx;
> >>  		__be16                  outlen;
> >> -	} __packed * tmp;  
> >
> > That looks a bit horrid.
> > I also had a feeling that the compiler sometimes rejects non-packed structures
> > inside packed ones.
> > Perhaps nest the whole thing inside another structure that has an initial
> > u8 pad and is marked __packed __aligned(4).
> > Then the assignments to the fields of 'ctx' will be known to be aligned
> > even when tcp4_ao_context is also __packed.
> >  
> 
> Agree with Eric that this has no bearing on this patch,

true - just the in the same code.

> but I'm not sure
> I see the problem here. 'ctx' will not be packed, and appear misaligned
> in struct kdf_input_block, but that would only matter if the address of
> the ctx field were taken and passed to a function taking a pointer to
> struct tcp4_ao_context (which would expect it to appear naturally
> aligned).
> 
> Having a feeling about what the compiler sometimes rejects is not
> actionable feedback - could you be more specific about which problem
> you think needs to be solved here? Are you concerned about unaligned
> accesses when populating the struct?

(It was 2am and the side effects of a cold were stopping me sleeping...)

I tend to double-check __packed because it gets misused in places
where you really want the compiler to error implicit padding rather
than generate expensive misaligned access code.

But I am sure I remember some build warning that needed __packed added
to the definition of a structure embedded in a __packed structure.
I don't think it was only the arm OABI (which pads structures to 2 bytes).
Historically this has never mattered (even the 'address of packed member'
error is moderately recent - well sometime in the last 20 years).

In this case (and the ipv6 code) 'struct tcp4_ao_context' can just be
marked __packed.
Or, since this is the only place it is used, possibly just inlined
into 'struct kdf_input_block' - which may not even need to be named.

	David




