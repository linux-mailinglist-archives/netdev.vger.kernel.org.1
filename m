Return-Path: <netdev+bounces-180447-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B9EFAA81589
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 21:11:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2AC571BC1A31
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 19:10:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6343A253331;
	Tue,  8 Apr 2025 19:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OCF3bPaL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D001D23E34D
	for <netdev@vger.kernel.org>; Tue,  8 Apr 2025 19:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744139231; cv=none; b=TfIeFItV72a9UMk3lpXUkghB6JKNnih6XtIOSqdD/YBCgFbRA2xsRbKyY3CV3Og0wHH3G7vJeArl/q4SMYJ/I0vWdQIZz6mWVjnUH6LilRNsJGBYkZiMb5n2hpzSu8XNKMP6/f6AK1Af89gBKajSGSq56BnwS/vzGVYGst9nbKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744139231; c=relaxed/simple;
	bh=pZLJnU5MBzggGR25yfKxPJTnmjKhYM8nlpq0QnfKJxA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TMDwIncDJ82lbnr48u0NUcqUH1zBe9gW0FnS9v16b+szBmRC42Y/L4oSeYyuZ5BN55fBWgl6vcEElzvpNCAMQxtGORJ1wYMRWcj0Fglb91N6QZ3IzcpNgIPqq6l0ntdC7ifbAg3CRQjT5auHmArhqiCLBf3ojvx/wfNWTqiGvEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OCF3bPaL; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-4766cb762b6so153151cf.0
        for <netdev@vger.kernel.org>; Tue, 08 Apr 2025 12:07:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1744139228; x=1744744028; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=93nqZU5s/fidU6KQmyWJ+8+WA5HOv5RZeLSBQVSW7pY=;
        b=OCF3bPaL+3FslH9YZ7CeEequAgIIflLAkq3A89gZwajAjvd2UJXzcAzBlCZG6rYPZJ
         upqUh63rnD725UMuiQgSkyiL796Vrx08Rb9XTHvQvim9eVvVZLVbCz9NizR+n1UASfTI
         AKR5OKorFLAQ1oYjw7v5+uwfy98VNf0w34HO65Lq6QE5zrCVEtzaqenfhW4YM2ljQAZP
         8sqzWnSge9pMwaYXEZ4bnB45+OP99+0vBwQfwQObb2yQGyNvb28X0RVMLeYDSscPTPBh
         LAxFvxRXGro+5gLdyTNTr9Mx/ljL/utuzkpBvcLRpFBIOMXBO8etDf7fzdKpqb+1/+3C
         XNbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744139228; x=1744744028;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=93nqZU5s/fidU6KQmyWJ+8+WA5HOv5RZeLSBQVSW7pY=;
        b=NGZugePA0+mNNG7gavG1esTR7riImTAwCEjsSYHbLOiRIG9rc8v5Hz47beIyK4yMjD
         biVk7icyuHGVoDY10gnqyGEWetvQK0hbW5WBC/e9wlyh4cAPc85zrTE94nM3+dxEoCFf
         SoKTXtooqWNNHM2fPEJYHXl0MwNMrmGVNY5O8ENEfoedfd4KD1BIvAscU1HvqG23CTTy
         b5mgn/Lmt/+8ZwKhZYEZ5GVEY1l+K48D0NF1K2+mXW/GR5pNdGLpZxQlNAqIIC7nlwkz
         jaFQdP7PG/6dqAX5DSmHiU4411NPiTFDuCB/diTPB5+YQdNrUcykr7/H9xAQflCJJaOo
         ZXqQ==
X-Forwarded-Encrypted: i=1; AJvYcCUreCmE7eku2nDk9TIa4InZEEl0YCQ+kqSU4MHOZJJ30yPmUCbk66f4BgcSb/NZbKZFEZ7ZUaM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzdWQ3fgRObpr11ndGJUVJdr36vYaBXGT5WstYI3yFH/r6bk69m
	h2EerKwPZZHD8svZdphWdfxCQACCTGm7hvwTB/AFOrtpMIcptwSH2DNYRu/nfVqZ5CjlRLAA+62
	pbB26iHrIWxf1uxMZtIdZVWqNpJy3mWcl9KHZ
X-Gm-Gg: ASbGncu1Lk3YLONizqdQSI86+PK/YfWeMnQXUqzOvj0fY+g5BJjv8M/Ba2LyKxe3jjI
	+XJ2EcXZ31I4P25L36fKKsuiip43cxWbJ0o/gJLs0CPuVdBblUQ3ttcojJ2skB2/IsSVYFHeBbX
	FczPwipoT1r4G3bSiHR6mrjM7svTMMOijtNP5liQ==
X-Google-Smtp-Source: AGHT+IHU3BjoLfm0LIuRrotuBrlGix9R6faP3V4CJEcVcdR9oJuJJuB96HzJW4gxD+c3m7UP0Jupbiy6dgNF7zINniE=
X-Received: by 2002:a05:622a:b:b0:477:1dd7:af94 with SMTP id
 d75a77b69052e-4795f06e7f4mr3538441cf.2.1744139227413; Tue, 08 Apr 2025
 12:07:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250408-fix_net-v1-1-375271a79c11@quicinc.com>
In-Reply-To: <20250408-fix_net-v1-1-375271a79c11@quicinc.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 8 Apr 2025 21:06:55 +0200
X-Gm-Features: ATxdqUGZJ248TBvxAhOrlI6sj4tN-bv4Xzr4A8hA3BIPlgVZCyrznqJKUvvciOY
Message-ID: <CANn89iKP-5hy-oMuYwEvwFOzzAkfF5=8v7patSE5z7PZQS0V2Q@mail.gmail.com>
Subject: Re: [PATCH net-next] sock: Correct error checking condition for assign|release_proto_idx()
To: Zijun Hu <zijun_hu@icloud.com>
Cc: Kuniyuki Iwashima <kuniyu@amazon.com>, Paolo Abeni <pabeni@redhat.com>, 
	Willem de Bruijn <willemb@google.com>, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>, Pavel Emelyanov <xemul@openvz.org>, 
	Eric Dumazet <dada1@cosmosbay.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Zijun Hu <quic_zijuhu@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 8, 2025 at 3:43=E2=80=AFPM Zijun Hu <zijun_hu@icloud.com> wrote=
:
>
> From: Zijun Hu <quic_zijuhu@quicinc.com>
>
> assign|release_proto_idx() wrongly check find_first_zero_bit() failure
> by condition '(prot->inuse_idx =3D=3D PROTO_INUSE_NR - 1)' obviously.
>
> Fix by correcting the condition to '(prot->inuse_idx =3D=3D PROTO_INUSE_N=
R)'
> Also check @->inuse_idx before accessing @->val[] to avoid OOB.
>
> Fixes: 13ff3d6fa4e6 ("[SOCK]: Enumerate struct proto-s to facilitate perc=
pu inuse accounting (v2).")
> Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
> ---
>  include/net/sock.h | 5 ++++-
>  net/core/sock.c    | 7 +++++--
>  2 files changed, 9 insertions(+), 3 deletions(-)
>
> diff --git a/include/net/sock.h b/include/net/sock.h
> index 8daf1b3b12c607d81920682139b53fee935c9bb5..9ece93a3dd044997276b0fa37=
dddc7b5bbdacc43 100644
> --- a/include/net/sock.h
> +++ b/include/net/sock.h
> @@ -1421,7 +1421,10 @@ struct prot_inuse {
>  static inline void sock_prot_inuse_add(const struct net *net,
>                                        const struct proto *prot, int val)
>  {
> -       this_cpu_add(net->core.prot_inuse->val[prot->inuse_idx], val);
> +       unsigned int idx =3D prot->inuse_idx;
> +
> +       if (likely(idx < PROTO_INUSE_NR))
> +               this_cpu_add(net->core.prot_inuse->val[idx], val);
>  }

I do not think we are going to add such a test in the fast path, for a
bug that can not happen.

Please give us a reproducer ?

