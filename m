Return-Path: <netdev+bounces-247326-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A02FCF75D5
	for <lists+netdev@lfdr.de>; Tue, 06 Jan 2026 09:55:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 301B530321C7
	for <lists+netdev@lfdr.de>; Tue,  6 Jan 2026 08:54:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39988309F1C;
	Tue,  6 Jan 2026 08:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lZwDaoWC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8203E2D8390
	for <netdev@vger.kernel.org>; Tue,  6 Jan 2026 08:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767689698; cv=none; b=ltQLrLpIiv8+n5C7CIgo9IYnbLxAqWwPSckXYH5FZmedzcKb+QubaVNs9ycL+tz0GT8u1KlryTWeVsTHTveMo7UN3IdRA7PSAGXVs+ztY4GoSNppOegJHrVkzseRLPdFg42aeTKaLX6J4pa2MWUl73QtQWhbys5BQepmzthv1pY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767689698; c=relaxed/simple;
	bh=PudlsRY3cvqbF7BFTjTmjHdd6JA+NhtrLbq618w/VX0=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dZdAx5CW6zpTktYcLu3t8u978AwvahOkFkkbl/v1PGpLz5AzACp44EH+FTXTJeVUIQfNsRK0C07a3t9pZeKV2I+quqcK7ce1CegbRkQaDSmgOWfBXP6YfcrT6j3vEBVYRaO9DWPN417NvdCJBogR+WQNp/0iLaQykh5fTxfxlb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lZwDaoWC; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-42fb03c3cf2so360468f8f.1
        for <netdev@vger.kernel.org>; Tue, 06 Jan 2026 00:54:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767689695; x=1768294495; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=5VFZIns8Sps8uOV+Lb1ng4HSSezSvHcqd+Ga21Q6rkY=;
        b=lZwDaoWC0pLFrRoqBVNRfWw/rw97ABblYqrkhTHMC+N1lyTQ5JW/CT+h2HZjlhCiXL
         /4chn7qXE8Gsukd7D9w+MbECleYtCrZrLt6axk5b0NX40FsXcOaV/qFYVTjrcZn/0YgH
         BYMrMZHH+HKRtrg2kMSM6kSzvTZWAunT2JtZyWSLdHNaTJxXO8La4ThR24CQoMEX4LYG
         d+VpoP4ftWiUOlDIVCljKijAqdSqzXB4eAeQ8oCYoqe9ukBP2uu7bUscbAVGjT2MpASg
         GY1SjDsRg8Z65J3CxZTYNFlnhmAZIB4Cj/8puVaOkImWNuwPpz/ChiTG4Wwpd4V5U92q
         tVFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767689695; x=1768294495;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5VFZIns8Sps8uOV+Lb1ng4HSSezSvHcqd+Ga21Q6rkY=;
        b=hBGRCRw9mN359nWcICnOnk40mICMSo4nUMWq9bTNptONrQa8OZPQ7lTLSYC15m7Hx3
         YMM82ENPywXpUhFkIZYkWBx5jyrx0ySTmxRRkfXS/+3CHzTuyie7h1jN878FyPSUW2V5
         2TKIaqCd/34SXnY/g0PL0gs+vweH+DP/4gG+pLumK/e8ma6GrILxtlwYbJfRdtQ+ysYA
         OwYI1bWMMvBXCf+mXsbC4po5+jUzjNm4ndvbv4LVWmxtKupMgifbTJ4kUcuEUeF7hnIp
         VpLoTs65FNoisgEyO/BP9tFvFYmCfipf52zoLMH85VEQMWbGDHlGqf6TGVZqvnDnPOgO
         TEFg==
X-Forwarded-Encrypted: i=1; AJvYcCVJP3hWFf05aAD0WXhO3yoeUCyNoBn9Jo8XOfHpCpVb8+wlNVoRkUiW7rwJVzO2CrXWFOkUTiE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyi2jFq7w6I4y5hQw8W/IKmQsJmQj2nZSriubIcaJNRFWkQCIBK
	hdJGFLoyA2regs6mfCaemLU/cHWCjcp19Gne549dX+sAq01bP/9oClgp
X-Gm-Gg: AY/fxX4bPhahA+LVFCyUV3VefaGF0NkTXQfQL+/D+HT9pDXzSSF0YlEttT1JsSvD94Z
	tq2CXwM8sc8eQjios5baXZ7YtpVIlwoF2EfZ0CJmvqr54y7X6JHM9NMZS6S1PU7NbGo+CCsjwJA
	mgROmHu0iwWXJ3n4caEjIrLCcOYUvZyrVqOdD2lHxjRnW5F7JVr0yXrNXebS/nNJBqit6rho1Dk
	YsIlNTBgAdfG4IjzwWiZozYOsbYaEe1XCquMTiVdb88UknftBZiEGQHTIxs40R7UPUZScVUXs08
	DPqkWXWICDKnbyKjL7kTVoskPGRwwTIN2pY4ozu123fp8cy+qW8aYBChBhs5b4A/NyKud4QwRQp
	nAzvrzTe4LD6kzNGZDs67FqAouPp6zF8e8CTqH4BnkfZ5AFXO7ytHoqZH7xRCyP9ZQ8YYnj9Qeh
	Y=
X-Google-Smtp-Source: AGHT+IH1yCSdo0wPw/fy27nRhjvHjHheYMekyT9VVsyxylC5DTp4JUsf3SZIIRTA7LE1dNPIlcouGw==
X-Received: by 2002:a05:6000:200f:b0:431:b6e:8be3 with SMTP id ffacd0b85a97d-432bc9f6dccmr3306578f8f.38.1767689694636;
        Tue, 06 Jan 2026 00:54:54 -0800 (PST)
Received: from krava ([176.74.159.170])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-432bd5ee243sm3075703f8f.31.2026.01.06.00.54.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jan 2026 00:54:54 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Tue, 6 Jan 2026 09:54:51 +0100
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	Menglong Dong <menglong8.dong@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, jiang.biao@linux.dev,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, X86 ML <x86@kernel.org>,
	"H. Peter Anvin" <hpa@zytor.com>, bpf <bpf@vger.kernel.org>,
	Network Development <netdev@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH bpf-next v6 00/10] bpf: fsession support
Message-ID: <aVzN28i92roV1p4q@krava>
References: <20260104122814.183732-1-dongml2@chinatelecom.cn>
 <CAADnVQ+cK1XvYrBPf3zuNmRF+2A=i-AKGaNV4SoeTUeGRLF2Fg@mail.gmail.com>
 <CAEf4Bza4fD5WWWBxJk0dd_xvgPR0ORZpcp1wiahyMPjvdoWG0w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4Bza4fD5WWWBxJk0dd_xvgPR0ORZpcp1wiahyMPjvdoWG0w@mail.gmail.com>

On Mon, Jan 05, 2026 at 03:20:13PM -0800, Andrii Nakryiko wrote:
> On Mon, Jan 5, 2026 at 2:33 PM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Sun, Jan 4, 2026 at 4:28 AM Menglong Dong <menglong8.dong@gmail.com> wrote:
> > >
> > > In current solution, we can't reuse the existing bpf_session_cookie() and
> > > bpf_session_is_return(), as their prototype is different from
> > > bpf_fsession_is_return() and bpf_fsession_cookie(). In
> > > bpf_fsession_cookie(), we need the function argument "void *ctx" to get
> > > the cookie. However, the prototype of bpf_session_cookie() is "void".
> >
> > I think it's ok to change proto to bpf_session_cookie(void *ctx)
> > for kprobe-session. It's not widely used yet, so proto change is ok
> > if it helps to simplify this tramp-session code.
> > I see that you adjust get_kfunc_ptr_arg_type(), so the verifier
> > will enforce PTR_TO_CTX for kprobe and trampoline.
> > Potentially can relax and enforce r1==ctx only for trampoline,
> > but I would do it for both for consistency.
> 
> Yeah, I'd support that. It's early enough that this shouldn't be
> breaking a lot of users (if any).
> 
> Jiri, do you guys use bpf_session_is_return() or bpf_session_cookie()
> anywhere already?

np, we can still adjust, it's in PR that's not merged yet

jirka

