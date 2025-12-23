Return-Path: <netdev+bounces-245787-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B5A4CD7F3A
	for <lists+netdev@lfdr.de>; Tue, 23 Dec 2025 04:16:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BB4373019893
	for <lists+netdev@lfdr.de>; Tue, 23 Dec 2025 03:16:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C59192D0C8A;
	Tue, 23 Dec 2025 03:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ag6QkYLR"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f196.google.com (mail-pl1-f196.google.com [209.85.214.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F9C870824
	for <netdev@vger.kernel.org>; Tue, 23 Dec 2025 03:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766459777; cv=none; b=YMCZrwrLiJa6x8+tltdd5Ai5EV9l20+DfOBXzyVuh24v1yEq04pWEBLf7qg3r48VwhH3Ob7gBo3Lc0LDJEwQvrU3tBaJxoxQFkDBNB6SvM8nK3Ib1vdOmIZMvSUWtu69O5xU5K+ieJzPIO0bLzHoP+jFCrRKCCCPJKlqLZzuXl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766459777; c=relaxed/simple;
	bh=Mx/UmQpiIIEj3g1XtLjsQrkIbpEb1sO7h8QPcpp78vQ=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=MdnznC5dlEPHTjIzLHvQ4ioNj7CKFY8yzxCDrmYv2fwTmf9esqvdOrOyIsxyZpQPShWlyMguX4iTTvDgJWW+B8j8i72WPoTpyQ5i7a5MU91uF2x1tihl5zJvp4o5vWQn88889qBzrUVA8v+s/5YMpsUfD6myDUun9AeLxHy/TEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ag6QkYLR; arc=none smtp.client-ip=209.85.214.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f196.google.com with SMTP id d9443c01a7336-2a110548cdeso64340695ad.0
        for <netdev@vger.kernel.org>; Mon, 22 Dec 2025 19:16:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766459775; x=1767064575; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BlWmvPevLxcZ1ApfaQlGkISYTXnx0tCKi7KeQn9/wc8=;
        b=ag6QkYLRk36oKpnYOVqgLPh9o9181RmjXFoyiLT63EuKe78sZah1GlVwTUSrq6Zuuk
         s+UWzZ2HudOohOlaeebWVMqG/sI5FR25EOZqh+guqxKv7LVYbG6XG/dRPgoDtsat7y8w
         irXdEIYEa+LBW6DlhPIwOCeu9HAr8ZFS5/4NMVcuFkiXlVjPmwyg+LVcx3WpQJEgIqFt
         2osYRs1Ed5vkH13O40DkU9Wo67J/qLwHJa2WiKrmI1uj9kgjG3gZ4aBZliDbcLSTUF0O
         U8jgwRIUXUd3Ga+o+LMK9WzBtbpVbeT2Ip1BwVHercOIEJNjiYxolNwHfUsFKF5lOcsJ
         042w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766459775; x=1767064575;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BlWmvPevLxcZ1ApfaQlGkISYTXnx0tCKi7KeQn9/wc8=;
        b=j7focfO8N79qT5C8SRpxsESQ3Ny+1YL63ZbtFmmkcVGU71jsG5TX3PYeW+i12vSLoM
         7bM5J85G6WksDg4hMUqu7PIhNy/FwE4WNd2PkS/fsQFQzj6x/7fA5xCTrCPPrQHiisaK
         QFFA54gGsV76AYMm9UGl1F4T0+IqTAysMC3HDi63aDKmNj/3w7QEUicJ1KlKTtLpemtI
         SMnvoSieSnj3dZtuCL3Jc5OEeV7f1+k/cwWFRrJvW5Q5cKuX5TyCbdyrdsHdcYdH/K1k
         2bA+C0tgyHaUreczxk7KkQqu3HF7WN6A17Z/oSdkvIkD9vgYbenMoUWaoGQExJznh5Kr
         98Eg==
X-Forwarded-Encrypted: i=1; AJvYcCWq75ruyu5z9LnR6AQerp8/1DbPEJ+IFkyBFq6QjDD6/y/A3u4Zjm67ZroeYH+0T2PNYGQoSCs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRxHjfhMqrdRxPDE+Latk14hLTnDtg/crvrAqdT9o28lmHiF/x
	DCg+c1TgOMY6smdWjC9qDZAYLsrI//gIkm7ir3/wQb/4mtTnCerbVO7L
X-Gm-Gg: AY/fxX75owTvF678h6vBWu4PMVCUi7FNIGUUohsvmvrf1tyOR4GI9KHicpZBt0QnB7T
	vxPZo2wyNFRBYjm4+owAguybpgFN/wjOU5XjrURzY4a6ShHZe7V+7NgcG+kr51ts9IVrRmhXpxN
	DIEkrnEAs20XddOFm4OjOaaTj5Rkz/A+gril4QUPkW7MsnjdZN4Nn/E2t87gEiSV+1BoGC7eDzr
	GUflR6NEFP9E6pPzaHJZZFNTLpJ5KUmA3Oo4ZKWYleirNNTLTiF5m1Ass5Hv1tyPYR6LT3thv3v
	4Hq1gp0AK50MatyoLSZJPlG8rnejjcnp941hsLVUsEcEu5KuaWUf8UHunr+mmKLJljx9PwbzIYR
	yh0T91Gb0twXCKQsyDaGiol1exB5kaBIPX32EPhRiDE/yr758/a0QQPGHeOSusEpG6OFNbjCQBo
	WXN9eo/3Scjohss3CYFA==
X-Google-Smtp-Source: AGHT+IHsJHcvBEd1oY/Js4mF4dqnLZlZO6zVgt/BH5AZODSD/0YmbnGfhPQbR6X+bCQGU0pLbsm+xg==
X-Received: by 2002:a17:903:2a8b:b0:298:1422:510d with SMTP id d9443c01a7336-2a2f293daefmr125439995ad.48.1766459775168;
        Mon, 22 Dec 2025 19:16:15 -0800 (PST)
Received: from smtpclient.apple ([188.253.121.152])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a2f3c65d66sm109554945ad.20.2025.12.22.19.15.59
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 Dec 2025 19:16:14 -0800 (PST)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81.1.4\))
Subject: Re: [RFC bpf PATCH 0/2] bpf: Fix memory access tags in helper
 prototypes
From: Zesen Liu <ftyghome@gmail.com>
In-Reply-To: <CAMB2axPpB7Km=_7J_QTcQV8SvuFMKqg-_fCyRHEZKNfr7WL2Gg@mail.gmail.com>
Date: Tue, 23 Dec 2025 11:15:46 +0800
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>,
 Eduard Zingerman <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>,
 KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>,
 Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>,
 Matt Bobrowski <mattbobrowski@google.com>,
 Steven Rostedt <rostedt@goodmis.org>,
 Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>,
 Daniel Xu <dxu@dxuuu.xyz>,
 Shuah Khan <shuah@kernel.org>,
 bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org,
 netdev@vger.kernel.org,
 linux-kselftest@vger.kernel.org,
 Shuran Liu <electronlsr@gmail.com>,
 Peili Gao <gplhust955@gmail.com>,
 Haoran Ni <haoran.ni.cs@gmail.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <991C3D59-65D5-4B31-B667-EDAF348F9F7F@gmail.com>
References: <20251220-helper_proto-v1-0-2206e0d9422d@gmail.com>
 <CAMB2axPpB7Km=_7J_QTcQV8SvuFMKqg-_fCyRHEZKNfr7WL2Gg@mail.gmail.com>
To: Amery Hung <ameryhung@gmail.com>
X-Mailer: Apple Mail (2.3826.700.81.1.4)

Apologies for the resend due to an incorrect configuration in my mail =
client.

Thanks for your comment!

> On Dec 23, 2025, at 03:29, Amery Hung <ameryhung@gmail.com> wrote:
>=20
> Perhaps you are conflating one of your proposals here? This is fine
> currently. ARG_PTR_TO_MEM without any annotation is viewed as BPF_READ
> so passing a read-only buffer should work.


Actually, that is not the case. I tested this again, and ARG_PTR_TO_MEM
without MEM_RDONLY does reject read-only buffers. You can reproduce this
behavior with test_d_path_check_rdonly_mem in selftests by removing its
arg2=E2=80=99s MEM_WRITE tag.

> I think it is better to make the MEM_WRITE, MEM_RDONLY annotation
> explicit and check it in the verifier.
>=20
> Flipping the default MEM_RDONLY semantic to MEM_WRITE does not prevent
> a similar bug in the future when we have helpers/optimizations/checks
> rely on an implicit semantic.

The current default semantic is in an inconsistent state: it implies
neither MEM_RDONLY nor MEM_WRITE. A naked ARG_PTR_TO_MEM rejects
read-only buffers, yet tells the verifier that the helper does not =
modify the memory.

I see two ways to resolve this ambiguity:
1) Enforce explicit memory access tags (disallow naked ARG_PTR_TO_MEM) =
as I
proposed eariler; or
2) Change ARG_PTR_TO_MEM semantics to behave exactly like
   ARG_PTR_TO_MEM | MEM_RDONLY.

I would appreciate your thoughts on this. :)


Thanks,
Zesen Liu=

