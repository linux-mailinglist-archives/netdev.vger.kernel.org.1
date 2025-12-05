Return-Path: <netdev+bounces-243886-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EFF6DCA9A9A
	for <lists+netdev@lfdr.de>; Sat, 06 Dec 2025 00:52:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1F6FF301A232
	for <lists+netdev@lfdr.de>; Fri,  5 Dec 2025 23:52:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17B741A9F9F;
	Fri,  5 Dec 2025 23:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ePUovHbI"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F8F34502F
	for <netdev@vger.kernel.org>; Fri,  5 Dec 2025 23:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764978719; cv=none; b=o0fW5j2qkggjTsv00ZHJCAenodfqYrZoSsJRt/f7bpGg6ukGDWftmjadMAuQJcra2fJadWoCSk/SZ7/ey+RdPs/MJXWqiwHoVUmVz4W8JEPx9sVv3yBRth/vyt/LKj4WRIuQQ7QQQKSULjapcUjI4fcCU9wVG80jbMEmD2JdP5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764978719; c=relaxed/simple;
	bh=tZO8aasc5wG+Dm3Yxc8n1ChZbkNdMj8doPeKvpSw2Rw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QAEhAkfHCDRYk0LqwysSW67NgY6Sq4vn4Iu0rCl6OXNYMeJk8AfNubTfVpp/2Hy5V490t0cx9qs6uYBTNUkw8iZNMFpYFvNZIBDO5fkwZ148/osLX0eoqxPmE8Y4SsvOJl015tEliKtc53byASToDkSMsagXwtXMqGm6QgR/93M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ePUovHbI; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2958db8ae4fso27899775ad.2
        for <netdev@vger.kernel.org>; Fri, 05 Dec 2025 15:51:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764978717; x=1765583517; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TnLPtVxd2+m41sbS9f4ZRxQiPjW0nbgvUsIfYmsWlNQ=;
        b=ePUovHbI2XaaBpR+/03N1RkRPqGuOnW2sKSTeV9W453SbBAdZsx/ezAXbx1bDXJRsR
         eh0MfscaI2zK97RpeA0wVY/+dVRCLA1MtG8QOxfTSUL7grG5jYOSy/0L5LbKCSC888oL
         kETtr33dKhw9lQ9kuMW9TpoqkxTO5SR0pVACnfRGOVfRGdzLrqE27NEqA0G1Yx/fGdIs
         SVgyRxlbeWDNUUlpudys9WkOKITg/tBZfpWylgtz/fxBBcb6/22nOdJGPRakeRsndNkv
         zcoyU3DaID38bCEHRyyWz8uplZeOmiu8lu3gBxJ1OW+WUpRLwRZ5YjZ60dxxnh0H2aib
         iS8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764978717; x=1765583517;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TnLPtVxd2+m41sbS9f4ZRxQiPjW0nbgvUsIfYmsWlNQ=;
        b=Ts9QFbEu09rva5XzzM6XGIhtWZc0B1yWDy77a8mktQwmxGK90nykyhv6v7mYtkl6Du
         DHWAh/1JQr9syJvvJ8mqtTcooxImREonnwLpFxp4dB1Gqc+tjh114VuO0nj3ir5arvF+
         2BqBbEvRp7JcPIXx3jBhd6DJNu06aFSRjjNn7pYshtGUP2ZtIAy53WiQn6f7vRID0Pr7
         pOkHxN5P8HtPizrmbNS60BhAf2Gt8y06FnXOPp4YfPp0kNiOZMsCAOEp+HIq0VPMud/8
         jXGL49MkOgeC0lIKiHF5odPjGXaCQBWI4cDMYTT3GpVotbF6FDA8hwzD1uSCv1AtUke5
         U0Vw==
X-Forwarded-Encrypted: i=1; AJvYcCXXLaWCWpgnKSs8ygyj19gHxof8g/A3/JAqrLm4jrowzHXHd4jG0eILBjWjlE/n2Mb/AHXrh8s=@vger.kernel.org
X-Gm-Message-State: AOJu0YxyQT1cC8DJtc10+t8eollqiXTT+oZxjReAPzcf7CofQX2B/fe1
	TijCj9QgWpKLTTlQEv6hh/Y/Qe1Mbn3YsBWRqr3mjpqkTwk7psyD6E7Ew7TTG1BT/zHvGBg8xEn
	O+CGhBy3uLIxDCtkIQIbnznFODZrcZLxMgpUi
X-Gm-Gg: ASbGncsp70xhON55rcEOpKOuLGZ1eHQ0VA46crz6HT0wvNVRIoOq0f/7t/hrWFY4JoQ
	jJ8OFTWt3mh0fach/kkfWeySbKLPL55iNqCe/fNOux8419w3QYvHrD6UFnWcJ/7cCj7u1fU+rPV
	tEeaxTJo5niw4Gd2DQ3lhhVrU8WeFsRYPoKGHAZr4HLL15mK8ZVQ+Mqib8xRkReJYM36p0vD1O3
	mqdkHFoyjDH3VjEFkkoUYqXuhnFLpOnXwsvLDiSwI79HsRWqbj57rYFZ6/PesPm4LbQufXyWwGE
	hrv+b0VH8C4=
X-Google-Smtp-Source: AGHT+IECYf5+A0DiSY2McXf+f/hz+Alv/IlpSfujai+yXydMAVIb3uJFdpjh4iKfl7B4UT9Lmv3iL86LuYbwLCm1TtE=
X-Received: by 2002:a17:90b:2750:b0:349:9dc4:fa35 with SMTP id
 98e67ed59e1d1-349a2622069mr595234a91.25.1764978716793; Fri, 05 Dec 2025
 15:51:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251128002205.1167572-1-mikhail.v.gavrilov@gmail.com> <fa4ec6c228a314a9f0995f80225a4c0e4d8ac2c9.1764341791.git.mikhail.v.gavrilov@gmail.com>
In-Reply-To: <fa4ec6c228a314a9f0995f80225a4c0e4d8ac2c9.1764341791.git.mikhail.v.gavrilov@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 5 Dec 2025 15:51:44 -0800
X-Gm-Features: AWmQ_bkyv538DCFIlQho4HJ7x9k2WVJ3X4sEs1X_Ha5tTZpq4g44_00-xYmSLd8
Message-ID: <CAEf4BzYOhiddakWzVGe1CYt2GZ+a57kT4EyujhoiTQN6Mc6uLg@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next] tools/lib/bpf: fix -Wdiscarded-qualifiers
 under C23
To: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Cc: bpf@vger.kernel.org, andrii@kernel.org, ast@kernel.org, 
	daniel@iogearbox.net, netdev@vger.kernel.org, fweimer@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 28, 2025 at 6:59=E2=80=AFAM Mikhail Gavrilov
<mikhail.v.gavrilov@gmail.com> wrote:
>
> glibc =E2=89=A5 2.42 (GCC 15) defaults to -std=3Dgnu23, which promotes
> -Wdiscarded-qualifiers to an error in the default hardening flags
> of Fedora Rawhide, Arch Linux, openSUSE Tumbleweed, Gentoo, etc.
>
> In C23, strstr() and strchr() return "const char *" in most cases,
> making previous implicit casts invalid.
>
> This breaks the build of tools/bpf/resolve_btfids on pristine
> upstream kernel when using GCC 15 + glibc 2.42+.
>
> Fix the three remaining instances with explicit casts.
>
> No functional changes.
>
> Link: https://bugzilla.redhat.com/show_bug.cgi?id=3D2417601
> Suggested-by: Florian Weimer <fweimer@redhat.com>
> Signed-off-by: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
>
> ---
> v2:
> - Declare `res` as `const char *` =E2=80=94 never modified.
> - Keep `sym_sfx` as `char *` and cast =E2=80=94 it is advanced in the loo=
p.
> - Cast `next_path` =E2=80=94 declared as `char *` earlier in the function=
.
>   Changing it to const would require refactoring the whole function,
>   which is not justified for a tools/ file.
> ---
>  tools/lib/bpf/libbpf.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index dd3b2f57082d..22ccd50e9978 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -8245,7 +8245,7 @@ static int kallsyms_cb(unsigned long long sym_addr,=
 char sym_type,
>         struct bpf_object *obj =3D ctx;
>         const struct btf_type *t;
>         struct extern_desc *ext;
> -       char *res;
> +       const char *res;
>
>         res =3D strstr(sym_name, ".llvm.");
>         if (sym_type =3D=3D 'd' && res)
> @@ -11576,7 +11576,7 @@ static int avail_kallsyms_cb(unsigned long long s=
ym_addr, char sym_type,
>                  */
>                 char sym_trim[256], *psym_trim =3D sym_trim, *sym_sfx;

const char *sym_sfx; instead of unnecessary cast

>
> -               if (!(sym_sfx =3D strstr(sym_name, ".llvm.")))
> +               if (!(sym_sfx =3D (char *)strstr(sym_name, ".llvm.")))  /=
* needs mutation */
>                         return 0;
>
>                 /* psym_trim vs sym_trim dance is done to avoid pointer v=
s array
> @@ -12164,7 +12164,7 @@ static int resolve_full_path(const char *file, ch=
ar *result, size_t result_sz)
>
>                         if (s[0] =3D=3D ':')
>                                 s++;
> -                       next_path =3D strchr(s, ':');
> +                       next_path =3D (char *)strchr(s, ':');   /* declar=
ed as char * above */

same here, next_path should be const char *

pw-bot: cr


>                         seg_len =3D next_path ? next_path - s : strlen(s)=
;
>                         if (!seg_len)
>                                 continue;
> --
> 2.52.0
>

