Return-Path: <netdev+bounces-89359-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D29468AA20E
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 20:31:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 021221C2187A
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 18:31:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49B04EAD2;
	Thu, 18 Apr 2024 18:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dF4nPdDu"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 830DB3D62
	for <netdev@vger.kernel.org>; Thu, 18 Apr 2024 18:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713465091; cv=none; b=OLeFZcbNs6Dhovl4FsFrXzodMsBbB+o6z/qYtlJ1kjAZv86P59Tjb2rz7oSVtJhyB7MrYIazk1hu/bX/jaQBFr4dziNdM7X8HSRvLtw23zdvdkPCbv+sNRiFIrqHVWLlttvgtLDEPAM5O4ZmrpyMk7d6KFviVJkL6ywBJKHfafs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713465091; c=relaxed/simple;
	bh=Ltslr1RBzLiDTsVuVuGVK0oYHn7dQqKbhJaf4PjG7ck=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=AoBpBH+tZ5mtkLwcAwRHub5L8rBLH3lFj2izotvVdZgyFFnfiWy2GZy4+HPPrNaHpJE0bDnO4cqTwbEXb7IyzW4+7iO2TknD7tJ42sJGsSEZv6ALhCvOsCBOrnmbVqVSpjwIIoV43KXVqGkuj0FAfDfRGGdeHQsXv5D76F/3BOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dF4nPdDu; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713465088;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=41jrEvJA6F4MWz7nzX/PlgihNKfXrfpkxT7EhtWoS1Y=;
	b=dF4nPdDuxHOWs+/nXIOCZrIqrD0Cex+vfVUSRhMWrT/S49v1tiqehQqrFvb2PGwZzFZRUx
	5JNEV+UxPO5sNWWr4/G+kS+holoS9pIe54ERYUKE+8tXQqnLw/gxIjADLXdNj+VuUd7fsH
	ievnV9dTYklUAyv2Zsy/bvnZ1YT1hMg=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-622-wXE7HqK2MJGk6KOMleaCJw-1; Thu, 18 Apr 2024 14:31:25 -0400
X-MC-Unique: wXE7HqK2MJGk6KOMleaCJw-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-a524b774e39so136802466b.1
        for <netdev@vger.kernel.org>; Thu, 18 Apr 2024 11:31:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713465083; x=1714069883;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=41jrEvJA6F4MWz7nzX/PlgihNKfXrfpkxT7EhtWoS1Y=;
        b=Zb6AAUqnq7dYAVFGVh8Z0yLuDWtfBEcI1WoIoxmBfTvI6kK4UAlorSKNm10U/kgubT
         h4FlZtyNptoMZToATm5/MzJpDhyLtOp1uvLlAH/IrRMJRHeFkJm7STR/kqaOoC84XimR
         +9q2mCIsTGsJpQTbS5y4/h9CV6+n0ustMLf5d4s8SRrhi6ERxx1V5pimp1pqMOXvcwTH
         6akHckA7a15imvJtSAVt/ghBSkDt8XySExO1MCNG7Gy6M5L7+FLOaITOZ1hrRtYlrEqV
         TtxMj/2I3dGbNRh2HFEeDsTt8gnwsQGDNj7UZPEm6mgZtVvqTER0kQGsUbxNxhyBmkjP
         V/0w==
X-Forwarded-Encrypted: i=1; AJvYcCUW+CIzZeq0hCYzcLkJYtds5i+lwmHVEW79Sb/ihe2ORRhp9+yr/oojIZmyiBhgrUzK846A56L4x/zKaxq2a092PGmRQGUQ
X-Gm-Message-State: AOJu0Yz285lDP0DLrRGLTn7752BnWfB3pYLr6tXaCpgMzNqZ827ha6LG
	iNvt0ErFGGMN+Kv7/Jg3SzWORVTNvxkyaEPAj3IWfX0isYclGlBqb3vqM4mnq6fGPaRrg8p4iFD
	dQmALqo85L/hV3j8cYYp8NH54njpoqkxRQWVKJEsA2Bp+ATK2xp/h7Q==
X-Received: by 2002:a17:906:2997:b0:a52:6fe5:938b with SMTP id x23-20020a170906299700b00a526fe5938bmr2547255eje.26.1713465082924;
        Thu, 18 Apr 2024 11:31:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGDe/HhT9BP4NjSMZv666Qe5WtVx6ckkC+eAt27ByIXgYd/DY6Ep1Q6UvLnul0BHX6kleDb/g==
X-Received: by 2002:a17:906:2997:b0:a52:6fe5:938b with SMTP id x23-20020a170906299700b00a526fe5938bmr2547228eje.26.1713465082493;
        Thu, 18 Apr 2024 11:31:22 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id gf16-20020a170906e21000b00a526fe5ac61sm1206467ejb.209.2024.04.18.11.31.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Apr 2024 11:31:22 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 661801233CDC; Thu, 18 Apr 2024 20:31:21 +0200 (CEST)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Stanislav Fomichev <sdf@google.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, Martin KaFai
 Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu
 <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, John Fastabend
 <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, Hao Luo
 <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, "David S. Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Jesper Dangaard
 Brouer <hawk@kernel.org>, Hangbin Liu <liuhangbin@gmail.com>,
 syzbot+af9492708df9797198d6@syzkaller.appspotmail.com, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 bpf@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH bpf] xdp: use flags field to disambiguate broadcast
 redirect
In-Reply-To: <ZiFkG45wi9AO3LEs@google.com>
References: <20240418071840.156411-1-toke@redhat.com>
 <ZiFkG45wi9AO3LEs@google.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Thu, 18 Apr 2024 20:31:21 +0200
Message-ID: <87edb2ttdy.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Stanislav Fomichev <sdf@google.com> writes:

> On 04/18, Toke H=C3=B8iland-J=C3=B8rgensen wrote:
>> When redirecting a packet using XDP, the bpf_redirect_map() helper will =
set
>> up the redirect destination information in struct bpf_redirect_info (usi=
ng
>> the __bpf_xdp_redirect_map() helper function), and the xdp_do_redirect()
>> function will read this information after the XDP program returns and pa=
ss
>> the frame on to the right redirect destination.
>>=20
>> When using the BPF_F_BROADCAST flag to do multicast redirect to a whole
>> map, __bpf_xdp_redirect_map() sets the 'map' pointer in struct
>> bpf_redirect_info to point to the destination map to be broadcast. And
>> xdp_do_redirect() reacts to the value of this map pointer to decide whet=
her
>> it's dealing with a broadcast or a single-value redirect. However, if the
>> destination map is being destroyed before xdp_do_redirect() is called, t=
he
>> map pointer will be cleared out (by bpf_clear_redirect_map()) without
>> waiting for any XDP programs to stop running. This causes xdp_do_redirec=
t()
>> to think that the redirect was to a single target, but the target pointer
>> is also NULL (since broadcast redirects don't have a single target), so
>> this causes a crash when a NULL pointer is passed to dev_map_enqueue().
>>=20
>> To fix this, change xdp_do_redirect() to react directly to the presence =
of
>> the BPF_F_BROADCAST flag in the 'flags' value in struct bpf_redirect_info
>> to disambiguate between a single-target and a broadcast redirect. And on=
ly
>> read the 'map' pointer if the broadcast flag is set, aborting if that has
>> been cleared out in the meantime. This prevents the crash, while keeping
>> the atomic (cmpxchg-based) clearing of the map pointer itself, and witho=
ut
>> adding any more checks in the non-broadcast fast path.
>>=20
>> Fixes: e624d4ed4aa8 ("xdp: Extend xdp_redirect_map with broadcast suppor=
t")
>> Reported-and-tested-by: syzbot+af9492708df9797198d6@syzkaller.appspotmai=
l.com
>> Signed-off-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
>> ---
>>  net/core/filter.c | 42 ++++++++++++++++++++++++++++++++----------
>>  1 file changed, 32 insertions(+), 10 deletions(-)
>>=20
>> diff --git a/net/core/filter.c b/net/core/filter.c
>> index 786d792ac816..8120c3dddf5e 100644
>> --- a/net/core/filter.c
>> +++ b/net/core/filter.c
>> @@ -4363,10 +4363,12 @@ static __always_inline int __xdp_do_redirect_fra=
me(struct bpf_redirect_info *ri,
>>  	enum bpf_map_type map_type =3D ri->map_type;
>>  	void *fwd =3D ri->tgt_value;
>>  	u32 map_id =3D ri->map_id;
>> +	u32 flags =3D ri->flags;
>
> Any reason you copy ri->flags to the stack here? __bpf_xdp_redirect_map
> seems to be correctly resetting it for !BPF_F_BROADCAST case.

Well, we need to reset the values in xdp_do_redirect() to ensure things
are handled correctly if the next XDP program invocation returns
XDP_REDIRECT without calling bpf_redirect_map(). It's not *strictly*
necessary for the flags argument, since the other fields are reset so
that the code path that reads the flags field is never hit. But that is
not quite trivial to reason about, so I figured it was better to be
consistent with the other values here.

-Toke


