Return-Path: <netdev+bounces-124812-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EC96396B0B1
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 07:52:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA1051C20D56
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 05:52:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F29084E14;
	Wed,  4 Sep 2024 05:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qJAHLwch"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D7CC84FAD
	for <netdev@vger.kernel.org>; Wed,  4 Sep 2024 05:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725429160; cv=none; b=T+cLYotOwhIQsztrdiSpBEKUIAFqfHEUU99PnoG3dbFgpqYqSi9PB3P0gIrOLvxSVUNdVi5ctxqQL8xVTNn7t4WIbSFOJnWp58M9UQXjoE0MR96Miegeu+SyOL6Y7HsnPtb054OPgz0gdA3R0jzIrZaNFi1WEv+W46gnfoZw68I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725429160; c=relaxed/simple;
	bh=FHAHq5En2ytSrx9wAQ+3HWUZ4QEOTrFIzGXIHEZ9U0Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=THMKuVU/mAKxhVORK0jBe9n3kO44E3tu4J0xBxbjyuDdcvnja5EXqgRD6ZoF/mmX5JYIcSKE6glpsNPYrLyFQjhq3oydkILi1jfAa1BsFTOUrlL0nLFztB4KKC4KEHvKRe140qsmzMVF6ju9SEnSCaQKKxMqCZTgZbeaWhdMnsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qJAHLwch; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-5334491702cso2149e87.0
        for <netdev@vger.kernel.org>; Tue, 03 Sep 2024 22:52:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725429157; x=1726033957; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IpIJEb+RbBNCQx9hDO51spdk1MhZBEgZyMyfLVhshic=;
        b=qJAHLwchRUQtycPtkD38KoOzOqVKtZCIU6Le4Bln3eAc1Zr7YGQx4plN/nUWuFL6tH
         EUls7AGOKd8nqGzx/3qg2m/qbG1/323TA8QoRnVV26JSvDxrfWzSHy2cmGTaksAjJjZ+
         ewRf855uL+KP7G0IqUEtLThc+6daNJ/ne/69aTy2Qd6ejx6j7mUIxSgiA1/4XBFBIYUH
         wJJL6sRAcMGMUAFqPDpUh2/EojphLDieOXx8tJDo9CB94iikE1PLiWlPfmdwknsVcUTU
         CR+RGeMWvMD+L9fkWvy0+s/PDZsCRX4AHIjEa5h2OvM05CC+j78a7nLKLbNezum0aJAM
         Ed+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725429157; x=1726033957;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IpIJEb+RbBNCQx9hDO51spdk1MhZBEgZyMyfLVhshic=;
        b=gF3rNTjfb7xJu1/kOl3EnsJzy+6hB+y852hKnCYgrELRbCNksIAb2Lqqsawfnt1mlM
         WLTqV4sDNxkt4iR81UmvqSTCBIUi+W7cW/zQbtOne3DkL2+bIUskd2tMEsROKCkAANR7
         aBcAOdL4lVXshd/FfszKdNBFi8SYsL7/PFyevePQlQvOndZU+fsG5SunSiyS5Bcia3SK
         BO5GlJzR2qQbP4zMBiCoQist51j7ayb6ICtNchxQxj7167/x9Na/iCNusZo+vOiDRwYI
         e3RGo3kjffg2TXpeOYR1zBZYaPw6EMhG/YRqoeOp6Im0cOjIY302j3gbhDTNyc8seQPn
         s3rA==
X-Forwarded-Encrypted: i=1; AJvYcCUDite8GgQeCum3Q9y1bmWHblAIGPX0ocdcTybRIMH+FKcrHErQxIqKHNs06u5sA6xCuTNHyls=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5UxlE0IT0sXGWJ83a+FKCD+MxEm2ShnEVqKon8J7IpQMmEjt7
	bswRRLZf53BOlOTsSKXWr/VbnJIW/1zViY/xKI2OBPNPih7Dubtyw7GIud0rdEX0Sku+RFCV6Rt
	RHYG7NhPo+RGSIjlJYgq1w6gfx4dLWJckfbTY
X-Google-Smtp-Source: AGHT+IH62oGoBKuW4iEeNyAKqt0Puk7uw2vbSjLqVfa5GmkN69wBFkG5LIwqaSXoemGgsERtkEOnxJQq73DNowryoL4=
X-Received: by 2002:a19:f611:0:b0:535:68b2:9589 with SMTP id
 2adb3069b0e04-53568b29744mr12733e87.2.1725429156307; Tue, 03 Sep 2024
 22:52:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240828181011.1591242-1-namangulati@google.com> <ZtBQLqqMrpCLBMw1@LQ3V64L9R2>
In-Reply-To: <ZtBQLqqMrpCLBMw1@LQ3V64L9R2>
From: Naman Gulati <namangulati@google.com>
Date: Tue, 3 Sep 2024 22:52:25 -0700
Message-ID: <CAMP57yW99Y+CS+h_bayj_hBfoGQE+bdfVHuwfHZ3q+KueTS+iw@mail.gmail.com>
Subject: Re: [PATCH] Add provision to busyloop for events in ep_poll.
To: Joe Damato <jdamato@fastly.com>, Naman Gulati <namangulati@google.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, netdev@vger.kernel.org, 
	Stanislav Fomichev <sdf@fomichev.me>, linux-kernel@vger.kernel.org, skhawaja@google.com, 
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>, mkarsten@uwaterloo.ca
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks all for the comments and apologies for the delay in replying.
Stan and Joe I=E2=80=99ve addressed some of the common concerns below.

On Thu, Aug 29, 2024 at 3:40=E2=80=AFAM Joe Damato <jdamato@fastly.com> wro=
te:
>
> On Wed, Aug 28, 2024 at 06:10:11PM +0000, Naman Gulati wrote:
> > NAPI busypolling in ep_busy_loop loops on napi_poll and checks for new
> > epoll events after every napi poll. Checking just for epoll events in a
> > tight loop in the kernel context delivers latency gains to applications
> > that are not interested in napi busypolling with epoll.
> >
> > This patch adds an option to loop just for new events inside
> > ep_busy_loop, guarded by the EPIOCSPARAMS ioctl that controls epoll nap=
i
> > busypolling.
>
> This makes an API change, so I think that linux-api@vger.kernel.org
> needs to be CC'd ?
>
> > A comparison with neper tcp_rr shows that busylooping for events in
> > epoll_wait boosted throughput by ~3-7% and reduced median latency by
> > ~10%.
> >
> > To demonstrate the latency and throughput improvements, a comparison wa=
s
> > made of neper tcp_rr running with:
> >     1. (baseline) No busylooping
>
> Is there NAPI-based steering to threads via SO_INCOMING_NAPI_ID in
> this case? More details, please, on locality. If there is no
> NAPI-based flow steering in this case, perhaps the improvements you
> are seeing are a result of both syscall overhead avoidance and data
> locality?
>

The benchmarks were run with no NAPI steering.

Regarding syscall overhead, I reproduced the above experiment with
mitigations=3Doff
and found similar results as above. Pointing to the fact that the
above gains are
materialized from more than just avoiding syscall overhead.

By locality are you referring to numa locality?

> >     2. (epoll busylooping) enabling the epoll busy looping on all epoll
> >     fd's
>
> This is the case you've added, event_poll_only ? It seems like in
> this case you aren't busy looping exactly, you are essentially
> allowing IRQ/softIRQ to drive processing and checking on wakeup that
> events are available.
>
> IMHO, I'm not sure if "epoll busylooping" is an appropriate
> description.
>

I see your point, perhaps "spinning" or just =E2=80=9Clooping=E2=80=9D coul=
d be a closer word?

> >     3. (userspace busylooping) looping on epoll_wait in userspace
> >     with timeout=3D0
>
> Same question as Stanislav; timeout=3D0 should get ep_loop to transfer
> events immediately (if there are any) and return without actually
> invoking busy poll. So, it would seem that your ioctl change
> shouldn't be necessary since the equivalent behavior is already
> possible with timeout=3D0.
>
> I'd probably investigate both syscall overhead and data locality
> before approving this patch because it seems a bit suspicious to me.
>
> >
> > Stats for two machines with 100Gbps NICs running tcp_rr with 5 threads
> > and varying flows:
> >
> > Type                Flows   Throughput             Latency (=CE=BCs)
> >                              (B/s)      P50   P90    P99   P99.9   P99.=
99
> > baseline            15            272145      57.2  71.9   91.4  100.6 =
  111.6
> > baseline            30            464952      66.8  78.8   98.1  113.4 =
  122.4
> > baseline            60            695920      80.9  118.5  143.4 161.8 =
  174.6
> > epoll busyloop      15            301751      44.7  70.6   84.3  95.4  =
  106.5
> > epoll busyloop      30            508392      58.9  76.9   96.2  109.3 =
  118.5
> > epoll busyloop      60            745731      77.4  106.2  127.5 143.1 =
  155.9
> > userspace busyloop  15            279202      55.4  73.1   85.2  98.3  =
  109.6
> > userspace busyloop  30            472440      63.7  78.2   96.5  112.2 =
  120.1
> > userspace busyloop  60            720779      77.9  113.5  134.9 152.6 =
  165.7
> >
> > Per the above data epoll busyloop outperforms baseline and userspace
> > busylooping in both throughput and latency. As the density of flows per
> > thread increased, the median latency of all three epoll mechanisms
> > converges. However epoll busylooping is better at capturing the tail
> > latencies at high flow counts.
> >
> > Signed-off-by: Naman Gulati <namangulati@google.com>
> > ---
> >  fs/eventpoll.c                 | 53 ++++++++++++++++++++++++++--------
> >  include/uapi/linux/eventpoll.h |  3 +-
> >  2 files changed, 43 insertions(+), 13 deletions(-)
> >
> > diff --git a/fs/eventpoll.c b/fs/eventpoll.c
> > index f53ca4f7fcedd..6cba79261817a 100644
> > --- a/fs/eventpoll.c
> > +++ b/fs/eventpoll.c
> > @@ -232,7 +232,10 @@ struct eventpoll {
> >       u32 busy_poll_usecs;
> >       /* busy poll packet budget */
> >       u16 busy_poll_budget;
> > -     bool prefer_busy_poll;
> > +     /* prefer to busypoll in napi poll */
> > +     bool napi_prefer_busy_poll;
>
> Adding napi seems slightly redundant to me but I could be convinced eithe=
r
> way, I suppose.
>

With the two different polling booleans in the struct, I felt it's
better to be explicit
about the scope of each.

> > +     /* avoid napi poll when busy looping and poll only for events */
> > +     bool event_poll_only;
>
> I'm not sure about this overall; this isn't exactly what I think of
> when I think about the word "polling" but maybe I'm being too
> nit-picky.
>

I'm not sure how else to categorize the operation, is there some other phra=
sing
you'd recommend?

> >  #endif
> >
> >  #ifdef CONFIG_DEBUG_LOCK_ALLOC
> > @@ -430,6 +433,24 @@ static bool ep_busy_loop_end(void *p, unsigned lon=
g start_time)
> >       return ep_events_available(ep) || busy_loop_ep_timeout(start_time=
, ep);
> >  }
> >
> > +/**
> > + * ep_event_busy_loop - loop until events available or busy poll
> > + * times out.
> > + *
> > + * @ep: Pointer to the eventpoll context.
> > + *
> > + * Return: true if events available, false otherwise.
> > + */
> > +static bool ep_event_busy_loop(struct eventpoll *ep)
> > +{
> > +     unsigned long start_time =3D busy_loop_current_time();
> > +
> > +     while (!ep_busy_loop_end(ep, start_time))
> > +             cond_resched();
> > +
> > +     return ep_events_available(ep);
> > +}
> > +
> >  /*
> >   * Busy poll if globally on and supporting sockets found && no events,
> >   * busy loop will return if need_resched or ep_events_available.
> > @@ -440,23 +461,29 @@ static bool ep_busy_loop(struct eventpoll *ep, in=
t nonblock)
> >  {
> >       unsigned int napi_id =3D READ_ONCE(ep->napi_id);
> >       u16 budget =3D READ_ONCE(ep->busy_poll_budget);
> > -     bool prefer_busy_poll =3D READ_ONCE(ep->prefer_busy_poll);
> > +     bool event_poll_only =3D READ_ONCE(ep->event_poll_only);
> >
> >       if (!budget)
> >               budget =3D BUSY_POLL_BUDGET;
> >
> > -     if (napi_id >=3D MIN_NAPI_ID && ep_busy_loop_on(ep)) {
> > +     if (!ep_busy_loop_on(ep))
> > +             return false;
> > +
> > +     if (event_poll_only) {
> > +             return ep_event_busy_loop(ep);
> > +     } else if (napi_id >=3D MIN_NAPI_ID) {
> > +             bool napi_prefer_busy_poll =3D READ_ONCE(ep->napi_prefer_=
busy_poll);
> > +
> >               napi_busy_loop(napi_id, nonblock ? NULL : ep_busy_loop_en=
d,
> > -                            ep, prefer_busy_poll, budget);
> > +                             ep, napi_prefer_busy_poll, budget);
> >               if (ep_events_available(ep))
> >                       return true;
> >               /*
> > -              * Busy poll timed out.  Drop NAPI ID for now, we can add
> > -              * it back in when we have moved a socket with a valid NA=
PI
> > -              * ID onto the ready list.
> > -              */
> > +             * Busy poll timed out.  Drop NAPI ID for now, we can add
> > +             * it back in when we have moved a socket with a valid NAP=
I
> > +             * ID onto the ready list.
> > +             */
> >               ep->napi_id =3D 0;
> > -             return false;
> >       }
> >       return false;
> >  }
> > @@ -523,13 +550,15 @@ static long ep_eventpoll_bp_ioctl(struct file *fi=
le, unsigned int cmd,
> >
> >               WRITE_ONCE(ep->busy_poll_usecs, epoll_params.busy_poll_us=
ecs);
> >               WRITE_ONCE(ep->busy_poll_budget, epoll_params.busy_poll_b=
udget);
> > -             WRITE_ONCE(ep->prefer_busy_poll, epoll_params.prefer_busy=
_poll);
> > +             WRITE_ONCE(ep->napi_prefer_busy_poll, epoll_params.prefer=
_busy_poll);
> > +             WRITE_ONCE(ep->event_poll_only, epoll_params.event_poll_o=
nly);
> >               return 0;
> >       case EPIOCGPARAMS:
> >               memset(&epoll_params, 0, sizeof(epoll_params));
> >               epoll_params.busy_poll_usecs =3D READ_ONCE(ep->busy_poll_=
usecs);
> >               epoll_params.busy_poll_budget =3D READ_ONCE(ep->busy_poll=
_budget);
> > -             epoll_params.prefer_busy_poll =3D READ_ONCE(ep->prefer_bu=
sy_poll);
> > +             epoll_params.prefer_busy_poll =3D READ_ONCE(ep->napi_pref=
er_busy_poll);
> > +             epoll_params.event_poll_only =3D READ_ONCE(ep->event_poll=
_only);
> >               if (copy_to_user(uarg, &epoll_params, sizeof(epoll_params=
)))
> >                       return -EFAULT;
> >               return 0;
> > @@ -2203,7 +2232,7 @@ static int do_epoll_create(int flags)
> >  #ifdef CONFIG_NET_RX_BUSY_POLL
> >       ep->busy_poll_usecs =3D 0;
> >       ep->busy_poll_budget =3D 0;
> > -     ep->prefer_busy_poll =3D false;
> > +     ep->napi_prefer_busy_poll =3D false;
> >  #endif
>
> Just FYI: This is going to conflict with a patch I've sent to VFS
> that hasn't quite made its way back to net-next just yet.
>
> https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git/commit/?h=3Dv=
fs.misc&id=3D4eb76c5d9a8851735fd3ec5833ecf412e8921655
>

Acknowledged.

> >       ep->file =3D file;
> >       fd_install(fd, file);
> > diff --git a/include/uapi/linux/eventpoll.h b/include/uapi/linux/eventp=
oll.h
> > index 4f4b948ef3811..3bc0f4eed976c 100644
> > --- a/include/uapi/linux/eventpoll.h
> > +++ b/include/uapi/linux/eventpoll.h
> > @@ -89,9 +89,10 @@ struct epoll_params {
> >       __u32 busy_poll_usecs;
> >       __u16 busy_poll_budget;
> >       __u8 prefer_busy_poll;
> > +     __u8 event_poll_only:1;
> >
> >       /* pad the struct to a multiple of 64bits */
> > -     __u8 __pad;
> > +     __u8 __pad:7;
> >  };
>
> If the above is accepted then a similar change should make its way
> into glibc, uclibc-ng, and musl. It might be easier to add an
> entirely new ioctl.

Adding a new ioctl seems preferable, I can look into reworking the
code accordingly.

>
> All the above said: I'm not sure I'm convinced yet and having more
> clear data, descriptions, and answers on locality/syscall overhead
> would be very helpful.
>
> In the future, add 'net-next' to the subject line so that this
> targets the right tree:
>    [PATCH net-next] subject-line
>

Will do, thank you for the pointer.

> - Joe

