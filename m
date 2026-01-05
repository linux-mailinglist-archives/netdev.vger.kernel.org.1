Return-Path: <netdev+bounces-247221-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 46148CF5F63
	for <lists+netdev@lfdr.de>; Tue, 06 Jan 2026 00:20:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E6425302D3B5
	for <lists+netdev@lfdr.de>; Mon,  5 Jan 2026 23:20:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 090062F1FEA;
	Mon,  5 Jan 2026 23:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aiQNpLCj"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 921643A1E6D
	for <netdev@vger.kernel.org>; Mon,  5 Jan 2026 23:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767655227; cv=none; b=qDeBvZJ3xrnzrsYvXX8Gu9x/YlaOiJsZTNv1kbM/WyZhaWXklvAubchmZ/y4RkuX0biRBwpXrGJec28IKhVh89KefiZg5okZCr08Rw3nkOH7cRVdehZVKsu75dPlf3USOkpkVmwjQaI62F7v8QVrkvuFyP7DhLHCjg7xK8+9wsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767655227; c=relaxed/simple;
	bh=0E+4QPBstXUcDSUWtVQHs8B2Asrfe/YhSkOUHNYyQP8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h+YSQZSK9ZpSxky/soXDiE96EVZssh7SkKvAW8GN8Of/yV1fqpod77Z6c7sk6mmrdyswxiAYsF8qMzvubKRrUgiCbDKWDTZHhdWf4ABpVG2169tHIOKNvq/w/teb91Ai+keRmts9jJhNqEt+4gvzhCmFi5iWdqPJ6ksBk4ej3qI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aiQNpLCj; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-7b8e49d8b35so550082b3a.3
        for <netdev@vger.kernel.org>; Mon, 05 Jan 2026 15:20:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767655226; x=1768260026; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0E+4QPBstXUcDSUWtVQHs8B2Asrfe/YhSkOUHNYyQP8=;
        b=aiQNpLCjUxuOQ3UJ5FYQRkvtCbWyoZwG12ZeKx7XVgEJJ074poojBtvyedqcgRWjqS
         I8SnlZxW31rzc5xWi6+NGqkVhNrPe31ttRaxriYb8D/KDM9bwF1AYNDdYLI+T/TO+sli
         whhWxdA5JgHubQEV4tGaCCG4xALLn9eZLQa9XEVBOJ/3TLp/Vf3sdDaNCTejFc+QG2Lc
         SaK8X5y7/gpx+ghEr2Caa0HpO+UoudSZfUa0dKFqZwV9OIMXIBvGBdMMSV3tbIr9htfI
         utUHWFZQ1MmU0BfrGEiPeli+py9Qfh7610zInrO+70kKV5w1CVsEqIPsdEOwqEbTO64L
         xXRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767655226; x=1768260026;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0E+4QPBstXUcDSUWtVQHs8B2Asrfe/YhSkOUHNYyQP8=;
        b=S/JxRwA8dq6VByBWh+mlN8DSU7CAowlvjKdqdq+ajK4ANIosmEN3VFfI1l9naPL5xo
         myfLIvhunbE+AUFxqUn+stb5hI8lf9GRkcyLdgoKFIFF2KTzvIbBnrNP6gJKYCBoQJmK
         CPrfj+OyrmsMpBs50go2D49YXrlcB2aYw5F61lHBKwa7Qzyemp6VL2aS7an9aEF3PVYv
         oYV5+UzhQFLjweL2gK0+jJ0iKPxcUhG+b0NyAiWuaQ8nmXzh/u4rrEZe6rQl6BN5Dcv9
         hLvYzO+mFlut1JafRoye+cTDFW2Hlm038NVBxv8R/Yn9TOEhs8q7aqyGCZmeieKMwZ8H
         fzuQ==
X-Forwarded-Encrypted: i=1; AJvYcCWcLZNDulpo2b4+us0a/wEhfq++MZnrD83DRaQo8D7HjsXbjEoXQBvYeGdn2zJHJQy9suFabPg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0IgWlyCsNG3tIUWfWaWls5sjB8AbBMD94ygcBuPBVsr4f5H5s
	dBOCIypoj24/VpWfOaVYgQl2rKblj6dWOxcpPtS6r8B3r/bAmoVkq4HX/krT6rnHUl+xgMMiLR5
	cfr0JNQmvfnLWGPOadT1yY4wZWRLHUtQ=
X-Gm-Gg: AY/fxX5I+MJZ1GbFHT8PbaHOFWe4Lo/NSoB9d0z/9YWkAsfRK9UYk3TE/eqRP21fvYZ
	K/ItwWTwozGAG+NC5G+Ddri+Nq1htqTyOSDImde4YNxLYXpDH9kIZQCN8pGaNcHJsl7X+0lGdNa
	CUSh950Vqprd0H2tWITA6v7HXCNr8YOKGikFtmyTrZZEdgazbTXPOzQgKn7FLQUtLS/Uy5vsRPZ
	ikVZ/BmtBBzYMF/W+f9DOX7s/+MU+BCJIoSvgaZZbak3mG/ZUs9nvidDxxGq1yfGfB4vE9tl8X6
	G2BP5x/huAg=
X-Google-Smtp-Source: AGHT+IFuFoCraIRea4qJ15vjHbQ1kIwwD9aKbmZqN1IFqHVG/eU6maV1Menh/bm6z+1shlHBeKJ063tmJwX6QC53aFA=
X-Received: by 2002:a05:6a20:3d21:b0:355:1add:c298 with SMTP id
 adf61e73a8af0-389822f565cmr887636637.21.1767655225850; Mon, 05 Jan 2026
 15:20:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260104122814.183732-1-dongml2@chinatelecom.cn> <CAADnVQ+cK1XvYrBPf3zuNmRF+2A=i-AKGaNV4SoeTUeGRLF2Fg@mail.gmail.com>
In-Reply-To: <CAADnVQ+cK1XvYrBPf3zuNmRF+2A=i-AKGaNV4SoeTUeGRLF2Fg@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 5 Jan 2026 15:20:13 -0800
X-Gm-Features: AQt7F2rHkS7ZrHcrANFCtqfQxw4ogv5j_Cyjsb5vUpE0ah3hN7_wtOLCd4Zs2dM
Message-ID: <CAEf4Bza4fD5WWWBxJk0dd_xvgPR0ORZpcp1wiahyMPjvdoWG0w@mail.gmail.com>
Subject: Re: [PATCH bpf-next v6 00/10] bpf: fsession support
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>, Jiri Olsa <jolsa@kernel.org>
Cc: Menglong Dong <menglong8.dong@gmail.com>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	"David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, jiang.biao@linux.dev, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, X86 ML <x86@kernel.org>, 
	"H. Peter Anvin" <hpa@zytor.com>, bpf <bpf@vger.kernel.org>, 
	Network Development <netdev@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 5, 2026 at 2:33=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Sun, Jan 4, 2026 at 4:28=E2=80=AFAM Menglong Dong <menglong8.dong@gmai=
l.com> wrote:
> >
> > In current solution, we can't reuse the existing bpf_session_cookie() a=
nd
> > bpf_session_is_return(), as their prototype is different from
> > bpf_fsession_is_return() and bpf_fsession_cookie(). In
> > bpf_fsession_cookie(), we need the function argument "void *ctx" to get
> > the cookie. However, the prototype of bpf_session_cookie() is "void".
>
> I think it's ok to change proto to bpf_session_cookie(void *ctx)
> for kprobe-session. It's not widely used yet, so proto change is ok
> if it helps to simplify this tramp-session code.
> I see that you adjust get_kfunc_ptr_arg_type(), so the verifier
> will enforce PTR_TO_CTX for kprobe and trampoline.
> Potentially can relax and enforce r1=3D=3Dctx only for trampoline,
> but I would do it for both for consistency.

Yeah, I'd support that. It's early enough that this shouldn't be
breaking a lot of users (if any).

Jiri, do you guys use bpf_session_is_return() or bpf_session_cookie()
anywhere already?

