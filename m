Return-Path: <netdev+bounces-249947-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CC27BD2179F
	for <lists+netdev@lfdr.de>; Wed, 14 Jan 2026 22:59:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CA88A307BF4C
	for <lists+netdev@lfdr.de>; Wed, 14 Jan 2026 21:56:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94CB33A9D88;
	Wed, 14 Jan 2026 21:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fQZUoJxO"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C2A23A9D80
	for <netdev@vger.kernel.org>; Wed, 14 Jan 2026 21:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768427813; cv=none; b=oajrxXYhshtCKrKQj/EfVxF3AonGXw89MI4jtdaMwyu0JwkVlyCaJ4P5UtrmTlS+NDphlvWz86f98vR/pjdNCEkZXOCP0axn0EbbOmN1PZrcSK0kWMA1deTHpVgnzdtjfwVackUEG0+y/UGAe5bn2Dj7DIAf1DJyJa8DcB6Mlk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768427813; c=relaxed/simple;
	bh=GhnFSKeN2Zl7Uze175m/2I1Md7YRb2qMzTVcY7DlFvw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=twrEzsCm78JaeoOGukxFXKvqhlOuEmGB9ss7qxWBuuXJ6F/yjRRi0pi6fzimQGua+jdlgoskkWYednkih+y982esf2iP2Ir5jM4hLyhquZupufx3ZoCmaf46ht/lq+6ENDgci33607tjuAtx8dTMWfdkz8UqV19iJi6fdoeJpnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fQZUoJxO; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-477a219dbcaso2308345e9.3
        for <netdev@vger.kernel.org>; Wed, 14 Jan 2026 13:56:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768427783; x=1769032583; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V2IFPWB+T8VdoZY6NJv4zwx5iiV744THuNeTgWC4nyo=;
        b=fQZUoJxOaUJFGdyaLYelKy7sOZpSVZER3GLT5CDfmciBUY9rzu3JeKM2Rra9TKpRI7
         FAN8zz4cOkp2vNZeFWc3oSeZsOSqH16Gdp9tc3lFCdbB3B1yMjyQHQKcHtwvt3TpvBXX
         QW+n9K9Zhc7jBMsQLqZzkBDfmrAtp81USjKoQX0QrNEyon1M9Q8wjFNtvB73qDp8nGZi
         4TRbZtzF+vsEmD5EzdJ/3/Yi8kN5SZOm/QByIXDxCkDu6aey9EaANXP9mYLxjXLt+ng8
         6i57YprppSZwKIy+mZExmt3dWG9eRGYu8K5ZhLZjJtDlUtjStd/l5Tv2DPfQMKzRUZO0
         vw8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768427783; x=1769032583;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=V2IFPWB+T8VdoZY6NJv4zwx5iiV744THuNeTgWC4nyo=;
        b=RSQuIluGac1stlwrGUOgCLay3klWBu9SYefLUqfQLH0GIeo1/TBavQ2UV3cUbX4hJc
         x6PZ95Qx3/Tt8J/Zp/ohDlBDCw7TwHJOSw5UdGgrAhrXwzDwbg4pFJcj0eANau/1V5BH
         aSpFhJObXJV5EDeVGMMim85t3/4u4RdDZ5V5kjdxCBUdzncgrIonyKkXtKRL8TIp4MSX
         MKQCPDV8Vwh3/yZJDQg0R00fPShjYn5zCSlyFNcRvhVzoN20DR4jI4IO6lgsiAnUc0fl
         7k+wNmp+d5UwcTmFUC3Aw1JIfs3hQx1cTDipedp3i2/0smFcY+nH+UlBdVDf7rt9XFqT
         GlTw==
X-Forwarded-Encrypted: i=1; AJvYcCWho6jbQCsFVmKKgl0ictLMjbHUcAlp4Rmdp822HLfMAb/Tidk83QXLW/ltltp1OsJapPOf4YQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwV0ODR29rhM660VcsInZTBmGhPA6jh0wiEqARCmWOnUATRPRk2
	9lh0nOrYePgXeznFDGCKYv0ALZwXjybHy6yc4xMcK/lbP2RNQfxUkOtf/a4EQthiiNCVBQSYq6m
	IsXjthWwahgnaOguLRIB+yEGiTMnfClU=
X-Gm-Gg: AY/fxX5O7c180rnRWS5dTyaYdcsoXrQ71NSRJXH2V7508dkWgTEfnDbKdTk4uaVuNIl
	ptgj/0L8rUy60dVSvKrN8jWnEUfpjhc/mS0/J05h5gZC69YkSzMpj2PlVM7ICLf5voo6+75r5U8
	hU6nLweqL9JdLmmOcSesTbDWvfxpfJM/0GkORo4FkOjwfCxTFMrrYlbveXVlMzLv9zp2Hi3iXH4
	JlGlyOAt8DWzD1qxz0scEVAFQ4KMcF7go58tO75lm/WUzzbiNGADgH9+b4IhXj5iFPSb7qprktC
	WxkT66PxSQ4l3o9FU862TVVOfp+9
X-Received: by 2002:a05:600c:4f0b:b0:477:c71:1fc1 with SMTP id
 5b1f17b1804b1-47ee4819f30mr39840995e9.19.1768427783081; Wed, 14 Jan 2026
 13:56:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260102150032.53106-1-leon.hwang@linux.dev> <CAADnVQJugf_t37MJbmvhrgPXmC700kJ25Q2NVGkDBc7dZdMTEQ@mail.gmail.com>
 <aWd9z8GVYO12YsaH@krava> <CAADnVQLxo1uPbutGNKrv=f=bSVkzxOfSof0ea8n7VvqsaU+S3w@mail.gmail.com>
 <aWgD3zH7vsiBdIcr@krava>
In-Reply-To: <aWgD3zH7vsiBdIcr@krava>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 14 Jan 2026 13:56:11 -0800
X-Gm-Features: AZwV_QjPeGyIa5g7MAD4JaS1tAElwUa_x4uErmV3ep-P21EZz9S74OzD-I8OSSs
Message-ID: <CAADnVQLHVogD1mjMCsHcJOayuZW4OwadEN0g9wu=6d97uRSWqQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next 0/4] bpf: tailcall: Eliminate max_entries and
 bpf_func access at runtime
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Leon Hwang <leon.hwang@linux.dev>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Puranjay Mohan <puranjay@kernel.org>, Xu Kuohai <xukuohai@huaweicloud.com>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	"David S . Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, X86 ML <x86@kernel.org>, 
	"H . Peter Anvin" <hpa@zytor.com>, Andrew Morton <akpm@linux-foundation.org>, 
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, LKML <linux-kernel@vger.kernel.org>, 
	Network Development <netdev@vger.kernel.org>, kernel-patches-bot@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 14, 2026 at 1:00=E2=80=AFPM Jiri Olsa <olsajiri@gmail.com> wrot=
e:
>
> >
> > > fyi I briefly discussed that with Andrii indicating that it might not
> > > be worth the effort at this stage.
> >
> > depending on complexity of course.
>
> for my tests I just had to allow BPF_MAP_TYPE_PROG_ARRAY map
> for sleepable programs
>
> jirka
>
>
> ---
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index faa1ecc1fe9d..1f6fc74c7ea1 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -20969,6 +20969,7 @@ static int check_map_prog_compatibility(struct bp=
f_verifier_env *env,
>                 case BPF_MAP_TYPE_STACK:
>                 case BPF_MAP_TYPE_ARENA:
>                 case BPF_MAP_TYPE_INSN_ARRAY:
> +               case BPF_MAP_TYPE_PROG_ARRAY:
>                         break;
>                 default:
>                         verbose(env,

Think it through, add selftests, ship it.
On the surface the easy part is to make
__bpf_prog_map_compatible() reject sleepable/non-sleepable combo.
Maybe there are other things.

