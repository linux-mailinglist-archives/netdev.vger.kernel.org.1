Return-Path: <netdev+bounces-164631-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6395FA2E816
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 10:44:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3FCDD3A834D
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 09:44:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3F6B1C460A;
	Mon, 10 Feb 2025 09:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uh8PjeeN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D8A81C3C0F
	for <netdev@vger.kernel.org>; Mon, 10 Feb 2025 09:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739180655; cv=none; b=Q+3fPI9KEWydhr7eOD6TdQW2Y84guXP+Tuci0HeXsaJrVrutkz1EhBs8ktJxzT/pSxFTLa0pCYBByVzucKipr8DwmLF9QCS+ePxIjVlY9NJM35otVWpGQuI/bvPP4c1BulE34cvEr0axQ7TRryUocw2nexa8llRIRlqIUcPr8sY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739180655; c=relaxed/simple;
	bh=lcEwY9vviM81/gKEQoB6k/sM/Wfwx4W36EaBfvy4tKs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J3XiHgWF0dWyIj+e/fBxmfIaFkoJJ89sucMaZQXbGAA0fWbW2pkdBa1p8kirGWI320+zMzXbJBbvks/ZNHreWit/aGqwSPNnlMcy3gnmDw964DeNGPIrCiSgqaAM/z+GWopUSWxBC4WV7lkxYnypNkRa87DMCj+EafXXZpYcnAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uh8PjeeN; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5de64873d18so2681387a12.2
        for <netdev@vger.kernel.org>; Mon, 10 Feb 2025 01:44:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739180652; x=1739785452; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f/OmYe5ItNgnhagUpPRxbOJzD662fH1pWL+88TCU/mc=;
        b=uh8PjeeNkK71BpKgtwuOOZd6MiWMRBRmbxw1wejxA04fQVKQj7RsQF4LqxDT5Tiyhi
         EcSqiWlB9hrfzC8oykIjTXWBxQMyxNhQa61f4kGTmtXrzpGuo3As7RsqapCIIbIkXuh3
         pjkVNRkBlrE2EoalCXqJbc7yjJpk4t5rwUG0Pyw4iAVFCBcKt5R/sjnMug1SFGFm57Tm
         5FvvBJ1rkkpYX0RIj8f74qjw4MAekWS0ot6Di7FIJZ7rlQVqyxxUFI2xk8aU9d1jmi/N
         ov5zQfaAqlPdLFViq0rP+y3p1mvnu0tpgCEON1zy6wM774EM3gianJxJv3eTPP0ZoFaR
         Ovxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739180652; x=1739785452;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f/OmYe5ItNgnhagUpPRxbOJzD662fH1pWL+88TCU/mc=;
        b=BklVCglXiMY/Q+yc5tRQOsuxQSTOQHxlA4RnP5ZK6aiZxBMqLxAGKq+TLImK5etP/u
         uK3R5WieTtCA8I8fXKbmDzYtJNbuN+NqJAQjZr0Vzq3ADNNv05xDVezLXH6QmJ+dOZH0
         lTUFDdhQdo30ycLhliT4HQSgxSND+CDekD+ZPFa/4Z0d2ljWlLdpNoLdEO4joFVBhi7g
         PDWJI2E3c56+RE/LVkscrdX/9bdHjY65/aGO+B5KzpOM0kRlHPo6QQCRgCsdA/6/JX0E
         bCHk/lYSJxKp2N3lsGvcYPCakrIRYYGQno20tgJ81PI92RZZrt01Mg3z+JJnJHrhnLm0
         hM7g==
X-Forwarded-Encrypted: i=1; AJvYcCXV8Blj4QE7mm2e8WzKHCQFyEcp8mpRI9soVkZp/M63jMICqzwn+BPFm0J4938Yhpi2/xs2Hy8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwsYCvE1j0i7UJWQHqloG3hW1jv8HVG87/nWjKAej3o1LrxoVHM
	L9twx6htbH6gWNTLkWX+C2WZCza78M5toi2FR5joWThNHH4sMoPymFsdk2FjgFQEtgYEqMs2qKW
	R/nYNZNRcB/DtZAApId2+VlIvOw6q6GXdNlVA
X-Gm-Gg: ASbGncuqjSlUP8G4h8OiiHK/ggNWt2uc2oHrAIZYoXsOmMQJ95QiQRGf/XEzTmQDCIo
	esmWfJ/OqMbByV+IR+lSdS1ylikJbLHGT515zfWes7px9GQtPXYcrrbq1uZJNIvSxyxURK4Eg
X-Google-Smtp-Source: AGHT+IHU3wcFsrYylwceUx+ADhoekIhjj5OUv9zhhGLXfwK34sw8qdJKqkRrnQP4LdKU3iq4rdpBrh6o0lQ8ZnErR/M=
X-Received: by 2002:a05:6402:910:b0:5de:5946:8a01 with SMTP id
 4fb4d7f45d1cf-5de59468a13mr9701808a12.2.1739180651629; Mon, 10 Feb 2025
 01:44:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250210082805.465241-1-edumazet@google.com> <20250210082805.465241-4-edumazet@google.com>
 <Z6nHRDtxEG393A38@hog>
In-Reply-To: <Z6nHRDtxEG393A38@hog>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 10 Feb 2025 10:44:00 +0100
X-Gm-Features: AWEUYZlNzZj04qRXMUi2pdXYuCHdci5ruYAZKQd5R3aCpLxvNS9NqtVcXom4hWM
Message-ID: <CANn89iLCrohtJrfdRKvB3-XNtVjKDucNeTcxrmn4vAutgFyXAA@mail.gmail.com>
Subject: Re: [PATCH net-next 3/4] tcp: use EXPORT_IPV6_MOD[_GPL]()
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
	Willem de Bruijn <willemb@google.com>, Simon Horman <horms@kernel.org>, eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 10, 2025 at 10:30=E2=80=AFAM Sabrina Dubroca <sd@queasysnail.ne=
t> wrote:
>
> 2025-02-10, 08:28:04 +0000, Eric Dumazet wrote:
> > @@ -613,7 +613,7 @@ __poll_t tcp_poll(struct file *file, struct socket =
*sock, poll_table *wait)
> >
> >       return mask;
> >  }
> > -EXPORT_SYMBOL(tcp_poll);
> > +EXPORT_IPV6_MOD(tcp_poll);
>
> ktls uses it directly (net/tls/tls_main.c):


Oh, right.

>
> static __poll_t tls_sk_poll(struct file *file, struct socket *sock,
>                             struct poll_table_struct *wait)
> {
>         struct tls_sw_context_rx *ctx;
>         struct tls_context *tls_ctx;
>         struct sock *sk =3D sock->sk;
>         struct sk_psock *psock;
>         __poll_t mask =3D 0;
>         u8 shutdown;
>         int state;
>
>         mask =3D tcp_poll(file, sock, wait);
> [...]
> }
>
> If you want to un-export tcp_poll, I guess we'll need to add the same
> thing as for ->sk_data_ready (save the old ->poll to tls_context).

No need, I simply missed tls was using tcp_poll() can could be a
module, I will fix in V2

Thanks !

