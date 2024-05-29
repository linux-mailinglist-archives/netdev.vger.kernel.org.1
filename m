Return-Path: <netdev+bounces-98999-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC30A8D356A
	for <lists+netdev@lfdr.de>; Wed, 29 May 2024 13:23:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0EC4F284FBF
	for <lists+netdev@lfdr.de>; Wed, 29 May 2024 11:23:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67D0D16EC03;
	Wed, 29 May 2024 11:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="1/vt0g0u"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9775714B973
	for <netdev@vger.kernel.org>; Wed, 29 May 2024 11:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716981778; cv=none; b=k3nyIbQZJ3maRx3LFkidecdPhVvxY8z8qqWJftDqa04wWvM0erJlVeTqcXG7SzICPT79Rx6lWgXxYtbmbsNfszS0liAZj0qUrnrqLdriCtEyPbUj3ChkwYm4X5bZMhL+UHdrB/Gfh+8Q/kCy3IuvTnqPfwjslb9X9rhJkAN3tXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716981778; c=relaxed/simple;
	bh=M/KeBIVWQXIB+c4Rzt2Dv87qGL5hfvWTsnvYrzSF5Hg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=b0OEBFbah+b2ilCRUCbYwzPlo+7wbOQYXlch8AjsHmtvml7RhMiChKkTbNFU1TSLoq3jDn26nWXyCXf6K8gY/Q/sWXuDh47zz1UN5iIHxhxJO2XUvCbgmgrxOOUF1gX0Ov8YziyJLglXCBY10j75x7R8ClXm6aMRA/aVZdmNOgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=1/vt0g0u; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-627ebbefd85so20617887b3.3
        for <netdev@vger.kernel.org>; Wed, 29 May 2024 04:22:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1716981775; x=1717586575; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2ii8Xw/O+B8r7OWcPd+pODsHRWHZaBD662vQh5LCmiM=;
        b=1/vt0g0uIvG2dcmJQJCZ9PcIchxs9m8XC+WIDpwt01BwiMbbLOasj1IG4wkYh8nChU
         yE1WhYa8iyuqvcbe62E+grnD+cSS/1wly/1p9liwQ0uXH7KhPdc0XrNk0DIteoTFRdpJ
         tU2EzJmRzojDCfmxAPj7LwfgEatNRxQ9Qa/NcHCMdSzhnu1HddAM4T3Do84OMA7YLgks
         rhPXukijfUAtE47kcw7OB7qNIKLU+MUVlk/ezMZB2pONlveaWumNd3FOIkSncnL+Opwd
         ftmLNyAjpJUdB62kR3a5teIEbJH9XfMZ8LRkV7/bqVktDsZ/LC/aurqvWts/EDJmyJJU
         QL6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716981775; x=1717586575;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2ii8Xw/O+B8r7OWcPd+pODsHRWHZaBD662vQh5LCmiM=;
        b=DCmqEFDFjUQWNli1AbK28QEuDiOwJL8jk/QGZkFsgTOjQZVwJhRyebdaBPJhN5jSuq
         LbJR9NG/pfQuOSKFXetVSmXuG0Qp64CMKO4eN7uRwD1NfLOxoSGM/mIWMarvfS2s6H9K
         lrSQLU7bI2PS3khSUjH5w+iHRDMDyD4bvsIejiPFRTcckY2ifyytI2L0ERC/K3/CfQRz
         8IA2UlThYwhQgU2ebf+qRfdwXPX1fO1qxCOlLr3z8/X5CgIWyaYJ6FMqB6XOnLXJVY8E
         GA3vCc/rvFVrzgtoQ4N42J+XRFLFcOdWBwSLhk60x/nJxATWLhUiE/k2B2Vd/y04f7jV
         LRIg==
X-Forwarded-Encrypted: i=1; AJvYcCWsWt5/oxrizMwnPlt0T5ZtGKbh5cYnQtRedAHodAOf0DfL6B38RpOxnK1+kM8ylrA5VO1YFyO1jAQz6mQP/KMKhXIgIW8g
X-Gm-Message-State: AOJu0Yw5grL8ENGo8cxEVX9DI4QxLM/cy0ME2K0TASgrq7F9NfCffGV6
	YxKhuClrAuB1osyNL181iAS+qAOlAzIvxYlSMDUwkD9I3GCbf2qyJsKRHvqow2kb7mfKzUXFob6
	rsK7HK3t7zo2F+n3BAwDdVOddECdd9H/dadyn
X-Google-Smtp-Source: AGHT+IHu7NOy6GqbaiT/qrHxhh1gB9rpWWAzkP7undGfgLM1LgZsfwhwQVGxe0I4M2OBnB8Fmg5jLnXh9cpbKa8rcGs=
X-Received: by 2002:a25:910:0:b0:df4:b780:a5df with SMTP id
 3f1490d57ef6-df7bff4726dmr5567748276.24.1716981775485; Wed, 29 May 2024
 04:22:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240410140141.495384-1-jhs@mojatatu.com> <41736ea4e81666e911fee5b880d9430ffffa9a58.camel@redhat.com>
 <CAM0EoM=982OctjvSQpx0kR7e+JnQLhvZ=sM-tNB4xNiu7nhH5Q@mail.gmail.com>
 <CAM0EoM=VhVn2sGV40SYttQyaiCn8gKaKHTUqFxB_WzKrayJJfQ@mail.gmail.com>
 <87cf4830e2e46c1882998162526e108fb424a0f7.camel@redhat.com>
 <CAM0EoMkJwR0K-fF7qo0PfRw4Sf+=2L0L=rOcH5A2ELwagLrZMw@mail.gmail.com>
 <CAM0EoMmfDoZ9_ZdK-ZjHjFAjuNN8fVK+R57_UaFqAm=wA0AWVA@mail.gmail.com>
 <82ee1013ca0164053e9fb1259eaf676343c430e8.camel@redhat.com>
 <CAADnVQLugkg+ahAapskRaE86=RnwpY8v=Nre8pn=sa4fTEoTyA@mail.gmail.com>
 <CAM0EoM=2wHem54vTeVq4H1W5pawYuHNt-aS9JyG8iQORbaw5pA@mail.gmail.com>
 <CAM0EoMmCz5usVSLq_wzR3s7UcaKifa-X58zr6hkPXuSBnwFX3w@mail.gmail.com>
 <CAM0EoMmsB5jHZ=4oJc_Yzm=RFDUHWh9yexdG6_bPFS4_CFuiog@mail.gmail.com>
 <20240522151933.6f422e63@kernel.org> <CAM0EoMmFrp5X5OzMbum5i_Bjng7Bhtk1YvWpacW6FV6Oy-3avg@mail.gmail.com>
 <CO1PR11MB499350FC06A5B87E4C770CCE93F42@CO1PR11MB4993.namprd11.prod.outlook.com>
 <MW4PR12MB71927C9E4B94871B45F845DF97F52@MW4PR12MB7192.namprd12.prod.outlook.com>
 <MW4PR12MB719209644426A0F5AE18D2E897F62@MW4PR12MB7192.namprd12.prod.outlook.com>
 <66563bc85f5d0_2f7f2087@john.notmuch> <CO1PR11MB49932999F5467416D4F7197693F12@CO1PR11MB4993.namprd11.prod.outlook.com>
 <66566c7c6778d_52e720851@john.notmuch> <CAM0EoMn3-tpDK7jAgh97ZtA5ME1W=oFxgYwHSZ3LG_HbF93FHA@mail.gmail.com>
In-Reply-To: <CAM0EoMn3-tpDK7jAgh97ZtA5ME1W=oFxgYwHSZ3LG_HbF93FHA@mail.gmail.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Wed, 29 May 2024 07:22:44 -0400
Message-ID: <CAM0EoMnu3DcmBZFwm7fTpk7YGahM5darR+cJkqC2Pdr3OqXu3g@mail.gmail.com>
Subject: Re: On the NACKs on P4TC patches
To: John Fastabend <john.fastabend@gmail.com>
Cc: "Singhai, Anjali" <anjali.singhai@intel.com>, "Jain, Vipin" <Vipin.Jain@amd.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Alexei Starovoitov <alexei.starovoitov@gmail.com>, Network Development <netdev@vger.kernel.org>, 
	"Chatterjee, Deb" <deb.chatterjee@intel.com>, "Limaye, Namrata" <namrata.limaye@intel.com>, 
	tom Herbert <tom@sipanda.io>, Marcelo Ricardo Leitner <mleitner@redhat.com>, 
	"Shirshyad, Mahesh" <Mahesh.Shirshyad@amd.com>, "Osinski, Tomasz" <tomasz.osinski@intel.com>, 
	Jiri Pirko <jiri@resnulli.us>, Cong Wang <xiyou.wangcong@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Vlad Buslov <vladbu@nvidia.com>, Simon Horman <horms@kernel.org>, Khalid Manaa <khalidm@nvidia.com>, 
	=?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>, 
	Victor Nogueira <victor@mojatatu.com>, "Tammela, Pedro" <pctammela@mojatatu.com>, 
	"Daly, Dan" <dan.daly@intel.com>, Andy Fingerhut <andy.fingerhut@gmail.com>, 
	"Sommers, Chris" <chris.sommers@keysight.com>, Matty Kadosh <mattyk@nvidia.com>, 
	bpf <bpf@vger.kernel.org>, "lwn@lwn.net" <lwn@lwn.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 29, 2024 at 7:21=E2=80=AFAM Jamal Hadi Salim <jhs@mojatatu.com>=
 wrote:
>
> On Tue, May 28, 2024 at 7:45=E2=80=AFPM John Fastabend <john.fastabend@gm=
ail.com> wrote:
> >
> > Singhai, Anjali wrote:
> > > >From: John Fastabend <john.fastabend@gmail.com>
> > > >Sent: Tuesday, May 28, 2024 1:17 PM
> > >
> > > >Jain, Vipin wrote:
> > > >> [AMD Official Use Only - AMD Internal Distribution Only]
> > > >>
> > > >> My apologies, earlier email used html and was blocked by the list.=
..
> > > >> My response at the bottom as "VJ>"
> > > >>
> > > >> ________________________________________
> > >
> > > >Anjali and Vipin is your support for HW support of P4 or a Linux SW =
implementation of P4. If its for HW support what drivers would we want to s=
upport? Can you describe how to program >these devices?
> > >
> > > >At the moment there hasn't been any movement on Linux hardware P4 su=
pport side as far as I can tell. Yes there are some SDKs and build kits flo=
ating around for FPGAs. For example >maybe start with what drivers in kerne=
l tree run the DPUs that have this support? I think this would be a product=
ive direction to go if we in fact have hardware support in the works.
> > >
> > > >If you want a SW implementation in Linux my opinion is still pushing=
 a DSL into the kernel datapath via qdisc/tc is the wrong direction. Mappin=
g P4 onto hardware blocks is fundamentally >different architecture from map=
ping
> > > >P4 onto general purpose CPU and registers. My opinion -- to handle t=
his you need a per architecture backend/JIT to compile the P4 to native ins=
tructions.
> > > >This will give you the most flexibility to define new constructs, be=
st performance, and lowest overhead runtime. We have a P4 BPF backend alrea=
dy and JITs for most architectures I don't >see the need for P4TC in this c=
ontext.
> > >
> > > >If the end goal is a hardware offload control plane I'm skeptical we=
 even need something specific just for SW datapath. I would propose a devli=
nk or new infra to program the device directly >vs overhead and complexity =
of abstracting through 'tc'. If you want to emulate your device use BPF or =
user space datapath.
> > >
> > > >.John
> > >
> > >
> > > John,
> > > Let me start by saying production hardware exists i think Jamal poste=
d some links but i can point you to our hardware.
> >
> > Maybe more direct what Linux drivers support this? That would be
> > a good first place to start IMO. Similarly what AMD hardware
> > driver supports this. If I have two drivers from two vendors
> > with P4 support this is great.
> >
> > For Intel I assume this is idpf?
> >
> > To be concrete can we start with Linux driver A and P4 program
> > P. Modprobe driver A and push P4 program P so that it does
> > something very simple, and drop a CIDR/Port range into a table.
> > Perhaps this is so obvious in your community the trouble is in
> > the context of a Linux driver its not immediately obvious to me
> > and I would suspect its not obvious to many others.
> >
> > I really think walking through the key steps here would
> > really help?
> >
> >  1. $ p4IntelCompiler p4-dos.p4 -o myp4
> >  2. $ modprobe idpf
> >  3. $ ping -i eth0 10.0.0.1 // good
> >  4. $ p4Load p4-dos.p4
> >  5. -- load cidr into the hardware somehow -- p4rt-ctrl?
> >  6. $ ping -i eth0 10.0.0.1 // dropped
> >
> > This is an honest attempt to help fwiw. Questions would be.
> >
> > For compilation do we need an artifact from Intel it seems
> > so from docs. But maybe a typo not sure. I'm not overly stuck
> > on it but worth mentioning if folks try to follow your docs.
> >
> > For 2 I assume this is just normal every day module load nothing
> > to see. Does it pop something up in /proc or in firmware or...?
> > How do I know its P4 ready?
> >
> > For 4. How does this actually work? Is it a file in a directory
> > the driver pushes into firmware? How does the firmware know
> > I've done this? Does the Linux driver already support this?
> >
> > For 5 (most interesting) how does this work today. How are
> > you currently talking to the driver/firmware to insert rules
> > and discover the tables? And does the idpf driver do this
> > already? Some side channel I guess? This is p4rt-ctrl?
> >
> > I've seen docs for above in ipdk, but they are a bit hard
> > to follow if I'm honest.
> >
> > I assume IPDK is the source folks talk to when we mention there
> > is hardware somewhere. Also it seems there is an IPDK BPF support
> > as well which is interesting.
> >
> > And do you know how the DPDK implementation works? Can we
> > learn from them is it just on top of Flow API which we
> > could easily use in devlink or some other *link I suspect.
> >
> > > The hardware devices under discussion are capable of being abstracted=
 using the P4 match-action paradigm so that's why we chose TC.
> > > These devices are programmed using the TC/netlink interface i.e the s=
tandard TC control-driver ops apply. While it is clear to us that the P4TC =
abstraction suffices, we are currently discussing details that will cater f=
or all vendors in our biweekly meetings.
> > > One big requirement is we want to avoid the flower trap - we dont wan=
t to be changing kernel/user/driver code every time we add new datapaths.
> >
> > I think many 1st order and important points have been skipped. How do y=
ou
> > program the device is it a firmware blob, a set of firmware commands,
> > something that comes to you on device so only vendor sees this? Maybe
> > I can infer this from some docs and some examples (by the way I ran
> > through some of your DPU docs and such) but its unclear how these
> > map onto Linux networking. Jiri started into this earlier and was
> > cut off because p4tc was not for hardware offload. Now it is apparently=
.
> >
> > P4 is a good DSL for this sure and it has a runtime already specified
> > which is great.
> >
> > This is not a qdisc/tc its an entire hardware pipeline I don't see
> > the reason to put it in TC at all.
> >
> > > We feel P4TC approach is the path to add Linux kernel support.
> >
> > I disagree with your implementation not your goals to support
> > flexible hardware.
> >
> > >
> > > The s/w path is needed as well for several reasons.
> > > We need the same P4 program to run either in software or hardware or =
in both using skip_sw/skip_hw. It could be either in split mode or as an ex=
ception path as it is done today in flower or u32. Also it is common now in=
 the P4 community that people define their datapath using their program and=
 will write a control application that works for both hardware and software=
 datapaths. They could be using the software datapath for testing as you sa=
id but also for the split/exception path. Chris can probably add more comme=
nts on the software datapath.
> >
> > None of above requires P4TC. For different architectures you
> > build optimal backend compilers. You have a Xilenx backend,
> > an Intel backend, and a Linux CPU based backend. I see no
> > reason to constrain the software case to map to a pipeline
> > model for example. Software running on a CPU has very different
> > characteristics from something running on a TOR, or FPGA.
> > Trying to push all these into one backend "model" will result
> > in suboptimal result for every target. At the end of the
> > day my .02$, P4 is a DSL it needs a target dependent compiler
> > in front of it. I want to optimize my software pipeline the
> > compiler should compress tables as much as possible and
> > search for a O(1) lookup even if getting that key is somewhat
> > expensive. Conversely a TCAM changes the game. An FPGA is
> > going to be flexible and make lots of tradeoffs here of which
> > I'm not an expert. Also by avoiding loading the DSL into the kernel
> > you leave room for others to build new/better/worse DSLs as they
> > please.
> >
> > The P4 community writes control applicatoins on top of the
> > runtime spec right? p4rt-ctl being the thing I found. This
> > should abstract the endpoint away to work with hardware or
> > software or FPGA or anything else.
> >
>
> For the record, _every single patchset we have posted_ specified our
> requirements as being s/w + h/w. A simpler version of the requirements
> is listed here:
> https://github.com/p4tc-dev/pushback-patches?tab=3Dreadme-ov-file#summary=
-of-our-requirements
>
> John's content variant above is described in:
> https://github.com/p4tc-dev/pushback-patches?tab=3Dreadme-ov-file#summary=
-of-our-requirements
Correction: https://github.com/p4tc-dev/pushback-patches?tab=3Dreadme-ov-fi=
le#3-comment-but-you-did-it-wrong-heres-how-you-do-it

cheers,
jamal
> According to him we should not bother with the kernel at all. It's
> what is commonly referred to as a monday-morning quarterbacking or
> arm-chair lawyering "lets just do it my way and it will all be great".
> It's 90% of these discussions and one of the reasons I put up that
> page.
>
> cheers,
> jamal

