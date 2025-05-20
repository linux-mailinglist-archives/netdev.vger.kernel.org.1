Return-Path: <netdev+bounces-191687-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 04893ABCC06
	for <lists+netdev@lfdr.de>; Tue, 20 May 2025 02:34:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 05B861B62587
	for <lists+netdev@lfdr.de>; Tue, 20 May 2025 00:34:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CEFA253F2B;
	Tue, 20 May 2025 00:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qrNo8m9F"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B09831DA62E
	for <netdev@vger.kernel.org>; Tue, 20 May 2025 00:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747701261; cv=none; b=lltRN4y4aaFFc61qISd6gYsSi3HpELpCE1nZbHUUghkNIQk+Uemuk6+8mPZRcWDkpLiNjhAGFBFmZuE6GZJU4nJgOOXrygiKLHCG4jo7xykEzbJ+S0IL2asFOsYkQRZ8eDT/McB7iKbrt2T1wwbkmat23ZagWmNWOG14uWx2Tbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747701261; c=relaxed/simple;
	bh=kAf1PcSpspX8RUTqsPhTMt6aUXZC9WmHJinTWxESXdI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fvqFEX+nPDJ4kybSCpnzSS9Zip/6p8hnWuBs6NrL9BPu3N+5iGgaT/E2ZZi1tGqP1FYcG6LfZu681J5DGw2rrf8Dvre/L9iNPOVr9adDVGGkoq/hBqxi9u2d9e3v+pckhFtxlGC3NdmPKDl7aPZUClqrKGBF1akiwbFyk1fTCyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qrNo8m9F; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-48b7747f881so812971cf.1
        for <netdev@vger.kernel.org>; Mon, 19 May 2025 17:34:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747701256; x=1748306056; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QErx0UCmmloyqtOccQADJ/bldT2Mu/XEYjpPVXpqwCc=;
        b=qrNo8m9FRaLjitz18TTdRbp3ZiNbWygawLPTUDsQrGxqPNyr6MtL+td5AQlvjWN7Ph
         vcdPstH8VusUnV9PgmdsbRlhmDj4mGL17/VbH4Cu2m/g/CYXMegty7nTGBLB0dCh6jkh
         xYT5rerTaxAKPEI/26odQN/9P97tyBauhoj6E+mhzkC2VSPtsxRgortTBnuzJeNJVdsj
         wVqVaZZQbz/uejCcJ836tsIo6AEWqbd+LKWJnm3AgTjcoR5Wm5klo9N7lDfgFc61wzQ+
         RdX6PJwTrkUEclSD+vCseJqJyrMz+cq++04c7LoH0v1D5SvIQQIxiuTSxH0Veqn2cJOu
         Y42Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747701256; x=1748306056;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QErx0UCmmloyqtOccQADJ/bldT2Mu/XEYjpPVXpqwCc=;
        b=ds7ESUiXqktTx6IN2ZMbXoRA5MoGFJzt+zx1URD/i4r2L3ln9M57JRZe8XlFw+QN9I
         TpkETLNPbZmj7s4u+2DnPUgjXpWw4pYSvNiBO2VxAJ77JeaC13/lSLs7eQW/6h6oAsgt
         cfrk1Dc44MWKpPEn5EFRBeYLmLNEU2y+zSbMi600GgxFKbtLJhHBEG9xsEaLJbrHTora
         WSeTp9ZuU5iU+Tp2KlChluQVzuLBXngA6seYKIPgpiP7ZiZZ8QiJ6GVxQ0Oq/MAx7BVW
         YuO1o5oZiLfy9t3RpQwcc5ekOy44CU5bbf9EBXjItKefCc2+sPkLUeQGmsRQQxz2WOa6
         M2vg==
X-Forwarded-Encrypted: i=1; AJvYcCWRUkz0zRsq6MAxpAvLcYQbcvjtSNHAoMrHu2VVwAjVg9t7inxe3jrGygMpZoSrUbhvMfffGX4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOCzpHjBko+GP/7b4UD7recUcHlbw3tO2MNQA3FxKhUA6TaTVL
	nnj6Tav142AvTcE8Bc2Psc9YKpyGsuIiXD9D1C16eTKImN6A8fmkgnC6x8cXOgvKl+tu0Uzz8sk
	tVLudXnN270WSboSo86Cv+u8GB5i0FNHPyTKmM/Gs
X-Gm-Gg: ASbGncsnajg5T38qVxfnvaOVoKDa5Jvqd8x8KTLJ/AgSNFgUDqFdx4aPFzuePiHR5Fy
	Lmb55QryzUf3L/tT6N8cJrVatVR++dJy2BSmkzSGK6gSQsYpZJwSy03wwWb4Owodd4wTIbrn9QC
	33t4gMm1jfIXGmWwjT9zXufo1NXyYSdP3Iy4TInUIV9rYo
X-Google-Smtp-Source: AGHT+IGw9AUMdRcuCvEfy36x4US71FJ78bljXtTA2F10M0v2HGJAiKPYQzy33GiuBy73TUj0XczWZoMfLkfWDDKz+bw=
X-Received: by 2002:a05:622a:1828:b0:472:538:b795 with SMTP id
 d75a77b69052e-49595c5d5dfmr9429061cf.22.1747701256082; Mon, 19 May 2025
 17:34:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250519224325.3117279-1-skhawaja@google.com>
In-Reply-To: <20250519224325.3117279-1-skhawaja@google.com>
From: Wei Wang <weiwan@google.com>
Date: Mon, 19 May 2025 17:34:03 -0700
X-Gm-Features: AX0GCFtyPSFC47GqwjTfdOBTO09M0hgYuFuEmmbGjxLW4vGHo28XogEmz3xiWMo
Message-ID: <CAEA6p_AyVbAevnUFXpxo4OgNqmHe01qYs9x8jGDgVJwUbAAg4w@mail.gmail.com>
Subject: Re: [PATCH net-next v2] net: stop napi kthreads when THREADED napi is disabled
To: Samiullah Khawaja <skhawaja@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, almasrymina@google.com, 
	willemb@google.com, jdamato@fastly.com, mkarsten@uwaterloo.ca, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 19, 2025 at 3:43=E2=80=AFPM Samiullah Khawaja <skhawaja@google.=
com> wrote:
>
> Once the THREADED napi is disabled, the napi kthread should also be
> stopped. Keeping the kthread intact after disabling THREADED napi makes
> the PID of this kthread show up in the output of netlink 'napi-get' and
> ps -ef output.
>
> The is discussed in the patch below:
> https://lore.kernel.org/all/20250502191548.559cc416@kernel.org
>
> The napi THREADED state should be unset before stopping the thread. This
> makes sure that this napi will not be scheduled again for threaded
> polling (SCHED_THREADED). In the napi_thread_wait function we need to
> make sure that the SCHED_THREADED is not set before stopping. Once the
> SCHED_THREADED is unset it means that the napi kthread doesn't own this
> napi and it is safe to stop it.
>
> ____napi_schedule for threaded napi is also modified to make sure that
> the STATE_THREADED is not unset while we are setting SCHED_THREADED and
> waking up the napi kthread. If STATE_THREADED is unset while the
> threaded napi is being scheduled, the schedule code will recheck the
> STATE_THREADED to prevent wakeup of a stopped thread. Use try_cmpxchg to
> make sure the value of napi->state is not changed.
>
> Add a new test in nl_netdev to verify this behaviour.
>
> Tested:
>  ./tools/testing/selftests/net/nl_netdev.py
>  TAP version 13
>  1..6
>  ok 1 nl_netdev.empty_check
>  ok 2 nl_netdev.lo_check
>  ok 3 nl_netdev.page_pool_check
>  ok 4 nl_netdev.napi_list_check
>  ok 5 nl_netdev.dev_set_threaded
>  ok 6 nl_netdev.nsim_rxq_reset_down
>  # Totals: pass:6 fail:0 xfail:0 xpass:0 skip:0 error:0
>
> Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
> ---
>
> v2:
> - Handle the race where the STATE_THREADED is disabled and kthread is
>   stopped while the ____napi_schedule code has already checked the
>   STATE_THREADED and tries to wakeup napi kthread that is stopped.
>
>  net/core/dev.c                           | 77 +++++++++++++++++++-----
>  tools/testing/selftests/net/nl_netdev.py | 38 +++++++++++-
>  2 files changed, 98 insertions(+), 17 deletions(-)
>
> diff --git a/net/core/dev.c b/net/core/dev.c
> index d0563ddff6ca..52d173f5206c 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c
> @@ -4754,15 +4754,18 @@ int weight_p __read_mostly =3D 64;           /* o=
ld backlog weight */
>  int dev_weight_rx_bias __read_mostly =3D 1;  /* bias for backlog weight =
*/
>  int dev_weight_tx_bias __read_mostly =3D 1;  /* bias for output_queue qu=
ota */
>
> -/* Called with irq disabled */
> -static inline void ____napi_schedule(struct softnet_data *sd,
> -                                    struct napi_struct *napi)
> +static inline bool ____try_napi_schedule_threaded(struct softnet_data *s=
d,
> +                                                 struct napi_struct *nap=
i)
>  {
>         struct task_struct *thread;
> +       unsigned long new, val;
>
> -       lockdep_assert_irqs_disabled();
> +       do {
> +               val =3D READ_ONCE(napi->state);
> +
> +               if (!(val & NAPIF_STATE_THREADED))
> +                       return false;
>
> -       if (test_bit(NAPI_STATE_THREADED, &napi->state)) {
>                 /* Paired with smp_mb__before_atomic() in
>                  * napi_enable()/dev_set_threaded().
>                  * Use READ_ONCE() to guarantee a complete
> @@ -4770,17 +4773,30 @@ static inline void ____napi_schedule(struct softn=
et_data *sd,
>                  * wake_up_process() when it's not NULL.
>                  */
>                 thread =3D READ_ONCE(napi->thread);
> -               if (thread) {
> -                       if (use_backlog_threads() && thread =3D=3D raw_cp=
u_read(backlog_napi))
> -                               goto use_local_napi;
> +               if (!thread)
> +                       return false;
>
> -                       set_bit(NAPI_STATE_SCHED_THREADED, &napi->state);
> -                       wake_up_process(thread);
> -                       return;
> -               }
> -       }
> +               if (use_backlog_threads() &&
> +                   thread =3D=3D raw_cpu_read(backlog_napi))
> +                       return false;
> +
> +               new =3D val | NAPIF_STATE_SCHED_THREADED;
> +       } while (!try_cmpxchg(&napi->state, &val, new));
> +
> +       wake_up_process(thread);
> +       return true;
> +}
> +
> +/* Called with irq disabled */
> +static inline void ____napi_schedule(struct softnet_data *sd,
> +                                    struct napi_struct *napi)
> +{
> +       lockdep_assert_irqs_disabled();
> +
> +       /* try to schedule threaded napi if enabled */
> +       if (____try_napi_schedule_threaded(sd, napi))
> +               return;
>
> -use_local_napi:
>         list_add_tail(&napi->poll_list, &sd->poll_list);
>         WRITE_ONCE(napi->list_owner, smp_processor_id());
>         /* If not called from net_rx_action()
> @@ -6888,6 +6904,18 @@ static enum hrtimer_restart napi_watchdog(struct h=
rtimer *timer)
>         return HRTIMER_NORESTART;
>  }
>
> +static void dev_stop_napi_threads(struct net_device *dev)
> +{
> +       struct napi_struct *napi;
> +
> +       list_for_each_entry(napi, &dev->napi_list, dev_list) {
> +               if (napi->thread) {
> +                       kthread_stop(napi->thread);
> +                       napi->thread =3D NULL;
> +               }
> +       }
> +}
> +
>  int dev_set_threaded(struct net_device *dev, bool threaded)
>  {
>         struct napi_struct *napi;
> @@ -6926,6 +6954,15 @@ int dev_set_threaded(struct net_device *dev, bool =
threaded)
>         list_for_each_entry(napi, &dev->napi_list, dev_list)
>                 assign_bit(NAPI_STATE_THREADED, &napi->state, threaded);
>
> +       /* Calling kthread_stop on napi threads should be safe now as the
> +        * threaded state is disabled.
> +        */
> +       if (!threaded) {
> +               /* Make sure the state is set before stopping threads.*/
> +               smp_mb__before_atomic();

This should be smp_mb__after_atomic() right?

> +               dev_stop_napi_threads(dev);
> +       }
> +
>         return err;
>  }
>  EXPORT_SYMBOL(dev_set_threaded);
> @@ -7451,7 +7488,8 @@ static int napi_thread_wait(struct napi_struct *nap=
i)
>  {
>         set_current_state(TASK_INTERRUPTIBLE);
>
> -       while (!kthread_should_stop()) {
> +       /* Wait until we are scheduled or asked to stop. */
> +       while (true) {
>                 /* Testing SCHED_THREADED bit here to make sure the curre=
nt
>                  * kthread owns this napi and could poll on this napi.
>                  * Testing SCHED bit is not enough because SCHED bit migh=
t be
> @@ -7463,6 +7501,15 @@ static int napi_thread_wait(struct napi_struct *na=
pi)
>                         return 0;
>                 }
>
> +               /* Since the SCHED_THREADED is not set so this napi kthre=
ad does
> +                * not own this napi and it is safe to stop here. Checkin=
g the
> +                * SCHED_THREADED before stopping here makes sure that th=
is napi
> +                * was not scheduled again while napi threaded was being
> +                * disabled.
> +                */
> +               if (kthread_should_stop())
> +                       break;
> +
>                 schedule();
>                 set_current_state(TASK_INTERRUPTIBLE);
>         }
> diff --git a/tools/testing/selftests/net/nl_netdev.py b/tools/testing/sel=
ftests/net/nl_netdev.py
> index beaee5e4e2aa..c9109627a741 100755
> --- a/tools/testing/selftests/net/nl_netdev.py
> +++ b/tools/testing/selftests/net/nl_netdev.py
> @@ -2,8 +2,9 @@
>  # SPDX-License-Identifier: GPL-2.0
>
>  import time
> +from os import system
>  from lib.py import ksft_run, ksft_exit, ksft_pr
> -from lib.py import ksft_eq, ksft_ge, ksft_busy_wait
> +from lib.py import ksft_eq, ksft_ge, ksft_ne, ksft_busy_wait
>  from lib.py import NetdevFamily, NetdevSimDev, ip
>
>
> @@ -34,6 +35,39 @@ def napi_list_check(nf) -> None:
>                  ksft_eq(len(napis), 100,
>                          comment=3Df"queue count after reset queue {q} mo=
de {i}")
>
> +def dev_set_threaded(nf) -> None:
> +    """
> +    Test that verifies various cases of napi threaded
> +    set and unset at device level using sysfs.
> +    """
> +    with NetdevSimDev(queue_count=3D2) as nsimdev:
> +        nsim =3D nsimdev.nsims[0]
> +
> +        ip(f"link set dev {nsim.ifname} up")
> +
> +        napis =3D nf.napi_get({'ifindex': nsim.ifindex}, dump=3DTrue)
> +        ksft_eq(len(napis), 2)
> +
> +        napi0_id =3D napis[0]['id']
> +        napi1_id =3D napis[1]['id']
> +
> +        # set threaded
> +        system(f"echo 1 > /sys/class/net/{nsim.ifname}/threaded")
> +
> +        # check napi threaded is set for both napis
> +        napi0 =3D nf.napi_get({'id': napi0_id})
> +        ksft_ne(napi0.get('pid'), None)
> +        napi1 =3D nf.napi_get({'id': napi1_id})
> +        ksft_ne(napi1.get('pid'), None)
> +
> +        # unset threaded
> +        system(f"echo 0 > /sys/class/net/{nsim.ifname}/threaded")
> +
> +        # check napi threaded is unset for both napis
> +        napi0 =3D nf.napi_get({'id': napi0_id})
> +        ksft_eq(napi0.get('pid'), None)
> +        napi1 =3D nf.napi_get({'id': napi1_id})
> +        ksft_eq(napi1.get('pid'), None)
>
>  def nsim_rxq_reset_down(nf) -> None:
>      """
> @@ -122,7 +156,7 @@ def page_pool_check(nf) -> None:
>  def main() -> None:
>      nf =3D NetdevFamily()
>      ksft_run([empty_check, lo_check, page_pool_check, napi_list_check,
> -              nsim_rxq_reset_down],
> +              dev_set_threaded, nsim_rxq_reset_down],
>               args=3D(nf, ))
>      ksft_exit()
>
>
> base-commit: b65999e7238e6f2a48dc77c8c2109c48318ff41b
> --
> 2.49.0.1101.gccaa498523-goog
>

