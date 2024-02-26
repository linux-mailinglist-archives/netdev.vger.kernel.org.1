Return-Path: <netdev+bounces-75083-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C0A768681BE
	for <lists+netdev@lfdr.de>; Mon, 26 Feb 2024 21:11:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E75E1F22D5F
	for <lists+netdev@lfdr.de>; Mon, 26 Feb 2024 20:11:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9251D12C55E;
	Mon, 26 Feb 2024 20:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IqIaDgxt"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F25412DDBB
	for <netdev@vger.kernel.org>; Mon, 26 Feb 2024 20:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708978300; cv=none; b=R0W0bFdb6oNvOODRyGxQrUDvEmLWBIuNhNWxYdNwpYveWls7b5gOX4smnlqr29L4xiSOeXgAq2zyBGUHjpeP9N2mmYGEOwXNUqYiZ3oUKlKYc+BJbQ/YshLPLmR/2/p6ALuBABQxjMG4Co3ijUSs+r1jkBgSxWJPjCLLpmzKFWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708978300; c=relaxed/simple;
	bh=bDwpd2OjsF3jIPFEtpzLTlBqOwrwtlacgpPqqBcHzoA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PyHZUosrWgaMpUvmnl1zoh8uh0i3UXnLnCvYxSapuijcgH5TgOb2n8D+jHgwbQRe5k7YSkocsy5/pggkfWWtKOIgHc6avbjaS5zRKsrnf0hdjAf4jaaBdQ1XbzuwquR6DnaUbmWONeneNx56ltXqp2P+xv8EIoND7q4ZyKnBom8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IqIaDgxt; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708978297;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lImKjhx3mbLC7/PeG7z/wsJLqj583nlyj7rKhyutm1Y=;
	b=IqIaDgxt9B57QJbZZAIUxxpm6MGBmhnnTeTs2GoLjy8pnjdgLzAQVPfKAaVxhAPkW1ZmBG
	l5Rb1ON22nEhvM4KHGtJq5ckS/TeIVHhgTyvsFrI4/DyRe1MWyhbnanKteANvLq6ij8Uyz
	B9C6a2oNDsVV27YeouME7CMAioOVR9Y=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-645-fSTLHNKWPwWuoNUAidovJw-1; Mon, 26 Feb 2024 15:11:36 -0500
X-MC-Unique: fSTLHNKWPwWuoNUAidovJw-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-a3ecd8d3a8dso144731866b.2
        for <netdev@vger.kernel.org>; Mon, 26 Feb 2024 12:11:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708978295; x=1709583095;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lImKjhx3mbLC7/PeG7z/wsJLqj583nlyj7rKhyutm1Y=;
        b=Zydf/O87eQxke1cV3iUXG5VzkZYV1qH3iBxpdIeNnWWT1oCj+WXPQ9z+JhrAI9aIaZ
         PRq3i+och/D5hG2UychTbZ84mqTz7wevYrIvmdlP/gXZiq1w81XXumZVvsz+MvDRGbmZ
         drNCp0SBBww5KGYFAl/BxMCPb6t82e76J5gmbpiCCm58PYvGvHLimD9qfeSljny0DI1c
         8orChPhe4PDMllZPVfoGickWQQaJGO7SzOjaIHUO6owcT+BdN9yj3umy0s+pUaTcbdja
         Z1J34uW+H6+CyovMzd1/Zqr3OwIjBiCnJTX3XEuvqNHZS7X48fFDU+LcdANfXRi/kevn
         9jfg==
X-Forwarded-Encrypted: i=1; AJvYcCU3hiysIwShYndoJvcQdmYLx/Qa45RPH1D3izofttddHLBOIFLA2rzaq7+ECZXC6T+kc5CJjEZNBGD4NvqeyMEUHk2UTwm7
X-Gm-Message-State: AOJu0YwoloC2eKAyFGaOZPTEuTA8M7GRKFbqNsJr6D2YbR0/LRO99uge
	r4n27f9JZ6+xD1zGmd2Z4GHvTzP2mk4/0Rbu78h1QKYVx72W5ezgfafTfhE7lkOGTfaFSY2nGzI
	xzJmI9EvA3gu0tYQ5oe9blvRKudx7DQ/yrVdHn2JdRD3rRUMnfRTTuXijqnSfVHtU9HNuL9It0+
	mdnXnnBqckuxcGLqDNpCGUS8YhRRD+
X-Received: by 2002:a17:906:6dcd:b0:a3e:7cd8:3db7 with SMTP id j13-20020a1709066dcd00b00a3e7cd83db7mr5543269ejt.68.1708978294908;
        Mon, 26 Feb 2024 12:11:34 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGDx/VXbHhc7+1+gW+s0W5/hQikc4xx1u9a4ebbDB3rYzlGs9rj31BBTAEOEIoWoY4BS5f2VOHpSaAFXvDvjpQ=
X-Received: by 2002:a17:906:6dcd:b0:a3e:7cd8:3db7 with SMTP id
 j13-20020a1709066dcd00b00a3e7cd83db7mr5543262ejt.68.1708978294605; Mon, 26
 Feb 2024 12:11:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240226151125.45391-1-mschmidt@redhat.com> <20240226151125.45391-3-mschmidt@redhat.com>
 <e03aabf2-2a97-4395-9060-909d3651bcf7@intel.com>
In-Reply-To: <e03aabf2-2a97-4395-9060-909d3651bcf7@intel.com>
From: Michal Schmidt <mschmidt@redhat.com>
Date: Mon, 26 Feb 2024 21:11:23 +0100
Message-ID: <CADEbmW19UZ2KvmHr_JrmJ9--yy2L4zOJKAUdJFtN53tWR5nkrA@mail.gmail.com>
Subject: Re: [PATCH net-next 2/3] ice: avoid the PTP hardware semaphore in
 gettimex64 path
To: Jacob Keller <jacob.e.keller@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, 
	Jesse Brandeburg <jesse.brandeburg@intel.com>, Richard Cochran <richardcochran@gmail.com>, 
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>, 
	Karol Kolacinski <karol.kolacinski@intel.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 26, 2024 at 8:36=E2=80=AFPM Jacob Keller <jacob.e.keller@intel.=
com> wrote:
> On 2/26/2024 7:11 AM, Michal Schmidt wrote:
> > The writing is performed indirectly, by the hardware, as a result of
> > the driver writing GLTSYN_CMD_SYNC in ice_ptp_exec_tmr_cmd. I wasn't
> > sure if the ice_flush there is enough to make sure GLTSYN_TIME has been
> > updated, but it works well in my testing.
> >
>
> I believe this is good enough. I don't know the exact timing involved
> here, but the hardware synchronizes the update to all the PHYs and the
> MAC and it is supposed to be on the order of nanoseconds.

Thanks, that's good to know.

> > My test code can be seen here:
> > https://gitlab.com/mschmidt2/linux/-/commits/ice-ptp-host-side-lock
> > It consists of:
> >  - kernel threads reading the time in a busy loop and looking at the
> >    deltas between consecutive values, reporting new maxima.
> >    in the consecutive values;
> >  - a shell script that sets the time repeatedly;
> >  - a bpftrace probe to produce a histogram of the measured deltas.
> > Without the spinlock ptp_gltsyn_time_lock, it is easy to see tearing.
> > Deltas in the [2G, 4G) range appear in the histograms.
> > With the spinlock added, there is no tearing and the biggest delta I sa=
w
> > was in the range [1M, 2M), that is under 2 ms.
> >
>
> Nice.
>
>
> At first, I wasn't convinced we actually need cross-adapter spinlock
> here. I thought all the flows that took hardware semaphore were on the
> clock owner. Only the clock owner PF will access the GLTSYN_TIME
> registers, (gettimex is only exposed through the ptp device, which hooks
> into the clock owner). Similarly, only the clock owner does adjtime,
> settime, etc.

Non-owners do not expose a ptp device to userspace, but they still do
ice_ptp_periodic_work -> ice_ptp_update_cached_phctime ->
ice_ptp_read_src_clk_reg, where they read GLTSYN_TIME.

> However... It turns out that at least a couple of flows use the
> semaphore on non-clock owners. Specifically E822 hardware has to
> initialize the PHY after a link restart, which includes re-doing Vernier
> calibration. Each PF handles this itself, but does require use of the
> timer synchronization commands to do it. In this flow, the main timer is
> not modified but we still use the semaphore and sync registers.
>
> I don't think that impacts the E810 card, but we use the same code flow
> here. The E822 series hardware doesn't use the AdminQ for the PHY
> messages, so its faster but I think the locking improvement would still
> be relevant for them as well.
>
> Given all this, I think it makes sense to go this route.
>
> I'd like to follow-up with possibly replacing the entire HW semaphore
> with a mutex initialized here. That would remove a bunch of PCIe posted
> transactions required to acquire the HW semaphore which would be a
> further improvement here.

Yes, I agree and I have already been looking into this.
Thanks,
Michal

> Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
>
> > Signed-off-by: Michal Schmidt <mschmidt@redhat.com>
> > ---
> >  drivers/net/ethernet/intel/ice/ice_adapter.c | 2 ++
> >  drivers/net/ethernet/intel/ice/ice_adapter.h | 6 ++++++
> >  drivers/net/ethernet/intel/ice/ice_ptp.c     | 8 +-------
> >  drivers/net/ethernet/intel/ice/ice_ptp_hw.c  | 3 +++
> >  4 files changed, 12 insertions(+), 7 deletions(-)
> >
> > diff --git a/drivers/net/ethernet/intel/ice/ice_adapter.c b/drivers/net=
/ethernet/intel/ice/ice_adapter.c
> > index deb063401238..4b9f5d29811c 100644
> > --- a/drivers/net/ethernet/intel/ice/ice_adapter.c
> > +++ b/drivers/net/ethernet/intel/ice/ice_adapter.c
> > @@ -5,6 +5,7 @@
> >  #include <linux/mutex.h>
> >  #include <linux/pci.h>
> >  #include <linux/slab.h>
> > +#include <linux/spinlock.h>
> >  #include <linux/xarray.h>
> >  #include "ice_adapter.h"
> >
> > @@ -38,6 +39,7 @@ struct ice_adapter *ice_adapter_get(const struct pci_=
dev *pdev)
> >       if (!a)
> >               return NULL;
> >
> > +     spin_lock_init(&a->ptp_gltsyn_time_lock);
> >       refcount_set(&a->refcount, 1);
> >
> >       if (xa_is_err(xa_store(&ice_adapters, index, a, GFP_KERNEL))) {
> > diff --git a/drivers/net/ethernet/intel/ice/ice_adapter.h b/drivers/net=
/ethernet/intel/ice/ice_adapter.h
> > index cb5a02eb24c1..9d11014ec02f 100644
> > --- a/drivers/net/ethernet/intel/ice/ice_adapter.h
> > +++ b/drivers/net/ethernet/intel/ice/ice_adapter.h
> > @@ -4,15 +4,21 @@
> >  #ifndef _ICE_ADAPTER_H_
> >  #define _ICE_ADAPTER_H_
> >
> > +#include <linux/spinlock_types.h>
> >  #include <linux/refcount_types.h>
> >
> >  struct pci_dev;
> >
> >  /**
> >   * struct ice_adapter - PCI adapter resources shared across PFs
> > + * @ptp_gltsyn_time_lock: Spinlock protecting access to the GLTSYN_TIM=
E
> > + *                        register of the PTP clock.
> >   * @refcount: Reference count. struct ice_pf objects hold the referenc=
es.
> >   */
> >  struct ice_adapter {
> > +     /* For access to the GLTSYN_TIME register */
> > +     spinlock_t ptp_gltsyn_time_lock;
> > +
> >       refcount_t refcount;
> >  };
> >
> > diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/eth=
ernet/intel/ice/ice_ptp.c
> > index c11eba07283c..b6c7246245c6 100644
> > --- a/drivers/net/ethernet/intel/ice/ice_ptp.c
> > +++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
> > @@ -374,6 +374,7 @@ ice_ptp_read_src_clk_reg(struct ice_pf *pf, struct =
ptp_system_timestamp *sts)
> >       u8 tmr_idx;
> >
> >       tmr_idx =3D ice_get_ptp_src_clock_index(hw);
> > +     guard(spinlock_irqsave)(&pf->adapter->ptp_gltsyn_time_lock);
> >       /* Read the system timestamp pre PHC read */
> >       ptp_read_system_prets(sts);
> >
> > @@ -1925,15 +1926,8 @@ ice_ptp_gettimex64(struct ptp_clock_info *info, =
struct timespec64 *ts,
> >                  struct ptp_system_timestamp *sts)
> >  {
> >       struct ice_pf *pf =3D ptp_info_to_pf(info);
> > -     struct ice_hw *hw =3D &pf->hw;
> > -
> > -     if (!ice_ptp_lock(hw)) {
> > -             dev_err(ice_pf_to_dev(pf), "PTP failed to get time\n");
> > -             return -EBUSY;
> > -     }
> >
> >       ice_ptp_read_time(pf, ts, sts);
> > -     ice_ptp_unlock(hw);
> >
> >       return 0;
> >  }
> > diff --git a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c b/drivers/net/=
ethernet/intel/ice/ice_ptp_hw.c
> > index 187ce9b54e1a..a47dbbfadb74 100644
> > --- a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
> > +++ b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
> > @@ -274,6 +274,9 @@ void ice_ptp_src_cmd(struct ice_hw *hw, enum ice_pt=
p_tmr_cmd cmd)
> >   */
> >  static void ice_ptp_exec_tmr_cmd(struct ice_hw *hw)
> >  {
> > +     struct ice_pf *pf =3D container_of(hw, struct ice_pf, hw);
> > +
> > +     guard(spinlock_irqsave)(&pf->adapter->ptp_gltsyn_time_lock);
> >       wr32(hw, GLTSYN_CMD_SYNC, SYNC_EXEC_CMD);
> >       ice_flush(hw);
> >  }
>


