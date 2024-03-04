Return-Path: <netdev+bounces-77262-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E47F8870FAA
	for <lists+netdev@lfdr.de>; Mon,  4 Mar 2024 23:01:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9AFAD282722
	for <lists+netdev@lfdr.de>; Mon,  4 Mar 2024 22:01:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7ACA79DCA;
	Mon,  4 Mar 2024 22:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipanda-io.20230601.gappssmtp.com header.i=@sipanda-io.20230601.gappssmtp.com header.b="RkdHbZtG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ua1-f53.google.com (mail-ua1-f53.google.com [209.85.222.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E671B1F60A
	for <netdev@vger.kernel.org>; Mon,  4 Mar 2024 22:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709589682; cv=none; b=iaR3Mtvk8BKbdW1FGuBAu3XYgz8W736/sFH8Ch9IjtWfStMmPpTF9c279jYdx//wnX/iNm4h+fN+JtXayrPld4LwmuczhKuCepa7bEECPztVZnzuIHUigrpEhqkEIhPoh2hRgjDgkPMXRFGHlRXPmT8v+MwWhyMKTQ2XRxnN4VI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709589682; c=relaxed/simple;
	bh=z3q1VpKpjWS/AmxEdmIGa819Za6gXGV9rYZBZ7aLZdA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZqpzPiu307iYvC9/YYPoplEr5HJpctcbIA3yzV9z3H8NrBmPDHWThH01eb8cidIiOrznKuUX5r8AjA/FUTHEVH3fqzl/iJhWmCrW+ao/xfjt5OBPynqvj9Euq2D3ew4oiJpw2avD+W9bFk0aBMCouVPbOln9lFvU8txLNXsl/bE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sipanda.io; spf=pass smtp.mailfrom=sipanda.io; dkim=pass (2048-bit key) header.d=sipanda-io.20230601.gappssmtp.com header.i=@sipanda-io.20230601.gappssmtp.com header.b=RkdHbZtG; arc=none smtp.client-ip=209.85.222.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sipanda.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipanda.io
Received: by mail-ua1-f53.google.com with SMTP id a1e0cc1a2514c-7dad83f225cso1452899241.2
        for <netdev@vger.kernel.org>; Mon, 04 Mar 2024 14:01:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sipanda-io.20230601.gappssmtp.com; s=20230601; t=1709589680; x=1710194480; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z3q1VpKpjWS/AmxEdmIGa819Za6gXGV9rYZBZ7aLZdA=;
        b=RkdHbZtGFLG+/pQ1CZaDTpUBfo90R9AE9xhnoQaKoF887Oi3LyHeIOrekbLluYI+XH
         24K2ufNlDkBp9+gWosSNXMjDAC5CoP1NYWbg/8bw2v/SY5AAtZX/gxltccsRwxu6zaXe
         VV+qL5ITmIz/AR+w8VgEED052njG6R4Zk+5aPaLj1vgo7vnZgQ+miWO294ks/W71o4D4
         zgh/fYSfk6u8dySm7/+DWuyJLxcpn1PTITDzv5Yp1LzqIzm6gVAPalTFlvjZeUFSuwkG
         9zG8QpZOrspalVCcsfkDmmK2c7xLj1ewW3ymprWcnAudL4xxSitoeLT0l49w5sbR0ccs
         7dOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709589680; x=1710194480;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z3q1VpKpjWS/AmxEdmIGa819Za6gXGV9rYZBZ7aLZdA=;
        b=esak10dJvAtOUy0mltoNBappA0Xz243K+bd0Z/Z8VNKP8XMaroai8HsUyT5wiNL9Im
         qWGLwqcjk0PO+0KixY11KGuHpqPd5Y3CUIz4PATtR2dsjHLlYwXqed30o3hXQImaVwRz
         5eg/C5BvJBKOAuiivEyHETwyHYouYaiSBAhBe5resxtGdg0v+2cwd4ESEmjcySg0zAj7
         vyYzCktShyx3J1Sl//cJemd2Jhb8nzr3j5LEmwyBj4hogweGx1p4hDtjQvujzbeQU2LR
         0TYMhhT9bFIePYr08VqbHUdRcVmfoAxgdiMZqREqTCI+UzX3xidolaQGlU03OTgjFA0H
         Lbww==
X-Forwarded-Encrypted: i=1; AJvYcCVGMZxyFPaXPbW64m+TRyjCOsdnMOFZ2OMpyu/Ml+Z0d/WpguVVUjpJOAvt9csFMU+jEqmknfIRvkgoFBZX4K1PXSHvCEkW
X-Gm-Message-State: AOJu0YxLkflN43WRqlBWp2pWZu1YxUuQegJiaf6zthKHMuSEiJG7fIDr
	gf2W/gLsgNSuQbNohhAPeQS+jLjYDbnZ7aqVDd6pCej4AvZiWgcWb4uWOZEbtWveokZcBGPwL5w
	kBQeW+bW8JE5nvsrIjd6QASSCNUewjfSksf/X0g==
X-Google-Smtp-Source: AGHT+IEPVmfr43zJCi1kyszWjOhYwMY2T0gaK5I4jrNJlu29MFc3wLhAIpRT+AMdVR220miBy+KpJTK2b6wn1m8bn4g=
X-Received: by 2002:a05:6122:21a2:b0:4c7:7407:e8ab with SMTP id
 j34-20020a05612221a200b004c77407e8abmr13956vkd.12.1709589679774; Mon, 04 Mar
 2024 14:01:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CO1PR11MB49931E501B20F32681F917CD935F2@CO1PR11MB4993.namprd11.prod.outlook.com>
 <65e106305ad8b_43ad820892@john.notmuch> <CAM0EoM=r1UDnkp-csPdrz6nBt7o3fHUncXKnO7tB_rcZAcbrDg@mail.gmail.com>
 <CAOuuhY8qbsYCjdUYUZv8J3jz8HGXmtxLmTDP6LKgN5uRVZwMnQ@mail.gmail.com>
 <20240301090020.7c9ebc1d@kernel.org> <CAM0EoM=-hzSNxOegHqhAQD7qoAR2CS3Dyh-chRB+H7C7TQzmow@mail.gmail.com>
 <20240301173214.3d95e22b@kernel.org> <CAOuuhY8fnpEEBb8z-1mQmvHtfZQwgQnXk3=op-Xk108Pts8ohA@mail.gmail.com>
 <20240302191530.22353670@kernel.org> <CAOuuhY_senZbdC2cVU9kfDww_bT+a_VkNaDJYRk4_fMbJW17sQ@mail.gmail.com>
 <ZeY6r9cm4pdW9WNC@google.com>
In-Reply-To: <ZeY6r9cm4pdW9WNC@google.com>
From: Tom Herbert <tom@sipanda.io>
Date: Mon, 4 Mar 2024 14:01:08 -0800
Message-ID: <CAOuuhY8ieZav-Bgmn5x9OqYGnG4jQgVBhpsz5mz_iBoCZLgs_A@mail.gmail.com>
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

On Mon, Mar 4, 2024 at 1:19=E2=80=AFPM Stanislav Fomichev <sdf@google.com> =
wrote:
>
> On 03/03, Tom Herbert wrote:
> > On Sat, Mar 2, 2024 at 7:15=E2=80=AFPM Jakub Kicinski <kuba@kernel.org>=
 wrote:
> > >
> > > On Fri, 1 Mar 2024 18:20:36 -0800 Tom Herbert wrote:
> > > > This is configurability versus programmability. The table driven
> > > > approach as input (configurability) might work fine for generic
> > > > match-action tables up to the point that tables are expressive enou=
gh
> > > > to satisfy the requirements. But parsing doesn't fall into the tabl=
e
> > > > driven paradigm: parsers want to be *programmed*. This is why we
> > > > removed kParser from this patch set and fell back to eBPF for parsi=
ng.
> > > > But the problem we quickly hit that eBPF is not offloadable to netw=
ork
> > > > devices, for example when we compile P4 in an eBPF parser we've los=
t
> > > > the declarative representation that parsers in the devices could
> > > > consume (they're not CPUs running eBPF).
> > > >
> > > > I think the key here is what we mean by kernel offload. When we do
> > > > kernel offload, is it the kernel implementation or the kernel
> > > > functionality that's being offloaded? If it's the latter then we ha=
ve
> > > > a lot more flexibility. What we'd need is a safe and secure way to
> > > > synchronize with that offload device that precisely supports the
> > > > kernel functionality we'd like to offload. This can be done if both
> > > > the kernel bits and programmed offload are derived from the same
> > > > source (i.e. tag source code with a sha-1). For example, if someone
> > > > writes a parser in P4, we can compile that into both eBPF and a P4
> > > > backend using independent tool chains and program download. At
> > > > runtime, the kernel can safely offload the functionality of the eBP=
F
> > > > parser to the device if it matches the hash to that reported by the
> > > > device
> > >
> > > Good points. If I understand you correctly you're saying that parsers
> > > are more complex than just a basic parsing tree a'la u32.
> >
> > Yes. Parsing things like TLVs, GRE flag field, or nested protobufs
> > isn't conducive to u32. We also want the advantages of compiler
> > optimizations to unroll loops, squash nodes in the parse graph, etc.
> >
> > > Then we can take this argument further. P4 has grown to encompass a l=
ot
> > > of functionality of quite complex devices. How do we square that with
> > > the kernel functionality offload model. If the entire device is model=
ed,
> > > including f.e. TSO, an offload would mean that the user has to write
> > > a TSO implementation which they then load into TC? That seems odd.
> > >
> > > IOW I don't quite know how to square in my head the "total
> > > functionality" with being a TC-based "plugin".
> >
> > Hi Jakub,
> >
> > I believe the solution is to replace kernel code with eBPF in cases
> > where we need programmability. This effectively means that we would
> > ship eBPF code as part of the kernel. So in the case of TSO, the
> > kernel would include a standard implementation in eBPF that could be
> > compiled into the kernel by default. The restricted C source code is
> > tagged with a hash, so if someone wants to offload TSO they could
> > compile the source into their target and retain the hash. At runtime
> > it's a matter of querying the driver to see if the device supports the
> > TSO program the kernel is running by comparing hash values. Scaling
> > this, a device could support a catalogue of programs: TSO, LRO,
> > parser, IPtables, etc., If the kernel can match the hash of its eBPF
> > code to one reported by the driver then it can assume functionality is
> > offloadable. This is an elaboration of "device features", but instead
> > of the device telling us they think they support an adequate GRO
> > implementation by reporting NETIF_F_GRO, the device would tell the
> > kernel that they not only support GRO but they provide identical
> > functionality of the kernel GRO (which IMO is the first requirement of
> > kernel offload).
> >
> > Even before considering hardware offload, I think this approach
> > addresses a more fundamental problem to make the kernel programmable.
> > Since the code is in eBPF, the kernel can be reprogrammed at runtime
> > which could be controlled by TC. This allows local customization of
> > kernel features, but also is the simplest way to "patch" the kernel
> > with security and bug fixes (nobody is ever excited to do a kernel
>
> [..]
>
> > rebase in their datacenter!). Flow dissector is a prime candidate for
> > this, and I am still planning to replace it with an all eBPF program
> > (https://netdevconf.info/0x15/slides/16/Flow%20dissector_PANDA%20parser=
.pdf).
>
> So you're suggesting to bundle (and extend)
> tools/testing/selftests/bpf/progs/bpf_flow.c? We were thinking along
> similar lines here. We load this program manually right now, shipping
> and autoloading with the kernel will be easer.

Hi Stanislav,

Yes, I envision that we would have a standard implementation of
flow-dissector in eBPF that is shipped with the kernel and autoloaded.
However, for the front end source I want to move away from imperative
code. As I mentioned in the presentation flow_dissector.c is spaghetti
code and has been prone to bugs over the years especially whenever
someone adds support for a new fringe protocol (I take the liberty to
call it spaghetti code since I'm partially responsible for creating
this mess ;-) ).

The problem is that parsers are much better represented by a
declarative rather than an imperative representation. To that end, we
defined PANDA which allows constructing a parser (parse graph) in data
structures in C. We use the "PANDA parser" to compile C to restricted
C code which looks more like eBPF in imperative code. With this method
we abstract out all the bookkeeping that was often the source of bugs
(like pulling up skbufs, checking length limits, etc.). The other
advantage is that we're able to find a lot more optimizations if we
start with a right representation of the problem.

If you're interested, the video presentation on this is in
https://www.youtube.com/watch?v=3DzVnmVDSEoXc.

Tom

