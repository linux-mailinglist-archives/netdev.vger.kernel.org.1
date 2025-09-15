Return-Path: <netdev+bounces-223177-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 32B19B581F0
	for <lists+netdev@lfdr.de>; Mon, 15 Sep 2025 18:24:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4FBFF48302B
	for <lists+netdev@lfdr.de>; Mon, 15 Sep 2025 16:24:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7CE925DD0C;
	Mon, 15 Sep 2025 16:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2/OjvXq2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C75A22222D1
	for <netdev@vger.kernel.org>; Mon, 15 Sep 2025 16:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757953468; cv=none; b=Ev416wx5sDmpjZmd7IFsD5WSj+LqhRSNUHveOY8HUe5ZL56msrN97VssMJEkaWCvJVKJK+YaOFZciph7mCTx+3bF/26YhPUTZJ4cUjbGv++hBJTJOs1LBSMUdL1cH/Nn74cIWtLFT+zrfdZPHGjxRdt+bw3HVFnSp0zWTOYILRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757953468; c=relaxed/simple;
	bh=vCnrSNDNZbdtwqbQF0C/JLvTu4JxeU2IUKDW28tRMKg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=s1CcZDRNQzgBnI4wN/B42IpDmXTxemc8ikEu9OTBiUZ3+adfPLSWbiB9/eO9nHe29vUzAGV4HrpdwNZA65/8NfQ6/lvg8Y373w6mnI/a4NF0vz51KDVx09Xy+wQTuvBM8mYJzuZJ254cyCzCd4Xdsz18zlyRfua9B7IaqAfsrW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2/OjvXq2; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-265abad93bfso218295ad.0
        for <netdev@vger.kernel.org>; Mon, 15 Sep 2025 09:24:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757953466; x=1758558266; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J5px4UZqTaVAp/IuR7BdScybA6fbJgTvKCdBa+jtY/k=;
        b=2/OjvXq2lE19fogY7cMsftVqwEHW87msIvhmfFqthFBsqym1soHFY7VBzmGMUWiOp6
         IjueFzJBnk1QgQeN3nGKTeybfUeFEagcsmVEtFTcOYl2nWorH6DUIkNWGBL5fWDmKAf4
         tnmBTgwq1xYqamb2A40h9BQ9H2Ra7USHLq85IYzZt/I0638zIX5x/bqYFTp8k7r8h4Zl
         +jX9knplNL2E3tFqfOtpbWHcut28UPEC95ppcW5rrQdO9fmcDXw6c1d7/yNiNCHzL21W
         yFf82LEJEi/dSs6dcWUBlOo6GyDKe0RX6GVOkzgf73ww1hrPobhnPBvFJZAiMuZPDT7B
         ZrXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757953466; x=1758558266;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J5px4UZqTaVAp/IuR7BdScybA6fbJgTvKCdBa+jtY/k=;
        b=dINfI8otxJcgCIrFVyuN1ULCE9cP5maZ1EbtZfixwImHPtMZK/25IU9kNF0tzoQJ4o
         zNMioujEpTkTuYRqQnCmFhBpzoMN8BpeLkiLAnfVVEuKNhRiPaAuhdCyMwLioLmHXPaj
         /goxReXvamJnujO7xHh3pFfSVA2r2BWtP4bo8DaIz6PUF+Cisrvk48DJjMqkhRJgt4DJ
         cPaEruoFj5fhUMStj1ddVxscd9nluBRYTizMZI3Z0/uXPd1UfoWT8jHu0ohlZfdenhe8
         ndpQEvrkVeJb5WI5/A6PEpwyyfdgCB0ysyL1yKfG/ZJSZYJ8GahrB1dFlz1g4GgZ3//R
         +3yg==
X-Forwarded-Encrypted: i=1; AJvYcCU1rayfmxVZmdqvxeIb/c9zZ2hcLwCkHFbEk7BAMqwgdEyiXAaXloW6joFSeqvHV6hsKh0SPNY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxs59SdoZcs9zQnQ4V6z8xDLwzdoZiyB7jeeh0ki7xNbZDUhtfa
	+uLmoiLQaUhHJuJhWVK3hkf3Vdb+hJ+buzhoHoQZm2rVRJXCXhXTW3dDl6/RPFUJ87kUafF6HsR
	iz4rYaYavGPTDX7dsirlWmPFRO1qhtzcJ9lKtKfIX
X-Gm-Gg: ASbGncujFypJwKqdDbAMPgo32aFIyxcizKAzA+5K32kZee+jTuPA5bhQWjd59t6MHEB
	vkRG5Qwz8x3sCnEMgz24ZYnaGl+QC4QgP0Rp4QP0vTHccIpr9AC5+GATaS2DjKsyqEvG86yaFwu
	7tflP+IC7dLarBbep/hMRYbEaq8JUOLi2b3PH4V2yn8r+IPpv23yDV0nlY97Sqs72W2ZlZ+CZ5b
	qIvKUOtTvpQQfxHEbsh1MoGctFim+8F1NGFvIN5twc4DJ7Qa23K
X-Google-Smtp-Source: AGHT+IFFc5y45k7v48zyDYRJ1kSu7a6prxL2wilVuBCYM913aY0UQzo7gmIakMCpHEK3+AA8QShQkZ53tg5z49vi5ro=
X-Received: by 2002:a17:902:d486:b0:264:1805:df20 with SMTP id
 d9443c01a7336-2641805e24emr5045055ad.4.1757953465551; Mon, 15 Sep 2025
 09:24:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250911212901.1718508-1-skhawaja@google.com> <20250911212901.1718508-2-skhawaja@google.com>
 <20250912184608.6c6a7c51@kernel.org>
In-Reply-To: <20250912184608.6c6a7c51@kernel.org>
From: Samiullah Khawaja <skhawaja@google.com>
Date: Mon, 15 Sep 2025 09:24:13 -0700
X-Gm-Features: Ac12FXz5m-lR3hBMLNSV0fU9dhkm3fPIaXa_sxrIyfMucKllBlULrjMfJPSVypM
Message-ID: <CAAywjhR1yHShH_LdMW+s-L+Luv=jpWG3kr3eSu1h5w6tWFMCHw@mail.gmail.com>
Subject: Re: [PATCH net-next v9 1/2] Extend napi threaded polling to allow
 kthread based busy polling
To: Jakub Kicinski <kuba@kernel.org>
Cc: "David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, almasrymina@google.com, willemb@google.com, 
	Joe Damato <joe@dama.to>, mkarsten@uwaterloo.ca, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 12, 2025 at 6:46=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Thu, 11 Sep 2025 21:29:00 +0000 Samiullah Khawaja wrote:
> > Add a new state to napi state enum:
> >
> > - NAPI_STATE_THREADED_BUSY_POLL
> >   Threaded busy poll is enabled/running for this napi.
> >
> > Following changes are introduced in the napi scheduling and state logic=
:
> >
> > - When threaded busy poll is enabled through netlink it also enables
> >   NAPI_STATE_THREADED so a kthread is created per napi. It also sets
> >   NAPI_STATE_THREADED_BUSY_POLL bit on each napi to indicate that it is
> >   going to busy poll the napi.
> >
> > - When napi is scheduled with NAPI_STATE_SCHED_THREADED and associated
> >   kthread is woken up, the kthread owns the context. If
> >   NAPI_STATE_THREADED_BUSY_POLL and NAPI_STATE_SCHED_THREADED both are
> >   set then it means that kthread can busy poll.
> >
> > - To keep busy polling and to avoid scheduling of the interrupts, the
> >   napi_complete_done returns false when both NAPI_STATE_SCHED_THREADED
> >   and NAPI_STATE_THREADED_BUSY_POLL flags are set. Also
> >   napi_complete_done returns early to avoid the
> >   NAPI_STATE_SCHED_THREADED being unset.
> >
> > - If at any point NAPI_STATE_THREADED_BUSY_POLL is unset, the
> >   napi_complete_done will run and unset the NAPI_STATE_SCHED_THREADED
> >   bit also. This will make the associated kthread go to sleep as per
> >   existing logic.
> >
> > Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
>
> I think you need to spend some time trying to make this code more..
> elegant.
Thanks for the review and the feedback. I will work on it for the next revi=
sion.
>
> > diff --git a/Documentation/netlink/specs/netdev.yaml b/Documentation/ne=
tlink/specs/netdev.yaml
> > index c035dc0f64fd..ce28e8708a87 100644
> > --- a/Documentation/netlink/specs/netdev.yaml
> > +++ b/Documentation/netlink/specs/netdev.yaml
> > @@ -88,7 +88,7 @@ definitions:
> >    -
> >      name: napi-threaded
> >      type: enum
> > -    entries: [disabled, enabled]
> > +    entries: [disabled, enabled, busy-poll-enabled]
>
> drop the -enabled
Agreed
>
> >  attribute-sets:
> >    -
> > @@ -291,7 +291,8 @@ attribute-sets:
> >          name: threaded
> >          doc: Whether the NAPI is configured to operate in threaded pol=
ling
> >               mode. If this is set to enabled then the NAPI context ope=
rates
> > -             in threaded polling mode.
> > +             in threaded polling mode. If this is set to busy-poll-ena=
bled
> > +             then the NAPI kthread also does busypolling.
>
> I don't think busypolling is a word? I mean, I don't think English
> combines words like this.
>
> > +Threaded NAPI busy polling
> > +--------------------------
>
> Please feed the documentation into a grammar checker. A bunch of
> articles seems to be missing.
>
> > +Threaded NAPI allows processing of packets from each NAPI in a kthread=
 in
> > +kernel. Threaded NAPI busy polling extends this and adds support to do
> > +continuous busy polling of this NAPI. This can be used to enable busy =
polling
> > +independent of userspace application or the API (epoll, io_uring, raw =
sockets)
> > +being used in userspace to process the packets.
> > +
> > +It can be enabled for each NAPI using netlink interface.
>
> Netlink, capital letter
>
> > +For example, using following script:
> > +
> > +.. code-block:: bash
> > +
> > +  $ ynl --family netdev --do napi-set \
> > +            --json=3D'{"id": 66, "threaded": "busy-poll-enabled"}'
> > +
> > +
> > +Enabling it for each NAPI allows finer control to enable busy pollling=
 for
>
> pollling -> polling
>
> > +only a set of NIC queues which will get traffic with low latency requi=
rements.
>
> A bit of a non-sequitur. Sounds like you just cut off the device-wide
> config here.
Will reword this.
>
> > +Depending on application requirement, user might want to set affinity =
of the
> > +kthread that is busy polling each NAPI. User might also want to set pr=
iority
> > +and the scheduler of the thread depending on the latency requirements.
> > +
> > +For a hard low-latency application, user might want to dedicate the fu=
ll core
> > +for the NAPI polling so the NIC queue descriptors are picked up from t=
he queue
> > +as soon as they appear. Once enabled, the NAPI thread will poll the NI=
C queues
> > +continuously without sleeping. This will keep the CPU core busy with 1=
00%
> > +usage. For more relaxed low-latency requirement, user might want to sh=
are the
> > +core with other threads by setting thread affinity and priority.
>
> Is there such a thing a priority in the Linux scheduler? Being more
> specific would be useful. I think this code is useful for forwarding
> or AF_XDP but normal socket applications would struggle to use this
> mode.
Will reword this.
>
> >  Threaded NAPI
> > diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
> > index f3a3b761abfb..a88f6596aef7 100644
> > --- a/include/linux/netdevice.h
> > +++ b/include/linux/netdevice.h
> > @@ -427,6 +427,8 @@ enum {
> >       NAPI_STATE_THREADED,            /* The poll is performed inside i=
ts own thread*/
> >       NAPI_STATE_SCHED_THREADED,      /* Napi is currently scheduled in=
 threaded mode */
> >       NAPI_STATE_HAS_NOTIFIER,        /* Napi has an IRQ notifier */
> > +     NAPI_STATE_THREADED_BUSY_POLL,  /* The threaded napi poller will =
busy poll */
> > +     NAPI_STATE_SCHED_THREADED_BUSY_POLL,  /* The threaded napi poller=
 is busy polling */
>
> I don't get why you need 2 bits to implement this feature.
I will reuse the IN_BUSY_POLL bit as you suggested below.
>
> > @@ -1873,7 +1881,8 @@ enum netdev_reg_state {
> >   *   @addr_len:              Hardware address length
> >   *   @upper_level:           Maximum depth level of upper devices.
> >   *   @lower_level:           Maximum depth level of lower devices.
> > - *   @threaded:              napi threaded state.
> > + *   @threaded:              napi threaded mode is disabled, enabled o=
r
> > + *                           enabled with busy polling.
>
> And you are still updating the device level kdoc.
>
> >   *   @neigh_priv_len:        Used in neigh_alloc()
> >   *   @dev_id:                Used to differentiate devices that share
> >   *                           the same link layer address
>
> > @@ -78,6 +78,7 @@
> >  #include <linux/slab.h>
> >  #include <linux/sched.h>
> >  #include <linux/sched/isolation.h>
> > +#include <linux/sched/types.h>
>
> Leftover from experiments with setting scheduler params in the core?
> Or dare I say Google prod kernel?
>
> >  #include <linux/sched/mm.h>
> >  #include <linux/smpboot.h>
> >  #include <linux/mutex.h>
> > @@ -6619,7 +6620,8 @@ bool napi_complete_done(struct napi_struct *n, in=
t work_done)
> >        *    the guarantee we will be called later.
> >        */
> >       if (unlikely(n->state & (NAPIF_STATE_NPSVC |
> > -                              NAPIF_STATE_IN_BUSY_POLL)))
> > +                              NAPIF_STATE_IN_BUSY_POLL |
> > +                              NAPIF_STATE_SCHED_THREADED_BUSY_POLL)))
>
> Why not just set the IN_BUSY_POLL when the thread starts polling?
> What's the significance of the distinction?
Agreed. I think I can reuse the IN_BUSY_POLL bit.
>
> >               return false;
> >
> >       if (work_done) {
>
> > +static void napi_set_threaded_state(struct napi_struct *napi,
> > +                                 enum netdev_napi_threaded threaded)
> > +{
> > +     unsigned long val;
> > +
> > +     val =3D 0;
> > +     if (threaded =3D=3D NETDEV_NAPI_THREADED_BUSY_POLL_ENABLED)
> > +             val |=3D NAPIF_STATE_THREADED_BUSY_POLL;
> > +     if (threaded)
> > +             val |=3D NAPIF_STATE_THREADED;
>
> this reads odd, set threaded first then the sub-option
>
> > +     set_mask_bits(&napi->state, NAPIF_STATE_THREADED_BUSY_POLL_MASK, =
val);
>
> Does this actually have to be atomic? I don't think so.
Agreed.
>
> > +}
> > +
> >  int napi_set_threaded(struct napi_struct *napi,
> >                     enum netdev_napi_threaded threaded)
> >  {
> > @@ -7050,7 +7066,7 @@ int napi_set_threaded(struct napi_struct *napi,
> >       } else {
> >               /* Make sure kthread is created before THREADED bit is se=
t. */
> >               smp_mb__before_atomic();
> > -             assign_bit(NAPI_STATE_THREADED, &napi->state, threaded);
> > +             napi_set_threaded_state(napi, threaded);
> >       }
> >
> >       return 0;
> > @@ -7442,7 +7458,9 @@ void napi_disable_locked(struct napi_struct *n)
> >               }
> >
> >               new =3D val | NAPIF_STATE_SCHED | NAPIF_STATE_NPSVC;
> > -             new &=3D ~(NAPIF_STATE_THREADED | NAPIF_STATE_PREFER_BUSY=
_POLL);
> > +             new &=3D ~(NAPIF_STATE_THREADED
> > +                      | NAPIF_STATE_THREADED_BUSY_POLL
> > +                      | NAPIF_STATE_PREFER_BUSY_POLL);
>
> kernel coding style has | at the end of the line.
>
> >       } while (!try_cmpxchg(&n->state, &val, new));
> >
> >       hrtimer_cancel(&n->timer);
> > @@ -7486,7 +7504,7 @@ void napi_enable_locked(struct napi_struct *n)
> >
> >               new =3D val & ~(NAPIF_STATE_SCHED | NAPIF_STATE_NPSVC);
> >               if (n->dev->threaded && n->thread)
> > -                     new |=3D NAPIF_STATE_THREADED;
> > +                     napi_set_threaded_state(n, n->dev->threaded);
> >       } while (!try_cmpxchg(&n->state, &val, new));
> >  }
> >  EXPORT_SYMBOL(napi_enable_locked);
> > @@ -7654,7 +7672,7 @@ static int napi_thread_wait(struct napi_struct *n=
api)
> >       return -1;
> >  }
> >
> > -static void napi_threaded_poll_loop(struct napi_struct *napi)
> > +static void napi_threaded_poll_loop(struct napi_struct *napi, bool bus=
y_poll)
> >  {
> >       struct bpf_net_context __bpf_net_ctx, *bpf_net_ctx;
> >       struct softnet_data *sd;
> > @@ -7683,22 +7701,58 @@ static void napi_threaded_poll_loop(struct napi=
_struct *napi)
> >               }
> >               skb_defer_free_flush(sd);
> >               bpf_net_ctx_clear(bpf_net_ctx);
> > +
> > +             /* Flush too old packets. If HZ < 1000, flush all packets=
 */
>
> Probably better to say something about the condition than just copy
> the comment third time.
>
> > +             if (busy_poll)
> > +                     gro_flush_normal(&napi->gro, HZ >=3D 1000);
> >               local_bh_enable();
> >
> > -             if (!repoll)
> > +             /* If busy polling then do not break here because we need=
 to
> > +              * call cond_resched and rcu_softirq_qs_periodic to preve=
nt
> > +              * watchdog warnings.
> > +              */
> > +             if (!repoll && !busy_poll)
> >                       break;
> >
> >               rcu_softirq_qs_periodic(last_qs);
> >               cond_resched();
> > +
> > +             if (!repoll)
> > +                     break;
> >       }
> >  }
> >
> >  static int napi_threaded_poll(void *data)
> >  {
> >       struct napi_struct *napi =3D data;
> > +     bool busy_poll_sched;
> > +     unsigned long val;
> > +     bool busy_poll;
> > +
> > +     while (!napi_thread_wait(napi)) {
> > +             /* Once woken up, this means that we are scheduled as thr=
eaded
> > +              * napi and this thread owns the napi context, if busy po=
ll
>
> please capitalize NAPI in all comments and docs
>
> > +              * state is set then busy poll this napi.
> > +              */
> > +             val =3D READ_ONCE(napi->state);
> > +             busy_poll =3D val & NAPIF_STATE_THREADED_BUSY_POLL;
> > +             busy_poll_sched =3D val & NAPIF_STATE_SCHED_THREADED_BUSY=
_POLL;
> > +
> > +             /* Do not busy poll if napi is disabled. */
>
> It's not disabled, disable is pending
>
> > +             if (unlikely(val & NAPIF_STATE_DISABLE))
>
> > +                     busy_poll =3D false;
> > +
> > +             if (busy_poll !=3D busy_poll_sched) {
> > +                     val =3D busy_poll ?
> > +                                     NAPIF_STATE_SCHED_THREADED_BUSY_P=
OLL :
> > +                                     0;
> > +                     set_mask_bits(&napi->state,
> > +                                   NAPIF_STATE_SCHED_THREADED_BUSY_POL=
L,
> > +                                   val);
>
> why set single bit with set_mask_bits() ?
>
> Please improve, IIRC it took quite a lot of reviewer effort to get
> the thread stopping into shape, similar level of effort will not be
> afforded again.

