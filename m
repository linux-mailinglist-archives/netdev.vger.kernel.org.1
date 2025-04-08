Return-Path: <netdev+bounces-180163-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02211A7FD00
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 12:54:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 634A5420F41
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 10:47:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D73D1267712;
	Tue,  8 Apr 2025 10:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MHeRZ4vZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD392266F17
	for <netdev@vger.kernel.org>; Tue,  8 Apr 2025 10:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744109069; cv=none; b=G69xhDODijYAbLvUVLb3+ULcEfdb43mMVmrZGrkE80PmPpgA4ZJWjfPYUTHgLZvjfJoQ0q0XK5Cf72IcoUhsjwnA8hMqF+XfzRgrGIZC8FemCT6DDuor6tBbgXduNd316EPSSMM0txFdVo49JeVmA0rZ//7gzqge18AAtj2+cl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744109069; c=relaxed/simple;
	bh=419p2jfIVuqswVnYCpxVb4C1tmk/VU4wbdwBrDE6ZDA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=b6cTBedmnPUkqJyBi8SoR261rQWkUQdqxlnfmUgGbjER33ltezk6sV073zcJfFDyvX2my9BefKPa6GD9f93yO7h/P44I9VrZiSyC+aUj/vhOGY/TeVxeSNu6HeBY2gEh7CJ1GNwjos0ouCHKyk1Zpm5gJ4aBUJpNXbLiNhXXWNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MHeRZ4vZ; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-5499c5d9691so6100559e87.2
        for <netdev@vger.kernel.org>; Tue, 08 Apr 2025 03:44:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1744109066; x=1744713866; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=419p2jfIVuqswVnYCpxVb4C1tmk/VU4wbdwBrDE6ZDA=;
        b=MHeRZ4vZf5FEQKyHlkzdCIIwaregR8Y6Fw4PSdv9coXXVvLZjJNDda4AZmjoNgI5sX
         VXmXCBthHCqSiesSSAvexe5gIsKWR/sLRzo1eu0H3DFgGsWXncfOin4cBCHI+uCLvOis
         H0t/UFaCra02LPQ5Cs/YzRnKMwlzH1ZXP1ZnybkA117QCdmv23HLverdC8oR2eefjWv6
         +8DCeIOiNYM7013YNV99BtOm52JnIfBg3m2ZHPtLXQIO05gySvwaMYZElkMzrqCQ8CET
         ZZkOaOooLuEov06BNWLr/KMl7BIS6GjVQEV//ZLiXx5IeePaBXtzm+MqKmsNbBZ2uxET
         xWPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744109066; x=1744713866;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=419p2jfIVuqswVnYCpxVb4C1tmk/VU4wbdwBrDE6ZDA=;
        b=Bf1PelKkzlScvBGZa16cLup2/cybCB80DdvFqW9vLIiUIx1clQb6yTy2qdKkJ3JV9O
         7D/yw/eBsPBCaUIoIkP/ElCqZSsHu07XZi1QKZLKM4Bx+pE/M4xgnhaBRllgAeBMURHe
         SF+Bw0t3FPycD8Zd2qFisuAWdRm6qOcYo96UiZYOqmt3jBFCTaXi47HpijCtglxeCSah
         rA/q1pT8F7ri/mQCQTIctbmI3gLSgTL0+S45Rb2BQwQQqhJEVSRYJPbxfzTVR7Qb+qVS
         k76ByPZ/jJ6OIM3ABtZ0bkvLM8yXuruxZkkHaUiHbtTey8IJRIvKj83Jt0AUpLo9tqjY
         qyVQ==
X-Forwarded-Encrypted: i=1; AJvYcCXPAC2NnDAZTHr7tz75nEL2/IrYhR60RuXjdZo82HNEdg489VLnFxiiDMCRlrwhvnvCDhM3sQY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwsBHvYvYyqZUIjJiaoQ1Z4NKIKXBNF58vx3OGMiQAUrnqDVVeP
	ez79Nfx/HCZ5RYO8Q9V7Eli/ihUH/ByBACuTdig8n0rHUMyWo6geo1E1vbAaFn4pqNms3f2gzQV
	Sp7bvXL7wqT5pMHRWbkqiIU08JX+Uz1pSV/vQ
X-Gm-Gg: ASbGnctNKlJTeS2rmhtMS8XW/ylWjeEOhA1w0+2/4PPRCuGXQOuLx47WGQrwOYUXkD4
	+iOhNHcPv7VT/OyqsNjwe7fg2XxdPtb28iCRSMj8zuaAM+P1zKijzAGGuIKK2tnzG1POhigl4j6
	A1bfC5eddLUY7SmziestT0tXvw4irVcxfSIWuzPr8V6jZ6cU1GCMrALM7v
X-Google-Smtp-Source: AGHT+IE6Mo63+aNLgjUy0hwr7ZFaZKS1coMjIhw5cBTkTQK/+wn9m6TH3/wwl0cHKC7QrTe670eB2PBOcctoSbdy6wA=
X-Received: by 2002:a05:651c:1585:b0:2ff:56a6:2992 with SMTP id
 38308e7fff4ca-30f0a1d8ac4mr49263491fa.37.1744109065757; Tue, 08 Apr 2025
 03:44:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <Z_PfCosPB7GS4DJl@mini-arch> <20250407161308.19286-1-kuniyu@amazon.com>
 <CANp29Y5RjJD3FK8zciRL92f0+tXEaZ=DbzSF3JrnVRGyDmag2A@mail.gmail.com>
In-Reply-To: <CANp29Y5RjJD3FK8zciRL92f0+tXEaZ=DbzSF3JrnVRGyDmag2A@mail.gmail.com>
From: Dmitry Vyukov <dvyukov@google.com>
Date: Tue, 8 Apr 2025 12:44:14 +0200
X-Gm-Features: ATxdqUFyy-54YLVuSp15WzCbaleB-jiZZ-DebC9ojvDiy-cfPHkfhgKLdRQnP6k
Message-ID: <CACT4Y+acJ-D6TiynzWef4vAwTNhCNAgey=RmfZHEXDJVrPxDCg@mail.gmail.com>
Subject: Re: [syzbot] [net?] WARNING: bad unlock balance in do_setlink
To: Aleksandr Nogikh <nogikh@google.com>
Cc: Kuniyuki Iwashima <kuniyu@amazon.com>, stfomichev@gmail.com, andrew@lunn.ch, 
	davem@davemloft.net, edumazet@google.com, horms@kernel.org, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	sdf@fomichev.me, syzbot+45016fe295243a7882d3@syzkaller.appspotmail.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 8 Apr 2025 at 10:11, Aleksandr Nogikh <nogikh@google.com> wrote:
>
> On Mon, Apr 7, 2025 at 6:13=E2=80=AFPM 'Kuniyuki Iwashima' via syzkaller-=
bugs
> <syzkaller-bugs@googlegroups.com> wrote:
> >
> > From: Stanislav Fomichev <stfomichev@gmail.com>
> > Date: Mon, 7 Apr 2025 07:19:54 -0700
> > > On 04/07, syzbot wrote:
> > > > Hello,
> > > >
> > > > syzbot has tested the proposed patch but the reproducer is still tr=
iggering an issue:
> > > > unregister_netdevice: waiting for DEV to become free
> > > >
> > > > unregister_netdevice: waiting for batadv0 to become free. Usage cou=
nt =3D 3
> > >
> > > So it does fix the lock unbalance issue, but now there is a hang?
> >
> > I think this is an orthogonal issue.
> >
> > I saw this in another report as well.
> > https://lore.kernel.org/netdev/67f208ea.050a0220.0a13.025b.GAE@google.c=
om/
> >
> > syzbot may want to find a better way to filter this kind of noise.
> >
>
> Syzbot treats this message as a problem worthy of reporting since a
> long time (Cc'd Dmitry who may remember the context):
> https://github.com/google/syzkaller/commit/7a67784ca8bdc3b26cce2f0ec9a40d=
2dd9ec9396
>
> Since v6.15-rc1, we do observe it happen at least 10x more often than
> before, both during fuzzing and while processing #syz test commands:
> https://syzkaller.appspot.com/bug?extid=3D881d65229ca4f9ae8c84

IIUC this error means a leaked reference count on a device, and the
device and everything it references leaked forever + a kernel thread
looping forever. This does not look like noise.

Eric, should know more. Eric fixed a bunch of these bugs and added a
ref count tracker to devices to provide better diagnostics. For some
reason I don't see the reftracker output in the console output, but
CONFIG_NET_DEV_REFCNT_TRACKER=3Dy is enabled in the config.

