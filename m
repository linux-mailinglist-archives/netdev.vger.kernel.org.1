Return-Path: <netdev+bounces-127956-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CADC977358
	for <lists+netdev@lfdr.de>; Thu, 12 Sep 2024 23:08:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 087F62839E9
	for <lists+netdev@lfdr.de>; Thu, 12 Sep 2024 21:08:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C50CD1C2307;
	Thu, 12 Sep 2024 21:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OE2U3eIs"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BC5E1C1AA9
	for <netdev@vger.kernel.org>; Thu, 12 Sep 2024 21:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726175290; cv=none; b=hXQN2V3JnkAZQSuODzAS6RLRearyOIER/Qds0JRjL9ip0ToFRhu6C8hRgkHY4g6GpdP+DambqU2sGx9cN+T8HhdarEHKdUYC69vMxJoiYSQCXC6rI6glNNkZmOotngR98FoOadLyNaVBeMhZ/Y8s2nqlpJYvVykxnn0ic+fsAk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726175290; c=relaxed/simple;
	bh=7FmWEpkWETI6rAOdNBqSPwiupiNbAImQ0z9BL82/uB4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KCbke8Uom2iozlrclECnRw9nZgMDdYPiCygx1iHTw+FK94jAi08k/Yn3t5XWQLkuxPYvvtXNYhs24gNVR892gKN/qX9Gw7CllQA0/77pa8ek3Ac8hKiHNEXaMb2fIv9n4iogOlcK4cph6CsnHzxdtuiexi7/Ts/t//cLrr5l7uE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OE2U3eIs; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-4581cec6079so83971cf.0
        for <netdev@vger.kernel.org>; Thu, 12 Sep 2024 14:08:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1726175288; x=1726780088; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7FmWEpkWETI6rAOdNBqSPwiupiNbAImQ0z9BL82/uB4=;
        b=OE2U3eIsbcqZ/o1UwnCQu5+Ynpy6n13g652UMBK0Vu2ttYmqMSwoVyUs4FWjSAOrX0
         QjeKSF+oXXRIvd/4txjzxCoenh/Tyo7dra0TEWeBpt9fwCsiLfjnpOG4qmejuOB7H6PD
         bJXi0awetJcxI7yCwZinbtua/Mnx67l82qHRlRJWews/Z+g7ELtqjbfDrnqPfvM1ft0r
         QpG1IRmlZ9FAm+yWP7aPuwZPK2wdyIzyJhIvSEesvoHOGoe48RXzSadfut9c0rgrvqXy
         ZqpT65dSDd7/X4z04MJl2x9XRHXXAQOr5aVv9Jxe7IZdzVdgYQK1xwQs1MIn7a6jj8yU
         5SKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726175288; x=1726780088;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7FmWEpkWETI6rAOdNBqSPwiupiNbAImQ0z9BL82/uB4=;
        b=TLLQk+x7/mtaENs7OYCKiKsJiKU5sI4d4VKgEVp+v2keyR1jraVoUjImOmsW2GegJn
         FnpWDeje4KzkIgUj+j6W0/I9hMJu5VR6DShCerl50bk+0+zqLxzVSBOnrgKJLrXDdnDc
         Gfy141cIwmo3FXS0CsEGvdycBRltmkYwvAGUhI3YGzkPOHKQG4LDW3IO+hE8NTG7oloO
         1e0Q/C6T+HzDwcA65becC8qYjKIKDX6nX/2mQDdLhQgocn5YtxlP3JmPveD6h+Qccuhs
         lD4pdjvc6LKS8diL6fM0+g/XzUpE8hy5W7DfA1/yWnaid8drfui72QqQL8D/Gp3ZL5uc
         0n8Q==
X-Gm-Message-State: AOJu0Yy4HcoOIqfSnr0CqZ0pBFEuRbky3p165JMpVvgliS47IyIai+fQ
	ttGIWcIOr7oiJPMSaDCWl1fmKp5lZjbJWRghMABJqbYAXOLkE3Uf+ug5F0yxZvTFGY3xx1/7C83
	ep3nyVl31ESCbjBtxPQYVzyKhK9U2Z3r8YTau
X-Google-Smtp-Source: AGHT+IFTczjdQuyMfT7o0Y3cvlaURLRVAhNJDSgFv3XHPantUoK3EpvfYn2DV3uCfyYgjE4CrXJvAA5UPtDeUvQTyNI=
X-Received: by 2002:ac8:7f41:0:b0:447:f958:ab83 with SMTP id
 d75a77b69052e-45864549fddmr4203891cf.21.1726175287878; Thu, 12 Sep 2024
 14:08:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240912171251.937743-1-sdf@fomichev.me> <ZuNFcP6UM4e5EdUX@mini-arch>
In-Reply-To: <ZuNFcP6UM4e5EdUX@mini-arch>
From: Mina Almasry <almasrymina@google.com>
Date: Thu, 12 Sep 2024 14:07:54 -0700
Message-ID: <CAHS8izM8e4OhOFjRm9cF2LuN=ePWPgd-EY09fZHSybgcOaH4MA@mail.gmail.com>
Subject: Re: [PATCH net-next 00/13] selftests: ncdevmem: Add ncdevmem to ksft
To: Stanislav Fomichev <stfomichev@gmail.com>, Pavel Begunkov <asml.silence@gmail.com>, 
	David Wei <dw@davidwei.uk>, Taehee Yoo <ap420073@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 12, 2024 at 12:48=E2=80=AFPM Stanislav Fomichev
<stfomichev@gmail.com> wrote:
>
> On 09/12, Stanislav Fomichev wrote:
> > The goal of the series is to simplify and make it possible to use
> > ncdevmem in an automated way from the ksft python wrapper.
> >
> > ncdevmem is slowly mutated into a state where it uses stdout
> > to print the payload and the python wrapper is added to
> > make sure the arrived payload matches the expected one.
>
> Mina, what's your plan/progress on the upstreamable TX side? I hope
> you're still gonna finish it up?
>

I'm very open to someone pushing the TX side, but there is a bit of a
need here to get the TX side done sooner than later. In reality I
don't think anyone cares as much as me to push this ASAP so I
plan/hope to look into it. I have made some progress but a bit to be
worked through at the moment. I hope to have something ready as the
merge window reopens; very likely doable.

> I have a PoC based on your old RFC over here (plus all the selftests to
> verify it). I also have a 'loopback' mode to test/verify UAPI parts on qe=
mu
> without real HW.
>

This sounds excellent. Where is here? Is there a link missing?

I'm happy to push those patches forward, giving you full credit of
course (either signed-off-by both of us or 'Based on work by
stfomichev@gmail.com' etc).

> Should I post it as an RFC once the merge window closes? Or maybe send
> it off list? I don't intent to push those patches further. If you already
> have the implementation on your side, maybe at least the selftests will b=
e
> helpful to reuse?

Everything would be useful to reuse. Thank you very much, this is amazing.

BTW, I was planning on looking into both TX and improving tests and
you have looked into both, which is amazing, thank you. Would you
Pavel/David/Taehee others would be interested in, say, a monthly
face-to-face call to discuss future work? I am under the impression
Taehee will push devmem support for bnxt and Pavel for io uring ZC, so
we may have a bunch of details to discuss.

Any sync would be hosted on bbb, public to anyone to join.

No pressure, of course. Communicating on-list via email has worked so
far, so in a sense there is no reason to change things :D

--=20
Thanks,
Mina

