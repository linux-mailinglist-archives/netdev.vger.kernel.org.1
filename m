Return-Path: <netdev+bounces-270069-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aOFqHku7vWnyAwMAu9opvQ
	(envelope-from <netdev+bounces-270069-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 22:25:31 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F91E2E154E
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 22:25:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D47B2302804F
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 21:20:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 273F13E2766;
	Fri, 20 Mar 2026 21:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="g4Zx7wA+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9824C36AB61
	for <netdev@vger.kernel.org>; Fri, 20 Mar 2026 21:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774041598; cv=none; b=swXSA48NeHKeKTsXp6PnGQuBgzHz+V2X/AZFUA1SC6BIVv+wQn4K1n0BifG6zaKECsLuE7VmZ2y+hH8i3hqvEE4BoVFzt/hI68U8D3MHbAyCj1XpmKeQV4cROIyeYJmIKY0eHiEvibhCnsHH8O2YE33IEhtdvh5LGP91wzf+bts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774041598; c=relaxed/simple;
	bh=HZRLHEwGWpwaQuLLrSh40uPRxk7ylCvGq0hs14KucR0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lOQijLuJq7JDQaHV0+pOAkQnj5xbkmf246HLY4wgVMKe7dX69BwrdD6Gu5tU2tBD9tJsz9aM6rPVPTdHkAfdlE+nnkfiVWOhOe86dSBsU+GDtqKmyd+JGu8Ljdhi1lAtwjSUK/m4+dTolBf+HP98wy2H9ccqfGEy4mkRT6VP1eg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=g4Zx7wA+; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-b97bca3797dso310907466b.0
        for <netdev@vger.kernel.org>; Fri, 20 Mar 2026 14:19:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1774041595; x=1774646395; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=XCE3Sb6hrBAlOh+2FMHN/3IZlK3Hh6o5UrXz2dr3r8U=;
        b=g4Zx7wA+SN2odLJZzsajuV6KCjfBKCntTNMoz6QpJnPX7KqDtWCoHwGlnoNxlq69Yi
         H4K8vuFrjwQrUZ/ctICXBkoSuyCffV7bZBeiHzlTfiCWVToo8ukwEMmLiU1+qj+xZa2h
         vwtEAq+fbmrwsXd5DF+A/AGjPVjCgi8Vlh94w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774041595; x=1774646395;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XCE3Sb6hrBAlOh+2FMHN/3IZlK3Hh6o5UrXz2dr3r8U=;
        b=nyw3wM6oGc5efiIR62bsL0vWBUnd96Wl5gjoSewLtgLLyyCyp5rJaqYtOdYTl04v6F
         jglrwsw2YyCPHSOfRlfGPyq6V2uaq08sJF2g8Ynsr9p3OCddsrFc49IF+DM686mbFNUH
         yu5UXqqrCWQKn4a/Lpw9cgDbezoLKV9P04Z6mVcYHbM1jK/f3LaC0N4nwUdDiE8eXVgv
         fklw3LanJ6dzbGw+wYRU0ntxx41eSDuis6k98tNPaoDnSlhkUb6Kl9Ilno2tRiOxJ1dy
         VQvp8cN2x1fxPQr84kpPUCb3kOjdoKUPrdRsGduI1OpxcUWpsnAPMZ2oZk1xo1uprbRl
         p9AQ==
X-Forwarded-Encrypted: i=1; AJvYcCW4luTQZUJsXkg88NNf4dDUmhP8eYuSy81ADBZ6I3wXyA/6ICHSRq27vUEPfCNrGz1ix5SSG1I=@vger.kernel.org
X-Gm-Message-State: AOJu0YxxczuEIm7fhNm2zSaCgYzGYekuyaeacRhTULO6sFvBojYCE6rI
	kM3a8h8HXsbxCdas2CgZK2p4KKCJRnA4H5o5sMkFJPG2QmIP86AsQU55gNr8ZYSm4s7GGT/Cc8T
	3ELAm2NQ=
X-Gm-Gg: ATEYQzzmzNLgz9V+yA5Kao+AjcLDgFJ+bmbPaAUsJKSGoMtRPPHHYqWyAA9wJAayx5A
	3Qv/dOTB7EqF1DvFzqfy2MrE0qN5Lu1LnuroJNNfXjsCc3+l4ggptMpKd5GZTM0ctaDEbPfh4V/
	5U1Xol5sKtp7DMM2S93gOyG/G3Fmr3hXxOhlHXSfpdwlgYbehuUI2QxIhwubrehKvmrvOBZj8T2
	J/r8ci2ULVPXAlRYzRz/WQo5MG/5naMJYEOvpKIBPJAc2Kfq8lmAk9IeDj8G6W8ctFFnbt2cvXd
	jGTsnSLc8oB37DtPC7UVN+iXMY/rneLfX76DcQ4pQhurZeBoD9WhQIwb1Nd+uD8xlt84/+QA8yD
	o7WV7bQWqcpMY0+60QFNeAgIA/f7bNLaUqg7huG4QdnbvWYUZ3j51K3+ATJzDhCw0FifBk7EEEh
	Ofo5EbhW4cX8WCzI+B9XPRkaKIKmGpVSjFV9hUs6zK/vUIwLNUz3tECszs0elifBmI4uOqu6UY
X-Received: by 2002:a17:907:cb20:b0:b98:5b2:77f7 with SMTP id a640c23a62f3a-b982f0c9208mr237816266b.12.1774041594909;
        Fri, 20 Mar 2026 14:19:54 -0700 (PDT)
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com. [209.85.208.51])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b983e4e9b65sm87250666b.31.2026.03.20.14.19.53
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Mar 2026 14:19:54 -0700 (PDT)
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-6634bb959a2so3796438a12.1
        for <netdev@vger.kernel.org>; Fri, 20 Mar 2026 14:19:53 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCV9Ua0JShibuqfFeB8p7DhhDVrkn7BU9gVgauTuHiWPfHASklFW00kUlB1U7l2Yk0ZMfsHAYzA=@vger.kernel.org
X-Received: by 2002:a05:6402:3786:b0:668:8c50:284c with SMTP id
 4fb4d7f45d1cf-668c911da49mr3212716a12.11.1774041593499; Fri, 20 Mar 2026
 14:19:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260319190455.135302-1-luiz.dentz@gmail.com> <177396481128.1855248.1024090053580545012.git-patchwork-notify@kernel.org>
 <6411a735-d187-4848-b199-a0e2c2e0e52c@leemhuis.info> <CABBYNZJfLf6PzKUkGjiCvqEm3h0+3SUcxY5RNbUHv6LBdPT_zQ@mail.gmail.com>
 <CAHk-=wh8dnp1qT_CHG-Zz9H2=G1Q=0rF5SYv+YsEaPnVhznxWA@mail.gmail.com>
In-Reply-To: <CAHk-=wh8dnp1qT_CHG-Zz9H2=G1Q=0rF5SYv+YsEaPnVhznxWA@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 20 Mar 2026 14:19:37 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgryF_COh9xzhGaJ-FAm471pn5uvqt-Z94+3ENPVu4w-Q@mail.gmail.com>
X-Gm-Features: AaiRm52w5UPxNX4mH_HiyvwPIsVpHwHmqg_LpHJqM3MhIn7krj-l7qPCQ22Gurs
Message-ID: <CAHk-=wgryF_COh9xzhGaJ-FAm471pn5uvqt-Z94+3ENPVu4w-Q@mail.gmail.com>
Subject: Re: bluetooth regression fix likely to miss -rc5 (was: Re: [GIT PULL]
 bluetooth 2026-03-19)
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Thorsten Leemhuis <regressions@leemhuis.info>, kuba@kernel.org, 
	linux-bluetooth@vger.kernel.org, davem@davemloft.net, netdev@vger.kernel.org, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[linux-foundation.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-270069-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[linux-foundation.org];
	FREEMAIL_TO(0.00)[gmail.com];
	DKIM_TRACE(0.00)[linux-foundation.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[torvalds@linux-foundation.org,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,linux-foundation.org:dkim,linux-foundation.org:email,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 7F91E2E154E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, 20 Mar 2026 at 14:03, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> That hardware may admittedly often not be great, and we may all wish
> that it didn't exist, but hey, that's the thing about reality: it's
> often messy.

Of course, the thing about "reality is often messy" is that then you
end up with the truly conflicting situations where there are other
complications: security issues can sometimes mean that you *really*
can't just revert a regression fix, because while paper standards and
artificial tests are relatively worthless (compared to a user
regression report), a severe security problem obviously isn't...

Also, if the regression reports then come in late, people may have
started relying on the new behavior, and reverting things then causes
its own set of regressions.

But when you get a regression report quickly during the early -rc
period, that tends to mean that it's either a really bad fix, or it's
just a very common piece of bad hardware (or a shared bug across many
different hw implementations - which obviously is often then due to
some common chip or firmware implementation or whatever)

               Linus

