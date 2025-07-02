Return-Path: <netdev+bounces-203186-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05E45AF0B43
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 08:08:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD4483AC42E
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 06:07:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E583B1DED42;
	Wed,  2 Jul 2025 06:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tKDS5BYq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 465F1D299
	for <netdev@vger.kernel.org>; Wed,  2 Jul 2025 06:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751436486; cv=none; b=gmJiahM8Ea0uoYjmVYMnENZjxJTUQeiLf8zWSDQb2sf4cjSQEei/FbRtxX6iy3fCKuC4HZ+9R1Mrm9W1J4hrXBQLYnYxLzDtsMxjpEh3PIXTfDpe5n1mB19LxD0FENCJcJcK0rnUjCTtMlkxj4MMvfs3SyAUNVqpGdj/AEEauq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751436486; c=relaxed/simple;
	bh=uZsqjA9P/yqx+10vYlDlaOrQEq+Q69IOw2a8eeTEavU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SJG2t9VHQmPRGLW0O+y0NXWWgtKt6M6B2AZ8XkKytB5j2C76nQ6ZcwsZ+uKhscgRzeDfbXIusCUQ36jSKKFcrCNgQyhZnhvVf+4MvonGfmNYRFNf4GeQY4hdjy+h/zaOgObPM9HcEs33zyOzmesfJRtdXLUVgfB0/WpIjg7ILOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tKDS5BYq; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-4a823b532a4so24855111cf.2
        for <netdev@vger.kernel.org>; Tue, 01 Jul 2025 23:08:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1751436484; x=1752041284; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EYCulDaUuA5TsJ5+ChannohiN70xWTTIU1+S4IGZwJY=;
        b=tKDS5BYqk6RDEx0RaYM8aQ/efO5ErF0z2KPdl8hipANpdDMtyA0V0i84Q+qMJRzspX
         Xmp9eRBrg0AuIMj72xXrLMAqm7KScjZ41D5jahHSw82H9DZMJ6CqtaTgtVVMPcd1j3Cl
         tKBIdzxnpy3HGH8swcl/bGkXSvMTccQMXQ/Gnh5TJ6UTaZ924EqqYKYf32D9HA/eQPDl
         LkHjkca/NF/N/NWPstji6Zu7EF1lOsE4GaplQILsl1S8+yL5m0yqlkYtgg5OsgxL3tQ+
         +Ow4Va0nZligZoVeEq016TpXfauGiQ74C85pX47mlN2vCvJ/S+LtpNmQRvMVxO/AI7c7
         ag6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751436484; x=1752041284;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EYCulDaUuA5TsJ5+ChannohiN70xWTTIU1+S4IGZwJY=;
        b=ieiOrHtPQUhoCOTtZHipJ8k9BPelNi2kFceXd9vKPHH6rnQhiO0fTNOOXLRKiBpHGd
         /7MffmC7N9UUQz3hWN2Kv+CPV8aLXcFje+5LyhtF098lcviI1WU0mbHeO/qQ5E7a7FWb
         FAL7mJPQXa5W0jOPHqshem05ltLQuxPrG7Hj0bf2gBBl1hVNDYznyICTSJ2ZBBau//A6
         lKgp0MHEQGbYIxq9TE407uYoTR+/nVYf6DEgVZv/qR6kpgE1cALHbyriKydv4kytHkqd
         ibo1iGavBLoGuLYRV7txCkSzqkRhif67Ti/gM9QBqJdbZ0EqJCKy49dWBYuJHXfmdwb4
         p6ag==
X-Forwarded-Encrypted: i=1; AJvYcCVIRnaFmYByciZFk17q3dAH8CALCZVTgXj7R6QSLF51cHECjsfC9B9wSNuYz6GjO/2VRYZ82Eo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5bS0BLzK6F1pdthImXc/TLMHq+vof9iomPnQ8/x1y80EVVZoo
	hNdmVGhWi+5UzwPehxVaSJk5n3TNR4/wHpULfzYYQjjp04Ig6b9FLrmSTwF5J+evKJC5rPYxeaP
	98QueuLrdpXhT+s/seRuXZ5AkW06vnwESi8jQWJhL
X-Gm-Gg: ASbGncsn4VMpiOKbZD2w0DH9RFQHFxqkKeW3f3n3cZzCDN1zgA4zDAQdkmsyEvFvPNR
	DFXJuDlc2CCSoiFTM3pyW8Tu6JBJXwIQqezE7njAoptj8bJyjSJ2u9v7iMlf+i+GQ84JFwl5mdr
	cgCmISOK5x9boTCpJ4EJDlI31FbhR8di9wlBfN9DPux8qh3wHj2Ab8mg==
X-Google-Smtp-Source: AGHT+IFjFM3tRBaX3GEuGNjmM8SbAdapdekOct9BHqcz+xTOYihYgyVVb4PI6biXiiCzCmUuNCEMd3b/Bq0ENsyRPEo=
X-Received: by 2002:a05:622a:50:b0:476:a713:f783 with SMTP id
 d75a77b69052e-4a9769cafb5mr30303001cf.47.1751436483764; Tue, 01 Jul 2025
 23:08:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250627130839.4082270-1-edumazet@google.com> <20250701174612.55d55715@kernel.org>
In-Reply-To: <20250701174612.55d55715@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 1 Jul 2025 23:07:52 -0700
X-Gm-Features: Ac12FXw3u9wOvq9LTHnB3l9Z_jxi4Dw3rhFDGh8iWjSU4QmgMVhE9SYAQWRQz0k
Message-ID: <CANn89i+5jz7sB5UShxB+PDMaMCWpy2rA1LRocAWi5rAXV95HWA@mail.gmail.com>
Subject: Re: [PATCH net-next] net: remove RTNL use for /proc/sys/net/core/rps_default_mask
To: Jakub Kicinski <kuba@kernel.org>
Cc: "David S . Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 1, 2025 at 5:46=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wro=
te:
>
> On Fri, 27 Jun 2025 13:08:39 +0000 Eric Dumazet wrote:
> > diff --git a/net/core/net-sysfs.h b/net/core/net-sysfs.h
> > index 8a5b04c2699aaee13ccc3a5b1543eecd0fc10d29..ff3440d721963b2f90b6a83=
666a63b3f95e61421 100644
> > --- a/net/core/net-sysfs.h
> > +++ b/net/core/net-sysfs.h
> > @@ -11,4 +11,8 @@ int netdev_queue_update_kobjects(struct net_device *n=
et,
> >  int netdev_change_owner(struct net_device *, const struct net *net_old=
,
> >                       const struct net *net_new);
> >
> > +#if IS_ENABLED(CONFIG_SYSCTL) && IS_ENABLED(CONFIG_RPS)
> > +extern struct mutex rps_default_mask_mutex;
> > +#endif
>
> Perhaps subjective but hiding definitions under ifdefs often forces
> the ifdef to spread, IOW it prevents us from using:
>
>         if (IS_ENABLED(CONFIG_..))
>
> and relying on compiler to remove the dead code. So I'd skip the ifdef.

Yes, I will remove it in V2.

>
> >  #endif
> > diff --git a/net/core/sysctl_net_core.c b/net/core/sysctl_net_core.c
> > index 5dbb2c6f371defbf79d4581f9b6c1c3fb13fa9d9..672520e43fefadf4c8c667f=
f6c77acf3935bc567 100644
> > --- a/net/core/sysctl_net_core.c
> > +++ b/net/core/sysctl_net_core.c
> > @@ -96,50 +96,40 @@ static int dump_cpumask(void *buffer, size_t *lenp,=
 loff_t *ppos,
> >
> >  #ifdef CONFIG_RPS
> >
> > -static struct cpumask *rps_default_mask_cow_alloc(struct net *net)
> > -{
> > -     struct cpumask *rps_default_mask;
> > -
> > -     if (net->core.rps_default_mask)
> > -             return net->core.rps_default_mask;
> > -
> > -     rps_default_mask =3D kzalloc(cpumask_size(), GFP_KERNEL);
> > -     if (!rps_default_mask)
> > -             return NULL;
> > -
> > -     /* pairs with READ_ONCE in rx_queue_default_mask() */
> > -     WRITE_ONCE(net->core.rps_default_mask, rps_default_mask);
> > -     return rps_default_mask;
> > -}
> > +DEFINE_MUTEX(rps_default_mask_mutex);
>
> nit: sparse says ../sysfs.h is not included here so it doesn't see the
> declaration for the header:
>
> net/core/sysctl_net_core.c:99:1: warning: symbol 'rps_default_mask_mutex'=
 was not declared. Should it be static?

Thanks, I will fix this in V2.

