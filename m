Return-Path: <netdev+bounces-294901-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id H6mEKMuHIGoG4wAAu9opvQ
	(envelope-from <netdev+bounces-294901-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 22:00:11 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DB9FA63B075
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 22:00:10 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux-foundation.org header.s=google header.b=E5WQL0eE;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-294901-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-294901-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 93922301E6C2
	for <lists+netdev@lfdr.de>; Wed,  3 Jun 2026 20:00:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 258803A6412;
	Wed,  3 Jun 2026 20:00:03 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E9583A5E99
	for <netdev@vger.kernel.org>; Wed,  3 Jun 2026 20:00:00 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780516803; cv=none; b=gYfHQrPdJ/2Xt7bikul/qzU5cneAAPudGpid5qF4vwOUBtsDXmN+qZhfhkcKjLQ/dhWip5aKh/gT1C8SbOK/ga97dgsEfsgNpm1GU2emt4mvUuExJ6/WIFck/H4aiVu7urXxKNJ3PsBCK99BOhmXu4p8EJ9juFnl7F1klxc4AHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780516803; c=relaxed/simple;
	bh=cJCdMggMBtlaRufFOzf56NF2SmvXVse1UnTO+KmUUY8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JYjrhXyW6Bc+t8cUhVW2Ug8pwu9mfNIAFpH2vtnlXSE1i/EtV+p4SBBZqEYFjaDJDZKLqMd6E35KGZvLrxKMchvdOMVOU9p9th0IW1RkFgZv5cPAF7cxibqMkvxKTfyY1b9wlBKqpMeunUL5sTOB0yKHSvl4GK1FZNQ7Ra5PGrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=E5WQL0eE; arc=none smtp.client-ip=209.85.216.44
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-36b95eb4bb4so3397501a91.3
        for <netdev@vger.kernel.org>; Wed, 03 Jun 2026 13:00:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1780516800; x=1781121600; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=rLwU6+VwyCgHprpb82bpoZ1vCU00viaTeQ4mjhQKQr0=;
        b=E5WQL0eE5SCkORdDgmaH/6yh0Q+bkb2AAXJDvh0D9Qt3t3+ma6m0+1u9F2rEHJVllH
         udnnnxaDFUrroLqW14J517iMyS1wSC4j3ZPETGbQkkkkzIh6FzQyDfxqMojqgmNnFHeA
         r4172xi+9r/CMdbECOO1j4unC9zKjDm9l3DzE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780516800; x=1781121600;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rLwU6+VwyCgHprpb82bpoZ1vCU00viaTeQ4mjhQKQr0=;
        b=sja+hkm900N4Ric8Mdrh8CQzwkvmPoBfIrcXnBiVrccQZNV7CngF6fYSZ9vTAsrnCE
         eTF4n1vWAEv5mAn3sOMt7zqhTxezUkVpTo+jpyqB4s/wIzh4PrTOFfjdVuDg7WnA2fMm
         eRDLNkREB7PO8k6fY3Ji3gsvzvsEtxjugy6ZbmW0joDdd9iy5nca8gnhBf6pTVgfeCyO
         f9JpKC6MlMVH2/knwIctY83gSKYrYtt6KApRfK+Oasv0+JWNr2bcHbFoRSIs86IOmCu9
         kixIrP28B/J15UNTDBCrkV5kYu6s97gXFamyjanGCf/pYXbhvp1GnG2yMPiI0Ioyd4On
         tLTA==
X-Forwarded-Encrypted: i=1; AFNElJ8wTROTkxMC9vGMkvuWSqTW/2WhJAHLr38Di3posD++CFgrzJvpfeGcxEiiYCfIVs2yHjOszjA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzjrYC67G5eClk5rv/k596eUr7UPXOGojD35XKKpXysWTJ4UZiD
	s68FsmM1Ox4ty59O039K6OIJNvzaUc8EBQNzsh6S7dHD9UA9Cv8PeRinCDcmzhEcr6BDaJLwjZc
	ij3lal7GtwQ==
X-Gm-Gg: Acq92OFogCYBrOcR99/QuBARNOkcXHDIrIcJZ8giJevRr6oYUvZHuMrS1sX1xCosoYA
	ZV2RlIi0fm7g3sLMjVYR4Qs4ajhmRmBQn5xApPOakt10h6euf9E/1zoPnl1rQO4qK5UQANQGpbG
	aw+FFuNHDdlwkiskWdXcO8sdpOiFRrwGHB6c/V8z6+7G06JUwW9By6CNJ8OTcmRJYIL1fTYx1dA
	Psq38nekplDyICkowKEGJQ8SAoWIwdBo++BnOudXaJukcNc2EEOu41/cr0rkHldW6atPcEbue43
	op5jkDQG1d8NJvaOtvQTwwuYiPoT/WDnj0E0gS8Cm98JhZQ+MwxPGUyLRLqulnpiI+yBM2qYBpl
	W7aDc6qjidmwUbGrhu+lJapr/7wD7xmsbWoHj4zqxNAR2/54RZnej0I+1yL6KFxNf24/fqcwuW/
	LxpD/nwzTxDFGV27W6gnT6dbmHlnLLBTlYIlICoaOGT+aZ42cEaKoKNCHlGtiPLhT3y003DDPSM
	G7qBv9D57s=
X-Received: by 2002:a17:902:ecc8:b0:2c0:cea4:3df4 with SMTP id d9443c01a7336-2c1644cb12bmr48064515ad.40.1780516800175;
        Wed, 03 Jun 2026 13:00:00 -0700 (PDT)
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com. [209.85.216.44])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c1664950aesm31788165ad.69.2026.06.03.12.59.58
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Jun 2026 12:59:58 -0700 (PDT)
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-36babe2c4bdso3878720a91.1
        for <netdev@vger.kernel.org>; Wed, 03 Jun 2026 12:59:58 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ9KDN+YzfrAcYSOqgaAbEd03FmY5Zg2p9Wp98POC4PuNg463gvpC1EsepV/29aLc5DYx0WmaXA=@vger.kernel.org
X-Received: by 2002:a17:90b:2f86:b0:36b:77b9:5c8c with SMTP id
 98e67ed59e1d1-36e3237e125mr4484034a91.17.1780516797989; Wed, 03 Jun 2026
 12:59:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHk-=wiAqf0PdZ4AKj_4riUnnEb=g_ZNPkLnXrByA9BBHYiFRg@mail.gmail.com>
 <20260602225426.122258-1-safinaskar@gmail.com> <CAHk-=wgKy4dP0oQCNKyMQQf3-uVpaigmDyH6_T0Via76gWST9g@mail.gmail.com>
 <CALCETrWx8-Q5-rK1KnAPCxCbXaWCd=Yfs_Pr8qVMa8k8L6of1w@mail.gmail.com>
 <CAHk-=wizkDXRut5xLXRF-CVUVYMaZ5AOexxeghOAoXPb4yAvQg@mail.gmail.com>
 <CALCETrXzxubt4eWue3+wv7Fq9C2m7uu6bWPstqFh6Mo57bPwQQ@mail.gmail.com> <CAHk-=wiEwSjfbjfO74xu=UmkkdHXkJg5QNQ8pP-3iYmunmeV9g@mail.gmail.com>
In-Reply-To: <CAHk-=wiEwSjfbjfO74xu=UmkkdHXkJg5QNQ8pP-3iYmunmeV9g@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 3 Jun 2026 12:59:36 -0700
X-Gmail-Original-Message-ID: <CAHk-=whkGbMoP-Dym8pAd3hV21=BZST+6sK++1X038+9Q-TgeA@mail.gmail.com>
X-Gm-Features: AVHnY4Jw9pwWVUIawcRWYEJbSOr_4eFJHRjDI61fxjs_qgnMfY70yBDODQXhxd4
Message-ID: <CAHk-=whkGbMoP-Dym8pAd3hV21=BZST+6sK++1X038+9Q-TgeA@mail.gmail.com>
Subject: Re: [PATCH 0/3] vmsplice: make vmsplice a trivial wrapper for preadv2/pwritev2
To: Andy Lutomirski <luto@amacapital.net>
Cc: Askar Safin <safinaskar@gmail.com>, akpm@linux-foundation.org, axboe@kernel.dk, 
	brauner@kernel.org, david@kernel.org, dhowells@redhat.com, hch@infradead.org, 
	jack@suse.cz, linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, miklos@szeredi.hu, 
	netdev@vger.kernel.org, patches@lists.linux.dev, pfalcato@suse.de, 
	viro@zeniv.linux.org.uk, willy@infradead.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[linux-foundation.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-294901-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:luto@amacapital.net,m:safinaskar@gmail.com,m:akpm@linux-foundation.org,m:axboe@kernel.dk,m:brauner@kernel.org,m:david@kernel.org,m:dhowells@redhat.com,m:hch@infradead.org,m:jack@suse.cz,m:linux-api@vger.kernel.org,m:linux-fsdevel@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-mm@kvack.org,m:miklos@szeredi.hu,m:netdev@vger.kernel.org,m:patches@lists.linux.dev,m:pfalcato@suse.de,m:viro@zeniv.linux.org.uk,m:willy@infradead.org,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[linux-foundation.org];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[torvalds@linux-foundation.org,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[19];
	FREEMAIL_CC(0.00)[gmail.com,linux-foundation.org,kernel.dk,kernel.org,redhat.com,infradead.org,suse.cz,vger.kernel.org,kvack.org,szeredi.hu,lists.linux.dev,suse.de,zeniv.linux.org.uk];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,mail.gmail.com:mid,vger.kernel.org:from_smtp,linux-foundation.org:dkim,linux-foundation.org:from_mime,linux-foundation.org:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: DB9FA63B075

On Wed, 3 Jun 2026 at 11:28, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> But even then you need to have a *handle* to the buffers for the
> general case, and that's what the pipe fd ends up then still
> effectively being.

Again: for sendfile, you don't need the handle, because you can just
"read the file data again".

But the the handle is needed for any buffering that can't do that -
iow pretty much *any* other case than a file-backed source.

So the original use-cases included things like copying media data from
a TV capture card to a GPU for outputting in a window.

There it's actually the intermediate buffer that is the important
thing, and it needs to have a lifetime that is independent of the
system call itself, because the system call may be interrupted by
signals etc, and you can't just "read the data again" when you
restart.

So the whole idea with splice() is that you have an input, an output,
and a stateful buffer between the two that has a lifetime.

Having just a iov_iter isn't enough - even with the current much more
capable iov_iter we have now (compared to when splice came to be: two
decades ago when the modern iov_iter didn't even exist). You have to
have that notion of a buffer with a lifetime.

(iov_iter came a couple of years later, but it then took many many
years for it to become the powerful thing it is today where you can
put almost arbitrary data into it - it started as purely a user space
iovec iterator, all the bvec/kvec etc stuff that you need for IO
buffering came a decade later)

So there's historical reasons for the use of pipes, but there really
is a very fundamental reason for it too: wanting to *generic* data
transfer between two points, not sendfile.

It's worth noticing that in the generic case, zero-copy isn't really
even an issue.

When you think operations like "splice TV capture input to a pipe",
you typically need to allocate the pages that you then DMA into
*anyway*, and you'd just put those pages into the pipe. And the facty
that you can then just take the data directly from those pages when
you splice from the pipe to whatever GPU engine that does the decoding
is kind of secondary.

So again: the big deal with splice() and the pipe isn't really about
zero-copy. It's the in-kernel buffers where the drivers control the
allocation and you don't have some "user space allocates memory, then
kernel looks that allocation up and uses it" model.

Having less copies is kind of incidental. It *might* happen just
because it's natural when some streaming device just gives it data
away and doesn't care after the fact.

The problem with splicing from a file has been exactly the fact that
it's *not* streaming data, and the filesystem zero-copy case gave
direct access to the long-term cache.

Which is undoubtedly good for performance. But it fundamentally
*requires* that the sink is trustworthy. Which has been problematic.

That's why sendfile() is bad. Not because splice itself is a bad
concept, but because you have to have that absolute trust across
components.

          Linus

