Return-Path: <netdev+bounces-156805-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C313A07E08
	for <lists+netdev@lfdr.de>; Thu,  9 Jan 2025 17:47:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4E2057A3840
	for <lists+netdev@lfdr.de>; Thu,  9 Jan 2025 16:47:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9D33166F1A;
	Thu,  9 Jan 2025 16:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Q2i3Has+"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7589143759
	for <netdev@vger.kernel.org>; Thu,  9 Jan 2025 16:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736441224; cv=none; b=HIEe8ntK2cA8e14E5leKe9IlIo9JvhngRR4AxPdKcbAEUPRYkzDo2luJBdQOyfMC8IwokdPKzjZuiQGonEP1NYXyNARITiQ3Ykrzvskn46OdWQjSB7d+RHaRIJ2enfWVb7jF6JIsYkAmdliMD46+f2yXidt3+DVN1IKbxUpaXnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736441224; c=relaxed/simple;
	bh=IcABLs77zzHFVw4UA1mRjG3oNdKurdMAOZ3SGDHVy1E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qcl6pQU3n9AzxfNIF9Scv/JoGiLefxWnv7gMBMeRK5hYX+WFN93uhRxpnNfNJhtpawNiQZYr6lR4+XoCowue2uiSQoeBjhjnnW1zZA7/2xOkLCKsYytjQOu+EMTNgRwtFhBsZlFpkryy2t//h4rCsqYjmh67l6DVG2i6u3Spi8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Q2i3Has+; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736441221;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5JPHuVCRp7+zQFOdQ8fHuST1GoGNN9SlNiLTtrR+sc4=;
	b=Q2i3Has+GYv0rVtUMru9fJodOX7/YS2No21+ky8eenP2Dc2KcY99vFQRZFg8lFmRxv1MjR
	DY2RfpDPuv7CA6Gxsa23CQvqD8F8KPB4kPFdQKoFsCyKORHLZrjJr0JZ9IsoH0O2Jf/vKx
	/ivY+CswvzaqyY1yLlOz9lA1ZG6k0Os=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-107-wO31kq5cOSiYyDOmxWtPMg-1; Thu, 09 Jan 2025 11:47:00 -0500
X-MC-Unique: wO31kq5cOSiYyDOmxWtPMg-1
X-Mimecast-MFC-AGG-ID: wO31kq5cOSiYyDOmxWtPMg
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-2eeeb5b7022so2094691a91.0
        for <netdev@vger.kernel.org>; Thu, 09 Jan 2025 08:47:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736441219; x=1737046019;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5JPHuVCRp7+zQFOdQ8fHuST1GoGNN9SlNiLTtrR+sc4=;
        b=X9Vf7KtF5hJv/DF5UG579jKl3k5QLexcq+VYfabhTcXqMzw6OebfrLfFXSkXsHx6F7
         eRGRyVaAhxIw+zbrgdEg+sPnL4LSdMBVEOM70ToB0dANWYW2ZYcr6fseiJexLp+kkOrT
         v8U8N2JocTPCXJo5oh2nfS8+JiIb43k/TTJOZlZ1fG7HE3zXsWleOVg+iRXM8uv2mXdZ
         UDq6gZ/S7w8Jx5sgbKsUBlayvY50QcBgNzAWZu5t88LVQmcORCNEBS5KlleRXdlvI2V6
         xhZEbNlaozJsPlBSGAHhHvypEAlNAgGY2wIJMdPanAqJSnRMuI2NRR57vMHgTq0ttx87
         bRDg==
X-Forwarded-Encrypted: i=1; AJvYcCX8bI3Japho8ZcFq/8kQjZIFNuYmLiTSDMDlGXD5ctKt4mdiyowItEkdlKNsd5o8W9COVGSqfA=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywx8Pe5hflofl/iSLW03eX9XbejQwPArbd+z5Zw4uvBm73beF9H
	Cusrjj5txKdV39rt3p/wf6L6k8FnkdrbU5eoOCwm6zYFifDhobiZjrYHAwF1C5/KHp0mvZKodpx
	PmGYOHwvgXZ81+6mJOkiGjzYmHbZ4hq6TxpeeQGio/rBSDKhO6XM+IhSOAegCxJ1E3LpxIU0oSo
	FQw0pGIKAMpC4CbltMHqWU88+D/Jma
X-Gm-Gg: ASbGnct2iIkR08muHvfaBL+MCRrh0MZ5ysTbF7k/BmOeV+D8CaN0T7K0KTuA+e/jfSa
	8fBZcvgP0/R0CJQI+Yh/S9T2d3gwjTG2nznflag==
X-Received: by 2002:a17:90a:d648:b0:2f4:9e8b:6aad with SMTP id 98e67ed59e1d1-2f548da4606mr12572624a91.0.1736441219375;
        Thu, 09 Jan 2025 08:46:59 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHpM1xeYGQdWij9k8A8bJCGJl8L0XuzQRJzgPHF85+Q/4kUmrEx8hke+2dARHLCjk80AxjDtK2agKR7JR/4LpE=
X-Received: by 2002:a17:90a:d648:b0:2f4:9e8b:6aad with SMTP id
 98e67ed59e1d1-2f548da4606mr12572590a91.0.1736441219101; Thu, 09 Jan 2025
 08:46:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241204114229.21452-1-wander@redhat.com> <20250107135106.WWrtBMXY@linutronix.de>
 <taea3z7nof4szjir2azxsjtbouymqxyy4draa3hz35zbacqeeq@t3uidpha64k7> <20250108102532.VWnKWvoo@linutronix.de>
In-Reply-To: <20250108102532.VWnKWvoo@linutronix.de>
From: Wander Lairson Costa <wander@redhat.com>
Date: Thu, 9 Jan 2025 13:46:47 -0300
X-Gm-Features: AbW1kvZ8KQOnh86-GeyADaUmjIhlzOD5nmsf-y8x0xoFHG_aBcz-pakMV0aIxSU
Message-ID: <CAAq0SUnoS45Fctkzj4t4OxT=9qm9Bg8zu79=S3DUL_jcoLbC-A@mail.gmail.com>
Subject: Re: [PATCH iwl-net 0/4] igb: fix igb_msix_other() handling for PREEMPT_RT
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>, 
	Przemek Kitszel <przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Clark Williams <clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Jeff Garzik <jgarzik@redhat.com>, Auke Kok <auke-jan.h.kok@intel.com>, 
	"moderated list:INTEL ETHERNET DRIVERS" <intel-wired-lan@lists.osuosl.org>, 
	"open list:NETWORKING DRIVERS" <netdev@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, 
	"open list:Real-time Linux (PREEMPT_RT):Keyword:PREEMPT_RT" <linux-rt-devel@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 8, 2025 at 7:25=E2=80=AFAM Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:
>
> On 2025-01-07 15:52:47 [-0300], Wander Lairson Costa wrote:
> > On Tue, Jan 07, 2025 at 02:51:06PM +0100, Sebastian Andrzej Siewior wro=
te:
> > > On 2024-12-04 08:42:23 [-0300], Wander Lairson Costa wrote:
> > > > This is the second attempt at fixing the behavior of igb_msix_other=
()
> > > > for PREEMPT_RT. The previous attempt [1] was reverted [2] following
> > > > concerns raised by Sebastian [3].
> > > >
> > > > The initial approach proposed converting vfs_lock to a raw_spinlock=
,
> > > > a minor change intended to make it safe. However, it became evident
> > > > that igb_rcv_msg_from_vf() invokes kcalloc with GFP_ATOMIC,
> > > > which is unsafe in interrupt context on PREEMPT_RT systems.
> > > >
> > > > To address this, the solution involves splitting igb_msg_task()
> > > > into two parts:
> > > >
> > > >     * One part invoked from the IRQ context.
> > > >     * Another part called from the threaded interrupt handler.
> > > >
> > > > To accommodate this, vfs_lock has been restructured into a double
> > > > lock: a spinlock_t and a raw_spinlock_t. In the revised design:
> > > >
> > > >     * igb_disable_sriov() locks both spinlocks.
> > > >     * Each part of igb_msg_task() locks the appropriate spinlock fo=
r
> > > >     its execution context.
> > >
> > > - Is this limited to PREEMPT_RT or does it also occur on PREEMPT syst=
ems
> > >   with threadirqs? And if this is PREEMPT_RT only, why?
> >
> > PREEMPT systems configured to use threadirqs should be affected as well=
,
> > although I never tested with this configuration. Honestly, until now I =
wasn't
> > aware of the possibility of a non PREEMPT_RT kernel with threaded IRQs =
by default.
>
> If the issue is indeed the use of threaded interrupts then the fix
> should not be limited to be PREEMPT_RT only.
>
Although I was not aware of this scenario, the patch should work for it as =
well,
as I am forcing it to run in interrupt context. I will test it to confirm.

> > > - What causes the failure? I see you reworked into two parts to behav=
e
> > >   similar to what happens without threaded interrupts. There is still=
 no
> > >   explanation for it. Is there a timing limit or was there another
> > >   register operation which removed the mailbox message?
> > >
> >
> > I explained the root cause of the issue in the last commit. Maybe I sho=
uld
> > have added the explanation to the cover letter as well.  Anyway, here i=
s a
> > partial verbatim copy of it:
> >
> > "During testing of SR-IOV, Red Hat QE encountered an issue where the
> > ip link up command intermittently fails for the igbvf interfaces when
> > using the PREEMPT_RT variant. Investigation revealed that
> > e1000_write_posted_mbx returns an error due to the lack of an ACK
> > from e1000_poll_for_ack.
>
> That ACK would have come if it would poll longer?
>
No, the service wouldn't be serviced while polling.

> > The underlying issue arises from the fact that IRQs are threaded by
> > default under PREEMPT_RT. While the exact hardware details are not
> > available, it appears that the IRQ handled by igb_msix_other must
> > be processed before e1000_poll_for_ack times out. However,
> > e1000_write_posted_mbx is called with preemption disabled, leading
> > to a scenario where the IRQ is serviced only after the failure of
> > e1000_write_posted_mbx."
>
> Where is this disabled preemption coming from? This should be one of the
> ops.write_posted() calls, right? I've been looking around and don't see
> anything obvious.

I don't remember if I found the answer by looking at the code or by
looking at the ftrace flags.
I am currently on sick leave with covid. I can check it when I come back.

> Couldn't you wait for an event instead of polling?
>
> > The call chain from igb_msg_task():
> >
> > igb_msg_task
> >       igb_rcv_msg_from_vf
> >               igb_set_vf_multicasts
> >                       igb_set_rx_mode
> >                               igb_write_mc_addr_list
> >                                       kmalloc
> >
> > Cannot happen from interrupt context under PREEMPT_RT. So this part of
> > the interrupt handler is deferred to a threaded IRQ handler.
> >
> > > > Cheers,
> > > > Wander
>
> Sebastian
>


