Return-Path: <netdev+bounces-295315-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id iyurOmikIWoEKgEAu9opvQ
	(envelope-from <netdev+bounces-295315-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 18:14:32 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E5DB3641BD3
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 18:14:31 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux-foundation.org header.s=google header.b=SdrJyF1R;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295315-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-295315-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 8A56E30260BD
	for <lists+netdev@lfdr.de>; Thu,  4 Jun 2026 15:58:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC567399019;
	Thu,  4 Jun 2026 15:58:54 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AA282F7F08
	for <netdev@vger.kernel.org>; Thu,  4 Jun 2026 15:58:52 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780588734; cv=none; b=lx4ssfYqulpNzR7eMlKAmIaGejOknnlpr3YJrhnWk6thQa5bC+jPooVOwVEqFQQ3pDZbA9HNBMFdl6uMxa88drkJ21GKwMgeXGJBQD27AlepLuFcvhRgkiw7ymCQVgNsdvZphrPsAgbwQTszcYfesEX9FYiHwbML+XjtjbrA6kk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780588734; c=relaxed/simple;
	bh=7s0rKR9scvgD84QvTOBiJiUg2JjvF9nGtFbIGJxaif4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t5VAZou9/cfVQnrG4OfRoAxTA+JvHxqM8n3RBX0aRu/4NonOIkEZvTmitqDSWJV7y4iA9wkkc4G78dwjFLLtgtmAFdGJ/lF3B7m8GQcUCYxurWVpJqbxq7hTEjrQPkkAYtppsKcoEUPes6yapKUVbKxaOsrUGxUmtZdJsuZewqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=SdrJyF1R; arc=none smtp.client-ip=209.85.208.51
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-68d23430690so1759740a12.3
        for <netdev@vger.kernel.org>; Thu, 04 Jun 2026 08:58:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1780588731; x=1781193531; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=7+wqPGUkYgYLzLpNrBl5F+HLbRSqQcg4ZruoWvmFRPs=;
        b=SdrJyF1RHjWLUyuMT6WLM4SY9mN0srEwT2jTA8p8Z3NxOGc7WHHWJqz0KJdGNOfRxs
         RH9zmQ72sTy1XGwm3R448CQzYJO6tUMvQAry/NKYh52CLwwfg+HtrLBKtqGOGzfU74vK
         TfEv+DaQMUj7/yTJ2BVwtpZ90/xk2At7+kRRs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780588731; x=1781193531;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7+wqPGUkYgYLzLpNrBl5F+HLbRSqQcg4ZruoWvmFRPs=;
        b=Yy5JIa6RVqZWz8lsfZqWLm/Qv55c80xkWe2HczxIN3WVd6KEvUyGpnqkTlagn5PWnM
         FIXeH648ki5+GWtWWg+2gP1XFRwhlSkPKLbOYSc0l7Rfgr2OHx2KhlKMQhzQviASRVms
         RTziT3z6CnoTZFEGqavw7C55iTY9wdnu0PagFrrq0xfsM3Ctlyf+5+xN2ChYUPpyF9M5
         zkIi/AbGzB7wpdvTIUJBsLGfgywN6z0IlbERtNZUm0IvvqgLGhUgYLOG/0JHItI9LtoM
         EhXPQOGaOwmdKHm9vSaIyp1plLog6+XM6ivvmBYHAYDZucz1ahkSji5OUflH5Xpc0DmD
         bg7A==
X-Forwarded-Encrypted: i=1; AFNElJ+rXAMVv7NT22UNQBBPHsmqjjlotQ9bM1DFLBEUXQL2GS5sQ7GfBTeiM4DMa1f81sFNvWdklXA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxzWnyRa+HUysRY7J2wBeiqT91IzsfGWIYdsZZ/juvICzPtM01t
	wo3moVyRC6L6Eckl7uigwKLXRE/3GAkBMGooFr/WpIGbX4VMAzVorb069i7vXcCQs47ZcceYlKq
	TG77UJCax4Q==
X-Gm-Gg: Acq92OEpuu7FGMFubg7gnxsxQ+a3gteh4aiJOAhjAW68Kdvj+FY3ZR0EmZgHBzV1OJv
	FDhICqT+FXsCBFkc/WnVdZa1YcKRBxxR/3qUed5a77Vn9qAWfEDSSH/xJ713FnDRY6spdrmWFnF
	wEzRMtKXzNwU7SIgtFawHeWKlScb2G+YaJ6hB0m6UySMrtTUq6n63k6hgPl0zXM01VjxqO+P8MQ
	faSQckE/lA2/v4JWQIJAARRmEMnSULGBiN6obqNiztXw/T25FO0R8pmvFXYjSqnAsySJXxXHpHz
	Ydy8Z3gE1AQFnolOW3fUYZX8jNaXnGa69XcdgaxdjlXZn0L4I1/Yre0J9FpGCFRKtdhJQ9hPlbx
	Xw4NhDw5RPvquzHNV/BaA15EkS3Ws7UMYC1U/oY0wzZYwAjAcT0Ublgi+N/n78VT6Hh6JNrC52+
	E8LV/v6da0vvDj5UANdkvdi2yXzlv8itYa9wPp67qnuZzODB/QraiRynIGWEyED2Z5RlS58qbeR
	QttHu+E3gb4aoVGoL8dQA==
X-Received: by 2002:a05:6402:388b:b0:68e:4c0:f5b5 with SMTP id 4fb4d7f45d1cf-68e70ce90demr4467136a12.13.1780588731403;
        Thu, 04 Jun 2026 08:58:51 -0700 (PDT)
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com. [209.85.208.41])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-68e6595c722sm2651976a12.22.2026.06.04.08.58.50
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Jun 2026 08:58:51 -0700 (PDT)
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-68d23430690so1759692a12.3
        for <netdev@vger.kernel.org>; Thu, 04 Jun 2026 08:58:50 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ8BndbI+K35Dp0ozD53NkylCNPu15tmapHgYAaTwai0dQUaVlpDDqYpghweYwLXQ1xDo9hdxhI=@vger.kernel.org
X-Received: by 2002:a05:6402:268d:b0:68d:235a:cdaf with SMTP id
 4fb4d7f45d1cf-68e6e447981mr4450863a12.5.1780588730255; Thu, 04 Jun 2026
 08:58:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260531010107.1953702-1-safinaskar@gmail.com>
 <20260601-enthusiasmus-canceln-anlehnen-0e62317a9784@brauner>
 <CAHk-=wifX_rrDjRGnDnOqE-usptAukuXKrmuPuVDP5bOCBWzGQ@mail.gmail.com>
 <20260601173325.GH2636677@ZenIV> <20260601160455.2c187574@gandalf.local.home>
 <20260601172825.a51a588ec1c32617a0e12d78@linux-foundation.org>
 <aiEb8CTM-ovMIq7-@1wt.eu> <CAHk-=wiQB-j53cTs9kM4UeXoXPaFj78aJe3D6Yp1Fohg7i4tWA@mail.gmail.com>
 <aiGfgRch99l_5z11@1wt.eu>
In-Reply-To: <aiGfgRch99l_5z11@1wt.eu>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 4 Jun 2026 08:58:33 -0700
X-Gmail-Original-Message-ID: <CAHk-=wg0e8pP5haNW4qJP1=QwwUEctwjK5k07sv8bskitoMDgg@mail.gmail.com>
X-Gm-Features: AVVi8Cfm3XRgcYqAOfqktIkPjsqV4jnNlBPsed_wU8pvtWHjKA_FxUEOuJC1FXo
Message-ID: <CAHk-=wg0e8pP5haNW4qJP1=QwwUEctwjK5k07sv8bskitoMDgg@mail.gmail.com>
Subject: Re: [PATCH 0/3] vmsplice: make vmsplice a trivial wrapper for preadv2/pwritev2
To: Willy Tarreau <w@1wt.eu>
Cc: Andrew Morton <akpm@linux-foundation.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Al Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, 
	Askar Safin <safinaskar@gmail.com>, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-api@vger.kernel.org, netdev@vger.kernel.org, 
	Matthew Wilcox <willy@infradead.org>, Jens Axboe <axboe@kernel.dk>, 
	Christoph Hellwig <hch@infradead.org>, David Howells <dhowells@redhat.com>, 
	David Hildenbrand <david@kernel.org>, Pedro Falcato <pfalcato@suse.de>, Miklos Szeredi <miklos@szeredi.hu>, 
	patches@lists.linux.dev, linux-fsdevel@vger.kernel.org, 
	Jan Kara <jack@suse.cz>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[linux-foundation.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-295315-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:w@1wt.eu,m:akpm@linux-foundation.org,m:rostedt@goodmis.org,m:viro@zeniv.linux.org.uk,m:brauner@kernel.org,m:safinaskar@gmail.com,m:linux-kernel@vger.kernel.org,m:linux-mm@kvack.org,m:linux-api@vger.kernel.org,m:netdev@vger.kernel.org,m:willy@infradead.org,m:axboe@kernel.dk,m:hch@infradead.org,m:dhowells@redhat.com,m:david@kernel.org,m:pfalcato@suse.de,m:miklos@szeredi.hu,m:patches@lists.linux.dev,m:linux-fsdevel@vger.kernel.org,m:jack@suse.cz,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[linux-foundation.org];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[torvalds@linux-foundation.org,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[20];
	FREEMAIL_CC(0.00)[linux-foundation.org,goodmis.org,zeniv.linux.org.uk,kernel.org,gmail.com,vger.kernel.org,kvack.org,infradead.org,kernel.dk,redhat.com,suse.de,szeredi.hu,lists.linux.dev,suse.cz];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[1wt.eu:email,mail.gmail.com:mid,vger.kernel.org:from_smtp,linux-foundation.org:from_mime,linux-foundation.org:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E5DB3641BD3

On Thu, 4 Jun 2026 at 08:53, Willy Tarreau <w@1wt.eu> wrote:
>
> > It looks like you're actually doing exactly the thing that I thought
> > was crazy and wouldn't even work reliably: you change the
> > common_response[] contents dynamically *after* the vmsplice, and
> > depend on the fact that changing it in user space changes the buffer
> > in the pipe too.
>
> No no, it's definitely not doing that (or it's a bug, but it's not
> supposed to happen). I'm perfectly aware that one must definitely not
> do that, and it's a guarantee the user of vmsplice() must provide.

Whew, good.

In that case, can you just try the vmsplice patch series (Christian
already found a bug, but I don't think it will necessarily matter in
practice - famous last words) and that test patch of mine, and see if
it all (a) works for you and (b) if you have any numbers for
performance that would be *great*.

There aren't many obvious splice users out there, and even if they
were to exist they are typically specialized enough that you have to
have a real use case to then tell if the patches make a difference in
real life or not.

So you testing that thing would seem to be a great first test of
whether any of this is realistic..

               Linus

