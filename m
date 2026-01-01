Return-Path: <netdev+bounces-246472-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C323CCECAFD
	for <lists+netdev@lfdr.de>; Thu, 01 Jan 2026 01:07:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B59523005A91
	for <lists+netdev@lfdr.de>; Thu,  1 Jan 2026 00:07:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 820621C01;
	Thu,  1 Jan 2026 00:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W9KIOqDY"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5209BA34
	for <netdev@vger.kernel.org>; Thu,  1 Jan 2026 00:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767226066; cv=none; b=m3kkF+SW+lRpQfInKOfWnRSqRkVoSYTC81rdpyf2LLVi64JW+0DIWkQaJ41zdPuvI5pCctub5+1U0eUciRdDyTn06ME+sr5d2sLMxLdQopBlDgdjPfejhJ5nMzH89o44sHB+hUQ4Qu4gEIFHryDeZ/77aTlDGaJvm1U4Dpk8NAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767226066; c=relaxed/simple;
	bh=9TZdqYDvxAWJNyqKxpwV1QhwM8327YU4KxvehCryeNY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M0pCoWXwLd1i+3hT4toLHgRGiaiYZ2H935onHKWGKZJ5nRz8YrF7lY9icabHL4oKsNBn/X4HdqUmnLfEv0HFjH1Pfhq9BLQZHv0bexe4KLzalotw5De5MlfBElfdfv0scZ4o6Emokw65vcf+q0fxqrIkov6N6eg1bCXGGLsoJqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W9KIOqDY; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-477563e28a3so68142455e9.1
        for <netdev@vger.kernel.org>; Wed, 31 Dec 2025 16:07:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767226063; x=1767830863; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6nswqdzdzgDL2SsgFG1RXJY/Ml4QDsRI1s4C4JVgdyk=;
        b=W9KIOqDY5uq8Vzo/lrEM4+cGHvnUcnIfSQsVAhZYSOcaRwOd4hZYEbu5a/LYVTZLVp
         RMqM1UlZIUvHEv4bK7XF0knCXor4Od2wig0Scuy8x/DYNmbdfI1Ey0+iUWnd1ZjX9N/f
         4WGDqZAM8Ch2z4xT6uNxpDIYXRS0ZuYHQSHaaLDL5KGQetgMrLrM2lDYT2gyIRhLubJc
         3nSNz2x4iC8nbjIRI7SbZCd2Li2fOgub8tU3igVlbz4zfStAeIp9kWH8QBwQjccxlHxf
         yVtwcjL/pdom8z+i5JH1iuMizq3hNSPPlglClsZBaa6qibONymwXOYMMmt+lGctMssV6
         KDRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767226063; x=1767830863;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6nswqdzdzgDL2SsgFG1RXJY/Ml4QDsRI1s4C4JVgdyk=;
        b=elnbdRNoqVy6p/zyDPenqm7zXZjrzO8hbYzHgIXZOyd3LFhKghtyrKG9bQ/vK4kpVM
         nVLsmakPiZCoU3i0AJ90y5E0nbsGA1aK3FobemlwtG78YM+KbF9E4QsbNaD1LOP0t3W5
         i+1vUUOIc5kzqq9uDRSNe1AqAHsR5zuXPfKIMc8hTF9shgR6T+KdgioPzLpkKXfmA7eN
         Iqa3P3aFCqulXdHWFvl+6TZv5cLdZC4CmB28mjH3ttkTer0+QDt9PaU2Y/SrNPH2xWvS
         8WwDnFB17TqTB7DvEokzlzGqVSWJAlAkrFVEftTUb1lZBF1w9O6oc2YzYoKbm7BKsf7N
         o3YQ==
X-Forwarded-Encrypted: i=1; AJvYcCV73JRhV/rCd95wF9LYuEl0uZoYu+0zKrA70G65SYRVKEF48KdY4kyP6Yd01IzM3pZPJI5U+70=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0zbdBLTl1j2mzAOyyC3qq3LD2rInPJvA2VpvIAHIi7wLdRlBO
	vfROiEzFrx6aUiFOxHmV5lnkWRgCBiy6LmXdZMkVaP6g0WmYRqNNV9R7L3Xsdc7wiNBzOn+Tq7B
	f3zfEaAv2uI+GeL+1DGTmWlLrKoWjOc8=
X-Gm-Gg: AY/fxX5/ufBGLR7GgQKzxEersQ+NhLsToazOiot/wlsQpFk8E/43yjNuOnyotGy6m52
	vcOP9tL8QqPFGGep3bXuGaZ+3T8pn3WFzP+OzBB3WjUFiT2dGYMfhweqikIkpGlI3kaFrKsErHv
	dlaLtlsCC3XrN0cZ6AQ4RfjG0FNJnmvlFafV8sDfEZW1HGRfB/018LaUCgWpBvZpOH1LpURDUHE
	2mVgBAfuMgK/A8iR5jlptGZDMkjD+im++p2QYQ/oSkFMCtEu/8SgmlqKR5H1AFN6ZcrGPWKkgma
	Pk/p1LEhQFauzidB7tSEi+VRn+Wq
X-Google-Smtp-Source: AGHT+IEuQszZg7wTp+W6ileKKwymt4EKRPFjA2SMulfekoh0KIiAS/kTnlLwyyMRH0XJuHJgfjyOaw7GUSI+Za6glwc=
X-Received: by 2002:a05:600c:181b:b0:477:9a61:fd06 with SMTP id
 5b1f17b1804b1-47be29afe18mr345736325e9.8.1767226062825; Wed, 31 Dec 2025
 16:07:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251231232048.2860014-1-maze@google.com>
In-Reply-To: <20251231232048.2860014-1-maze@google.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 31 Dec 2025 16:07:31 -0800
X-Gm-Features: AQt7F2px-lQKro5XezvemgzE0XuwobUnwdCsPbj7ENtRF5rqiJQbbZYMafwEdLk
Message-ID: <CAADnVQL4ZPaiwuXtB7b9nrVVMg0eDiT6gnnNGrU5Ys61UWdgCA@mail.gmail.com>
Subject: Re: [PATCH bpf] bpf: 'fix' for undefined future potential exploits of BPF_PROG_LOAD
To: =?UTF-8?Q?Maciej_=C5=BBenczykowski?= <maze@google.com>
Cc: =?UTF-8?Q?Maciej_=C5=BBenczykowski?= <zenczykowski@gmail.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Linux Network Development Mailing List <netdev@vger.kernel.org>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, BPF Mailing List <bpf@vger.kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 31, 2025 at 3:21=E2=80=AFPM Maciej =C5=BBenczykowski <maze@goog=
le.com> wrote:
>
> Over the years there's been a number of issues with the eBPF
> verifier/jit/codegen (incl. both code bugs & spectre related stuff).
>
> It's an amazing but very complex piece of logic, and I don't think
> it's realistic to expect it to ever be (or become) 100% secure.
>
> For example we currently have KASAN reporting buffer length violation
> issues on 6.18 (which may or may not be due to eBPF subsystem, but are
> worrying none-the-less)
>
> Blocking bpf(BPF_PROG_LOAD, ...) is the only sure fire way to guarantee
> the inability to exploit the eBPF subsystem.
> In comparison other eBPF operations are pretty benign.
> Even map creation is usually at most a memory DoS, furthermore it
> remains useful (even with prog load disabled) due to inner maps.
>
> This new sysctl is designed primarily for verified boot systems,
> where (while the system is booting from trusted/signed media)
> BPF_PROG_LOAD can be enabled, but before untrusted user
> media is mounted or networking is enabled, BPF_PROG_LOAD
> can be outright disabled.
>
> This provides for a very simple way to limit eBPF programs to only
> those signed programs that are part of the verified boot chain,
> which has always been a requirement of eBPF use in Android.
>
> I can think of two other ways to accomplish this:
> (a) via sepolicy with booleans, but it ends up being pretty complex
>     (especially wrt verifying the correctness of the resulting policies)
> (b) via BPF_LSM bpf_prog_load hook, which requires enabling additional
>     kernel options which aren't necessarily worth the bother,
>     and requires dynamically patching the kernel (frowned upon by
>     security folks).
>
> This approach appears to simply be the most trivial.

You seem to ignore the existence of sysctl_unprivileged_bpf_disabled.
And with that the CAP_BPF is the only way to prog_load to work.

I suspect you're targeting some old kernels.
We're definitely not adding new sysctl because you cannot upgrade
android kernel fast enough.

pw-bot: cr

