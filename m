Return-Path: <netdev+bounces-77278-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E3A4C871152
	for <lists+netdev@lfdr.de>; Tue,  5 Mar 2024 00:50:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 346402842D4
	for <lists+netdev@lfdr.de>; Mon,  4 Mar 2024 23:50:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2D347D09C;
	Mon,  4 Mar 2024 23:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipanda-io.20230601.gappssmtp.com header.i=@sipanda-io.20230601.gappssmtp.com header.b="gYmGmuYZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ua1-f53.google.com (mail-ua1-f53.google.com [209.85.222.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6E377D083
	for <netdev@vger.kernel.org>; Mon,  4 Mar 2024 23:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709596216; cv=none; b=Q1KrJ4KHNwjE9V2WdgXBvz5eXhg9jdzNFNf3czkUXAEg7WVMKwVE+42a+t2aIK9FunC2s3QvndkPTvC3or7bDXpdqYqt1m7ntAQPCXQz88C3Hi8HwWmyTM6h/emu5LoO95ffw8JfbAX5Nhhz3UGMf3VOwZ1KortbZwlcLS7aXaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709596216; c=relaxed/simple;
	bh=2eJH1wa9HGteQ6bhwtOh3Blnr97ZXU75HLoBqvCpIO0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SW8MraGHA24wVlO6vXgWcCK+uRzAaQS2TeB/T7+VhQPa93WFH57BNg7Jtvq/5xjJoa/eG+eJRXFcOStgLqxzIt0yP+tWSaHtG+rjXRwW1EV0wDJbhcHjALrN5n6wfaIVmQdCHbgRgrCFyGqey2i39HwdCZSEHkZFbi/DwG5f5AY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sipanda.io; spf=pass smtp.mailfrom=sipanda.io; dkim=pass (2048-bit key) header.d=sipanda-io.20230601.gappssmtp.com header.i=@sipanda-io.20230601.gappssmtp.com header.b=gYmGmuYZ; arc=none smtp.client-ip=209.85.222.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sipanda.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipanda.io
Received: by mail-ua1-f53.google.com with SMTP id a1e0cc1a2514c-7d6275d7d4dso2424442241.2
        for <netdev@vger.kernel.org>; Mon, 04 Mar 2024 15:50:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sipanda-io.20230601.gappssmtp.com; s=20230601; t=1709596213; x=1710201013; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2eJH1wa9HGteQ6bhwtOh3Blnr97ZXU75HLoBqvCpIO0=;
        b=gYmGmuYZQALUDqEa6MkC5XGznLHl3klNo3EHG2xJN8fKJlwS8o7SXH/YWYAdH6s3EU
         iD84KMGL1UhF2lUD9FHUz+Rak426i9SumreXpOOksJOW4ySvf3GTrpgFQF0dZNDBUkuZ
         zglxmYA61raWPnHbdTxBwoupcdzw4yl6McJYUuBY+AtMSNk0wUxLpUtJxJGwDRY2y6kZ
         yOBga4gy+4up1sCWoNuwLEcdcyxXWNsqdL4rjY/MpUV/5gYeTPgFc9k35sh9XaJfM0PR
         L7cillYB5ScmR96X4gBReJJVh4okWRCJR/MU4/3tAnSjL57xLfDpXr5HYeotdvXUhe5S
         ic0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709596213; x=1710201013;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2eJH1wa9HGteQ6bhwtOh3Blnr97ZXU75HLoBqvCpIO0=;
        b=UEEieDs4i35UQoUwLm0finYq9Uj5FSzJ7W4M1gCnIPLSCfKCe2YDR5n6ltOZGympcN
         6n2vRvYHYqfFgV+HxInDMI14hzMB3Yub/pA+ESXGzdWJlRYAwCPH30fakwefET225B41
         rpScqCeHeX1MtdYEt5Y8iiZyvV/xRJ8Tbf00IqczQvsRbjOg9e85EVpfye4sWNpDgedi
         jmm3xRg4E2NyPgAUYqQt9Sf/yf6fBV4qalC9WAw4fi+2OruU2EGjOkKXImWybTyMkHBj
         MFcW2+zVQ2CWZVTBCasVg7ld0L9ZHBqeb4gvXVcEwjEPozi1OjgTVdIY4L996AT20//a
         qscg==
X-Forwarded-Encrypted: i=1; AJvYcCWqYLM6mvo4e8FLsjOzg7So7c0B6WbbTib12CLKIBht7b5nD8cWxdAAmXHeWAmiY1mBVkNVDhIu7LwabCPCRpdHZ33IsvLB
X-Gm-Message-State: AOJu0YydHZtWynpY3IUeiFgfzN5svnv84+qcfJGTQ73J4k0POB1s/4PP
	7v0H2gVJCakx4jL8mB/bY1ffWXwUWrAWz0wbzzvoMjdBGcWbGXQn4BcCvDQBzcB4WhawJ46IQQS
	kRyPviMhJMAHVeu/nV8RyT2kAmXljjHWV+TxlqQ==
X-Google-Smtp-Source: AGHT+IFSU5UNw0Ux5eP+lhQSmWyEUeI2Ck8O5wILcZc+toA5Qd9Ywy7uroe1KrD2/Rxmm9CJ/UpSqS1RS6fyoDTX8vo=
X-Received: by 2002:a05:6102:f11:b0:471:e1cb:a9fc with SMTP id
 v17-20020a0561020f1100b00471e1cba9fcmr319866vss.3.1709596213467; Mon, 04 Mar
 2024 15:50:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAM0EoM=r1UDnkp-csPdrz6nBt7o3fHUncXKnO7tB_rcZAcbrDg@mail.gmail.com>
 <CAOuuhY8qbsYCjdUYUZv8J3jz8HGXmtxLmTDP6LKgN5uRVZwMnQ@mail.gmail.com>
 <20240301090020.7c9ebc1d@kernel.org> <CAM0EoM=-hzSNxOegHqhAQD7qoAR2CS3Dyh-chRB+H7C7TQzmow@mail.gmail.com>
 <20240301173214.3d95e22b@kernel.org> <CAOuuhY8fnpEEBb8z-1mQmvHtfZQwgQnXk3=op-Xk108Pts8ohA@mail.gmail.com>
 <20240302191530.22353670@kernel.org> <CAOuuhY_senZbdC2cVU9kfDww_bT+a_VkNaDJYRk4_fMbJW17sQ@mail.gmail.com>
 <ZeY6r9cm4pdW9WNC@google.com> <CAOuuhY8ieZav-Bgmn5x9OqYGnG4jQgVBhpsz5mz_iBoCZLgs_A@mail.gmail.com>
 <ZeZYPWecammoABY0@google.com>
In-Reply-To: <ZeZYPWecammoABY0@google.com>
From: Tom Herbert <tom@sipanda.io>
Date: Mon, 4 Mar 2024 15:50:02 -0800
Message-ID: <CAOuuhY8mnhXLqesyxA2p1cWpbVJXjc7z-dkPrhff2dvsLQ-iWw@mail.gmail.com>
Subject: Re: [PATCH net-next v12 00/15] Introducing P4TC (series 1)
To: Stanislav Fomichev <sdf@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>, Jamal Hadi Salim <jhs@mojatatu.com>, 
	John Fastabend <john.fastabend@gmail.com>, anjali.singhai@intel.com, 
	Paolo Abeni <pabeni@redhat.com>, 
	Linux Kernel Network Developers <netdev@vger.kernel.org>, deb.chatterjee@intel.com, namrata.limaye@intel.com, 
	mleitner@redhat.com, Mahesh.Shirshyad@amd.com, Vipin.Jain@amd.com, 
	tomasz.osinski@intel.com, Jiri Pirko <jiri@resnulli.us>, 
	Cong Wang <xiyou.wangcong@gmail.com>, davem@davemloft.net, edumazet@google.com, 
	Vlad Buslov <vladbu@nvidia.com>, horms@kernel.org, khalidm@nvidia.com, 
	=?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>, 
	Daniel Borkmann <daniel@iogearbox.net>, Victor Nogueira <victor@mojatatu.com>, pctammela@mojatatu.com, 
	dan.daly@intel.com, andy.fingerhut@gmail.com, chris.sommers@keysight.com, 
	mattyk@nvidia.com, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 4, 2024 at 3:24=E2=80=AFPM Stanislav Fomichev <sdf@google.com> =
wrote:
>
> On 03/04, Tom Herbert wrote:
> > On Mon, Mar 4, 2024 at 1:19=E2=80=AFPM Stanislav Fomichev <sdf@google.c=
om> wrote:
> > >
> > > On 03/03, Tom Herbert wrote:
> > > > On Sat, Mar 2, 2024 at 7:15=E2=80=AFPM Jakub Kicinski <kuba@kernel.=
org> wrote:
> > > > >
> > > > > On Fri, 1 Mar 2024 18:20:36 -0800 Tom Herbert wrote:
> > > > > > This is configurability versus programmability. The table drive=
n
> > > > > > approach as input (configurability) might work fine for generic
> > > > > > match-action tables up to the point that tables are expressive =
enough
> > > > > > to satisfy the requirements. But parsing doesn't fall into the =
table
> > > > > > driven paradigm: parsers want to be *programmed*. This is why w=
e
> > > > > > removed kParser from this patch set and fell back to eBPF for p=
arsing.
> > > > > > But the problem we quickly hit that eBPF is not offloadable to =
network
> > > > > > devices, for example when we compile P4 in an eBPF parser we've=
 lost
> > > > > > the declarative representation that parsers in the devices coul=
d
> > > > > > consume (they're not CPUs running eBPF).
> > > > > >
> > > > > > I think the key here is what we mean by kernel offload. When we=
 do
> > > > > > kernel offload, is it the kernel implementation or the kernel
> > > > > > functionality that's being offloaded? If it's the latter then w=
e have
> > > > > > a lot more flexibility. What we'd need is a safe and secure way=
 to
> > > > > > synchronize with that offload device that precisely supports th=
e
> > > > > > kernel functionality we'd like to offload. This can be done if =
both
> > > > > > the kernel bits and programmed offload are derived from the sam=
e
> > > > > > source (i.e. tag source code with a sha-1). For example, if som=
eone
> > > > > > writes a parser in P4, we can compile that into both eBPF and a=
 P4
> > > > > > backend using independent tool chains and program download. At
> > > > > > runtime, the kernel can safely offload the functionality of the=
 eBPF
> > > > > > parser to the device if it matches the hash to that reported by=
 the
> > > > > > device
> > > > >
> > > > > Good points. If I understand you correctly you're saying that par=
sers
> > > > > are more complex than just a basic parsing tree a'la u32.
> > > >
> > > > Yes. Parsing things like TLVs, GRE flag field, or nested protobufs
> > > > isn't conducive to u32. We also want the advantages of compiler
> > > > optimizations to unroll loops, squash nodes in the parse graph, etc=
.
> > > >
> > > > > Then we can take this argument further. P4 has grown to encompass=
 a lot
> > > > > of functionality of quite complex devices. How do we square that =
with
> > > > > the kernel functionality offload model. If the entire device is m=
odeled,
> > > > > including f.e. TSO, an offload would mean that the user has to wr=
ite
> > > > > a TSO implementation which they then load into TC? That seems odd=
.
> > > > >
> > > > > IOW I don't quite know how to square in my head the "total
> > > > > functionality" with being a TC-based "plugin".
> > > >
> > > > Hi Jakub,
> > > >
> > > > I believe the solution is to replace kernel code with eBPF in cases
> > > > where we need programmability. This effectively means that we would
> > > > ship eBPF code as part of the kernel. So in the case of TSO, the
> > > > kernel would include a standard implementation in eBPF that could b=
e
> > > > compiled into the kernel by default. The restricted C source code i=
s
> > > > tagged with a hash, so if someone wants to offload TSO they could
> > > > compile the source into their target and retain the hash. At runtim=
e
> > > > it's a matter of querying the driver to see if the device supports =
the
> > > > TSO program the kernel is running by comparing hash values. Scaling
> > > > this, a device could support a catalogue of programs: TSO, LRO,
> > > > parser, IPtables, etc., If the kernel can match the hash of its eBP=
F
> > > > code to one reported by the driver then it can assume functionality=
 is
> > > > offloadable. This is an elaboration of "device features", but inste=
ad
> > > > of the device telling us they think they support an adequate GRO
> > > > implementation by reporting NETIF_F_GRO, the device would tell the
> > > > kernel that they not only support GRO but they provide identical
> > > > functionality of the kernel GRO (which IMO is the first requirement=
 of
> > > > kernel offload).
> > > >
> > > > Even before considering hardware offload, I think this approach
> > > > addresses a more fundamental problem to make the kernel programmabl=
e.
> > > > Since the code is in eBPF, the kernel can be reprogrammed at runtim=
e
> > > > which could be controlled by TC. This allows local customization of
> > > > kernel features, but also is the simplest way to "patch" the kernel
> > > > with security and bug fixes (nobody is ever excited to do a kernel
> > >
> > > [..]
> > >
> > > > rebase in their datacenter!). Flow dissector is a prime candidate f=
or
> > > > this, and I am still planning to replace it with an all eBPF progra=
m
> > > > (https://netdevconf.info/0x15/slides/16/Flow%20dissector_PANDA%20pa=
rser.pdf).
> > >
> > > So you're suggesting to bundle (and extend)
> > > tools/testing/selftests/bpf/progs/bpf_flow.c? We were thinking along
> > > similar lines here. We load this program manually right now, shipping
> > > and autoloading with the kernel will be easer.
> >
> > Hi Stanislav,
> >
> > Yes, I envision that we would have a standard implementation of
> > flow-dissector in eBPF that is shipped with the kernel and autoloaded.
> > However, for the front end source I want to move away from imperative
> > code. As I mentioned in the presentation flow_dissector.c is spaghetti
> > code and has been prone to bugs over the years especially whenever
> > someone adds support for a new fringe protocol (I take the liberty to
> > call it spaghetti code since I'm partially responsible for creating
> > this mess ;-) ).
> >
> > The problem is that parsers are much better represented by a
> > declarative rather than an imperative representation. To that end, we
> > defined PANDA which allows constructing a parser (parse graph) in data
> > structures in C. We use the "PANDA parser" to compile C to restricted
> > C code which looks more like eBPF in imperative code. With this method
> > we abstract out all the bookkeeping that was often the source of bugs
> > (like pulling up skbufs, checking length limits, etc.). The other
> > advantage is that we're able to find a lot more optimizations if we
> > start with a right representation of the problem.
> >
> > If you're interested, the video presentation on this is in
> > https://www.youtube.com/watch?v=3DzVnmVDSEoXc.
>
> Oh, yeah, I've seen this one. Agreed that the C implementation is not
> pleasant and generating a parser from some declarative spec is a better
> idea.
>
> From my pow, the biggest win we get from making bpf flow dissector
> pluggable is the fact that we can now actually write some tests for it

Yes, extracting out functions from the kernel allows them to be
independently unit tested. It's an even bigger win if the same source
code is used for offloading the functionality as I described. We can
call this "Test once, run anywhere!"

Tom

> (and, maybe, fuzz it?). We should also probably spend more time properly
> defining the behavior of the existing C implementation. We've seen
> some interesting bugs like this one:
> https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git/commit/?=
id=3D9fa02892857ae2b3b699630e5ede28f72106e7e7

