Return-Path: <netdev+bounces-294816-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id NoRFL+NLIGop0gAAu9opvQ
	(envelope-from <netdev+bounces-294816-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 17:44:35 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 17AA06395BE
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 17:44:35 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux-foundation.org header.s=google header.b=GR5Ainrb;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-294816-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-294816-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BF49F31D34CD
	for <lists+netdev@lfdr.de>; Wed,  3 Jun 2026 15:29:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B16053D1716;
	Wed,  3 Jun 2026 15:27:04 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D9C0395ADB
	for <netdev@vger.kernel.org>; Wed,  3 Jun 2026 15:27:02 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780500424; cv=none; b=DA5zyesLp72KqooAvHmejzcfMXE3s2wshsgn9IlNzfia2yk9P0wVxbdDLichE30FtsksuITSe0T1c6w2o0yFZclV9Sjd50Y/TdP+KuZRWgGzZ9iK5O4g7SmM32necmJyF3MUjItpOZdXMWVzn4h1OpHOijNNCiiVa6VVG5MNLVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780500424; c=relaxed/simple;
	bh=5wR6ldRtC07oE2OfAwKn+DBv+oDO9pj5vEPnyj7TnCw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pFJVHwKvSoTiYTlLl5w/weEf0BIxR0fOGzsWrkEKH+e5QUxMTx6lj41A7Ygs9dVkHR5Ozx3HMIOjLKv54275G5zpAQbqFRxqmK00mbPldTFUK8CBINxW2WwPNBBjescl7UnJ5DIXHbDYLcsvdGNkIvZ8WNij6w+pN2MBkIHDriE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=GR5Ainrb; arc=none smtp.client-ip=209.85.208.45
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-68c5eecdd56so7470727a12.3
        for <netdev@vger.kernel.org>; Wed, 03 Jun 2026 08:27:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1780500421; x=1781105221; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=EdBrjWRKLAumno5vFkve2ATlSCQiBIWYVQeSXYhWLKg=;
        b=GR5AinrbEA1LdrzGwQjhSZHbnZjyn5PJPKLcC/i01LK16bSWM+GLNlHgxBkxSa6ILY
         KTkjft0Rk/vVp03hAP1oDhpiGkrIa8Xfv5lPQnQ+sTlLEK+AXY37iVDezKKTx57rqi4g
         n2Yya4Ck76D9l3cgW4fKBEdbDCtLSXt3ytzlY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780500421; x=1781105221;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EdBrjWRKLAumno5vFkve2ATlSCQiBIWYVQeSXYhWLKg=;
        b=Ey4vTDqWPOFwGTxvGHiYwdxPJLLE3RzgkICMbqekEXvZPQ1sl7liORSqNICrVdwDWV
         nTc5UkLzkn/Mcsij4HjFTDbWGFzH3DMO3V3wXanaOikxFZEcaJgVokjq0Z6omM9J6bv8
         kQFsWa36ocyZNSMuXz0QMaPqb46dGQp5HPSZr2XkmLG8/ByKzk9P9gK3aiexKJzRToz0
         vUJZKcIZPcbF5TLUTtuTV1Bc8rrmFxfFeUzUJcbvXO9/7yZkrKywejs7VPVMemrnhX13
         kR4VPgdkmBvXAmadRneVJSjGtlMyAuvb+t32EWwYAjK4PuZq21EUs1PSVgqYRca0r9A2
         AHAA==
X-Forwarded-Encrypted: i=1; AFNElJ9va1wz2bZSJj68gTrlMQTxAhI3dpy3CYyoN47n2suwlREjwtBoKJ3J6JmoMYIzioJGKdcWx2o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzp9sQXg6t7S9F3CWQB03X1haojQvMjHySFSkiKuSFBQ7h8uYuu
	nTAe5ByOGNdNpwbJk2cVEjSILIkvJIzxLMCVB4mYGZcU2w6pxI+kEjXLn/7wsuuOsWRJiqF5w8S
	ForURRTT0vg==
X-Gm-Gg: Acq92OHCrlZVCGSeyCdPeFCQZ/thp7/NZy98hIxXUG4R7cVvXnAG6e0LKa+fZtltW8Z
	mqQ2cWoG9TjsdzYO5cz8a26hx9ndss3FLz7Rc9ChRvH6y/hFIefBz57RtKLUHDFvTIdVuKDAR1a
	Kl5w1fojW3ZIU3muQmU27808rj5CBk8Ix7Eb6OUsjzVaOQyqLXakqUfl8ff8yxHbv5op2h9QXrN
	PgGAwxUPGNXWdRhn2KGFxjlalwHDr1GsY7hNi8wyVEl+sJy9z6jU8xIB7k8dDaSZ1fHJuekKZed
	64sW+2jynoF8+WS2CzLz3i6qZ6ugn/7nEl+EjXVEcXL2lT89ufvwxJde2iTg77WMEM4OkewTOGJ
	Pp36uwW9PBDkda3+av6+NF8ODfm2gLXCookNZMdbojd1i7JV6yhfIpztbu+2osYOCxk4kGU5S6X
	/5BgEx9eolmA69GCzBwHQTZBuQqNaFgA6k+9Ui8aV1yG8EaQdC8AqwHbDv1VoCmIc7+PJ9EZLGe
	nrHCLs9BvU=
X-Received: by 2002:a05:6402:2689:b0:68b:f026:f381 with SMTP id 4fb4d7f45d1cf-68e6f1d5e7cmr1800653a12.8.1780500421312;
        Wed, 03 Jun 2026 08:27:01 -0700 (PDT)
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com. [209.85.208.45])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-68e65851786sm1361891a12.17.2026.06.03.08.26.58
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Jun 2026 08:26:59 -0700 (PDT)
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-68c1630159bso6793857a12.2
        for <netdev@vger.kernel.org>; Wed, 03 Jun 2026 08:26:58 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ+6+QArRkncARW4tYLuE8A2/JVYbX5E+xXYgJOdqemulNHSOnLR11ZpgrPM/XRX53vv7FrsCyI=@vger.kernel.org
X-Received: by 2002:a17:907:3f0e:b0:bed:19af:f8aa with SMTP id
 a640c23a62f3a-bf0acf0f958mr176902766b.13.1780500418629; Wed, 03 Jun 2026
 08:26:58 -0700 (PDT)
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
 <20260603-navigieren-pleite-stilvoll-60e6da66b1d4@brauner> <20260603-raumfahrt-unmerklich-ertrugen-c4ecae70d5f9@brauner>
In-Reply-To: <20260603-raumfahrt-unmerklich-ertrugen-c4ecae70d5f9@brauner>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 3 Jun 2026 08:26:42 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgV-j-G3d+899Zm1pQ=NaJrddPz=GKcL5Yw5DTUM=GaUw@mail.gmail.com>
X-Gm-Features: AVHnY4Kj73Z8AasW6cIfq1Oi-uE8PGC_0Rj2_P-0GPM116OFy2hMKOC9XAw-q3o
Message-ID: <CAHk-=wgV-j-G3d+899Zm1pQ=NaJrddPz=GKcL5Yw5DTUM=GaUw@mail.gmail.com>
Subject: Re: [PATCH 0/3] vmsplice: make vmsplice a trivial wrapper for preadv2/pwritev2
To: Christian Brauner <brauner@kernel.org>
Cc: Andy Lutomirski <luto@amacapital.net>, Askar Safin <safinaskar@gmail.com>, akpm@linux-foundation.org, 
	axboe@kernel.dk, david@kernel.org, dhowells@redhat.com, hch@infradead.org, 
	jack@suse.cz, linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, miklos@szeredi.hu, 
	netdev@vger.kernel.org, patches@lists.linux.dev, pfalcato@suse.de, 
	viro@zeniv.linux.org.uk, willy@infradead.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linux-foundation.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-294816-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:brauner@kernel.org,m:luto@amacapital.net,m:safinaskar@gmail.com,m:akpm@linux-foundation.org,m:axboe@kernel.dk,m:david@kernel.org,m:dhowells@redhat.com,m:hch@infradead.org,m:jack@suse.cz,m:linux-api@vger.kernel.org,m:linux-fsdevel@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-mm@kvack.org,m:miklos@szeredi.hu,m:netdev@vger.kernel.org,m:patches@lists.linux.dev,m:pfalcato@suse.de,m:viro@zeniv.linux.org.uk,m:willy@infradead.org,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[linux-foundation.org];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[torvalds@linux-foundation.org,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[19];
	FREEMAIL_CC(0.00)[amacapital.net,gmail.com,linux-foundation.org,kernel.dk,kernel.org,redhat.com,infradead.org,suse.cz,vger.kernel.org,kvack.org,szeredi.hu,lists.linux.dev,suse.de,zeniv.linux.org.uk];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux-foundation.org:from_mime,linux-foundation.org:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 17AA06395BE

On Wed, 3 Jun 2026 at 06:40, Christian Brauner <brauner@kernel.org> wrote:
>
> Prior to the change add_to_pipe() returns -EAGAIN the moment the pipe is
> full. So iter_to_pipe stops and returns a partial count capped at pipe
> capacity. For a 128K buffer over a 64K pipe the first call returns 64K,
> the test drains it, call 2 returns the remaining 64K. Done.
>
> After this change do_writev(... flags & SPLICE_F_NONBLOCK ? RWF_NOWAIT :
> 0) then calls pipe_write which does not stop when the pipe fills. It
> blocks until the entire iovec is consumed.
>
> I kinda think we need to preserve similar semantics.

Ack. We definitely do need to keep the old semantics.

Looking at the patch again, I think it's that

    (flags & SPLICE_F_NONBLOCK) ? RWF_NOWAIT : 0

thing that is broken. I think splice_to_pipe is *always* nowait - but
has the special conditional _initial_ wait.

So I think the RWF_NOWAIT should be unconditional to the do_writev(),
and instead the code should do something like

        ret = wait_for_space(pipe, flags);
        if (!ret) do_writev(...RWF_NOWAIT);

but admittedly I did not think very much about the details, so I might
miss something.

Which also then probably measn that we should just keep the legacy
wrapper in fs/splice.c and we'd just need to make do_writev() and
do_readv() non-static.

Because I'd rather keep wait_for_space() internal to splice (or
alternatively we'd move it to pipe.c, rename it to
"pipe_wait_for_space()", and change the 'flags' argument to be a
boolean to not make it use that splice-specific flags etc).

            Linus

