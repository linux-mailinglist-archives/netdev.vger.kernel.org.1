Return-Path: <netdev+bounces-294443-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 5r5YDgpUH2pjkgAAu9opvQ
	(envelope-from <netdev+bounces-294443-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 00:07:06 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C1578632573
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 00:07:05 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux-foundation.org header.s=google header.b=TD7K6R3m;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-294443-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-294443-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 939F23045DF3
	for <lists+netdev@lfdr.de>; Tue,  2 Jun 2026 22:06:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3F8F390239;
	Tue,  2 Jun 2026 22:06:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52529383985
	for <netdev@vger.kernel.org>; Tue,  2 Jun 2026 22:06:26 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780437987; cv=none; b=ATL1Eq8LGBO+TKSJM64+RnT2xNpdoYvXJsuc/PbCKIToOsxdimuVFLnfLgtF7zRBbPlYONrDp0EtcTEvU+2bj1f6FslmavUAb1XAKZyuKLTSuu9+mFPi0hRQawVsyrbutXcdS+tZRfqnoRlpSdlMD1n9p/QEu6/GiS7MILpUf24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780437987; c=relaxed/simple;
	bh=ggdn1Kxplzazv5OLdinIKnlry9LYLtLaNuo30kwvE0w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qsiPFDnLGkVrDmDuN5kiuaXkH/xQaoX5HKrzv8kWOUPOb4qZy/28u/Nvw6D2TMqsYli7egdTdgaEY9x0IP6jfziZyfqQDxEoKvU+r33aL0a3BY4MrvPSC+nXs1Jey23w56k74QgNqmhJ2/9VxlFjvu5beuB88EKA82uJ6tibcq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=TD7K6R3m; arc=none smtp.client-ip=209.85.208.45
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-68d233bf083so4916399a12.1
        for <netdev@vger.kernel.org>; Tue, 02 Jun 2026 15:06:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1780437985; x=1781042785; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Qw8RVcymrwPdvtyZ+lyACgxH7IqaYDBeV32TfvS6Ats=;
        b=TD7K6R3mVShUzuw/noiYiD15mOuL0n9iLaV6TusZsLMtB+TG6TMB9qyQBIxtbz0LyO
         DUFK/lCQ1FsU4ucVIc4cN30qSyjB/xc6qIp7fD2zGe/rs1SoCijiSW6ZEzLFrWYVCTM9
         /j76CO/QqC4kPT4oIElHeqqIFhjDkoMU9DeCI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780437985; x=1781042785;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qw8RVcymrwPdvtyZ+lyACgxH7IqaYDBeV32TfvS6Ats=;
        b=KpWCeWqcySfCenaU/P487Hb+2fpPD1LEgJZT99cAPRFiq0j5Fe4TfOHyVYRB3fh/GC
         7R4NlMqG2NfDZjfplxiu61SxYw8ZzOQ4iotL2eF0yZHPCanXOW2DJpuFKthTYx2I/3uD
         a3dVhI+WT5n1ICYjk6goPhn9+OqpCk/q4BBBp67xLJHfxje7PZ2J1i20dhRkEjJo/1Da
         E9/KF9FnQO1NresBv950WBeVC8NBW9K8TJPgeXj6Hs6QupWMBm08kffKFnOEEv9595fG
         hpn5n364DoI3g3oqI0Ay9SzoZXh4jbJ93SNKjdjEyJvmPSE87UahW5xkxOTpMFuQS5ys
         ZPew==
X-Forwarded-Encrypted: i=1; AFNElJ/Zv7tQ3dVl7IrPJiolh9U8B/avtnEm2xWjgoHrViOz3Jv54GDPR1ZWWnpSSigUzXfoov1ndzE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJx6q6SnnrboLm1LbJnVN8048QUG+OKJsftuT7Nda+pxYgyK2e
	ycYE4fFNcJHS3QPd6szuv47tzvUkeilIjBHAVDUqi+HALorj1Q7n572KRZuMmzy91fkj8THT0Kd
	Jg24DAig=
X-Gm-Gg: Acq92OFq9SvcpTJQIP2IIfw/ZIu/ryRlpX7gshV4pOkoJKgcdaqP2fnA3n87crokjnf
	LPiodPGMVpBxrpjOiN3Y3jMjJaQ3eN/zeeq49MT6vNavUtSieOiRa+8775FYli7JUG8cdzwHaZt
	X0Pn5UoiV4lpa3AoDP20ZXvptxiHRTJIrnf+1ut3SbbLrCEFHno7HrBLLO7lh8uSY7vMyaldWvh
	iGSsvf2F527I+XaksZFeMcL0vPmbcfcZ6CQKiQFjM4P0SfvEP6hA9i5BLyaoGDEX1fe5jhfV7pA
	LhvOSyQ/IVpVYhTvaunvC8b/IIkv7zdo+rKrgcx/uJ65/m9dLjP2D0YzGzsiZ/UQQPt/ajYFfFy
	lAsEQYGUo4M5/q5MkcO1Isvi+pRR/vPx0LYQ8PO5qEmkynqnzq94qEGV//15UkDoOFV2466m56H
	zefeyKKOxCeKgy/pS3jKDCml9cEH4OpXKv5PkBQ3TCpRp+qe9GcHwwmNWQT86UNUlYlVgzavKAB
	0SL6OrWEk0=
X-Received: by 2002:a17:907:3d44:b0:bee:19d0:db92 with SMTP id a640c23a62f3a-bf0afcf815fmr14983966b.49.1780437984820;
        Tue, 02 Jun 2026 15:06:24 -0700 (PDT)
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com. [209.85.218.48])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-68e65c542c7sm220617a12.31.2026.06.02.15.06.23
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Jun 2026 15:06:24 -0700 (PDT)
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-bec405a6ea5so484580766b.0
        for <netdev@vger.kernel.org>; Tue, 02 Jun 2026 15:06:23 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ+F6yKlM1JobrTvfLjcGMUlyw+ourRCpq0WclbJ2m1XJm90ilMwFpzWqp1PbD+vfCr284zsP0s=@vger.kernel.org
X-Received: by 2002:a17:907:3f19:b0:bed:62c1:f7 with SMTP id
 a640c23a62f3a-bf0ad9ebf64mr15174966b.20.1780437983314; Tue, 02 Jun 2026
 15:06:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ahv16ogY8Zx3Rtox@pedro-suse.lan> <20260602211242.13870-1-safinaskar@gmail.com>
 <ah9LaPQayJ6tBE53@pedro-suse.lan>
In-Reply-To: <ah9LaPQayJ6tBE53@pedro-suse.lan>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 2 Jun 2026 15:06:07 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiAqf0PdZ4AKj_4riUnnEb=g_ZNPkLnXrByA9BBHYiFRg@mail.gmail.com>
X-Gm-Features: AVHnY4La_ZzADdnhLw7VXJvUOP1cc6TzuLIwNWiX_o8vXHDUu8ML9nZoEC5oxec
Message-ID: <CAHk-=wiAqf0PdZ4AKj_4riUnnEb=g_ZNPkLnXrByA9BBHYiFRg@mail.gmail.com>
Subject: Re: [PATCH 0/3] vmsplice: make vmsplice a trivial wrapper for preadv2/pwritev2
To: Pedro Falcato <pfalcato@suse.de>
Cc: Askar Safin <safinaskar@gmail.com>, akpm@linux-foundation.org, axboe@kernel.dk, 
	brauner@kernel.org, david@kernel.org, dhowells@redhat.com, hch@infradead.org, 
	jack@suse.cz, linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, miklos@szeredi.hu, 
	netdev@vger.kernel.org, patches@lists.linux.dev, viro@zeniv.linux.org.uk, 
	willy@infradead.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linux-foundation.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-294443-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:pfalcato@suse.de,m:safinaskar@gmail.com,m:akpm@linux-foundation.org,m:axboe@kernel.dk,m:brauner@kernel.org,m:david@kernel.org,m:dhowells@redhat.com,m:hch@infradead.org,m:jack@suse.cz,m:linux-api@vger.kernel.org,m:linux-fsdevel@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-mm@kvack.org,m:miklos@szeredi.hu,m:netdev@vger.kernel.org,m:patches@lists.linux.dev,m:viro@zeniv.linux.org.uk,m:willy@infradead.org,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[linux-foundation.org];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[torvalds@linux-foundation.org,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[18];
	FREEMAIL_CC(0.00)[gmail.com,linux-foundation.org,kernel.dk,kernel.org,redhat.com,infradead.org,suse.cz,vger.kernel.org,kvack.org,szeredi.hu,lists.linux.dev,zeniv.linux.org.uk];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[linux-foundation.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[torvalds@linux-foundation.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,suse.de:email,vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C1578632573

On Tue, 2 Jun 2026 at 14:37, Pedro Falcato <pfalcato@suse.de> wrote:
>
> Well, that's most definitely part of my patch. Also, you cannot outright
> remove splice() functionality

That isn't what Askar's patch ever did.

You apparently didn't even read it.

Honestly, I think you are the one out of line here.

Askar did something I suggested years ago, and didn't remove any functionality.

It just changes vmsplice to be a copying model (one of the directions
already was). It doesn't change regular splice at all.

And yes, it has the potential to be a visible behavior difference - if
some insane user uses vmsplice and then modifies the buffer
*afterwards*, then that would be semantically different between a
zero-copy and a normal copy.

But that would be insane behavior, and was never really reliable
anyway even with zero-copy (ie subsequent writes to user space buffers
would potentially do COW breaking based purely on timing and memory
pressure etc, so anybody who relied on it being visible wasn't goign
to get it realiably anyway)

Perhaps more importantly, it has the potential to change performance -
zero-copy *can* be a performance win, although typically it really
doesn't tend to be (looking up the page mapping is often slower than
copying).

I would expect it to be very clear in trivial benchmarks that aren't
actually real loads. And probably not visible anywhere else.

But your responses have been making it clear that you didn't seem to
actually look at the patch or the history of it.

Trying to make it look like Askar is the problem is only making you look worse.

Anyway, the vmsplice() thing is queued up in Christian's tree, and I
guess we'll see if anybody even notices anything.

              Linus

