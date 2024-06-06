Return-Path: <netdev+bounces-101288-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F5138FE07F
	for <lists+netdev@lfdr.de>; Thu,  6 Jun 2024 10:04:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 96EB1B210D0
	for <lists+netdev@lfdr.de>; Thu,  6 Jun 2024 08:04:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B82713AA31;
	Thu,  6 Jun 2024 08:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="e2SUbbKj"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4149F3A8CB
	for <netdev@vger.kernel.org>; Thu,  6 Jun 2024 08:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717661085; cv=none; b=GB9OJfO7CgBqHpqWSRLSMdFMey7OXUEU3SadDRwVeQyORMZqwfJz+t2uucBMiW5wlrIT3xC9Cd7TSnhGfGjvcPRfpyZ+FMlhetqVii3vNLHQHCYR2etXHLP3qUnBRyPfsjR7JUPhPk20iNOONtVrcMcUiopCq0Om7CMAE2HPo/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717661085; c=relaxed/simple;
	bh=g4c5psevZ4KTGnwayQMHLRHOtg2KtKX6R0GxlXxG5WI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=onxnSjFzthfr7hx5sMo1bZyYVSZNgznnrQgFYSv7XbJxhUJ9n+vXzckHXy+iwr08V6L4Jly0svowmbURMQ7OfZrt9FlWWiSCi4fs74DKgdyOidC5iKrM+i6ku469bbFgGI5irbsDAQczVfXvU7ZqA8BJnzxoCppmFQ6V9JtFLhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=e2SUbbKj; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-57a4ce82f30so788677a12.0
        for <netdev@vger.kernel.org>; Thu, 06 Jun 2024 01:04:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1717661081; x=1718265881; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P0oFG8bq7yHSKq/amXLj6YkSDfn5J6Mv84WGLZXEbSo=;
        b=e2SUbbKjihiAmgJzaV6cUHf2t4paIHZFcUB8y8xc9OH3Pr4KAoPCAWRlA8wbxHHa8T
         sNqeL68TsMcWwS7I7EBLW7jUcwV+9YdqHSNPRXFXOMR644FRNmVHxPvbYKpXwIo4A63M
         Ey5U5kwDr+2NgqXNCou3+akqcy/Z/WYNAx6tg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717661081; x=1718265881;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P0oFG8bq7yHSKq/amXLj6YkSDfn5J6Mv84WGLZXEbSo=;
        b=O2iMYF5AoAnXmcOXG0QAOhCuvZq94CxC1q5rJcWXaYOmk1wsx86zkn7iOvMumL4N3O
         U6KUdIY7ZxtTZDJdGrMv92K2vej9qqtHlySujFQIwxUvGgSvtkH2U8N8FsZMt+NgXuWW
         plTjv/GqtduF/VS/jY6YcXQB9wC5yQn1z1pNDFquO+eKyaOXslyqkaqAu7mOifbOsiho
         SqTyD+Fc5E/ouHdBgtRF/G4EG0UKIr2QP1m7kZR9rufrSdi5A881oc4QRxXu2HXtlfv2
         djcmbTFJke9GBcXQ+MnKytQGO7G+fppaqYqEFfAofh9dCZ68dn5DYkXbVkJ1O3/xYpDj
         i+9g==
X-Gm-Message-State: AOJu0YxsZEt0qUS1a/LitX46IyEeWPoNWsrgfuRW92eQu2yQS7EMKn/v
	ijKgsXHNMIwfs1U4rwz9SZGlYAvsS01F8KmASm10SMDihJd7Gz2mfJ85Vmw9AIHtMICK3GdSx8A
	=
X-Google-Smtp-Source: AGHT+IEG4b3JeVfjoFD8Ssv+vyc/ouWOTgekd7P7yS3/x42r1EHY8TvSsKpTnWbxA+yA5VELCT470A==
X-Received: by 2002:a50:d7de:0:b0:579:c08b:afa5 with SMTP id 4fb4d7f45d1cf-57a8bcb9532mr3677883a12.37.1717661081073;
        Thu, 06 Jun 2024 01:04:41 -0700 (PDT)
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com. [209.85.218.50])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57aae0ca2b0sm660409a12.30.2024.06.06.01.04.39
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Jun 2024 01:04:40 -0700 (PDT)
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a68a9a4e9a6so64873666b.3
        for <netdev@vger.kernel.org>; Thu, 06 Jun 2024 01:04:39 -0700 (PDT)
X-Received: by 2002:a17:906:c945:b0:a68:b839:485a with SMTP id
 a640c23a62f3a-a69a002ba4amr345395366b.77.1717661078546; Thu, 06 Jun 2024
 01:04:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230518072657.1.If9539da710217ed92e764cc0ba0f3d2d246a1aee@changeid>
 <5184214b-22ed-41cf-a1b0-6db2d4ff324c@gmx.net>
In-Reply-To: <5184214b-22ed-41cf-a1b0-6db2d4ff324c@gmx.net>
From: Ying Hsu <yinghsu@chromium.org>
Date: Thu, 6 Jun 2024 16:03:59 +0800
X-Gmail-Original-Message-ID: <CAAa9mD1HGJDKzoLoqZzyrR5wsk_6voWs+VmoZoo9ZontyvjUww@mail.gmail.com>
Message-ID: <CAAa9mD1HGJDKzoLoqZzyrR5wsk_6voWs+VmoZoo9ZontyvjUww@mail.gmail.com>
Subject: Re: [PATCH] igb: Fix igb_down hung on surprise removal
To: Stefan Schaeckeler <schaecsn@gmx.net>
Cc: netdev@vger.kernel.org, grundler@chromium.org, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Jesse Brandeburg <jesse.brandeburg@intel.com>, 
	Paolo Abeni <pabeni@redhat.com>, Tony Nguyen <anthony.l.nguyen@intel.com>, 
	intel-wired-lan@lists.osuosl.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On the CalDigit Thunderbolt Station 3 Plus, we've encountered an issue
when the USB downstream display connection state changes. The
problematic sequence observed is:
```
igb_io_error_detected
igb_down
igb_io_error_detected
igb_down
```

The second igb_down call blocks at napi_synchronize.
Simply avoiding redundant igb_down calls makes the Ethernet of the
thunderbolt dock unusable.

If Intel can identify when an Ethernet device is within a Thunderbolt
tunnel, the patch can be more specific.

On Thu, Jun 6, 2024 at 8:04=E2=80=AFAM Stefan Schaeckeler <schaecsn@gmx.net=
> wrote:
>
> Hi all,
>
> This commit introduced a regression. What does not work with this commit =
is an AER without a surprise removal event.
>
>
> On 5/18/23 00:26, Ying Hsu wrote:
> > In a setup where a Thunderbolt hub connects to Ethernet and a display
> > through USB Type-C, users may experience a hung task timeout when they
> > remove the cable between the PC and the Thunderbolt hub.
> > This is because the igb_down function is called multiple times when
> > the Thunderbolt hub is unplugged. For example, the igb_io_error_detecte=
d
> > triggers the first call, and the igb_remove triggers the second call.
> > The second call to igb_down will block at napi_synchronize.
> > Here's the call trace:
> >     __schedule+0x3b0/0xddb
> >     ? __mod_timer+0x164/0x5d3
> >     schedule+0x44/0xa8
> >     schedule_timeout+0xb2/0x2a4
> >     ? run_local_timers+0x4e/0x4e
> >     msleep+0x31/0x38
> >     igb_down+0x12c/0x22a [igb 6615058754948bfde0bf01429257eb59f13030d4]
> >     __igb_close+0x6f/0x9c [igb 6615058754948bfde0bf01429257eb59f13030d4=
]
> >     igb_close+0x23/0x2b [igb 6615058754948bfde0bf01429257eb59f13030d4]
> >     __dev_close_many+0x95/0xec
> >     dev_close_many+0x6e/0x103
> >     unregister_netdevice_many+0x105/0x5b1
> >     unregister_netdevice_queue+0xc2/0x10d
> >     unregister_netdev+0x1c/0x23
> >     igb_remove+0xa7/0x11c [igb 6615058754948bfde0bf01429257eb59f13030d4=
]
> >     pci_device_remove+0x3f/0x9c
> >     device_release_driver_internal+0xfe/0x1b4
> >     pci_stop_bus_device+0x5b/0x7f
> >     pci_stop_bus_device+0x30/0x7f
> >     pci_stop_bus_device+0x30/0x7f
> >     pci_stop_and_remove_bus_device+0x12/0x19
> >     pciehp_unconfigure_device+0x76/0xe9
> >     pciehp_disable_slot+0x6e/0x131
> >     pciehp_handle_presence_or_link_change+0x7a/0x3f7
> >     pciehp_ist+0xbe/0x194
> >     irq_thread_fn+0x22/0x4d
> >     ? irq_thread+0x1fd/0x1fd
> >     irq_thread+0x17b/0x1fd
> >     ? irq_forced_thread_fn+0x5f/0x5f
> >     kthread+0x142/0x153
> >     ? __irq_get_irqchip_state+0x46/0x46
> >     ? kthread_associate_blkcg+0x71/0x71
> >     ret_from_fork+0x1f/0x30
> >
> > In this case, igb_io_error_detected detaches the network interface
> > and requests a PCIE slot reset, however, the PCIE reset callback is
> > not being invoked and thus the Ethernet connection breaks down.
> > As the PCIE error in this case is a non-fatal one, requesting a
> > slot reset can be avoided.
> > This patch fixes the task hung issue and preserves Ethernet
> > connection by ignoring non-fatal PCIE errors.
> >
> > Signed-off-by: Ying Hsu <yinghsu@chromium.org>
> > ---
> > This commit has been tested on a HP Elite Dragonfly Chromebook and
> > a Caldigit TS3+ Thunderbolt hub. The Ethernet driver for the hub
> > is igb. Non-fatal PCIE errors happen when users hot-plug the cables
> > connected to the chromebook or to the external display.
> >
> >  drivers/net/ethernet/intel/igb/igb_main.c | 5 +++++
> >  1 file changed, 5 insertions(+)
> >
> > diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/et=
hernet/intel/igb/igb_main.c
> > index 58872a4c2540..a8b217368ca1 100644
> > --- a/drivers/net/ethernet/intel/igb/igb_main.c
> > +++ b/drivers/net/ethernet/intel/igb/igb_main.c
> > @@ -9581,6 +9581,11 @@ static pci_ers_result_t igb_io_error_detected(st=
ruct pci_dev *pdev,
> >       struct net_device *netdev =3D pci_get_drvdata(pdev);
> >       struct igb_adapter *adapter =3D netdev_priv(netdev);
> >
> > +     if (state =3D=3D pci_channel_io_normal) {
> > +             dev_warn(&pdev->dev, "Non-correctable non-fatal error rep=
orted.\n");
> > +             return PCI_ERS_RESULT_CAN_RECOVER;
> > +     }
> > +
> >       netif_device_detach(netdev);
> >
> >       if (state =3D=3D pci_channel_io_perm_failure)
>
> We are currently stuck with the 5.4 kernel - our embedded system can't ea=
sily boot arbitrary kernel versions. The igb driver code has not changed an=
d I'm quite positive the issue still persist in the latest upstream kernel.
>
> This issue is reproducible with aer_inject. 09:00.0 is our i210 which is =
directly connected to the cpu root port 00:01.1:
>
>
> - - - snip - - -
> [node0_RP0_CPU0:~]$cat aer.log
> AER
> PCI_ID 09:00.0
> UNCOR_STATUS COMP_TIME
> HEADER_LOG 0 1 2 3
> - - - snip - - -
>
> - - - snip - - -
> [node0_RP0_CPU0:~]$aer-inject aer.log
> [369145.900845] pcieport 0000:00:01.1: aer_inject: Injecting errors 00000=
000/00004000 into device 0000:09:00.0
> [369145.912726] pcieport 0000:00:01.1: AER: Uncorrected (Non-Fatal) error=
 received: 0000:09:00.0
> [369145.923124] igb 0000:09:00.0: AER: PCIe Bus Error: severity=3DUncorre=
cted (Non-Fatal), type=3DTransaction Layer, (Requester ID)
> [369145.936791] igb 0000:09:00.0: AER:   device [8086:1537] error status/=
mask=3D00004000/00000000
> [369145.947068] igb 0000:09:00.0: AER:    [14] CmpltTO
> [369145.954602] igb 0000:09:00.0: Non-correctable non-fatal error reporte=
d.
> [369145.984564] ------------[ cut here ]------------
> [369145.990285] kernel BUG at include/linux/netdevice.h:529!
> [369145.996860] invalid opcode: 0000 [#1] SMP PTI
> [369146.002267] CPU: 3 PID: 142 Comm: irq/26-aerdrv Kdump: loaded Tainted=
: G           O      5.4.251-yocto-standard #1
> [369146.015073] Hardware name: Cisco System Inc. SF-D8/Type2 - Board Prod=
uct Name1, BIOS 1-29-g46d9e72a-s 05/03/2019
> [369146.027570] RIP: 0010:igb_up+0x51/0x160 [igb]
> [369146.032974] Code: d2 eb 16 f0 80 60 60 fe f0 80 60 60 f7 48 83 c2 01 =
39 93 14 02 00 00 76 13 48 8b 84 d3 08 0f 00 00 48 8b 48 60 83 e1 01 75 d9 =
<0f> 0b f6 83 11 02 00 00 20 0f 85 c0 00 00 00 48 8b bb 08 0f 00 00
> [369146.055938] RSP: 0018:ffffb29b0045bcf0 EFLAGS: 00010246
> [369146.062399] RAX: ffff8d938d99e400 RBX: ffff8d9398a08740 RCX: 00000000=
00000000
> [369146.071186] RDX: 0000000000000000 RSI: 0000000000000004 RDI: ffff8d93=
8d99e2c0
> [369146.079974] RBP: ffffb29b0045bd00 R08: 00000000000002ec R09: ffffb29b=
002fa000
> [369146.088761] R10: 0000000000006f80 R11: 000000000090ef2c R12: ffff8d93=
98a08000
> [369146.097547] R13: ffff8d9398a08740 R14: ffff8d939ae92c00 R15: ffff8d93=
9ae92c28
> [369146.106335] FS:  0000000000000000(0000) GS:ffff8d939fcc0000(0000) knl=
GS:0000000000000000
> [369146.116286] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [369146.123381] CR2: 000056318eb418e8 CR3: 000000084e744002 CR4: 00000000=
003606e0
> [369146.132170] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 00000000=
00000000
> [369146.140960] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 00000000=
00000400
> [369146.149747] Call Trace:
> [369146.152826]  ? show_regs.cold+0x1a/0x1f
> [369146.157592]  ? __die+0x90/0xd9
> [369146.161408]  ? die+0x30/0x50
> [369146.165002]  ? do_trap+0x85/0xf0
> [369146.169029]  ? do_error_trap+0x7c/0xb0
> [369146.173695]  ? igb_up+0x51/0x160 [igb]
> [369146.178355]  ? do_invalid_op+0x3c/0x50
> [369146.183019]  ? igb_up+0x51/0x160 [igb]
> [369146.187681]  ? invalid_op+0x7c/0x90
> [369146.192027]  ? igb_up+0x51/0x160 [igb]
> [369146.196691]  ? hrtimer_try_to_cancel+0x2c/0x110
> [369146.202305]  ? schedule_hrtimeout_range_clock+0xa0/0x110
> [369146.208871]  ? hrtimer_init_sleeper+0x90/0x90
> [369146.214277]  ? igb_rx_fifo_flush_82575+0x32/0x270 [igb]
> [369146.220738]  ? igb_configure+0x417/0x650 [igb]
> [369146.226247]  ? igb_up+0x51/0x160 [igb]
> [369146.230913]  igb_io_resume+0x31/0x50 [igb]
> [369146.235998]  report_resume+0x5c/0x80
> [369146.240449]  ? pcie_portdrv_probe+0x70/0x70
> [369146.245631]  pci_walk_bus+0x75/0x90
> [369146.249966]  pcie_do_recovery+0x163/0x280
> [369146.254947]  aer_process_err_devices+0xa2/0xd1
> [369146.260455]  aer_isr.cold+0x52/0xa1
> [369146.264799]  ? __schedule+0x2bf/0x680
> [369146.269349]  ? irq_finalize_oneshot+0xf0/0xf0
> [369146.274754]  irq_thread_fn+0x28/0x50
> [369146.279205]  irq_thread+0xf8/0x180
> [369146.283445]  ? wake_threads_waitq+0x30/0x30
> [369146.288638]  kthread+0x104/0x140
> [369146.292666]  ? irq_thread_check_affinity+0x80/0x80
> [369146.298597]  ? __kthread_cancel_work+0x40/0x40
> [369146.304106]  ret_from_fork+0x35/0x40
> - - - snip - - -
>
> BUG_ON() comes from
>
> - - - snip - - -
> static inline void napi_enable(struct napi_struct *n)
> {
>         BUG_ON(!test_bit(NAPI_STATE_SCHED, &n->state));
>         smp_mb__before_atomic();
>         clear_bit(NAPI_STATE_SCHED, &n->state);
>         clear_bit(NAPI_STATE_NPSVC, &n->state);
> }
> - - - snip - - -
>
> The stack-trace shows that the AER handler starts here and goes into igb_=
up():
>
> - - - snip - - -
> static void igb_io_resume(struct pci_dev *pdev)
> {
>         struct net_device *netdev =3D pci_get_drvdata(pdev);
>         struct igb_adapter *adapter =3D netdev_priv(netdev);
>
>         if (netif_running(netdev)) {
>                 if (igb_up(adapter)) {
>                         dev_err(&pdev->dev, "igb_up failed after reset\n"=
);
>                         return;
>                 }
>         }
>
>        ...
> }
> - - - snip - - -
> Three functions come into the picture:
>
> igb_io_error_detected() { // runs upon AER detection
>   igb_down();  // before this commit
>   noop;        // with this commit
> }
>
> igb_io_resume() { // runs upon AER handling
>   igb_up()
> }
>
> igb_remove() { // runs upon rmmod igb, or surprise down removal (as shown=
 in the commit log)
>   igb_down();
> }
>
> Before this commit, the flow for an AER on 09:00.0 was
>  igb_down; // from igb_io_error_detect() - this sets the NAPI_STATE_SCHED=
 bit
>  igb_up;   // from igb_io_resume()       - that works as it finds a set N=
API_STATE_SCHED bit (and then clears it)
>
> Now with this commit, the flow for an AER on 09:00.0 is
>  noop;     // from igb_io_error_detect() - the NAPI_STATE_SCHED bit is no=
t touched, e.g. it remains cleared
>  igb_up;   // from igb_io_resume()       - BUG_ON() is triggered as it fi=
nds a cleared NAPI_STATE_SCHED bit
>
>
> I don't have a means to reproduce this i210 on thunderbolt issue and don'=
t completely understand its flow. Before this commit, the "expected" flow f=
or i210 on thunderbolt was probably
>
>  igb_down; // from igb_io_error_detect() - this sets the NAPI_STATE_SCHED=
 bit
>  igb_up;   // from igb_io_resume()       - that works as it finds a set N=
API_STATE_SCHED bit and cleans it.
>  igb_down; // from igb_remove()          - that works b/c of the previous=
 igb_up()
>
> The bug report shows that this was not the case. I don't completely under=
stand the reported problem: what happens to and in igb_io_resume() and its =
call to igb_up()? In the commit log backtrace, I see igb_remove() eventuall=
y calling __dev_close_many() which clears the __LINK__STATE_START bit. igb_=
io_resume() does check this bit via netif_running() and calls only then igb=
_up(). My guess is igb_io_resume() executes after igb_remove() and skips th=
erefore the execution of igb_up(). As we see from the commit log backtrace,=
 that makes igb_remove() starve now in igb_down()->napi_synchronize().
>
> How to fix that, I don't know.
>
>  Stefan
>
>

