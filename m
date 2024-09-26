Return-Path: <netdev+bounces-129975-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F99998755C
	for <lists+netdev@lfdr.de>; Thu, 26 Sep 2024 16:22:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 401BF285CCB
	for <lists+netdev@lfdr.de>; Thu, 26 Sep 2024 14:22:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F65143AA8;
	Thu, 26 Sep 2024 14:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="A0Cck2Zn"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f179.google.com (mail-il1-f179.google.com [209.85.166.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC5E7374EA
	for <netdev@vger.kernel.org>; Thu, 26 Sep 2024 14:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727360522; cv=none; b=OCh+IR2DNS+IwxoKtKJHItUWvrry+MON0W1OOChGmLIsCZsSOteVWjtIL503a32EhqbK+KLLbITf10u+v29MZm+MWynGoW8C20SLWUZmbbxkSlj9cLpScWjA0GYbjHU19RvJjhsfi5S3EnDcYnWs0HqvpMWIcoJ4JbYmAGs9EZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727360522; c=relaxed/simple;
	bh=+y24IVUxor/kyNBm91ljRSRvsQRxdlhSxfQWOvqLT1A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=khl5iYuehsL+vv8VfzJJSLX2zw1qphy2De0wEAOSW+A6Nsul7346eJLQ4mzlpUfL+HyOf/GLULs9jnQPKODArlfgMDHFuqaCzUsh+7bCNtiNCmEiO/r2w3V3Et/TEKWVVOfkmHG3vRZnn7kMrTGcb2dnycLLbcwDgAqzQeFojsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=A0Cck2Zn; arc=none smtp.client-ip=209.85.166.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f179.google.com with SMTP id e9e14a558f8ab-3a2761f1227so3675575ab.0
        for <netdev@vger.kernel.org>; Thu, 26 Sep 2024 07:22:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727360520; x=1727965320; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SfFiyiH6kgWbgMXEmTeBEyoYGBSUVUt9KtKUrpIaXN4=;
        b=A0Cck2ZnZPgLFGJEkwcQlZYujALVQfeZ2J+lRM4seQ8SIZWDONkLY0VNKnmEEgvCgO
         2YRf4vffb4XL43m0AD+sxCHh74WVZHMdf+ByT4rJR0rxRLCK91XB8U5ZL6u8m9euWGqr
         LT50XV4ttmedigC7WYkEPwCL/zD06/r4Rn2ZhmvTHdITJODpggqSie6u1LqsGSHO0Azr
         EoR0lLk5NAmH6nWl7Az77o7Vu8VGVduLfMaOQV10bImTce4SlI6+T+I01lhb3gpaEcGv
         C7dkLrlnXmSnlWhppN0rwJKGGZyCMQevRiGmZMKr1TFs3+MzX/Nh97DtkAd4VFoSsaBx
         cOdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727360520; x=1727965320;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SfFiyiH6kgWbgMXEmTeBEyoYGBSUVUt9KtKUrpIaXN4=;
        b=gK/2RXg9qeFb8ZyPOEpUHtt9/JXmcWcFSoiSNIkKBR6XP0Hw0a3jVnMYV9FxLO100J
         IUi56bW/7p6ou3YUgWcs7rYj5qsktgGQNrz/mLa2v6LmmL29NqZN44lj1GCuZJv8p1P2
         STbTeX4rCNZZs+zRNctq5Djon0ZUN+Ac4Cldy/H0fX5uLyafQqh9pqXSBv+htWbvbHs0
         JMxuNwe2rB3Y3JBQpIIezi1QXofZOGK7rKp3FtuxazVjts2SqjBjU69JDLX9sA0VMa8K
         2X31rOReplvH1lM3iK4dNdFbH16gaCcEBJ7ECiThFSy8uKJZoUYxTg1nn0mEquy9PjeH
         PSDw==
X-Forwarded-Encrypted: i=1; AJvYcCWK5svKLX89c+o0N7Q88qYUXUhzH1PHI2kG1S7KbsENtzgoJ3gBGZ52Fg4JOgK024uVTGCYywM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQDO9KOVue9L4ODi6Zabumc5UlJkER7yhxc7BVI3fv7ijEmvYl
	ZL2u6tmCgpF6KFhyVCQYVFqVK5YtSsrTI5jtVccI61shayXdgZHD4jYpgWEucwsaaZg24ahMfAl
	5QdzcL/Wcn6IGhnMrY+IC3MpIoSYaaiPhAaXf
X-Google-Smtp-Source: AGHT+IEhYTwkcQOydX6/mPTb/HEwIxwSttcZQgsPb/3Rz68DWYmoZ9QWBU7Za8W38ZpoYqE1eYTtCFXbKkq0PRx3s64=
X-Received: by 2002:a05:6602:2dd2:b0:81f:8f5d:6e19 with SMTP id
 ca18e2360f4ac-83247ced469mr543953839f.2.1727360519577; Thu, 26 Sep 2024
 07:21:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240926075646.15592-1-lena.wang@mediatek.com>
 <CANn89iKt-0LCJaJS8udObGOKz530seK67ieUgvmxr5woos+hyQ@mail.gmail.com> <28c0330f1d1827fb61eee26a697cc7cf4735fb15.camel@mediatek.com>
In-Reply-To: <28c0330f1d1827fb61eee26a697cc7cf4735fb15.camel@mediatek.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 26 Sep 2024 16:21:43 +0200
Message-ID: <CANn89i+ZGWunObbYkemKE-ZYS3dGqWF0y8MQ8kEn1=fEwbztxw@mail.gmail.com>
Subject: Re: [PATCH net] tcp: check if skb is true to avoid crash
To: =?UTF-8?B?TGVuYSBXYW5nICjnjovlqJwp?= <Lena.Wang@mediatek.com>
Cc: "davem@davemloft.net" <davem@davemloft.net>, "kuba@kernel.org" <kuba@kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>, 
	"dsahern@kernel.org" <dsahern@kernel.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 26, 2024 at 4:05=E2=80=AFPM Lena Wang (=E7=8E=8B=E5=A8=9C) <Len=
a.Wang@mediatek.com> wrote:
>
> On Thu, 2024-09-26 at 11:07 +0200, Eric Dumazet wrote:
> >
> > External email : Please do not click links or open attachments until
> > you have verified the sender or the content.
> >  On Thu, Sep 26, 2024 at 9:55=E2=80=AFAM Lena Wang <lena.wang@mediatek.=
com>
> > wrote:
> > >
> > > A kernel NULL pointer dereference reported.
> > > Backtrace:
> > > vmlinux tcp_can_coalesce_send_queue_head(sk=3D0xFFFFFF80316D9400,
> > len=3D755)
> > > + 28 </alps/OfficialRelease/Of/alps/kernel-
> > 6.6/net/ipv4/tcp_output.c:2315>
> > > vmlinux  tcp_mtu_probe(sk=3D0xFFFFFF80316D9400) + 3196
> > > </alps/OfficialRelease/Of/alps/kernel-
> > 6.6/net/ipv4/tcp_output.c:2452>
> > > vmlinux  tcp_write_xmit(sk=3D0xFFFFFF80316D9400, mss_now=3D128,
> > > nonagle=3D-2145862684, push_one=3D0, gfp=3D2080) + 3296
> > > </alps/OfficialRelease/Of/alps/kernel-
> > 6.6/net/ipv4/tcp_output.c:2689>
> > > vmlinux  tcp_tsq_write() + 172
> > > </alps/OfficialRelease/Of/alps/kernel-
> > 6.6/net/ipv4/tcp_output.c:1033>
> > > vmlinux  tcp_tsq_handler() + 104
> > > </alps/OfficialRelease/Of/alps/kernel-
> > 6.6/net/ipv4/tcp_output.c:1042>
> > > vmlinux  tcp_tasklet_func() + 208
> > >
> > > When there is no pending skb in sk->sk_write_queue, tcp_send_head
> > > returns NULL. Directly dereference of skb->len will result crash.
> > > So it is necessary to evaluate the skb to be true here.
> > >
> > > Fixes: 808cf9e38cd7 ("tcp: Honor the eor bit in tcp_mtu_probe")
> > > Signed-off-by: Lena Wang <lena.wang@mediatek.com>
> > > ---
> >
> > I am not sure why tcp_send_head() can return NULL.
> >
> > Before tcp_can_coalesce_send_queue_head() is called, we have this
> > code :
> >
> > size_needed =3D probe_size + (tp->reordering + 1) * tp->mss_cache;
> >
> > /* Have enough data in the send queue to probe? */
> > if (tp->write_seq - tp->snd_nxt < size_needed)
> >     return -1;
> >
> >
> >
> > Do you have a repro ?
> Hi Eric,
> It just happens once in monkey test. I can't reproduce it.
>
> from the dump log, it can see these values:
> (gdb) p tp->reordering
> $16 =3D 4
> (gdb) p tp->mss_cache
> $17 =3D 128
> probe_size =3D 755
> size_needed =3D 755 + (4+1)*128 =3D 1395
>
> (gdb) p tp->write_seq
> $18 =3D 1571343838
> (gdb) p tp->snd_nxt
> $19 =3D 1571336917
> tp->write_seq - tp->snd_nxt =3D 1571343838 - 1571336917 =3D 6921 > 1395

OK thanks.

Next question is : with 6921 bytes in the write queue, how
tcp_send_head could possibly be NULL ?

This would hint at a more serious bug breaking a fundamental invariant.

