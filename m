Return-Path: <netdev+bounces-250287-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id C5AB9D27839
	for <lists+netdev@lfdr.de>; Thu, 15 Jan 2026 19:28:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 8261A30B4703
	for <lists+netdev@lfdr.de>; Thu, 15 Jan 2026 18:08:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 684F73E959A;
	Thu, 15 Jan 2026 18:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q98W8KbV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8C5F3E95A2
	for <netdev@vger.kernel.org>; Thu, 15 Jan 2026 18:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768500024; cv=none; b=UgaWXyy4OsM6aoNzW5JmtjTN4GByVQdbfgfGSI6slJNB4PjFywPaQklxxqEqNSkhDYhNVlo4+wxsb/9BI6RbepCUe6OTVXwDkeU29VmhwMxcV4QGGKdj+UgmlnLC6kzTQ/6LsQD1hGEtVe6+7tMQEFLNlOpXxQK+csOmAD1oPzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768500024; c=relaxed/simple;
	bh=vLddMxM0W6026RbjbLsRAyK48T0JMu6b1ru+OYq9x+Y=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=laeCONNDb27gyssz6caTaq03hNShmlDy21ifGsr5GT+uXPG+Zzrew+sUDTtV03MBHXUPZZQgkYzjBzjkRBbp3+/G3c8WMsvGMQB1pGS1h401AE5jS90Ke9FqQ3JHYaG4AxoEOziXOorgEU6gWl/RFdp2HM0C0q1KtVaD7LSR9Tc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q98W8KbV; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-4327778df7fso719288f8f.3
        for <netdev@vger.kernel.org>; Thu, 15 Jan 2026 10:00:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768500021; x=1769104821; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=8THmu0qXU1sZub569pYlCPkbhQYfiv8r3J7zMWrHXdE=;
        b=Q98W8KbVD0HNwCgzTK/NzQjs7GwQ8LlzVXscW6qR5zM3u/JEKK49xq2wVfvSrBM5hz
         wrjQ3Keo1Dkesj1NSgyflDA93bKlJr1/XlBUiPIYOlMBXdnIRDiHqWICuAE0eTOuflM7
         wakFJkdpJGUu9AtDdJfWUEKSYcSNyOPJd8zPPySwPWfsYRXtEMmm+JxX6By/DYizyERV
         QGlnQyAI7p8p8yn/NPrfLhnH+5GtykFM+nEGpqjt30Hxo9Xbwh/0IP0u0Q37CiCgg0Gn
         sbn95rjNZcm2YbXypPimgYoZa6PLazYTKFIbtnBKPf4RM4QbcCNJWAQWAhkdb73r28Ua
         HGeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768500021; x=1769104821;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8THmu0qXU1sZub569pYlCPkbhQYfiv8r3J7zMWrHXdE=;
        b=dap4l4gWbgb0gnqsKy5zFV0M6Fok+d+i4T5pBwVZFmOkvhFHI39kUdCWYGfdKYemwP
         EIs59c+FgGFQmYP7Rxfv+vpqvi/O2e773HLcnrfK1TX8Km+gC5+AWsxTXIn50eelIc1h
         dU36Rfv7qSEOD/+9RUjgsKKrDBIHV8yEiiC1YiTh2D5QR4b1ZoOi3M/fa2qMCLz4tkby
         3MiG7O0SZ6q4uXcyDoDQwo9PekuzzWge2KxkeSMgBXDmZZXrq/wFzR/Sj4/N/4BAHB/p
         h1rN5AXbasu9DjwyJ1FKNbfS+zs9W+supMYozPnIId1kVDNQ7YMn+tgs7C7Bxcyc2PbI
         PGSg==
X-Forwarded-Encrypted: i=1; AJvYcCWLs/8qk0TllkgkL8MRhAhHFalHT+EtgJISdrQC0RSvFCOeDuAfgqMuydBRRnI+xMaRUNU6wFk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6k/8OtaqsL/YQ8t1CCaGBzPDG825TwdgDtfHjF41odovzHEsb
	AgPE9LF1XS0gvHNCPss4NVbUXqTcFGmPENiu40Jo7URjD5S7hfMRFHkx
X-Gm-Gg: AY/fxX5e8bZDOPzIP6zguBFB6VoUjydkwJ9KawFkgAZMvlS2/jK5zMW+eiwtK5yMcpu
	hUV71r0Ldgf3RFOBkRXt8ourCbCWKsZ4cn5to1sTlGlkKbdq9cqXeF1TuWDFFORj5VFMsK5E0Be
	Wt0q8EHV66e+CCBb6hL5hStkQiLbIAk3adoRf3pfYdeXqb80s+XqV4M8wRC/XXtW5id02PPDHVw
	P5JprtXLOK5sH+hPUi4+Z3haHWn4UsgA8ra+FrjcgrSH6VrnafzWo/weCrrHqJzmtLLpv2dAKoo
	8WKcV+BhuhgIvo4HL7xw86Xyek8NSZqVbLwNXIxQ2apn1xZy6+mwOpKehPf3zXxsMJ5xs3TFQYg
	BPZqmgFrsBxz+lnTK23pfgcWjm5D3/NJem5Vn+jnSnpKBghD0vtiDSujk6h+rq8chwqNsoiHuhA
	8=
X-Received: by 2002:a05:6000:26d1:b0:431:2cb:d335 with SMTP id ffacd0b85a97d-4356a053852mr135704f8f.34.1768500020783;
        Thu, 15 Jan 2026 10:00:20 -0800 (PST)
Received: from krava ([176.74.159.170])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4356997e664sm280337f8f.30.2026.01.15.10.00.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jan 2026 10:00:20 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Thu, 15 Jan 2026 19:00:17 +0100
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Jiri Olsa <olsajiri@gmail.com>, Leon Hwang <leon.hwang@linux.dev>,
	bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>, Puranjay Mohan <puranjay@kernel.org>,
	Xu Kuohai <xukuohai@huaweicloud.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, X86 ML <x86@kernel.org>,
	"H . Peter Anvin" <hpa@zytor.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Network Development <netdev@vger.kernel.org>,
	kernel-patches-bot@fb.com
Subject: Re: [PATCH bpf-next 0/4] bpf: tailcall: Eliminate max_entries and
 bpf_func access at runtime
Message-ID: <aWkrMckumhQErMmV@krava>
References: <20260102150032.53106-1-leon.hwang@linux.dev>
 <CAADnVQJugf_t37MJbmvhrgPXmC700kJ25Q2NVGkDBc7dZdMTEQ@mail.gmail.com>
 <aWd9z8GVYO12YsaH@krava>
 <CAADnVQLxo1uPbutGNKrv=f=bSVkzxOfSof0ea8n7VvqsaU+S3w@mail.gmail.com>
 <aWgD3zH7vsiBdIcr@krava>
 <CAADnVQLHVogD1mjMCsHcJOayuZW4OwadEN0g9wu=6d97uRSWqQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAADnVQLHVogD1mjMCsHcJOayuZW4OwadEN0g9wu=6d97uRSWqQ@mail.gmail.com>

On Wed, Jan 14, 2026 at 01:56:11PM -0800, Alexei Starovoitov wrote:
> On Wed, Jan 14, 2026 at 1:00 PM Jiri Olsa <olsajiri@gmail.com> wrote:
> >
> > >
> > > > fyi I briefly discussed that with Andrii indicating that it might not
> > > > be worth the effort at this stage.
> > >
> > > depending on complexity of course.
> >
> > for my tests I just had to allow BPF_MAP_TYPE_PROG_ARRAY map
> > for sleepable programs
> >
> > jirka
> >
> >
> > ---
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index faa1ecc1fe9d..1f6fc74c7ea1 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> > @@ -20969,6 +20969,7 @@ static int check_map_prog_compatibility(struct bpf_verifier_env *env,
> >                 case BPF_MAP_TYPE_STACK:
> >                 case BPF_MAP_TYPE_ARENA:
> >                 case BPF_MAP_TYPE_INSN_ARRAY:
> > +               case BPF_MAP_TYPE_PROG_ARRAY:
> >                         break;
> >                 default:
> >                         verbose(env,
> 
> Think it through, add selftests, ship it.
> On the surface the easy part is to make
> __bpf_prog_map_compatible() reject sleepable/non-sleepable combo.
> Maybe there are other things.

ok, thanks

jirka

