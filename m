Return-Path: <netdev+bounces-53700-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E4BEB8042B3
	for <lists+netdev@lfdr.de>; Tue,  5 Dec 2023 00:40:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1069D1C20904
	for <lists+netdev@lfdr.de>; Mon,  4 Dec 2023 23:40:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F0AE35F06;
	Mon,  4 Dec 2023 23:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="dWXZXzFT"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB974107
	for <netdev@vger.kernel.org>; Mon,  4 Dec 2023 15:40:33 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id 4fb4d7f45d1cf-54bfd4546fbso6174838a12.1
        for <netdev@vger.kernel.org>; Mon, 04 Dec 2023 15:40:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1701733231; x=1702338031; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j8cb3BI/rsKzc7Vb5XxK5mF0t710SsUEXm0jO9+FTts=;
        b=dWXZXzFT/LKvykOTuMeODGO1NAVXOhunKmpek1b+333GX2iWqTUOWhZGjxgd35oeoZ
         0M2RCMbZSQVDMwGBJh9S8auR0jEZhbMFa/SS8jS4///qGwbjzaDXIAXG/x5B+xKvFXxY
         IudhTDHj+rRgW3eEaF084e+cfsotQkiI8fafk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701733231; x=1702338031;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j8cb3BI/rsKzc7Vb5XxK5mF0t710SsUEXm0jO9+FTts=;
        b=sX4wO3frxyuvO6n1aiaVLnaah0DzoJIW5lUJsLBBFcb+vxCNlIija5aaZNh/HDZxBR
         g9kVnxgcB4eDPMFmsSw9bFPIfL36EBt6+K3mCYUXLS4bkrcL6p8QtBechuv+lga2nZSL
         v+3vtbTO89oaHc1OsypMRaaNPifLGS5Tkorb3UE28PLM9dNXqxOvNycJsk9otg6QFg/E
         ItD4SlCVytF1/c9i3pTNTXjblv3c3itNfgqYAOtjFVdhdpRUeK8Nm6OPM+8YHRJ8Pd0o
         0i1gOaYpshpu1hBAk4Gu91Kr/MXk9pgwUQedzIV0lgL2bY75NoVSMgJJ6tdXUgIa1C1x
         nAxA==
X-Gm-Message-State: AOJu0YypnvCKGLHlejWt0eoNn7dsD4YQS3FoKH3mgYFC3PrBwnW06xDv
	/kCppFJaL5UDlEoKGkmuyFsiYF7QD/Dvc46vo0TGH2rV
X-Google-Smtp-Source: AGHT+IHiEhwIgNXoYESw6J4pDA+V1Rg62g9G28GrgY9yRHsBtr4JSs7lnWbyD6cb4RAgBWKnsRLrhw==
X-Received: by 2002:a50:d547:0:b0:54a:fb92:13c8 with SMTP id f7-20020a50d547000000b0054afb9213c8mr3493596edj.39.1701733230788;
        Mon, 04 Dec 2023 15:40:30 -0800 (PST)
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com. [209.85.128.54])
        by smtp.gmail.com with ESMTPSA id h16-20020aa7de10000000b0054cc61f0412sm331976edv.24.2023.12.04.15.40.30
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Dec 2023 15:40:30 -0800 (PST)
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-40b422a274dso25365e9.0
        for <netdev@vger.kernel.org>; Mon, 04 Dec 2023 15:40:30 -0800 (PST)
X-Received: by 2002:a05:600c:35d2:b0:40a:4c7d:f300 with SMTP id
 r18-20020a05600c35d200b0040a4c7df300mr517677wmq.6.1701733229952; Mon, 04 Dec
 2023 15:40:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231201083926.1817394-1-judyhsiao@chromium.org> <CANn89iJMbMZdnJRP0CUVfEi20whhShBfO+DAmdaerhiXfiTx5A@mail.gmail.com>
In-Reply-To: <CANn89iJMbMZdnJRP0CUVfEi20whhShBfO+DAmdaerhiXfiTx5A@mail.gmail.com>
From: Doug Anderson <dianders@chromium.org>
Date: Mon, 4 Dec 2023 15:40:14 -0800
X-Gmail-Original-Message-ID: <CAD=FV=VqmkydL2XXMWNZ7+89F_6nzGZiGfkknaBgf4Zncng1SQ@mail.gmail.com>
Message-ID: <CAD=FV=VqmkydL2XXMWNZ7+89F_6nzGZiGfkknaBgf4Zncng1SQ@mail.gmail.com>
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
>         unsigned long tref =3D jiffies - 5 * HZ;
>         struct neighbour *n, *tmp;
>         int shrunk =3D 0;
> +       int loop =3D 0;
>
>         NEIGH_CACHE_STAT_INC(tbl, forced_gc_runs);
>
> @@ -279,10 +281,16 @@ static int neigh_forced_gc(struct neigh_table *tbl)
>                         if (shrunk >=3D max_clean)
>                                 break;
>                 }
> +               if (++loop =3D=3D 16) {
> +                       if (ktime_get_ns() > tmax)
> +                               goto unlock;
> +                       loop =3D 0;
> +               }
>         }
>
>         WRITE_ONCE(tbl->last_flush, jiffies);
>
> +unlock:
>         write_unlock_bh(&tbl->lock);

I'm curious what the plan here is. Your patch looks OK to me and I
could give it a weak Reviewed-by, but I don't know the code well
enough to know if we also need to address your second comment that we
need to "use a second list to make sure to cycle over all elements
eventually". Is that something you'd expect to get resolved before
landing?

Thanks! :-)

-Doug

