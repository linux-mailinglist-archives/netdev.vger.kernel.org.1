Return-Path: <netdev+bounces-180477-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9286A81709
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 22:41:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0639B8A3B7E
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 20:41:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABE09244195;
	Tue,  8 Apr 2025 20:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JPPyVr+Y"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0136023E327
	for <netdev@vger.kernel.org>; Tue,  8 Apr 2025 20:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744144908; cv=none; b=p0Cif9ccah2QdlONT3F1uCgRRGVhqt+UEhDEu8IEbodAK2SBZDEUNBsn/x9+A4GTHEt4hldlFlSr9pCmJ06RuzuzKyvluAWOnrzJ19MsT+ysUxhZ9s/SzqmxRU2e97ZlEEzLEFDvdQcU+93ddmOSgmh6tNn37sskCwnm/wL1b7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744144908; c=relaxed/simple;
	bh=GFB0IF7Cn0n4Q6auzito82YpH6bLTABJG6OGJs/6TS4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HBZPhgQy0i6ElxCQe+q5dvlpWBdTTRosgtrIqOTR/B8ka5OYXhK/oH4YcGF1xL/jNzdooTb07giE6ruVeCt0Jmalj6getCnwNwn6a7u2WzyI62xNv2uGILcTxhzAZo3/HHZhuOyQEQW5VIVylMOSrlJHZ4nEkkmQIioKol56gAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JPPyVr+Y; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-476a1acf61eso53569031cf.1
        for <netdev@vger.kernel.org>; Tue, 08 Apr 2025 13:41:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1744144905; x=1744749705; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EVTdQLCsbN0cVigq4hecvHon4nuKEqP1DouZoJpgWNU=;
        b=JPPyVr+YbsUVUi5cLz/VJMGK3vKMpRSZ7wlURa9SdaHZ/5R4GEG7tWYdMgjwM8WxOt
         Retasq//MfGjgzCmBeye36JdkYef9qzXzaUhKUGA5ezFf13TmmkUFhLvnpbAniOSLquC
         9ap/HbBHNGZ9ySGix20Efn1rGpMkfcjPDA2wCb8ov36LAg6bGTtFDBlcnFvGukQ/XGeR
         Sa3g227DoP5CidGSluHS0XXr4K/qTZfPbZs/zNu9JgsAzVCEDL6e+qulkbh59NvN7mnc
         89VaFPwyPFLJ3+QhNIPCy5C1N+Dsz0ABIJOID8FedxbcLrJtVKDWOHjAfu7IDBFgJK0g
         tERA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744144905; x=1744749705;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EVTdQLCsbN0cVigq4hecvHon4nuKEqP1DouZoJpgWNU=;
        b=rwMFtKLPl9QHrmMnMjn84xjqLZlaQwiX/OR9O56q9BZdTdBZVtKqFYkiSTrj/RgCSf
         NMoOw8KAYFgjSMD+SsACPhCEDnyjXVnXDX7AieJ0gkL2SsHvUYdJgf+F0F/IdO0AUv49
         Ye5S/LWaHvNvnEGhVHSRCZDqngPugZEe+sLTrtcEWrGHpLkSbNgr3z7wgBNRSbsFjtqI
         TrdDVKcrWGQafkwRjxTqUd38xKftXH4Y5cG0jzzWyY+z7iCdA8A9U/L7M6aCndLnKGPq
         t83U0pEYaNOVOGchokKMZS9biWNB/Xs91WP6WWrcfKM+qEAnrqi4cxf6sMpSAGywGzmB
         mTLw==
X-Forwarded-Encrypted: i=1; AJvYcCVpk2Er7cySRI1BPguGp7rwzYO0ooxUEfl7Ch656xI/4BAmmwcZtCCOtYwmYNla4Xrmx7ouym4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8AQAYMNahj10typ7CZSiZ62ujxwnfqstGwP+UzLfuMP+n4d28
	1ckm+mWbI/gs8N/qKDWF3cCjC8Ub0zCE5KADY0rv8J3htqmeHrfDw1Xk7RjLAjiHJ2mpLHyJLiC
	VOesdDX9HbgOJvfhLdknA3U+XHxNHQb9Y2xQY
X-Gm-Gg: ASbGncs+zzwWD83kk/nAY7yM7A7PzFd0pqpcRUtpYr97WmRdhz6owwpqw7x1/hafRs7
	b+9/JRUpTAxyEQWx1eZeFq7XD+RNlMbjFrPaSurWVtUMMwtXJ+FQ/v2g5bLKZy90hX30PDGm6di
	588zFiClTSBAWJDTS44WsO1zr38bY=
X-Google-Smtp-Source: AGHT+IHJucqGqBT/cZhrNZIpCoklFKHoTaYd9R9xPvw5vruQlW3Ys48NKk7evtKCO1P/cXlXV9rnwOG3DxLGerAttFE=
X-Received: by 2002:a05:622a:1390:b0:476:8288:9558 with SMTP id
 d75a77b69052e-4795f37e439mr5938161cf.46.1744144904629; Tue, 08 Apr 2025
 13:41:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <Z_PfCosPB7GS4DJl@mini-arch> <20250407161308.19286-1-kuniyu@amazon.com>
 <CANp29Y5RjJD3FK8zciRL92f0+tXEaZ=DbzSF3JrnVRGyDmag2A@mail.gmail.com>
 <CACT4Y+acJ-D6TiynzWef4vAwTNhCNAgey=RmfZHEXDJVrPxDCg@mail.gmail.com>
 <CANn89iK=SrbwSN20nKY5y71huhsabLEdX=OGsdqwMPZOmNW8Gw@mail.gmail.com> <CANp29Y5cTga9UrkySy6GiOco+nOHuDnFOWSb5PF-P0i6hU+hnA@mail.gmail.com>
In-Reply-To: <CANp29Y5cTga9UrkySy6GiOco+nOHuDnFOWSb5PF-P0i6hU+hnA@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 8 Apr 2025 22:41:32 +0200
X-Gm-Features: ATxdqUG1UVRLynsyei216IbnoTCMsa2TfGH7-rydQFtiDybzeVMSm_mghwzM5oU
Message-ID: <CANn89iJTHf-sJCqcyrFJiLMLBOBgtN0+KrfPSuW0mhOzLS08Rw@mail.gmail.com>
Subject: Re: [syzbot] [net?] WARNING: bad unlock balance in do_setlink
To: Aleksandr Nogikh <nogikh@google.com>, Sven Eckelmann <sven@narfation.org>
Cc: Dmitry Vyukov <dvyukov@google.com>, Kuniyuki Iwashima <kuniyu@amazon.com>, stfomichev@gmail.com, 
	andrew@lunn.ch, davem@davemloft.net, horms@kernel.org, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	sdf@fomichev.me, syzbot+45016fe295243a7882d3@syzkaller.appspotmail.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 8, 2025 at 10:16=E2=80=AFPM Aleksandr Nogikh <nogikh@google.com=
> wrote:
>
> On Tue, Apr 8, 2025 at 1:33=E2=80=AFPM Eric Dumazet <edumazet@google.com>=
 wrote:
> >
> > On Tue, Apr 8, 2025 at 12:44=E2=80=AFPM Dmitry Vyukov <dvyukov@google.c=
om> wrote:
> > >
> > > On Tue, 8 Apr 2025 at 10:11, Aleksandr Nogikh <nogikh@google.com> wro=
te:
> > > >
> > > > On Mon, Apr 7, 2025 at 6:13=E2=80=AFPM 'Kuniyuki Iwashima' via syzk=
aller-bugs
> > > > <syzkaller-bugs@googlegroups.com> wrote:
> > > > >
> > > > > From: Stanislav Fomichev <stfomichev@gmail.com>
> > > > > Date: Mon, 7 Apr 2025 07:19:54 -0700
> > > > > > On 04/07, syzbot wrote:
> > > > > > > Hello,
> > > > > > >
> > > > > > > syzbot has tested the proposed patch but the reproducer is st=
ill triggering an issue:
> > > > > > > unregister_netdevice: waiting for DEV to become free
> > > > > > >
> > > > > > > unregister_netdevice: waiting for batadv0 to become free. Usa=
ge count =3D 3
> > > > > >
> > > > > > So it does fix the lock unbalance issue, but now there is a han=
g?
> > > > >
> > > > > I think this is an orthogonal issue.
> > > > >
> > > > > I saw this in another report as well.
> > > > > https://lore.kernel.org/netdev/67f208ea.050a0220.0a13.025b.GAE@go=
ogle.com/
> > > > >
> > > > > syzbot may want to find a better way to filter this kind of noise=
.
> > > > >
> > > >
> > > > Syzbot treats this message as a problem worthy of reporting since a
> > > > long time (Cc'd Dmitry who may remember the context):
> > > > https://github.com/google/syzkaller/commit/7a67784ca8bdc3b26cce2f0e=
c9a40d2dd9ec9396
> > > >
> > > > Since v6.15-rc1, we do observe it happen at least 10x more often th=
an
> > > > before, both during fuzzing and while processing #syz test commands=
:
> > > > https://syzkaller.appspot.com/bug?extid=3D881d65229ca4f9ae8c84
> > >
> > > IIUC this error means a leaked reference count on a device, and the
> > > device and everything it references leaked forever + a kernel thread
> > > looping forever. This does not look like noise.
> > >
> > > Eric, should know more. Eric fixed a bunch of these bugs and added a
> > > ref count tracker to devices to provide better diagnostics. For some
> > > reason I don't see the reftracker output in the console output, but
> > > CONFIG_NET_DEV_REFCNT_TRACKER=3Dy is enabled in the config.
> >
> > I think that Kuniyuki patch was fixing the original syzbot report.
> >
> > After fixing this trivial bug, another bug showed up,
> > and this second bug triggered "syzbot may want to find a better way to
> > filter this kind of noise." comment.
>
> FWIW I've just bisected the recent spike in "unregister_netdevice:
> waiting for batadv0 to become free" and git bisect pointed to:
>
> 00b35530811f2aa3d7ceec2dbada80861c7632a8
> Author: Eric Dumazet <edumazet@google.com>
> Date:   Thu Feb 6 14:04:22 2025 +0000
>
>     batman-adv: adopt netdev_hold() / netdev_put()
>
>     Add a device tracker to struct batadv_hard_iface to help
>     debugging of network device refcount imbalances.
>
>
> Eric, could you please have a look?
>

My original patch was :
https://lore.kernel.org/netdev/CANn89i+ySFS5C24guM9E9UsPWfQBL69-OoRDbOGfih9=
vLGxDJg@mail.gmail.com/T/

I think it was correct.

Then Sven added code in it, instead of adding a separate patch.

I guess a fix would be :

diff --git a/net/batman-adv/hard-interface.c b/net/batman-adv/hard-interfac=
e.c
index f145f96626531053bbf8f58a31f28f625a9d80f9..7cd4bdcee43935b9e5fb7d16964=
30909b7af67b4
100644
--- a/net/batman-adv/hard-interface.c
+++ b/net/batman-adv/hard-interface.c
@@ -725,7 +725,6 @@ int batadv_hardif_enable_interface(struct
batadv_hard_iface *hard_iface,

        kref_get(&hard_iface->refcount);

-       dev_hold(mesh_iface);
        netdev_hold(mesh_iface, &hard_iface->meshif_dev_tracker, GFP_ATOMIC=
);
        hard_iface->mesh_iface =3D mesh_iface;
        bat_priv =3D netdev_priv(hard_iface->mesh_iface);

