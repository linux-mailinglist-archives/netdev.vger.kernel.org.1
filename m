Return-Path: <netdev+bounces-112976-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B2C5593C12C
	for <lists+netdev@lfdr.de>; Thu, 25 Jul 2024 13:54:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E3831F22954
	for <lists+netdev@lfdr.de>; Thu, 25 Jul 2024 11:54:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B5581993B9;
	Thu, 25 Jul 2024 11:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XzmSzcB/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D56D7199398
	for <netdev@vger.kernel.org>; Thu, 25 Jul 2024 11:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721908425; cv=none; b=FlXR0m/0rbCnA65ieuke83aNUTet5zuu0xdy0uUbWErXLQJul6gSVbRbRYUTe+7rabZjogiB9rpUPPDrh9hFtgChndcDPoPzyvS34M3m8nkWsjeOXAx2e9EvvXFdnwCS3kwbl7IWjNPuL5au8d0wY2YXY8ODpCBlXtCMxShLWgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721908425; c=relaxed/simple;
	bh=6PGgGYHRW1Fy1ldCtA21C6UkADY3uVnVxlOU/P1ZO7k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BVtfJFa/jTfda/H926cURdGn0yJG+KVLjp1vrU3jdqvLPItIBYc3XqQur4PF9MKIsadX7CnOANLQntkIoIDfd510tpJ4gRQYQ+yzxdVc3PzKKBZrUUwAIs+ob2qEf/AL5sdI/fQuACxLgqxhjI3Q1wmDEfkMNy8bvgc8soh4jbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XzmSzcB/; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5a18a5dbb23so10252a12.1
        for <netdev@vger.kernel.org>; Thu, 25 Jul 2024 04:53:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721908422; x=1722513222; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tp9zFfq6Mp6wXC8Na+4ujbdqv2pzT03d9NP2nnsFpQw=;
        b=XzmSzcB/f0xzkTgiOuowrBPyUD1v3q74J0sg1gKpmnj6DJX6l0EtWLH4npd20r7VVk
         YuIx0LMe0CGi8czkBzz8B2ALJBHFKvWAkJITI0htMkLkWl3QSQ/51DqtasJned7YK2aU
         JWzgfHTGGwKkICeba/t7JFx+xaTbGTX3hUVKO7SL4bpHekpTkhaM9BrQMtBrcYvb4agZ
         XlN/G9C5mGLkLDL3SR8mFFP/P/fdVZCJy+LydBRrpkoLGizv5KsIAEjRr63fp8ScbRyw
         oRtS6ya/+DKEJSdDDl3Uik4VcRgiuuH4drc4ETJdsEYE+6grpfHmJytAaTNrDiiylm+H
         mKkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721908422; x=1722513222;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tp9zFfq6Mp6wXC8Na+4ujbdqv2pzT03d9NP2nnsFpQw=;
        b=FfEjuPh6tLJOWICYkODDAvJf8GNkNcqiUnW5wTQYeJyuit0GHBVaMX415cDPIWUBGn
         8TuxHuMupmjLT8O7GnkY5+6o2xBh0+VaObAjd1hw2yCmHyxuUngzXSoZcD6LwKDbp4I2
         ZJYLXIL7HFCWwh16vT/hQRN21lxpf3QQB/+tkyI12ZEMry8O0HZ1FA4iX8WS07WunrBO
         FP6H6FDaLdG56ehsp9BQtfdB35EDm/003dimebjRO88YHVJ0HsTmGK9oQaCo+4Ncbu4R
         rB7prPFuwHpvv3v+SxuJL6bv8iUXRRlaVoZDNkf3KE/MSUIUZ+W2CHDPxfyLewsVcnpb
         +vgg==
X-Forwarded-Encrypted: i=1; AJvYcCW7dNbD1HQJUkhqfs/PftQ2yZqdA3hA/ab0oYKGpj4ppHQQ4hH9wPbukZzYSoW8HCS+XZf/qh/iILiGqbE9jBv/P40Mu0KS
X-Gm-Message-State: AOJu0Yyi8ZF1iuitWCKhkHWlvWDrsqQdW0laUb/99Q+QgFafUBXKWukH
	l7eki6M5PStGdAreHOVu/EyVUo7t2k+P2QEvFna9hsXZxEMP5S52YiIDDeGHdrmQmkG3SwCvsDR
	HztlhiHVtpuVcUnwJTRHrGGLtGg5B4/im7QlT
X-Google-Smtp-Source: AGHT+IF4Nc85qJaIsgPDyd9SnzqU79cudDhEao8n/ZdhzfhOJiiXDZ2e4ajJAvQNyK9PoM9KTLeZ2xX5pt+ED/IdJso=
X-Received: by 2002:a05:6402:268a:b0:57c:c5e2:2c37 with SMTP id
 4fb4d7f45d1cf-5ac2c3b3eb1mr205737a12.3.1721908421621; Thu, 25 Jul 2024
 04:53:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240724135622.1797145-1-syoshida@redhat.com> <CANn89iKOWNa28NkQhhey=U_9NgOaymRvzuewb_1=vJ65HX1VgQ@mail.gmail.com>
 <d2014eb3-2cea-474a-8f04-a4251fd956c9@redhat.com>
In-Reply-To: <d2014eb3-2cea-474a-8f04-a4251fd956c9@redhat.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 25 Jul 2024 13:53:27 +0200
Message-ID: <CANn89iL_fyHeEh0ymxYuSEtNg10wnzPbaOo06xToejMmDxRHNA@mail.gmail.com>
Subject: Re: [PATCH net] macvlan: Return error on register_netdevice_notifier()
 failure
To: Paolo Abeni <pabeni@redhat.com>
Cc: Shigeru Yoshida <syoshida@redhat.com>, davem@davemloft.net, kuba@kernel.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 25, 2024 at 12:13=E2=80=AFPM Paolo Abeni <pabeni@redhat.com> wr=
ote:
>
>
>
> On 7/25/24 11:44, Eric Dumazet wrote:
> > On Wed, Jul 24, 2024 at 3:56=E2=80=AFPM Shigeru Yoshida <syoshida@redha=
t.com> wrote:
> >>
> >> register_netdevice_notifier() may fail, but macvlan_init_module() does
> >> not handle the failure.  Handle the failure by returning an error.
> >
> > How could this fail exactly ? Please provide details, because I do not
> > think it can.
>
> Yup, it looks like the registration can't fail for macvlan.
>
> It's better to avoid adding unneeded checks, to reduce noise on the
> tree, keep stable backport easy, etc.

Shigeru, you could send a debug patch when net-next reopens next week,
so that we do not get another attempt
on fixing a non-existent bug.

diff --git a/drivers/net/macvlan.c b/drivers/net/macvlan.c
index 24298a33e0e94851ebf9c704c723f25ac7bf5eec..0803fcf8df4c56ede10597c8622=
88c7aa887160e
100644
--- a/drivers/net/macvlan.c
+++ b/drivers/net/macvlan.c
@@ -1849,7 +1849,8 @@ static int __init macvlan_init_module(void)
 {
        int err;

-       register_netdevice_notifier(&macvlan_notifier_block);
+       err =3D register_netdevice_notifier(&macvlan_notifier_block);
+       DEBUG_NET_WARN_ON_ONCE(err < 0);

        err =3D macvlan_link_register(&macvlan_link_ops);
        if (err < 0)

