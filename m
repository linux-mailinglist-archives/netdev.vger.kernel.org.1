Return-Path: <netdev+bounces-238833-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 97AA0C5FE97
	for <lists+netdev@lfdr.de>; Sat, 15 Nov 2025 03:37:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 5ABCF350047
	for <lists+netdev@lfdr.de>; Sat, 15 Nov 2025 02:36:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A5271DF751;
	Sat, 15 Nov 2025 02:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h+03AFaD"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AF7B14A60C
	for <netdev@vger.kernel.org>; Sat, 15 Nov 2025 02:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763174207; cv=none; b=BSjz7YIIwhLYcRRAkvDI8DuFeVGVFGBVtSO2h16lYa9wkf92fm0cU8rUpo6YRWrpRY05fglMydA75yCzRV4e9uk5+PF69uZ8CT7MoxYawmVG79tUXgcQG0QQkan7Qyw4IjogERdsUgL7LZIcNZgFno5WcUHae1fLRNj2K3sLhms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763174207; c=relaxed/simple;
	bh=8DPpuzgUgLbzWtOUVgscddNrvc/g3niB9nXpK4dm2cc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ibLZFCQLbfMR6VR+p79hcDTNqmt6oqcBfT3KoEgAT4e1zajQ7g4a6s9mt24CnJVVlKNBUNYKb15Qrnqs9pe8TB71jLibtC0HBcS1YGITZousYVTZntmSbch39fAvO7xYjsDPaEq0uKULta1jeyaM5CtOFZHQPIoLelO5wv+0hls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h+03AFaD; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-42b3ad51fecso2062362f8f.1
        for <netdev@vger.kernel.org>; Fri, 14 Nov 2025 18:36:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763174205; x=1763779005; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8DPpuzgUgLbzWtOUVgscddNrvc/g3niB9nXpK4dm2cc=;
        b=h+03AFaDJRnzpQlxQ7/4y/pcDIma+pjcjvDSvuEqiPVzH6RXGVrpRJQbaCoeU0/tUK
         ojVFPAWIfo833439wa7tdwbPw4Cvf7R+pyvIzbcuRnN4HcEK23pgsyMjRm4I01i/coaJ
         PDY5BAHR8p/u/ga3HGUAJL7iAJuPmOIAi1sS6Fc7jgR+Far6cRA8mV/sJaCPm2Bdxxah
         47eN/GnAd3YyuteRsDo15gmpMwVap+Mad8lhOdYAolnuMlPE8aZlsolCoMne95grRYJL
         2v7ZBDFx1k4xPmNjZirklYLYEUmNq4Jz2q/XeU2H5ufaQBQxUb5xqJu1RHtR0ibjrJW6
         Xa9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763174205; x=1763779005;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8DPpuzgUgLbzWtOUVgscddNrvc/g3niB9nXpK4dm2cc=;
        b=Sgu2rHLAanVOMJgbAPb9+fiXZ4veVvrb2EXFRsve1Mnaavb9TNDML0stld9CfH7tVg
         1J7TKgiqNJXIqtDJTzMt8S2CS2uqY1SHQNbdAD9N9TyD8iR7XqkCcOoRaRFItwwRvPc7
         UB9nju5f93u2XAZYxMhKyjY+lhfnH7zZpeLz40ZmgyS9W6hVwIv+M6n1Tul4G5Sswuvy
         6sY1dT4tpYVMT/BvVsWeFO5TWVugnp3+Cbk4SzbbPygdciMhqldURytVXwlKH5MBLzhy
         pvK9bheNkNSeVzRZT2gCUQczJiK4ZaHzra3t/UQEfkpi1mtQx7Io9DPdbGOk84fcyJFC
         loig==
X-Forwarded-Encrypted: i=1; AJvYcCVGQ/n+tWmpMDPTszZ93YWw2fmTsjEqkvInFeJVGsPqi3x2tcaYR5D/v7JFdrFXvknb85Xfml8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyoM/mkqt3rd/rY5uxqYBN25vuRQ6cKaoFB8eMPx3A6QlsKqgQb
	LzV5QDUZOJNQ/WmRh5HCmfp+6z0n1+/klYSDA7B53Wqte5x2RX/+TbpAWTbDtzt+Bqbla1j+gMU
	0zVAxVj4bmtUUyahYzNtgSE2AQS6GlgM=
X-Gm-Gg: ASbGncvfiNfEeSzszsxFPPDLe5e4MP13ZxpsnwEt647GNRPw3Xj3fCWH2LJCg2kTZTp
	94iRwewVziJ7USf+qwxCKDFhfT2TV2xFfoKMcipg3RTfFzBiyu+ym6CjpHE8Dyf/tLgwMCQXjR2
	TVbyBfI2K/k65vLV4/tv0cDBC9p+JWoQzGY4ARjhJdh2aotYw6vyPnBCv3fN0kX4hGHfhUQQZda
	UJg6Un9oA4mkB6KnguvBNZAF3lCS3nyi56oolo8bOxj5uOVmAB+6TuN4Re7AcY0PD1voNA+fIb5
	OTE+eW4fBy3UJu+wbWTzt/cXBy10wZbzBUzbuLs=
X-Google-Smtp-Source: AGHT+IGdjVOVft0i9MHawiL9ZDWhmz+Kp8hNgq798cxwuaLgKNAyfuoT8WLgFvbZtt+vmVSsVX969c98h0VHsBMS7ok=
X-Received: by 2002:a05:6000:230d:b0:42b:2e94:5a8f with SMTP id
 ffacd0b85a97d-42b5939dc13mr4661462f8f.52.1763174204734; Fri, 14 Nov 2025
 18:36:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <69155df5.a70a0220.3124cb.0018.GAE@google.com> <9537276.CDJkKcVGEf@7950hx>
In-Reply-To: <9537276.CDJkKcVGEf@7950hx>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 14 Nov 2025 18:36:33 -0800
X-Gm-Features: AWmQ_bmmJRmlh1z3f-9dtHoVzu-qamlHYFnpoSgZGqj_ucK56f7oS9mlr1s9mzo
Message-ID: <CAADnVQK8Viv9DTtfSQTm8T4Nuy2zoUyqRvhqTtzZWNc3By2Xpg@mail.gmail.com>
Subject: Re: [syzbot] [bpf?] possible deadlock in bpf_lru_push_free (2)
To: Menglong Dong <menglong.dong@linux.dev>
Cc: Andrii Nakryiko <andrii@kernel.org>, Alexei Starovoitov <ast@kernel.org>, bpf <bpf@vger.kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Eduard <eddyz87@gmail.com>, Hao Luo <haoluo@google.com>, 
	John Fastabend <john.fastabend@gmail.com>, Jiri Olsa <jolsa@kernel.org>, 
	KP Singh <kpsingh@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Network Development <netdev@vger.kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Song Liu <song@kernel.org>, 
	syzkaller-bugs <syzkaller-bugs@googlegroups.com>, Yonghong Song <yonghong.song@linux.dev>, 
	syzbot <syzbot+18b26edb69b2e19f3b33@syzkaller.appspotmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 13, 2025 at 11:08=E2=80=AFPM Menglong Dong <menglong.dong@linux=
.dev> wrote:
>
>
> Hmm...I have not figure out a good idea, and maybe we can
> use some transaction process here. Is there anyone else
> that working on this issue?

yeah. it's not easy. rqspinlock is not a drop-in replacement.
But before we move any further, can you actually reproduce?
I tried the repro.c with lockdep, kasan and all other debug configs
and it doesn't repro.
Maybe it was fixed already by nokprobe-ing lru, but syzbot didn't notice.

