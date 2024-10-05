Return-Path: <netdev+bounces-132352-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA5FF991545
	for <lists+netdev@lfdr.de>; Sat,  5 Oct 2024 10:25:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 08BA11C20B97
	for <lists+netdev@lfdr.de>; Sat,  5 Oct 2024 08:25:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C597F130A73;
	Sat,  5 Oct 2024 08:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HnVfoOKI"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C9932F5B
	for <netdev@vger.kernel.org>; Sat,  5 Oct 2024 08:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728116735; cv=none; b=edt7RigsQpdmQUmFvl+aUD1vW+dpy5nIjwj+OavTJzy72Ot6orXDVJFN4fYqLe/S5j+0nwmOnhH/on6QzGJVSDWj6KY/r2AON7csNv10b6G1oYEY/rVueouAZU8y/zQYE87d7s59qGy/L/+xdNGqJCbG/QpE92O47K3KuRrUmcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728116735; c=relaxed/simple;
	bh=ORqGMlT2X5U0gpBmv/cfQXpjbLeT37i06j2XDh2tkkc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Mh+ojLcxUdh6H+O4fx1/huV9Yel3FVa8QLEtYgpIKrrFpPcKVoc0M1SMbHXAj1UxSAny64Yj3WIlrOsz/XgI3lmTa34yjUGvgj3Z34TNpGAqxezrSIH/KuQYjyCHXOh7nsTMQ+dDOxRw3UmMqFHVTORiTjpaqxMXw4rbSxzLcQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HnVfoOKI; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a993f6916daso23893666b.1
        for <netdev@vger.kernel.org>; Sat, 05 Oct 2024 01:25:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728116732; x=1728721532; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o5XetfSqmsT0FoqAMypYpHKFZI7ysc4QJ+C1htKml54=;
        b=HnVfoOKIrdlS5vqluzfoy2NmJWpMKvzyzIDzAPP61YS3lT56jjQyO2QIiIdtxArjnF
         8jWsc17G+Doemyz+XaTSnXDM1ZD22u6eg264Oqo3JfgmQKcijWbEm2iFSEm1TYCEBgZa
         PwycnWiiFmkmMtuWT/XylbldR9x2j7njdSacNKc+P0hDwgjh07T6WJkJNqfLNtweESfy
         L7REO8+bjsXGj/hdoFDtUqjryPUChEqLjBrousshxj01gI/USHPnH3l5YXD1trj0uHBK
         gSyE7swF2UJ6iPR1kCdj76ZdipyIZ98WuMMBNKlwDG1+mnC2v257W5f2Q7xq4YhP6RXS
         kr9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728116732; x=1728721532;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o5XetfSqmsT0FoqAMypYpHKFZI7ysc4QJ+C1htKml54=;
        b=Ls5tdSokGYwgViBwMoq8wAgKx+qQkwd6jb6uoXSviSj9mt8ARC37ZKrZfUCWqCWiKP
         0qTDoScxSy9QyATnHZcp7jThkY7pIsqyB8hrpTAQuZPyHNs7scynkTJPJvRKVpxvMMfn
         EWbEh3nN661ve6nLlwFRxxgAXW8XVbcf1BxlqcpGNUIPZ8Xv6A/1TfrnDF424abYByT4
         d/jH1K0P9zzIsrTqe///afbWLrErTxpKYlFQ0SSLpxlC2SlYtlECxV0TxJEtg5fnz/8S
         /zukS9f9gG9uReYY4bXXMatCYXP5dKpe2IBIK42rxCYlvrklBQn9bZdIUL6MqrDn1NTt
         eerA==
X-Forwarded-Encrypted: i=1; AJvYcCXemfPx6gx6Hz7PwvGxogRvcuu+iy2dUgqNGpMyK/bvYiLzex1k9KJk/kAXF+jaqCHAqRWBMCE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxu0rZd+BSNKl51uuTUG/rcIFPawjxfgSxXtm93/EuiDNDiWK3R
	3F1pETr2W6GIne4XC7XUYe/vB72IDSturHB15HyznAnqe5izqk3EFNqx3n8Idw8bbU+/fRY29Ui
	EA1XiF1V8vjVEtrBmbA2bHLjzL1HBqz6k1JyT
X-Google-Smtp-Source: AGHT+IE8bC4pa+mAyos14itoLD7At0JnMwZmO1Yx7CXi6SNTvg/aWwSHAekJkLf6vdHIjSA0PQB+kiT2XONeeiXsMik=
X-Received: by 2002:a17:907:980a:b0:a99:4152:1cb4 with SMTP id
 a640c23a62f3a-a99415220a5mr48917566b.42.1728116732008; Sat, 05 Oct 2024
 01:25:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241004222358.79129-1-kuniyu@amazon.com> <20241004222358.79129-2-kuniyu@amazon.com>
In-Reply-To: <20241004222358.79129-2-kuniyu@amazon.com>
From: Eric Dumazet <edumazet@google.com>
Date: Sat, 5 Oct 2024 10:25:20 +0200
Message-ID: <CANn89iKEaY22wrYoi9NbZ3CN+fwXqmLnM_P+zgucv_Unna64UQ@mail.gmail.com>
Subject: Re: [PATCH v2 net 1/6] rtnetlink: Add bulk registration helpers for
 rtnetlink message handlers.
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 5, 2024 at 12:24=E2=80=AFAM Kuniyuki Iwashima <kuniyu@amazon.co=
m> wrote:
>
> Before commit addf9b90de22 ("net: rtnetlink: use rcu to free rtnl message
> handlers"), once rtnl_msg_handlers[protocol] was allocated, the following
> rtnl_register_module() for the same protocol never failed.
>
> However, after the commit, rtnl_msg_handler[protocol][msgtype] needs to
> be allocated in each rtnl_register_module(), so each call could fail.
>
> Many callers of rtnl_register_module() do not handle the returned error,
> and we need to add many error handlings.
>
> To handle that easily, let's add wrapper functions for bulk registration
> of rtnetlink message handlers.
>
> Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
> ---
>  include/net/rtnetlink.h | 19 +++++++++++++++++++
>  net/core/rtnetlink.c    | 30 ++++++++++++++++++++++++++++++
>  2 files changed, 49 insertions(+)
>
> diff --git a/include/net/rtnetlink.h b/include/net/rtnetlink.h
> index b45d57b5968a..b6b91898dc13 100644
> --- a/include/net/rtnetlink.h
> +++ b/include/net/rtnetlink.h
> @@ -29,6 +29,14 @@ static inline enum rtnl_kinds rtnl_msgtype_kind(int ms=
gtype)
>         return msgtype & RTNL_KIND_MASK;
>  }
>
> +struct rtnl_msg_handler {

Since we add a structure, we could stick here a

            struct module *owner;

> +       int protocol;
> +       int msgtype;
> +       rtnl_doit_func doit;
> +       rtnl_dumpit_func dumpit;
> +       int flags;
> +};
> +
>  void rtnl_register(int protocol, int msgtype,
>                    rtnl_doit_func, rtnl_dumpit_func, unsigned int flags);
>  int rtnl_register_module(struct module *owner, int protocol, int msgtype=
,
> @@ -36,6 +44,17 @@ int rtnl_register_module(struct module *owner, int pro=
tocol, int msgtype,
>  int rtnl_unregister(int protocol, int msgtype);
>  void rtnl_unregister_all(int protocol);
>
> +int __rtnl_register_many(struct module *owner,
> +                        struct rtnl_msg_handler *handlers, int n);
> +void __rtnl_unregister_many(struct rtnl_msg_handler *handlers, int n);
> +
> +#define rtnl_register_many(handlers)                                    =
       \
> +       __rtnl_register_many(NULL, handlers, ARRAY_SIZE(handlers))
> +#define rtnl_register_module_many(handlers)                             =
       \
> +       __rtnl_register_many(THIS_MODULE, handlers, ARRAY_SIZE(handlers))


This would allow a simpler api, no need for rtnl_register_module_many()

