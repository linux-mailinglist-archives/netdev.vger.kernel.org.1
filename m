Return-Path: <netdev+bounces-174312-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D7B9BA5E3D9
	for <lists+netdev@lfdr.de>; Wed, 12 Mar 2025 19:49:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 569D33B4BD1
	for <lists+netdev@lfdr.de>; Wed, 12 Mar 2025 18:49:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91DFD2580CC;
	Wed, 12 Mar 2025 18:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ibAZvABg"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ED601D9A5F
	for <netdev@vger.kernel.org>; Wed, 12 Mar 2025 18:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741805359; cv=none; b=igVV3lplajQkmMqf9IojNtO8/39euBWuYv2dpk/avmBCIhgKhlw58tMyAkwn8OvdceY8QNVPwpr9vwLoJIxauD1VoE42tx+rC8lSbZvhpGHI1zSXrP6Dq/O1xP6WdXUabwh2BDyNehOSmFI8Koa9M1om2pHQuGwm1D0O0dYMGxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741805359; c=relaxed/simple;
	bh=JEv0N9Ir1ejtdnozN6BUIcUt5wu1A+oaE1DQlOhNtIU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MGPu1u+ngPYJcgDURAPdnn3ZaYifR0ZjNOvDR3Els98vDUAXZqd9n7t3f/yMj6WVPYCrj3jy04z3Bpvql5ReBaC4Vc17GY6gpxJGnwrTrejBu3/tMDN2lDK6SvgSL32XSKFv1U00uUKvzGEEr+TFpxTa+idp951q2nVKntap5fU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=ibAZvABg; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-5498c742661so177917e87.1
        for <netdev@vger.kernel.org>; Wed, 12 Mar 2025 11:49:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1741805354; x=1742410154; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SU9eA8XTstbIi4MFjUo+WZEiwuYa9EXV8LicSal4nK8=;
        b=ibAZvABglz674+vkq+Bg9ZBNr4b8qEvDkuqMujqMOSw6ddF/W8wc3i7022OQjRycES
         L0vPwLqNMXJS8yun+PMmcZpS83t8y8Ky3PsGJRQ5W8h5WS7ee4amASq7jFse1XsXHNx9
         QPpnvVIh9v7FU2jko1ezTD5yHpdfcE56lQDdY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741805354; x=1742410154;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SU9eA8XTstbIi4MFjUo+WZEiwuYa9EXV8LicSal4nK8=;
        b=hlcjh90X2z/HdLxHO4lFVUyYU4TTsWA8J81VFWQQDBhdBMQZ4GODRhp5/j9B/l3nKr
         QBViAKyalza039V0PfWUh5hpIRAhTMIoVDxa4H8XKUDzqAvA1f0HF6FY63/LlIUHjPs+
         TgKz/jje86+TORD85EhWFQDfEMS+b9mfHAdsYkSnfPG/75m4mrRXwfMGASZMzdN241Ph
         J0h52hFyorZ099IfMC3jIWFq9rDrBDNDI3rkHweJ/50hm47xsud9MUbWw1zRDdEiD35L
         78kpE3kAC2uaymWZKOCSgtQmHGqXBGe7XG3rtss5juMYm7/mNwMJ1Ht7QuvSliESRZvG
         +h9w==
X-Forwarded-Encrypted: i=1; AJvYcCXbSmVFBkaWz8RheGpIiro0uVKypK3CzD8+mEdbVdPDsMzASABGoTihdCjfear43ddXSNLBZj8=@vger.kernel.org
X-Gm-Message-State: AOJu0YytypkqfVPNNjJgpvpM5r8VfONRpg4XwKDh02jxtrExs8sBzfEa
	tRV0FObNKWRXtKuK/MyOUe9S3BGYkCqyew5AeSvqV3asQfg0lra3sRMFbE6+eS1/yemnWzjMrjP
	7FqpEbM6OHWLOH3jXmjqug4AMo97BrWRt3jTq
X-Gm-Gg: ASbGnctunvkJVgOiKpkb9DSOzLz9P3iP3LQyyy3UGUcQw9t3dlB6A8wR4MNk2KYZ0rV
	eNbnTiGvwhDFyr4LIevEZJCMwWbBD3Yj/PaUvY2252jRXAwvOGtoQcpS1+b7hcKy4B9ezSqhur2
	rSOnY0dpow1dOghm1O/Jjo9ku3zA==
X-Google-Smtp-Source: AGHT+IGvH0dqMXrkY7n5hJujCz7OuO/8hmt2UWjsgfjuLHqwUgRRurdzSX7a9KyPFKlVA/3gJSbDfmbKT4cpl4wY+rY=
X-Received: by 2002:a05:6512:4020:b0:549:5769:6aee with SMTP id
 2adb3069b0e04-54990e2be9dmr8011040e87.7.1741805353612; Wed, 12 Mar 2025
 11:49:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250303200212.3294679-1-dualli@chromium.org> <20250303200212.3294679-3-dualli@chromium.org>
 <Z8-4SZv6plpyQUwf@google.com> <CANBPYPhR-C3VTv=ZHc1LJ0c7OG8-K2iGS62vXHmg9gcX0y89Cw@mail.gmail.com>
In-Reply-To: <CANBPYPhR-C3VTv=ZHc1LJ0c7OG8-K2iGS62vXHmg9gcX0y89Cw@mail.gmail.com>
From: Li Li <dualli@chromium.org>
Date: Wed, 12 Mar 2025 11:49:02 -0700
X-Gm-Features: AQ5f1JoYq5_VGpuvJ9bwTUUHGEFdrn9qYS1Sn08ly9dC1t7FWBEmJCr1XCpHboA
Message-ID: <CANBPYPg5i5PhqV0-1foaKwNOaoKNoit6-cLUAqNu=2S0AUp==w@mail.gmail.com>
Subject: Fwd: [PATCH v16 2/3] binder: report txn errors via generic netlink
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

Sorry for resending this email. My email client was wrongly set to HTML mod=
e.

On Mon, Mar 10, 2025 at 9:13=E2=80=AFPM Carlos Llamas <cmllamas@google.com>=
 wrote:
>
> On Mon, Mar 03, 2025 at 12:02:11PM -0800, Li Li wrote:
> > From: Li Li <dualli@google.com>
> >
> > +/**
> > + * binder_find_proc() - find the binder_proc by pid
> > + * @pid:     the target process
> > + *
> > + * Returns the struct binder_proc if the pid is found, or NULL otherwi=
se.
> > + */
> > +static struct binder_proc *binder_find_proc(int pid)
> > +{
> > +     struct binder_proc *proc;
> > +
> > +     mutex_lock(&binder_procs_lock);
> > +     hlist_for_each_entry(proc, &binder_procs, proc_node) {
> > +             if (proc->pid =3D=3D pid)
> > +                     break;
>
> Wait... can't there be multiple binder_proc instances matching the same
> pid? I know that binder_proc is a bit of a misnomer but what should you
> do in such case? Shouldn't you set the flags in _all_ matching pids?
>
> Furthermore, there could be a single task talking on multiple contexts,
> so you could be returning the 'proc' that doesn't match the context that
> you are looking for right?
>

You're right. I should update this logic to search the process within a
certain binder_context only.

> > +     }
> > +     mutex_unlock(&binder_procs_lock);
> > +
> > +     return proc;
> > +}
> > +
> > +/**
> > + * binder_netlink_enabled() - check if binder netlink reports are enab=
led
> > + * @proc:    the binder_proc to check
> > + * @mask:    the categories of binder netlink reports
> > + *
> > + * Returns true if certain binder netlink reports are enabled for this=
 binder
> > + * proc (when per-process overriding takes effect) or context.
> > + */
> > +static bool binder_netlink_enabled(struct binder_proc *proc, u32 mask)
> > +{
> > +     struct binder_context *context =3D proc->context;
> > +
> > +     if (!genl_has_listeners(&binder_nl_family, &init_net, BINDER_NLGR=
P_REPORT))
> > +             return false;
> > +
> > +     if (proc->report_flags & BINDER_FLAG_OVERRIDE)
> > +             return (proc->report_flags & mask) !=3D 0;
> > +     else
> > +             return (context->report_flags & mask) !=3D 0;
> > +}
> > +
> > +/**
> > + * binder_netlink_report() - report one binder netlink event
> > + * @context: the binder context
> > + * @err:     copy of binder_driver_return_protocol returned to the sen=
der
> > + * @pid:     sender process
> > + * @tid:     sender thread
> > + * @to_pid:  target process
> > + * @to_tid:  target thread
> > + * @reply:   whether the binder transaction is a reply
> > + * @tr:              the binder transaction data
> > + *
> > + * Packs the report data into a binder netlink message and send it.
> > + */
> > +static void binder_netlink_report(struct binder_context *context, u32 =
err,
> > +                               u32 pid, u32 tid, u32 to_pid, u32 to_ti=
d,
>
> Instead of all these parameters, is there a way to pass the transaction
> itself? Isn't this info already populated there? I think it even holds
> the info you are looking for from the 'binder_transaction_data' below.
>

The binder_transaction_data doesn't include all of pid, tid, to_pid and to_=
tid.

> > +                               u32 reply,
> > +                               struct binder_transaction_data *tr)
> > +{
> > +     struct sk_buff *skb;
> > +     void *hdr;
> > +     int ret;
> > +
> > +     trace_binder_netlink_report(context->name, err, pid, tid, to_pid,
> > +                                 to_tid, reply, tr);
> > +
> > +     skb =3D genlmsg_new(GENLMSG_DEFAULT_SIZE, GFP_KERNEL);
> > +     if (!skb) {
> > +             pr_err("Failed to alloc binder netlink message\n");
> > +             return;
> > +     }
> > +
> > +     hdr =3D genlmsg_put(skb, 0, atomic_inc_return(&context->report_se=
q),
> > +                       &binder_nl_family, 0, BINDER_CMD_REPORT);
> > +     if (!hdr)
> > +             goto free_skb;
> > +
> > +     if (nla_put_string(skb, BINDER_A_REPORT_CONTEXT, context->name) |=
|
> > +         nla_put_u32(skb, BINDER_A_REPORT_ERR, err) ||
> > +         nla_put_u32(skb, BINDER_A_REPORT_FROM_PID, pid) ||
> > +         nla_put_u32(skb, BINDER_A_REPORT_FROM_TID, tid) ||
> > +         nla_put_u32(skb, BINDER_A_REPORT_TO_PID, to_pid) ||
> > +         nla_put_u32(skb, BINDER_A_REPORT_TO_TID, to_tid) ||
> > +         nla_put_u32(skb, BINDER_A_REPORT_REPLY, reply) ||
> > +         nla_put_u32(skb, BINDER_A_REPORT_FLAGS, tr->flags) ||
> > +         nla_put_u32(skb, BINDER_A_REPORT_CODE, tr->code) ||
> > +         nla_put_u32(skb, BINDER_A_REPORT_DATA_SIZE, tr->data_size))
> > +             goto cancel_skb;
> > +
> > +     genlmsg_end(skb, hdr);
> > +
> > +     ret =3D genlmsg_multicast(&binder_nl_family, skb, 0, BINDER_NLGRP=
_REPORT, GFP_KERNEL);
>
> Thanks for switching to multicast. On this topic, we can only have a
> single global configuration at a time correct? e.g. context vs per-proc.
> So all listeners would ahve to work with the same setup?
>

We only have a single global configuration, which can include both
context and proc setup.
Yes, all listeners work with the same setup as we have only one
multicast group defined.
The user space code can demux it by checking the context field of the
netlink messages.

> > +     if (ret < 0)
> > +             pr_err("Failed to send binder netlink message: %d\n", ret=
);
>
> nit: can you please add an emtpy new line before the return?
>

Sure.

> > @@ -7013,6 +7231,11 @@ static int __init binder_init(void)
> >       if (ret)
> >               goto err_init_binder_device_failed;
> >
> > +     ret =3D genl_register_family(&binder_nl_family);
> > +     if (ret) {
>
> You don't undo init_binderfs() here? If that seems hard, then you can
> move up the genl registration instead, leaving init_binderfs() last.
> However, you would need to then undo the genl_register_family() call I
> suppose.
>

The current logic allows binder driver to continue working even if
genl_register_family
fails. But your suggestion makes sense. I'll move it up and undo it if
anything fails.

> > +TRACE_EVENT(binder_netlink_report,
> > +     TP_PROTO(const char *name, u32 err, u32 pid, u32 tid, u32 to_pid,
> > +              u32 to_tid, u32 reply, struct binder_transaction_data *t=
r),
>
> Similarly here I think you could get away with passing 'struct
> binder_transaction' instead of all the individual fields.
>

Same as above, the pid/tid fields are not in the struct
binder_transaction (or redacted for oneway txns).

