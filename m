Return-Path: <netdev+bounces-140242-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77A879B59CC
	for <lists+netdev@lfdr.de>; Wed, 30 Oct 2024 03:11:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A90A41C229C3
	for <lists+netdev@lfdr.de>; Wed, 30 Oct 2024 02:11:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 175BD192D79;
	Wed, 30 Oct 2024 02:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BBwwZJTA"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2782192584
	for <netdev@vger.kernel.org>; Wed, 30 Oct 2024 02:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730254273; cv=none; b=lyWdIeXC/YC4cBIQfkjrQ/cmyQneXDcfuNwx0D6sHxWiEMnQucToFTC415UERcnou3RyKnysDyP4J2TpyI8s5cLrzkbjBHH1TZUOFJfqqIp4erlHd/I8AZpCaKqAu1p0l0D0B8V3IUNuxsCBqBK017Svkt7I2oQT1cRmjGQUNXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730254273; c=relaxed/simple;
	bh=0ELS2+dojxRf1HfqnhDw+yJKv1qtQ97Pa011fkvnSDw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=s/gKNCq9Eql699QzbKeWJ9CsYFzZceY7QSZeyU4hcr8IOyT5qzT/6rmA9GXxcp0KW6GmkDmlxwPMSBczuSyx+7Ryt0zR0AL1zwMOi/9Rgdt0VDYnN/RFu70OImFTgQGd+vQclr2fmjl676DxjWbE6B9zI7PqRmz2DBLP3rLdKkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BBwwZJTA; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4316f3d3c21so57297605e9.3
        for <netdev@vger.kernel.org>; Tue, 29 Oct 2024 19:11:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730254269; x=1730859069; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GLmrUNophKyKjhd0XobNpTJJVkA9Neub6jASYgLs3YU=;
        b=BBwwZJTA/xupEFJVsQm+D2dSqzSJfitXNuBkfqLhLWTWa2q6pV7CnxaplupD6BUdC0
         R7F9JGpdvVWA/Oewe3fjfyEUPoe2e9nhbyXYW0E1V2BkyCeRilgDovWJEdEqsx23CIEb
         wUVGrT/SyfwqXTAF0NgUmbggUcDF4DfADBUhvlB+IXrMjXsNFXcZb9/LLHbNws9f+a1l
         32jgJlZuUeImOGJ54g0QDt0slYhZRhTPbz9sw+4+dwBXL5Zjep5fjD9Klk59aadxdYSU
         9WoqqQc15vzY91z0iN7fxHnfkNf+OKX2rhQutCujcz5RCyfx0AjkIgIZjxfiKsUo1o14
         rAWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730254269; x=1730859069;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GLmrUNophKyKjhd0XobNpTJJVkA9Neub6jASYgLs3YU=;
        b=DKBk/GR+d1re/2diDHH4BDmthJiZp/4rOaFofalBVJkciUaVza5mqS/y1AMD2ty+Sb
         Nv7jfR89K1FQ2ah/RgcBiQvA1STXTlHGp4YBV0PtGGzV9DYLBcnrBt31c2mmQyBAu77y
         g/gDssXvFbgN+wY5CrYWzkc6VlZIZcIpVPAvh0W/+jAs9AsIbOU8S6l7Uy64yroIL1X1
         IZl4AEgTsi9+BKmd882zwJl7V6JXpGjXDof5Rpxlu2PzAJHU1+5798eDv6DHUYyx09lY
         2hRdfdgq/UsGR1xnkyiVDL+U797gIS6xRN0jcQozbTK3Qc62znU5SDL0aKdM7rwTao/U
         rwHQ==
X-Gm-Message-State: AOJu0YyIjlN4HrmW9+lyCpxcGPXiAc8bNG9pVD2cTQHiiKB9xsKWTkmE
	9PFuDwNLL2TeiWR43aYVwNONqDTa71C1aUIWnwBZKQfJSeYyKWKpfyFwWfvEsSj13IYxSsIKO2C
	olbTYpwSDwwOkyZwPYOgQSWKI3lJNy0PS
X-Google-Smtp-Source: AGHT+IGsEX3Cr1NsxzeJI/nJkgBB4GnHODtL/MsPUc+IQgCZwlnHfjXnRPZRmOrzKUpGo0gn4+E01sXHaSbQO/udNf4=
X-Received: by 2002:a05:600c:4691:b0:431:2460:5574 with SMTP id
 5b1f17b1804b1-431bb9d1425mr11864875e9.27.1730254269011; Tue, 29 Oct 2024
 19:11:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241023023146.372653-1-shaw.leon@gmail.com> <20241029161722.51b86c71@kernel.org>
In-Reply-To: <20241029161722.51b86c71@kernel.org>
From: Xiao Liang <shaw.leon@gmail.com>
Date: Wed, 30 Oct 2024 10:10:32 +0800
Message-ID: <CABAhCOQ60u9Bkatbg6bc7CksMTXDw8v06SDsfv77YpEQW+anZg@mail.gmail.com>
Subject: Re: [PATCH net-next 0/5] net: Improve netns handling in RTNL and ip_tunnel
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
	David Ahern <dsahern@kernel.org>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Kuniyuki Iwashima <kuniyu@amazon.com>, Ido Schimmel <idosch@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 30, 2024 at 7:17=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Wed, 23 Oct 2024 10:31:41 +0800 Xiao Liang wrote:
> > This patch series includes some netns-related improvements and fixes fo=
r
> > RTNL and ip_tunnel, to make link creation more intuitive:
> >
> >  - Creating link in another net namespace doesn't conflict with link na=
mes
> >    in current one.
> >  - Add a flag in rtnl_ops, to avoid netns change when link-netns is pre=
sent
> >    if possible.
> >  - When creating ip tunnel (e.g. GRE) in another netns, use current as
> >    link-netns if not specified explicitly.
> >
> > So that
> >
> >   # modprobe ip_gre netns_atomic=3D1
> >   # ip link add netns ns1 link-netns ns2 tun0 type gre ...
>
> Do you think the netns_atomic module param is really necessary?
> I doubt anyone cares about the event popping up in the wrong
> name space first.

We used FRRouting in our solution which listens to link notifications to
set up corresponding objects in userspace. Since the events are sent
in different namespaces (thus via different RTNL sockets), we can't
guarantee that the events are received in the correct order, and have
trouble processing them. The way to solve this problem I can think of is
to have a multi-netns RTNL socket where all events are synchronized,
or to eliminate the redundant events in the first place. The latter seems
easier to implement.

>
> BTW would be good to have tests for this. At least the behavior
> around name / ifindex collisions in different namespaces.
> You can possibly extend/re-purpose netns-name.sh for this.
>
> For notifications you could use python and subscribe to the events
> using a YNL socket. May be easier than dealing with ip monitor
> as a background process. But either way is fine.

I will try to add some tests. Thanks!

