Return-Path: <netdev+bounces-77274-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5393A8710FA
	for <lists+netdev@lfdr.de>; Tue,  5 Mar 2024 00:14:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 10EC628221C
	for <lists+netdev@lfdr.de>; Mon,  4 Mar 2024 23:14:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03B0F7C6C6;
	Mon,  4 Mar 2024 23:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="a+fzMkMz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E0D27B3FA
	for <netdev@vger.kernel.org>; Mon,  4 Mar 2024 23:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709594092; cv=none; b=FK2NUXZI2pyUTUCAbTy1JQoZ3WwvNLgXKQDYOhdSXi6FT0rstlohRZd+3wHnYw6wcgWzRVfwyVaYQc5YosaVFApwfnCO9yCT5ch6R903ftCAjbwLgwekxB2UDlldM7JHOzbp+9IFXSBl3vUToSJ4y7p/koFUUmSkvtR4Eo2+ZY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709594092; c=relaxed/simple;
	bh=VHn4XdOTtPFjTDo31/wfnO57B+jM9iiwHRQdmKptEaU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=dM+fcFTclAk+qWeCSa1YdQqS0TMh/ytNPBJcyNKiD279+la35b3WkFctZX04FAqVSFrV4I/buYgds8RgyOwjS2ML+yP/5Gfab6TrFx7oPQ3K208DU3CnsZNV9FSKGINo690xbSSu+eZA4U8Nu4UG24XFt7JthDUgqBHf/640qPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--sdf.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=a+fzMkMz; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--sdf.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-6e5588db705so3801305b3a.1
        for <netdev@vger.kernel.org>; Mon, 04 Mar 2024 15:14:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709594090; x=1710198890; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=H2aSDUKapPJ8O+f7PfrUpvwvIiwFtwosW4yjOmWXGQY=;
        b=a+fzMkMzY5I+iFve3bpuLbRObmF4ALj65Cnx2aaocb7PikbY0WPVnvjyjl9S2s8gUg
         mn8K/NAsp5iIUIzNgZEFbdcBoihINY/YCnC5xpOF7+pC3lpYaIvog56ptdYV5KQdMgX5
         NHVrVvlJq5sR8hJhsydyNElAYTR8E0r/y213PLm4R1/teKj7GKvITbTdQqeXj5y46CiD
         JN3J/NBg+Dy/mlSmxdQPdv2V7ipD5y3KddICQG94JB2J2KkKc0TUQmpTBXg5LlL/2bIW
         RjLotDTcUVZsL/skk19u10LMZ7fdpTEvvcDGs6sWJzgyCxV05t/PEN0xGCUY9q3i2Hn5
         Tp4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709594090; x=1710198890;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=H2aSDUKapPJ8O+f7PfrUpvwvIiwFtwosW4yjOmWXGQY=;
        b=RrZX69BiPzLi3e8y5xmzRliUTbhfq5oQr7P0ewtY4p3YqhIYMdwoz1te6/pdgiDjfJ
         jWWk/YOPEVKbQovPIQZl652q7AC0hEJpeEdZeMiby1mnt7Uk0WQbElAaQKnlRBbA3etW
         flPGNlqsXk++SIg3d7TYiEHdZKSHeKcA5Dxrf+g0d+78AvDTz0deKmHiYevQ0T5WXosp
         NicaRqaGQOwfYQJP+o+xDttcUwvrIFMlxM57verwuVQs6rIkza+B0rV+z5A3QAHa18XE
         QrDGCtY3ch4HVPHFTNM31egpwXZgw3xSw7fIoR43XBQRqS1d+alWVHNK2kLzQ91bn7qp
         Y3aA==
X-Forwarded-Encrypted: i=1; AJvYcCUzGqGrhkU0eNm/3g4+aimFGSuOTnOZHvs+DU8QYLXa2wweYUB/kBIdUphBg4Ba4OviQyiGhweFsScn/wgh+yiOJkCECXBg
X-Gm-Message-State: AOJu0YwojtCFQFoPSRCSh8oPKtSwHozM+E2KSduDRf6q2LfHw7ggB8aa
	YzFPXqeGS+tdfa+YLd+dOHbH07dukayIz0ysUWVmj2aRJ1UNhrVVggOTvW0GuVofpw==
X-Google-Smtp-Source: AGHT+IGSE5jvKHhH+ixh6V1SQqQZE9dvPJ/J71kAoOxY7d1Ge9z9L4mxDozj5xfXfpfPxDndToC2HOs=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a05:6a00:2d1a:b0:6e5:118:33cf with SMTP id
 fa26-20020a056a002d1a00b006e5011833cfmr52137pfb.2.1709594090486; Mon, 04 Mar
 2024 15:14:50 -0800 (PST)
Date: Mon, 4 Mar 2024 15:14:49 -0800
In-Reply-To: <CAM0EoM=G6s-eZa2tfTdPMYufmSXTE_EBXAEgfkU84p0bRi95sQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <CAM0EoM=NEB25naGtz=YaOt6BDoiv4RpDw27Y=btMZAMGeYB5bg@mail.gmail.com>
 <CAM0EoM=8GG-zCaopaUDMkvqemrZQUtaVRTMrWA6z=xrdYxG9+g@mail.gmail.com>
 <20240302192747.371684fb@kernel.org> <CAM0EoMncuPvUsRwE+Ajojgg-8JD+1oJ7j2Rw+7oN60MjjAHV-g@mail.gmail.com>
 <CAOuuhY8pgxqCg5uTXzetTt5sd8RzOfLPYF8ksLjoUhkKyqr56w@mail.gmail.com>
 <CAM0EoMnpZuC_fdzXj5+seXo3GT9rrf1txc45tB=gie4cf-Zqeg@mail.gmail.com>
 <ZeY7TqCGFR3h36k-@google.com> <CAM0EoM=b6ymCEKs14ACanbkzscy=AdARYHSWprtexHBswD7xeg@mail.gmail.com>
 <ZeZJxzRs5ayQ03ii@google.com> <CAM0EoM=G6s-eZa2tfTdPMYufmSXTE_EBXAEgfkU84p0bRi95sQ@mail.gmail.com>
Message-ID: <ZeZV6UE-Zf5XzTQr@google.com>
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
> On Mon, Mar 4, 2024 at 5:23=E2=80=AFPM Stanislav Fomichev <sdf@google.com=
> wrote:
> >
> > On 03/04, Jamal Hadi Salim wrote:
> > > On Mon, Mar 4, 2024 at 4:23=E2=80=AFPM Stanislav Fomichev <sdf@google=
.com> wrote:
> > > >
> > > > On 03/03, Jamal Hadi Salim wrote:
> > > > > On Sun, Mar 3, 2024 at 1:11=E2=80=AFPM Tom Herbert <tom@sipanda.i=
o> wrote:
> > > > > >
> > > > > > On Sun, Mar 3, 2024 at 9:00=E2=80=AFAM Jamal Hadi Salim <jhs@mo=
jatatu.com> wrote:
> > > > > > >
> > > > > > > On Sat, Mar 2, 2024 at 10:27=E2=80=AFPM Jakub Kicinski <kuba@=
kernel.org> wrote:
> > > > > > > >
> > > > > > > > On Sat, 2 Mar 2024 09:36:53 -0500 Jamal Hadi Salim wrote:
> > > > > > > > > 2) Your point on:  "integrate later", or at least "fill i=
n the gaps"
> > > > > > > > > This part i am probably going to mumble on. I am going to=
 consider
> > > > > > > > > more than just doing ACLs/MAT via flower/u32 for the sake=
 of
> > > > > > > > > discussion.
> > > > > > > > > True, "fill the gaps" has been our model so far. It requi=
res kernel
> > > > > > > > > changes, user space code changes etc justifiably so becau=
se most of
> > > > > > > > > the time such datapaths are subject to standardization vi=
a IETF, IEEE,
> > > > > > > > > etc and new extensions come in on a regular basis.  And s=
ometimes we
> > > > > > > > > do add features that one or two users or a single vendor =
has need for
> > > > > > > > > at the cost of kernel and user/control extension. Given o=
ur work
> > > > > > > > > process, any features added this way take a long time to =
make it to
> > > > > > > > > the end user.
> > > > > > > >
> > > > > > > > What I had in mind was more of a DDP model. The device load=
s it binary
> > > > > > > > blob FW in whatever way it does, then it tells the kernel i=
ts parser
> > > > > > > > graph, and tables. The kernel exposes those tables to user =
space.
> > > > > > > > All dynamic, no need to change the kernel for each new prot=
ocol.
> > > > > > > >
> > > > > > > > But that's different in two ways:
> > > > > > > >  1. the device tells kernel the tables, no "dynamic reprogr=
amming"
> > > > > > > >  2. you don't need the SW side, the only use of the API is =
to interact
> > > > > > > >     with the device
> > > > > > > >
> > > > > > > > User can still do BPF kfuncs to look up in the tables (like=
 in FIB),
> > > > > > > > but call them from cls_bpf.
> > > > > > > >
> > > > > > >
> > > > > > > This is not far off from what is envisioned today in the disc=
ussions.
> > > > > > > The main issue is who loads the binary? We went from devlink =
to the
> > > > > > > filter doing the loading. DDP is ethtool. We still need to ti=
e a PCI
> > > > > > > device/tc block to the "program" so we can do skip_sw and it =
works.
> > > > > > > Meaning a device that is capable of handling multiple program=
s can
> > > > > > > have multiple blobs loaded. A "program" is mapped to a tc fil=
ter and
> > > > > > > MAT control works the same way as it does today (netlink/tc n=
do).
> > > > > > >
> > > > > > > A program in P4 has a name, ID and people have been suggestin=
g a sha1
> > > > > > > identity (or a signature of some kind should be generated by =
the
> > > > > > > compiler). So the upward propagation could be tied to discove=
ring
> > > > > > > these 3 tuples from the driver. Then the control plane target=
s a
> > > > > > > program via those tuples via netlink (as we do currently).
> > > > > > >
> > > > > > > I do note, using the DDP sample space, currently whatever get=
s loaded
> > > > > > > is "trusted" and really you need to have human knowledge of w=
hat the
> > > > > > > NIC's parsing + MAT is to send the control. With P4 that is a=
ll
> > > > > > > visible/programmable by the end user (i am not a proponent of=
 vendors
> > > > > > > "shipping" things or calling them for support) - so should be
> > > > > > > sufficient to just discover what is in the binary and send th=
e correct
> > > > > > > control messages down.
> > > > > > >
> > > > > > > > I think in P4 terms that may be something more akin to only=
 providing
> > > > > > > > the runtime API? I seem to recall they had some distinction=
...
> > > > > > >
> > > > > > > There are several solutions out there (ex: TDI, P4runtime) - =
our API
> > > > > > > is netlink and those could be written on top of netlink, ther=
e's no
> > > > > > > controversy there.
> > > > > > > So the starting point is defining the datapath using P4, gene=
rating
> > > > > > > the binary blob and whatever constraints needed using the ven=
dor
> > > > > > > backend and for s/w equivalent generating the eBPF datapath.
> > > > > > >
> > > > > > > > > At the cost of this sounding controversial, i am going
> > > > > > > > > to call things like fdb, fib, etc which have fixed datapa=
ths in the
> > > > > > > > > kernel "legacy". These "legacy" datapaths almost all the =
time have
> > > > > > > >
> > > > > > > > The cynic in me sometimes thinks that the biggest problem w=
ith "legacy"
> > > > > > > > protocols is that it's hard to make money on them :)
> > > > > > >
> > > > > > > That's a big motivation without a doubt, but also there are p=
eople
> > > > > > > that want to experiment with things. One of the craziest exam=
ples we
> > > > > > > have is someone who created a P4 program for "in network calc=
ulator",
> > > > > > > essentially a calculator in the datapath. You send it two ope=
rands and
> > > > > > > an operator using custom headers, it does the math and respon=
ds with a
> > > > > > > result in a new header. By itself this program is a toy but i=
t
> > > > > > > demonstrates that if one wanted to, they could have something=
 custom
> > > > > > > in hardware and/or kernel datapath.
> > > > > >
> > > > > > Jamal,
> > > > > >
> > > > > > Given how long P4 has been around it's surprising that the best
> > > > > > publicly available code example is "the network calculator" toy=
.
> > > > >
> > > > > Come on Tom ;-> That was just an example of something "crazy" to
> > > > > demonstrate freedom. I can run that in any of the P4 friendly NIC=
s
> > > > > today. You are probably being facetious - There are some serious
> > > > > publicly available projects out there, some of which I quote on t=
he
> > > > > cover letter (like DASH).
> > > >
> > > > Shameless plug. I have a more crazy example with bpf:
> > > >
> > > > https://github.com/fomichev/xdp-btc-miner
> > > >
> > >
> > > Hrm - this looks crazy interesting;-> Tempting. I guess to port this
> > > to P4 we'd need the sha256 in h/w (which most of these vendors have
> > > already). Is there any other acceleration would you need? Would have
> > > been more fun if you invented you own headers too ;->
> >
> > Yeah, some way to do sha256(sha256(at_some_fixed_packet_offset + 80 byt=
es))
>=20
> This part is straight forward.
>=20
> > is one thing. And the other is some way to compare that sha256 vs some
> > hard-coded (difficulty) number (as a 256-byte uint).
>=20
> The compiler may have issues with this comparison - will have to look
> (I am pretty sure it's fixable though).
>=20
>=20
> >  But I have no
> > clue how well that maps into declarative p4 language. Most likely
> > possible if you're saying that the calculator is possible?
>=20
> The calculator basically is written as a set of match-action tables.
> You parse your header, construct a key based on the operator field of
> the header (eg "+"),  invoke an action which takes the operands from
> the headers(eg "1" and "2"), the action returns you results(3"). You
> stash the result in a new packet and send it back to the source.
>=20
> So my thinking is the computation you need would be modelled on an action=
.
>=20
> > I'm assuming that even sha256 can possibly be implemented in p4 without
> > any extra support from the vendor? It's just a bunch of xors and
> > rotations over a fix-sized input buffer.

[..]

> True,  and I think those would be fast. But if the h/w offers it as an
> interface why not.
> It's not that you are running out of instruction space - and my memory
> is hazy - but iirc, there is sha256 support in the kernel Crypto API -
> does it not make sense to kfunc into that?

Oh yeah, that's definitely a better path if somebody were do to it
"properly". It's still fun, though, to see how far we can push
the bpf vm/verifier without using any extra helpers :-D

