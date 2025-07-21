Return-Path: <netdev+bounces-208514-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F2198B0BEB2
	for <lists+netdev@lfdr.de>; Mon, 21 Jul 2025 10:21:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 204A83A8F22
	for <lists+netdev@lfdr.de>; Mon, 21 Jul 2025 08:20:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84452283FF9;
	Mon, 21 Jul 2025 08:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HOE05vuy"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D422519AD89
	for <netdev@vger.kernel.org>; Mon, 21 Jul 2025 08:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753086075; cv=none; b=G3zKzT1E+cZil7gn43fIY41sRi+gjf7ILal2XDJVx/SrRcIlT0bNXldzSaQiFcuMWcFvurxi3d8LYT/Sjufnv2HhbkeTGGLGHs/iF5scGWQgrBPqJ5IHJjzjh+Z3R9HdVJbfJTExdN2ibr//k2XTNNu303FJHckcpcccLIkAyWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753086075; c=relaxed/simple;
	bh=ivUBRwOT4gBUc4sQHKVSdAsKfbQMoc0FaJDGyzSlShs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QM9MLY8jJIwD21otT38tZ34zFxGxAYPz3i/MeS6GcRHYRPTlPPh28/ic2xZGVTjxaoQdMA0qUXppwJO0qLt7TIpV+fYQrqEa11ZTbU305XmCtCqDpt67ONX2v/gmYlUvUBVfM39VnmhkzMfPU71XbtxZ5F1youYrYNT3CgXXnoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HOE05vuy; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-4ab6646476aso25097861cf.3
        for <netdev@vger.kernel.org>; Mon, 21 Jul 2025 01:21:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753086073; x=1753690873; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BuCRJ4uldLzWRkxX+sEHu5x/+4Bciq9ZQVcRfuRRxw0=;
        b=HOE05vuySMxMM10ZBOohMCbyoVU+7BQRiU5WIyCzVp0s4dXLmHDYxzF/vLEzOnMgD5
         HeYe+Ol3gi13zNYdk2J2xkjQPLB4uhj2ooWFDad0XAOy+fEafrlIKHpy7QrPCZMxzs+A
         l2xBygdZILPGplDkSWA18Mt6UWuikQ0beRS9Rq2fr0dLv/vznOwxUacbNZTsJEYosiC3
         YV8bcUn1yJ8HNiZh79G515/muiLIBFzpjkmeLCh9sCoSTu7BVpe3KP7KW/rKF7u1HAjH
         /n/XVWFuxGYm9M4blwBiK+AGlx9Szx9DTwcPZQs0bE6R6CNK5QbLNR46Opm3spvUJACE
         /i1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753086073; x=1753690873;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BuCRJ4uldLzWRkxX+sEHu5x/+4Bciq9ZQVcRfuRRxw0=;
        b=mCThSxcUR3dUD5BMJj1mSMbY3XHnTajW/9Y8AcXA9+VUKatnhAnamSewBKp6V9noo6
         V/4J4wKh1TeTxC3XMRgZlzljxT/qg2kR8H8qHTGIZL0v+SHjT4CMjGBC8V+4VF7IxVg4
         hnZg9GGrytOA0yKTiZY3cP3NYYQdxAxRrtzRqEZJYH0Lq2zwOxi9AGS0jgy3GHbsk84x
         1zj7SnWu+zL8G0mAdjwMv/9Ymz8h8h3YnYrUT75sZ6W2KGyRrlkE9tmk0SLNYI05cAmh
         Vzhp84G1klEQoCrjb/Fbc1YKy8KRK2H9pH1ob455f4V/VRkVRtkwQBhXFQ+HKdzW7RUY
         ZSGA==
X-Gm-Message-State: AOJu0Yy2rPSDuX8aC4yCIBqwKAxUakDRpuy+ys1OfqmUGjlvN2h4MoJA
	xdPRvbDbQrVGRiZjhCb0hFYebtXVtNbpMuRRLTC10cCRQY3Or2CrzZG0SWe9UTfrqghhPvIy8O6
	O/V0njPu71ojhgd/7vyzsBktpVfggn4XfVT/gCopd0jaq7UB++X+oP9Fk
X-Gm-Gg: ASbGncv63z9qNXJmg++6LKOLKSgfuQKITczHsiohaPQBUcNESNDTA4mv695plc9N08y
	Pt/YVoGkI7zwo6kVUqDDOQ4GPP/LpUeq/r5WMTpleVPtSnsCthfy98rhm6t08rCf3UHkLv1VJ11
	xtjcZRvE86fo2/4o08ULSpW+Vl2nU8IlyosqWDZmf+se6VuQkctVEHBBiYLtHZtgohiE8ONJF03
	7Rp9cU=
X-Google-Smtp-Source: AGHT+IFdfS63Qaq6oxHhD3zXUWKrZASJlZqlxw9o0eQ+cDj1l40P2Eu5nf7YoDkM0eqa33cmHBsTT6PYLivD5MZxMSY=
X-Received: by 2002:a05:622a:242:b0:4a9:e225:fb6d with SMTP id
 d75a77b69052e-4aba3cb9d7bmr215281521cf.21.1753086072371; Mon, 21 Jul 2025
 01:21:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250721031609.132217-1-krikku@gmail.com> <20250721031609.132217-2-krikku@gmail.com>
In-Reply-To: <20250721031609.132217-2-krikku@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 21 Jul 2025 01:21:00 -0700
X-Gm-Features: Ac12FXyJM3EhvoJAhwy2gwrCGPd_MUNPsCtaY4_ktfcdX60lXBy-7bsiEOabAME
Message-ID: <CANn89iLXMK0edE0xdZgD9aqLkGr32tOjOyyHKAnBbgCYhZt+jw@mail.gmail.com>
Subject: Re: [PATCH v5 net-next 1/2] net: Prevent RPS table overwrite for
 active flows
To: Krishna Kumar <krikku@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, tom@herbertland.com, 
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, sdf@fomichev.me, 
	kuniyu@google.com, ahmed.zaki@intel.com, aleksander.lobakin@intel.com, 
	atenart@kernel.org, jdamato@fastly.com, krishna.ku@flipkart.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jul 20, 2025 at 8:16=E2=80=AFPM Krishna Kumar <krikku@gmail.com> wr=
ote:
>
> This patch fixes an issue where two different flows on the same RXq
> produce the same hash resulting in continuous flow overwrites.
>
> Flow #1: A packet for Flow #1 comes in, kernel calls the steering
>          function. The driver gives back a filter id. The kernel saves
>          this filter id in the selected slot. Later, the driver's
>          service task checks if any filters have expired and then
>          installs the rule for Flow #1.
> Flow #2: A packet for Flow #2 comes in. It goes through the same steps.
>          But this time, the chosen slot is being used by Flow #1. The
>          driver gives a new filter id and the kernel saves it in the
>          same slot. When the driver's service task runs, it runs through
>          all the flows, checks if Flow #1 should be expired, the kernel
>          returns True as the slot has a different filter id, and then
>          the driver installs the rule for Flow #2.
> Flow #1: Another packet for Flow #1 comes in. The same thing repeats.
>          The slot is overwritten with a new filter id for Flow #1.
>
> This causes a repeated cycle of flow programming for missed packets,
> wasting CPU cycles while not improving performance. This problem happens
> at higher rates when the RPS table is small, but tests show it still
> happens even with 12,000 connections and an RPS size of 16K per queue
> (global table size =3D 144x16K =3D 64K).
>
>
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202507161125.rUCoz9ov-lkp@i=
ntel.com/
> Signed-off-by: Krishna Kumar <krikku@gmail.com>
> ---
>  include/net/rps.h    |  5 +--
>  net/core/dev.c       | 82 ++++++++++++++++++++++++++++++++++++++++----
>  net/core/net-sysfs.c |  4 ++-
>  3 files changed, 81 insertions(+), 10 deletions(-)
>
> diff --git a/include/net/rps.h b/include/net/rps.h
> index d8ab3a08bcc4..8e33dbea9327 100644
> --- a/include/net/rps.h
> +++ b/include/net/rps.h
> @@ -25,13 +25,14 @@ struct rps_map {
>

> +#ifdef CONFIG_RFS_ACCEL
> +/**
> + * rps_flow_is_active - check whether the flow is recently active.
> + * @rflow: Specific flow to check activity.
> + * @flow_table: Check activity against the flow_table's size.
> + * @cpu: CPU saved in @rflow.
> + *
> + * If the CPU has processed many packets since the flow's last activity
> + * (beyond 10 times the table size), the flow is considered stale.
> + *
> + * Return: true if flow was recently active.
> + */
> +static bool rps_flow_is_active(struct rps_dev_flow *rflow,
> +                              struct rps_dev_flow_table *flow_table,
> +                              unsigned int cpu)
> +{
> +       return cpu < nr_cpu_ids &&
> +              ((int)(READ_ONCE(per_cpu(softnet_data, cpu).input_queue_he=
ad) -
> +               READ_ONCE(rflow->last_qtail)) < (int)(10 << flow_table->l=
og));
> +}
> +#endif

This notion of active flow is kind of weird.
It might be time to make it less obscure, less expensive and time
(jiffies ?) deterministic.

