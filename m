Return-Path: <netdev+bounces-52953-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8461D800E60
	for <lists+netdev@lfdr.de>; Fri,  1 Dec 2023 16:17:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 85EF91C20949
	for <lists+netdev@lfdr.de>; Fri,  1 Dec 2023 15:17:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BC8D495F8;
	Fri,  1 Dec 2023 15:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="oCojIwhW"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8EAF1994
	for <netdev@vger.kernel.org>; Fri,  1 Dec 2023 07:16:46 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-54c54a3b789so1396930a12.0
        for <netdev@vger.kernel.org>; Fri, 01 Dec 2023 07:16:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1701443804; x=1702048604; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CqyWOd2V2jjfULDVhDbfTsYOuXxG/ALnevGqkLboVV0=;
        b=oCojIwhW8STXWzSiVJj5ENYvAnstlAUYqYitZf7PPoTf+90NrCFIE2ht1r9glZjLtz
         fl9lEDjJ1gXwuJ8cTiwc36/8/hQL4rzNmgiBn0lPv1aQHGWPsD+fPPQZ3kGuZ+yPRsWB
         AFgLln0MPjlPNeqhkN3mmdJKJDvr2/QLMiA88=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701443804; x=1702048604;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CqyWOd2V2jjfULDVhDbfTsYOuXxG/ALnevGqkLboVV0=;
        b=GdZBZfeKnm4I4IlE/I+yKaL4lJ6zaxBX9R+myx5yJWWsWdGD4x+4hqODwLbx892dGo
         66Bds3/kUURDezOYYlwUlHGrP1c0Cz3wuaFkD4Ld/xmykPEx9r+tiqGgqF2//TMss2fa
         QhdqkAv7fBdYbaLRGj1MbCcY8qSnv2mtr6fo5JjFc2EsD8VYgtJVeEQVUyHCW9ojg34n
         aRbKuCQVi3CltmBxbuNODBeNSvqDABniv8babhjrUAQSteaswIzE5X5lxgcoPM3UTA9T
         J3G356DaEMO95P+KVe2sJeq/QDkJ/AtAo44dWyuQ1Cn6y+uBgu2wPtJ/2/81CWO0BhGt
         UobQ==
X-Gm-Message-State: AOJu0Yy0PiPySHxrVMjv5cXknNewgnF3nHcaOiCpXCVaQ5MDbhwSfMKC
	KpY7CQ7WZ518UQQBu2dHk4PvQJASRaQXI5Kqn6nzUw==
X-Google-Smtp-Source: AGHT+IEdgY3lR+N7a2ovbj6Rpf2s8PcsHxw1YkvYG272ha/jp8im5Bca9R1n7igZeOAzj4NVdagbjg==
X-Received: by 2002:a50:9313:0:b0:54c:553e:67f5 with SMTP id m19-20020a509313000000b0054c553e67f5mr1467826eda.8.1701443803882;
        Fri, 01 Dec 2023 07:16:43 -0800 (PST)
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com. [209.85.128.43])
        by smtp.gmail.com with ESMTPSA id w23-20020aa7da57000000b0054bce7dab31sm1703509eds.79.2023.12.01.07.16.43
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Dec 2023 07:16:43 -0800 (PST)
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-40b422a274dso75465e9.0
        for <netdev@vger.kernel.org>; Fri, 01 Dec 2023 07:16:43 -0800 (PST)
X-Received: by 2002:a05:600c:54e7:b0:3f7:3e85:36a with SMTP id
 jb7-20020a05600c54e700b003f73e85036amr131039wmb.7.1701443802948; Fri, 01 Dec
 2023 07:16:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231201083926.1817394-1-judyhsiao@chromium.org> <CANn89iJMbMZdnJRP0CUVfEi20whhShBfO+DAmdaerhiXfiTx5A@mail.gmail.com>
In-Reply-To: <CANn89iJMbMZdnJRP0CUVfEi20whhShBfO+DAmdaerhiXfiTx5A@mail.gmail.com>
From: Doug Anderson <dianders@chromium.org>
Date: Fri, 1 Dec 2023 07:16:30 -0800
X-Gmail-Original-Message-ID: <CAD=FV=Vf18TxUWpGTN9b=iECq=5BmEoopQjsMH2U6bDX2=T3cQ@mail.gmail.com>
Message-ID: <CAD=FV=Vf18TxUWpGTN9b=iECq=5BmEoopQjsMH2U6bDX2=T3cQ@mail.gmail.com>
Subject: Re: [PATCH v1] neighbour: Don't let neigh_forced_gc() disable
 preemption for long
To: Eric Dumazet <edumazet@google.com>
Cc: Judy Hsiao <judyhsiao@chromium.org>, David Ahern <dsahern@kernel.org>, 
	Simon Horman <horms@kernel.org>, Brian Haley <haleyb.dev@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Joel Granados <joel.granados@gmail.com>, Julian Anastasov <ja@ssi.bg>, Leon Romanovsky <leon@kernel.org>, 
	Luis Chamberlain <mcgrof@kernel.org>, Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Dec 1, 2023 at 1:10=E2=80=AFAM Eric Dumazet <edumazet@google.com> w=
rote:
>
> On Fri, Dec 1, 2023 at 9:39=E2=80=AFAM Judy Hsiao <judyhsiao@chromium.org=
> wrote:
> >
> > We are seeing cases where neigh_cleanup_and_release() is called by
> > neigh_forced_gc() many times in a row with preemption turned off.
> > When running on a low powered CPU at a low CPU frequency, this has
> > been measured to keep preemption off for ~10 ms. That's not great on a
> > system with HZ=3D1000 which expects tasks to be able to schedule in
> > with ~1ms latency.
>
> This will not work in general, because this code runs with BH blocked.
>
> jiffies will stay untouched for many more ms on systems with only one CPU=
.
>
> I would rather not rely on jiffies here but ktime_get_ns() [1]
>
> Also if we break the loop based on time, we might be unable to purge
> the last elements in gc_list.
> We might need to use a second list to make sure to cycle over all
> elements eventually.
>
>
> [1]
> diff --git a/net/core/neighbour.c b/net/core/neighbour.c
> index df81c1f0a57047e176b7c7e4809d2dae59ba6be5..e2340e6b07735db8cf6e75d23=
ef09bb4b0db53b4
> 100644
> --- a/net/core/neighbour.c
> +++ b/net/core/neighbour.c
> @@ -253,9 +253,11 @@ static int neigh_forced_gc(struct neigh_table *tbl)
>  {
>         int max_clean =3D atomic_read(&tbl->gc_entries) -
>                         READ_ONCE(tbl->gc_thresh2);
> +       u64 tmax =3D ktime_get_ns() + NSEC_PER_MSEC;

It might be nice to make the above timeout based on jiffies. On a
HZ=3D100 system it's probably OK to keep preemption disabled for 10 ms
but on a HZ=3D1000 system you'd want 1 ms. ...so maybe you'd want to use
jiffies_to_nsecs(1)?

One worry might be that we disabled preemption _right before_ we were
supposed to be scheduled out. In that case we'll end up blocking some
other task for another full timeslice, but maybe there's not a lot we
can do there?

-Doug

