Return-Path: <netdev+bounces-208601-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 68505B0C4A6
	for <lists+netdev@lfdr.de>; Mon, 21 Jul 2025 15:01:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B361E3A3753
	for <lists+netdev@lfdr.de>; Mon, 21 Jul 2025 13:01:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73E8A2D836B;
	Mon, 21 Jul 2025 13:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=readmodwrite-com.20230601.gappssmtp.com header.i=@readmodwrite-com.20230601.gappssmtp.com header.b="jxC2utf4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1541D2D7805
	for <netdev@vger.kernel.org>; Mon, 21 Jul 2025 13:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753102907; cv=none; b=eAkHmKwxbmDImYVzt9CdtCFsxbo2SCc0N4N/FRY2UgZ3tcIMQuBiAkiQwvinhB409+u04AYBoyuaDbLZoz57vfKM6VAW6udSeJogarCMsiyrP7NAQfd+nI7exZp5aLqitWeXG2Ph6iPYJnPoc1TmUZxMzMWQuZy8vIWsiB/rYow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753102907; c=relaxed/simple;
	bh=lObe4xQq7y7sV9eXXp3dYC3/nrQJ+ma8WyXvYw9iWKc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pX6KGamHXWDs4lRmUFveAZ5fZC7KOqREKP9NE2Fb/L41T98UlPf+wOPZTZOnTNc7dneb5+Eq8XMcPBzb28AcEcLVOwouhyDBFS+T4BfOOl5/PkDWDqnVtfosszazXJlotqFj5vjEC00GU7s9fh/H/eg0SyghPKQgf+/agPkFAfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=readmodwrite.com; spf=none smtp.mailfrom=readmodwrite.com; dkim=pass (2048-bit key) header.d=readmodwrite-com.20230601.gappssmtp.com header.i=@readmodwrite-com.20230601.gappssmtp.com header.b=jxC2utf4; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=readmodwrite.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=readmodwrite.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-313f68bc519so2679452a91.0
        for <netdev@vger.kernel.org>; Mon, 21 Jul 2025 06:01:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=readmodwrite-com.20230601.gappssmtp.com; s=20230601; t=1753102905; x=1753707705; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qxRzWZ3OiN4FOr/n1+PHB32FHELlvgJzpX0WolbMnx0=;
        b=jxC2utf42a6g7aCyFmrDQyWxPDj6WeqAKU5QsUEk9rzK0HlcY5z/SEQ+MBtHf1XZoy
         lRWgDPwZiAsl+w+3wPF5c7QrPcXZq5mmx6k2WE+V9ADipCAMoCgXPjzKFdqvSuOTMus8
         KvgkYfWlz47j98/AZ+vcxA4mlPkMK/cNeOEtRhA1Si0ytX5CBBSrYt6WtaQOR+nfL1ZY
         YISlEu6f+bMWHHo8lzWDgiQcaKJmst8gyp80/oab+XKQ8lLvEAuKft5cbYlRGLgQm4Na
         7nxMLJNhZ00T264XJQbsbC5CAAoswgy7ozDFNCiixhHaFGKOj+IlBc+GXAqSgSihfFLp
         ilSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753102905; x=1753707705;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qxRzWZ3OiN4FOr/n1+PHB32FHELlvgJzpX0WolbMnx0=;
        b=S9gnjc4FWngWRFVu/sQgwdm8XWXbDh8wI2mivMGq2TYze6TSn9s8fF+9aR0nB0H8u8
         bMKbSj8sBMuI4OS0dRn2VhFNaXSt3c/EowRvmTH7gzNj355kIvAu1fHvAbaNLBT821Z4
         7ldfV1dzQPDveQenQ/4bJUrSB6fZoPvb2eSlY/7eMeAFy2B/zXnB/SfxIuZ9mDBscsfU
         BHKhoDvmuaK1x630+2wEeT0b0ctKO7ZztktvuAwrtqJG2CNlA1vNOQEAV7K4iXd9d7Y3
         PvOmCX4RA3HjbjEdTauba6KQ4MkA0Cm4RqB7567UNZXNsx0O5h2SIhFp/ga2LnCdLPD8
         Y1+A==
X-Forwarded-Encrypted: i=1; AJvYcCU5J1rPSkBKkv7Zj12QmCCzKglGzBO9ZqSYNAqriwrqeqmJagDLroDaGOry/tSzXmCDvx0b+68=@vger.kernel.org
X-Gm-Message-State: AOJu0YzenSdMzbUR96djEnN/4Qaw/vDludxHxV0lYqeqr+BDs+tG3iOo
	g+camI2JnRZkcXGB9fGLcBF/NNuAiqwVtObkehD9Tii6Mtg3QFOXuXdrYVjpTuy1uGl7l08J0/q
	NaBgE4iWjWpVd/GFrK4ALHmrXvlpDG/DUmrANZov2FNB3GdC7O7ds
X-Gm-Gg: ASbGncucY48AxeY5kzBorfcwpdaf+PyxwbN9vUlqr5oJBcxwB7UIcemL3lk1gu0geVM
	vD5FYauHYN5JBcZwkIPSwvwh2LKS3Eb1D4dV97NTZDQTp2vGxZmpV5TlVsBzYix5agoAgf2sx92
	jh0lXzJW94sRwY0Yru/2I3sW2xI1F+ihZ3V41inFFDJzazRmVasx+qY4+FeFygQr46eV/NYGIAD
	4L37N8j688tXGfFa5tcreg=
X-Google-Smtp-Source: AGHT+IGzAppY+Mxy5qmnlvBrX3tf7sTF4dGXTD7KnY/IuDlf5WJgBbAFdO38e7rnT91cKVn/9FtpLq3NJZ1TQj3C21g=
X-Received: by 2002:a17:90b:1fc3:b0:30c:540b:9ba with SMTP id
 98e67ed59e1d1-31c9f44bc2dmr32037532a91.10.1753102903531; Mon, 21 Jul 2025
 06:01:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250718150554.48210-1-matt@readmodwrite.com> <81cd8749-6212-4fcf-8e1a-5eba5a8e2a73@kernel.org>
In-Reply-To: <81cd8749-6212-4fcf-8e1a-5eba5a8e2a73@kernel.org>
From: Matt Fleming <matt@readmodwrite.com>
Date: Mon, 21 Jul 2025 14:01:32 +0100
X-Gm-Features: Ac12FXzd0fWwBUJ6czP3EpQRC9Pxf3NK5Ala9zRsgvMp5hrQxZvDDxiuCtMHrac
Message-ID: <CAENh_ST_8XN2+QT8xz1gcKyovwEGwO-j2-YHbMj6GrWuZcgRag@mail.gmail.com>
Subject: Re: [PATCH] selftests/bpf: Add LPM trie microbenchmarks
To: Jesper Dangaard Brouer <hawk@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Shuah Khan <shuah@kernel.org>, kernel-team@cloudflare.com, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org, Matt Fleming <mfleming@cloudflare.com>, 
	Yonghong Song <yonghong.song@linux.dev>, Netdev <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jul 19, 2025 at 2:15=E2=80=AFPM Jesper Dangaard Brouer <hawk@kernel=
.org> wrote:
>
> On 18/07/2025 17.05, Matt Fleming wrote:
>
> > [...]
> > diff --git a/tools/testing/selftests/bpf/progs/lpm_trie_bench.c b/tools=
/testing/selftests/bpf/progs/lpm_trie_bench.c
> > new file mode 100644
> > index 000000000000..c335718cc240
> > --- /dev/null
> > +++ b/tools/testing/selftests/bpf/progs/lpm_trie_bench.c
> > @@ -0,0 +1,175 @@
> [...]
> > +
> > +static __always_inline void atomic_inc(long *cnt)
> > +{
> > +     __atomic_add_fetch(cnt, 1, __ATOMIC_SEQ_CST);
> > +}
> > +
> > +static __always_inline long atomic_swap(long *cnt, long val)
> > +{
> > +     return __atomic_exchange_n(cnt, val, __ATOMIC_SEQ_CST);
> > +}
>
> For userspace includes we have similar defines in bench.h.
> Except they use __ATOMIC_RELAXED and here __ATOMIC_SEQ_CST.
> Which is the correct to use?
>
> For BPF kernel-side do selftests have another header file that define
> these `atomic_inc` and `atomic_swap` ?

Actually, we can side step this problem completely by consistently
using __sync_fetch_and_add() for duration_ns and hits and removing the
atomic operations for DELETE, which doesn't need atomicity anyway
since only a single producer can run.

I'll send a v2.

