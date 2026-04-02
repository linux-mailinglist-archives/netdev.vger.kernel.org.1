Return-Path: <netdev+bounces-274621-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UDrvF3aWzmkBowYAu9opvQ
	(envelope-from <netdev+bounces-274621-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 18:16:54 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E21038BB9B
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 18:16:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A1C8630095CC
	for <lists+netdev@lfdr.de>; Thu,  2 Apr 2026 16:16:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A42923EF678;
	Thu,  2 Apr 2026 16:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KXP5YL5r"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38A9335F605
	for <netdev@vger.kernel.org>; Thu,  2 Apr 2026 16:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775146571; cv=pass; b=RNarmCrCEVZ50/Jb68RTcWzkeD16aEzpyK7VqdYetEvHxKKDHdDwVQVzIJPg94aAovYhe0CUfYzZGAB1d5rpSrvIH4k7CY+cCfFE6DJgoqTAwxPMtNXUUgO0gC6RxYAaAYoZJsr+Js8XgLsn7m1z9/ROu+1B4EV05WUIwpyIgnE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775146571; c=relaxed/simple;
	bh=D60EDa61LqhPW5o5D86PD0M639K04WgxXc9SFQwKl8w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pB+t1KMCanyqOBy9UchTYgwqt9jl9+omjAFnQUVkkfqYlkRzfUh+Sha9sTQBzSu9TLeXnYH7s3Lma64pGZ8Ck4Q6jKnbjoohdF1GkPvlovnwZFo7mN4oVJI2g5HCzqykRpruQYXppf3FZRgg1PsBK0CRqASo+yvlaf+IHvl3oG4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KXP5YL5r; arc=pass smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-66baa7fdfd3so11437a12.1
        for <netdev@vger.kernel.org>; Thu, 02 Apr 2026 09:16:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775146566; cv=none;
        d=google.com; s=arc-20240605;
        b=Q2lf0Yykawjx38RU5+1aJ9Y2yIX/IYrslsmStHE4M4GtkfKr40eMFZL3EM88LYKxGZ
         JIoYeG49113CTtfe4yqBsvk6w/LeA8qEwiJbfp+h9Hw3pJrSteEwKrYb3RHCQqOaeur8
         ZjZ2W/5jtG/fsi1svFtXRn+/DUW6v41a9mvbVRaZZygG/ZSmPH8YAGm8s4JHwbVs8e2H
         EZLxIY50WqwSlYhT8bBjhztI1SUWAg3QEVZ4KARqaRs0ci6mSZWZCvo0zHF2NE34XToK
         vm/uk1Q3wJVvmsEYnMoWy9cMeRHZn4yn0ZUDfVeJP43ZYerwGb0VXaE8k5TNx4q6rBv7
         FsYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=XpWeMAPNa4kjUUqgfe+POmovFhY+dw9PcsRJmCuy9so=;
        fh=rx+UcZcJJ2eigJ799Q5WvnSSt3+JOx/FCek26EkrdI4=;
        b=Nu/wYoG05XSLht2eOC57SfQyKPZvOvg8fqlgmtfgCiF9XzTtdcjY4mG0aC1gmfiW18
         k58UKjPDKwn4dA8N8kTjKmC4NQF90qUSXxR/cHo1ne85b2flf2/HOroDVFxsHIms7VKV
         5+FgLvY8UJgVM8jLFTt175cl9OcQqfleZmhkHRNyWhGOO/VGttiS6GU9caVQb1LBP0x+
         Zhs2wbRRkmzmnpUTdwulahBrO/P8vthb/6ljank1rz+HwJ6fHG8LJfvQwUqU+WkOlUMz
         oohhs9psCTBSEei/S7mmpKp1DB0JJTqJEyiA5eu3BqHM9MgYsV0iLn/56xvQcjyluA9R
         GIHw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775146566; x=1775751366; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XpWeMAPNa4kjUUqgfe+POmovFhY+dw9PcsRJmCuy9so=;
        b=KXP5YL5r7/B7fcaKQY/B+SWa3ptPtvxl7/KtGo3N504FXqmOZtbFPQlDY371UFCZXB
         GOOQXCA4HQ4utlxuh72n8KDuPZsGxdXXqbliZ9XR9wDJp9GikbeSLRSUC4SEy3Ic0WOv
         e2d07kb5aRQqJgLruSfPeqWS2jZvaUf035JXoG2SPahdMc1/pf6K+A3H8vdMezNI4e/z
         7EdqGr1JLig+4K83VFGONHaNCogehOpw+l2RhEEDvPFK78skTfqoCVPThlgHlKtZMM3l
         MIM0eXVEJH4N/EX6ktNLLPmDIybstdJg/cOg5dZfGx9a028v15Oph52ubJ1z3OpI89dl
         b//g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775146566; x=1775751366;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XpWeMAPNa4kjUUqgfe+POmovFhY+dw9PcsRJmCuy9so=;
        b=pxunQAvxHSqjSpKBMSKDbV9jXyIeYz96Vc1UhjRLQAwHX9Rhl9aiDQyJQ85EicUzSD
         /Jw60aqZlhsA18f/ErXYRrwdx0fGzJNwX/UhOGkNxpsA0L65GE6iPwgvRrdeb725T0O5
         UFDy9I2JKpmOnwAVTMsNvUXYBh422cx5atMx48UIk84MSyLPwmYqwR8nx6I1KoZ4B7YF
         jlIgssw/7S/YvGYZU42BmVD3GPhO32WrzjoBlO1NVvDLQ7QFjZ79PLDPy0kO13BU5Og6
         ohuPB2xUhuUa5ZfgqPyFC1lBUPtK4M82C/ycZ0v6+mlULValzxlmfKMzdK+5UF9WiOdx
         DF9Q==
X-Forwarded-Encrypted: i=1; AJvYcCVF8/hXen8bZfxdVXuQUPAGBOsQ9gl1KW+moVc1IT3b6JmSsvCiPZd/SlKYXNxQF2oVslFmXkU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5TOJcAnutexgxPIR/008q0IeF3QHZiULHMm4ZPhyDPPo8pxJF
	iT5tvPufIvviYdFNWnEuDMI4deh1hQ19NpLOQt0OYELzXPIGcKWhjGHbCTRVFhVFe0kQTX9od2E
	HbFPx/d6bTyIFMoqoLlF8F5v8oi3ztAf8P2ttJp1Q
X-Gm-Gg: ATEYQzyjux6qAqdRgRinItVTUGnPdRsALKwd+7jb2Gu9EHQbnBxhqg/irWL+4YNXWIo
	PNDtpm3i9WOnYrkpjE1fwrGvW3BqrEKMwLzRJyLoFDbKigeC1Cbs/gZyZviGFQ7D7oKJSzJhUUu
	w0awPIdFdSUrZmMPsB+m6bds3lCOu5kP4N47pfsxxTxjc8+9+ouTW7WdKulK7s/IU9bAeBIfyho
	8XMeUhTZJxA8nawzAeSnghtq2s0bRyvFkhS0qJ+0W6LqL6b75mWr2Gy0yWORIfcdBMSmQIh1FVa
	rVcTULFTK0t5pyitQ62k5Vxz/xzlOckY+fh+9A==
X-Received: by 2002:aa7:ccd2:0:b0:66b:fcbf:11ad with SMTP id
 4fb4d7f45d1cf-66e082d709amr41208a12.2.1775146565852; Thu, 02 Apr 2026
 09:16:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260326224527.1044097-4-hramamurthy@google.com>
 <20260329212002.2875815-1-kuba@kernel.org> <CA+mzVtuK6NSrnZdcwyToTseFqBU86jRn9nbdeLGFjhjeok=q2g@mail.gmail.com>
 <CAMP57yWZkgU989sN38ycxiR1p5w48mssAwycZY4BZS28nDObRw@mail.gmail.com>
 <CA+mzVtv-91ru7v6GxOS80xihE4ZbwGqdyQdKPTHv+woKaeOhuQ@mail.gmail.com> <CAMP57yVS3OiFX+Qjcr9djO46OLZ=KuW2awD-7fCPZ=k2SdHNnw@mail.gmail.com>
In-Reply-To: <CAMP57yVS3OiFX+Qjcr9djO46OLZ=KuW2awD-7fCPZ=k2SdHNnw@mail.gmail.com>
From: Jordan Rhee <jordanrhee@google.com>
Date: Thu, 2 Apr 2026 09:15:53 -0700
X-Gm-Features: AQROBzBybDyhkaLO4W6f0OfSinHsRNQr4EvsqYPgibT3LjRjm-UBCE2LZLpbEWY
Message-ID: <CA+mzVtuL9iZ71VkMhb8vhs8idqOfJ=heWwgMLkYUjv6F0L91kQ@mail.gmail.com>
Subject: Re: [PATCH net-next v2 3/3] gve: implement PTP gettimex64
To: Naman Gulati <namangulati@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>, hramamurthy@google.com, netdev@vger.kernel.org, 
	joshwash@google.com, andrew+netdev@lunn.ch, davem@davemloft.net, 
	edumazet@google.com, pabeni@redhat.com, richardcochran@gmail.com, 
	willemb@google.com, nktgrg@google.com, jfraker@google.com, 
	ziweixiao@google.com, maolson@google.com, thostet@google.com, 
	jefrogers@google.com, alok.a.tiwari@oracle.com, yyd@google.com, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-274621-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	FREEMAIL_CC(0.00)[kernel.org,google.com,vger.kernel.org,lunn.ch,davemloft.net,redhat.com,gmail.com,oracle.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jordanrhee@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5E21038BB9B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The iowrite32be() inside gve_adminq_report_nic_ts() will prevent
reordering by the compiler because it uses volatile, and the VM exit
will prevent speculative execution by the CPU.

On Thu, Apr 2, 2026 at 8:53=E2=80=AFAM Naman Gulati <namangulati@google.com=
> wrote:
>
> On Thu, Apr 2, 2026 at 8:38=E2=80=AFAM Jordan Rhee <jordanrhee@google.com=
> wrote:
> >
> > We know that gve_adminq_report_nic_ts() will cause a VM exit, which
> > will act as a full barrier. Additional barriers are not strictly
> > necessary from a functional perspective. Can we rely on this fact or
> > do we need explicit barriers?
>
> I don't think that's enough. Without a barrier get_cycles can be
> speculatively executed before gve_adminq_report_nic_ts.
>
> >
> >
> > On Tue, Mar 31, 2026 at 11:05=E2=80=AFAM Naman Gulati <namangulati@goog=
le.com> wrote:
> > >
> > > On Sun, Mar 29, 2026 at 9:31=E2=80=AFPM Jordan Rhee <jordanrhee@googl=
e.com> wrote:
> > > >
> > > > On Sun, Mar 29, 2026 at 2:20=E2=80=AFPM Jakub Kicinski <kuba@kernel=
.org> wrote:
> > > > >
> > > > > This is an AI-generated review of your patch. The human sending t=
his
> > > > > email has considered the AI review valid, or at least plausible.
> > > > > ---
> > > > > Subject: gve: implement PTP gettimex64
> > > > >
> > > > > This commit implements the PTP gettimex64 function to enable chro=
ny and
> > > > > phc2sys to synchronize the system clock to the NIC clock. It read=
s the
> > > > > NIC timestamp along with pre and post system cycle counters to mi=
nimize
> > > > > the uncertainty window.
> > > > >
> > > > > > diff --git a/drivers/net/ethernet/google/gve/gve_ptp.c b/driver=
s/net/ethernet/google/gve/gve_ptp.c
> > > > > > index 140b8fbce4f4..bea794541f30 100644
> > > > > > --- a/drivers/net/ethernet/google/gve/gve_ptp.c
> > > > > > +++ b/drivers/net/ethernet/google/gve/gve_ptp.c
> > > > > > @@ -10,28 +10,203 @@
> > > > >
> > > > > [ ... ]
> > > > >
> > > > > > +static int gve_adminq_read_timestamp(struct gve_priv *priv,
> > > > > > +                                  cycles_t *pre_cycles,
> > > > > > +                                  cycles_t *post_cycles)
> > > > > > +{
> > > > > > +     unsigned long delay_us =3D 1000;
> > > > > > +     int retry_count =3D 0;
> > > > > > +     int err;
> > > > > > +
> > > > > > +     lockdep_assert_held(&priv->nic_ts_read_lock);
> > > > > > +
> > > > > > +     do {
> > > > > > +             *pre_cycles =3D get_cycles();
> > > > > > +             err =3D gve_adminq_report_nic_ts(priv, priv->nic_=
ts_report_bus);
> > > > > > +
> > > > > > +             /* Ensure cycle counter is sampled after AdminQ c=
md returns */
> > > > > > +             rmb();
> > > > > > +             *post_cycles =3D get_cycles();
> > > > >
> > > > > Are execution barriers needed around get_cycles() here? rmb() ord=
ers
> > > > > memory accesses, but the CPU might still speculatively execute th=
e cycle
> > > > > counter reads out of order with respect to the AdminQ commands.
> > > > >
> > > > > Could this speculative reordering cause the strict bounds validat=
ion in
> > > > > gve_ptp_gettimex64() to fail spuriously?
> > > >
> > > > I will add mb() barriers to be totally safe.
> > >
> > > I'm not so sure that rmb() is insufficient here. In x86_64 rmb() is a=
n
> > > lfence. lfence is used to prevent speculative execution (per the x86
> > > barrier_nospec implementation) and rdtsc_ordered, which is called by
> > > the ktime* helpers, also prefaces rdtsc with an lfence. On ARM the
> > > get_cycles implementation adds an isb instruction before reading
> > > cntvct_el0.
> > >
> > >
> > > >
> > > > > [ ... ]
> > > > >
> > > > > >  static int gve_ptp_gettimex64(struct ptp_clock_info *info,
> > > > > >                             struct timespec64 *ts,
> > > > > >                             struct ptp_system_timestamp *sts)
> > > > > >  {
> > > > > > -     return -EOPNOTSUPP;
> > > > > > +     struct gve_ptp *ptp =3D container_of(info, struct gve_ptp=
, info);
> > > > > > +     struct gve_sysclock_sample sysclock =3D {0};
> > > > > > +     struct gve_priv *priv =3D ptp->priv;
> > > > > > +     struct system_time_snapshot snap;
> > > > > > +     u64 nic_ts;
> > > > > > +     int err;
> > > > > > +
> > > > > > +     /* Take system clock snapshot before sampling cycle count=
ers */
> > > > > > +     if (sts)
> > > > > > +             ktime_get_snapshot(&snap);
> > > > > > +
> > > > > > +     err =3D gve_clock_nic_ts_read(priv, &nic_ts, &sysclock);
> > > > >
> > > > > Could the system time snapshot become stale here?
> > > > >
> > > > > If priv->nic_ts_read_lock is contended, or if gve_adminq_read_tim=
estamp()
> > > > > retries and sleeps, the snapshot might be taken significantly bef=
ore the
> > > > > actual hardware read.
> > > > >
> > > > > Would it be more accurate to take the snapshot immediately before=
 reading the
> > > > > hardware, inside the mutex?
> > > >
> > > > Ack, will fix.
> > > >
> > > > >
> > > > > > +     if (err)
> > > > > > +             return err;
> > > > > > +
> > > > > > +     if (sts) {
> > > > > > +             /* Reject samples with out of order system clock =
values */
> > > > > > +             if (!(sysclock.host_pre_cycles <=3D sysclock.nic_=
pre_cycles &&
> > > > > > +                   sysclock.nic_pre_cycles  <=3D sysclock.nic_=
post_cycles &&
> > > > > > +                   sysclock.nic_post_cycles <=3D sysclock.host=
_post_cycles)) {
> > > > > > +                     dev_err_ratelimited(&priv->pdev->dev,
> > > > > > +                                         "AdminQ system clock =
cycle counts out of order. Expecting %llu <=3D %llu <=3D %llu <=3D %llu\n",
> > > > > > +                                         (u64)sysclock.host_pr=
e_cycles,
> > > > > > +                                         sysclock.nic_pre_cycl=
es,
> > > > > > +                                         sysclock.nic_post_cyc=
les,
> > > > > > +                                         (u64)sysclock.host_po=
st_cycles);
> > > > > > +                     return -EBADMSG;
> > > > >
> > > > > How does this behave on architectures where get_cycles() is not i=
mplemented
> > > > > and returns 0, or with older firmware that leaves nic_pre_cycles =
and
> > > > > nic_post_cycles as 0?
> > > >
> > > > Firmware is not allowed to return 0. 0 should trigger the check.
> > > >
> > > > > It looks like the bounds check would unconditionally fail and ret=
urn -EBADMSG.
> > > > > Since userspace tools like chrony usually expect -EOPNOTSUPP for =
unsupported
> > > > > extended ioctls to fall back to basic PTP ioctls, will returning =
-EBADMSG
> > > > > cause a hard failure for clock synchronization?
> > > >
> > > > Will fix. GVE is only supported on x86_64 and arm64, and will fail =
on
> > > > other architectures with -EOPNOTSUPP due to the check in
> > > > gve_cycles_to_clock_fn(). However, if an architecture returns
> > > > get_cycles() as 0, it will fail here first with -EBADMSG. I will ad=
d
> > > > an explicit check for x86 || arm64 earlier in this function.
> > > >
> > > > >
> > > > > [ ... ]
> > > > >
> > > > > > @@ -132,7 +307,7 @@ int gve_init_clock(struct gve_priv *priv)
> > > > > >               goto release_ptp;
> > > > > >       }
> > > > > >       mutex_init(&priv->nic_ts_read_lock);
> > > > > > -     err =3D gve_clock_nic_ts_read(priv, &nic_raw);
> > > > > > +     err =3D gve_clock_nic_ts_read(priv, &nic_raw, NULL);
> > > > > >       if (err) {
> > > > > >               dev_err(&priv->pdev->dev, "failed to read NIC clo=
ck %d\n", err);
> > > > > >               goto release_nic_ts_report;
> > > > >
> > > > > Is there a race condition exposing the PTP device to userspace be=
fore its
> > > > > resources are fully initialized?
> > > > >
> > > > > Looking at gve_init_clock(), gve_ptp_init() is called before allo=
cating
> > > > > nic_ts_report and initializing nic_ts_read_lock:
> > > > >
> > > > >     err =3D gve_ptp_init(priv);
> > > > >     if (err)
> > > > >         return err;
> > > > >
> > > > >     priv->nic_ts_report =3D dma_alloc_coherent(...);
> > > > >     ...
> > > > >     mutex_init(&priv->nic_ts_read_lock);
> > > > >
> > > > > If a concurrent userspace process immediately invokes the
> > > > > PTP_SYS_OFFSET_EXTENDED ioctl after gve_ptp_init() registers the =
/dev/ptpX
> > > > > device, could it call gve_ptp_gettimex64() and attempt to lock th=
e
> > > > > uninitialized mutex or dereference the NULL nic_ts_report pointer=
?
> > > > >
> > > > > Additionally, in the error path for gve_init_clock():
> > > > >
> > > > >     release_nic_ts_report:
> > > > >         mutex_destroy(&priv->nic_ts_read_lock);
> > > > >         dma_free_coherent(...);
> > > > >         priv->nic_ts_report =3D NULL;
> > > > >     release_ptp:
> > > > >         gve_ptp_release(priv);
> > > > >
> > > > > Could destroying the mutex and freeing the memory before gve_ptp_=
release()
> > > > > create a use-after-free window if an ioctl is currently running?
> > > >
> > > > Will be fixed in the previous patch in the series.

