Return-Path: <netdev+bounces-270065-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CI3mGjq2vWkqAwMAu9opvQ
	(envelope-from <netdev+bounces-270065-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 22:03:54 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id DFFE62E114B
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 22:03:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BFEC7301452B
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 21:03:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78A3B362122;
	Fri, 20 Mar 2026 21:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="SrHTcttn"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E811E34B18E
	for <netdev@vger.kernel.org>; Fri, 20 Mar 2026 21:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774040631; cv=none; b=UL5KV+F0ejOxaG29v19+pnqjELa+9gxdNZlRB72fgWH1yjPjIsPAZUWDQe07x2xyGAXIuBuLL8tHz1YjPiQ+z6vwcr1ONKXt7FXZx8zkXf75NT227jfQDbkNmvmaeRK7lbDdZhmErl4TcLZpFt3rIiuzoRzD/ujXxyg8jACS4mo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774040631; c=relaxed/simple;
	bh=gz4z96j/kUq36nMix7l3YS85cXEqJghag0WF37XT8DY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m6wh+B/JkP/Cf/vQyvItop30FD1csJVr9NF36DZBRnmVqwAHTCwODu5n5MoKclBPMYFTbcChyGq9W3v8K291yzJigmft5w+d9Ek9POqtBnMC2LEBzpP6C1rfBBEU0E8VGw6haOFg/RHLVAJiZFxd70ckXDg5dVlwt6YDglxATkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=SrHTcttn; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-b9358dd7f79so174219066b.1
        for <netdev@vger.kernel.org>; Fri, 20 Mar 2026 14:03:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1774040628; x=1774645428; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=RfykHQROXEayv7l3WCeAk4a6XCvf0bpEMNKpRypCktg=;
        b=SrHTcttnrQfQ/Fg5GcNWEUnh6/4mOwP/uX9vDfrCn/EoOJIBWAwWZwH6jxLxEJl6QE
         yFuiPy+FGbCbdQ/0zQ9NN9jLsOAwULJ+c1uBzIoSH23xvewplzjFOj/p97kWR2xndGg3
         wVydzvaLdr8M7jirAMenis50bDqSNEqQ7tfww=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774040628; x=1774645428;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RfykHQROXEayv7l3WCeAk4a6XCvf0bpEMNKpRypCktg=;
        b=VakLdoCG09nSMRLuGTTguqRWXRvdek5asGq2M/QMmvfT1mVabPwaHkCntC+4EpEpvB
         Of5/wl+avScvSsE+3W473LypjzxtjvECCop8R87iuAg7stNQ1v473g28c9DlGX3rxrSv
         M7hkH4FuswAEmXT7Q+c59YxEhvGrN58CjBjVyg9NSAaVhA8cyzL7qKnG6q0NHtBeUfCY
         Ou7Z2ua/u5NmLCZnXMeKKAm24i5PFAaw53IojwMJx1xoNKEpAL11PeTYsB17fXgfh/vC
         uibxrmvhBjQyj6iSmTMViQ7BqzBPiV4G72n+0aNI3P15gXpAD28QGRJEk72gO1XBfAHU
         SuYA==
X-Forwarded-Encrypted: i=1; AJvYcCWxY3arLSJw0ZyO6GBfndj9YFMrAg2IQfLuxnZgLXYIpeDBldhlF7bgEjWuHD768dhK+WHS2uY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBNb+qgO4j5D4kATOCZ9MXJRKVEjWu8yTDUAwXbRsRC8YGljhr
	8QCt24ogM3wGr11u7MrNP/98CQECkS/B8lDlVpqEbUux6BZOvHuV4JQtMcljavYj4FZ5/4XCXvO
	xnC7e0Dk=
X-Gm-Gg: ATEYQzyb9tg+hm2HbWH/AYU2mgEylmksJyO2adKo9ZD671lEtEnCH06C800UFI/AXDz
	xA6GEr7MrDLtI07WYORrV5mt1ID3iQfuyyQbQKY59oZZACnywQAFvgDcAkyN5N0PcU15uI3RI8T
	hi2EmUy2YVclr21NzNckIJ1Q059Jvc+XOtFRBKoRzzTBZrmmUXYN1n/hKgoizwYy+1vA2dmWIA6
	Z2KSOvzo9EeMO9Mm3QcSICglAu9rTEHBlNFonJ3MPHr10gi9qfyheDP2Q1VU1o0KAnN56cFBFrA
	dcTSyRcwwPeWoZ7nek8TZmLNl4V8vhoaKTChEt7KMX0lOWUFkBRHQoRr0y395Q68JA/CmvLzq3c
	dkxjwG5ZKMfxKVUkTOAuY5H0aKYDq0AFE45Y+fmMTCdokdxeBfxG4NRTyeoRDt5fOa5UDgPy4Pf
	Gw3CuZB6eh3CYoOtAHsj4zQOikoTIqxxeg2rmY1jA+4nf/oXc68W6gFvM1vUsSjmd2AwWzFxqy
X-Received: by 2002:a17:906:1d51:b0:b97:a459:b66a with SMTP id a640c23a62f3a-b982f25c54cmr231557966b.25.1774040628034;
        Fri, 20 Mar 2026 14:03:48 -0700 (PDT)
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com. [209.85.208.50])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b9833871369sm188950466b.55.2026.03.20.14.03.46
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Mar 2026 14:03:46 -0700 (PDT)
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-65c0891f4e9so1478557a12.1
        for <netdev@vger.kernel.org>; Fri, 20 Mar 2026 14:03:46 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUiG8fe6okTizKd+g5FBqvfbuRYkndkjeRrepQ2xlHmXpWEfbmXKhZy/0TEME3GRWJASsb0Pbw=@vger.kernel.org
X-Received: by 2002:a05:6402:278c:b0:666:725b:b660 with SMTP id
 4fb4d7f45d1cf-668ca31fe2cmr3173661a12.30.1774040626571; Fri, 20 Mar 2026
 14:03:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260319190455.135302-1-luiz.dentz@gmail.com> <177396481128.1855248.1024090053580545012.git-patchwork-notify@kernel.org>
 <6411a735-d187-4848-b199-a0e2c2e0e52c@leemhuis.info> <CABBYNZJfLf6PzKUkGjiCvqEm3h0+3SUcxY5RNbUHv6LBdPT_zQ@mail.gmail.com>
In-Reply-To: <CABBYNZJfLf6PzKUkGjiCvqEm3h0+3SUcxY5RNbUHv6LBdPT_zQ@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 20 Mar 2026 14:03:30 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh8dnp1qT_CHG-Zz9H2=G1Q=0rF5SYv+YsEaPnVhznxWA@mail.gmail.com>
X-Gm-Features: AaiRm50M8NUw_PkbhBRYCMaCqWtNi1uA19DPteegykkyQpXcCTwtsupjkqHhJK0
Message-ID: <CAHk-=wh8dnp1qT_CHG-Zz9H2=G1Q=0rF5SYv+YsEaPnVhznxWA@mail.gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linux-foundation.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-270065-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[linux-foundation.org];
	FREEMAIL_TO(0.00)[gmail.com];
	DKIM_TRACE(0.00)[linux-foundation.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[torvalds@linux-foundation.org,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linux-foundation.org:dkim]
X-Rspamd-Queue-Id: DFFE62E114B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, 20 Mar 2026 at 11:02, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> Bluetooth regressions are normally device-specific, though. In this
> case, the regression was introduced to pass a new Bluetooth
> Qualification test, so we would have to weigh what is more important:
> compliance or interoperability?

What?

That's nonsensical.

Compliance with some paper standard or artificial test is *COMPLETELY*
irrelevant in the face of an actual user experience regression.

Because when reality and theory collide, theory goes out the window.

There's no "weighing what is more important". None. Users are a
million times more important than specs or tests.

And yes, the world is full of hardware that is not actually compliant
with various standards that it's _supposed_ to be compliant with.

That hardware may admittedly often not be great, and we may all wish
that it didn't exist, but hey, that's the thing about reality: it's
often messy.

And sometimes it's the standard that is wrong.

> I can't remove a valid compliance fix just because
> a user (later more appeared which raized the severity) said his device
> stopped working.

Of course you can.

The test or the standard may be entirely invalid. Not unheard of.

But even more common is that the "fix" that made the test work may
simply be wrong.

Because that "fix some case, break something else" is in a fairly
common pattern.  And that just makes the fix invalid and buggy.

And we have a hard rule on regressions exactly BECAUSE of that
situation: having a "fix one thing, break another" is what the
suspend/resume code had for years and years.

The constant "one step forward, two steps back" dance was what made us
have that hard rule about regressions, because it's better to have a
stable base with known problems - that you can perhaps document - than
have a base where the problems just shift around like quicksand and
users are understandably nervous about upgrading their system, because
they never know if the end result works or not.

So the whole "it's a fix so we can't remove it" is simple not a valid
argument. It's absolutely wrong. Because a fix that causes regressions
is BY DEFINITION not a fix at all.

                Linus

