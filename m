Return-Path: <netdev+bounces-50557-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 18AFB7F6192
	for <lists+netdev@lfdr.de>; Thu, 23 Nov 2023 15:34:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B39BB282011
	for <lists+netdev@lfdr.de>; Thu, 23 Nov 2023 14:34:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3053224A1D;
	Thu, 23 Nov 2023 14:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Z39ieLvO"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4932BD44
	for <netdev@vger.kernel.org>; Thu, 23 Nov 2023 06:34:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1700750078;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jJ7Ki4jyK6CXGE03cStoDbMuXGPhHn+xPGZmYbAaox4=;
	b=Z39ieLvOQ02hX6ZFFBJMQBcL5DDekuQ6YSEOYfo/NgRp1uUhtkAKEBDztQaNkLCSHLOJDR
	stalq2USV7wgE780sM+beng42Pr/yjNR75PHLjGcAcruSJRMapkKQEE3/Vl3RiG7eOlrjJ
	VG0ZzZvaAFqG6zKiWz9wwFXw0Q/C6ek=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-102-WnENY02COgKTycoj2076AA-1; Thu, 23 Nov 2023 09:34:36 -0500
X-MC-Unique: WnENY02COgKTycoj2076AA-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-a0009a87651so59664466b.1
        for <netdev@vger.kernel.org>; Thu, 23 Nov 2023 06:34:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700750075; x=1701354875;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jJ7Ki4jyK6CXGE03cStoDbMuXGPhHn+xPGZmYbAaox4=;
        b=s+JRHLxqN1C+YQwK3iPUy6WXKbuflNCJtWD63z9yR8XJVH5SW8QSmi5GtQC0RknKZa
         mleACnZUO03Y9/Ys7BFbxpJ2657hYeZAjIBX4SUDK3yaYxOqL4acbolWm3SUvQmqOFkq
         GMG3zzQDU12qwC9vZQNuXAwjsACU2IRscO+BMqjGSYFqHC/3BWb7PVHrSaFK6JjVCxX0
         5bfpakIjl5mMMmawhsyJUlDEp7oDYGh4GW0LCr/EYfCLrycAWd6DTZspMBz81eLN3SnM
         LnV9fcqCK/4emjWGIlC8YZK0HSB1s9U4qrRJ3BifF67ooOOIpCULTCsce+qP/g5go7B7
         sgtQ==
X-Gm-Message-State: AOJu0Ywi3/egfXhjmKLgd+iCYgZ+HW25gxPF1UGkmtcnALsHDolfFp0b
	V+7k1EgKmp5d28jw/uwBzveCpJQHRhnvjQCBLOhY9XtpSfRv4y1OQ20igc8gWg7/AiHlxvJ9fw3
	P2o1hHFJn2PjFfH+nzL456klm71hoFkIJ
X-Received: by 2002:a17:906:10d9:b0:9fd:8d07:a3ad with SMTP id v25-20020a17090610d900b009fd8d07a3admr4074575ejv.17.1700750075151;
        Thu, 23 Nov 2023 06:34:35 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHJGIgYt3XV572SfRjarH9RjhlJNwD5AtR5SICWYkEEOs2fQ/XmS1ZzGbCjAF0HNd+6pHOl5+0CkBtgRGOD50s=
X-Received: by 2002:a17:906:10d9:b0:9fd:8d07:a3ad with SMTP id
 v25-20020a17090610d900b009fd8d07a3admr4074560ejv.17.1700750074891; Thu, 23
 Nov 2023 06:34:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231115210509.481514-1-vschneid@redhat.com> <20231115210509.481514-2-vschneid@redhat.com>
 <CANn89iJPxrXi35=_OJqLsJjeNU9b8EFb_rk+EEMVCMiAOd2=5A@mail.gmail.com>
In-Reply-To: <CANn89iJPxrXi35=_OJqLsJjeNU9b8EFb_rk+EEMVCMiAOd2=5A@mail.gmail.com>
From: Valentin Schneider <vschneid@redhat.com>
Date: Thu, 23 Nov 2023 15:34:23 +0100
Message-ID: <CAD235PRWd+zF1xpuXWabdgMU01XNpvtvGorBJbLn9ny2G_TSuw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] tcp/dcpp: Un-pin tw_timer
To: Eric Dumazet <edumazet@google.com>
Cc: dccp@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-rt-users@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, David Ahern <dsahern@kernel.org>, 
	Juri Lelli <juri.lelli@redhat.com>, Tomas Glozar <tglozar@redhat.com>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Eric,

On Mon, 20 Nov 2023 at 18:56, Eric Dumazet <edumazet@google.com> wrote:
>
> On Wed, Nov 15, 2023 at 10:05=E2=80=AFPM Valentin Schneider <vschneid@red=
hat.com> wrote:
> >
> > @@ -53,16 +53,14 @@ void dccp_time_wait(struct sock *sk, int state, int=
 timeo)
> >                 if (state =3D=3D DCCP_TIME_WAIT)
> >                         timeo =3D DCCP_TIMEWAIT_LEN;
> >
> > -               /* tw_timer is pinned, so we need to make sure BH are d=
isabled
> > -                * in following section, otherwise timer handler could =
run before
> > -                * we complete the initialization.
> > -                */
> > -               local_bh_disable();
> > -               inet_twsk_schedule(tw, timeo);
> > -               /* Linkage updates.
> > -                * Note that access to tw after this point is illegal.
> > -                */
> > +              local_bh_disable();
> > +
> > +               // Linkage updates
> >                 inet_twsk_hashdance(tw, sk, &dccp_hashinfo);
> > +               inet_twsk_schedule(tw, timeo);
>
> We could arm a timer there, while another thread/cpu found the TW in
> the ehash table.
>
>
>
> > +               // Access to tw after this point is illegal.
> > +               inet_twsk_put(tw);
>
> This would eventually call inet_twsk_free() while the timer is armed.
>
> I think more work is needed.
>
> Perhaps make sure that a live timer owns a reference on tw->tw_refcnt
> (This is not the case atm)
>

I thought that was already the case, per inet_twsk_hashdance():

/* tw_refcnt is set to 3 because we have :
 * - one reference for bhash chain.
 * - one reference for ehash chain.
 * - one reference for timer.

and

tw_timer_handler()
`\
  inet_twsk_kill()
  `\
    inet_twsk_put()

So AFAICT, after we go through the hashdance, there's a reference on
tw_refcnt held by the tw_timer.
inet_twsk_deschedule_put() can race with arming the timer, but it only
calls inet_twsk_kill() if the timer
was already armed & has been deleted, so there's no risk of calling it
twice... If I got it right :-)


