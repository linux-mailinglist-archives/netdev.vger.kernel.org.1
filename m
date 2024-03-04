Return-Path: <netdev+bounces-77269-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BD05E871092
	for <lists+netdev@lfdr.de>; Tue,  5 Mar 2024 00:00:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E132F1C221F6
	for <lists+netdev@lfdr.de>; Mon,  4 Mar 2024 23:00:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD5487C0A8;
	Mon,  4 Mar 2024 22:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="gZM4Fslu"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1BBA7C098
	for <netdev@vger.kernel.org>; Mon,  4 Mar 2024 22:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709593198; cv=none; b=rfH6CJudIr5t3GF47QoEINYYjS9RMXg3AOICLlKGxUO1LfMFLW71XAIDDkJPhkSrfYMrM8sjX3cChAHVrzsGlNFAFhbQPMc+Bp2FGd5D3IgzpzAbZmWRDN4JoTlcoyRunYRcizCCqDkMlR/DHqbrdqJMEcbotnDvDsbCoweiddA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709593198; c=relaxed/simple;
	bh=6z/giiE9YygSr73SYZnzkC3mDTNDyJ6nkeIxDzakPjQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PoPfRL95mKCSrbPEYN37YXY8wHVRSs1uiOiznrtSJjvGlItnKTSyvOX9wtFPynLTPtXkzfJPWYohszldXdn9XL505aOdwG5kF2l6zgooQzwq6BoePdKLY50RZYMAJwMdj+OYsPlUJcyIia7dgcoxLTwp/5rewS9URTfA3+SpipE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=gZM4Fslu; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-6095dfcb461so48187547b3.2
        for <netdev@vger.kernel.org>; Mon, 04 Mar 2024 14:59:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1709593195; x=1710197995; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gof2LKqOLPBEZfgw1PSnhJLx5M2rvhB1qSQnVcrzk8s=;
        b=gZM4FslurRF50Nxew+JoJ92Coiy2W54dqPWkf6Zn0CArarI/kV4bRoftWuDhk/C4YL
         CXBOLp/CX9dFlwG9WlK9a1AC5vze5XlWglto5ZYkJvQZfb3rwVIn2+Ar22IcBQvJwtRe
         wYN8Q+qzDA1iU0F0jBBpNb3pc2Q+WYk68Thj9pt/5y+oiM+y3cutpIQQcsguX4+u96Zv
         R4pDdaoQScfZYQczSHad/PkowmP9Dzd2AYr0Cd/NMdB2Ihh7yMMYOP6UQMKs3Z8QVW2E
         lq2Szv1Dx42zrtvqQb0zuzTOASPSAx5swzZkHGV7We/3iFn65Wh6XXBKVWZ9JCAB8H8n
         C1hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709593195; x=1710197995;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gof2LKqOLPBEZfgw1PSnhJLx5M2rvhB1qSQnVcrzk8s=;
        b=SmefZCR8OHIG96zXFTSgJXiMoly7iU6aDUUE+VQFM+GmAubGNJ8KsfZHK7ImjchzfT
         rG2Ts6Uwos1+7cAf69yWe+eNJtEuKT8Plio6FPI3PmJgQHKQvQJoxg8FpG1zOI53tRKq
         2TbdlLGG+ZVH0rLOq4K4/fjDXdLVdYPqfphjZCK82xKWBdlvBESjsuqM5dwYQsni66by
         I2il7gLdpo8izpKNNzitXAyijEnEFugnflTQIeGpHAznRKXbq768ndfflec/MXZuiicw
         dfKX4gyXjVjtOQI1y+d+jJ1mwuzAk3BA2EaASgeGgk/SRBdS0vDOrFSP1Ymbvxawicn7
         PNuw==
X-Forwarded-Encrypted: i=1; AJvYcCXpNWbOVf7HnVbsDB8AkTOuzJY9e/UJsh+C7JvgLIgp3AN/1O9ND+hH4LmgufVyw6hsRypwDwYQf2Vwa4x7I6t+z/HocLTS
X-Gm-Message-State: AOJu0YwAFqlnn2Scc4CmKf/yO1U9QQjDFHMDBYtkFkBkupVwc+cB2hya
	MRyN56WEjS2VIK0uxHwATWkuy2+/+FtKcnt5FufVyqS59/iGB8bhH7bVZD+9eDq2bLytqIreQvr
	khPHM/17Yff6MM0Se9OuAoXOZXV+GZSqr7DpB
X-Google-Smtp-Source: AGHT+IF43Xggwf4lA7pnfBUxmuGKOvkRCB+JP24/JMj49S/ma+wlf7s0rKPuvFsPfg7V/wMryuGF9Uky7XjjHgYcWEM=
X-Received: by 2002:a0d:f207:0:b0:608:7686:21b5 with SMTP id
 b7-20020a0df207000000b00608768621b5mr10127278ywf.35.1709593195503; Mon, 04
 Mar 2024 14:59:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAM0EoM=-hzSNxOegHqhAQD7qoAR2CS3Dyh-chRB+H7C7TQzmow@mail.gmail.com>
 <20240301173214.3d95e22b@kernel.org> <CAM0EoM=NEB25naGtz=YaOt6BDoiv4RpDw27Y=btMZAMGeYB5bg@mail.gmail.com>
 <CAM0EoM=8GG-zCaopaUDMkvqemrZQUtaVRTMrWA6z=xrdYxG9+g@mail.gmail.com>
 <20240302192747.371684fb@kernel.org> <CAM0EoMncuPvUsRwE+Ajojgg-8JD+1oJ7j2Rw+7oN60MjjAHV-g@mail.gmail.com>
 <CAOuuhY8pgxqCg5uTXzetTt5sd8RzOfLPYF8ksLjoUhkKyqr56w@mail.gmail.com>
 <CAM0EoMnpZuC_fdzXj5+seXo3GT9rrf1txc45tB=gie4cf-Zqeg@mail.gmail.com>
 <ZeY7TqCGFR3h36k-@google.com> <CAM0EoM=b6ymCEKs14ACanbkzscy=AdARYHSWprtexHBswD7xeg@mail.gmail.com>
 <ZeZJxzRs5ayQ03ii@google.com>
In-Reply-To: <ZeZJxzRs5ayQ03ii@google.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Mon, 4 Mar 2024 17:59:43 -0500
Message-ID: <CAM0EoM=G6s-eZa2tfTdPMYufmSXTE_EBXAEgfkU84p0bRi95sQ@mail.gmail.com>
Subject: Re: Hardware Offload discussion WAS(Re: [PATCH net-next v12 00/15]
 Introducing P4TC (series 1)
To: Stanislav Fomichev <sdf@google.com>
Cc: Tom Herbert <tom@sipanda.io>, Jakub Kicinski <kuba@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, anjali.singhai@intel.com, 
	Paolo Abeni <pabeni@redhat.com>, 
	Linux Kernel Network Developers <netdev@vger.kernel.org>, deb.chatterjee@intel.com, namrata.limaye@intel.com, 
	Marcelo Ricardo Leitner <mleitner@redhat.com>, Mahesh.Shirshyad@amd.com, Vipin.Jain@amd.com, 
	tomasz.osinski@intel.com, Jiri Pirko <jiri@resnulli.us>, 
	Cong Wang <xiyou.wangcong@gmail.com>, davem@davemloft.net, 
	Eric Dumazet <edumazet@google.com>, Vlad Buslov <vladbu@nvidia.com>, Simon Horman <horms@kernel.org>, 
	Khalid Manaa <khalidm@nvidia.com>, =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>, 
	Daniel Borkmann <daniel@iogearbox.net>, Victor Nogueira <victor@mojatatu.com>, pctammela@mojatatu.com, 
	dan.daly@intel.com, Andy Fingerhut <andy.fingerhut@gmail.com>, chris.sommers@keysight.com, 
	Matty Kadosh <mattyk@nvidia.com>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 4, 2024 at 5:23=E2=80=AFPM Stanislav Fomichev <sdf@google.com> =
wrote:
>
> On 03/04, Jamal Hadi Salim wrote:
> > On Mon, Mar 4, 2024 at 4:23=E2=80=AFPM Stanislav Fomichev <sdf@google.c=
om> wrote:
> > >
> > > On 03/03, Jamal Hadi Salim wrote:
> > > > On Sun, Mar 3, 2024 at 1:11=E2=80=AFPM Tom Herbert <tom@sipanda.io>=
 wrote:
> > > > >
> > > > > On Sun, Mar 3, 2024 at 9:00=E2=80=AFAM Jamal Hadi Salim <jhs@moja=
tatu.com> wrote:
> > > > > >
> > > > > > On Sat, Mar 2, 2024 at 10:27=E2=80=AFPM Jakub Kicinski <kuba@ke=
rnel.org> wrote:
> > > > > > >
> > > > > > > On Sat, 2 Mar 2024 09:36:53 -0500 Jamal Hadi Salim wrote:
> > > > > > > > 2) Your point on:  "integrate later", or at least "fill in =
the gaps"
> > > > > > > > This part i am probably going to mumble on. I am going to c=
onsider
> > > > > > > > more than just doing ACLs/MAT via flower/u32 for the sake o=
f
> > > > > > > > discussion.
> > > > > > > > True, "fill the gaps" has been our model so far. It require=
s kernel
> > > > > > > > changes, user space code changes etc justifiably so because=
 most of
> > > > > > > > the time such datapaths are subject to standardization via =
IETF, IEEE,
> > > > > > > > etc and new extensions come in on a regular basis.  And som=
etimes we
> > > > > > > > do add features that one or two users or a single vendor ha=
s need for
> > > > > > > > at the cost of kernel and user/control extension. Given our=
 work
> > > > > > > > process, any features added this way take a long time to ma=
ke it to
> > > > > > > > the end user.
> > > > > > >
> > > > > > > What I had in mind was more of a DDP model. The device loads =
it binary
> > > > > > > blob FW in whatever way it does, then it tells the kernel its=
 parser
> > > > > > > graph, and tables. The kernel exposes those tables to user sp=
ace.
> > > > > > > All dynamic, no need to change the kernel for each new protoc=
ol.
> > > > > > >
> > > > > > > But that's different in two ways:
> > > > > > >  1. the device tells kernel the tables, no "dynamic reprogram=
ming"
> > > > > > >  2. you don't need the SW side, the only use of the API is to=
 interact
> > > > > > >     with the device
> > > > > > >
> > > > > > > User can still do BPF kfuncs to look up in the tables (like i=
n FIB),
> > > > > > > but call them from cls_bpf.
> > > > > > >
> > > > > >
> > > > > > This is not far off from what is envisioned today in the discus=
sions.
> > > > > > The main issue is who loads the binary? We went from devlink to=
 the
> > > > > > filter doing the loading. DDP is ethtool. We still need to tie =
a PCI
> > > > > > device/tc block to the "program" so we can do skip_sw and it wo=
rks.
> > > > > > Meaning a device that is capable of handling multiple programs =
can
> > > > > > have multiple blobs loaded. A "program" is mapped to a tc filte=
r and
> > > > > > MAT control works the same way as it does today (netlink/tc ndo=
).
> > > > > >
> > > > > > A program in P4 has a name, ID and people have been suggesting =
a sha1
> > > > > > identity (or a signature of some kind should be generated by th=
e
> > > > > > compiler). So the upward propagation could be tied to discoveri=
ng
> > > > > > these 3 tuples from the driver. Then the control plane targets =
a
> > > > > > program via those tuples via netlink (as we do currently).
> > > > > >
> > > > > > I do note, using the DDP sample space, currently whatever gets =
loaded
> > > > > > is "trusted" and really you need to have human knowledge of wha=
t the
> > > > > > NIC's parsing + MAT is to send the control. With P4 that is all
> > > > > > visible/programmable by the end user (i am not a proponent of v=
endors
> > > > > > "shipping" things or calling them for support) - so should be
> > > > > > sufficient to just discover what is in the binary and send the =
correct
> > > > > > control messages down.
> > > > > >
> > > > > > > I think in P4 terms that may be something more akin to only p=
roviding
> > > > > > > the runtime API? I seem to recall they had some distinction..=
.
> > > > > >
> > > > > > There are several solutions out there (ex: TDI, P4runtime) - ou=
r API
> > > > > > is netlink and those could be written on top of netlink, there'=
s no
> > > > > > controversy there.
> > > > > > So the starting point is defining the datapath using P4, genera=
ting
> > > > > > the binary blob and whatever constraints needed using the vendo=
r
> > > > > > backend and for s/w equivalent generating the eBPF datapath.
> > > > > >
> > > > > > > > At the cost of this sounding controversial, i am going
> > > > > > > > to call things like fdb, fib, etc which have fixed datapath=
s in the
> > > > > > > > kernel "legacy". These "legacy" datapaths almost all the ti=
me have
> > > > > > >
> > > > > > > The cynic in me sometimes thinks that the biggest problem wit=
h "legacy"
> > > > > > > protocols is that it's hard to make money on them :)
> > > > > >
> > > > > > That's a big motivation without a doubt, but also there are peo=
ple
> > > > > > that want to experiment with things. One of the craziest exampl=
es we
> > > > > > have is someone who created a P4 program for "in network calcul=
ator",
> > > > > > essentially a calculator in the datapath. You send it two opera=
nds and
> > > > > > an operator using custom headers, it does the math and responds=
 with a
> > > > > > result in a new header. By itself this program is a toy but it
> > > > > > demonstrates that if one wanted to, they could have something c=
ustom
> > > > > > in hardware and/or kernel datapath.
> > > > >
> > > > > Jamal,
> > > > >
> > > > > Given how long P4 has been around it's surprising that the best
> > > > > publicly available code example is "the network calculator" toy.
> > > >
> > > > Come on Tom ;-> That was just an example of something "crazy" to
> > > > demonstrate freedom. I can run that in any of the P4 friendly NICs
> > > > today. You are probably being facetious - There are some serious
> > > > publicly available projects out there, some of which I quote on the
> > > > cover letter (like DASH).
> > >
> > > Shameless plug. I have a more crazy example with bpf:
> > >
> > > https://github.com/fomichev/xdp-btc-miner
> > >
> >
> > Hrm - this looks crazy interesting;-> Tempting. I guess to port this
> > to P4 we'd need the sha256 in h/w (which most of these vendors have
> > already). Is there any other acceleration would you need? Would have
> > been more fun if you invented you own headers too ;->
>
> Yeah, some way to do sha256(sha256(at_some_fixed_packet_offset + 80 bytes=
))

This part is straight forward.

> is one thing. And the other is some way to compare that sha256 vs some
> hard-coded (difficulty) number (as a 256-byte uint).

The compiler may have issues with this comparison - will have to look
(I am pretty sure it's fixable though).


>  But I have no
> clue how well that maps into declarative p4 language. Most likely
> possible if you're saying that the calculator is possible?

The calculator basically is written as a set of match-action tables.
You parse your header, construct a key based on the operator field of
the header (eg "+"),  invoke an action which takes the operands from
the headers(eg "1" and "2"), the action returns you results(3"). You
stash the result in a new packet and send it back to the source.

So my thinking is the computation you need would be modelled on an action.

> I'm assuming that even sha256 can possibly be implemented in p4 without
> any extra support from the vendor? It's just a bunch of xors and
> rotations over a fix-sized input buffer.

True,  and I think those would be fast. But if the h/w offers it as an
interface why not.
It's not that you are running out of instruction space - and my memory
is hazy - but iirc, there is sha256 support in the kernel Crypto API -
does it not make sense to kfunc into that?

cheers,
jamal

