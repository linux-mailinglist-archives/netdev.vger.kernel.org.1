Return-Path: <netdev+bounces-219494-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D6FBB41990
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 11:06:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 39B721644DB
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 09:06:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57AC22ECD23;
	Wed,  3 Sep 2025 09:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="emOaslNc"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f181.google.com (mail-il1-f181.google.com [209.85.166.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 043251E0DCB
	for <netdev@vger.kernel.org>; Wed,  3 Sep 2025 09:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756890385; cv=none; b=oqXFdJOVhgXY4/uU4CpJ0XE9ioW8TFkbP/hXKRHswkwfJiXMigH5pMtZePr2tDkTEup/iz/32JYH4L5mFWzti8x9NZg0o31pYnqVwcVqKYoSSVACljBcf+ZXtsa5mjCKSSaP1h69Meyiw5fhLFB6cUKBRhp7UefICf3YppMUpo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756890385; c=relaxed/simple;
	bh=/U70fxvYdCFEAAqyO3X/isLermfWAcT1p0cDMajt18I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fZnVxWIPF51/We9Rw2ReL0XQXQLIBfqiUaAt1mrQ1n0EG37AclC970CvSR3U3m1LK4AVuM2lZmm4y1xk138OW37fdh1IXPn31YQkuIZ7Hq4hZ7vGJe7pSDFkj+EQ+cZn3l5uYxlDHqehqGKP4n4OHLdpHOtiQADX3zbyuUx+LDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=emOaslNc; arc=none smtp.client-ip=209.85.166.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f181.google.com with SMTP id e9e14a558f8ab-3f2da50ad46so30076475ab.3
        for <netdev@vger.kernel.org>; Wed, 03 Sep 2025 02:06:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756890382; x=1757495182; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U7wFQD/FKZ3mbJJluKWaTq8i548AC3/hwW4H5ht2wq8=;
        b=emOaslNcmhAgvBVkcVbKYNc/tLYBeUPK0AXmmJfwvMGXE7l4uDBQEdGA5ViFMDECzi
         Ljv0xkb//AK0vgPcTNrzOcaYw2BcO8lO0Jcbha8kUCPW8W/v0JI4LZluVUg7nLT1EdSW
         oHMl4qV46Mn+b9vFBhK+QxX999Ky4ry7MZkc0NLFflhQ2LmMqREk1EzZTfpYWAgIZPV/
         //IaQzGABmLF7WyZBz5lT9O08bf1lOPx+69GP5AL+8UR/lraatwwxYtf0kA+aGxQ2gfB
         HeMjezaiQrhA3AyAObIxIuIeGynv3qnRbqZzed3yiNU4k2vNMcLRzQRLrTFV3v6HQJgF
         fGaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756890382; x=1757495182;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U7wFQD/FKZ3mbJJluKWaTq8i548AC3/hwW4H5ht2wq8=;
        b=aObry5hs37R9ZFX2W1dbrjV0i5XfwcR2P/qDi2a5z8chMIjTWzeXzQcYe0AjRwq/JL
         yJ4CHb0n7gypyGKcyL88lTD9Ry6Z6BHSEV7mIpEJMNse0M8yms5yM4FIL4HDT7r0qHIK
         IcsrRSQ9RXhhcAAKJkeAJlpUUo2VZGEZ6QGXPDXp4+vr4vdgvLpmTGQLbATwab0KJMuZ
         cDLNC/Pmfuj/0YDkkH0PrK3Lh+vrObd52d6xR07KjrgAh6HRqBGuCggwUO9xdH5ekhKQ
         gllsfXXDGQf6G4xvS7b8vQTVV16haCfNSQgf0HaD43nSv/XiSy5X5cGwYNUrFbZkpcvN
         P+AA==
X-Forwarded-Encrypted: i=1; AJvYcCVmQTCpzlIqKpf68gsZoVZauw+e9jrKOghsxzkGxj61CRe4MnvgI3qClyDnUoC1JUtUVKbcIVc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx09QT8ngl1EGxFYjbXJbdLbgz38AHarVWgcZwK2mT34h34cyiP
	p8xX67axEAByYTUyOGww9CFo7pJQjqG8ZLwNx2qPRW2TgtFIuNWi7fyC+rSuvlmuakQv0awwmRR
	JamT0+UsTfazR4VLD+Cd5jjSU2AQ428g=
X-Gm-Gg: ASbGnctPP1IC/TBsDmC36ut6dAHtLTRTyNX+ZcbQjk6ga3MHbafpCHre4WeKUXs7hbF
	IIJ2lxJh8B5YCbDx9m3Iz77Tq8uioEfiIkGIZ/NCHH59vLnss5s5Idaf5rltTv8TbGc2Xy/lvcq
	n+ASvKn+3BJ+hKI5lq+Qe1rUNB8eQ5yf6AC8kDTnK7jr4cxQ8LeNsi6PSgl3qARvTSqI7wzt6Db
	orIB9U=
X-Google-Smtp-Source: AGHT+IHbYAQjlFCWrh6+OWh/McixcOdBeeRBYlvEBTNoJVG4NCUMoq31EFZSjGNOch0Kbrv68xlow/d+IVLSZkhD73g=
X-Received: by 2002:a05:6e02:3781:b0:3f3:4562:ca92 with SMTP id
 e9e14a558f8ab-3f400674c40mr287940895ab.10.1756890381879; Wed, 03 Sep 2025
 02:06:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250903024406.2418362-1-xuanqiang.luo@linux.dev>
 <CANn89i+XH95h4UANWpR-39LSRkvM3LL=_pRL0+6fp6dwTZxn_g@mail.gmail.com>
 <CAL+tcoAPdLYPu+HE=pA=T9T7J+b19Mg2BRgP3PM2d8_z6iXgYQ@mail.gmail.com> <CANn89i+AMitXNYNo6h7GPBHsk2sVSbmH-8BQLRFDeihEd9-oQQ@mail.gmail.com>
In-Reply-To: <CANn89i+AMitXNYNo6h7GPBHsk2sVSbmH-8BQLRFDeihEd9-oQQ@mail.gmail.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Wed, 3 Sep 2025 17:05:45 +0800
X-Gm-Features: Ac12FXw0TFsQhWX7f1w-vzdpRFRCTaYEy0e6BcuidnUrpQripziHU6qGFcITcn0
Message-ID: <CAL+tcoCLFZTsfUxLogZmmVsR3YAabpErYWVsGv3XzGNR9iuEbg@mail.gmail.com>
Subject: Re: [PATCH net] inet: Avoid established lookup missing active sk
To: Eric Dumazet <edumazet@google.com>
Cc: Xuanqiang Luo <xuanqiang.luo@linux.dev>, kuniyu@google.com, davem@davemloft.net, 
	kuba@kernel.org, kernelxing@tencent.com, netdev@vger.kernel.org, 
	Xuanqiang Luo <luoxuanqiang@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 3, 2025 at 4:35=E2=80=AFPM Eric Dumazet <edumazet@google.com> w=
rote:
>
> On Tue, Sep 2, 2025 at 11:53=E2=80=AFPM Jason Xing <kerneljasonxing@gmail=
.com> wrote:
> >
> > On Wed, Sep 3, 2025 at 2:40=E2=80=AFPM Eric Dumazet <edumazet@google.co=
m> wrote:
> > >
> > > On Tue, Sep 2, 2025 at 7:46=E2=80=AFPM Xuanqiang Luo <xuanqiang.luo@l=
inux.dev> wrote:
> > > >
> > > > From: Xuanqiang Luo <luoxuanqiang@kylinos.cn>
> > > >
> > > > Since the lookup of sk in ehash is lockless, when one CPU is perfor=
ming a
> > > > lookup while another CPU is executing delete and insert operations
> > > > (deleting reqsk and inserting sk), the lookup CPU may miss either o=
f
> > > > them, if sk cannot be found, an RST may be sent.
> > > >
> > > > The call trace map is drawn as follows:
> > > >    CPU 0                           CPU 1
> > > >    -----                           -----
> > > >                                 spin_lock()
> > > >                                 sk_nulls_del_node_init_rcu(osk)
> > > > __inet_lookup_established()
> > > >                                 __sk_nulls_add_node_rcu(sk, list)
> > > >                                 spin_unlock()
> > > >
> > > > We can try using spin_lock()/spin_unlock() to wait for ehash update=
s
> > > > (ensuring all deletions and insertions are completed) after a faile=
d
> > > > lookup in ehash, then lookup sk again after the update. Since the s=
k
> > > > expected to be found is unlikely to encounter the aforementioned sc=
enario
> > > > multiple times consecutively, we only need one update.
> > >
> > > No need for a lock really...
> > > - add the new node (with a temporary 'wrong' nulls value),
> > > - delete the old node
> > > - replace the nulls value by the expected one.
> >
> > Yes. The plan is simple enough to fix this particular issue and I
> > verified in production long ago. Sadly the following patch got
> > reverted...
> > https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git/commit/?=
id=3D3f4ca5fafc08881d7a57daa20449d171f2887043
>
> Please read again what I wrote, and compare it to your old patch.
>
> - add the new node (with a temporary 'wrong' nulls value),
> - delete the old node
> - replace the nulls value by the expected one.
>
> Can you see a difference ?

IIUC, you use a temporary value. It would avoid two sockets appearing
in the list at the same time.

Thanks,
Jason

