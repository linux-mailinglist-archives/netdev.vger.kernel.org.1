Return-Path: <netdev+bounces-103625-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CCCA908D02
	for <lists+netdev@lfdr.de>; Fri, 14 Jun 2024 16:09:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F00F31C25200
	for <lists+netdev@lfdr.de>; Fri, 14 Jun 2024 14:09:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BE41D268;
	Fri, 14 Jun 2024 14:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Rx82NLw0"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CE2DC121
	for <netdev@vger.kernel.org>; Fri, 14 Jun 2024 14:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718374135; cv=none; b=gFixgyFjAQ/Z0fYBYG8rXbQVzRI6n49H73/ojPcVDVDDc/Yl7D3HeOanmVEox1CULWc6rhTMnXlngHJ1WH5I6LrjRD2andyZoL4f8nfjt3bRQ5xlPVnSJeepnPEu6tRJRr6ER3NwWkZ3QsStapsE0Mv5FY/qEolcGBqsnsdjEso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718374135; c=relaxed/simple;
	bh=i7fBhkE22YnP4Bqn7Gw6/lRTqCPjsqlYhYf1Rvq+VO4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=sRQXrYKLFmfmZw34GLdQDwln+etMHPctVJReuQn0/Vd5oXZZfdMzlwCDtQw5j7etzj48tjQmmSpV+xBU3x91h8uks8mrMYHVlscRd83RKufzr2/NPFncxU84sthhfQccx3qCD9KBOeNlEWTM68QpU/DgoOSCIRcsg98EFM7k7OU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Rx82NLw0; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718374132;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=sei/AlzPitkzh30oWFQLawwYGSDtixmAw+yG8sdJyPQ=;
	b=Rx82NLw0vmEdKKoW8nMccXflCpR4ZJBFVA0tuwbLeCwvqOZY/PJowt+JFg5xhgXIdEOXsc
	q7OUuGmLGt17dtuzQi4b6+bSptDRdz2GO2mCLZb+Scj2NAhQ+GtCI1yidx1BLuotte0hdp
	CLWbdknd4NQCW2qw6RVJZ06UFsfihQ4=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-396-nqh8yJsyPbm2PszuUJJXqg-1; Fri, 14 Jun 2024 10:08:50 -0400
X-MC-Unique: nqh8yJsyPbm2PszuUJJXqg-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-42180d2a0d6so3441945e9.1
        for <netdev@vger.kernel.org>; Fri, 14 Jun 2024 07:08:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718374125; x=1718978925;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sei/AlzPitkzh30oWFQLawwYGSDtixmAw+yG8sdJyPQ=;
        b=i4MHrH325FLjEZeGGdKzZX096NTcmi2xbdLttPUl+RaP/lC5hdvRAx3hviMT3ShXC1
         MhCBvs0Cgf1OC8/9NFfg8TBeUCl1Ba/2SgNStgFsrQq2NkbI8K6/kC/7wBuJugx4/qLv
         Fb9+g6ST8EEQdQGmj2vjTReI1SpV22AZlLCnhO2Thg2WCDNNOANVMWC0j52AHYgRqK1f
         3qse35kM5v5ULI47mMMc71NjsfuaarNfCU2xjUGgDslWOSxVYrs1ffAj9V5JInkQWwik
         2gsRncXq3gzV0iEcg+YFgw3CuRTgrniJ9/GueXgivAavhqOOkK8FFO5gfKZcxtqgoGTD
         ftaw==
X-Forwarded-Encrypted: i=1; AJvYcCUkIuitjO2Tf0aBojAwdcAvV1AQOnMpfIP43Tph6EHnFrn4RVh6r9zStmLj5KHOWiQ8BBqoT/0PdzOLNUWGqEtj15glMzbi
X-Gm-Message-State: AOJu0Yx3YYX1bno9S/xoHhujbwu1ICqfxFHDf1hIieBqgJLvBzbFwX2/
	hAJ860BqyHMFQH02Ff41KN5d39sfi8VEQoHwFq1a6MdtNEtcZbYVxEQcPEWFwCUF+Y+jGpS3SuE
	5PKsz5Qtl1sJq651GuTFoW8I6ep9Demo8nkCFMz3Wmds1cA8mndOtUW3vY1BBhVoT
X-Received: by 2002:a05:600c:314e:b0:421:de31:76 with SMTP id 5b1f17b1804b1-42304849009mr20570355e9.3.1718374125156;
        Fri, 14 Jun 2024 07:08:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFSWPYoDukuiUzS+4Z4nzmvxNfQT6o9nqibK4enYXrliymBeNMI/R12YC4i1AGKfmbDzrD1mQ==
X-Received: by 2002:a05:600c:314e:b0:421:de31:76 with SMTP id 5b1f17b1804b1-42304849009mr20570025e9.3.1718374124719;
        Fri, 14 Jun 2024 07:08:44 -0700 (PDT)
Received: from gerbillo.redhat.com ([2a0d:3341:b083:7210::f71])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-422f8be0c69sm62597875e9.33.2024.06.14.07.08.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jun 2024 07:08:43 -0700 (PDT)
Message-ID: <834b61b93df3cbf5053e459f337e622e2c510fbd.camel@redhat.com>
Subject: Re: [PATCH v6 net-next 08/15] net: softnet_data: Make
 xmit.recursion per task.
From: Paolo Abeni <pabeni@redhat.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Eric Dumazet
	 <edumazet@google.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org, 
 netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, Daniel
 Bristot de Oliveira <bristot@kernel.org>, Boqun Feng
 <boqun.feng@gmail.com>, Daniel Borkmann <daniel@iogearbox.net>, Frederic
 Weisbecker <frederic@kernel.org>, Ingo Molnar <mingo@redhat.com>, Jakub
 Kicinski <kuba@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Thomas
 Gleixner <tglx@linutronix.de>, Waiman Long <longman@redhat.com>, Will
 Deacon <will@kernel.org>, Ben Segall <bsegall@google.com>, Daniel Bristot
 de Oliveira <bristot@redhat.com>,  Dietmar Eggemann
 <dietmar.eggemann@arm.com>, Juri Lelli <juri.lelli@redhat.com>, Mel Gorman
 <mgorman@suse.de>,  Valentin Schneider <vschneid@redhat.com>, Vincent
 Guittot <vincent.guittot@linaro.org>
Date: Fri, 14 Jun 2024 16:08:42 +0200
In-Reply-To: <20240614094809.gvOugqZT@linutronix.de>
References: <20240612170303.3896084-1-bigeasy@linutronix.de>
	 <20240612170303.3896084-9-bigeasy@linutronix.de>
	 <20240612131829.2e33ca71@rorschach.local.home>
	 <20240614082758.6pSMV3aq@linutronix.de>
	 <CANn89i+YfdmKSMgHni4ogMDq0BpFQtjubA0RxXcfZ8fpgV5_fw@mail.gmail.com>
	 <20240614094809.gvOugqZT@linutronix.de>
Autocrypt: addr=pabeni@redhat.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2024-06-14 at 11:48 +0200, Sebastian Andrzej Siewior wrote:
> On 2024-06-14 10:38:15 [+0200], Eric Dumazet wrote:
> > > I think it should work fine. netdev folks, you want me to remove that
> > > ifdef and use a per-Task counter unconditionally?
> >=20
> > It depends if this adds another cache line miss/dirtying or not.
> >=20
> > What about other fields from softnet_data.xmit ?
>=20
> duh. Looking at the `more' member I realise that this needs to move to
> task_struct on RT, too. Therefore I would move the whole xmit struct.
>=20
> The xmit cacheline starts within the previous member (xfrm_backlog) and
> ends before the following member starts. So it kind of has its own
> cacheline.
> With defconfig, if we move it to the front of task struct then we go from
>=20
> > struct task_struct {
> >         struct thread_info         thread_info;          /*     0    24=
 */
> >         unsigned int               __state;              /*    24     4=
 */
> >         unsigned int               saved_state;          /*    28     4=
 */
> >         void *                     stack;                /*    32     8=
 */
> >         refcount_t                 usage;                /*    40     4=
 */
> >         unsigned int               flags;                /*    44     4=
 */
> >         unsigned int               ptrace;               /*    48     4=
 */
> >         int                        on_cpu;               /*    52     4=
 */
> >         struct __call_single_node  wake_entry;           /*    56    16=
 */
> >         /* --- cacheline 1 boundary (64 bytes) was 8 bytes ago --- */
> >         unsigned int               wakee_flips;          /*    72     4=
 */
> >=20
> >         /* XXX 4 bytes hole, try to pack */
> >=20
> >         long unsigned int          wakee_flip_decay_ts;  /*    80     8=
 */
>=20
> to
>=20
> > struct task_struct {
> >         struct thread_info         thread_info;          /*     0    24=
 */
> >         unsigned int               __state;              /*    24     4=
 */
> >         unsigned int               saved_state;          /*    28     4=
 */
> >         void *                     stack;                /*    32     8=
 */
> >         refcount_t                 usage;                /*    40     4=
 */
> >         unsigned int               flags;                /*    44     4=
 */
> >         unsigned int               ptrace;               /*    48     4=
 */
> >         struct {
> >                 u16                recursion;            /*    52     2=
 */
> >                 u8                 more;                 /*    54     1=
 */
> >                 u8                 skip_txqueue;         /*    55     1=
 */
> >         } xmit;                                          /*    52     4=
 */
> >         struct __call_single_node  wake_entry;           /*    56    16=
 */
> >         /* --- cacheline 1 boundary (64 bytes) was 8 bytes ago --- */
> >         int                        on_cpu;               /*    72     4=
 */
> >         unsigned int               wakee_flips;          /*    76     4=
 */
> >         long unsigned int          wakee_flip_decay_ts;  /*    80     8=
 */
>=20
>=20
> stuffed a hole due to adding `xmit' and moving `on_cpu'. In the end the
> total size of task_struct remained the same.
> The cache line should be hot due to `flags' usage in
>=20
> > static void handle_softirqs(bool ksirqd)
> > {
> >          unsigned long old_flags =3D current->flags;
> =E2=80=A6
> >         current->flags &=3D ~PF_MEMALLOC;
>=20
> Then there is a bit of code before net_XX_action() and the usage of
> either of the members so not sure if it is gone by then=E2=80=A6
>=20
> Is this what we want or not?

I personally think (fear mostly) there is still the potential for some
(performance) regression. I think it would be safer to introduce this
change under a compiler conditional and eventually follow-up with a
patch making the code generic.

Should such later change prove to be problematic, we could revert it
without impacting the series as a whole.=20

Thanks!

Paolo


