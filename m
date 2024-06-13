Return-Path: <netdev+bounces-103303-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AF4A907779
	for <lists+netdev@lfdr.de>; Thu, 13 Jun 2024 17:50:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 25D5AB24ABF
	for <lists+netdev@lfdr.de>; Thu, 13 Jun 2024 15:50:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0933412E1D9;
	Thu, 13 Jun 2024 15:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="q50OePrX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 459405BACF
	for <netdev@vger.kernel.org>; Thu, 13 Jun 2024 15:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718293747; cv=none; b=fb8rcRSBpbhAsWcM6Q/5IuuWHANqKDw1WbVN1Gx6tT87Qt2VUipmMQkPNVDi1/VtID+eCzNRe2dUAYq+wQU7Pelg9GpdPHbAvxKgWmR04ZaqAGLnEAp3teUr20KCEVunvYsMJYwfyyRs/crmX9m7dceym/N7qZEPwjUmjUc+ppw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718293747; c=relaxed/simple;
	bh=taRiR0fMUjYqnzaDUdUDlQL2evkahckx2l3llhAlymk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LaKUI0P8Zexins3bKPHocEk8aQrwCgGz7gzjKZPHNR9zCHBJj+8fY4JVCHAJHq2xdPL84Ya7dYPFQyfSf5pnOiaMbuxR5KSrwXtT+ruIXUQ80WQLP6pItFX4JyAua7AW+xC3XjPkFy7uBWM7nb1rEEcb3WWahxg/K7ltfTtK6ak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=q50OePrX; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-57a16f4b8bfso19428a12.0
        for <netdev@vger.kernel.org>; Thu, 13 Jun 2024 08:49:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718293744; x=1718898544; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9V4C6vZeHq3mEgnXmw31HlkbTiS0R3kLszADUDb231A=;
        b=q50OePrXjCe+m5p2zeyI1VJqWhWirkDJ+HzpsoI6i0dcxokAIlQJ98AuS07n0+dG4g
         +xfOuinm1EBlzs8NlZlWpa2og4e+fg1tdJj4rw3zMUNrydW8xYr16//zinO5syE8TYZn
         sI2n8Kcez9LXJTZyyJnLsJbsL4iJeJUxMdxNZpz8QrUBtCVOKOiaD+TGTL5p9hmySXI2
         NqfExK93Kjk5dhSxIXswQl3FnY82t98CZyg4zr1xpYrJOJdXEX+NWZB2a53Yk4UcpiFb
         TlqOANidN6Zvl91IlJDNWMwYQt7/b0E1JS0rsQ2pavbCD3BkmTZxkhIZXZqUCMb/77t3
         wvIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718293744; x=1718898544;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9V4C6vZeHq3mEgnXmw31HlkbTiS0R3kLszADUDb231A=;
        b=l+tXF02m5IvWd+IZVfQl3uqIYF8BqrnOFA9CZS4KywbgoPfhW2R+nAV8qb8w9UvPe9
         9NL6h3CtZpf9IpROOvzLgOD9EfXKdXWLs+PgHxxnbmf5Bj8VChwhR5NvbHx1W0m6YAod
         JxmMMbfst5LC/9qSyueX66DCh2tP0Nq7Zns0fPLlzmWo9nyVKhx5zmCKNRC7OxGRVbQ1
         vdn6ebcoO0Lk36B4sFSui9JXUx46WN7pNRHxClw0uEqbhxJ4YT+K1vr7nrgcY6IUrW8+
         ryV4CKqwZL/vBuVjCrhFP4puGanZLXknXcej5QNLqikWuRfl+J/57aw3HG0hVctJab+T
         Kgyg==
X-Forwarded-Encrypted: i=1; AJvYcCUGT8vzKxrNAHl/WevhtaZam3XIbUOMH2kHae/QHE1lfnBgr+U3yU8VDOEDEwCDt1Y4Pb1mvRZg4YXO5mr0TpSn76SQO7tL
X-Gm-Message-State: AOJu0Yyx69ykCuyaDmeq+SDj+4xlVJhJ3dlQFyGbwLijra2TGepdFu0/
	rIvO9wB/lWHKsX3cN39tgO5xdxjN2c5CL/u8lusf9GTTDpWO9oWQ1A9dNFtqiax5xxXkK0Wozai
	cYy5jMQ9GPojCdbkbrzckBDG3O/uPlRIjNsdW
X-Google-Smtp-Source: AGHT+IHGYduRhq/lq2biN9CFzFCrXI2CYs4s1LWbliBGVq1S/ezywgwVf5ixrZc0drhE5MfhkIvCZ45yqD16nFfUIX8=
X-Received: by 2002:a05:6402:3593:b0:57c:b712:47b5 with SMTP id
 4fb4d7f45d1cf-57cb7124955mr181577a12.4.1718293744361; Thu, 13 Jun 2024
 08:49:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240613023549.15213-1-kerneljasonxing@gmail.com>
 <CAL+tcoAP=Jg3pXO-_46w5CbrGnGVzHf4woqg3bQNCrb8SMhnrw@mail.gmail.com>
 <20240613080234.36d61880@kernel.org> <CANn89iJj=ZBBLxgRQia_ttE1afxGSbJJxG_17NemZB_8OL6LaA@mail.gmail.com>
 <CAL+tcoDo0NYCGxLxJctq-9YNgvSKPr-5rRGkMamX7owQDGpmhw@mail.gmail.com>
In-Reply-To: <CAL+tcoDo0NYCGxLxJctq-9YNgvSKPr-5rRGkMamX7owQDGpmhw@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 13 Jun 2024 17:48:50 +0200
Message-ID: <CANn89iK_nf3o_i0phUvE2nqqx04hbn3chwm7q8pi2kDtfTwzFw@mail.gmail.com>
Subject: Re: [PATCH net-next v3] net: dqs: introduce IFF_NO_BQL private flag
 for non-BQL drivers
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: Jakub Kicinski <kuba@kernel.org>, pabeni@redhat.com, davem@davemloft.net, 
	dsahern@kernel.org, mst@redhat.com, jasowang@redhat.com, 
	xuanzhuo@linux.alibaba.com, eperezma@redhat.com, leitao@debian.org, 
	netdev@vger.kernel.org, Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 13, 2024 at 5:37=E2=80=AFPM Jason Xing <kerneljasonxing@gmail.c=
om> wrote:
>
> On Thu, Jun 13, 2024 at 11:26=E2=80=AFPM Eric Dumazet <edumazet@google.co=
m> wrote:
> >
> > On Thu, Jun 13, 2024 at 5:02=E2=80=AFPM Jakub Kicinski <kuba@kernel.org=
> wrote:
> > >
> > > On Thu, 13 Jun 2024 22:55:16 +0800 Jason Xing wrote:
> > > > I wonder why the status of this patch was changed to 'Changes
> > > > Requested'? Is there anything else I should adjust?
> > >
> > > Sorry to flip the question on you, but do you think the patch should
> > > be merged as is? Given Jiri is adding BQL support to virtio?
> >
> > Also what is the rationale for all this discussion ?
> >
> > Don't we have many sys files that are never used anyway ?
>
> At the very beginning, I thought the current patch is very simple and
> easy to get merged because I just found other non-BQL drivers passing
> the checks in netdev_uses_bql(). Also see the commit:

>     Suggested-by: Eric Dumazet <edumazet@google.com>
>     Signed-off-by: Breno Leitao <leitao@debian.org>
>     Link: https://lore.kernel.org/r/20240216094154.3263843-1-leitao@debia=
n.org
>     Signed-off-by: Jakub Kicinski <kuba@kernel.org>
>
> I followed this patch and introduced a flag only.
>
> Actually, it's against my expectations. It involved too many
> discussions. As I said again: at the very beginning, I thought it's
> very easy to get merged... :(

I think you missed the point of the original suggestion leading to Breno pa=
tch.

At Google, we create gazillion of netns per minute, with few virtual
drivers in them (like loopback, ipvlan)

This was pretty easy to avoid /sys/class/net/lo/queues/tx-0/byte_queue_limi=
ts/*
creation. cpu savings for little investment.

But when it comes to physical devices, I really do not see the benefit
of being picky about some sysfs files.

So let me repeat my question : Why do you need this ?

