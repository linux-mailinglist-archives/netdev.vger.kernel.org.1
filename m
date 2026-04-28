Return-Path: <netdev+bounces-282092-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QCV1Fuot8WleeQEAu9opvQ
	(envelope-from <netdev+bounces-282092-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 00:00:10 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A805048C6D6
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 00:00:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5E60A304138E
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 22:00:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E38B537104D;
	Tue, 28 Apr 2026 22:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AR7G9B7c"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48D192F99B8
	for <netdev@vger.kernel.org>; Tue, 28 Apr 2026 22:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777413607; cv=none; b=VMX6DJNU7zbVqMfXftVovILJ3hBWHl6vsvc1gwoYSaNEOZ8st3UBVCWcpUxhgCU8lbjBh8fmcyYai7a+1uu1Po5bjIRAfFfyETUu3LA/2Smb8yVVeZk8foQ7cA7/XNekA5/m0j+yGV2EGWW+K7U0QRR4ssXo2M7XzUh84B+ho0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777413607; c=relaxed/simple;
	bh=VoYzJaWRdp1h+CDLkJx1M+CFVba50lVH7z4SaaYxOGk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fBjRC6O7ty7HqRboWY8OsvzWTo3LNbDcjr1mzn+jIJ4FbOPoK0t7blx+Xae1drQ3YJU5XTCouAAnILtD02oZl3/yq6Qj5/gdee0e+MNDyNZeGKVxHSWbK2PdO+IuVMp854ROtHroDsRggoyf52YGc9nq6ZN0dviGonp9QLfx2Xk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AR7G9B7c; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-488ba840146so106724985e9.1
        for <netdev@vger.kernel.org>; Tue, 28 Apr 2026 15:00:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777413605; x=1778018405; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H+ir5t3PaX/DWkAs1o8I5rosOinQMQa+UnM53hyy14A=;
        b=AR7G9B7cFH9EnCAe8zDJRzT3h+sdPBRAnyzxhHYNZAD/h2oRWzYBBZoYp3uq/ZukQF
         YYX8TGfv6ktWoDpxR1qMYJNUgWK9ULN4onRZc5nc16Ns4615d1pGqr1qSClNxZ0ngqIn
         UuY9FgzOAXuJqQnHAqGhyBpB5U3XhGnNcMCJ0iYXpK1Mh7UHVmPZ4tbiyc3SkVndVuvP
         2VtLBoJAYH/aiKSeCyggsQVYbcO7KYf+5Y9WzxpgLtLSKOpJLCmxCZ4mORgMxqQFNFMX
         n6qO5GiV2e7RjSt1uiZC3yipXDLQ3XNzuwKGtBr9qpAtTlhvUQQ3GbK2TOwxtNQxNCRr
         pdQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777413605; x=1778018405;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=H+ir5t3PaX/DWkAs1o8I5rosOinQMQa+UnM53hyy14A=;
        b=PCiG6ZKyngKFEynokvret64gC6jmV6iHwjlkUZbtxpPkZjn6KZR35+NU5dhwIuSXfd
         ye1Kv3q0kseqbaFy8jgFRi9CSQmXt9PFqYZRRXxs+B51Yj1QKApQRtVlwjTVZyqqvh6M
         8+89o16WXo92VWYb5UV9VH7JjJ6KU5dbSfT901sp5GKKuRbSWfhqwdhFNgJNyhoylRPk
         zxG34FlR1EPKjNT5dH0HI+NPSS2vUtdyg+6OWMLcRas9jkETCa3AgcX63xV1PIc/qAKr
         wKR25xcGJvLdZ9L2Bit2ZYmZtycvUn82Qfj7V24XqtKFcEZQWpViPQ+tbjY+PwuT+M7N
         U12A==
X-Forwarded-Encrypted: i=1; AFNElJ+UK4G8Y6o9v8w2r8zPsf/DoDhdRbpHY+xN61Vo8231GsziOvCR0YIgm9a7Tszn9eNWAyvPcCk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8E7CY0hoz5Ej3flVyqqXOzuSt4lPUgCLGnhepIzAz+Shf52LY
	B4NUD7X4gpJob4Q+M4wsfKTlK5t6CXu8JTruF/ufrCdgWr6w+t+5zOuS
X-Gm-Gg: AeBDiev3gx2l1G4w8bqTL2za3i/rXbV8hwj1tdsCIHZoSY5Xuj3605oiEOrSVi69mPq
	vBaHazHXjKih9vPIrCXL9smTIpaCOpHdD5F4F6DC2t6r07xh/nnZcjp3RAQpRrKTr/6MdfH2IG5
	fO1YDIYroYjTuJAxtyBBviCgRusdln1TNI8Y2Ea6gdXWMi7FaLoLDeSz55GGMQEWz0DL3qqnwVo
	Aq/qLT9U1XK8JhOFJmH7jvEBIXYnW5Aubyts4xIeHDMqs7mwsCVMu6dydfLHeoRRDvntw9EUIlk
	+OiKcKE7hm/TU7ktQ3hLUcazMilaNQoKKwgKKgTsLvtd1KtqR1OTjavqigs5ZI7uWyOrTMzUR26
	hCpRic1IZ7gpOqldasugvtGDCpRqYLq7a/H5QptMSSjPGFXDit3tvhXiEACYJe+96S4EXdJa3v8
	SpT+yOTgkawKYhO4qWQVMfTKrqOvVM3Vw8wokLK3cUg0sjDYJc8OeyQRTesqJy5wrzLB3xNlXfT
	+48ExNMyBa+yQ==
X-Received: by 2002:a05:600c:1e28:b0:489:ecee:c4ef with SMTP id 5b1f17b1804b1-48a77b050dfmr75265055e9.13.1777413604277;
        Tue, 28 Apr 2026 15:00:04 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a7c310048sm3120025e9.22.2026.04.28.15.00.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2026 15:00:04 -0700 (PDT)
Date: Tue, 28 Apr 2026 23:00:02 +0100
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
Message-ID: <20260428230002.448bd8e7@pumpkin>
In-Reply-To: <97b79659-5fa1-4085-8c2b-3140fb663acc@app.fastmail.com>
References: <20260427172727.9310-1-ebiggers@kernel.org>
	<20260427172727.9310-3-ebiggers@kernel.org>
	<20260428022445.65e14a27@pumpkin>
	<bab8b5b6-6ee7-4e0b-9999-becf8f28ce71@app.fastmail.com>
	<20260428111008.6ab7981b@pumpkin>
	<97b79659-5fa1-4085-8c2b-3140fb663acc@app.fastmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: A805048C6D6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-282092-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[16];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,google.com,davemloft.net,redhat.com,zx2c4.com,gondor.apana.org.au,gmail.com];
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

On Tue, 28 Apr 2026 18:38:51 +0200
"Ard Biesheuvel" <ardb@kernel.org> wrote:

> On Tue, 28 Apr 2026, at 12:10, David Laight wrote:
> > On Tue, 28 Apr 2026 08:34:47 +0200
> > "Ard Biesheuvel" <ardb@kernel.org> wrote:
> >  
> >> On Tue, 28 Apr 2026, at 03:24, David Laight wrote:  
> >> > On Mon, 27 Apr 2026 10:27:24 -0700
> >> > Eric Biggers <ebiggers@kernel.org> wrote:
> >> >    
> >> >> Currently the kernel's TCP-AO implementation does the MAC and KDF
> >> >> computations using the crypto_ahash API.  This API is inefficient and
> >> >> difficult to use, and it has required extensive workarounds in the form
> >> >> of per-CPU preallocated objects (tcp_sigpool) to work at all.
> >> >> 
> >> >> Let's use lib/crypto/ instead.  This means switching to straightforward
> >> >> stack-allocated structures, virtually addressed buffers, and direct
> >> >> function calls.  It also means removing quite a bit of error handling.
> >> >> This makes TCP-AO quite a bit faster.
> >> >> 
> >> >> This also enables many additional cleanups, which later commits will
> >> >> handle: removing tcp-sigpool, removing support for crypto_tfm cloning,
> >> >> removing more error handling, and replacing more dynamically-allocated
> >> >> buffers with stack buffers based on the now-statically-known limits.
> >> >> 
> >> >> Reviewed-by: Ard Biesheuvel <ardb@kernel.org>
> >> >> Signed-off-by: Eric Biggers <ebiggers@kernel.org>    
> >> > ...    
> >> >> @@ -344,33 +444,26 @@ static int tcp_v4_ao_calc_key(struct tcp_ao_key *mkt, u8 *key,
> >> >>  	struct kdf_input_block {
> >> >>  		u8                      counter;
> >> >>  		u8                      label[6];
> >> >>  		struct tcp4_ao_context	ctx;
> >> >>  		__be16                  outlen;
> >> >> -	} __packed * tmp;    
> >> >
> >> > That looks a bit horrid.
> >> > I also had a feeling that the compiler sometimes rejects non-packed structures
> >> > inside packed ones.
> >> > Perhaps nest the whole thing inside another structure that has an initial
> >> > u8 pad and is marked __packed __aligned(4).
> >> > Then the assignments to the fields of 'ctx' will be known to be aligned
> >> > even when tcp4_ao_context is also __packed.
> >> >    
> >> 
> >> Agree with Eric that this has no bearing on this patch,  
> >
> > true - just the in the same code.
> >  
> >> but I'm not sure
> >> I see the problem here. 'ctx' will not be packed, and appear misaligned
> >> in struct kdf_input_block, but that would only matter if the address of
> >> the ctx field were taken and passed to a function taking a pointer to
> >> struct tcp4_ao_context (which would expect it to appear naturally
> >> aligned).
> >> 
> >> Having a feeling about what the compiler sometimes rejects is not
> >> actionable feedback - could you be more specific about which problem
> >> you think needs to be solved here? Are you concerned about unaligned
> >> accesses when populating the struct?  
> >
> > (It was 2am and the side effects of a cold were stopping me sleeping...)
> >
> > I tend to double-check __packed because it gets misused in places
> > where you really want the compiler to error implicit padding rather
> > than generate expensive misaligned access code.
> >
> > But I am sure I remember some build warning that needed __packed added
> > to the definition of a structure embedded in a __packed structure.
> > I don't think it was only the arm OABI (which pads structures to 2 bytes).
> > Historically this has never mattered (even the 'address of packed member'
> > error is moderately recent - well sometime in the last 20 years).
> >
> > In this case (and the ipv6 code) 'struct tcp4_ao_context' can just be
> > marked __packed.
> > Or, since this is the only place it is used, possibly just inlined
> > into 'struct kdf_input_block' - which may not even need to be named.
> >  
> 
> What would that achieve, exactly? You still haven't explained what is
> wrong with the code. Or are you really claiming that structs lacking
> the packed attribute are not permitted as fields in __packed structs?

My brain probably misfiled something :-(

	David

