Return-Path: <netdev+bounces-159032-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BCFEA142AB
	for <lists+netdev@lfdr.de>; Thu, 16 Jan 2025 21:00:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D10113A5DD3
	for <lists+netdev@lfdr.de>; Thu, 16 Jan 2025 20:00:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81AB881727;
	Thu, 16 Jan 2025 20:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="lNvai7Rh"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6352F24A7EE
	for <netdev@vger.kernel.org>; Thu, 16 Jan 2025 20:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737057626; cv=none; b=bJImnw1gTTSHo81ATv1dy0iVkvKeXKYmwrPuNaKPHxdsBrj7J1BlW6OwAayrDCTrRmtwcURqJxdwVtaiEEuQDtclK/JG3l9ZmM6nPyAiifXv1bmc+aN3evn7nPEKJrf8osoeCqFvznr/jQ/Smn2ZgzbHDmjKjZP+QZqVt8UmdDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737057626; c=relaxed/simple;
	bh=vs9Oibl3hWQNdAvc7b4GPXdRh3C4fMeHj9bOGq1LruM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OCwAjTG3OXuoalO0wUgP17P7A/kt2FU7z3C5rdMLnowNC/lAKYpFCQYWcYHDQTvA7wnoeqyf//MWHWL5kJ2u0BJW1bIsUCbLj7IgOIJWvDdYRdMLl1v9ETzmzzNcdgz91y1mifQkZ6ccNCGZlWcO4GgVz/73xi60Mw2nUUhe8Rs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=lNvai7Rh; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-218c8aca5f1so32631555ad.0
        for <netdev@vger.kernel.org>; Thu, 16 Jan 2025 12:00:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1737057623; x=1737662423; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=foStEkQNvwSKxgEkbLnhwc2C374vT9+WxNKRa1K+d5k=;
        b=lNvai7RhZs+9k0Z21O1FJMM0idoDzRNAhhm3KixGhAXHA5bWwG8mylyU0Cs0fW/xOJ
         oQyLOWOsTSNCKnZmqrcAze6YVlZuOic9bdoGz2khOeufkk4UXxVtBr8q0rgF6i5un4nV
         dryoeAZ936Ws5x655TYjjO3eg3ayZr7JCIRnkcbF0ORp6AgSqJZRzAQR7mcFXJkT9kji
         18HtPLnJsHYRABnJ7CkW+7e6+aee63Ge4IpMewjeneC8S40iHKmFybuFPCq2IA5/rFje
         EbBmNQqzfJin4UBB05QMqZ2GRrFCOoBXGmOufNFpus7smKkQc289ZRJjoyy1GmeyUqtz
         /CBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737057623; x=1737662423;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=foStEkQNvwSKxgEkbLnhwc2C374vT9+WxNKRa1K+d5k=;
        b=uK+GcMdpkvKQwDHIpyI167oI4JpyOSzZljX7EO57Gc8vwnCzGLc0chm72JjkrllClo
         THxUkL3NugTmvamITgF0Z7R0lq2oYgw2lvc0hEv0+iCkIqFBO1EAEhOhHDgvBIcIBQdS
         RO3HX/GwHGCHL2Gr81kNB9mWw5o0z2zqp4DpW8YU6ZYTXyN+UmR4mDdi+DclE4TE1ri8
         IcQDZRWHy3M9KRqGrTC62tIUCyN9kBha2zXyadNnKZIkO1lk2ixZdLK+zVjsm6D9cxKp
         ZeI0CUoUlE1/Yku8JiGUykyLUTpM4O4Y1tBhCHzwrk85yQuu+iT/fzdmCPTG6odh5v2t
         NZIw==
X-Gm-Message-State: AOJu0YyTklG2RPI7ARWyunovQntXE86wE6tLhmn9JQDEMWaBfuYaSukw
	M3MOm3OKoy5sd8v6bBi4km2UXHWsuUYNr/K/+0vtZcGLNf/iQpyvjKy8y8Y3YZzdggCFPFTIt7z
	6OqAx7JNM10wQxDQ3eZaOFhGlP4ZJEez4QCi/YgkSOo+mDsQ=
X-Gm-Gg: ASbGncvds+gux5OjdXDI8m4WYUmkT/cqBY+5tpcjojx7yFA2/cbyGRjGDv5EUwp9Oeh
	Tcxrwy31Z+oktgAgN+gKUdMTtPv1lxE7Mwz8w
X-Google-Smtp-Source: AGHT+IERnwfTtoLJYTeR65lwk2QUmi36MigiO2YTTrrp6naxZ9DZ2pH7J35NwYfTKER2zSMAYYdEqmE1K2PRDQ6qzmo=
X-Received: by 2002:a05:6a00:4218:b0:725:db34:6a8c with SMTP id
 d2e1a72fcca58-72dafa06dd3mr193544b3a.13.1737057623628; Thu, 16 Jan 2025
 12:00:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250116195642.2794-1-ouster@cs.stanford.edu>
In-Reply-To: <20250116195642.2794-1-ouster@cs.stanford.edu>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Thu, 16 Jan 2025 15:00:12 -0500
X-Gm-Features: AbW1kvatE_GnYaHDSkSwaoZenJGXmy6B6jRXpMT68Vx5ZgvMx4bIH6gu8c6nDhs
Message-ID: <CAM0EoMkkk-dT5kQH6OoVp-zs9bhg8ZLW2w+Dp4SYAZnFfw=CTA@mail.gmail.com>
Subject: Re: [PATCH netnext] net: tc: improve qdisc error messages
To: John Ousterhout <ouster@cs.stanford.edu>
Cc: netdev@vger.kernel.org, xiyou.wangcong@gmail.com, jiri@resnulli.us
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 16, 2025 at 2:57=E2=80=AFPM John Ousterhout <ouster@cs.stanford=
.edu> wrote:
>
> The existing error message ("Invalid qdisc name") is confusing
> because it suggests that there is no qdisc with the given name. In
> fact, the name does refer to a valid qdisc, but it doesn't match
> the kind of an existing qdisc being modified or replaced. The
> new error message provides more detail to eliminate confusion.
>
> Signed-off-by: John Ousterhout <ouster@cs.stanford.edu>
> ---
>  net/sched/sch_api.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/net/sched/sch_api.c b/net/sched/sch_api.c
> index 300430b8c4d2..5d017c06a96f 100644
> --- a/net/sched/sch_api.c
> +++ b/net/sched/sch_api.c
> @@ -1560,7 +1560,7 @@ static int tc_get_qdisc(struct sk_buff *skb, struct=
 nlmsghdr *n,
>         }
>
>         if (tca[TCA_KIND] && nla_strcmp(tca[TCA_KIND], q->ops->id)) {
> -               NL_SET_ERR_MSG(extack, "Invalid qdisc name");
> +               NL_SET_ERR_MSG(extack, "Invalid qdisc name: must match ex=
isting qdisc");
>                 return -EINVAL;
>         }
>
> @@ -1670,7 +1670,7 @@ static int tc_modify_qdisc(struct sk_buff *skb, str=
uct nlmsghdr *n,
>                                 }
>                                 if (tca[TCA_KIND] &&
>                                     nla_strcmp(tca[TCA_KIND], q->ops->id)=
) {
> -                                       NL_SET_ERR_MSG(extack, "Invalid q=
disc name");
> +                                       NL_SET_ERR_MSG(extack, "Invalid q=
disc name: must match existing qdisc");
>                                         return -EINVAL;
>                                 }
>                                 if (q->flags & TCQ_F_INGRESS) {
> @@ -1746,7 +1746,7 @@ static int tc_modify_qdisc(struct sk_buff *skb, str=
uct nlmsghdr *n,
>                 return -EEXIST;
>         }
>         if (tca[TCA_KIND] && nla_strcmp(tca[TCA_KIND], q->ops->id)) {
> -               NL_SET_ERR_MSG(extack, "Invalid qdisc name");
> +               NL_SET_ERR_MSG(extack, "Invalid qdisc name: must match ex=
isting qdisc");
>                 return -EINVAL;
>         }
>         err =3D qdisc_change(q, tca, extack);
> --

LGTM.
Acked-by: Jamal Hadi Salim <jhs@mojatatu.com>

cheers,
jamal

> 2.34.1
>
>

