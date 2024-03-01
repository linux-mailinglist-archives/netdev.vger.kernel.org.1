Return-Path: <netdev+bounces-76712-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F29AC86E973
	for <lists+netdev@lfdr.de>; Fri,  1 Mar 2024 20:24:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A90AB1F219CC
	for <lists+netdev@lfdr.de>; Fri,  1 Mar 2024 19:24:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C5933B193;
	Fri,  1 Mar 2024 19:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="T93xnxux"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2554B3A1B7
	for <netdev@vger.kernel.org>; Fri,  1 Mar 2024 19:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709321071; cv=none; b=B/sAL1W4xhnGKxL8aXKgzbrNunW6r1BlEbwh7oAmrH5XcXIOpqTI86I+4jmvBhzjZuLypM8ZLxbp3+1Ocl5YegDELhUCF1iiPyDbs7UQuDPBYzfl0UO36cJK9IhW5tkJL0l+eODZ/9duWob1hjozd0KtBL8TEOgM4NhxPvpL/Xw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709321071; c=relaxed/simple;
	bh=kJlvN6Ptew1iiph8Qm6reiLs2KrQnpMeI6G2YMVRg7M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BRXdR96nUV9txE5YO9pWpxEK1IXT0kJGK9J0WkbR3UCCRipXDFtxOSdKYodJp1Ei8IzA/2FFKTwTXX7ST9F5r+NjWFsAPyP3q9Fx3UhxIsERo5xW/4IMjv5zlNlQdMSLest2p8MwvhI9P+edKaf4mwLQJeljy5cdoElsM+LBAf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=T93xnxux; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-60974cb1cd7so19634307b3.3
        for <netdev@vger.kernel.org>; Fri, 01 Mar 2024 11:24:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1709321069; x=1709925869; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cbjX/lnoZ761OJUfB0gSxwfgwU0H+FScW9p4DrYodFU=;
        b=T93xnxux4j8v3ho6iRNiIJcJy6lbRzzKtZBk/PajXkEWJX7PZoyWV6v8yyzZIn218M
         B+r/gRigM/MDYkuFmrZN6QELlv2BCeOylESroLozqHT6S1LbgLozhQhgL3iqQsX/76ny
         1lffUxVtQ4ZE0Hhr9XZjHkuU5rgKApvNjl0GEhkG1rcYOGsrg6JRWHIVzC9qkrKFfDrS
         hLASVjH6CzJs2yYftsU6vyZYWnyv94raJUG6/yCTW8nZ5J88EjRTOULupvf89Z29nJEO
         QRceZKlTJq7aAsb6WWGLURPL2AZ296Yv0WzMcgIx38tfhSKZJINX8YCUS4QdeCQJZ8Ot
         yX/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709321069; x=1709925869;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cbjX/lnoZ761OJUfB0gSxwfgwU0H+FScW9p4DrYodFU=;
        b=qXav0wF4FIAE+CoTia6FtFdClwpppjvyyX5fIhTGiDDP8GBB6KKqn6xy1nnZUd9N2M
         FOAd9YxQbIYpIO1MkTrU+qIUVUzA66hBB+VNkWGf2dhnk1jmlqu3BRp0/02lUR1ycnTj
         8OIvz9emRuikbs85wqYYXWe1Rp8JEjzL3GVYWAMZv89SxNxcrM0NCVWHAx3kOrqefZyZ
         ixEP/u1AE22CNxH2RcBShXgQ/D/PCGf9bQAZXJYt4/fCgnWdAElTL5Cdcs97xdaIP5ij
         xXF2TcS/ZO+Pb0Uvy7bywJPuGLy7GX453EW3FY1fVR0b+t+YLO2I7mOjZkRAsfaIUOq8
         S9BQ==
X-Forwarded-Encrypted: i=1; AJvYcCURtI6PbpRWyIYDU4sXQaxB283ExYv2FknE3S4GaWx9I4b2Cp1kd4es3VS0Ix8vhYdy9QpkMyTwNJhxhThcB4gLHSP7xd6L
X-Gm-Message-State: AOJu0Yyx2tpOsvD9xW6JWdvysvLyBNMecdto0B2mdDLYRhGEOeMzoruM
	lzBxHFiJtU+b5BnJSL+Hu7GXhtEGe8jd5E07cwPVGkzUgUJUxEWZQn/jtMWaCeZhHMerussRr1j
	KSMLVJtqUg1Q7Sn+mMQDbmmtOJeFfZDFKZfnj
X-Google-Smtp-Source: AGHT+IFk5LvZyT1QJXgQCQi1lM8yjR9zyoN0HP30pvgo9Srn6tm/B4BynnFxbrnXJqBgueHu2i6BDMh9YqhTh/FwT5Q=
X-Received: by 2002:a81:4f89:0:b0:608:3782:4e1f with SMTP id
 d131-20020a814f89000000b0060837824e1fmr2869844ywb.34.1709321069065; Fri, 01
 Mar 2024 11:24:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240229143432.273b4871@gandalf.local.home>
In-Reply-To: <20240229143432.273b4871@gandalf.local.home>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Fri, 1 Mar 2024 14:24:17 -0500
Message-ID: <CAM0EoMkOgTezVLnN7f1GoXTURQ73LmXjHnBjQBSBRPnv58K-VQ@mail.gmail.com>
Subject: Re: [PATCH] tracing/net_sched: Fix tracepoints that save qdisc_dev()
 as a string
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>, netdev@vger.kernel.org, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Cong Wang <xiyou.wangcong@gmail.com>, vaclav.zindulka@tlapnet.cz, 
	Jiri Pirko <jiri@resnulli.us>, "David S. Miller" <davem@davemloft.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 29, 2024 at 2:32=E2=80=AFPM Steven Rostedt <rostedt@goodmis.org=
> wrote:
>
> From: "Steven Rostedt (Google)" <rostedt@goodmis.org>
>
> I'm updating __assign_str() and will be removing the second parameter. To
> make sure that it does not break anything, I make sure that it matches th=
e
> __string() field, as that is where the string is actually going to be
> saved in. To make sure there's nothing that breaks, I added a WARN_ON() t=
o
> make sure that what was used in __string() is the same that is used in
> __assign_str().
>
> In doing this change, an error was triggered as __assign_str() now expect=
s
> the string passed in to be a char * value. I instead had the following
> warning:
>
> include/trace/events/qdisc.h: In function =E2=80=98trace_event_raw_event_=
qdisc_reset=E2=80=99:
> include/trace/events/qdisc.h:91:35: error: passing argument 1 of 'strcmp'=
 from incompatible pointer type [-Werror=3Dincompatible-pointer-types]
>    91 |                 __assign_str(dev, qdisc_dev(q));
>
> That's because the qdisc_enqueue() and qdisc_reset() pass in qdisc_dev(q)
> to __assign_str() and to __string(). But that function returns a pointer
> to struct net_device and not a string.
>
> It appears that these events are just saving the pointer as a string and
> then reading it as a string as well.
>
> Use qdisc_dev(q)->name to save the device instead.
>
> Fixes: a34dac0b90552 ("net_sched: add tracepoints for qdisc_reset() and q=
disc_destroy()")
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>

Should this be targeting the net tree?
Otherwise, LGTM. Just wondering - this worked before because "name"
was the first field?

Reviewed-by: Jamal Hadi Salim <jhs@mojatatu.com>

cheers,
jamal
> ---
>  include/trace/events/qdisc.h | 20 ++++++++++----------
>  1 file changed, 10 insertions(+), 10 deletions(-)
>
> diff --git a/include/trace/events/qdisc.h b/include/trace/events/qdisc.h
> index a3995925cb05..1f4258308b96 100644
> --- a/include/trace/events/qdisc.h
> +++ b/include/trace/events/qdisc.h
> @@ -81,14 +81,14 @@ TRACE_EVENT(qdisc_reset,
>         TP_ARGS(q),
>
>         TP_STRUCT__entry(
> -               __string(       dev,            qdisc_dev(q)    )
> -               __string(       kind,           q->ops->id      )
> -               __field(        u32,            parent          )
> -               __field(        u32,            handle          )
> +               __string(       dev,            qdisc_dev(q)->name      )
> +               __string(       kind,           q->ops->id              )
> +               __field(        u32,            parent                  )
> +               __field(        u32,            handle                  )
>         ),
>
>         TP_fast_assign(
> -               __assign_str(dev, qdisc_dev(q));
> +               __assign_str(dev, qdisc_dev(q)->name);
>                 __assign_str(kind, q->ops->id);
>                 __entry->parent =3D q->parent;
>                 __entry->handle =3D q->handle;
> @@ -106,14 +106,14 @@ TRACE_EVENT(qdisc_destroy,
>         TP_ARGS(q),
>
>         TP_STRUCT__entry(
> -               __string(       dev,            qdisc_dev(q)    )
> -               __string(       kind,           q->ops->id      )
> -               __field(        u32,            parent          )
> -               __field(        u32,            handle          )
> +               __string(       dev,            qdisc_dev(q)->name      )
> +               __string(       kind,           q->ops->id              )
> +               __field(        u32,            parent                  )
> +               __field(        u32,            handle                  )
>         ),
>
>         TP_fast_assign(
> -               __assign_str(dev, qdisc_dev(q));
> +               __assign_str(dev, qdisc_dev(q)->name);
>                 __assign_str(kind, q->ops->id);
>                 __entry->parent =3D q->parent;
>                 __entry->handle =3D q->handle;
> --
> 2.43.0
>

