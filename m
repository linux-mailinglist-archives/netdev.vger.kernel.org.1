Return-Path: <netdev+bounces-77275-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EEE08871107
	for <lists+netdev@lfdr.de>; Tue,  5 Mar 2024 00:24:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 178011C221C2
	for <lists+netdev@lfdr.de>; Mon,  4 Mar 2024 23:24:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BAF97C6DB;
	Mon,  4 Mar 2024 23:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Rurf5AiR"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AA637C08C
	for <netdev@vger.kernel.org>; Mon,  4 Mar 2024 23:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709594690; cv=none; b=ro9dq76Awsggj/vdFmUADNsHuB0fbPk0ADDp9M9LXspoFZ1jW9BCvijlAZs0C0ynGmsFH3YWUI7/0EhVEhCjsfvAEe7Nd2HKZ3+WYMS/B9Z5HZ619I+9m1803rExpzB6TMJ098lkQc0L31qjo2i+Uwjs96owhS5VJ9fZwWrd1Wg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709594690; c=relaxed/simple;
	bh=UWquCOXdSTsI2tChPH6N2GVOeQkfTaMyZ8hrQ1/x5lg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=qr6johZNPhYcDRjpsEkIX/TSMFsu+Fokp4QaKhJI6di7Otl0dDSTGREmMVzNGL3yBfxN9GXN7Js31kOVZ8kUehyGsYpLyfOX6GhfvinPpNdyPowQQKgPzF83ZptEGpvIkuiwYkmGfUB4wOR6ZTcWIdK1BoA4V0dpQWfuYhzyZeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--sdf.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Rurf5AiR; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--sdf.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dcc05887ee9so6879267276.1
        for <netdev@vger.kernel.org>; Mon, 04 Mar 2024 15:24:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709594687; x=1710199487; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UWquCOXdSTsI2tChPH6N2GVOeQkfTaMyZ8hrQ1/x5lg=;
        b=Rurf5AiRaZCtbMN6pDXOygiOTLjPj/U4qKrrt3SOrqMp5ZJ+NI09Mu4KablOAbqzf8
         r6VM+GrNUg2DwLOMEIm1lCVHKWyHzNQ0rzj3lxX3K/xnZvSIGceuDn6rqdqGxu9KXFeC
         IlITuvUKiTxXydBpikri9uS7ICN5tF5JbQEid9Pb8ls4YBO/LZFikL8/gIrY7xnd20lX
         dog9i9Ub95UsEUlSekXCbg4CCURt7A5tKkd3W0ogFVCqZ6lCjPDJnNh3VnVJb3BWRKeR
         OX9nqV5Ji6a3EUnc23l1B1Gv9p3M+DlkqZp97FDZJI7Lp53u1ZMhhX11E0TvO2NNGIG9
         1DeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709594687; x=1710199487;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=UWquCOXdSTsI2tChPH6N2GVOeQkfTaMyZ8hrQ1/x5lg=;
        b=n1QO6Y9NZHk8W6tdubyiI2oxC2/ns6lNkdP/bYqCoXcKu7Mvx8V7njoPqaJ5NgIjA2
         i1cNqXfl1JKiV1FoNgzHJuUmHs/NcVRdTlhxSBWfe7GAIJl8KOf+vYtKg1SL2x48ViL7
         yHuBH3VLHGwZ4sRepmwBUg4TpDKE4e8j0v0fNYxqXLUaCtnRdBCKVNUGR4ykttx/Bt+I
         1OI9Lp8KUgHkUqvVO4TF5tG8SOPRAZMbzYnsFWSdNK38gu10Og3nk4fZRyzdghWCjgMl
         YO/aOBDJHhBrZboqAE41+5CAFn4JccROTBrXQDLYFjSXqi2c+FyMJTM2ItmrJwaHNGu2
         kXwg==
X-Forwarded-Encrypted: i=1; AJvYcCVRb0Mbbmd9xq0N8HvIHv4ACPz3+l28yfyMj/4xYHGtHO+MSIQuTWuPgOF4gGnLg9+er/dl55rVWAxupg3JpJceYWxSvR1R
X-Gm-Message-State: AOJu0YzbU65nJbvCvSq2+Yl5ClowaZkxj3lBK00v2Jq1jnAir/k4OUC0
	qMSo6TIuFqpULDXyraLpa07hjJ0GpP8AAQdYJs1i+hRUqcFQTrzZTpfSbyyluiJhIg==
X-Google-Smtp-Source: AGHT+IFJ6PJ8CB8/mMToVcJTohliDzBtwWcLZfG57Uh0k4NZFAPwz+WFaEDePKFqlcRrLFTjzIsV91w=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a05:6902:70d:b0:dc6:c94e:fb85 with SMTP id
 k13-20020a056902070d00b00dc6c94efb85mr362801ybt.2.1709594687281; Mon, 04 Mar
 2024 15:24:47 -0800 (PST)
Date: Mon, 4 Mar 2024 15:24:45 -0800
In-Reply-To: <CAOuuhY8ieZav-Bgmn5x9OqYGnG4jQgVBhpsz5mz_iBoCZLgs_A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <CAM0EoM=r1UDnkp-csPdrz6nBt7o3fHUncXKnO7tB_rcZAcbrDg@mail.gmail.com>
 <CAOuuhY8qbsYCjdUYUZv8J3jz8HGXmtxLmTDP6LKgN5uRVZwMnQ@mail.gmail.com>
 <20240301090020.7c9ebc1d@kernel.org> <CAM0EoM=-hzSNxOegHqhAQD7qoAR2CS3Dyh-chRB+H7C7TQzmow@mail.gmail.com>
 <20240301173214.3d95e22b@kernel.org> <CAOuuhY8fnpEEBb8z-1mQmvHtfZQwgQnXk3=op-Xk108Pts8ohA@mail.gmail.com>
 <20240302191530.22353670@kernel.org> <CAOuuhY_senZbdC2cVU9kfDww_bT+a_VkNaDJYRk4_fMbJW17sQ@mail.gmail.com>
 <ZeY6r9cm4pdW9WNC@google.com> <CAOuuhY8ieZav-Bgmn5x9OqYGnG4jQgVBhpsz5mz_iBoCZLgs_A@mail.gmail.com>
Message-ID: <ZeZYPWecammoABY0@google.com>
Subject: Re: [PATCH net-next v12 00/15] Introducing P4TC (series 1)
From: Stanislav Fomichev <sdf@google.com>
To: Tom Herbert <tom@sipanda.io>
Cc: Jakub Kicinski <kuba@kernel.org>, Jamal Hadi Salim <jhs@mojatatu.com>, 
	John Fastabend <john.fastabend@gmail.com>, anjali.singhai@intel.com, 
	Paolo Abeni <pabeni@redhat.com>, 
	Linux Kernel Network Developers <netdev@vger.kernel.org>, deb.chatterjee@intel.com, namrata.limaye@intel.com, 
	mleitner@redhat.com, Mahesh.Shirshyad@amd.com, Vipin.Jain@amd.com, 
	tomasz.osinski@intel.com, Jiri Pirko <jiri@resnulli.us>, 
	Cong Wang <xiyou.wangcong@gmail.com>, davem@davemloft.net, edumazet@google.com, 
	Vlad Buslov <vladbu@nvidia.com>, horms@kernel.org, khalidm@nvidia.com, 
	"Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?=" <toke@redhat.com>, Daniel Borkmann <daniel@iogearbox.net>, 
	Victor Nogueira <victor@mojatatu.com>, pctammela@mojatatu.com, dan.daly@intel.com, 
	andy.fingerhut@gmail.com, chris.sommers@keysight.com, mattyk@nvidia.com, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On 03/04, Tom Herbert wrote:
> On Mon, Mar 4, 2024 at 1:19=E2=80=AFPM Stanislav Fomichev <sdf@google.com=
> wrote:
> >
> > On 03/03, Tom Herbert wrote:
> > > On Sat, Mar 2, 2024 at 7:15=E2=80=AFPM Jakub Kicinski <kuba@kernel.or=
g> wrote:
> > > >
> > > > On Fri, 1 Mar 2024 18:20:36 -0800 Tom Herbert wrote:
> > > > > This is configurability versus programmability. The table driven
> > > > > approach as input (configurability) might work fine for generic
> > > > > match-action tables up to the point that tables are expressive en=
ough
> > > > > to satisfy the requirements. But parsing doesn't fall into the ta=
ble
> > > > > driven paradigm: parsers want to be *programmed*. This is why we
> > > > > removed kParser from this patch set and fell back to eBPF for par=
sing.
> > > > > But the problem we quickly hit that eBPF is not offloadable to ne=
twork
> > > > > devices, for example when we compile P4 in an eBPF parser we've l=
ost
> > > > > the declarative representation that parsers in the devices could
> > > > > consume (they're not CPUs running eBPF).
> > > > >
> > > > > I think the key here is what we mean by kernel offload. When we d=
o
> > > > > kernel offload, is it the kernel implementation or the kernel
> > > > > functionality that's being offloaded? If it's the latter then we =
have
> > > > > a lot more flexibility. What we'd need is a safe and secure way t=
o
> > > > > synchronize with that offload device that precisely supports the
> > > > > kernel functionality we'd like to offload. This can be done if bo=
th
> > > > > the kernel bits and programmed offload are derived from the same
> > > > > source (i.e. tag source code with a sha-1). For example, if someo=
ne
> > > > > writes a parser in P4, we can compile that into both eBPF and a P=
4
> > > > > backend using independent tool chains and program download. At
> > > > > runtime, the kernel can safely offload the functionality of the e=
BPF
> > > > > parser to the device if it matches the hash to that reported by t=
he
> > > > > device
> > > >
> > > > Good points. If I understand you correctly you're saying that parse=
rs
> > > > are more complex than just a basic parsing tree a'la u32.
> > >
> > > Yes. Parsing things like TLVs, GRE flag field, or nested protobufs
> > > isn't conducive to u32. We also want the advantages of compiler
> > > optimizations to unroll loops, squash nodes in the parse graph, etc.
> > >
> > > > Then we can take this argument further. P4 has grown to encompass a=
 lot
> > > > of functionality of quite complex devices. How do we square that wi=
th
> > > > the kernel functionality offload model. If the entire device is mod=
eled,
> > > > including f.e. TSO, an offload would mean that the user has to writ=
e
> > > > a TSO implementation which they then load into TC? That seems odd.
> > > >
> > > > IOW I don't quite know how to square in my head the "total
> > > > functionality" with being a TC-based "plugin".
> > >
> > > Hi Jakub,
> > >
> > > I believe the solution is to replace kernel code with eBPF in cases
> > > where we need programmability. This effectively means that we would
> > > ship eBPF code as part of the kernel. So in the case of TSO, the
> > > kernel would include a standard implementation in eBPF that could be
> > > compiled into the kernel by default. The restricted C source code is
> > > tagged with a hash, so if someone wants to offload TSO they could
> > > compile the source into their target and retain the hash. At runtime
> > > it's a matter of querying the driver to see if the device supports th=
e
> > > TSO program the kernel is running by comparing hash values. Scaling
> > > this, a device could support a catalogue of programs: TSO, LRO,
> > > parser, IPtables, etc., If the kernel can match the hash of its eBPF
> > > code to one reported by the driver then it can assume functionality i=
s
> > > offloadable. This is an elaboration of "device features", but instead
> > > of the device telling us they think they support an adequate GRO
> > > implementation by reporting NETIF_F_GRO, the device would tell the
> > > kernel that they not only support GRO but they provide identical
> > > functionality of the kernel GRO (which IMO is the first requirement o=
f
> > > kernel offload).
> > >
> > > Even before considering hardware offload, I think this approach
> > > addresses a more fundamental problem to make the kernel programmable.
> > > Since the code is in eBPF, the kernel can be reprogrammed at runtime
> > > which could be controlled by TC. This allows local customization of
> > > kernel features, but also is the simplest way to "patch" the kernel
> > > with security and bug fixes (nobody is ever excited to do a kernel
> >
> > [..]
> >
> > > rebase in their datacenter!). Flow dissector is a prime candidate for
> > > this, and I am still planning to replace it with an all eBPF program
> > > (https://netdevconf.info/0x15/slides/16/Flow%20dissector_PANDA%20pars=
er.pdf).
> >
> > So you're suggesting to bundle (and extend)
> > tools/testing/selftests/bpf/progs/bpf_flow.c? We were thinking along
> > similar lines here. We load this program manually right now, shipping
> > and autoloading with the kernel will be easer.
>=20
> Hi Stanislav,
>=20
> Yes, I envision that we would have a standard implementation of
> flow-dissector in eBPF that is shipped with the kernel and autoloaded.
> However, for the front end source I want to move away from imperative
> code. As I mentioned in the presentation flow_dissector.c is spaghetti
> code and has been prone to bugs over the years especially whenever
> someone adds support for a new fringe protocol (I take the liberty to
> call it spaghetti code since I'm partially responsible for creating
> this mess ;-) ).
>=20
> The problem is that parsers are much better represented by a
> declarative rather than an imperative representation. To that end, we
> defined PANDA which allows constructing a parser (parse graph) in data
> structures in C. We use the "PANDA parser" to compile C to restricted
> C code which looks more like eBPF in imperative code. With this method
> we abstract out all the bookkeeping that was often the source of bugs
> (like pulling up skbufs, checking length limits, etc.). The other
> advantage is that we're able to find a lot more optimizations if we
> start with a right representation of the problem.
>=20
> If you're interested, the video presentation on this is in
> https://www.youtube.com/watch?v=3DzVnmVDSEoXc.

Oh, yeah, I've seen this one. Agreed that the C implementation is not
pleasant and generating a parser from some declarative spec is a better
idea.

From my pow, the biggest win we get from making bpf flow dissector
pluggable is the fact that we can now actually write some tests for it
(and, maybe, fuzz it?). We should also probably spend more time properly
defining the behavior of the existing C implementation. We've seen
some interesting bugs like this one:
https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git/commit/?id=
=3D9fa02892857ae2b3b699630e5ede28f72106e7e7

