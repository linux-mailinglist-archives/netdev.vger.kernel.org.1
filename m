Return-Path: <netdev+bounces-77265-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F49F871005
	for <lists+netdev@lfdr.de>; Mon,  4 Mar 2024 23:23:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AAD401F2265C
	for <lists+netdev@lfdr.de>; Mon,  4 Mar 2024 22:23:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E7477BAE2;
	Mon,  4 Mar 2024 22:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oxf7Li6Z"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41DB47A70D
	for <netdev@vger.kernel.org>; Mon,  4 Mar 2024 22:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709590987; cv=none; b=JLbJw+EP+qqJN9jZgwKSEvc2aEmaAdyNyrOY/Q9x88O88oTNE/SGFB+kiIDw89vKdffDh/wTb5cy3tKIUi8gZok7bCROpN6P1PEc98RgfTMZ8amrrLIx+CIoTb2IH5MCVEszWAZWlPdk3DSrlHfFxY8MU2OdxVdoNoERT6iZJVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709590987; c=relaxed/simple;
	bh=Owu+EWU5VJmrFcSA9IZuRrclsu7ETVzGV/OMUSG3N00=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=eYez0D1p3AOKuijzEMRmZYkWJ3GzUDRJCL+jqJjTAIeaCOF5lA49kGVWvYRcInVF2eL89+rWCHmHR9tAv9Vx68qoamnvKSl+YcUrSDVCsno+hoHCtMV8sCuSX0uHawHDB5f7Q76DgJxBK422KELzxPJszzyJoN8wR5JcXkirXP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--sdf.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=oxf7Li6Z; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--sdf.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dc6b2682870so8140381276.0
        for <netdev@vger.kernel.org>; Mon, 04 Mar 2024 14:23:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709590985; x=1710195785; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=D/JMENula9xdGgm/fyDT7SM2OBRhPe/r5zKCY6GLqjc=;
        b=oxf7Li6Z+lxLEXVgRM5+qbJwVvlekOKQT/AdK3dIFuLjwCi+EnmNdYMgliwi3/Z7Q2
         JyiYKma76nt12Hk1nEsP3w8Eznp36ILvUcNA0B3ezL0V6uDWirx4BSVk2C9746LM/MBF
         tvJFZXjlH1n2cOHskIiOJ/hDEbFmpdAcH0akwbnsWm9F32iSUu0boI5kTDNYvnYBbBpk
         zJLxU+Zn0MZ7k1mp4lzpmPlOawhaJ0uuFKSHAWLL87ljPXpMu3TlzuQrPoJ7BNzUw3af
         d9h+/ko7PqX3UjZuExkMOK/lEHrhDlKl1VEmW3LxX6fS/t2rvHeLYf8SDno1DOjEZpEP
         4icw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709590985; x=1710195785;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=D/JMENula9xdGgm/fyDT7SM2OBRhPe/r5zKCY6GLqjc=;
        b=J8dUUeHL6wf0mPnxPQSwNCSVRtZ/lCNZo1HLpwu/2Lsk9Unt3+hcqHTS/GqSUfXI/9
         /9fq5Thk0WWBQngK4GPGnFYWV2FzrbKPo3VCc1y100gwZqRVHKLDI1bp2/WwxYKcvcgV
         O3qPwUJ5A/MHJTl2Ta8wgAR7SYzQuB6JlLCQ9fcFWWYhaqDUbDANrcR8YcQGFqnwMdrS
         h9M2BnJ0VJqgYCmuberZX0vrOGuv4uhok1mLxuEcC4waN9KnPLVFZWqx2uRhbkWIo4Eb
         VeKHY3VdFAfEPwlfApiJgkJChzAGJWKeI/OgtwoK2suM4kC3n1wo1PU55KzO/hKa3sAv
         V9+w==
X-Forwarded-Encrypted: i=1; AJvYcCWfmvBi59r7EblN/T1ebO+pX5H9Qo3kb0ajsRJnccuShCLaZn5pTWiOpwOE0ndvH6ThHh1LlTXRO73AakKU56x3QBTLFl6n
X-Gm-Message-State: AOJu0YwfO++xT2EJL9nGQZB8sr7hjYNS+bjnkdrWNb/PZU/bUs6vDqB2
	OhWiNQw3itkE7PVSACwOsJdfUUCZpqtgeqMTvtiTQWEVbuRYBq7RIYrTWu8gts4sBQ==
X-Google-Smtp-Source: AGHT+IHYrovjugOzVRfIKRtNK1exA0iGmPE/KuPEWxxRoVwXJYULKwQaKzJnY9Sut+lG5mgf1g7+UDQ=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a05:6902:1004:b0:dc7:48ce:d17f with SMTP id
 w4-20020a056902100400b00dc748ced17fmr2673279ybt.10.1709590985260; Mon, 04 Mar
 2024 14:23:05 -0800 (PST)
Date: Mon, 4 Mar 2024 14:23:03 -0800
In-Reply-To: <CAM0EoM=b6ymCEKs14ACanbkzscy=AdARYHSWprtexHBswD7xeg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <CAM0EoM=-hzSNxOegHqhAQD7qoAR2CS3Dyh-chRB+H7C7TQzmow@mail.gmail.com>
 <20240301173214.3d95e22b@kernel.org> <CAM0EoM=NEB25naGtz=YaOt6BDoiv4RpDw27Y=btMZAMGeYB5bg@mail.gmail.com>
 <CAM0EoM=8GG-zCaopaUDMkvqemrZQUtaVRTMrWA6z=xrdYxG9+g@mail.gmail.com>
 <20240302192747.371684fb@kernel.org> <CAM0EoMncuPvUsRwE+Ajojgg-8JD+1oJ7j2Rw+7oN60MjjAHV-g@mail.gmail.com>
 <CAOuuhY8pgxqCg5uTXzetTt5sd8RzOfLPYF8ksLjoUhkKyqr56w@mail.gmail.com>
 <CAM0EoMnpZuC_fdzXj5+seXo3GT9rrf1txc45tB=gie4cf-Zqeg@mail.gmail.com>
 <ZeY7TqCGFR3h36k-@google.com> <CAM0EoM=b6ymCEKs14ACanbkzscy=AdARYHSWprtexHBswD7xeg@mail.gmail.com>
Message-ID: <ZeZJxzRs5ayQ03ii@google.com>
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

On 03/04, Jamal Hadi Salim wrote:
> On Mon, Mar 4, 2024 at 4:23=E2=80=AFPM Stanislav Fomichev <sdf@google.com=
> wrote:
> >
> > On 03/03, Jamal Hadi Salim wrote:
> > > On Sun, Mar 3, 2024 at 1:11=E2=80=AFPM Tom Herbert <tom@sipanda.io> w=
rote:
> > > >
> > > > On Sun, Mar 3, 2024 at 9:00=E2=80=AFAM Jamal Hadi Salim <jhs@mojata=
tu.com> wrote:
> > > > >
> > > > > On Sat, Mar 2, 2024 at 10:27=E2=80=AFPM Jakub Kicinski <kuba@kern=
el.org> wrote:
> > > > > >
> > > > > > On Sat, 2 Mar 2024 09:36:53 -0500 Jamal Hadi Salim wrote:
> > > > > > > 2) Your point on:  "integrate later", or at least "fill in th=
e gaps"
> > > > > > > This part i am probably going to mumble on. I am going to con=
sider
> > > > > > > more than just doing ACLs/MAT via flower/u32 for the sake of
> > > > > > > discussion.
> > > > > > > True, "fill the gaps" has been our model so far. It requires =
kernel
> > > > > > > changes, user space code changes etc justifiably so because m=
ost of
> > > > > > > the time such datapaths are subject to standardization via IE=
TF, IEEE,
> > > > > > > etc and new extensions come in on a regular basis.  And somet=
imes we
> > > > > > > do add features that one or two users or a single vendor has =
need for
> > > > > > > at the cost of kernel and user/control extension. Given our w=
ork
> > > > > > > process, any features added this way take a long time to make=
 it to
> > > > > > > the end user.
> > > > > >
> > > > > > What I had in mind was more of a DDP model. The device loads it=
 binary
> > > > > > blob FW in whatever way it does, then it tells the kernel its p=
arser
> > > > > > graph, and tables. The kernel exposes those tables to user spac=
e.
> > > > > > All dynamic, no need to change the kernel for each new protocol=
.
> > > > > >
> > > > > > But that's different in two ways:
> > > > > >  1. the device tells kernel the tables, no "dynamic reprogrammi=
ng"
> > > > > >  2. you don't need the SW side, the only use of the API is to i=
nteract
> > > > > >     with the device
> > > > > >
> > > > > > User can still do BPF kfuncs to look up in the tables (like in =
FIB),
> > > > > > but call them from cls_bpf.
> > > > > >
> > > > >
> > > > > This is not far off from what is envisioned today in the discussi=
ons.
> > > > > The main issue is who loads the binary? We went from devlink to t=
he
> > > > > filter doing the loading. DDP is ethtool. We still need to tie a =
PCI
> > > > > device/tc block to the "program" so we can do skip_sw and it work=
s.
> > > > > Meaning a device that is capable of handling multiple programs ca=
n
> > > > > have multiple blobs loaded. A "program" is mapped to a tc filter =
and
> > > > > MAT control works the same way as it does today (netlink/tc ndo).
> > > > >
> > > > > A program in P4 has a name, ID and people have been suggesting a =
sha1
> > > > > identity (or a signature of some kind should be generated by the
> > > > > compiler). So the upward propagation could be tied to discovering
> > > > > these 3 tuples from the driver. Then the control plane targets a
> > > > > program via those tuples via netlink (as we do currently).
> > > > >
> > > > > I do note, using the DDP sample space, currently whatever gets lo=
aded
> > > > > is "trusted" and really you need to have human knowledge of what =
the
> > > > > NIC's parsing + MAT is to send the control. With P4 that is all
> > > > > visible/programmable by the end user (i am not a proponent of ven=
dors
> > > > > "shipping" things or calling them for support) - so should be
> > > > > sufficient to just discover what is in the binary and send the co=
rrect
> > > > > control messages down.
> > > > >
> > > > > > I think in P4 terms that may be something more akin to only pro=
viding
> > > > > > the runtime API? I seem to recall they had some distinction...
> > > > >
> > > > > There are several solutions out there (ex: TDI, P4runtime) - our =
API
> > > > > is netlink and those could be written on top of netlink, there's =
no
> > > > > controversy there.
> > > > > So the starting point is defining the datapath using P4, generati=
ng
> > > > > the binary blob and whatever constraints needed using the vendor
> > > > > backend and for s/w equivalent generating the eBPF datapath.
> > > > >
> > > > > > > At the cost of this sounding controversial, i am going
> > > > > > > to call things like fdb, fib, etc which have fixed datapaths =
in the
> > > > > > > kernel "legacy". These "legacy" datapaths almost all the time=
 have
> > > > > >
> > > > > > The cynic in me sometimes thinks that the biggest problem with =
"legacy"
> > > > > > protocols is that it's hard to make money on them :)
> > > > >
> > > > > That's a big motivation without a doubt, but also there are peopl=
e
> > > > > that want to experiment with things. One of the craziest examples=
 we
> > > > > have is someone who created a P4 program for "in network calculat=
or",
> > > > > essentially a calculator in the datapath. You send it two operand=
s and
> > > > > an operator using custom headers, it does the math and responds w=
ith a
> > > > > result in a new header. By itself this program is a toy but it
> > > > > demonstrates that if one wanted to, they could have something cus=
tom
> > > > > in hardware and/or kernel datapath.
> > > >
> > > > Jamal,
> > > >
> > > > Given how long P4 has been around it's surprising that the best
> > > > publicly available code example is "the network calculator" toy.
> > >
> > > Come on Tom ;-> That was just an example of something "crazy" to
> > > demonstrate freedom. I can run that in any of the P4 friendly NICs
> > > today. You are probably being facetious - There are some serious
> > > publicly available projects out there, some of which I quote on the
> > > cover letter (like DASH).
> >
> > Shameless plug. I have a more crazy example with bpf:
> >
> > https://github.com/fomichev/xdp-btc-miner
> >
>=20
> Hrm - this looks crazy interesting;-> Tempting. I guess to port this
> to P4 we'd need the sha256 in h/w (which most of these vendors have
> already). Is there any other acceleration would you need? Would have
> been more fun if you invented you own headers too ;->

Yeah, some way to do sha256(sha256(at_some_fixed_packet_offset + 80 bytes))
is one thing. And the other is some way to compare that sha256 vs some
hard-coded (difficulty) number (as a 256-byte uint). But I have no
clue how well that maps into declarative p4 language. Most likely
possible if you're saying that the calculator is possible?
I'm assuming that even sha256 can possibly be implemented in p4 without
any extra support from the vendor? It's just a bunch of xors and
rotations over a fix-sized input buffer.

