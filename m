Return-Path: <netdev+bounces-41171-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BCC6D7CA0BF
	for <lists+netdev@lfdr.de>; Mon, 16 Oct 2023 09:36:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 28F90B20CEE
	for <lists+netdev@lfdr.de>; Mon, 16 Oct 2023 07:36:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C139168D0;
	Mon, 16 Oct 2023 07:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="A5jCAIPT"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E200D15AE6
	for <netdev@vger.kernel.org>; Mon, 16 Oct 2023 07:36:36 +0000 (UTC)
Received: from mail-vs1-xe2f.google.com (mail-vs1-xe2f.google.com [IPv6:2607:f8b0:4864:20::e2f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C11C7D9
	for <netdev@vger.kernel.org>; Mon, 16 Oct 2023 00:36:34 -0700 (PDT)
Received: by mail-vs1-xe2f.google.com with SMTP id ada2fe7eead31-457bac7c3f5so1586214137.2
        for <netdev@vger.kernel.org>; Mon, 16 Oct 2023 00:36:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697441794; x=1698046594; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=THb+AjJq57EQO0I6/2CvYDrwJ5gGh/j3ZWSQgme6FCo=;
        b=A5jCAIPTZWmSrlGYPNj7AaNYqB8FFBTrlyxMtZjXH3dAqb4kN5YuYdIzYfhURqvtOZ
         VbZ+jibaTXrU216FECS1W8bTfmTmQtQYxvhsqMfCQZ5xxuE5EkLdgkIHlu0MxopUnPvg
         vqxywVCyuhemQZYjPVatMf08QeTJsDIVD+IJCdUbfuHljQoZzqfC0suTv5O7y56CvQ0V
         5x20+QB5jnBX3uZfzSYGiTds/8wijyk2uBSB8jlhW34foBO50ovRaNnn7112AfJk0DnD
         Nq2krDbs7azuDl48jyvow5uC8GIySU9G2c/79XVTr4SOxdDHaA1i139vnu/RpXkBMs2S
         RbOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697441794; x=1698046594;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=THb+AjJq57EQO0I6/2CvYDrwJ5gGh/j3ZWSQgme6FCo=;
        b=WTcs/IkiDagOHeUVzbxehYKe8ORygLffjFoRB1MucV8fmG06NTRG9shjBPBiYDfjEz
         5AVs4mrOjZSLqfYf5Up52XPVi8CICjCqU6BuDinyLX7JniWNblnyi+9hXKy0xs0ljaDp
         k3Pwxc3pm21GSVSZsxejMwTb7yNghGUszj9HIIPx2+pOk/yjOey8+/4OKYCz46Fku8bt
         APYy/RYWF+QuEr/Z86A8pFE2+1cdF4Va9iVVV0/cO5QIAFs9HyzQgbz06x6Oyo89ejV2
         F2KOnofeqFmZ9vp3u/MhGSJqu12ii5ceeKj23QkV/KiBiYGrjxJw+FsDX4zhbf51iPT3
         JaOg==
X-Gm-Message-State: AOJu0YzSXCiNSDZu0jhhePRAOWDrEP7wFX5VxOk5jADC4hgfJbOvfwXp
	92xwHqXGc60ty4cxH13fBdxQQ0hC9dOjggGvYItonw==
X-Google-Smtp-Source: AGHT+IGezCOViaHQrTa9N2GliVGZzTlX1ZWz7q5Ntu81SHxUpcquVbyJrM5rNKEX3sk8cTH6AF4QASaQx+y2FKvtnA4=
X-Received: by 2002:a05:6102:23f5:b0:457:c725:4bdb with SMTP id
 p21-20020a05610223f500b00457c7254bdbmr7218817vsc.28.1697441793768; Mon, 16
 Oct 2023 00:36:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231014031257.178630-1-mirsad.todorovac@alu.unizg.hr> <20231014031257.178630-3-mirsad.todorovac@alu.unizg.hr>
In-Reply-To: <20231014031257.178630-3-mirsad.todorovac@alu.unizg.hr>
From: Marco Elver <elver@google.com>
Date: Mon, 16 Oct 2023 09:35:57 +0200
Message-ID: <CANpmjNMsct0Y6j3Q1A0+_z6Zuy86SceRAzRn_iVqr0kaX5+Kfw@mail.gmail.com>
Subject: Re: [PATCH v1 3/3] r8169: fix the KCSAN reported data race in rtl_rx
 while reading desc->opts1
To: Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>
Cc: Heiner Kallweit <hkallweit1@gmail.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, nic_swsd@realtek.com, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Sat, 14 Oct 2023 at 05:16, Mirsad Goran Todorovac
<mirsad.todorovac@alu.unizg.hr> wrote:
>
> KCSAN reported the following data-race bug:
>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> BUG: KCSAN: data-race in rtl8169_poll (drivers/net/ethernet/realtek/r8169=
_main.c:4430 drivers/net/ethernet/realtek/r8169_main.c:4583) r8169
>
> race at unknown origin, with read to 0xffff888117e43510 of 4 bytes by int=
errupt on cpu 21:
> rtl8169_poll (drivers/net/ethernet/realtek/r8169_main.c:4430 drivers/net/=
ethernet/realtek/r8169_main.c:4583) r8169
> __napi_poll (net/core/dev.c:6527)
> net_rx_action (net/core/dev.c:6596 net/core/dev.c:6727)
> __do_softirq (kernel/softirq.c:553)
> __irq_exit_rcu (kernel/softirq.c:427 kernel/softirq.c:632)
> irq_exit_rcu (kernel/softirq.c:647)
> sysvec_apic_timer_interrupt (arch/x86/kernel/apic/apic.c:1074 (discrimina=
tor 14))
> asm_sysvec_apic_timer_interrupt (./arch/x86/include/asm/idtentry.h:645)
> cpuidle_enter_state (drivers/cpuidle/cpuidle.c:291)
> cpuidle_enter (drivers/cpuidle/cpuidle.c:390)
> call_cpuidle (kernel/sched/idle.c:135)
> do_idle (kernel/sched/idle.c:219 kernel/sched/idle.c:282)
> cpu_startup_entry (kernel/sched/idle.c:378 (discriminator 1))
> start_secondary (arch/x86/kernel/smpboot.c:210 arch/x86/kernel/smpboot.c:=
294)
> secondary_startup_64_no_verify (arch/x86/kernel/head_64.S:433)
>
> value changed: 0x80003fff -> 0x3402805f
>
> Reported by Kernel Concurrency Sanitizer on:
> CPU: 21 PID: 0 Comm: swapper/21 Tainted: G             L     6.6.0-rc2-kc=
san-00143-gb5cbe7c00aa0 #41
> Hardware name: ASRock X670E PG Lightning/X670E PG Lightning, BIOS 1.21 04=
/26/2023
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> drivers/net/ethernet/realtek/r8169_main.c:
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>    4429
>  =E2=86=92 4430                 status =3D le32_to_cpu(desc->opts1);
>    4431                 if (status & DescOwn)
>    4432                         break;
>    4433
>    4434                 /* This barrier is needed to keep us from reading
>    4435                  * any other fields out of the Rx descriptor unti=
l
>    4436                  * we know the status of DescOwn
>    4437                  */
>    4438                 dma_rmb();
>    4439
>    4440                 if (unlikely(status & RxRES)) {
>    4441                         if (net_ratelimit())
>    4442                                 netdev_warn(dev, "Rx ERROR. statu=
s =3D %08x\n",
>
> Marco Elver explained that dma_rmb() doesn't prevent the compiler to tear=
 up the access to
> desc->opts1 which can be written to concurrently. READ_ONCE() should prev=
ent that from
> happening:
>
>    4429
>  =E2=86=92 4430                 status =3D le32_to_cpu(READ_ONCE(desc->op=
ts1));
>    4431                 if (status & DescOwn)
>    4432                         break;
>    4433
>
> As the consequence of this fix, this KCSAN warning was eliminated.
>
> Fixes: 6202806e7c03a ("r8169: drop member opts1_mask from struct rtl8169_=
private")
> Suggested-by: Marco Elver <elver@google.com>
> Cc: Heiner Kallweit <hkallweit1@gmail.com>
> Cc: nic_swsd@realtek.com
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Eric Dumazet <edumazet@google.com>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: Paolo Abeni <pabeni@redhat.com>
> Cc: netdev@vger.kernel.org
> Link: https://lore.kernel.org/lkml/dc7fc8fa-4ea4-e9a9-30a6-7c83e6b53188@a=
lu.unizg.hr/
> Signed-off-by: Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>
>
> Signed-off-by: Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>

Double sign-off? Otherwise,

Acked-by: Marco Elver <elver@google.com>

> ---
>  drivers/net/ethernet/realtek/r8169_main.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethe=
rnet/realtek/r8169_main.c
> index 281aaa851847..81be6085a480 100644
> --- a/drivers/net/ethernet/realtek/r8169_main.c
> +++ b/drivers/net/ethernet/realtek/r8169_main.c
> @@ -4427,7 +4427,7 @@ static int rtl_rx(struct net_device *dev, struct rt=
l8169_private *tp, int budget
>                 dma_addr_t addr;
>                 u32 status;
>
> -               status =3D le32_to_cpu(desc->opts1);
> +               status =3D le32_to_cpu(READ_ONCE(desc->opts1));
>                 if (status & DescOwn)
>                         break;
>
> --
> 2.34.1
>

