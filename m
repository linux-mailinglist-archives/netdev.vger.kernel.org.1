Return-Path: <netdev+bounces-58742-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 856F6817F29
	for <lists+netdev@lfdr.de>; Tue, 19 Dec 2023 02:11:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F1C2285668
	for <lists+netdev@lfdr.de>; Tue, 19 Dec 2023 01:11:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EA0A7F8;
	Tue, 19 Dec 2023 01:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="h8ocAtp+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 512E110E4
	for <netdev@vger.kernel.org>; Tue, 19 Dec 2023 01:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-40c3ceded81so39310495e9.1
        for <netdev@vger.kernel.org>; Mon, 18 Dec 2023 17:11:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1702948303; x=1703553103; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Hej4AjxanXNrySIhvl+6S8hgAgsJIbBbBmJWQyMfh84=;
        b=h8ocAtp+qBDlpapTHPqOHFpk1+La8yMvPjGQ0gKoO3crTE0h11ug5NWVOTCRGzhgSS
         0s6Af+dfTYm/2CVnKe70WFjPi3vUYccPaHl635m8yWyP9Psgivj78vx/Gbv2alEmMebh
         u9vwwNSBbZwOgZnR5Tz7CZsEh9GigxNuToMAs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702948303; x=1703553103;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Hej4AjxanXNrySIhvl+6S8hgAgsJIbBbBmJWQyMfh84=;
        b=Rya88mB2ZYWGhvBW2z76eMwtP6pm4PQ7yaNCoW29WD19krt1LT/Q7ohiOBYI50s1LN
         DLBKAZGzdwDVjKR8jwvD2UUhBC8NfX/uIiFLUomlVDfHbiVjjcIIhYRVnk0q/eVj+Hqo
         QrQy4RQCLWspk8vFqiAoXROTJRu27I3phjuyMQIAypJyB6Cag1F1xfeZR2lNHEbtw6d2
         RdKmBfVi6dcOdj4csLBFQrfBDnF4R7WOqxSZWmkDZDa0EVYy3dAXrfo6m1O4lQh8RKAp
         grkpb6Us0+7c/S5Uv9jQANydvaAJJ3VM2CIqbDODT2A/WZzDcfMXpR4mtmYsp0qt3ZzA
         cvww==
X-Gm-Message-State: AOJu0YyaSH6IRf32PqAzn5mCGECH9VzQVhF2S/UqLb/IHf3lFVKXGgYO
	xOj/sF07Q0LUrRgqAQiCNJNYwp0tz6FKp2Go1Wf1SA==
X-Google-Smtp-Source: AGHT+IEBS285suNPAo201lNPaWxQY+HmaoS4g88wfxn4qWcuvXjhywPZUz+YhXPs3COClG+F4pn4Bg==
X-Received: by 2002:a05:600c:358d:b0:40d:27d3:8f2c with SMTP id p13-20020a05600c358d00b0040d27d38f2cmr5208wmq.56.1702948303477;
        Mon, 18 Dec 2023 17:11:43 -0800 (PST)
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com. [209.85.221.50])
        by smtp.gmail.com with ESMTPSA id vu3-20020a170907a64300b00a1cd9627474sm14658708ejc.44.2023.12.18.17.11.42
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Dec 2023 17:11:42 -0800 (PST)
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-32f8441dfb5so3782523f8f.0
        for <netdev@vger.kernel.org>; Mon, 18 Dec 2023 17:11:42 -0800 (PST)
X-Received: by 2002:a05:600c:511a:b0:405:37bb:d942 with SMTP id
 o26-20020a05600c511a00b0040537bbd942mr8221931wms.4.1702948301548; Mon, 18 Dec
 2023 17:11:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231219000520.34178-1-alexei.starovoitov@gmail.com>
In-Reply-To: <20231219000520.34178-1-alexei.starovoitov@gmail.com>
From: Linus Torvalds <torvalds@linuxfoundation.org>
Date: Mon, 18 Dec 2023 17:11:23 -0800
X-Gmail-Original-Message-ID: <CAHk-=wg7JuFYwGy=GOMbRCtOL+jwSQsdUaBsRWkDVYbxipbM5A@mail.gmail.com>
Message-ID: <CAHk-=wg7JuFYwGy=GOMbRCtOL+jwSQsdUaBsRWkDVYbxipbM5A@mail.gmail.com>
Subject: Re: pull-request: bpf-next 2023-12-18
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: kuba@kernel.org, davem@davemloft.net, edumazet@google.com, 
	pabeni@redhat.com, daniel@iogearbox.net, andrii@kernel.org, 
	peterz@infradead.org, brauner@kernel.org, netdev@vger.kernel.org, 
	bpf@vger.kernel.org, kernel-team@fb.com
Content-Type: text/plain; charset="UTF-8"

On Mon, 18 Dec 2023 at 16:05, Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> 2) Introduce BPF token object, from Andrii Nakryiko.

I assume this is why I and some other unusual recipients are cc'd,
because the networking people feel like they can't judge this and
shouldn't merge non-networking code like this.

Honestly, I was told - and expected - that this part would come in a
branch of its own, so that it would be sanely reviewable.

Now it's mixed in with everything else.

This is *literally* why we have branches in git, so that people can
make more independent changes and judgements, and so that we don't
have to be in a situation where "look, here's ten different things,
pull it all or nothing".

Many of the changes *look* like they are in branches, but they've been
the "fake branches" that are just done as "patch series in a branch,
with the cover letter as the merge message".

Which is great for maintaining that cover letter information and a
certain amount of historical clarity, but not helpful AT ALL for the
"independent changes" thing when it is all mixed up in history, where
independent things are mostly serialized and not actually independent
in history at all.

So now it appears to be one big mess, and exactly that "all or
nothing" thing that isn't great, since the whole point was that the
networking people weren't comfortable with the reviewing filesystem
side.

And honestly, the bpf side *still* seems to be absolutely conbfused
and complkete crap when it comes to file descriptors.

I took a quick look, and I *still* see new code being introduced there
that thinks that file descriptor zero is special, and we tols you a
*year* ago that that wasn't true, and that you need to fix this.

I literally see complete garbage like tghis:

        ..
        __u32 btf_token_fd;
        ...
        if (attr->btf_token_fd) {
                token = bpf_token_get_from_fd(attr->btf_token_fd);

and this is all *new* code that makes that same bogus sh*t-for-brains
mistake that was wrong the first time.

So now I'm saying NAK. Enough is enough.  No more of this crazy "I
don't understand even the _basics_ of file descriptors, and yet I'm
introducing new random interfaces".

I know you thought fd zero was something invalid. You were told
otherwise. Apparently you just ignored being wrong, and have decided
to double down on being wrong.

We don't take this kind of flat-Earther crap.

File descriptors don't start at 1. Deal with reality. Stop making the
same mistake over and over. If you ant to have a "no file descriptor"
flag, you use a signed type, and a signed value for that, because file
descriptor zero is perfectly valid, and I don't want to hear any more
uninformed denialism.

Stop polluting the kernel with incorrect assumptions.

So yes, I will keep NAK'ing this until this kind of fundamental
mistake is fixed. This is not rocket science, and this is not
something that wasn't discussed before. Your ignorance has now turned
from "I didn't know" to "I didn 't care", and at that point I really
don't want to see new code any more.

               Linus

