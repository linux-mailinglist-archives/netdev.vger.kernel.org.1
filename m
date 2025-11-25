Return-Path: <netdev+bounces-241706-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 56678C8787A
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 00:54:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B459D4E04EB
	for <lists+netdev@lfdr.de>; Tue, 25 Nov 2025 23:54:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEF642F1FD2;
	Tue, 25 Nov 2025 23:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VvxsyoBO"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F39F2F12A7
	for <netdev@vger.kernel.org>; Tue, 25 Nov 2025 23:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764114870; cv=none; b=CY0Qs1/x3mFIrpXW3H4ik234wT69lhB8GgQGAqD7PS7AeKO1EP57VFg9WhT6DftpNmgbg6f2Y/SlHPg2Jpst9FQf4Ciel6GbSoAucJzISd6jqD9LJi2LMl/WwF9skwx8NLAoITwSjDOUJmdox4W0bdWF0qQtFnY7CXBKeNY0p4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764114870; c=relaxed/simple;
	bh=W+U+0BaeK9ffOm8ROpFp3LMrGxOmROwhfa5rx3TX9II=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ba7/FJM2pGqacn8aZU4YBS0UNsKJelyExMogAUvLmOnIRD6tDOd68XdzEwa/IKJwjPznzBVKtD0lnET5OvzfGYHdWiuKckysowhUS1CxAblytm1b/OulTydZjUHS1Gdw7hxsicbLHEMNJowfxpuPbHZgygBbfQebxwRLkuzKwlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VvxsyoBO; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-34585428e33so6097139a91.3
        for <netdev@vger.kernel.org>; Tue, 25 Nov 2025 15:54:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764114868; x=1764719668; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PZpq4xpUxpvL6e+Vla1vMOOFNlf33LepiFdLqiItueI=;
        b=VvxsyoBOfjaTLEQnlvQa50byZLOAC0pAasqiJi8yD5GGATYqSzZsvRbZKZ+j2Pwlys
         GUst7QcOGZY/MisHv3sIqNI7qUq9dRwv/95A5VLsRqk9KRyD0t07XeQn6CaBuKL8C+EC
         55XML96hX9fGTf0x8hMeo++b8JdtXY2e7V98DGCB3gmpkSIaq0vq9laL8XYddW1Q8zIe
         LhyEwJzCFN85H8hj+mC3UnEnXvfYwEG6Krd83AQMLR+EwC2VCD6On6sAceYG21alMtuM
         bg8LalFsGpsGAr+/1mmmh8OV2eWcPUB56bzGno7LTrqGbuF2Lw5R7QW27mITsdiDDFpF
         7r7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764114868; x=1764719668;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PZpq4xpUxpvL6e+Vla1vMOOFNlf33LepiFdLqiItueI=;
        b=Bwl2h5O+ucjZBnLmXrkqJEnokUny16be6nvJTiBm5EPf7y2+JEhRIey++9kKWP/NTQ
         od6f7DmKWrOIOr4T7nwOm2t+/A0qEp/AwRpEA5uCSwV20e6LYXwHHqVOnpnACJ7JnZz7
         qk0O5fxLTY43cXTSBrBOx5d9G3ofRArw8WOobCdg0Vk7b/5Q0V2E3CGw7R1zUZIAxYZZ
         34fMKjVEi0Fqf5ZXxOMESmOAK39gV3mrt3qb4pA7wJbW6APDL6N4ocE4omlTlAfskrwp
         SnPyZ9cOH99kmj7nBDo8EAb79+vr8CuyuI8O3J9G4Aa89ZkjA5EqvPXuOQeSe6sjRYSz
         a9Ng==
X-Forwarded-Encrypted: i=1; AJvYcCWT0H+anN/1LzNaHLqXFQVyGreZK2FMuFkBsG33l/4IKdny98/e1lWm1VNu4zphBOYoHJRMpnE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGRhmBqzEeqF5CsHciN4WMQ842pR2GRCeocWzvTc1CXuyQaUwg
	vbLsyXsWALDnjSmkgqnOjNoHNcM4JIYy+FbVFlIw016Zzq2Fy1NHb57bbjfanB23zHeyfZaxgzw
	cdFaapuBp/jyq2nQhWujAQZhSQzFUpC0=
X-Gm-Gg: ASbGncuo9wSbWOc2T0zxxRQusl5tUmK5GneStrmwYXZMTtWG+UmPe1LgR5wBma7MTwi
	hHaqjln5cONGO4oRmem+QlcOvyQSqAwper1UnnU7n2j6qkM6JUwBHLrJp/NPrKIdV59Le17x2A+
	laMn/ER5cedv9j8BrGZ9bprq3cR91UmFqg3wyJ6iM508B3yucFUvFEE3upocZaGQjttQVVW2+5q
	waAAS2kb186gz/vB8/Vzbu/fezn8d7Xfuf5w87nN6OansQHpQ23a6L8t+/nMJeZjROHpJZvoDcY
	DmTStgJaDLzdboAft2pteg==
X-Google-Smtp-Source: AGHT+IEg9PsfqVp7jP26YRVgq1kQLfalnlhyJlYUGo7Igvj32E2SFPIwo3ye16EiJ0LMrUlmh0BZ/1e51LxX/9tTBR8=
X-Received: by 2002:a17:90b:2c86:b0:340:54a1:d6fe with SMTP id
 98e67ed59e1d1-34733e60868mr16762780a91.15.1764114868426; Tue, 25 Nov 2025
 15:54:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251121231352.4032020-1-ameryhung@gmail.com> <20251121231352.4032020-3-ameryhung@gmail.com>
In-Reply-To: <20251121231352.4032020-3-ameryhung@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 25 Nov 2025 15:54:16 -0800
X-Gm-Features: AWmQ_bna2XyFfkWnxTEA7MX_FwRcUwdAzEYeTRf80HWJjECU5bmh6xmjUb52FTM
Message-ID: <CAEf4Bzb0Lqthpnhp+O8gGENVUsd78oiQcRTQx-TudbpWPZTxAA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v7 2/6] bpf: Support associating BPF program with struct_ops
To: Amery Hung <ameryhung@gmail.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, alexei.starovoitov@gmail.com, 
	andrii@kernel.org, daniel@iogearbox.net, tj@kernel.org, martin.lau@kernel.org, 
	kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 21, 2025 at 3:13=E2=80=AFPM Amery Hung <ameryhung@gmail.com> wr=
ote:
>
> Add a new BPF command BPF_PROG_ASSOC_STRUCT_OPS to allow associating
> a BPF program with a struct_ops map. This command takes a file
> descriptor of a struct_ops map and a BPF program and set
> prog->aux->st_ops_assoc to the kdata of the struct_ops map.
>
> The command does not accept a struct_ops program nor a non-struct_ops
> map. Programs of a struct_ops map is automatically associated with the
> map during map update. If a program is shared between two struct_ops
> maps, prog->aux->st_ops_assoc will be poisoned to indicate that the
> associated struct_ops is ambiguous. The pointer, once poisoned, cannot
> be reset since we have lost track of associated struct_ops. For other
> program types, the associated struct_ops map, once set, cannot be
> changed later. This restriction may be lifted in the future if there is
> a use case.
>
> A kernel helper bpf_prog_get_assoc_struct_ops() can be used to retrieve
> the associated struct_ops pointer. The returned pointer, if not NULL, is
> guaranteed to be valid and point to a fully updated struct_ops struct.
> For struct_ops program reused in multiple struct_ops map, the return
> will be NULL.
>
> prog->aux->st_ops_assoc is protected by bumping the refcount for
> non-struct_ops programs and RCU for struct_ops programs. Since it would
> be inefficient to track programs associated with a struct_ops map, every
> non-struct_ops program will bump the refcount of the map to make sure
> st_ops_assoc stays valid. For a struct_ops program, it is protected by
> RCU as map_free will wait for an RCU grace period before disassociating
> the program with the map. The helper must be called in BPF program
> context or RCU read-side critical section.
>
> struct_ops implementers should note that the struct_ops returned may not
> be initialized nor attached yet. The struct_ops implementer will be
> responsible for tracking and checking the state of the associated
> struct_ops map if the use case expects an initialized or attached
> struct_ops.
>
> Signed-off-by: Amery Hung <ameryhung@gmail.com>
> ---
>  include/linux/bpf.h            | 16 +++++++
>  include/uapi/linux/bpf.h       | 17 +++++++
>  kernel/bpf/bpf_struct_ops.c    | 88 ++++++++++++++++++++++++++++++++++
>  kernel/bpf/core.c              |  3 ++
>  kernel/bpf/syscall.c           | 46 ++++++++++++++++++
>  tools/include/uapi/linux/bpf.h | 17 +++++++
>  6 files changed, 187 insertions(+)
>

LGTM

Acked-by: Andrii Nakryiko <andrii@kernel.org>

[...]

