Return-Path: <netdev+bounces-89428-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B71DF8AA41B
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 22:38:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB3811C21132
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 20:38:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C579184135;
	Thu, 18 Apr 2024 20:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mhIsKdU2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FF1A2E416
	for <netdev@vger.kernel.org>; Thu, 18 Apr 2024 20:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713472691; cv=none; b=ic4leoFQl4CT5ePpcOvzOhYEh/LbbZhgMxqG2MxuFm2D2suYShaooE6GN8YNwC8Ytd1wpVToWCrLrKJVrgQ0PT9biqY69n8AauJnnzNPMPOj/3r4S3sgI3Cuiiy1PCYUUz6xHsI0w5aoI7oGd1EajUDWbzYRa014egQAyx0pdKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713472691; c=relaxed/simple;
	bh=B6PYAxGEVdWd/iLbaLB3MWgBQSAPy9Thp2AzpzinGdQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=R/EQUx8ppAELYJYIxWKulTf1Ca0axZhYwlutXyppisPu+agOfra1G+CnOsF3RTurSS28vm/nfC6Y/Gyk+TU8epj5rLJGCgZ67WJ61aUNLcB58O+2eBFQMKqC9Ffyjp0Q9+5ALGWOnn0JFuZcWDIBaX4fiN79zdbI3oEyIH4PeXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--sdf.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mhIsKdU2; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--sdf.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2a4b60f8806so1598251a91.1
        for <netdev@vger.kernel.org>; Thu, 18 Apr 2024 13:38:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713472690; x=1714077490; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4ixqEbq42sw0x7YwcNDUvxMCgoJ/GVN9HI1Bqf4Fj5c=;
        b=mhIsKdU26igZwPMjFBVp3x0LGN/pHfk48V2WvrGTDm6Rt+lARVQCJQR2bFWjPBzMHs
         wPzttP87yaHze/K/ykyp065ICFZBPZmctXJqnH69VZtoNMiAtRpXNJaAA/VnT8Sqrw+R
         QP9kaYxlTDtMtPdFTyGzuDgyLeoy6GZRMIQquVj5Oyr60XgmJk/ynzkkVguAzE0IdKo9
         3hCcp0JW+vURn143wSSdAXdycp9EllzXgR/kPvdpJ6YudDwglH0dwTpZLzar62Yj9t05
         GUeflmMBrXelTcZce4XmCw9Ksm7Jss6fA0k7a1wDJpILeq9tzY3tSaWprLyMY+XpmK8E
         pjFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713472690; x=1714077490;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=4ixqEbq42sw0x7YwcNDUvxMCgoJ/GVN9HI1Bqf4Fj5c=;
        b=gmbsSHEdIqayQHG7TJoHu6vvbXFyHSpC0TSB7haduD6MYW3hieieGNU0KzK1Tsh67u
         dGW3ju+VkGRgNYPoYCavSRj4uhoNnNiiNeFpxiCcMpZDvnv4/QyeTezk3hJdx8+lL8wn
         /aNxjY0dADi/7v7d/cMjGfWSSwE1Ay8a9wb6NpDOGDJ2gvYDxu7lt/cghAIfXblSO6Jf
         WxsrVtF/zAuOdoOEXMdkLMCYCv8Kuc1a9mxx/lgL12sqbro7LeCL3y9YLzimaYZ2N4vI
         jWRDou/8PRsdFTjo7g220rbmtUk3uJj3DGhC6zcv0QNpS1xJGnLsNzX6rGI+RGCegXt8
         FAyg==
X-Forwarded-Encrypted: i=1; AJvYcCVZFpuz9qv0pVKxE10IJYK8RHcDMcUcVqSNl+7Zs+HMYKbVGeDCkcKU3glSovZXDcI6OVvzVJupw8K7S/S6TduL4VaIwMeb
X-Gm-Message-State: AOJu0Ywtf0/M4Mi+XlAWzotkV4l4XarUvt+p5P8grSTGdCsAne2pPmaY
	rJW4AnfRwDyTRz6pa8ByUU/A8I28A9Vx9h6EWSDHvOW26Wa081CE0RxSZ6zGxUhOfw==
X-Google-Smtp-Source: AGHT+IFq4R2BydwxieG1CN7ABcoPMb9TaOqRjgM00dFmOyCGXtJJIEurepe1f5ZSOsEggMM0vhzrSE8=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a17:90a:1c97:b0:2a5:dd7:1c35 with SMTP id
 t23-20020a17090a1c9700b002a50dd71c35mr729pjt.8.1713472689747; Thu, 18 Apr
 2024 13:38:09 -0700 (PDT)
Date: Thu, 18 Apr 2024 13:38:08 -0700
In-Reply-To: <87edb2ttdy.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240418071840.156411-1-toke@redhat.com> <ZiFkG45wi9AO3LEs@google.com>
 <87edb2ttdy.fsf@toke.dk>
Message-ID: <ZiGEsLcInuowL25m@google.com>
Subject: Re: [PATCH bpf] xdp: use flags field to disambiguate broadcast redirect
From: Stanislav Fomichev <sdf@google.com>
To: "Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?=" <toke@redhat.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, Hangbin Liu <liuhangbin@gmail.com>, 
	syzbot+af9492708df9797198d6@syzkaller.appspotmail.com, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, bpf@vger.kernel.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On 04/18, Toke H=C3=B8iland-J=C3=B8rgensen wrote:
> Stanislav Fomichev <sdf@google.com> writes:
>=20
> > On 04/18, Toke H=C3=B8iland-J=C3=B8rgensen wrote:
> >> When redirecting a packet using XDP, the bpf_redirect_map() helper wil=
l set
> >> up the redirect destination information in struct bpf_redirect_info (u=
sing
> >> the __bpf_xdp_redirect_map() helper function), and the xdp_do_redirect=
()
> >> function will read this information after the XDP program returns and =
pass
> >> the frame on to the right redirect destination.
> >>=20
> >> When using the BPF_F_BROADCAST flag to do multicast redirect to a whol=
e
> >> map, __bpf_xdp_redirect_map() sets the 'map' pointer in struct
> >> bpf_redirect_info to point to the destination map to be broadcast. And
> >> xdp_do_redirect() reacts to the value of this map pointer to decide wh=
ether
> >> it's dealing with a broadcast or a single-value redirect. However, if =
the
> >> destination map is being destroyed before xdp_do_redirect() is called,=
 the
> >> map pointer will be cleared out (by bpf_clear_redirect_map()) without
> >> waiting for any XDP programs to stop running. This causes xdp_do_redir=
ect()
> >> to think that the redirect was to a single target, but the target poin=
ter
> >> is also NULL (since broadcast redirects don't have a single target), s=
o
> >> this causes a crash when a NULL pointer is passed to dev_map_enqueue()=
.
> >>=20
> >> To fix this, change xdp_do_redirect() to react directly to the presenc=
e of
> >> the BPF_F_BROADCAST flag in the 'flags' value in struct bpf_redirect_i=
nfo
> >> to disambiguate between a single-target and a broadcast redirect. And =
only
> >> read the 'map' pointer if the broadcast flag is set, aborting if that =
has
> >> been cleared out in the meantime. This prevents the crash, while keepi=
ng
> >> the atomic (cmpxchg-based) clearing of the map pointer itself, and wit=
hout
> >> adding any more checks in the non-broadcast fast path.
> >>=20
> >> Fixes: e624d4ed4aa8 ("xdp: Extend xdp_redirect_map with broadcast supp=
ort")
> >> Reported-and-tested-by: syzbot+af9492708df9797198d6@syzkaller.appspotm=
ail.com
> >> Signed-off-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
> >> ---
> >>  net/core/filter.c | 42 ++++++++++++++++++++++++++++++++----------
> >>  1 file changed, 32 insertions(+), 10 deletions(-)
> >>=20
> >> diff --git a/net/core/filter.c b/net/core/filter.c
> >> index 786d792ac816..8120c3dddf5e 100644
> >> --- a/net/core/filter.c
> >> +++ b/net/core/filter.c
> >> @@ -4363,10 +4363,12 @@ static __always_inline int __xdp_do_redirect_f=
rame(struct bpf_redirect_info *ri,
> >>  	enum bpf_map_type map_type =3D ri->map_type;
> >>  	void *fwd =3D ri->tgt_value;
> >>  	u32 map_id =3D ri->map_id;
> >> +	u32 flags =3D ri->flags;
> >
> > Any reason you copy ri->flags to the stack here? __bpf_xdp_redirect_map
> > seems to be correctly resetting it for !BPF_F_BROADCAST case.
>=20
> Well, we need to reset the values in xdp_do_redirect() to ensure things
> are handled correctly if the next XDP program invocation returns
> XDP_REDIRECT without calling bpf_redirect_map(). It's not *strictly*
> necessary for the flags argument, since the other fields are reset so
> that the code path that reads the flags field is never hit. But that is
> not quite trivial to reason about, so I figured it was better to be
> consistent with the other values here.

SG! Wanted to double check whether there is something I'm missing or
the existing reset logic is fine :-)

Acked-by: Stanislav Fomichev <sdf@google.com>

