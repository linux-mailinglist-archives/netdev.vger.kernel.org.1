Return-Path: <netdev+bounces-224864-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F31AB8B0C8
	for <lists+netdev@lfdr.de>; Fri, 19 Sep 2025 21:09:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D4FC4A03503
	for <lists+netdev@lfdr.de>; Fri, 19 Sep 2025 19:09:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A687283121;
	Fri, 19 Sep 2025 19:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hXCxHh8N"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D1F4280CC8
	for <netdev@vger.kernel.org>; Fri, 19 Sep 2025 19:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758308959; cv=none; b=g/UJxwmM2HTYrp6kSNTC6g1fu0L0/a3vrXLiN//efS3oJ+C+MJc05CQVQUIL48U8wTomu1PwcwMIPadyhuTmIY6eJs1MuN6Dpiyp/bCFqZnZiCaAHYmdooSnEXPxESKUHQNx9U1RtD4rc6QNQZ146mMCmsGllmMxTt5VE5QKx4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758308959; c=relaxed/simple;
	bh=I6jtwFO4rLlCn3Qr98wO3TZ4R5zgDcuCAtGJjeBz4KM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mZmiPn+K+N+wA86itTToMlGxQxY73osvtrSLMQnhRdxksXuPn8ja6hKCdgB1vT6+lWFZeZXCwJbShBb776qsF5hLqUNdVdOpHarz5R+cxVJOV80usXbFDiLbt4nYn9M7hVciIRDT+kD+6zWfrZw9iPZf7cFc6QwYHkPpNAYt9q4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hXCxHh8N; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-4b79773a389so25473421cf.1
        for <netdev@vger.kernel.org>; Fri, 19 Sep 2025 12:09:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758308956; x=1758913756; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vXbAvw5kkLVhGfc5Ze9Jc+p6148kul0m6ybt6DGydeg=;
        b=hXCxHh8NCbn0JujoChJPSy9bcSl39TyHyq01HV0SDhHBu7LAbEyO0uK6HQv37Vf4u5
         gTFIwC+mQPrRHmp9aFFvHoI2xnkjDkrOlh+LS1DAbqAhwFnGSO8j/OaFD3zb7NaAJ4Jg
         oYKmkGEadimwVh8bZt0Hqf4HvM2CxGJbe7rXnMEsDRoZayvKrnZHOo6V9KkE14wPApax
         DbJJ6/NFnHYqqhUsosZFrRAV6srW7rDQA7aixuoYnjHso4RQ2PVLmNaACIBB2E6yP+1Y
         ySyUcDJh7P2qyrcSOCVoGuTqIzikYH3/f6f1NRFlfJldjzNGOc1P+MjaMdea+WytqbNj
         otZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758308956; x=1758913756;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vXbAvw5kkLVhGfc5Ze9Jc+p6148kul0m6ybt6DGydeg=;
        b=nkjqxuaA2elp/bKkD4FSYV8TYvMGNYmCyf2NhS9lDt/xxFXMNR1oYs1eZ9XNQUF0n7
         uGcmvCRmxTwvSOBMIGplycKrPw1VcJtd7jwBlQZIRNwZq82BYvQvmz2dUujYodRUIIFv
         1fmjS02uAlWuMQcSDcQz2CTSPJN3ur2cC2+aGuHCt8Vexd7brNjb120K+VDvkda66K+g
         csOKfRIIU84MQkQuhLG8L+czY4rg+oIARynF9hcVhU4uOp6LZsiRbiXhQpm2Z11YxHAU
         3GQjfXvztUlqzdu3Ol5/4E2Oo9Qm0lRKA2kIXQatnltHD+R1cxSpsgE2cVHL13FrXAWj
         E72A==
X-Forwarded-Encrypted: i=1; AJvYcCUgm10cTZ6qUuWXmyCxrjQt2PBVtaLPxg27/qE6Z3gXbn+o9damNeT1v/mJDq9R4WpNHyRwb9A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3y9sSIVyKcYIVlfhjSYYUwJkwobvji9wYl7MWYU8/Uy1BPmKE
	UyQf2uBe6fgZQ85PrNNaoGBlnxQ716p984Qr8rxySmOzTTm/L1mzV5tohgJTEVcXmQjQnNa1xe3
	R5/MeQprkU+d19iThYza1sVOlApyBvUzS1CC/hRI4
X-Gm-Gg: ASbGnct3J1l4cGznl7qt/9b2x19IEj8cwIMyepJib607tuF0J7WSisdAsAdkGjh/uwi
	QHspVZsKcRnPqdJix4lYqvUR1QQGYaAQEWSDor3/+SOGRhfoATysLZM6Fj+y4UNZ42HqhC1S1O+
	BwlWSYbiHCbQTzLeqxDqyTAr183GGQIz3099rw6nBgrf21fneE4YxKtMOEOd+TakG1KPM7iqWC0
	1Cp1A==
X-Google-Smtp-Source: AGHT+IHK4rrWt8hd+ehEHrqlcbzDHbyFpcHelDgbKsL1PGeJzPjV9eDyf0iQYAEDXEKf6jxfMvTMc1pEz6lgz1mBp/E=
X-Received: by 2002:ac8:7d01:0:b0:4b7:a62d:ef6f with SMTP id
 d75a77b69052e-4c072e26929mr51253261cf.64.1758308956080; Fri, 19 Sep 2025
 12:09:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250919180601.76152-1-hariconscious@gmail.com>
In-Reply-To: <20250919180601.76152-1-hariconscious@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 19 Sep 2025 12:09:04 -0700
X-Gm-Features: AS18NWDU8qkSN-NhK9yhAi1bjWHatilGj8aec2jq6okG1y-abKQuoQiJV7Jupu0
Message-ID: <CANn89i+ara1CeKOfuQgZ+oF3FMv3gF2BLP_7OSEEqytz-j9a-Q@mail.gmail.com>
Subject: Re: [PATCH net] net/core : fix KMSAN: uninit value in tipc_rcv
To: hariconscious@gmail.com
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	netdev@vger.kernel.org, shuah@kernel.org, stable@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	syzbot+9a4fbb77c9d4aacd3388@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 19, 2025 at 11:06=E2=80=AFAM <hariconscious@gmail.com> wrote:
>
> From: HariKrishna Sagala <hariconscious@gmail.com>
>
> Syzbot reported an uninit-value bug on at kmalloc_reserve for
> commit 320475fbd590 ("Merge tag 'mtd/fixes-for-6.17-rc6' of
> git://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux")'
>
> Syzbot KMSAN reported use of uninitialized memory originating from functi=
ons
> "kmalloc_reserve()", where memory allocated via "kmem_cache_alloc_node()"=
 or
> "kmalloc_node_track_caller()" was not explicitly initialized.
> This can lead to undefined behavior when the allocated buffer
> is later accessed.
>
> Fix this by requesting the initialized memory using the gfp flag
> appended with the option "__GFP_ZERO".
>
> Reported-by: syzbot+9a4fbb77c9d4aacd3388@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=3D9a4fbb77c9d4aacd3388
> Fixes: 915d975b2ffa ("net: deal with integer overflows in
> kmalloc_reserve()")
> Tested-by: syzbot+9a4fbb77c9d4aacd3388@syzkaller.appspotmail.com
> Signed-off-by: HariKrishna Sagala <hariconscious@gmail.com>
> ---
>  net/core/skbuff.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/net/core/skbuff.c b/net/core/skbuff.c
> index ee0274417948..2308ebf99bbd 100644
> --- a/net/core/skbuff.c
> +++ b/net/core/skbuff.c
> @@ -573,6 +573,7 @@ static void *kmalloc_reserve(unsigned int *size, gfp_=
t flags, int node,
>         void *obj;
>
>         obj_size =3D SKB_HEAD_ALIGN(*size);
> +       flags |=3D __GFP_ZERO;

Certainly not.

Some of us care about performance.

Moreover, the bug will be still there for non linear skbs.

So please fix tipc.

