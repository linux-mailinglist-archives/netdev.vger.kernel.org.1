Return-Path: <netdev+bounces-249683-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F377D1C248
	for <lists+netdev@lfdr.de>; Wed, 14 Jan 2026 03:33:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AE26F3019BC3
	for <lists+netdev@lfdr.de>; Wed, 14 Jan 2026 02:33:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 324832F3622;
	Wed, 14 Jan 2026 02:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VWbonpIj"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8213230D14
	for <netdev@vger.kernel.org>; Wed, 14 Jan 2026 02:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768358002; cv=none; b=BALoxW7sV6lTtQXJlF4jIT/BC0wyE2T0lAxdf9NVJQ0M+2r9RMwla+t6wHExX3T40k04WSQ8I3XAtgJJYwy22Yj5Tv6WP2LUWpYJtjx3tq9y0kPSIquhS4EcTuZzGax9jOQl5E8sLSAaoDRZSW4VIiNTzqnzV6CTH7B7ixu+VjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768358002; c=relaxed/simple;
	bh=yRggPcqlK8vr6TJMrmO1uo72WruGYkSCXYL3BH+siBA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f9ycDj+CSP60dvXhBzLU5LDHfYvGbUv9fqN4+EfJcXkMaxEB7kam7OyAIJu+hfdCYrWq2Iqd754z7sG0Ssmq6t3298C5f2kO5qiyVIxsgJtYupytxjIjPwNtbZ2aqU0l05gtzTiGE4D4nIIIMQnW0L9spTMysd/25nn72pdnTgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VWbonpIj; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-42fbad1fa90so6918321f8f.0
        for <netdev@vger.kernel.org>; Tue, 13 Jan 2026 18:33:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768357999; x=1768962799; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yRggPcqlK8vr6TJMrmO1uo72WruGYkSCXYL3BH+siBA=;
        b=VWbonpIjDLDbRExTVQdvxGKLYEsrXx1rUlLKKO1JdnsJsFKxkua84EqOLS8Nv/n/6k
         QPd/xmXB+vHoL/350PPDEDuUSQj+JcNQQ9WIWBQhw0TaVY3sKXAkRtGhFBwECZrloEtx
         7GUajCNA27hEbb6PLwOCknxVrwG6lZ614Q3dHikepzBFVJJhw+JRHTKlie2zzRMgGaLw
         L3kt9rU1yPKndnMfXxOUDFUo/Uvb0oHDlW/6jEyTuO1CjQn9ug9Ke4/NAapw0xYmkXve
         p14XRMK1fC/guxLRtlcxbNInr72Boof2nDLENahbQxf9gO02uypJTvVvw6OQ9MsAMijS
         gFyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768357999; x=1768962799;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yRggPcqlK8vr6TJMrmO1uo72WruGYkSCXYL3BH+siBA=;
        b=nAbAZ9bNc64D2bUW2IXaBHafKLpdtlacXKoKXr2+i8/DIDtmmD+CxfmmY0EH5KGBdH
         t8/VNQj72wYD8XSTiS4PU/BIXnE8v8A62i4G64mC8VHBUNZVC6yafeSuBfllha7BNgoZ
         JpxujOZdwz7GcIX6DQyOhP8l+b17UjNkobkHnSxYVw46QbK8qV+o6TvPao+vEmXDwGff
         4DuECh3FtEJJ3I6+ZtapsM9p3VjIOPx3f5odG0F8ssX3wG+t8tUyq8fCLc+Kh2jH7w+M
         60psXKNIGRVbvoiT0cM7TjPHtvRC2L/qnLXEeYIR5u12EtotgYBaAb2Gjr9s2PE2iAiK
         ta9g==
X-Forwarded-Encrypted: i=1; AJvYcCXOf8KRa9W9vOiU6qLRrv/AGdaQeiIPhQ4KWV2foy8z++y5Z2qoqFyN2PNulrgr3B/fpf9xxhw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyr/Qxzc6sEwwsH5O8GU31jMDQv5wRAvrVL7wmuYF4ctLeBwQvS
	MIOpo2fmJ/G/ZdguRAoJOhQC9QRwraKQiP3nJjuccXHjGkiT/6IUTsrVxZ4fS4OuRKewCuHwTTc
	lMiJIcZherv4c4ci6if0SsyhPubn+vy8=
X-Gm-Gg: AY/fxX7NMVC/Ol0qpFx2maLwNXONHKX+JQWskUEM5uEo5R9V80cgXEEM+E9kxf/ea/L
	7FvCyaPJAJZoIRPWMS6BJdGmq+pZo9aQB6A/vhckjwEGGl+q2d20tjjQc0optIzUZ8ubUDfXegu
	53XwkSmoNgU0Tn4WwDJpP8F+6ihl48eZ28E7ctJY71yBRkAEQFRVv0x3NzhDU+C4T0PVH0rUwqI
	abCdZqgnMDSREEeEOeHy+u2u/iygePKgjyiaqcEa3IACL7jOIKlq2hHAyDpEKiU70P1w76LKxH8
	Lbxd9Q3/vPZveNTqJyqvPDnD5K5H
X-Received: by 2002:a05:6000:2f84:b0:430:fa9a:74d with SMTP id
 ffacd0b85a97d-4342d3912bcmr464347f8f.24.1768357998953; Tue, 13 Jan 2026
 18:33:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260110141115.537055-1-dongml2@chinatelecom.cn>
 <20260110141115.537055-6-dongml2@chinatelecom.cn> <CAEf4BzbrYMSaM-EEwz4UhZr0BG4FDyxtaG16e4z10QhmAY8o=g@mail.gmail.com>
In-Reply-To: <CAEf4BzbrYMSaM-EEwz4UhZr0BG4FDyxtaG16e4z10QhmAY8o=g@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 13 Jan 2026 18:33:07 -0800
X-Gm-Features: AZwV_Qh9R49RHNFvHfXuQEMWgnFHcwmfCd43CnUckrigAg8jcAMO53P-h0Re3Q4
Message-ID: <CAADnVQJzkXysOO9jqdvJUYbe2t+urReRV2xWQ0L2z0qcjgxdcw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v9 05/11] bpf: support fsession for bpf_session_cookie
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Menglong Dong <menglong8.dong@gmail.com>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, "David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, jiang.biao@linux.dev, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, X86 ML <x86@kernel.org>, 
	"H. Peter Anvin" <hpa@zytor.com>, bpf <bpf@vger.kernel.org>, 
	Network Development <netdev@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 13, 2026 at 5:24=E2=80=AFPM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Sat, Jan 10, 2026 at 6:12=E2=80=AFAM Menglong Dong <menglong8.dong@gma=
il.com> wrote:
> >
> > Implement session cookie for fsession. In order to limit the stack usag=
e,
> > we make 4 as the maximum of the cookie count.
>
> This 4 is so random, tbh. Do we need to artificially limit it? Even if
> all BPF_MAX_TRAMP_LINKS =3D 38 where using session cookies, it would be
> 304 bytes. Not insignificant, but also not world-ending and IMO so
> unlikely that I wouldn't add extra limits at all.

I forgot that we already have BPF_MAX_TRAMP_LINKS limit for the total
number of progs. I guess extra 8 bytes per fsession prog isn't that bad.

