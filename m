Return-Path: <netdev+bounces-221023-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C8CBB49E74
	for <lists+netdev@lfdr.de>; Tue,  9 Sep 2025 03:01:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 17BCF3A77AF
	for <lists+netdev@lfdr.de>; Tue,  9 Sep 2025 01:01:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B352B21B9F6;
	Tue,  9 Sep 2025 01:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="U2cA1Iwt"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 413591EEA49
	for <netdev@vger.kernel.org>; Tue,  9 Sep 2025 01:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757379707; cv=none; b=JKEy2wuHLSF1ZxlmUIxJm/9W++46UhEQcU7Mcy2f9LJcq4EYO3xv6VRscasOTVeuuNFm4h+ZGlSzShVR9o07Pd8CdD2aONBVkrnz3jfGIn5aezjOeUlxXbWhM9jVXvTQfoYciQFK9u/teP/ZwN+suXkAapFjpGgAmnhOChzwmJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757379707; c=relaxed/simple;
	bh=D8q4oz+5nQ+UM/w4vLFgmI8FUHgj0o4Jl+WMAS3scsA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EULJdi/C0mETwFK/vQm95/x6JkV6/XfNlnJhNMpdl4RA43rDAZIzpgAOlt7ROuTF6EjgJ4n6CU5O7OppXyCsBayes9BBW9G4g4ijB6cruQ1bL4L6f/QEAB0x7uouhtvyTbQz5dgjXQxIdeyXhVklGJ2Nu2DnhNupp29f78hxL2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=U2cA1Iwt; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-251fc032d1fso28455065ad.3
        for <netdev@vger.kernel.org>; Mon, 08 Sep 2025 18:01:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757379705; x=1757984505; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D8q4oz+5nQ+UM/w4vLFgmI8FUHgj0o4Jl+WMAS3scsA=;
        b=U2cA1Iwt+7QWVVP6lkooMkFChrTRKqwBLENAXXCFpdVdF+HPz+BidLqv9BuPSkuBB7
         8xq/dx5PudU+CO8AQIX5et7mEK1JuH6TdoOpM6WwqvoRARYmnGgQPczDD4JVYZ72+BxP
         DwUjB/Y9mnJCgYMS4KShI0RJn9nEnEgmwcW8kixHfn65n5M9w1RWKXCmjY9TTeHAGjC2
         Wsytud8gxv23mNow+wggSCxqbOSg3TwJV3SSPOX2GxGtai+jdKPa+o89m3buUYChj4bK
         Toxne8hYW7MADPThAOOuCAMdVtkqf/JDDcQwgCC+18ejrLO7jT8BNTtNC52sCdgL9A9M
         197w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757379705; x=1757984505;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D8q4oz+5nQ+UM/w4vLFgmI8FUHgj0o4Jl+WMAS3scsA=;
        b=OHgMkYR0ySncAo8ESuqX7HEXWzsycr+KX6geaX+x9CaTbuiuSefEyG01Ne/RH2Jz4X
         P0AA4l3m0AtNMp7fVnHiUnXOYey1zcc979mhuXSSN9c5ELBerHgJ7u+X3MRP+PJkFuHg
         cCyybhTO7rrokslzv0MszSQ4Jl2KlzWuphKUZtpCx99sHPU1qTUqh1r7qOdut8TWQKuw
         DIVIIT+Aal5yLqzq/zN5xWGYjA/+N3Bk3GtPdVriChkToC4WaT0qri1vq5ryHE8Up5v4
         ToKUZVOWUOXq6yFgH2mDkzZH4HlXiBtnHgBX30xZ5W8q20Ihob8in1IOOQMqNzPulzn0
         vp6A==
X-Forwarded-Encrypted: i=1; AJvYcCX6JP7DvgdHRVPM+2pNMljAYBOt3h4ZdSTvRPi4bY9K85Di9VDG2Gl6jBkjveVoqHhkg+aE0AA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYylrQVa4rx0e5ElpOTV6xszCUVZ4hvI5tYPwCLOwohY+BkVwx
	iEHsCzWGANIioW2OxZuFHE7kri+jGiVHi5chZAu4NmLEiQxqipZY1+F1lq20XQaD0YDJInV+Fuv
	eiSz4EtfPls0I3Nr3q1jHgwWF3digMGH1g66kGHJk
X-Gm-Gg: ASbGnctCw5Dc5oFVwWJ3BhLVVw0xfDwQuPGqkoPqpnLefqJD1Jn/smi1AclR1eVNSS5
	F2kmpQiD3CoyYxudJPNtbWqk/TcHYhGDUnJPpdJJhAhDyFs3hx0Amc3oU2MNJxKqaUmqsyszWCm
	dqNRZDDsBl5wyKvkiz9UkfMqFals4yTY5cpfjYT1rEktgT88XNUPnoNQhXV5JG0OLhF5RerTEjm
	RXTOzAFgn0aKZZNexnTmZe4xuWEXHs3upaB4m4a
X-Google-Smtp-Source: AGHT+IGbfF85Gb8yUX1S5kLrlaqHX4+uOflDbv+3FPsdm9s3A4fbVGZGXb/apYzXp9uLCO3LRWcHy0W8tfE+64q709c=
X-Received: by 2002:a17:903:ac5:b0:240:6aad:1c43 with SMTP id
 d9443c01a7336-25172578d86mr126852905ad.48.1757379705302; Mon, 08 Sep 2025
 18:01:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250908223750.3375376-1-kuniyu@google.com> <hlxtpscuxjjzgsiom4yh6r7zj4vpiuibqod7mkvceqzabhqeba@zsybr6aadn3c>
 <CAAVpQUC1tm+rYE07_5ur+x8eh0x7RZ2sR1PGHG9oRhdeAGBdrQ@mail.gmail.com> <r2lh33nhc5pyx7crfahdeijd5vdq74abcmrbqkls2zwnih76fk@opua7takczmc>
In-Reply-To: <r2lh33nhc5pyx7crfahdeijd5vdq74abcmrbqkls2zwnih76fk@opua7takczmc>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Mon, 8 Sep 2025 18:01:34 -0700
X-Gm-Features: Ac12FXzmOHLKUGla1DBqQy8MItu9iGPqcKsPVwmymYI-Zh_kp_tuOXZOHFq_XaE
Message-ID: <CAAVpQUDBF8_GEuhrQBHaTkAAFX0C=zwnjifmyMnRkMDAyWDdbg@mail.gmail.com>
Subject: Re: [PATCH v6 bpf-next/net 0/5] bpf: Allow decoupling memcg from sk->sk_prot->memory_allocated.
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@linux.dev>, 
	John Fastabend <john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>, 
	Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Neal Cardwell <ncardwell@google.com>, Willem de Bruijn <willemb@google.com>, 
	Mina Almasry <almasrymina@google.com>, Kuniyuki Iwashima <kuni1840@gmail.com>, bpf@vger.kernel.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 8, 2025 at 6:00=E2=80=AFPM Shakeel Butt <shakeel.butt@linux.dev=
> wrote:
>
> On Mon, Sep 08, 2025 at 05:55:37PM -0700, Kuniyuki Iwashima wrote:
> > Maybe _EXCLUSIVE would be a bit clearer ?
> >
> > net.core.memcg_exclusive (sysctl)
> > SK_BPF_MEMCG_EXCLUSIVE
>
> Let's go with the exclusive one.

Thanks, will use it.

