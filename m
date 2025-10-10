Return-Path: <netdev+bounces-228535-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A6FF0BCD80D
	for <lists+netdev@lfdr.de>; Fri, 10 Oct 2025 16:24:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A7C11188E8FC
	for <lists+netdev@lfdr.de>; Fri, 10 Oct 2025 14:24:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0647287268;
	Fri, 10 Oct 2025 14:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gCs3Xs3j"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36A8B17597
	for <netdev@vger.kernel.org>; Fri, 10 Oct 2025 14:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760106242; cv=none; b=rxwiFfZVX5YH96sJM9NP3e3SWLbtGm4Tmt1DWijYT370TigF35N09CxM6lUofnJFq5vIh4owWmeuNrhNHFsiY30bnhv/6y3427iB5GUTuBNiyvLL+UqI5H3XzGc9Q2SRCCP9pVfiryefZFAQmRnQP1RG5UHCsv7Lw7LYHnKcGBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760106242; c=relaxed/simple;
	bh=728Pg4sn3XA6HHuow/YpDlQqrnEkY+wYm3DVQHrsDtk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nj4syp8OZ9b+mbRYsrHcwlsmTaKJ+es6Qh/ovaU3RitfjN53aeaPcZL1Bb/06LkObiiL81fOCW86PQphB80TPeugIy6fVLAnNRS2FCJe7zzo2JncYUn7tTzFvATAs7NK4Wurs2PKmqZJgaKNDBs8t+cYMe3V7cZNXbBLAZ/jqZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gCs3Xs3j; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-72ce9790aceso19597867b3.3
        for <netdev@vger.kernel.org>; Fri, 10 Oct 2025 07:24:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760106239; x=1760711039; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ep8vBwkncVq2/IyBnp2z8KCBLEvYE8o7QIrmGoze/68=;
        b=gCs3Xs3jeXyGap8ELqMKwYCt9LvFOgdRd1sBWvHq/SQ1xXCEP7sIy+BehNcP9KVnd0
         RJ/pz17JXVV8RYbJIkrzv+SVlwm/TSaCSJsJBIC1LJfjzOqFPQM5nfxKSYqnUZAsvBW9
         ypYXAWFvul/ffm5Xshlj6LqeNAXQJ9tQGQ74W8VkPw5muRv7CTXczU/oD6OKsrXszPeU
         grnsoV+2XQ4c1o4Lnzo7POsVvopsuQmDEr9dxFvddNkooJlT1I7rHKJptFAF9TkMt9LX
         kTfYnb9/h7T40FNZ5MXm+hGb4B6/6z821ZhjUp+11DUiInqSvCGdeXOwlNZ9EuJ+Mcrs
         oOJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760106239; x=1760711039;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ep8vBwkncVq2/IyBnp2z8KCBLEvYE8o7QIrmGoze/68=;
        b=ay/5q7Gd/+EHEF+BpeJ5ExnpSFlxOoesILtE/AC8St6w0oCD3Z845kj7SPV7vC/ny7
         EyjH2hcb/Ds+POz6HzRekycHogKnJVxfuQES98uUlp1wYQsDflYzyJQO0HROF4ovhZxl
         8Tai1Bc1z03i5ia7+KgNKhxicRgNcMXV0agAOeiTYzqwUY7zR20GYdf8HV5rWDSgmxlR
         xTgXZ3F2dxeWWMdte6oWtDJx+8xYjYK1UbnMX2nzaTi57jMh6Xaseq2lmPXkIrJnRLfZ
         PkqX/hu7eGkiD1MplRBXmqWr9sPivY00zOlthVutC0tRD4tfqqfGlE9iG6ie/w4ftQCx
         bUkQ==
X-Forwarded-Encrypted: i=1; AJvYcCXeqhdl4mKEdaHdZ6muerWNxKszvbfrJAgxe7KNVtJ0uCQXmmMZ0abyMYhOGvx1bXx8TEsS0bw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVqltgXO79vrp7wx4hBuik+R1SCTE6TJt0Ow+byJS7QKwpmImi
	HqXTsmkzsXEGQkWrahZXkcvvJSAeHyOMpGh0JaEnJLw9Dgtv6usaKkCkT0gZbSVhoGZcsMPe+6u
	0hB10T2yIc59xGlUj6G4S822ZhQy0DW5glAXl5F05
X-Gm-Gg: ASbGnctDP0aziQKn/ohAxeiX01QC0SVp0n/L6tNtUbdU1HMZLSAZxH7E2Quu5kxG3xl
	hxPGcxcjZeUoEi14nEjbfbAiSN2t+9ngfJFIPNxT3C6GXvl/IQFY78ltkn0v1iOY7DdeClRXTSf
	cUfLFg9IEN56ST48K3tJ+mSmah9ocLebj+eP1ZZfaiHVOgGyhWdmYWykfHMAe9WbRKnlbC/jQ6g
	TcrnuqNvMosGBQoBPhRa+mb9lfZFeT4+9hFgGrplYmp
X-Google-Smtp-Source: AGHT+IFXUmNhceZhgJjwPY/VRP9jDGszxMq44Rpe9q3p1bI1zOHVpEFQvHQpi/tuqUftv/YFXc8YNDVTdg5ozI7vO+Y=
X-Received: by 2002:a05:690c:e0a:b0:781:64f:2b16 with SMTP id
 00721157ae682-781064f3482mr52227047b3.56.1760106238542; Fri, 10 Oct 2025
 07:23:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251007001120.2661442-1-kuniyu@google.com> <20251007001120.2661442-3-kuniyu@google.com>
In-Reply-To: <20251007001120.2661442-3-kuniyu@google.com>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 10 Oct 2025 07:23:47 -0700
X-Gm-Features: AS18NWDQf2ogI7PP3DWUgSD8qvpKvGg_Iu4VbjufziD2iUPvf_knUOrdlfOrzSs
Message-ID: <CANn89iJYv-ei-0yKzveLF7teyNpMUwTCf8YmOUzxZcyhowsTUQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next/net 2/6] net: Allow opt-out from global protocol
 memory accounting.
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@linux.dev>, 
	John Fastabend <john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Neal Cardwell <ncardwell@google.com>, Willem de Bruijn <willemb@google.com>, 
	Mina Almasry <almasrymina@google.com>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, bpf@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 6, 2025 at 5:11=E2=80=AFPM Kuniyuki Iwashima <kuniyu@google.com=
> wrote:
>
> Some protocols (e.g., TCP, UDP) implement memory accounting for socket
> buffers and charge memory to per-protocol global counters pointed to by
> sk->sk_proto->memory_allocated.
>
> Sometimes, system processes do not want that limitation.  For a similar
> purpose, there is SO_RESERVE_MEM for sockets under memcg.
>
> Also, by opting out of the per-protocol accounting, sockets under memcg
> can avoid paying costs for two orthogonal memory accounting mechanisms.
> A microbenchmark result is in the subsequent bpf patch.
>
> Let's allow opt-out from the per-protocol memory accounting if
> sk->sk_bypass_prot_mem is true.
>
> sk->sk_bypass_prot_mem and sk->sk_prot are placed in the same cache
> line, and sk_has_account() always fetches sk->sk_prot before accessing
> sk->sk_bypass_prot_mem, so there is no extra cache miss for this patch.
>
> The following patches will set sk->sk_bypass_prot_mem to true, and
> then, the per-protocol memory accounting will be skipped.
>
> Note that this does NOT disable memcg, but rather the per-protocol one.
>
> Another option not to use the hole in struct sock_common is create
> sk_prot variants like tcp_prot_bypass, but this would complicate
> SOCKMAP logic, tcp_bpf_prots etc.
>
> Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>

Reviewed-by: Eric Dumazet <edumazet@google.com>

