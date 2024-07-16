Return-Path: <netdev+bounces-111648-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2846931EDE
	for <lists+netdev@lfdr.de>; Tue, 16 Jul 2024 04:31:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 108541C2164B
	for <lists+netdev@lfdr.de>; Tue, 16 Jul 2024 02:31:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 876926FBE;
	Tue, 16 Jul 2024 02:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="20y6mUqq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA7AA20310
	for <netdev@vger.kernel.org>; Tue, 16 Jul 2024 02:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721097040; cv=none; b=DSI1JbrvD9gQ4I4E0fdVYrnLcBHEok1yl5onqloBpqmfRGi9O5eEuL9nCBcku/CCMBdwf6EGdtVdcJUG+U1cMCgQ3/jgFxLEylhXiBlQY3BpeAhk0SMKNvcfawuPZqAZHG0TzrJ8JfxRvLqGz6jF0NI9+KpW5fWFWjo6TEQmqrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721097040; c=relaxed/simple;
	bh=3iqw1t/CyrkP/qQUgCQYv/zzWd4pYBWDepSahEba1wM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YwNS8USOhHx41R/vgNRJc8bo+wrm5MwXKpyYc+ddYmVuXA9bSFht92N/5vM3IeDouLdxCxaXd9+i5cETi++0l7N6vKT2kAdjvE+q28LPZUYyvZ2UfcuqmD8Y+B4n/mn27APrha6/rLfpm1AdTJ15nEFKSUBulb0tTuqXkIvVoW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=20y6mUqq; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-57a16f4b8bfso8491a12.0
        for <netdev@vger.kernel.org>; Mon, 15 Jul 2024 19:30:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721097037; x=1721701837; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C1pYeevvK77sMTv04yGyie+GvLz7zwfPlA255cFn8ls=;
        b=20y6mUqqZ4Hlapopze6MwurCtiQxWesiGSVefW0xb0QimWX+9QkK4ML/ClNpfxBowE
         O98QfJ5YRKhJxj2GeQbzBLSPKVsT/i8GbU89uhnKq5lvW0HnyPlzXlbmZZ5GA+r1OaGa
         HNOvaNrtbw0tb+3N/kl6QIPtyfnhrku7BA3MQIxnfM6FW16aag9jb0hdIxWiIkAgM5yZ
         68JJBSxJhgp01xjd2I0blEc4xSPGJbfiLH/NOEDcDNyd5NVXVYsdeiQ3M0SWZL+sVzdF
         OGkxs4/6Qi9Mshb2OZlweMA+WWKp3EEALVlo2/sWEc5Z5BaVLcXi3PO42XiirsEgz7A8
         4HWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721097037; x=1721701837;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C1pYeevvK77sMTv04yGyie+GvLz7zwfPlA255cFn8ls=;
        b=SVWgq2M3Clz1BEeJ9RO8byuIW1gpsTQjyy2IbrMCRrBWn8K/l1aflPrLzWLneY0/6e
         Ma8uQU2zyaeBBACXlfh2s6wszfTzazqdH4EUh7AHyGEg8OnsksjGhOLzG3rivIM4ea12
         XsxEOznQXo7OYUL2Flbf7y1lw5QYwJZiKTbY1ugyf6uInif+u93KE3M5G0PBa8IfPmBd
         qli//DOC7+gFypglKIjhVL5YA+WzJ8zGuZV1iNWbTzBirUnIUzPk7Hx9pXVBcD0iHToW
         yJYLAT1GZd1dxRKwiJHx+UxW1KajDHTqXWi/tknbpL9GenNt/gvMpyHa7dWq/ZCLCnQo
         UXZA==
X-Forwarded-Encrypted: i=1; AJvYcCXO7XH/58MnXqxXdIEyyD76JfPknWpQFEKnxi1E0eYc1f6eLK6KIHKP/ClMSrrModkHlb7y/SPGcS77xRZCn/4O3Os8lZuV
X-Gm-Message-State: AOJu0YxIoW2RTInOLv1//r/4PMKVaJnud9pVq/NuVgKRdgzEqPAhSisM
	i850sOfIStap/OYqXLs1GlS/7eWTffl15GXmVeksag3zF8Z9U4UihFgE9IupjlksYeXLc/XkF78
	fckLc5ed+DRRD7OLKQQ5gtPATwsIxnDuWGBGR
X-Google-Smtp-Source: AGHT+IHchWRK+QagrkmTdo8Drjk6/O7gp0y4ZtZeA4qUKecjhmMM8xytG2fGoy6xfybpClQwkF1ivmZiDztRHX4l/es=
X-Received: by 2002:a05:6402:5106:b0:58b:90c6:c59e with SMTP id
 4fb4d7f45d1cf-59eed87975dmr81644a12.7.1721097036784; Mon, 15 Jul 2024
 19:30:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240716021548.339364-1-make24@iscas.ac.cn>
In-Reply-To: <20240716021548.339364-1-make24@iscas.ac.cn>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 15 Jul 2024 19:30:24 -0700
Message-ID: <CANn89iKzNXMNjYmf+2uA1kutKcfW_XbYVQ==00meJvC3XpM2nw@mail.gmail.com>
Subject: Re: [PATCH] ipv6: prevent possible NULL dereference in ndisc_recv_na()
To: Ma Ke <make24@iscas.ac.cn>
Cc: davem@davemloft.net, dsahern@kernel.org, kuba@kernel.org, 
	pabeni@redhat.com, johannes.berg@intel.com, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 15, 2024 at 7:16=E2=80=AFPM Ma Ke <make24@iscas.ac.cn> wrote:
>
> In ndisc_recv_na(), __in6_dev_get() could return NULL, which is a NULL
> pointer dereference. Add a check to prevent bailing out.
>
> Fixes: 7a02bf892d8f ("ipv6: add option to drop unsolicited neighbor adver=
tisements")
> Signed-off-by: Ma Ke <make24@iscas.ac.cn>
> ---
>  net/ipv6/ndisc.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/net/ipv6/ndisc.c b/net/ipv6/ndisc.c
> index d914b23256ce..f7cafff3f6a9 100644
> --- a/net/ipv6/ndisc.c
> +++ b/net/ipv6/ndisc.c
> @@ -1000,6 +1000,8 @@ static enum skb_drop_reason ndisc_recv_na(struct sk=
_buff *skb)
>         struct ndisc_options ndopts;
>         struct net_device *dev =3D skb->dev;
>         struct inet6_dev *idev =3D __in6_dev_get(dev);
> +       if (!idev)
> +               return SKP_DROP_REASON_NOT_SPECIFIED;
>         struct inet6_ifaddr *ifp;
>         struct neighbour *neigh;
>         SKB_DR(reason);

Please do not mix code and variables.

Also, idev is correctly tested in the current code, therefore your
patch is not needed.

Thank you.

