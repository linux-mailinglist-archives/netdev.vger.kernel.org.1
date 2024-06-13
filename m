Return-Path: <netdev+bounces-103314-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73886907832
	for <lists+netdev@lfdr.de>; Thu, 13 Jun 2024 18:22:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DB992B238AE
	for <lists+netdev@lfdr.de>; Thu, 13 Jun 2024 16:21:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 873C9145A12;
	Thu, 13 Jun 2024 16:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FvHh6QUS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF79714198E
	for <netdev@vger.kernel.org>; Thu, 13 Jun 2024 16:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718295699; cv=none; b=G5UAI4KbjnE8bVMpi1m9m1LH0uKMDvh725HpkjlKBwlfKXF9pUtb/7Mh0Zu+Ftb1VREKhjP3LruWxuU1EJEARYyxbIVa+cVHaT1i9Xel5wso33rjWl0T15dCfgwk5MGKh603v6EiTTBFcPK3uhSMqv4H1cInDxrK5/aH5R4q4Ro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718295699; c=relaxed/simple;
	bh=Tpzw6WEwhAJ5CdVyvRewUB+klHN/e25EJUQJK3ONXEg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=H9ZEsSoG2IaoRcxzxggq0H5wM5JtBNjYdduP/IGYe/r9s1HKIJ3Z+T9tQ3IuZ62A24Vo5yTHRYNnRfdr3rRhuVwpIFwu8IaFhM/XKHA9t28WEfxOUYEwF1bOrV0wiaTrwpNnZBGjLAZYbQ6S0aRb4jIvOr/d8eSHtznpNYD6gPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FvHh6QUS; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-57c681dd692so1255607a12.3
        for <netdev@vger.kernel.org>; Thu, 13 Jun 2024 09:21:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718295696; x=1718900496; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d39iHPFKY375t4EZreYd1DxhYhNL/V70DP7Vz7/t2Sk=;
        b=FvHh6QUS++ldINyp+F/SmtpNV1GwnXSGUJKwu+z5TBVPunmZptDTUSHqD7+8ZZeK85
         dcejqtfUe9HBlsWFQJ7lRoFGp1dTQdODzMBn1zPoVNW5vU0H6E/uiNsMDsuB2OYzTDJS
         CbWuTJjpKajYYRzriVp3vkX6kWphUiR5JlXKTYhwYQEl5Zaf3Oc1e3ON8cz7GxI1ALg6
         96vVKfB5dyRE1YOIMRBtq5pGq0lWNtZ6T98BthdxAOVM/CCsi4VXgtM4zEwET/W7Bm3c
         faqWclUzZ/XLl9OrPEeJigj48QWIC9OnwJH7eYgwPrnpeJrz+vlE+DbtOlGZhBwLasuQ
         ZiOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718295696; x=1718900496;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d39iHPFKY375t4EZreYd1DxhYhNL/V70DP7Vz7/t2Sk=;
        b=YiDp3hps6l8HPIRwx4O90ue6USXm64WY6JpgHSQc3E9vw7mICcOdNHHK4KLw3dbNQb
         D8GG7Hon2TnO4rN5a+FF5spoWKWF0R2k3zPc0HDq76YnszkceBWIHd328SmsjYQgKH71
         GzxFe5eaff60/Lx+J7t4LewiYhwhMFGhSJfcyMKdsZhmqKv0WrjI6V8YwnNzwInFiUsI
         KFIUq0LXjO20jIWIlBdGpHGgVuPuJqarxH5U0KwhhC/sMJrKnWUEgtXSdz1kYr5xRt9o
         +CWwhHHkla/xGTMyV98vwz1vqwzwN9gHk4hWtsSgJLITOH8oeptvVF48RlRY2Uu+fQa/
         t2zw==
X-Forwarded-Encrypted: i=1; AJvYcCW6IYLRz9LChBUSiJpW5ymeZOC7UQz4J3nj2VLq+tjLH5QAqj4L8jJia+lCdA+dMSA9WUemPkt2AIqL4hASTC0Dtpd6Q/Mr
X-Gm-Message-State: AOJu0Yy7dbEfCu0qZKsMoVUDXpMVUIManmGTqybBFKMyHHSxM91c/GXx
	M/JEqYZrV8WrnhC2nAOOSplcs2FGTFQRo0nvCCp5pvuc0tcoes0jJbgzMOQr1hNXDlgm5SDGm1Z
	kxTs9K/5nf7fxYeHalUwQaxrZ/iw=
X-Google-Smtp-Source: AGHT+IH+aUmVgxeNSR7/LYhrIsAEMFzSQlgWjyV6gvvX36+WXaoemb1RiPkyqWOYKjS8cn29zewt/qGfiJh8BrwPPK0=
X-Received: by 2002:a50:cd0e:0:b0:57c:6a02:31d with SMTP id
 4fb4d7f45d1cf-57cbd8f2993mr186458a12.33.1718295695878; Thu, 13 Jun 2024
 09:21:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240613023549.15213-1-kerneljasonxing@gmail.com>
 <CAL+tcoAP=Jg3pXO-_46w5CbrGnGVzHf4woqg3bQNCrb8SMhnrw@mail.gmail.com>
 <20240613080234.36d61880@kernel.org> <CANn89iJj=ZBBLxgRQia_ttE1afxGSbJJxG_17NemZB_8OL6LaA@mail.gmail.com>
 <CAL+tcoDo0NYCGxLxJctq-9YNgvSKPr-5rRGkMamX7owQDGpmhw@mail.gmail.com> <CANn89iK_nf3o_i0phUvE2nqqx04hbn3chwm7q8pi2kDtfTwzFw@mail.gmail.com>
In-Reply-To: <CANn89iK_nf3o_i0phUvE2nqqx04hbn3chwm7q8pi2kDtfTwzFw@mail.gmail.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Fri, 14 Jun 2024 00:20:57 +0800
Message-ID: <CAL+tcoAPq3WpcSvqwUgiQJrEbJC4pYv0Omq9-Y53vFrCiQMVhQ@mail.gmail.com>
Subject: Re: [PATCH net-next v3] net: dqs: introduce IFF_NO_BQL private flag
 for non-BQL drivers
To: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>, pabeni@redhat.com, davem@davemloft.net, 
	dsahern@kernel.org, mst@redhat.com, jasowang@redhat.com, 
	xuanzhuo@linux.alibaba.com, eperezma@redhat.com, leitao@debian.org, 
	netdev@vger.kernel.org, Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 13, 2024 at 11:49=E2=80=AFPM Eric Dumazet <edumazet@google.com>=
 wrote:
>
> On Thu, Jun 13, 2024 at 5:37=E2=80=AFPM Jason Xing <kerneljasonxing@gmail=
.com> wrote:
> >
> > On Thu, Jun 13, 2024 at 11:26=E2=80=AFPM Eric Dumazet <edumazet@google.=
com> wrote:
> > >
> > > On Thu, Jun 13, 2024 at 5:02=E2=80=AFPM Jakub Kicinski <kuba@kernel.o=
rg> wrote:
> > > >
> > > > On Thu, 13 Jun 2024 22:55:16 +0800 Jason Xing wrote:
> > > > > I wonder why the status of this patch was changed to 'Changes
> > > > > Requested'? Is there anything else I should adjust?
> > > >
> > > > Sorry to flip the question on you, but do you think the patch shoul=
d
> > > > be merged as is? Given Jiri is adding BQL support to virtio?
> > >
> > > Also what is the rationale for all this discussion ?
> > >
> > > Don't we have many sys files that are never used anyway ?
> >
> > At the very beginning, I thought the current patch is very simple and
> > easy to get merged because I just found other non-BQL drivers passing
> > the checks in netdev_uses_bql(). Also see the commit:
>
> >     Suggested-by: Eric Dumazet <edumazet@google.com>
> >     Signed-off-by: Breno Leitao <leitao@debian.org>
> >     Link: https://lore.kernel.org/r/20240216094154.3263843-1-leitao@deb=
ian.org
> >     Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> >
> > I followed this patch and introduced a flag only.
> >
> > Actually, it's against my expectations. It involved too many
> > discussions. As I said again: at the very beginning, I thought it's
> > very easy to get merged... :(
>
> I think you missed the point of the original suggestion leading to Breno =
patch.
>
> At Google, we create gazillion of netns per minute, with few virtual
> drivers in them (like loopback, ipvlan)
>
> This was pretty easy to avoid /sys/class/net/lo/queues/tx-0/byte_queue_li=
mits/*
> creation. cpu savings for little investment.
>
> But when it comes to physical devices, I really do not see the benefit
> of being picky about some sysfs files.
>
> So let me repeat my question : Why do you need this ?

Sometimes people can see the sysfs files, sometimes not. They may get
confused. For non-BQL drivers, those sysfs files are totally needless
(not working) with one single flag.

Well, Eric, I don't expect this patch to keep involving more
discussions. If you or Jakub or other maintainers decide to reject
this patch, I'm fine. I can take it. We spend too much time on this
trivial patch. Many patches like this are trivial, not worth spending
you too much precious time on this. As I said, I thought it's very
simple and easy...

Thanks for your explanation.

Thanks,
Jason

