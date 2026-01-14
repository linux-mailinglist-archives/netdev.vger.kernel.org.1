Return-Path: <netdev+bounces-249679-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BB1A6D1C221
	for <lists+netdev@lfdr.de>; Wed, 14 Jan 2026 03:28:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 76BED30039EE
	for <lists+netdev@lfdr.de>; Wed, 14 Jan 2026 02:28:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D2472F6911;
	Wed, 14 Jan 2026 02:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CxhjmmXL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D566022F177
	for <netdev@vger.kernel.org>; Wed, 14 Jan 2026 02:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768357721; cv=none; b=YqcvOFytzjpu0zOxN+Oj9b4tDdNBJnjXsJy+vo/U1UIS8mkmGp9vLZQz7LtqZNhnFntX1vVr5R29P/2i30oVQGK1yKYMZVw+hP/7htJDF91A6q6K6ICcXUBGVIKNzCybbzpQf2V5THUDCtSYg4f3VQvcAn8dq7RK92uBJ92FxBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768357721; c=relaxed/simple;
	bh=We8ksS5J9F+fwW62K7yMl7MOkJY7HqN+JcpNG1VVuBc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CGguveKyj2HGxrWUPJWc7+SOtzkUAfFWJLK/uOGCzTwLSR9O7JuZ1lViei0oC/py6Q3dyGBOy7UWdCkLjBM6Kyxk31+n7yEEY+v5dL0a+6ZQMXduS+L9zQdpTiExZnn75AK9J0C6P6M4iUOPVVeOPhFTegcxdD6SwCJAbyPOdrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CxhjmmXL; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-430f3ef2d37so6790812f8f.3
        for <netdev@vger.kernel.org>; Tue, 13 Jan 2026 18:28:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768357718; x=1768962518; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xz2i6YPOO/6xi7igT30rHEGAb7MGWdjsESuKyerDuWk=;
        b=CxhjmmXL4an+7h2Ej2gAuMYrfb7D/45jDvlvKoNfNzdldwJ2qZONkHWKELJz5M/Yh/
         pFLKAOb0PZk06LPp5XmwF4rmq2yNYT5+emNJwt9ZxvZKLCcd6XOEkZWSntJ711Tp5Fto
         q9PM7crJ+ER+anl+Hhif3J8DkNLos3TNvG75RfHw88dZDF1KpMhPzHFAQVvCGORrSlZA
         W/VGba0YZ2zgbTFGBIE43jxbPgKH63WzAeDAMm9CkqxbY5KfE7ylXg+gvzxBVEBWxgh4
         l9FeZ36c9yS2JfkTV79zJMqvuWucrTT9F6a7pGCDgL1Zyhsm4nYlrXnWGeWok5apkRtu
         DZ2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768357718; x=1768962518;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xz2i6YPOO/6xi7igT30rHEGAb7MGWdjsESuKyerDuWk=;
        b=unknOPc19X/gFguD3x/hGh856c251IjmlsrYDA3K5an2SE+Qb5HuExwKvNf43rgGxu
         dz93d19IJ1El7ypWP12l+W49Csw0Nq1NqBnmUyt5dJQMZHDZ+eR2hi8YN3wtAtZtiSYn
         h10R0+1HQRCQSH4Q9nJB9VJBX6GgLJi8cTpf7Y5O97Te0gY8gTGgkPm6OsCXzZeTPcmP
         hEVk7l5bXuKVh9nQjw2Fw4oD6k72jPNO4exRiI0wgzp3iVZKs8S9qkebFAOCldpwRv7G
         mE8hk47hY7jIIq0sZhMi8QYAV7YviJPpJWdAbQ8pVvpZnsrJqDpzu4ytgVRU5mxm6OIV
         5TAg==
X-Forwarded-Encrypted: i=1; AJvYcCVtQwZ4fSAYGVhQkIpY/LkwtM1WOx16aZWhb9PslLkz0fUgawHIDaddPjZdu2vBLaDMjMJ62bk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxziUHZbbcFjP5+mDWuFC4nmlsYpY6RUBMYCUICwOy6n/J9EEim
	GtIwpzgw39JSSzpxEIY8p3OPEydP/OAKTkcXzZkNShWU4k9lhM9I3+bxQqxjPkJhOikH53CVTvZ
	iNOYJRYbq4w54bfjPApcew8hmygnISVg=
X-Gm-Gg: AY/fxX4Y9StEG82TO7wuSQO9nPtgS4OX+a1Zr8ndVQHDx1zJBBVKTGuU8X615GTeCyJ
	84E8za+DMyjWI1D3HHmEG8K/VLb7NGt4Hh+NKDji3IFkACdjsFVn3JdtRmTMPTyysLfyjxggnCK
	Gn1LtM4GlIYFLvTvqwZ5MJZQ66Vc5yxzNa4nx3l5aKLiTchUR/F94+xGmAOtLkIvhJVM+IBvnSy
	9OHlQgyZj02P+XXVnFhZufx5SktjUowWGqTl7htIrJX2P23CeRJvd435BprpGdCX2lj7sIPkbR+
	HI2O6J2iBVgUpOlgyqU/8tkTtrp+
X-Received: by 2002:a5d:5f55:0:b0:429:c851:69ab with SMTP id
 ffacd0b85a97d-4342c570c23mr829306f8f.55.1768357718101; Tue, 13 Jan 2026
 18:28:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260110141115.537055-1-dongml2@chinatelecom.cn>
In-Reply-To: <20260110141115.537055-1-dongml2@chinatelecom.cn>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 13 Jan 2026 18:28:27 -0800
X-Gm-Features: AZwV_QgcPb0t4gTbhKnWfWd-cjU6WwacBGBgmdh2yTCRVFbx1Uq28J6usLIsSEU
Message-ID: <CAADnVQJw6HZHqBs6JRWkHESk=tFQpki9X6TnXBLKgeAhb6FK5w@mail.gmail.com>
Subject: Re: [PATCH bpf-next v9 00/11] bpf: fsession support
To: Menglong Dong <menglong8.dong@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@linux.dev>, Eduard <eddyz87@gmail.com>, 
	Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, jiang.biao@linux.dev, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, X86 ML <x86@kernel.org>, 
	"H. Peter Anvin" <hpa@zytor.com>, bpf <bpf@vger.kernel.org>, 
	Network Development <netdev@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jan 10, 2026 at 6:11=E2=80=AFAM Menglong Dong <menglong8.dong@gmail=
.com> wrote:
>
q>
> Changes since v8:
> * remove the definition of bpf_fsession_cookie and bpf_fsession_is_return
>   in the 4th and 5th patch
> * rename emit_st_r0_imm64() to emit_store_stack_imm64() in the 6th patch
>
> Changes since v7:
> * use the last byte of nr_args for bpf_get_func_arg_cnt() in the 2nd patc=
h
>
> Changes since v6:
> * change the prototype of bpf_session_cookie() and bpf_session_is_return(=
),
>   and reuse them instead of introduce new kfunc for fsession.
>
> Changes since v5:
> * No changes in this version, just a rebase to deal with conflicts.

When you respin please add lore links to all previous revisions,
so it's easy to navigate to previous discussions.
Like:

Changes v3->v4:
...
v3: https://...

Changes v2->v3:
...
v2: https://...

