Return-Path: <netdev+bounces-229529-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 13E75BDD96D
	for <lists+netdev@lfdr.de>; Wed, 15 Oct 2025 11:02:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id B554C353C7C
	for <lists+netdev@lfdr.de>; Wed, 15 Oct 2025 09:02:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0610C30AAD6;
	Wed, 15 Oct 2025 09:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PIwyO76T"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54619307AEC
	for <netdev@vger.kernel.org>; Wed, 15 Oct 2025 09:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760518942; cv=none; b=mu4JqwCIDTcBnOVCk0d3LJTgOzWYEXNnG5d9CvZ7oYCv2jVUfHhcIPDeQVZrKjuq047lDRqBYKpMMgERsxcPylL2d5YMuhQIdKTwOELwCobbIHP8Ou3kmfCYrifhrTU3RY1USwXkd7u3ixy6w8Lw46WhxHa/SulSrCFO+PYSYJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760518942; c=relaxed/simple;
	bh=b/PKC4yK0a4x5vf2zpz2TWgJjUR+SxyTzU1jKnoUD2w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cfUjfET4KM9EGh44HOd9g1rPLua6JMzkBlbUvDF2MFUM4Y15YHz4TIzcC5nys5CceWDNvDPVUL8UoYZ4RJ+e8jiM3mD7otlsZ5ClVryeNDNREjVqRM6Fl12kdzT2+dEpj6Bad5Fns90Maefh/eQfAV/az49ENHJ706VLjjnpHzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PIwyO76T; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-862cbf9e0c0so796751685a.0
        for <netdev@vger.kernel.org>; Wed, 15 Oct 2025 02:02:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760518940; x=1761123740; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jbs2y26oKdHy+MMdOrQWvg1qB8gmvSLdQ2iIuvZktFk=;
        b=PIwyO76Tq3+mX2wdWbD9NHFb0oQwDkmpJraZLkJNhe6Zv3cEwiZ6PY9WLIgBshlZgp
         K7x2vYJqZ5601d1aR5nNDBzBYAfKRNQOFq6U5QAE2vHOqXJBSM5U4QNTYS8hvPanacUu
         K600AoKJr6mrel2cCm/uW5v3cO2fg6BiJ3z6SJXlnywUDmKSy+BLpP/p9t2tnCplkIe5
         NxE+gdVNS3kclZtKrgU17kxSUS/88p9zLqIRjeJeLHFzuiU3MiKDFaPALr7yP9qJPaxx
         4fbGHyIYg3neY7PC70CW5TINeVr6OcM0cFaAw7zoFEkPKLL8ywF7PcSl1KFOqkMlTh1h
         3qoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760518940; x=1761123740;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Jbs2y26oKdHy+MMdOrQWvg1qB8gmvSLdQ2iIuvZktFk=;
        b=I1nURI+qHzE9xRrSqBUh6ETc5BvHoxgwpWiW/8vuW/nYuP8pl+wG1jRdun6M02RfPs
         K6TVqUnf558yQWXF/BK08D4aMiHQ7qm6Jevxd5XR5ov4cmShYJOQ0QcYxrI4CG+5g4wA
         7anLbVoBOm5lnGFeb29M2ts9wC0xlnOvoKvbbMa5PpR3sbA48R/48+Kt2CrBmCbfi+xU
         XbTQLDiFw/Wttg/8ECDjPWttpiUHq4B8n1jeH441aIYBVBBsY8+X342amb/59X2vuAzM
         Wxcm9EmIzGtuOr+TKF+l6GPPaRodaxdJ6BTVq7W3YWNoYNkdhU+MRwNGeklk/8Cgp906
         kRmA==
X-Forwarded-Encrypted: i=1; AJvYcCW5Sth9cVpeICwPqxB/N6E7KzAIWPlBqps9zKCwTohLpJK7WKtZFn/TnijV0JqVokaFkzapEr0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyqjx4IYHn0ObtiGRC+BREGAftNulMl1Y4F6S1RIwJr/ePYQXsb
	FkRmvTuaTTe4p95h6YrKIVW/fi2/WP1gFsCDG6NeEQ3sX65rWj7LQX7e0Afea3tG/yeqdiuqFC5
	JSbv3zkZl47CIBT2sY5bxL+cvPekgnX7bI91T/Tf8
X-Gm-Gg: ASbGnct1ohHQTO9Z3lVArMCrC+ULsIpaB8quy1m/tq2y/UL9EoYJwf0sR97KIpmSTIE
	TxoHHX8MvG39T5Tj6lz/cVNfqXkeH6Psw2AECDznADS0tXMpR996QAZZFWJQz9KVAqrUW6lBsY0
	IlvzY3ddpWEvhWO+yrOV9KmtUfWDtILLWrVmXTViU0pEXJcvnv1/3tF3/MpynMoEUqb2CHR+PeL
	j+/OZ9+uhllBjKHn38kZVOuCnmbrCsDPw==
X-Google-Smtp-Source: AGHT+IG5nbpHK2kkLKQZDx7uXUf1dW8noyRFrN9p+JOB5yKBrBTZCMEeHE2xEDU+ieEt2LshZHhgdej9Xt268wXpqWE=
X-Received: by 2002:a05:622a:350:b0:4d1:2fe4:1ba9 with SMTP id
 d75a77b69052e-4e6ead4a6bcmr340726131cf.43.1760518939710; Wed, 15 Oct 2025
 02:02:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251015020236.431822-1-xuanqiang.luo@linux.dev> <20251015020236.431822-4-xuanqiang.luo@linux.dev>
In-Reply-To: <20251015020236.431822-4-xuanqiang.luo@linux.dev>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 15 Oct 2025 02:02:08 -0700
X-Gm-Features: AS18NWCu_MHbJeNbbT_nkNrBdLE1O7ipXh6nIwD1yVrORkpLpRb0wyGiFcOEDEE
Message-ID: <CANn89iKjBJ_GUKk0+k5AHbhtp_cmN4e-PYU6j9_+XEVBspRUaA@mail.gmail.com>
Subject: Re: [PATCH net-next v8 3/3] inet: Avoid ehash lookup race in inet_twsk_hashdance_schedule()
To: xuanqiang.luo@linux.dev
Cc: kuniyu@google.com, pabeni@redhat.com, kerneljasonxing@gmail.com, 
	davem@davemloft.net, kuba@kernel.org, netdev@vger.kernel.org, 
	horms@kernel.org, jiayuan.chen@linux.dev, ncardwell@google.com, 
	dsahern@kernel.org, Xuanqiang Luo <luoxuanqiang@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 14, 2025 at 7:04=E2=80=AFPM <xuanqiang.luo@linux.dev> wrote:
>
> From: Xuanqiang Luo <luoxuanqiang@kylinos.cn>
>
> Since ehash lookups are lockless, if another CPU is converting sk to tw
> concurrently, fetching the newly inserted tw with tw->tw_refcnt =3D=3D 0 =
cause
> lookup failure.
>
> The call trace map is drawn as follows:
>    CPU 0                                CPU 1
>    -----                                -----
>                                      inet_twsk_hashdance_schedule()
>                                      spin_lock()
>                                      inet_twsk_add_node_rcu(tw, ...)
> __inet_lookup_established()
> (find tw, failure due to tw_refcnt =3D 0)
>                                      __sk_nulls_del_node_init_rcu(sk)
>                                      refcount_set(&tw->tw_refcnt, 3)
>                                      spin_unlock()
>
> By replacing sk with tw atomically via hlist_nulls_replace_init_rcu() aft=
er
> setting tw_refcnt, we ensure that tw is either fully initialized or not
> visible to other CPUs, eliminating the race.
>
> It's worth noting that we held lock_sock() before the replacement, so
> there's no need to check if sk is hashed. Thanks to Kuniyuki Iwashima!
>
> Fixes: 3ab5aee7fe84 ("net: Convert TCP & DCCP hash tables to use RCU / hl=
ist_nulls")
> Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>
> Reviewed-by: Jiayuan Chen <jiayuan.chen@linux.dev>
> Signed-off-by: Xuanqiang Luo <luoxuanqiang@kylinos.cn>

Reviewed-by: Eric Dumazet <edumazet@google.com>

