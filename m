Return-Path: <netdev+bounces-122089-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2725995FDDC
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 01:56:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 123FEB21DE8
	for <lists+netdev@lfdr.de>; Mon, 26 Aug 2024 23:55:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B56719D889;
	Mon, 26 Aug 2024 23:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kutsevol-com.20230601.gappssmtp.com header.i=@kutsevol-com.20230601.gappssmtp.com header.b="AuQigSbz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 333B28120D
	for <netdev@vger.kernel.org>; Mon, 26 Aug 2024 23:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724716550; cv=none; b=aC7+gHZtSOYk3zkqKp/H9npkyNXL48HbWOL+MhOM65oajEvOHsKAhreRRzDCj2XIqZ5PdoEVC4XJVz1TEhwCgnRAeUr12tNut03L2YM0/jA2zdDAHzbrxkv/Lj4zRBkPD06VhhZLwkO1OPNTmUc7dQk7wsPubQJUi3fmCeHSfhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724716550; c=relaxed/simple;
	bh=nrH3TZ6YHLWyBeHIRo5xrSVenIAktZ+LbymJzk/ofkc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y5r7UovwLqW9PbSLRnpbaKH8a91HyUn9bv7aRg7B5kbkW0Y72JBTHh5Fdhvlh8zKOSZMeJdwYHqw5OPh4fSt/slgRXEoD4xr7lP6ScxRc+OuF3sIKsAIopWYwqCWAbcofWipSCcw0HpOl0TmQawePd/rJlKy0n3teW8PFib1sDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kutsevol.com; spf=none smtp.mailfrom=kutsevol.com; dkim=pass (2048-bit key) header.d=kutsevol-com.20230601.gappssmtp.com header.i=@kutsevol-com.20230601.gappssmtp.com header.b=AuQigSbz; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kutsevol.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kutsevol.com
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-44ff7bdb5a6so27572391cf.3
        for <netdev@vger.kernel.org>; Mon, 26 Aug 2024 16:55:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kutsevol-com.20230601.gappssmtp.com; s=20230601; t=1724716547; x=1725321347; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pxKS43x5b6GIR/dn5+DFA/LtxoDW2/9sZiDISPay3P4=;
        b=AuQigSbz1XEfC79NDCxdvaXxS6TTnIxXIY4yxZZJXjQ9AfBdUJui1lYyasMfWqWle5
         4+j6/0hlPEcG8FuaBUfm86VKlx0PW6C/9wW+Iprag5gEUEyKjyydD5j6VeKX35sXyDcP
         M+D3hWbN3FiKR1s+1ZwjU+ZYV4fgZbrB6fc2N9KoPpQgeXVg2siOGoICRPpCt8PpRNQM
         C0BNIgpTT70vxSU1s/ern2nfjYMy+bzxFkiPgyIRHQvDY6wFNvRAYZ/ELZwcB1Uv2/bh
         mSRO5xidQpLIoj4/+nJm+wg79Gq/s4DphzxH74eAYGkLr1E15Vt5/Vh+JeXabgQSI6dR
         WeMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724716547; x=1725321347;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pxKS43x5b6GIR/dn5+DFA/LtxoDW2/9sZiDISPay3P4=;
        b=OwbyMbbHv2YUTdQiNusSi0eCSg4D0nssErxgNskA+bWgUY6g+Bcl9n6IHJ+NygJRGD
         ppbNFy+xubG00u9WWXLSviR3ZKxEohsGfGxA6ZBBBUnFIdlSEulKqa0Z7DKB+2KtvyK3
         mc9p+yfMPWDwhtIh+MVXStZtZpRwTR2LQTz5o1rYv5hV9a/8RAg8UHRaFOv/FB79wCpG
         Ivq+Sn/S01kge5lXuIPWu2fZGNCY0gXTGz6G97ZL4uBGbWQOpVxvyeT+qpzWnY1ABuQe
         4xsTAGf4j+VOmDQK3cZ65YK36/AczKa1vfGkCL6Dk7YgUF/T/FbYtan6yik7DPr9kxUI
         jGeA==
X-Forwarded-Encrypted: i=1; AJvYcCWatHdHsJ8iujch1DMMK4nuOGxw1XFoUEG1c8QSsV5aBqemPbam+rrxy7VmE0qZYZQzCLy/17U=@vger.kernel.org
X-Gm-Message-State: AOJu0YwsG2e+DFD9LfUF3fgiTwKK18D6ryHgyuF9/MIlWd9GwCJQKHHk
	ZUDLc7zzdaZnymatKRz8lLjEjMeUgu5k5bDRtuKNEbP3wWKFmL6/oF2zHWcaeJhJMDSbVId6/eZ
	HOAng4sH42SPbg4H9wd2x26M5rG//RtBQ3JB0eA==
X-Google-Smtp-Source: AGHT+IEOn6iheQ+POTNkt4bD5q0z6HwLv9JFIyTkR0lASztMPmZRjIB4WL0FfTO9oAm8pCv3vVk09jQ/Aosb8BUmJRA=
X-Received: by 2002:a05:622a:134b:b0:456:627d:5542 with SMTP id
 d75a77b69052e-456627d56c0mr5515331cf.44.1724716546842; Mon, 26 Aug 2024
 16:55:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240824215130.2134153-1-max@kutsevol.com> <20240824215130.2134153-2-max@kutsevol.com>
 <20240826143546.77669b47@kernel.org>
In-Reply-To: <20240826143546.77669b47@kernel.org>
From: Maksym Kutsevol <max@kutsevol.com>
Date: Mon, 26 Aug 2024 19:55:36 -0400
Message-ID: <CAO6EAnX0gqnDOxw5OZ7xT=3FMYoh0ELU5CTnsa6JtUxn0jX51Q@mail.gmail.com>
Subject: Re: [PATCH 2/2] netcons: Add udp send fail statistics to netconsole
To: Jakub Kicinski <kuba@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Breno Leitao <leitao@debian.org>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hey Jakub,
thank you for your time looking into this.

PS. Sorry for the html message, noob mistake.

On Mon, Aug 26, 2024 at 5:35=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Sat, 24 Aug 2024 14:50:24 -0700 Maksym Kutsevol wrote:
> > Enhance observability of netconsole. UDP sends can fail. Start tracking=
 at
>
> nit: "UDP sends" sounds a bit too much like it's using sockets
> maybe "packet sends"?


Sure, it makes sense, I will update it.

>
> > least two failure possibilities: ENOMEM and NET_XMIT_DROP for every tar=
get.
> > Stats are exposed via an additional attribute in CONFIGFS.
>
> Please provide a reference to another configfs user in the kernel which
> exposes stats. To help reviewers validate it's a legit use case.
>
doc/Documentation/block/stat.txt describes what stats block devices expose.
The idea is the same there - a single read gives a coherent snapshot of sta=
ts.
Did you mean that the commit message needs updating or info provided
here is enough?

> > +#ifdef CONFIG_NETCONSOLE_DYNAMIC
> > +struct netconsole_target_stats  {
> > +     size_t xmit_drop_count;
> > +     size_t enomem_count;
> > +};
> > +#endif
>
> Don't hide types under ifdefs
> In fact I'm not sure if hiding stats if DYNAMIC isn't enabled makes
> sense. They don't take up much space.
>
I'll remove the ifdef.

Without _DYNAMIC it will not create the sysfs config group, so there
will be no place to expose the stats from,
hence the attachment to dynamic config.
The reason to hide the type comes from the same idea. It's not about
saving space, but about the fact that
it can't exist without it the way it's currently implemented. There's
no way to expose those metrics if _DYNAMIC
is not enabled.

> > +static ssize_t stats_show(struct config_item *item, char *buf)
> > +{
> > +     struct netconsole_target *nt =3D to_target(item);
> > +
> > +     return
> > +             nt->stats.xmit_drop_count, nt->stats.enomem_count);
>
> does configfs require value per file like sysfs or this is okay?


Docs say (Documentation/filesystems/sysfs.txt):

Attributes should be ASCII text files, preferably with only one value
per file. It is noted that it may not be efficient to contain only one
value per file, so it is socially acceptable to express an array of
values of the same type.

Given those are of the same type, I thought it's ok. To make it less
"fancy" maybe move to
just values separated by whitespace + a block in
Documentation/networking/netconsole.rst describing the format?
E.g. sysfs_emit(buf, "%lu %lu\n", .....) ? I really don't want to have
multiple files for it.
What do you think?

>
>
> >  /**
> >   * send_ext_msg_udp - send extended log message to target
> >   * @nt: target to send message to
> > @@ -1063,7 +1102,9 @@ static void send_ext_msg_udp(struct netconsole_ta=
rget *nt, const char *msg,
> >                                            "%s", userdata);
> >
> >               msg_ready =3D buf;
> > -             netpoll_send_udp(&nt->np, msg_ready, msg_len);
> > +             count_udp_send_stats(nt, netpoll_send_udp(&nt->np,
> > +                                                       msg_ready,
> > +                                                       msg_len));
>
> Please add a wrapper which calls netpoll_send_udp() and counts the
> stats. This sort of nested function calls are unlikely to meet kernel
> coding requirements.


I see, will do. Noob question -  I couldn't find any written guidance
regarding this, if you have it handy - I'd appreciate
a link to some guidance regarding passing the result of a function to
a classifier vs wrapper function.

> --
> pw-bot: cr

