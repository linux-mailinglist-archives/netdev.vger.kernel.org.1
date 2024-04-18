Return-Path: <netdev+bounces-89357-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E30738AA1EE
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 20:19:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6EF561F22199
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 18:19:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C477717A92F;
	Thu, 18 Apr 2024 18:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0V5wkZh2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E072317556A
	for <netdev@vger.kernel.org>; Thu, 18 Apr 2024 18:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713464352; cv=none; b=rmVALvXmCWTdCdhogqSV/u8aKAEp9iprtx/V1xIBBtRDxf6B013x8MXm15kMArJHewaVr7jlgy7SB7u5PfI3yZSk/4AW/bfcBDegyPId1zBlq7OStztngJ5FWzVoNKZug098Q92DUIm7LIeon77+NaiTgj4hWSBpheO0zhPyd4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713464352; c=relaxed/simple;
	bh=TY5RGHkR1B7VcpcfxqCvb9vWA9VGta9DEB9gTtPVOa8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=n5Y5uxo4XbTaNUKSc6fqy+78kIG3YvH5xjQbCJLeiYezZOXRBjUAwRkQHuOWS7LL+4ISlY89paI6y1muYkznjuJeWxqG6n5WV+JHLgsdoHMBnF9Pl7d1AmJJYCAvLRKaHM/LUqP/vkGFuPD5Hirgo+aPnuKyqR+YN3k4yS51txU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--sdf.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0V5wkZh2; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--sdf.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-5d8bcf739e5so1422596a12.1
        for <netdev@vger.kernel.org>; Thu, 18 Apr 2024 11:19:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713464350; x=1714069150; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AUve054mJbbxeZoYsSoxx0U8HsMmYEGyCpud/vdlqV8=;
        b=0V5wkZh2FPchxVlnN+0I4E+UBTL5gr2eZQow8cgO9Xrf2ZN+hrpR5n1BBZOGKLQ0SB
         YyVSiH/rw6zeQbpt0fYY3DMmm2C9pnDxBsotkj7UOLd0AxFVjZvIkY0RILMK0xBDrzbP
         40DfmJzb2BWf3PA4s2n5GZAHyd2xwyHwkpn/bgMHXj59iXUIFmFTR1ZNVpQKT8hD9r6o
         U52VRrVzC0sCjFOPxbfKEMnHOh0ID4KCRwgUE4P2pvO+D799qvdN4FPsARLcXiyDOpAT
         PHV2x2KfF52i7NjdSR3JgxsMsky89KxkzsV/822XPlGlNrx2rWmIvSf79aPRiivTwh/z
         ii/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713464350; x=1714069150;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=AUve054mJbbxeZoYsSoxx0U8HsMmYEGyCpud/vdlqV8=;
        b=k8KD/fC77Edjop+ExiGuyUPJSJ0Ol879D+vkZVmXJEaEg/Nk2x/1v3U2j76qigHhpK
         wVXL70dCBKYHepcLxbRSCQcVwNROVWeaVNPq0Oinupd4X5a1eVnjc5zeVcv3bJ99k0em
         a97eUeRRR1IGAiBq5UEjIey5cgHwSiq8eDTPTLkTp2vc/GcQ8FiJeOj6c2GGLl5TKYk0
         53yoL0uegoHTKdZXr6fsUxaoxsPi2SLh44zZ7IsXMUkJRUrledI/vT/RCpo51CJGLk/w
         Qb1OMNallg63vv93g9FcwqRm2ey0mfJReGOD4zUw/Re90yXM/sdHjt+reyIzU5SkzGzz
         t9qQ==
X-Forwarded-Encrypted: i=1; AJvYcCUQFYhHgkidoqb6leu71U0Jw89fOQOPD7onVlAcnQeLgwYhTXjs4FqL7dDJUP4SqGeUllJ9iOSrhdAD/PqFGXBmbZ6eGJ9P
X-Gm-Message-State: AOJu0YyuuLIx4O1cGyTwILlI/bLDlvuDSH3xKufwsG1M3TxiJTq0Q7T2
	pfH3IryzTNfVq+O/HDPeqdY+p0AeGS5AleYxgPy9t4+9rwiMLP84tP1T7oZkytMljg==
X-Google-Smtp-Source: AGHT+IGxDU7FDxGzk6bfcmDHyNPVZ5xo+1i4YxyLBmGSxyOwhMUghLftH40BiFVm20GJ86ROa2AHxmo=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a65:6a97:0:b0:5dc:2368:a9f2 with SMTP id
 q23-20020a656a97000000b005dc2368a9f2mr8951pgu.3.1713464350052; Thu, 18 Apr
 2024 11:19:10 -0700 (PDT)
Date: Thu, 18 Apr 2024 11:19:07 -0700
In-Reply-To: <20240418071840.156411-1-toke@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240418071840.156411-1-toke@redhat.com>
Message-ID: <ZiFkG45wi9AO3LEs@google.com>
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
> When redirecting a packet using XDP, the bpf_redirect_map() helper will s=
et
> up the redirect destination information in struct bpf_redirect_info (usin=
g
> the __bpf_xdp_redirect_map() helper function), and the xdp_do_redirect()
> function will read this information after the XDP program returns and pas=
s
> the frame on to the right redirect destination.
>=20
> When using the BPF_F_BROADCAST flag to do multicast redirect to a whole
> map, __bpf_xdp_redirect_map() sets the 'map' pointer in struct
> bpf_redirect_info to point to the destination map to be broadcast. And
> xdp_do_redirect() reacts to the value of this map pointer to decide wheth=
er
> it's dealing with a broadcast or a single-value redirect. However, if the
> destination map is being destroyed before xdp_do_redirect() is called, th=
e
> map pointer will be cleared out (by bpf_clear_redirect_map()) without
> waiting for any XDP programs to stop running. This causes xdp_do_redirect=
()
> to think that the redirect was to a single target, but the target pointer
> is also NULL (since broadcast redirects don't have a single target), so
> this causes a crash when a NULL pointer is passed to dev_map_enqueue().
>=20
> To fix this, change xdp_do_redirect() to react directly to the presence o=
f
> the BPF_F_BROADCAST flag in the 'flags' value in struct bpf_redirect_info
> to disambiguate between a single-target and a broadcast redirect. And onl=
y
> read the 'map' pointer if the broadcast flag is set, aborting if that has
> been cleared out in the meantime. This prevents the crash, while keeping
> the atomic (cmpxchg-based) clearing of the map pointer itself, and withou=
t
> adding any more checks in the non-broadcast fast path.
>=20
> Fixes: e624d4ed4aa8 ("xdp: Extend xdp_redirect_map with broadcast support=
")
> Reported-and-tested-by: syzbot+af9492708df9797198d6@syzkaller.appspotmail=
.com
> Signed-off-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
> ---
>  net/core/filter.c | 42 ++++++++++++++++++++++++++++++++----------
>  1 file changed, 32 insertions(+), 10 deletions(-)
>=20
> diff --git a/net/core/filter.c b/net/core/filter.c
> index 786d792ac816..8120c3dddf5e 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
> @@ -4363,10 +4363,12 @@ static __always_inline int __xdp_do_redirect_fram=
e(struct bpf_redirect_info *ri,
>  	enum bpf_map_type map_type =3D ri->map_type;
>  	void *fwd =3D ri->tgt_value;
>  	u32 map_id =3D ri->map_id;
> +	u32 flags =3D ri->flags;

Any reason you copy ri->flags to the stack here? __bpf_xdp_redirect_map
seems to be correctly resetting it for !BPF_F_BROADCAST case.

