Return-Path: <netdev+bounces-77243-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38848870C44
	for <lists+netdev@lfdr.de>; Mon,  4 Mar 2024 22:19:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A37F1C2138D
	for <lists+netdev@lfdr.de>; Mon,  4 Mar 2024 21:19:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 469841CAA6;
	Mon,  4 Mar 2024 21:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="q4r2D+Sg"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9977A1C680
	for <netdev@vger.kernel.org>; Mon,  4 Mar 2024 21:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709587152; cv=none; b=fM/X1hxgO2GjtkoFPgI4i2P8kqa/1dftK+SE5SNRVGbsWRuHP46kA30s3zynhIrnQEjmcaI1pHnBgp3XFhMYSv9UflpRZSMgR1YDoC4SUiCpjW8mgcItCo+N19Sxd+bd0SZdJlPSIZQa8E4waJDNBM5z/SJQmhqBAkRwi4ARmRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709587152; c=relaxed/simple;
	bh=k3sS1xa9FcOHJXVg0/nwKOU7OeW6fzkb7LbKTkTXG50=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=c0Gsd4hjdo003nSgn/78SeLXwI2OVcV6XRapuP21fM7lSah8J12mNEXij/YqNmmB+PMZ6Czi15wa6/s3cNO/DRZsVV1yGsNt4goTa8X9N4y+IbA4aIpZbZma+lJDkjG9tPJvSwHwUuU+VsledqLXKefZq+0ivZqwEQeehpueH9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--sdf.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=q4r2D+Sg; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--sdf.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-6e5d234fb2bso2932222b3a.0
        for <netdev@vger.kernel.org>; Mon, 04 Mar 2024 13:19:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709587150; x=1710191950; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=k3sS1xa9FcOHJXVg0/nwKOU7OeW6fzkb7LbKTkTXG50=;
        b=q4r2D+SgFjmOA3dNDSXQcTM3I/8AB4IH9R8QAPbsjr2IG0MyFzErpfL5yUx9aypJbG
         JtfH3XcUcWUkLJSiBCGy8WLTO0cv02JaxLgmXvk7YrebuApq8K6IxslzA5ikF5+gIugc
         /aIV1/ljeyjuSY+IO1gHEclNugNstVQAdIGyUQRzBNS9ijlOhWuXuggGDXx+j+Ew995X
         vNPs3yUt7EqF/1VMrJy0p5PBiZcEWqqZ8vaaOh3O8fLHcEt9tQyLwkz46N49Nad3iRwX
         FB3lJspsWuHf4pD8KZw4DE1ORuXECsJx+XLbhDaRTZLXenDmYUrNgBUbxJFmcRjT5h2J
         5Rzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709587150; x=1710191950;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=k3sS1xa9FcOHJXVg0/nwKOU7OeW6fzkb7LbKTkTXG50=;
        b=IVSmvE/r8x9XAnpxZA855vOMiqZJXKqy7qT1Qpe2N/Dbjw3sMT3RLD28UNxqAYRiqf
         o8qRQ5czRO0X3tOXbHqMbdep5rbKY9/63orTUvDEmXgJTE0YBgf+RpG8PCUf8ZF7LqbB
         9Puu5gglYj93UZr3aGG8vAZRI5YV0iGuzddzlW6l1hE63epQBS6jg2n96PTqYrsTuw9d
         JRSm6VnzZjlXgvIiOf87lShjjMJxybIYKTtwDiyQpHYS4reOATWxlB/RAMeOjuc9hlH0
         Wcq+z5eLELP6csejCPFf6nXL67ODade+0DomIbMNVWnpKcUUUN1O6veJ2Yfo8ELE/HwW
         nzrQ==
X-Forwarded-Encrypted: i=1; AJvYcCVC29UyMeajh+XhvD/BKPmf+DJKREuF5v2pNzmaMBgrSN98/l8SQC39CGUNYNSMT6SUtHUWE//Vq/WX+bInnLo0V+yrLJya
X-Gm-Message-State: AOJu0Yzr3fCiPEMNk4U0ChYEn+l70Sn89AiqFpKYYrlSMjSEOTZNtc6g
	U9COAvx4GlTJbuvVWGtvJLG8nmwqhpHAuKVGHbaQXXay563hOBQ+vq5GwmxfYU2n/A==
X-Google-Smtp-Source: AGHT+IFOfiDgOh8WUWMiJcCbvTlXfunkE/C3+awrmxdSfPyg0d0LpSx2jGuMg5PqEbIg55wzy3DbnaU=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a05:6a00:1808:b0:6e5:9a0a:b66a with SMTP id
 y8-20020a056a00180800b006e59a0ab66amr586699pfa.3.1709587150006; Mon, 04 Mar
 2024 13:19:10 -0800 (PST)
Date: Mon, 4 Mar 2024 13:19:08 -0800
In-Reply-To: <CAOuuhY_senZbdC2cVU9kfDww_bT+a_VkNaDJYRk4_fMbJW17sQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <CO1PR11MB49931E501B20F32681F917CD935F2@CO1PR11MB4993.namprd11.prod.outlook.com>
 <65e106305ad8b_43ad820892@john.notmuch> <CAM0EoM=r1UDnkp-csPdrz6nBt7o3fHUncXKnO7tB_rcZAcbrDg@mail.gmail.com>
 <CAOuuhY8qbsYCjdUYUZv8J3jz8HGXmtxLmTDP6LKgN5uRVZwMnQ@mail.gmail.com>
 <20240301090020.7c9ebc1d@kernel.org> <CAM0EoM=-hzSNxOegHqhAQD7qoAR2CS3Dyh-chRB+H7C7TQzmow@mail.gmail.com>
 <20240301173214.3d95e22b@kernel.org> <CAOuuhY8fnpEEBb8z-1mQmvHtfZQwgQnXk3=op-Xk108Pts8ohA@mail.gmail.com>
 <20240302191530.22353670@kernel.org> <CAOuuhY_senZbdC2cVU9kfDww_bT+a_VkNaDJYRk4_fMbJW17sQ@mail.gmail.com>
Message-ID: <ZeY6r9cm4pdW9WNC@google.com>
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

On 03/03, Tom Herbert wrote:
> On Sat, Mar 2, 2024 at 7:15=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> w=
rote:
> >
> > On Fri, 1 Mar 2024 18:20:36 -0800 Tom Herbert wrote:
> > > This is configurability versus programmability. The table driven
> > > approach as input (configurability) might work fine for generic
> > > match-action tables up to the point that tables are expressive enough
> > > to satisfy the requirements. But parsing doesn't fall into the table
> > > driven paradigm: parsers want to be *programmed*. This is why we
> > > removed kParser from this patch set and fell back to eBPF for parsing=
.
> > > But the problem we quickly hit that eBPF is not offloadable to networ=
k
> > > devices, for example when we compile P4 in an eBPF parser we've lost
> > > the declarative representation that parsers in the devices could
> > > consume (they're not CPUs running eBPF).
> > >
> > > I think the key here is what we mean by kernel offload. When we do
> > > kernel offload, is it the kernel implementation or the kernel
> > > functionality that's being offloaded? If it's the latter then we have
> > > a lot more flexibility. What we'd need is a safe and secure way to
> > > synchronize with that offload device that precisely supports the
> > > kernel functionality we'd like to offload. This can be done if both
> > > the kernel bits and programmed offload are derived from the same
> > > source (i.e. tag source code with a sha-1). For example, if someone
> > > writes a parser in P4, we can compile that into both eBPF and a P4
> > > backend using independent tool chains and program download. At
> > > runtime, the kernel can safely offload the functionality of the eBPF
> > > parser to the device if it matches the hash to that reported by the
> > > device
> >
> > Good points. If I understand you correctly you're saying that parsers
> > are more complex than just a basic parsing tree a'la u32.
>=20
> Yes. Parsing things like TLVs, GRE flag field, or nested protobufs
> isn't conducive to u32. We also want the advantages of compiler
> optimizations to unroll loops, squash nodes in the parse graph, etc.
>=20
> > Then we can take this argument further. P4 has grown to encompass a lot
> > of functionality of quite complex devices. How do we square that with
> > the kernel functionality offload model. If the entire device is modeled=
,
> > including f.e. TSO, an offload would mean that the user has to write
> > a TSO implementation which they then load into TC? That seems odd.
> >
> > IOW I don't quite know how to square in my head the "total
> > functionality" with being a TC-based "plugin".
>=20
> Hi Jakub,
>=20
> I believe the solution is to replace kernel code with eBPF in cases
> where we need programmability. This effectively means that we would
> ship eBPF code as part of the kernel. So in the case of TSO, the
> kernel would include a standard implementation in eBPF that could be
> compiled into the kernel by default. The restricted C source code is
> tagged with a hash, so if someone wants to offload TSO they could
> compile the source into their target and retain the hash. At runtime
> it's a matter of querying the driver to see if the device supports the
> TSO program the kernel is running by comparing hash values. Scaling
> this, a device could support a catalogue of programs: TSO, LRO,
> parser, IPtables, etc., If the kernel can match the hash of its eBPF
> code to one reported by the driver then it can assume functionality is
> offloadable. This is an elaboration of "device features", but instead
> of the device telling us they think they support an adequate GRO
> implementation by reporting NETIF_F_GRO, the device would tell the
> kernel that they not only support GRO but they provide identical
> functionality of the kernel GRO (which IMO is the first requirement of
> kernel offload).
>=20
> Even before considering hardware offload, I think this approach
> addresses a more fundamental problem to make the kernel programmable.
> Since the code is in eBPF, the kernel can be reprogrammed at runtime
> which could be controlled by TC. This allows local customization of
> kernel features, but also is the simplest way to "patch" the kernel
> with security and bug fixes (nobody is ever excited to do a kernel

[..]

> rebase in their datacenter!). Flow dissector is a prime candidate for
> this, and I am still planning to replace it with an all eBPF program
> (https://netdevconf.info/0x15/slides/16/Flow%20dissector_PANDA%20parser.p=
df).

So you're suggesting to bundle (and extend)
tools/testing/selftests/bpf/progs/bpf_flow.c? We were thinking along
similar lines here. We load this program manually right now, shipping
and autoloading with the kernel will be easer.

