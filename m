Return-Path: <netdev+bounces-77245-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 32FA4870C5C
	for <lists+netdev@lfdr.de>; Mon,  4 Mar 2024 22:23:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E8831F24FBD
	for <lists+netdev@lfdr.de>; Mon,  4 Mar 2024 21:23:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FF9C1E4AA;
	Mon,  4 Mar 2024 21:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wFQvknRw"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B977CEED3
	for <netdev@vger.kernel.org>; Mon,  4 Mar 2024 21:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709587401; cv=none; b=BW+wuuiJaWmbpelkd0FCJ4zKo3mjt0dOJJ5BXjxxjm2eUoCE4+/WyuW4YVBw3zIezLo4C9Og+btTk6/WOzw2h0dkviJfJrbuKR8p6Be+jLQhKZ3Gz4i+s51TKZ/sMpAX5D8o7ndDtkg/YMksr168XtRzwR5eBkOWTkQEkLz6EQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709587401; c=relaxed/simple;
	bh=NjGc/f9f4b7RJPUQgwDmDbZaag8OzcwcpE0ChTKFD/s=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=CyJ2AWejOtzXMSUvIiG3TMpNgfpffGEIvJusuM0Y/BJKzV11cPBp2X0DBGOXhXrKFesV+THi4Uz5SBGgxNJUhpGWawwL0+GAZC8d7beHiVCLROb4shoxPXL6sW45KqJRiDsTxE2J5p+NZ7BZQDAJv3QwPpk1pu2OloAuTtK2f24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--sdf.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wFQvknRw; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--sdf.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-1dccac85165so49644975ad.0
        for <netdev@vger.kernel.org>; Mon, 04 Mar 2024 13:23:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709587399; x=1710192199; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mwWFvDsDdAYmA0A3zxhtzJPDls6QGk6q5u3L0Zhluuc=;
        b=wFQvknRwmLA+qy9oJ4GI3CgkiXCEfJ2D750u+BdsT4YAdwoqcfi2wYxEbd/Eyik7SQ
         16zxgKSx6HTM9w/9nl9zyx5QDkABisnfKATtpN1ZyOMu9SI8gBwWTcIc7HyRI60O9G2a
         smgflq74Xc0PNtXhBkJGNjqw2tgikvqX+VXSAt000jYnrXQCBkzdt3HiJhb+7tKIm3d4
         ac1Agkl+OerQ/5Jzm2zeHFNPcXaUcww7DPRNOv6pnZ6wL1PXD8DV8FwMfVXzbOfl76c8
         Mzigjfk1AgHkuhhPjL/yTxz4Td4gJn55A8ZKg7GykDlX6YS+CzRTJ+T3+UIGGdRcLFDT
         HelA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709587399; x=1710192199;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=mwWFvDsDdAYmA0A3zxhtzJPDls6QGk6q5u3L0Zhluuc=;
        b=uebW2OmnStd0cT+Wd2ATGAzF342S+biwYu7SKI3NHIyDrabeluvPtLMYS5zd+Kb3Ns
         EWgqD0B15zix/gKM5t3CSXY38jeVtpF1GKrhKMFz1FaifbdoFhjqPHMWuSW1noOBi9v0
         1Gsy4E4NjX53JD4kvXu1IRqONpCdGt/EhmdZnkJiWwpd1DqDlkRxsL1clr4D95YR0k5G
         6g7BbuIi19ezT0vFB6TOaeCZdHktsvt6ytwy4Qe5SUAZMSRZfWH+dt+wQMNjoQVQqnGo
         t+4DhGg7MUBilSBjsO8KMtSqK4BuUYiBifgeek40+eZB4HDwM0PdSqF+609eB5j5zRSR
         mmMw==
X-Forwarded-Encrypted: i=1; AJvYcCXhezH2sB/7+G23fjmkLUfqd3rDzXAGIylLamVxPJmjjr/G+Y59UjvtoXyBBmDVSqBBRru2ZI2tgHbdx6SubeAt+O6loxix
X-Gm-Message-State: AOJu0YzUBrTUFYHWwcr5/UnNu8Ym5witIvHfOcMsABK9qVSUefVLYzHC
	eKHIwd9c3/TQ98MLDqriq9vxrvXfF2/lDA5bwcvPV2IuvRfEkkPLt8krZvIumTaotw==
X-Google-Smtp-Source: AGHT+IGBYpxCaN+8LNljpbYsldf+9tCsOWzpP8TXpMsNq0Ua83+cI/DoDDYROQdhzfWcFL0zk5vNIuo=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a17:902:ce82:b0:1db:c8de:fd9e with SMTP id
 f2-20020a170902ce8200b001dbc8defd9emr459586plg.7.1709587399084; Mon, 04 Mar
 2024 13:23:19 -0800 (PST)
Date: Mon, 4 Mar 2024 13:23:17 -0800
In-Reply-To: <CAM0EoMnpZuC_fdzXj5+seXo3GT9rrf1txc45tB=gie4cf-Zqeg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <CAOuuhY8qbsYCjdUYUZv8J3jz8HGXmtxLmTDP6LKgN5uRVZwMnQ@mail.gmail.com>
 <20240301090020.7c9ebc1d@kernel.org> <CAM0EoM=-hzSNxOegHqhAQD7qoAR2CS3Dyh-chRB+H7C7TQzmow@mail.gmail.com>
 <20240301173214.3d95e22b@kernel.org> <CAM0EoM=NEB25naGtz=YaOt6BDoiv4RpDw27Y=btMZAMGeYB5bg@mail.gmail.com>
 <CAM0EoM=8GG-zCaopaUDMkvqemrZQUtaVRTMrWA6z=xrdYxG9+g@mail.gmail.com>
 <20240302192747.371684fb@kernel.org> <CAM0EoMncuPvUsRwE+Ajojgg-8JD+1oJ7j2Rw+7oN60MjjAHV-g@mail.gmail.com>
 <CAOuuhY8pgxqCg5uTXzetTt5sd8RzOfLPYF8ksLjoUhkKyqr56w@mail.gmail.com> <CAM0EoMnpZuC_fdzXj5+seXo3GT9rrf1txc45tB=gie4cf-Zqeg@mail.gmail.com>
Message-ID: <ZeY7TqCGFR3h36k-@google.com>
Subject: Re: Hardware Offload discussion WAS(Re: [PATCH net-next v12 00/15]
 Introducing P4TC (series 1)
From: Stanislav Fomichev <sdf@google.com>
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: Tom Herbert <tom@sipanda.io>, Jakub Kicinski <kuba@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, anjali.singhai@intel.com, 
	Paolo Abeni <pabeni@redhat.com>, 
	Linux Kernel Network Developers <netdev@vger.kernel.org>, deb.chatterjee@intel.com, namrata.limaye@intel.com, 
	Marcelo Ricardo Leitner <mleitner@redhat.com>, Mahesh.Shirshyad@amd.com, Vipin.Jain@amd.com, 
	tomasz.osinski@intel.com, Jiri Pirko <jiri@resnulli.us>, 
	Cong Wang <xiyou.wangcong@gmail.com>, davem@davemloft.net, 
	Eric Dumazet <edumazet@google.com>, Vlad Buslov <vladbu@nvidia.com>, Simon Horman <horms@kernel.org>, 
	Khalid Manaa <khalidm@nvidia.com>, 
	"Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?=" <toke@redhat.com>, Daniel Borkmann <daniel@iogearbox.net>, 
	Victor Nogueira <victor@mojatatu.com>, pctammela@mojatatu.com, dan.daly@intel.com, 
	Andy Fingerhut <andy.fingerhut@gmail.com>, chris.sommers@keysight.com, 
	Matty Kadosh <mattyk@nvidia.com>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On 03/03, Jamal Hadi Salim wrote:
> On Sun, Mar 3, 2024 at 1:11=E2=80=AFPM Tom Herbert <tom@sipanda.io> wrote=
:
> >
> > On Sun, Mar 3, 2024 at 9:00=E2=80=AFAM Jamal Hadi Salim <jhs@mojatatu.c=
om> wrote:
> > >
> > > On Sat, Mar 2, 2024 at 10:27=E2=80=AFPM Jakub Kicinski <kuba@kernel.o=
rg> wrote:
> > > >
> > > > On Sat, 2 Mar 2024 09:36:53 -0500 Jamal Hadi Salim wrote:
> > > > > 2) Your point on:  "integrate later", or at least "fill in the ga=
ps"
> > > > > This part i am probably going to mumble on. I am going to conside=
r
> > > > > more than just doing ACLs/MAT via flower/u32 for the sake of
> > > > > discussion.
> > > > > True, "fill the gaps" has been our model so far. It requires kern=
el
> > > > > changes, user space code changes etc justifiably so because most =
of
> > > > > the time such datapaths are subject to standardization via IETF, =
IEEE,
> > > > > etc and new extensions come in on a regular basis.  And sometimes=
 we
> > > > > do add features that one or two users or a single vendor has need=
 for
> > > > > at the cost of kernel and user/control extension. Given our work
> > > > > process, any features added this way take a long time to make it =
to
> > > > > the end user.
> > > >
> > > > What I had in mind was more of a DDP model. The device loads it bin=
ary
> > > > blob FW in whatever way it does, then it tells the kernel its parse=
r
> > > > graph, and tables. The kernel exposes those tables to user space.
> > > > All dynamic, no need to change the kernel for each new protocol.
> > > >
> > > > But that's different in two ways:
> > > >  1. the device tells kernel the tables, no "dynamic reprogramming"
> > > >  2. you don't need the SW side, the only use of the API is to inter=
act
> > > >     with the device
> > > >
> > > > User can still do BPF kfuncs to look up in the tables (like in FIB)=
,
> > > > but call them from cls_bpf.
> > > >
> > >
> > > This is not far off from what is envisioned today in the discussions.
> > > The main issue is who loads the binary? We went from devlink to the
> > > filter doing the loading. DDP is ethtool. We still need to tie a PCI
> > > device/tc block to the "program" so we can do skip_sw and it works.
> > > Meaning a device that is capable of handling multiple programs can
> > > have multiple blobs loaded. A "program" is mapped to a tc filter and
> > > MAT control works the same way as it does today (netlink/tc ndo).
> > >
> > > A program in P4 has a name, ID and people have been suggesting a sha1
> > > identity (or a signature of some kind should be generated by the
> > > compiler). So the upward propagation could be tied to discovering
> > > these 3 tuples from the driver. Then the control plane targets a
> > > program via those tuples via netlink (as we do currently).
> > >
> > > I do note, using the DDP sample space, currently whatever gets loaded
> > > is "trusted" and really you need to have human knowledge of what the
> > > NIC's parsing + MAT is to send the control. With P4 that is all
> > > visible/programmable by the end user (i am not a proponent of vendors
> > > "shipping" things or calling them for support) - so should be
> > > sufficient to just discover what is in the binary and send the correc=
t
> > > control messages down.
> > >
> > > > I think in P4 terms that may be something more akin to only providi=
ng
> > > > the runtime API? I seem to recall they had some distinction...
> > >
> > > There are several solutions out there (ex: TDI, P4runtime) - our API
> > > is netlink and those could be written on top of netlink, there's no
> > > controversy there.
> > > So the starting point is defining the datapath using P4, generating
> > > the binary blob and whatever constraints needed using the vendor
> > > backend and for s/w equivalent generating the eBPF datapath.
> > >
> > > > > At the cost of this sounding controversial, i am going
> > > > > to call things like fdb, fib, etc which have fixed datapaths in t=
he
> > > > > kernel "legacy". These "legacy" datapaths almost all the time hav=
e
> > > >
> > > > The cynic in me sometimes thinks that the biggest problem with "leg=
acy"
> > > > protocols is that it's hard to make money on them :)
> > >
> > > That's a big motivation without a doubt, but also there are people
> > > that want to experiment with things. One of the craziest examples we
> > > have is someone who created a P4 program for "in network calculator",
> > > essentially a calculator in the datapath. You send it two operands an=
d
> > > an operator using custom headers, it does the math and responds with =
a
> > > result in a new header. By itself this program is a toy but it
> > > demonstrates that if one wanted to, they could have something custom
> > > in hardware and/or kernel datapath.
> >
> > Jamal,
> >
> > Given how long P4 has been around it's surprising that the best
> > publicly available code example is "the network calculator" toy.
>=20
> Come on Tom ;-> That was just an example of something "crazy" to
> demonstrate freedom. I can run that in any of the P4 friendly NICs
> today. You are probably being facetious - There are some serious
> publicly available projects out there, some of which I quote on the
> cover letter (like DASH).

Shameless plug. I have a more crazy example with bpf:

https://github.com/fomichev/xdp-btc-miner

A good way to ensure all those smartnic cycles are not wasted :-D
I wish we had more nics with xdp bpf offloads :-(

