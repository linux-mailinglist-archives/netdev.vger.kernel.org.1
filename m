Return-Path: <netdev+bounces-174374-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 89B8AA5E5F4
	for <lists+netdev@lfdr.de>; Wed, 12 Mar 2025 22:03:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 88BEC17DA82
	for <lists+netdev@lfdr.de>; Wed, 12 Mar 2025 21:02:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C0D41EF084;
	Wed, 12 Mar 2025 20:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Qi0dasUx"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30B771EF097
	for <netdev@vger.kernel.org>; Wed, 12 Mar 2025 20:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741813008; cv=none; b=F0zyaf7hWVoPTekCv7cXZsXCT7ly+m9jV1NoBS4scRd0p1AGxxCVXclx601Lo5I+D/j5TilNRGEWMMHrivWJbLkLSxS5XPEXJe6JR1nDQpEtyfmJMzSc7DmR/K/6d3pvn3gwRL4B4O8uLLcIcwj5+884nESzl5mElCxI0NDuKe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741813008; c=relaxed/simple;
	bh=/cLVu/i1J/npZ/UFxDKmVGIv97YHvczKzdlFovdn4U4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pPoYVhfyQ8uRPPQo2L7Judb0XsRUATidHQ/zdLxRZMkBkuZ9NG55UGqwdjp+8BWmDiZBaZ0ge1Axw99ZKXecABxG5OlW5zjJVsQOqaahP2N8XRhFuHLvFRY4gGsPBc65fJbu8GkXeTz8aaWLkigEX4u77BG1qb28tueb1lCEZzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Qi0dasUx; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5499c5d9691so261189e87.2
        for <netdev@vger.kernel.org>; Wed, 12 Mar 2025 13:56:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1741813004; x=1742417804; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GrvETxTzEPANOEDl+dE9UqwlinAPB0E0IpXcGB+inLY=;
        b=Qi0dasUxq1x9VsCH8pwLMM9wIPDwJKeOo2GKvPZTGkDa6G+3SsYGbbKKZWpnPFB+LP
         Du2vp/qFMIwHKhI1NlHL90rBsymREqXVIJ4E98TAU/BnPR2/6qaZa3LIgYFsoZNeogy0
         OzsmjACLuopczDpmH++aHe1uQUfOiiXZOW15M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741813004; x=1742417804;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GrvETxTzEPANOEDl+dE9UqwlinAPB0E0IpXcGB+inLY=;
        b=Vgjuo70kqxj0qMaVrD6C1PB2kkNURTcnlpQjKUf5FJzRrA67z5d7FF1cpqze0lizVO
         PkcGip9lwRQtAVxSBf2pG2nTp7T3uCTD+ktbyeLk5NNylUTmh9Hb3t0wWuYBRH79txc/
         MQM2YP2y34nFONY0zR3NXa0cOTtejJ/KAtikWqmi/qCNhPcn6fb1VZvj8dKKGgTsedxP
         Z51Yq9S2GkD3V+Yrecfa1Wwd59aXNwMV2SXpvQzeIC0PrS5OpB6YxZHnInLxAILoBUa/
         Luv2eUK7UeVnVto5b/S2+ooFIBisRIZ1jn2FQSfuxpSJ8K58NAorcFKzvBJWYkPCsx4X
         YGaA==
X-Forwarded-Encrypted: i=1; AJvYcCXaR543Jd9PoQ3l1zKKoBKCTVA2oTZ82RW0ZLELa+xDlSnyyE91FCnEL/mu9w2biVrWy+uGSag=@vger.kernel.org
X-Gm-Message-State: AOJu0YwW2LEDxQPgAdDOE4Xch+zm1Saa2KCf7iCwztiUMbl9Iq3IJ/Lf
	CqsC9U9MHxUgZlaKHOMhAuBLS7KiExrlwUQnAmTQdZkSCoz/Ue/8/4ppkVXUZXa6c+lbMpgjDLp
	akY1xX1GUWG0KZTQFcJcVpaxo/YaN2fn83rQ/
X-Gm-Gg: ASbGnctgoA75lkR2fLaTnF0gRuufZzUfjQivhdm7XhaNJhvNDotEy2Y+XNAtqAICOML
	mzIQ5vjbeTgGKxM86x+tD8ZX5BUKUA3qJX13zh/JSWhtwh80FtzqZJ6z/QPREYXFyLWJc/zDGRG
	fly04OUIxoZRpjO6cEsf6JvVJjNQ==
X-Google-Smtp-Source: AGHT+IHUkHHcbtyRAkWY2R1TLCWecAoP+9J2rTrtsm1A8/LiKJUZvmvewYlVLMFBlhjz6pjBCx/KuuT00faBLcXTdlw=
X-Received: by 2002:a05:6512:3d27:b0:545:df9:5bb5 with SMTP id
 2adb3069b0e04-54990ec8bd9mr9152703e87.45.1741813004171; Wed, 12 Mar 2025
 13:56:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250303200212.3294679-1-dualli@chromium.org> <20250303200212.3294679-3-dualli@chromium.org>
 <Z8-4SZv6plpyQUwf@google.com> <CANBPYPhR-C3VTv=ZHc1LJ0c7OG8-K2iGS62vXHmg9gcX0y89Cw@mail.gmail.com>
 <CANBPYPg5i5PhqV0-1foaKwNOaoKNoit6-cLUAqNu=2S0AUp==w@mail.gmail.com> <Z9HrEdbI5JYu0pwS@google.com>
In-Reply-To: <Z9HrEdbI5JYu0pwS@google.com>
From: Li Li <dualli@chromium.org>
Date: Wed, 12 Mar 2025 13:56:32 -0700
X-Gm-Features: AQ5f1JqD9a5qsP1mO79Ph7ePMU0QhGNiwP1z2NP0wllQAR2ToDs_LwX9Kwcahfc
Message-ID: <CANBPYPi8sT0m4bj9JhVn38rrRBg7nV9kduc34QC_edwHS-wNZg@mail.gmail.com>
Subject: Re: Fwd: [PATCH v16 2/3] binder: report txn errors via generic netlink
To: Carlos Llamas <cmllamas@google.com>
Cc: "Cc:" <dualli@google.com>, corbet@lwn.net, davem@davemloft.net, 
	edumazet@google.com, Jakub Kicinski <kuba@kernel.org>, pabeni@redhat.com, 
	donald.hunter@gmail.com, Greg KH <gregkh@linuxfoundation.org>, 
	=?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>, tkjos@android.com, 
	maco@android.com, "Joel Fernandes (Google)" <joel@joelfernandes.org>, brauner@kernel.org, 
	Suren Baghdasaryan <surenb@google.com>, omosnace@redhat.com, shuah@kernel.org, arnd@arndb.de, 
	masahiroy@kernel.org, Bagas Sanjaya <bagasdotme@gmail.com>, 
	Simon Horman <horms@kernel.org>, tweek@google.com, LKML <linux-kernel@vger.kernel.org>, 
	linux-doc@vger.kernel.org, netdev@vger.kernel.org, selinux@vger.kernel.org, 
	Hridya Valsaraju <hridya@google.com>, smoreland@google.com, ynaffit@google.com, 
	Android Kernel Team <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 12, 2025 at 1:14=E2=80=AFPM Carlos Llamas <cmllamas@google.com>=
 wrote:
>
> On Wed, Mar 12, 2025 at 11:49:02AM -0700, Li Li wrote:
> > > > +     mutex_lock(&binder_procs_lock);
> > > > +     hlist_for_each_entry(proc, &binder_procs, proc_node) {
> > > > +             if (proc->pid =3D=3D pid)
> > > > +                     break;
> > >
> > > Wait... can't there be multiple binder_proc instances matching the sa=
me
> > > pid? I know that binder_proc is a bit of a misnomer but what should y=
ou
> > > do in such case? Shouldn't you set the flags in _all_ matching pids?
> > >
> > > Furthermore, there could be a single task talking on multiple context=
s,
> > > so you could be returning the 'proc' that doesn't match the context t=
hat
> > > you are looking for right?
> > >
> >
> > You're right. I should update this logic to search the process within a
> > certain binder_context only.
>
> Also, note the comment about multiple 'struct binder_proc' matching the
> same desired pid.
>

Yes, multiple matching can be found when the context is not specified.
I'll take care of that as well.

> > > > +static void binder_netlink_report(struct binder_context *context, =
u32 err,
> > > > +                               u32 pid, u32 tid, u32 to_pid, u32 t=
o_tid,
> > >
> > > Instead of all these parameters, is there a way to pass the transacti=
on
> > > itself? Isn't this info already populated there? I think it even hold=
s
> > > the info you are looking for from the 'binder_transaction_data' below=
.
> > >
> >
> > The binder_transaction_data doesn't include all of pid, tid, to_pid and=
 to_tid.
>
> I'm not referring to binder_transaction_data, I mean 'struct
> binder_transaction'. I _think_ this should have all you need?
>

Ah, yes, let me take a closer look and optimize this. Thanks!

> > > > +     ret =3D genlmsg_multicast(&binder_nl_family, skb, 0, BINDER_N=
LGRP_REPORT, GFP_KERNEL);
> > >
> > > Thanks for switching to multicast. On this topic, we can only have a
> > > single global configuration at a time correct? e.g. context vs per-pr=
oc.
> > > So all listeners would ahve to work with the same setup?
> > >
> >
> > We only have a single global configuration, which can include both
> > context and proc setup.
> > Yes, all listeners work with the same setup as we have only one
> > multicast group defined.
> > The user space code can demux it by checking the context field of the
> > netlink messages.
>
> Ack. I understand the demux solution. I was wondering if we'll need to
> OR the different configurations (per-proc and flags) from each listener
> in that case.
>

They are already OR'ed from all listeners.

> > > > +TRACE_EVENT(binder_netlink_report,
> > > > +     TP_PROTO(const char *name, u32 err, u32 pid, u32 tid, u32 to_=
pid,
> > > > +              u32 to_tid, u32 reply, struct binder_transaction_dat=
a *tr),
> > >
> > > Similarly here I think you could get away with passing 'struct
> > > binder_transaction' instead of all the individual fields.
> > >
> >
> > Same as above, the pid/tid fields are not in the struct
> > binder_transaction (or redacted for oneway txns).
>
> There is something off here. You have t->from_{pid|tid} and also
> t->to_{proc|thead} that you can use. Isn't this what you are looking
> for?
>
> --
> Carlos Llamas

