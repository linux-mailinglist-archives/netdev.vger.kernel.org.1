Return-Path: <netdev+bounces-98144-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A97A8CFB09
	for <lists+netdev@lfdr.de>; Mon, 27 May 2024 10:08:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B3A89B214DF
	for <lists+netdev@lfdr.de>; Mon, 27 May 2024 08:08:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CBC36CDB1;
	Mon, 27 May 2024 08:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EKMFQ/pf"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56DD960882
	for <netdev@vger.kernel.org>; Mon, 27 May 2024 08:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716797269; cv=none; b=PLymd52GJbrJzkMl9TiwlNaScAEUuCBjaiHx8dpKAXuoJI97jj681J1i2FYNVrepxsa5EH1LWk45LHmuVcgaffaYAKJ4tzUTCPwLgqz+zrJXdYqLFQmew3+MJUoEPNLtdtHKS3Q0H1Mpcq/bDWS0yzloJh8SIlNFySnbuLerL00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716797269; c=relaxed/simple;
	bh=iUeVo1tdY+5ul8ldSESVIRoMjkelgDsPoZVf7Sjt9Uc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o8YEMTQy1mKd5KgJBGesTSZXIC7w+yqHQGeGZTwCeYvJ67kBZjhRp+xTa8NxGST9HU+tYlH10EaO6slpkbBFCS/wLVAz2nqwkSI1mxTo9Zgpb6IOteCrdhL8dsZFm5b3U2X9jZ27HoD+fV2znA2MXGHYazTeNtptjVa7DLh9QyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EKMFQ/pf; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-579ce5fbeb6so5009a12.1
        for <netdev@vger.kernel.org>; Mon, 27 May 2024 01:07:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1716797266; x=1717402066; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lvywjM11zQlVaVE7ADpOEvrrpKIrXsL/oSnsjL/LEU0=;
        b=EKMFQ/pf1Mh+C7Oc3jL6R4bfCebqcDKbo0itFY3Sey8RfnrUpzJFeAtddL8k1LyBMM
         7UHgmwaYRb0hmmUi3+2suyZJWQ049vHqkHBr6w/2CYEvXn7q5F5PS8rAOxGRZrRcp2aJ
         Sc7vgZNGI32sDcFP4gG3XtQXCO+jEJIfcvxzq8IzhmFTwQbX5THRuzYLhqg4tSKmLOFU
         gmVp62YZ69alrNpAwRgphSOgoGLMwSLYvEtSL0Nqh483VITouBvexXLkmLPClJt6e3Cl
         ewEltDbAvvqG5zZfBuMQZwLsYWIypiUPEP4SlpYBDNJjJeiqjdZCJthY25BhI1BkygY4
         5F6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716797266; x=1717402066;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lvywjM11zQlVaVE7ADpOEvrrpKIrXsL/oSnsjL/LEU0=;
        b=fsrAxbPv9wuoMrey2txpt5HSg5gm/RFtpP2CSM/VPQug1G4wlE1jxnjPAr+nN2w/HZ
         LjIHTI04ubslEsTGxFQf7yqRnUUl8zFgBOP8e3Qmw8REGrZJDqfHmCANNwEa/uFpNld5
         EO/zfRCD1/eUHL5BatNDhGh4nR3nh4RR90uFLIXFhvC+LzLjZ/hOOUMmDLRnU5BGR/Kd
         YFIdqV7AUoLxNI3OeyFBbkhhua/rJgfKB6j9SCkzisy4zxt+DcLcs3EnN78ECj2ZlrVt
         TkISpyk8yew3eACcnR35Iw6DZCn4rtXlDhPoyH2cmqb0Edjhh1vRa6/F27iV5YPLuv6E
         sg+w==
X-Forwarded-Encrypted: i=1; AJvYcCUbeynBiMhHlQYGnOuNPNDJDLqVB1Vq20VNZR5goWRJVOIsTyMrwdjSDZgthucmBJxQw1N9remttf2232y+BwGnYtu8k/Qs
X-Gm-Message-State: AOJu0YzKvTzkLMmWLIkCsaH9bydcFZxD5H4i6aRD9EFjUsJH2ndVHtCC
	5uLlIT3IvJ/ixVMYTuOuFO4lS+hgobgJtHl1kovJRBOGs8i6pmhiOCj1JH+rGFgQ27lz2dhlt76
	Qci0yCdpp7sPRBmBHoIIe3phA3Y/24n5ZoQxR
X-Google-Smtp-Source: AGHT+IHrN+HAMDlUIbaHK1fxMxMN+iYh0hEk47y5XfgCJd8xWCbcxbgg6EhqA6oDoAPGTCB8k98eHwbjl77fqn4ChMs=
X-Received: by 2002:a05:6402:2695:b0:579:d7e8:fc6 with SMTP id
 4fb4d7f45d1cf-579d7e8151emr65952a12.4.1716797265330; Mon, 27 May 2024
 01:07:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240523134549.160106-1-edumazet@google.com> <20240524153948.57ueybbqeyb33lxj@skbuf>
 <CANn89iKwinmr=XnsA=N0NiGJhMvZKXuehPmViniMFo7PQeePWQ@mail.gmail.com>
 <CANn89iKtp6S1guEb75nswR=baG4KN11s9m+HQZQ+v_ig3tOUfg@mail.gmail.com> <20240524160718.mak4p7jan2t5qfoz@skbuf>
In-Reply-To: <20240524160718.mak4p7jan2t5qfoz@skbuf>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 27 May 2024 10:07:31 +0200
Message-ID: <CANn89iKiox74T-ytObEoajCMR+cVHfYbGvSJOGObKTBpHxauvA@mail.gmail.com>
Subject: Re: [PATCH net] net/sched: taprio: fix duration_to_length()
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Jamal Hadi Salim <jhs@mojatatu.com>, 
	Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, syzbot <syzkaller@googlegroups.com>, 
	Vinicius Costa Gomes <vinicius.gomes@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 24, 2024 at 6:07=E2=80=AFPM Vladimir Oltean <vladimir.oltean@nx=
p.com> wrote:
>
> On Fri, May 24, 2024 at 05:52:17PM +0200, Eric Dumazet wrote:
> > On Fri, May 24, 2024 at 5:50=E2=80=AFPM Eric Dumazet <edumazet@google.c=
om> wrote:
> > >
> > > On Fri, May 24, 2024 at 5:39=E2=80=AFPM Vladimir Oltean <vladimir.olt=
ean@nxp.com> wrote:
> > > >
> > > > On Thu, May 23, 2024 at 01:45:49PM +0000, Eric Dumazet wrote:
> > > > > duration_to_length() is incorrectly using div_u64()
> > > > > instead of div64_u64().
> > > > > ---
> > > > >  net/sched/sch_taprio.c | 3 ++-
> > > > >  1 file changed, 2 insertions(+), 1 deletion(-)
> > > > >
> > > > > diff --git a/net/sched/sch_taprio.c b/net/sched/sch_taprio.c
> > > > > index 1ab17e8a72605385280fad9b7f656a6771236acc..827fb81fc63a09830=
4bad198fadd4aed55d1fec4 100644
> > > > > --- a/net/sched/sch_taprio.c
> > > > > +++ b/net/sched/sch_taprio.c
> > > > > @@ -256,7 +256,8 @@ static int length_to_duration(struct taprio_s=
ched *q, int len)
> > > > >
> > > > >  static int duration_to_length(struct taprio_sched *q, u64 durati=
on)
> > > > >  {
> > > > > -     return div_u64(duration * PSEC_PER_NSEC, atomic64_read(&q->=
picos_per_byte));
> > > > > +     return div64_u64(duration * PSEC_PER_NSEC,
> > > > > +                      atomic64_read(&q->picos_per_byte));
> > > > >  }
> > > >
> > > > There's a netdev_dbg() in taprio_set_picos_per_byte(). Could you tu=
rn
> > > > that on? I'm curious what was the q->picos_per_byte value that trig=
gered
> > > > the 64-bit division fault. There are a few weird things about
> > > > q->picos_per_byte's representation and use as an atomic64_t (s64) t=
ype.
> > >
> > >
> > > No repro yet.
> > >
> > > Anything with 32 low order bits cleared would trigger a divide by 0.
> > >
> > > (1ULL << 32) picoseconds is only 4.294 ms
> >
> > BTW, just a reminder, div_u64() is a divide by a 32bit value...
> >
> > static inline u64 div_u64(u64 dividend, u32 divisor)
> > ...
>
> The thing is that I don't see how q->picos_per_byte could take any sane
> value of either 0 or a multiple of 2^32. Its formula is "(USEC_PER_SEC * =
8) / speed"
> where "speed" is the link speed: 10, 100, 1000 etc. The special cases
> of speed=3D0 and speed=3DSPEED_UNKNOWN are handled by falling back to SPE=
ED_10
> in the picos_per_byte calculation.
>
> For q->picos_per_byte to be larger than 2^32, "speed" would have to be
> smaller than 8000000 / U32_MAX (0.001862645).
>
> For q->picos_per_byte to be exactly 0, "speed" would have to be larger
> than 8000000. But the largest defined speed in include/uapi/linux/ethtool=
.h
> is precisely SPEED_800000, leading to an expected q->picos_per_byte of 1.

This suggests q->picos_per_byte should be a mere u32, and that
taprio_set_picos_per_byte()
should make sure to not set  0 in q->picos_per_byte

Presumably some devices must get a speed bigger than SPEED_800000

team driver could do that, according to team_ethtool_get_link_ksettings()


diff --git a/net/sched/sch_taprio.c b/net/sched/sch_taprio.c
index 1ab17e8a72605385280fad9b7f656a6771236acc..71087a53630362863cc6c5e462b=
29dbef8cd5d74
100644
--- a/net/sched/sch_taprio.c
+++ b/net/sched/sch_taprio.c
@@ -89,9 +89,9 @@ struct taprio_sched {
        bool offloaded;
        bool detected_mqprio;
        bool broken_mqprio;
-       atomic64_t picos_per_byte; /* Using picoseconds because for 10Gbps+
-                                   * speeds it's sub-nanoseconds per byte
-                                   */
+       atomic_t picos_per_byte; /* Using picoseconds because for 10Gbps+
+                                 * speeds it's sub-nanoseconds per byte
+                                 */

        /* Protects the update side of the RCU protected current_entry */
        spinlock_t current_entry_lock;
@@ -251,12 +251,12 @@ static ktime_t get_interval_end_time(struct
sched_gate_list *sched,

 static int length_to_duration(struct taprio_sched *q, int len)
 {
-       return div_u64(len * atomic64_read(&q->picos_per_byte), PSEC_PER_NS=
EC);
+       return div_u64((u64)len * atomic_read(&q->picos_per_byte),
PSEC_PER_NSEC);
 }

 static int duration_to_length(struct taprio_sched *q, u64 duration)
 {
-       return div_u64(duration * PSEC_PER_NSEC,
atomic64_read(&q->picos_per_byte));
+       return div_u64(duration * PSEC_PER_NSEC,
atomic_read(&q->picos_per_byte));
 }

 /* Sets sched->max_sdu[] and sched->max_frm_len[] to the minimum between t=
he
@@ -666,8 +666,8 @@ static void taprio_set_budgets(struct taprio_sched *q,
                if (entry->gate_duration[tc] =3D=3D sched->cycle_time)
                        budget =3D INT_MAX;
                else
-                       budget =3D
div64_u64((u64)entry->gate_duration[tc] * PSEC_PER_NSEC,
-                                          atomic64_read(&q->picos_per_byte=
));
+                       budget =3D div_u64((u64)entry->gate_duration[tc]
* PSEC_PER_NSEC,
+                                        atomic_read(&q->picos_per_byte));

                atomic_set(&entry->budget[tc], budget);
        }
@@ -1291,7 +1291,7 @@ static void taprio_set_picos_per_byte(struct
net_device *dev,
 {
        struct ethtool_link_ksettings ecmd;
        int speed =3D SPEED_10;
-       int picos_per_byte;
+       u32 picos_per_byte;
        int err;

        err =3D __ethtool_get_link_ksettings(dev, &ecmd);
@@ -1303,11 +1303,11 @@ static void taprio_set_picos_per_byte(struct
net_device *dev,

 skip:
        picos_per_byte =3D (USEC_PER_SEC * 8) / speed;
-
-       atomic64_set(&q->picos_per_byte, picos_per_byte);
-       netdev_dbg(dev, "taprio: set %s's picos_per_byte to: %lld,
linkspeed: %d\n",
-                  dev->name, (long long)atomic64_read(&q->picos_per_byte),
-                  ecmd.base.speed);
+       if (!picos_per_byte)
+               picos_per_byte =3D 1U;
+       atomic_set(&q->picos_per_byte, picos_per_byte);
+       netdev_dbg(dev, "taprio: set %s's picos_per_byte to: %u,
linkspeed: %d\n",
+                  dev->name, picos_per_byte, ecmd.base.speed);
 }

