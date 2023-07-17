Return-Path: <netdev+bounces-18149-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA92E7559A2
	for <lists+netdev@lfdr.de>; Mon, 17 Jul 2023 04:35:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC5C51C209C8
	for <lists+netdev@lfdr.de>; Mon, 17 Jul 2023 02:35:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A399E10ED;
	Mon, 17 Jul 2023 02:35:43 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 915C9A23
	for <netdev@vger.kernel.org>; Mon, 17 Jul 2023 02:35:43 +0000 (UTC)
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46F6FBA
	for <netdev@vger.kernel.org>; Sun, 16 Jul 2023 19:35:38 -0700 (PDT)
Received: by mail-qv1-xf30.google.com with SMTP id 6a1803df08f44-634a3682c25so28215636d6.3
        for <netdev@vger.kernel.org>; Sun, 16 Jul 2023 19:35:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689561337; x=1692153337;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3t80ZQsYOVYzs2Mc0+EyixJB/2dayX+KrnHe0ewRiAw=;
        b=MoJ76flogaJ7ti0Z3weDs8t9K7nXzj7C/9rL2Vx2o0IxFiDjaZLZwEe0APVCeOH+h6
         z0p83Jp3dml9dZ5P8qMZX037Ixxuy5PUgM0bHXbkiFNvKG+/YAc3lvblpTFIU3DKIIhL
         bO+oH1StbvjVpti8e0cgYOeVqEkOXUEYMEvpOrgD8qsPsPGo3lof48F611wkjCqYDJSJ
         EjMbrfxfqY/SPzDmi4uy5Bod2ZloGZYJQ7zI6UucCk75ihWO+hikkFQt77flLvl5Knq3
         ToxK+skQmrro/Tduyv6+lvBXVLjH+QBMAGY9PNVIQwt0fim3mDwMLiZI9ClrpSKFNGzw
         x1jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689561337; x=1692153337;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3t80ZQsYOVYzs2Mc0+EyixJB/2dayX+KrnHe0ewRiAw=;
        b=dR1URC5S8nBeh7SfvYLt2NapwBwatRWXhyYRk5fGCOhzyC64S+DU2nZP4L65fT6Wyo
         JLEn0366hhP97VLB5PM+kLsg/POUgf7TYD2/Y4cQ15wFhEenM+MXNHROyZdeynbz8P7o
         1ZLZzogx8Kzm+7tBm4beTF7sJMBTKmlSF61ykCR3S1jL36ZTSjU0YI3TRsTFN1zMQr5u
         eRQ+WcqOGFtbt/zhen3kFe9L97RRmgb8xioLtYDkB5Fr8p5h1tIqeoqDgYb9aqRdvomB
         VK98HjN6p3IaDRH9QGittdXBprG6Nh84ezSud/yhE271PZkmVRoY4WGN6hwIHVwgAA0k
         R3Bg==
X-Gm-Message-State: ABy/qLbTi9BRHN7Q50SjLRwp1JwlnubBfT52XhTJ3+lBtgZat/Xu/Mto
	7wV6KQ7Zibr04Bhbeumk/e5it+1SjhVJx5tg3QEoeM63DUI=
X-Google-Smtp-Source: APBJJlFsUaxQ6VP+YjbPVBe55PSI4Hr800Cxl0IfCzimOASgxhuYftwDics2zRdy68qDNQGk2awDXRWMKy/t42OVEmQ=
X-Received: by 2002:a05:622a:2c6:b0:403:6ac5:e761 with SMTP id
 a6-20020a05622a02c600b004036ac5e761mr16220866qtx.62.1689561337215; Sun, 16
 Jul 2023 19:35:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAL87dS2SS9rjLUPnwufh9a0O-Cu-hMAUU7Xa534mXTB9v=KM5g@mail.gmail.com>
 <CAL87dS1Cvbxczdyk_2nviC=M2S91bMRKPXrkp1PLHXFuX=CuKg@mail.gmail.com>
 <Y3GZAEFaO2zp5SbJ@pop-os.localdomain> <CAL87dS2XjE2f0+HJ4DH4zzQwz1K-LYQx0rV0t=sbs343pxar2Q@mail.gmail.com>
In-Reply-To: <CAL87dS2XjE2f0+HJ4DH4zzQwz1K-LYQx0rV0t=sbs343pxar2Q@mail.gmail.com>
From: mingkun bian <bianmingkun@gmail.com>
Date: Mon, 17 Jul 2023 10:35:26 +0800
Message-ID: <CAL87dS1XL832QXZsQWnA0i5H-_WKibwHJwHjh5W02i8U4Ndotw@mail.gmail.com>
Subject: Re: [ISSUE] suspicious sock leak
To: Cong Wang <xiyou.wangcong@gmail.com>
Cc: netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi,
    I have use cookie as key instead of sock*, then use lru map, it works o=
k.

    But now I basically confirmed the reason, There is a very small
probability that kprobe will fail come into kprobe handler in another
experiment about tcp timer.

    ftrace:
    trace_timer_expire_entry=E3=80=81trace_timer_expire_exit of call_timer_=
fn.
    trace_timer_start of debug_activate
    trace_timer_cancel of debug_deactivate

    Then I kprobe "call_timer_fn", there will be a small probability
that the timer has been executed, but the kprobe has not been
executed.
    There is a high probability that the stack will appear when the
kprobe hander(kprobe_ftrace_handler)  is interrupted by a hard
interrupt(irq_exit).


nginx-10064 [000] d.s. 154816.275735: timer_cancel: timer=3D00000000fb259de=
9
nginx-10064 [000] d.s. 154816.275743: <stack trace>
=3D> run_timer_softirq
=3D> __do_softirq
=3D> irq_exit
=3D> smp_apic_timer_interrupt
=3D> apic_timer_interrupt
=3D> trace_call_bpf
=3D> kprobe_perf_func
=3D> kprobe_ftrace_handler
=3D> ftrace_ops_assist_func
=3D> 0xffffffffc078a0bf
=3D> tcp_send_fin
=3D> tcp_close
=3D> inet_release
=3D> __sock_release
=3D> sock_close
=3D> __fput
=3D> task_work_run
=3D> exit_to_usermode_loop
=3D> do_syscall_64
=3D> entry_SYSCALL_64_after_hwframe
nginx-10064 [000] ..s. 154816.275744: timer_expire_entry:
timer=3D00000000fb259de9 function=3Dtcp_write_timer now=3D4449486051
nginx-10064 [000] ..s. 154816.275747: <stack trace>
=3D> call_timer_fn
=3D> run_timer_softirq
=3D> __do_softirq
=3D> irq_exit
=3D> smp_apic_timer_interrupt
=3D> apic_timer_interrupt
=3D> trace_call_bpf
=3D> kprobe_perf_func
=3D> kprobe_ftrace_handler
=3D> ftrace_ops_assist_func
=3D> 0xffffffffc078a0bf
=3D> tcp_send_fin
=3D> tcp_close
=3D> inet_release
=3D> __sock_release
=3D> sock_close
=3D> __fput
=3D> task_work_run
=3D> exit_to_usermode_loop
=3D> do_syscall_64
=3D> entry_SYSCALL_64_after_hwframe
nginx-10064 [000] ..s. 154816.275748: timer_expire_exit: timer=3D00000000fb=
259de9
nginx-10064 [000] ..s. 154816.275750: <stack trace>
=3D> call_timer_fn
=3D> run_timer_softirq
=3D> __do_softirq
=3D> irq_exit
=3D> smp_apic_timer_interrupt
=3D> apic_timer_interrupt
=3D> trace_call_bpf
=3D> kprobe_perf_func
=3D> kprobe_ftrace_handler
=3D> ftrace_ops_assist_func
=3D> 0xffffffffc078a0bf
=3D> tcp_send_fin
=3D> tcp_close
=3D> inet_release
=3D> __sock_release
=3D> sock_close
=3D> __fput
=3D> task_work_run
=3D> exit_to_usermode_loop
=3D> do_syscall_64
=3D> entry_SYSCALL_64_after_hwframe

    Thanks.




On Mon, 14 Nov 2022 at 13:39, mingkun bian <bianmingkun@gmail.com> wrote:
>
> Cong Wang <xiyou.wangcong@gmail.com> =E4=BA=8E2022=E5=B9=B411=E6=9C=8814=
=E6=97=A5=E5=91=A8=E4=B8=80 09:25=E5=86=99=E9=81=93=EF=BC=9A
> >
> > On Sun, Nov 13, 2022 at 06:22:22PM +0800, mingkun bian wrote:
> > > Hi,
> > >
> > > bpf map1:
> > > key: cookie
> > > value: addr daddr sport dport cookie sock*
> > >
> > > bpf map2:
> > > key: sock*
> > > value: addr daddr sport dport cookie sock*
> >
> > So none of them is sockmap? Why not use sockmap which takes care
> > of sock refcnt for you?
> >
> > >
> > > 1. Recv a "HTTP GET" request in user applicatoin
> > > map1.insert(cookie, value)
> > > map2.insert(sock*, value)
> > >
> > > 1. kprobe inet_csk_destroy_sock:
> > > sk->sk_wmem_queued is 0
> > > sk->sk_wmem_alloc is 4201
> > > sk->sk_refcnt is 2
> > > sk->__sk_common.skc_cookie is 173585924
> > > saddr daddr sport dport is 192.168.10.x 80
> > >
> > > 2. kprobe __sk_free
> > > can not find the "saddr daddr sport dport 192.168.10.x 80" in kprobe =
__sk_free
> > >
> > > 3. kprobe __sk_free
> > > after a while, "kprobe __sk_free" find the "saddr daddr sport dport
> > > 127.0.0.1 xx"' info
> > > value =3D map2.find(sock*)
> > > value1 =3D map1.find(sock->cookie)
> > > if (value) {
> > >     map2.delete(sock) //print value info, find "saddr daddr sport
> > > dport" is "192.168.10.x 80=E2=80=9C=EF=BC=8C and value->cookie is 173=
585924, which is
> > > the same as "192.168.10.x 80" 's cookie.
> > > }
> > >
> > > if (value1) {
> > >     map1.delete(sock->cookie)
> > > }
> > >
> > > Here is my test flow, commented lines represents that  sock of =E2=80=
=9Dsaddr
> > > daddr sport dport 192.168.10.x 80=E2=80=9C does not come in  __sk_fre=
e=EF=BC=8C but it
> > > is reused by =E2=80=9D saddr daddr sport dport 127.0.0.1 xx"
> >
> > I don't see this is a problem yet, the struct sock may be still referen=
ced
> > by the kernel even after you close its corresponding struct socket from
> > user-space. And TCP sockets have timewait too, so...
> >
> > I suggest you try sockmap to store sockets instead.
> >
> > Thanks.
>
> Hi,
>
> I do not use sockmap in this scenario.
>
> Traffic model is about 20Gbps external traffic and 80Gbps lo traffic,
> only external traffic can insert bpf map.
> The old sock will be reused only if the old sock exec "__sock_free"
> whether  referenced or not by the kernel, but my test result is not
> so.
> And TIME_WAIT state still release the sock immediately=EF=BC=8C then crea=
te
> tcp_timewait_sock instead of sock in function 'tcp_time_wait'.
>
> My kernel is 4.18.0.
>
> Thanks.

