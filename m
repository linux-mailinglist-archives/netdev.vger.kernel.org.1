Return-Path: <netdev+bounces-169859-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B7A3A4609D
	for <lists+netdev@lfdr.de>; Wed, 26 Feb 2025 14:21:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2FA4C171EEF
	for <lists+netdev@lfdr.de>; Wed, 26 Feb 2025 13:21:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A0D421CC48;
	Wed, 26 Feb 2025 13:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rsiSb0Du"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E8A921CA0D;
	Wed, 26 Feb 2025 13:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740576107; cv=none; b=crZIx8CWKfdHWG7nSO5MkQGFs6wUvm8JbkqjmoUiNn/zuLoIzSVHQZlRp74EHhXdFi94DgEQzsMr3EZwK0o4frxAJBdgLn/5oDvoIrWAZ4n7LjuUXfu6qjZ2lnjj7yFcP3YC+/ZdoQaapVdK7o9/VBQsei0yR8LgfuSiViXY3WA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740576107; c=relaxed/simple;
	bh=8cnR8orHIs6RAb5Jn/LFacAHgK/ZjTRl+C+5RkYBwQg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=otft2iPuI64BbWemGZZbEb6u5IYLuHk7WhkemsznhY5okmEXmOoovk7Irm4QWZNqdmkdUcr4j7XUhE7MCTEY330DtnaH8525C4mNY57/CZr6+Zi9AiZ16MdQbcniFFfpPKMpdwanlP59xjGMX1piy84A/prmQ1BIbWyOaVPVMgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rsiSb0Du; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 985EEC4CED6;
	Wed, 26 Feb 2025 13:21:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740576107;
	bh=8cnR8orHIs6RAb5Jn/LFacAHgK/ZjTRl+C+5RkYBwQg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rsiSb0Duk/4h54bpfyOucSbD05kHaZYafFd9PfLIQG4vOlEEAV3CG5M1aGXpzfJjY
	 fhOY/aoBDXrQF9DwgGT2XachvtbithI73fPVkhHlBOfpC0B4If6mvOIR5/XbezVmPr
	 b5TJ9jqmKwJ3s0pNd/77kpK8FXTPoiTviqzRHZTy5T5aZvN7OoRKbEia4h2s/NicwW
	 hOnpuQ5WSS3SBh75wDDdXRiuNkwcrO6SD/1pdUyg67nFk/SSrNb8EagWYiJ2k7f1Kx
	 2dNxo5RXVSgDW2ZjeBmkYOt9WUtg+7+PINrUkpzbr8bsHNwHpRJ8qbplJM6zTy9rO0
	 7gDrTEZD7qEqQ==
Date: Wed, 26 Feb 2025 14:21:44 +0100
From: Frederic Weisbecker <frederic@kernel.org>
To: Eric Dumazet <edumazet@google.com>
Cc: LKML <linux-kernel@vger.kernel.org>, netdev@vger.kernel.org,
	Breno Leitao <leitao@debian.org>, Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Paolo Abeni <pabeni@redhat.com>,
	Francois Romieu <romieu@fr.zoreil.com>,
	Paul Menzel <pmenzel@molgen.mpg.de>,
	Joe Damato <jdamato@fastly.com>
Subject: Re: [PATCH net v2] net: Handle napi_schedule() calls from
 non-interrupt
Message-ID: <Z78VaPGU3dzKdvl1@localhost.localdomain>
References: <20250223221708.27130-1-frederic@kernel.org>
 <CANn89iLgyPFY_u_CHozzk69dF3RQLrUVdLrf0NHj5+peXo2Yuw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANn89iLgyPFY_u_CHozzk69dF3RQLrUVdLrf0NHj5+peXo2Yuw@mail.gmail.com>

Le Wed, Feb 26, 2025 at 11:31:24AM +0100, Eric Dumazet a écrit :
> On Sun, Feb 23, 2025 at 11:17 PM Frederic Weisbecker
> <frederic@kernel.org> wrote:
> >
> > napi_schedule() is expected to be called either:
> >
> > * From an interrupt, where raised softirqs are handled on IRQ exit
> >
> > * From a softirq disabled section, where raised softirqs are handled on
> >   the next call to local_bh_enable().
> >
> > * From a softirq handler, where raised softirqs are handled on the next
> >   round in do_softirq(), or further deferred to a dedicated kthread.
> >
> > Other bare tasks context may end up ignoring the raised NET_RX vector
> > until the next random softirq handling opportunity, which may not
> > happen before a while if the CPU goes idle afterwards with the tick
> > stopped.
> >
> > Such "misuses" have been detected on several places thanks to messages
> > of the kind:
> >
> >         "NOHZ tick-stop error: local softirq work is pending, handler #08!!!"
> >
> > For example:
> >
> >        __raise_softirq_irqoff
> >         __napi_schedule
> >         rtl8152_runtime_resume.isra.0
> >         rtl8152_resume
> >         usb_resume_interface.isra.0
> >         usb_resume_both
> >         __rpm_callback
> >         rpm_callback
> >         rpm_resume
> >         __pm_runtime_resume
> >         usb_autoresume_device
> >         usb_remote_wakeup
> >         hub_event
> >         process_one_work
> >         worker_thread
> >         kthread
> >         ret_from_fork
> >         ret_from_fork_asm
> >
> > And also:
> >
> > * drivers/net/usb/r8152.c::rtl_work_func_t
> > * drivers/net/netdevsim/netdev.c::nsim_start_xmit
> >
> > There is a long history of issues of this kind:
> >
> >         019edd01d174 ("ath10k: sdio: Add missing BH locking around napi_schdule()")
> >         330068589389 ("idpf: disable local BH when scheduling napi for marker packets")
> >         e3d5d70cb483 ("net: lan78xx: fix "softirq work is pending" error")
> >         e55c27ed9ccf ("mt76: mt7615: add missing bh-disable around rx napi schedule")
> >         c0182aa98570 ("mt76: mt7915: add missing bh-disable around tx napi enable/schedule")
> >         970be1dff26d ("mt76: disable BH around napi_schedule() calls")
> >         019edd01d174 ("ath10k: sdio: Add missing BH locking around napi_schdule()")
> >         30bfec4fec59 ("can: rx-offload: can_rx_offload_threaded_irq_finish(): add new  function to be called from threaded interrupt")
> >         e63052a5dd3c ("mlx5e: add add missing BH locking around napi_schdule()")
> >         83a0c6e58901 ("i40e: Invoke softirqs after napi_reschedule")
> >         bd4ce941c8d5 ("mlx4: Invoke softirqs after napi_reschedule")
> >         8cf699ec849f ("mlx4: do not call napi_schedule() without care")
> >         ec13ee80145c ("virtio_net: invoke softirqs after __napi_schedule")
> >
> > This shows that relying on the caller to arrange a proper context for
> > the softirqs to be handled while calling napi_schedule() is very fragile
> > and error prone. Also fixing them can also prove challenging if the
> > caller may be called from different kinds of contexts.
> >
> > Therefore fix this from napi_schedule() itself with waking up ksoftirqd
> > when softirqs are raised from task contexts.
> >
> > Reported-by: Paul Menzel <pmenzel@molgen.mpg.de>
> > Reported-by: Jakub Kicinski <kuba@kernel.org>
> > Reported-by: Francois Romieu <romieu@fr.zoreil.com>
> > Closes: https://lore.kernel.org/lkml/354a2690-9bbf-4ccb-8769-fa94707a9340@molgen.mpg.de/
> > Cc: Breno Leitao <leitao@debian.org>
> > Cc: Jakub Kicinski <kuba@kernel.org>
> > Cc: "David S. Miller" <davem@davemloft.net>
> > Cc: Eric Dumazet <edumazet@google.com>
> > Cc: Paolo Abeni <pabeni@redhat.com>
> > Cc: Francois Romieu <romieu@fr.zoreil.com>
> > Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> > ---
> >  net/core/dev.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/net/core/dev.c b/net/core/dev.c
> > index 80e415ccf2c8..5c1b93a3f50a 100644
> > --- a/net/core/dev.c
> > +++ b/net/core/dev.c
> > @@ -4693,7 +4693,7 @@ static inline void ____napi_schedule(struct softnet_data *sd,
> >          * we have to raise NET_RX_SOFTIRQ.
> >          */
> >         if (!sd->in_net_rx_action)
> > -               __raise_softirq_irqoff(NET_RX_SOFTIRQ);
> > +               raise_softirq_irqoff(NET_RX_SOFTIRQ);
> 
> Your patch is fine, but would silence performance bugs.
> 
> I would probably add something to let network developers be aware of them.
> 
> diff --git a/net/core/dev.c b/net/core/dev.c
> index 1b252e9459fdbde42f6fb71dc146692c7f7ec17a..ae8882a622943a81ddd8e2d141df685637e334b6
> 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c
> @@ -4762,8 +4762,10 @@ static inline void ____napi_schedule(struct
> softnet_data *sd,
>         /* If not called from net_rx_action()
>          * we have to raise NET_RX_SOFTIRQ.
>          */
> -       if (!sd->in_net_rx_action)
> -               __raise_softirq_irqoff(NET_RX_SOFTIRQ);
> +       if (!sd->in_net_rx_action) {
> +               raise_softirq_irqoff(NET_RX_SOFTIRQ);
> +               DEBUG_NET_WARN_ON_ONCE(!in_interrupt());
> +       }

That looks good and looks like what I did initially:

https://lore.kernel.org/lkml/20250212174329.53793-2-frederic@kernel.org/

Do you prefer me doing it over DEBUG_NET_WARN_ON_ONCE() or with lockdep
like in the link?

Thanks.

>  }
> 
>  #ifdef CONFIG_RPS
> 
> 
> Looking at the list of patches, I can see idpf fix was not very good,
> I will submit another patch.

