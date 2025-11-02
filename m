Return-Path: <netdev+bounces-234903-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 46DC1C29156
	for <lists+netdev@lfdr.de>; Sun, 02 Nov 2025 16:51:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 05E703AFB31
	for <lists+netdev@lfdr.de>; Sun,  2 Nov 2025 15:51:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0BAF2309B2;
	Sun,  2 Nov 2025 15:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VQf9zryt"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 425FA1C831A
	for <netdev@vger.kernel.org>; Sun,  2 Nov 2025 15:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762098678; cv=none; b=b2XDvpe1mpo5pNgvpjyTFn4ouPq1dt6SwzTZQTsF9WAH2YVDcqG0visd1lvpQNfFS7HRPg85w3US4KjnmVCBm3uC6svYT4dPBnbjC7DUtxgsqxQtcgaI7sz3IGTuxlAChGorSFuf43oS/g1cJVp1tVUbsyGnlryHg8tZpux9wu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762098678; c=relaxed/simple;
	bh=IVGRhEx6SwwcuiB/43BUyx3KBlWNJ/Z9V62kRKtkTWU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HaYFzIO4Rrm8M9lrNoqd3sTqEWg2rsPgJn+3rMmGUl98BYFotVO/OcSRgarIAJJIEvU+IoBU3DRDMcHXmwaw5Va1YCLR0cpIMTckE9llGTB0/sWPzIANKAFA+GC8Wutq/8dWq4AiM9AwmV5ryZb0dWMULH1dIrErwfXIkVIfs7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VQf9zryt; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-34029c5beabso3328967a91.1
        for <netdev@vger.kernel.org>; Sun, 02 Nov 2025 07:51:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762098675; x=1762703475; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M8zabFFXO/kK05h5IRuopTuEr8QgfbyLWlJrEPONgeY=;
        b=VQf9zrytheMhxs5YMPKkJdiLX1HAcVEvvMLEaqi1y4ix0raiW5BBki5mdeHWMTBaG2
         5kKdbiEKBw6fUP8n0euuwvs2ukubvZO4ZHYrc4TSTqOid6X5TQVfCSTMLaU8l42fDuRS
         h1w59tpgsMJBSwff1LbdKkI+USEoYRP7WXnKuumYDvyewtrhbFJRNaw8GhI33si5dqzt
         HZ67jLhNwEXkGZxrW0KZ11fe1T6QB6hNk34r3Mg1lOb+fg8EqatHxcqu1jyq3nG+raQB
         J+OPQbkCewc3jylay35DVrfIkP10k9JJvxRXmczhR6DnnVPdHUblSSIYeVH8YnRgSCcv
         7+dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762098675; x=1762703475;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M8zabFFXO/kK05h5IRuopTuEr8QgfbyLWlJrEPONgeY=;
        b=asRQIYHIw8EB4Pt3WP7YRQFYGbQGIsXxFa9JYG/kpfGUkuRzpzRCzDlKHqJkXzYTax
         q2VLhdCmzyJBHylSquomU7EK8PdzRvgmMeIPHEyhuRR8KQp+37OADhJ27MfsNaZJnYsw
         EEsJXgatcoCqi4ls9HaqZX6U8fc6mTPE+ljrJVkmwTK8MgFoAUMz1R3jWeRz0gMBSw9g
         EL6R3ICKWKnFiVk9dLEgFU1yXEJiSqnI+PxDPEoSQtUHgX3AKtCyuiDRDWUJmQO5bj4N
         MRbQxLRqNqg3kq/ZMRReLJ3TVHNdOWi5ITMFxnqw+2Gu6LsFU8tNyjdTqTCK4aDqeqf5
         yG1g==
X-Forwarded-Encrypted: i=1; AJvYcCVgll91otGeaB9TuWRdeI2hr9baY/KxTK3oSVlLbnWBlSnB5JcVELlSoRTokW+xCBdZ0FR4j1Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YzlN2TtRbiWfFivikzL0AIvEmtXZSlfZZAnmjBkYQboe1Cmh+za
	DnfwWpKCQ3mAM5xWQc8tV/w0YA5m/gQHLAVbY9pDYMxuz3tW6MRIT3nWtQzs8Q1CWnpRe1PHbF8
	JJYqiGdXbWvBUyZWPylxNXn9QTCiZthQ=
X-Gm-Gg: ASbGncsomd1JGRFC+37IiGw9YTXPJXhbIHbxyojDvczOXqXMMfmOnzG5LgyZoB25FCL
	Ca2tx6W+1ZGEzMRvt4Cv74eV+EedR+Mxc+D7pVLGWOuSETQj8LQGk/AkJ/GlsgWPuQEbO1NMF2n
	iIRKnMGDOZyStE3BQBpNJ7o7sr/XpZbs8EQ+0XbZ4B1Rm98xCl8tsRR9srFsLwuL5SIiA23SD52
	af5aNReT6bjsMrOBOyRNrTMzneZQbub9nFeO3f1CfOzyl/TsVKndprhI4xkhg9DXZCqnkYuLg==
X-Google-Smtp-Source: AGHT+IFTwYjObHjVACXx+yKhmx3nHerpwqmx/UegK6/vDIN0wNRsze92crbnrrslfRfu6uaTLgeVSRptXrdqwClZN5M=
X-Received: by 2002:a17:90b:2e07:b0:341:194:5e71 with SMTP id
 98e67ed59e1d1-34101945f39mr2615733a91.29.1762098675493; Sun, 02 Nov 2025
 07:51:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251101163656.585550-1-hehuiwen@kylinos.cn>
In-Reply-To: <20251101163656.585550-1-hehuiwen@kylinos.cn>
From: Xin Long <lucien.xin@gmail.com>
Date: Sun, 2 Nov 2025 10:51:04 -0500
X-Gm-Features: AWmQ_bmS4T2uL37JePpWdJiTenPBPVlMVaI2XJrFASO8Jy7GhhDEL4pW3BmfvMc
Message-ID: <CADvbK_cUA1TR2+=-k8iUu=y6rxEj7Qn+EcvRzKy7xkAhGrE6Ww@mail.gmail.com>
Subject: Re: [PATCH] sctp: make sctp_transport_init() void
To: Huiwen He <hehuiwen@kylinos.cn>
Cc: marcelo.leitner@gmail.com, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	linux-sctp@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 1, 2025 at 12:37=E2=80=AFPM Huiwen He <hehuiwen@kylinos.cn> wro=
te:
>
> sctp_transport_init() is static and never returns NULL. It is only
> called by sctp_transport_new(), so change it to void and remove the
> redundant return value check.
>
> Signed-off-by: Huiwen He <hehuiwen@kylinos.cn>
> ---
>  net/sctp/transport.c | 16 +++++-----------
>  1 file changed, 5 insertions(+), 11 deletions(-)
>
> diff --git a/net/sctp/transport.c b/net/sctp/transport.c
> index 4d258a6e8033..97da92390aa7 100644
> --- a/net/sctp/transport.c
> +++ b/net/sctp/transport.c
> @@ -37,10 +37,10 @@
>  /* 1st Level Abstractions.  */
>
>  /* Initialize a new transport from provided memory.  */
> -static struct sctp_transport *sctp_transport_init(struct net *net,
> -                                                 struct sctp_transport *=
peer,
> -                                                 const union sctp_addr *=
addr,
> -                                                 gfp_t gfp)
> +static void sctp_transport_init(struct net *net,
> +                               struct sctp_transport *peer,
> +                               const union sctp_addr *addr,
> +                               gfp_t gfp)
>  {
>         /* Copy in the address.  */
>         peer->af_specific =3D sctp_get_af_specific(addr->sa.sa_family);
> @@ -83,8 +83,6 @@ static struct sctp_transport *sctp_transport_init(struc=
t net *net,
>         get_random_bytes(&peer->hb_nonce, sizeof(peer->hb_nonce));
>
>         refcount_set(&peer->refcnt, 1);
> -
> -       return peer;
>  }
>
>  /* Allocate and initialize a new transport.  */
> @@ -98,16 +96,12 @@ struct sctp_transport *sctp_transport_new(struct net =
*net,
>         if (!transport)
>                 goto fail;
I think you can return NULL; here, and delete the 'fail:' path below now.

Thanks.
>
> -       if (!sctp_transport_init(net, transport, addr, gfp))
> -               goto fail_init;
> +       sctp_transport_init(net, transport, addr, gfp);
>
>         SCTP_DBG_OBJCNT_INC(transport);
>
>         return transport;
>
> -fail_init:
> -       kfree(transport);
> -
>  fail:
>         return NULL;
>  }
> --
> 2.25.1
>

