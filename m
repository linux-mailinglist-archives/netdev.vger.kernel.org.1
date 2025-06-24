Return-Path: <netdev+bounces-200790-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E92E7AE6E97
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 20:27:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C9061BC2D16
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 18:27:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 090372E62BE;
	Tue, 24 Jun 2025 18:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="M3Ty8lsj"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77B73274B34
	for <netdev@vger.kernel.org>; Tue, 24 Jun 2025 18:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750789615; cv=none; b=S+XN+R/hamlyqZyxDXqGWo1pBLEnW/fqN/J44f3RqYB3soeTAUwNO/aH/RoY+WGcBCxPRvMfdB82dzYW7045h9w8IwykLlQieM7RZltPjNQ1NJNBzD3S78vGEld4UZ5gcZbaTVEJ0o9jUk99kzXNMvGaH5Tu/zhjd+P9tAMqiDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750789615; c=relaxed/simple;
	bh=HFbSzYd+mqxN5pXKtHnvjoXNDEkTAPKwFubZBZilaE8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PzNiTNRGOnyp1a3b/aDOsH1bPbPy9c7gsqg2YetdEyFEYf5N4S49IeoVfjtUTAjvAG3GuiE0uVgyAq9o127NQn7OHbE4GtmquLMaJ+yWropIlFr2d+UzU820hN+Wj+nps/o1211gILGMT82+PDLjasd4eCaO8Bo309mcdw/arCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=M3Ty8lsj; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-311d5fdf1f0so5365591a91.1
        for <netdev@vger.kernel.org>; Tue, 24 Jun 2025 11:26:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1750789614; x=1751394414; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DfORqwPEBwe7uV2f/5Rz+iOYAL0FCQqJXYRyyOAw9qc=;
        b=M3Ty8lsj7qcRfOitV+mLl9/Jv9KVIh/O8lpGF16GshumOlYUGrj38ijyLShWNF7Jiv
         1roazMUcwnxu9u6Ba+U+n2lK5TwUSGyUUSwJ5zKzfQwvkZ+LxSh4G1Rp7fjiigM2Hx2p
         F4jbPYkXHLIrDDKkVjBRGfFcgMn8+m74aX/DIHC714RgRdVfs2C4UQjn5CUwozmb1f3I
         JeYjr/L92ozjhyDJXG+1ELfpMiqYoxSoxAiq0Xf9mfADGsATsuCX2qj9fWdNu2ta3Qzp
         jPddNqokd1rB6j8+ijIG7DCn6jO6AAE5SxO3rhTYIy90qaDFhxVBzu/NZMuJk7Qntr3a
         Xetw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750789614; x=1751394414;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DfORqwPEBwe7uV2f/5Rz+iOYAL0FCQqJXYRyyOAw9qc=;
        b=R/qlf9KO1O7rCSTnZ1otUICITKSUS/pHJ3IQ5kOUUEVO0mtOlx+GuK2E6sF3Z6ESHJ
         actBM9nByUqhg31rjThtxy7XTWn1S4IuxEQvsXyz7Oj8Jfh900CtYOJAhrabYWook9uW
         DP+0IXT9GIbfV6eOmuZoWeayba+yEVXxTKgM2UuVIvCMvI/AKf1T3IUGCrEKVk7l+dXK
         FwnTSZr8AFmnjbd0KUvyysBGXiSxJrqKXEVSiAB3ByqnJqyKHNtjkgGx89jLCM2Q+4YY
         QZNJuZkT4mLg1s0vJbFKpnq/8J1mxw1In9NloIJNldoMW7xg7aW7SgxXnkErJaDxpxCm
         NgsA==
X-Forwarded-Encrypted: i=1; AJvYcCXUrgwCURXVp1GN62kkxWOu9h/9HJnn1GckzqqW3qRzLVhuyhkkwX69LImVNzLcykYAwsrzSzQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyomdyPUWzecn9exloKCBgReEzbFjSzKmTpcPEqMDajQixg7QwL
	TODk8SOcSlskgrGDSGcQtJ13hJ6hn5PnHKKu90HMX2wjAkHUxMykayxro/ZgrdHbI3w1aRwvUfA
	MD5dDmcJbiRNnwrjj6Zhwcq166fFNzv5UzJVnPDPa
X-Gm-Gg: ASbGncsG3HbVgijm3Is3Xu/ZQKu3d2HAoyfYGh8zpDl2nFVCeNM6Fp2qeuyn0tXTBaI
	MBjgBxm65gd6s6xPPwjWn/vhl8mLsZrxwNjqFOymuYzYp+bCfX7ouAzFS5QrDcg5DH7GLUbGeO4
	P7wNaHoyRJbMeBCRguDzO1YQwLTcGyyvp7NFpz5xbq3OzpAtcbRvqU3VtAHB5tg01Wn7jYBbVHd
	Q==
X-Google-Smtp-Source: AGHT+IH1/zQNp6I1p6hBqo8VrrpP+G9Mqp2P2w6NaBmxw9sa5OuKVbJpJ2osu1ZB77jYC/gfIYOUgmtBjuFR+0bvZaQ=
X-Received: by 2002:a17:90b:4c42:b0:311:e8cc:4264 with SMTP id
 98e67ed59e1d1-3159d64a714mr32148948a91.12.1750789613525; Tue, 24 Jun 2025
 11:26:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250624140315.3929702-1-yuehaibing@huawei.com>
In-Reply-To: <20250624140315.3929702-1-yuehaibing@huawei.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Tue, 24 Jun 2025 11:26:40 -0700
X-Gm-Features: AX0GCFs98LXgUtbrFARLUjGAJi0S9xWz1KZnlb7kgU4F1zKPOXytkgaSgwGMYiA
Message-ID: <CAAVpQUAEA6jkcM4VhzgYnx-dS1FEodN7y3DSK7LAh7Evt6bgjw@mail.gmail.com>
Subject: Re: [PATCH net-next] ipv4: fib: Remove unnecessary encap_type check
To: Yue Haibing <yuehaibing@huawei.com>
Cc: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 24, 2025 at 6:46=E2=80=AFAM Yue Haibing <yuehaibing@huawei.com>=
 wrote:
>
> lwtunnel_build_state() has check validity of encap_type,
> so no need to do this before call it.
>
> Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
> ---
>  net/ipv4/fib_semantics.c | 8 --------
>  1 file changed, 8 deletions(-)
>
> diff --git a/net/ipv4/fib_semantics.c b/net/ipv4/fib_semantics.c
> index f7c9c6a9f53e..475ffcbf4927 100644
> --- a/net/ipv4/fib_semantics.c
> +++ b/net/ipv4/fib_semantics.c
> @@ -625,11 +625,6 @@ int fib_nh_common_init(struct net *net, struct fib_n=
h_common *nhc,
>         if (encap) {
>                 struct lwtunnel_state *lwtstate;
>
> -               if (encap_type =3D=3D LWTUNNEL_ENCAP_NONE) {
> -                       NL_SET_ERR_MSG(extack, "LWT encap type not specif=
ied");
> -                       err =3D -EINVAL;
> -                       goto lwt_failure;
> -               }
>                 err =3D lwtunnel_build_state(net, encap_type, encap,
>                                            nhc->nhc_family, cfg, &lwtstat=
e,
>                                            extack);
> @@ -890,9 +885,6 @@ static int fib_encap_match(struct net *net, u16 encap=
_type,
>         struct lwtunnel_state *lwtstate;
>         int ret, result =3D 0;
>
> -       if (encap_type =3D=3D LWTUNNEL_ENCAP_NONE)
> -               return 0;

Now this condition returns -EINVAL, which confuses fib_encap_match(), no ?


> -
>         ret =3D lwtunnel_build_state(net, encap_type, encap, AF_INET,
>                                    cfg, &lwtstate, extack);
>         if (!ret) {
> --
> 2.34.1
>

