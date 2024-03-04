Return-Path: <netdev+bounces-77215-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57845870B61
	for <lists+netdev@lfdr.de>; Mon,  4 Mar 2024 21:19:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 89C011C2285B
	for <lists+netdev@lfdr.de>; Mon,  4 Mar 2024 20:19:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 202DC7BAF5;
	Mon,  4 Mar 2024 20:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B2B3YVVc"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E74847A159;
	Mon,  4 Mar 2024 20:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709583495; cv=none; b=mwn9uEhFogpa80tf8uUb1RhF0QmD6t11oj/2toIlU4JBbetbXBUe6FEjNMJNBj4Pxb4cClkAr0vBrLEtmuhw3BUR/y4IRHKeK4qx0Y7+OEFfYJu3l1IaQaSyL4tXR32OXisy9TtYwbYctj9Pn+QnAIoMvd8RKCGBsWNUoYvB128=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709583495; c=relaxed/simple;
	bh=K23JakM1P875wWRg3o7Bh9hwijeqRnaAhC1ZmI9DT6M=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cA9aS7433uGEzdqz1TmuE3VLiy3H/h+kcHd5+/H5ZUn4Pf8D72KQ6+SBLCma90fr6bJ4leKHd4qQjfcco+C7Jn3sQafBwSdZbCPcu57WtoC+3INPi6+0bqio8u5yp1rMvw3ynP+ZuvwzL0Xd0B1VsdDADba0eDVVFJOS3q4+k0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B2B3YVVc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BA78C433C7;
	Mon,  4 Mar 2024 20:18:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709583494;
	bh=K23JakM1P875wWRg3o7Bh9hwijeqRnaAhC1ZmI9DT6M=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=B2B3YVVcAg8euaTwpzEAd/U1Mfwf7tB4GGnKpAL4c6DXaH40QiIQ8sYrV5qR7+UNK
	 C8zI9NZMUp7WlD+6qbngi8mvkFAi+XcB9ErtTWwyNV/ycwg05fSduQlzjkc0jnd0W5
	 egCdnN3hqWDnxz8bgKq6JrPnhW7z0RvpKAbKUpeec5M7+i3bz/UBKSX9LfFYcal1ji
	 W0+aYPH//qKinG+K2Q6nCD2ce0ihyUojtNDEwtrlHeyptlPAbV32/1cpywzyVY+lEP
	 ddoCM8rh0mguz99kr5Uf2hJ3swvLeJgDO67JnUX90jEsAT5URs/hMALGoj8oQWVSKT
	 6RzPIKvoD7PyQ==
Date: Mon, 4 Mar 2024 12:18:12 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: Tom Herbert <tom@sipanda.io>, John Fastabend <john.fastabend@gmail.com>,
 "Singhai, Anjali" <anjali.singhai@intel.com>, Paolo Abeni
 <pabeni@redhat.com>, Linux Kernel Network Developers
 <netdev@vger.kernel.org>, "Chatterjee, Deb" <deb.chatterjee@intel.com>,
 "Limaye, Namrata" <namrata.limaye@intel.com>, Marcelo Ricardo Leitner
 <mleitner@redhat.com>, "Shirshyad, Mahesh" <Mahesh.Shirshyad@amd.com>,
 "Jain, Vipin" <Vipin.Jain@amd.com>, "Osinski, Tomasz"
 <tomasz.osinski@intel.com>, Jiri Pirko <jiri@resnulli.us>, Cong Wang
 <xiyou.wangcong@gmail.com>, "David S . Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Vlad Buslov <vladbu@nvidia.com>, Simon
 Horman <horms@kernel.org>, Khalid Manaa <khalidm@nvidia.com>, Toke
 =?UTF-8?B?SMO4aWxhbmQtSsO4cmdlbnNlbg==?= <toke@redhat.com>, Daniel Borkmann
 <daniel@iogearbox.net>, Victor Nogueira <victor@mojatatu.com>, "Tammela,
 Pedro" <pctammela@mojatatu.com>, "Daly, Dan" <dan.daly@intel.com>, Andy
 Fingerhut <andy.fingerhut@gmail.com>, "Sommers, Chris"
 <chris.sommers@keysight.com>, Matty Kadosh <mattyk@nvidia.com>, bpf
 <bpf@vger.kernel.org>
Subject: Re: Hardware Offload discussion WAS(Re: [PATCH net-next v12 00/15]
 Introducing P4TC (series 1)
Message-ID: <20240304121812.450dda4c@kernel.org>
In-Reply-To: <CAM0EoMnpZuC_fdzXj5+seXo3GT9rrf1txc45tB=gie4cf-Zqeg@mail.gmail.com>
References: <20240225165447.156954-1-jhs@mojatatu.com>
	<b28f2f7900dc7bad129ad67621b2f7746c3b2e18.camel@redhat.com>
	<CO1PR11MB49931E501B20F32681F917CD935F2@CO1PR11MB4993.namprd11.prod.outlook.com>
	<65e106305ad8b_43ad820892@john.notmuch>
	<CAM0EoM=r1UDnkp-csPdrz6nBt7o3fHUncXKnO7tB_rcZAcbrDg@mail.gmail.com>
	<CAOuuhY8qbsYCjdUYUZv8J3jz8HGXmtxLmTDP6LKgN5uRVZwMnQ@mail.gmail.com>
	<20240301090020.7c9ebc1d@kernel.org>
	<CAM0EoM=-hzSNxOegHqhAQD7qoAR2CS3Dyh-chRB+H7C7TQzmow@mail.gmail.com>
	<20240301173214.3d95e22b@kernel.org>
	<CAM0EoM=NEB25naGtz=YaOt6BDoiv4RpDw27Y=btMZAMGeYB5bg@mail.gmail.com>
	<CAM0EoM=8GG-zCaopaUDMkvqemrZQUtaVRTMrWA6z=xrdYxG9+g@mail.gmail.com>
	<20240302192747.371684fb@kernel.org>
	<CAM0EoMncuPvUsRwE+Ajojgg-8JD+1oJ7j2Rw+7oN60MjjAHV-g@mail.gmail.com>
	<CAOuuhY8pgxqCg5uTXzetTt5sd8RzOfLPYF8ksLjoUhkKyqr56w@mail.gmail.com>
	<CAM0EoMnpZuC_fdzXj5+seXo3GT9rrf1txc45tB=gie4cf-Zqeg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 3 Mar 2024 14:04:11 -0500 Jamal Hadi Salim wrote:
> > At
> > this point in its lifetime, eBPF had far more examples of real world
> > use cases publically available. That being said, there's nothing
> > unique about P4 supporting the network calculator. We could just as
> > easily write this in eBPF (either plain C or P4)  and "offload" it to
> > an ARM core on a SmartNIC.  
> 
> With current port speeds hitting 800gbps you want to use Arm cores as
> your offload engine?;-> Running the generated ebpf on the arm core is
> a valid P4 target.  i.e there is no contradiction.
> Note: P4 is a DSL specialized for datapath definition; it is not a
> competition to ebpf, two different worlds. I see ebpf as an
> infrastructure tool, nothing more.

I wonder how much we're benefiting of calling this thing P4 and how
much we should focus on filling in the tech gaps.
Exactly like you said, BPF is not competition, but neither does 
the kernel "support P4", any more than it supports bpftrace and:

$ git grep --files-with-matches bpftrace
Documentation/bpf/redirect.rst
tools/testing/selftests/bpf/progs/test_xdp_attach_fail.c

Filling in tech gaps would also help DPP, IDK how much DPP is based 
or using P4, neither should I have to care, frankly :S

