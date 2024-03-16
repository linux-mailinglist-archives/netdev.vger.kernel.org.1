Return-Path: <netdev+bounces-80222-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 00E6487DA88
	for <lists+netdev@lfdr.de>; Sat, 16 Mar 2024 16:11:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9EDB52821BC
	for <lists+netdev@lfdr.de>; Sat, 16 Mar 2024 15:11:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF1BC18EA1;
	Sat, 16 Mar 2024 15:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KnG2uS9Z"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6909D168BE
	for <netdev@vger.kernel.org>; Sat, 16 Mar 2024 15:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710601896; cv=none; b=mF2R/p4VFW7cS6ba78fC9CTyA+FZxdX4oKb3z92C1pzC/35lGQAKQigva7s+ycd8IVg3YmVdL1fsrK0WtMM2TUKgO64cPCP6BQXPmeDZi0Py/9jKtjXYHlt7yyMf0ByeZ/7Lwh1z/WNW1JRzB/pUnLzUsFNGYE1Ju4scdZBB9Ec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710601896; c=relaxed/simple;
	bh=F+I/1ynaYr1QMsBSvgL6RgQ2WXyo4LqekOL85IIoQSU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Byk6JzKJfrflkhdRIYVgryLpXaRpUtEaMIFNymMjQMUsJmAtoUcB6Wl7gjFENrUAKojITVWTwf/tt5E9zmz6od9dd9tOOQJ2K1tCXl9sEzucu7C8tIVdbjXeJ1pjw/bxxeVGv7t2MyOG71HiOwkXb3xa+ZCnOtyEkXsiFiV029M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KnG2uS9Z; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-5d3907ff128so2397080a12.3
        for <netdev@vger.kernel.org>; Sat, 16 Mar 2024 08:11:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710601894; x=1711206694; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nnyrmkO2WJ1aiVJu53KHDMTRTgrmRURAaCkNIqMa+M0=;
        b=KnG2uS9ZjptwvpMVDNOZ13DbtYz2B24GLcspru4P+iVUEPbVtbysEppda6qDUTEhCK
         TgkKEuH33RGgA34cBfiVGk0+6bnwZQmABSis/PJwzNoTTfwCZuENjgYDmGlby6K+Fb9G
         A26z7XuGYudjwFNitrJD9F4Zfy+7avezkskqZBgFiCxyJlD2AasCLbMiJdp0qnFOKHUY
         bbcEKCoAbzXjx1moZqq6qWa6PzBHQneLQ3FtiSdoEaBMYzGYiueeGBD+SxVxJ9Q8P9wX
         r3Sz554cZg70j63e+EIi6GAKCt2gyjSHDbYdepk9eueZ3hcFMU2fWQDboHKh8kpa0z+d
         tKjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710601894; x=1711206694;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nnyrmkO2WJ1aiVJu53KHDMTRTgrmRURAaCkNIqMa+M0=;
        b=rzP5M4vIRL7C9wIwkGnkGHy4NWydI8Xz3ic9nibtNsjYyUz+0E6/U/qo75y8yFsot1
         GKABc7pHV6FrheYLJayiukOhVCCXmRBt3yj1pqq4M4E3oK6kTgIbuqXnp8gXKXRI+Iga
         3eSxDnmjNi/j5Bmg9lMeiVKv4jr/n4/6Qs3V3oeWC1rq1lw0n1mzLRgLuVb9jNohjvmB
         5DVk1kNmfUKjpzZfkyk0fafgnMo4Fo6kezPYjaSX3t1iIILm8IKQ4HH1vsawDY7uFgpG
         7nc5n7oCCAuTVBTIWoa3jiEJ3OMwDppqVwE1oFjD9uTWpX2SHkiuOoG7k+tE2LwZ42TM
         8hxA==
X-Forwarded-Encrypted: i=1; AJvYcCUPQnZsxmGxl+w1pWEw/7aZ+K5pNcqHpZwyfMWCMFe9HxfGdyEMRGZnYjEP4g6KfS3cgnF35zw8WCdsbdjXx+bG4LUCTwVw
X-Gm-Message-State: AOJu0Yy1ze5STbWiDiKnJucwXq8sIzvya4EcyktRBcgCuud+bNAK7Jmz
	NXAAIAzGnz28SiBRT72kOcN6CnhdeV+tT1xJpuMLUgdCFPrfUBly9uehboeEo6ZxAddZrALYoEg
	6NDSXi++LQgOMsmwo74p0OSj+Cg==
X-Google-Smtp-Source: AGHT+IGZa0cQAWI4T7uRiJsAgEOiOc6mVrii1BCocHOQGeO4MemH99/Cl2XZqewqZ5gmsXyqkxyeD2OElsZsVhZ5XIc=
X-Received: by 2002:a05:6a21:170f:b0:1a3:4979:f25e with SMTP id
 nv15-20020a056a21170f00b001a34979f25emr7244773pzb.59.1710601894351; Sat, 16
 Mar 2024 08:11:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZfOalln/myRNOkH6@cy-server> <ZfRc1eUJJSoaGSpn@smile.fi.intel.com>
In-Reply-To: <ZfRc1eUJJSoaGSpn@smile.fi.intel.com>
From: Chenyuan Yang <chenyuan0y@gmail.com>
Date: Sat, 16 Mar 2024 10:11:23 -0500
Message-ID: <CALGdzurn0q49m10=K8vPDnvWyw9UyuaPVbYDnuE71oFp0TAAeQ@mail.gmail.com>
Subject: Re: [net/netlink] Question about potential memleak in netlink_proto_init()
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, "fw@strlen.de" <fw@strlen.de>, kuniyu@amazon.com
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, horms@kernel.org, anjali.k.kulkarni@oracle.com, 
	pctammela@mojatatu.com, dhowells@redhat.com, netdev@vger.kernel.org, 
	zzjas98@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thank you all for sharing your insights on this issue.

I'm pondering over the best solution: should we follow Kuniyuki's
suggestion to "eliminate the cleanup code," or would it be better to
adopt Florian's approach of "eschewing error handling in favor of
immediate panic"?

Best,
Chenyuan

On Fri, Mar 15, 2024 at 9:36=E2=80=AFAM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Thu, Mar 14, 2024 at 07:47:18PM -0500, Chenyuan Yang wrote:
> > Dear Netlink Developers,
> >
> > We are curious whether the function `netlink_proto_init()` might have a
> > memory leak.
> >
> > The function is
> > https://elixir.bootlin.com/linux/v6.8/source/net/netlink/af_netlink.c#L=
2908
> > and the relevant code is
> > ```
> > static int __init netlink_proto_init(void)
> > {
> >       int i;
> >   ...
> >
> >       for (i =3D 0; i < MAX_LINKS; i++) {
> >               if (rhashtable_init(&nl_table[i].hash,
> >                                   &netlink_rhashtable_params) < 0) {
> >                       while (--i > 0)
> >                               rhashtable_destroy(&nl_table[i].hash);
> >                       kfree(nl_table);
> >                       goto panic;
> >               }
> >       }
> >   ...
> > }
> > ```
> >
> > In the for loop, when `rhashtable_init()` fails, the function will free=
 the
> > allocated memory for `nl_table[i].hash` by checking `while (--i > 0)`.
> > However, the first element (`i=3D1`) of `nl_table` is not freed since `=
i` is
> > decremented before the check.
> >
> > Based on our understanding, a possible fix would be
> > ```
> > -      while (--i > 0)
> > +      while (--i >=3D 0)
> > ```
>
> The better pattern (and widely used in kernel) is
>
>         while (i--)
>
> > Please kindly correct us if we missed any key information. Looking forw=
ard to
> > your response!
>
> --
> With Best Regards,
> Andy Shevchenko
>
>

