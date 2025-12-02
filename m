Return-Path: <netdev+bounces-243176-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 12883C9AC07
	for <lists+netdev@lfdr.de>; Tue, 02 Dec 2025 09:49:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id AEF0D34671A
	for <lists+netdev@lfdr.de>; Tue,  2 Dec 2025 08:49:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D5ED191F91;
	Tue,  2 Dec 2025 08:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l17IZ/ub"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E17B36D510;
	Tue,  2 Dec 2025 08:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764665378; cv=none; b=Ps0Q6jO+JgVJSGnfxNBQJdYWB3XI1U4ipIOkrMkph47dU5tY9TQih8mQ+4aNpgdTVcAjlu+hZn7V+rq86XQHmWkoZyPBCEkgDzv1ul/Ie/RhIEy+wgr1ikGiaGL6KV6D5WTfqRzZfWvQyWDoFWE8AybtMTquWEnl2DQoYRJUh2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764665378; c=relaxed/simple;
	bh=m0WUsHtD58BH603ZtsVc3CpSJQ2vsEM4Cb73xi9A+nk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=G7nXmhKlvHiVYi9RhFb/O1kjJMO1K+q+fxtSgaXiSpiEvbYOVmsk1kAFI7ISVA9Bx1VcJJgpzL6HuwNOKSGRPV4hh5DXMAmmONigZwAEeFQv2pUArreQ+/cHwRwbSD7wuRL1zpabytItu7Quy+bUuKcqlhBy57sQjJMBLXAjDrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l17IZ/ub; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85E84C4CEF1;
	Tue,  2 Dec 2025 08:49:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764665377;
	bh=m0WUsHtD58BH603ZtsVc3CpSJQ2vsEM4Cb73xi9A+nk=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=l17IZ/ubWKEtxS/KN3TM2UUURyGirrYqIk6dB+ONoEGYTLLqTtWnjXTj/cYmTzQp6
	 CpxS4w2g/J9C5a6xqgl9qV331JWYoSer2sr8iuWIHbp+xx5k34vmkj7Jhp2zf69E2T
	 QEb9UIOL73A3WKuiF+JDjRpOkNWQQlKe6/yLi3GMGm8yvi8xXRyjxoXplkwPvGCSgh
	 3vwcsmSPVma2vziDKu4qs9N1JPRNIQJ6qYu/jFJwNOIkRgniwO0i9bhz1yCRlKR+UR
	 lZ1Q4JhKhU3zb60axRzGfoWjtTdSNzOp/jhlylDrasi7/dpPmnNjBFjAAkgxSRQNCf
	 oXguOrxnonE4g==
Message-ID: <07a0cd77a61358cfb6e436da60fb5f644201b52c.camel@kernel.org>
Subject: Re: [PATCH v21 15/23] sfc: get endpoint decoder
From: PJ Waskiewicz <ppwaskie@kernel.org>
To: Alejandro Lucero Palau <alucerop@amd.com>,
 alejandro.lucero-palau@amd.com, 	linux-cxl@vger.kernel.org,
 netdev@vger.kernel.org, dan.j.williams@intel.com, 	edward.cree@amd.com,
 davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, 
	edumazet@google.com, dave.jiang@intel.com
Cc: Martin Habets <habetsm.xilinx@gmail.com>, Edward Cree
	 <ecree.xilinx@gmail.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 Ben Cheatham <benjamin.cheatham@amd.com>
Date: Tue, 02 Dec 2025 00:49:36 -0800
In-Reply-To: <ab182638-3693-422b-a7b6-b3630a35a0be@amd.com>
References: <20251119192236.2527305-1-alejandro.lucero-palau@amd.com>
	 <20251119192236.2527305-16-alejandro.lucero-palau@amd.com>
	 <4aab1857efeaf2888b1c85cbac1fc5c8fc5c8cbc.camel@kernel.org>
	 <34f7771f-7d6d-4bfd-9212-889433d80b4c@amd.com>
	 <7f1e56067bdc46195a9e36f914aa103dc76d4f7f.camel@kernel.org>
	 <ab182638-3693-422b-a7b6-b3630a35a0be@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.1 (3.58.1-1.fc43) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Alejandro,

On Thu, 2025-11-27 at 09:08 +0000, Alejandro Lucero Palau wrote:
> >=20
> > TL;DR: if your device you're testing with presents the CXL.mem
> > region
> > as EFI_RESERVED_TYPE, I don't see how these patches are working.
> > Unless you're doing something extra outside of the patches, which
> > isn't
> > obvious to me.
>=20
>=20
> Yes, sorry, that is the case. I'm applying some dirty changes to
> these=20
> patches for testing with my current testing devices, including the
> BIOS=20
> and the Host.
>=20

Well, this is basically the issue.

You are proposing these patches to support Type 2 devices, and use the
X4 with SFC as the vehicle.  But out of the box, following the same
flow, my driver for my (proprietary) device can't match the behavior.=20
If you're having to make modifications to these patches to work with
your device, even if it's to work around a weird platform or BIOS, then
these patches can't be considered as-is.

I have two main platforms in use for development.  One is an Intel
Granite Rapids, one is an AMD Turin.  I've got production SKU's and
CRB's, so I have a cross-section of BIOS's.  All of them behave the
exact same way with these patches.  I do have a BIOS that is doing the
right thing from what I can tell (tracing with a bus analyzer, and also
ILA taps).

CXL Type 2 device support is desparately needed.  I'm happy you've been
championing this to get it merged.  I'm also very committed to helping
test, modify, etc.  So please don't be discouraged.

I'm also one who's dealt with internal pressures from a company to get
something working upstream.  But honestly, upstream work doesn't align
with corporate or company calendars.  Been there, done that, hasn't
gotten easier.  The kernel can't take a patchset that doesn't work at
face value.  It's unfortunately as simple as that.  So let's figure out
how to get it working out of the box with the patches.

>=20
> > >=20
> > > FWIW, last year in Vienna I raised the concern of the kernel
> > > doing
> > > exactly what you are witnessing, and I proposed having a way for
> > > taking
> > > the device/memory from DAX but I was told unanimously that was
> > > not
> > > necessary and if the BIOS did the wrong thing, not fixing that in
> > > the
> > > kernel. In hindsight I would say this conflict was not well
> > > understood
> > > then (me included) with all the details, so maybe it is time to
> > > have
> > > this capacity, maybe from user space or maybe specific kernel
> > > param
> > > triggering the device passing from DAX.
> > I do recall this.=C2=A0 Unfortunately I brought up similar concerns way
> > back
> > in Dublin in 2021 regarding all of this flow well before 2.0-
> > capable
> > hosts arrived.=C2=A0 I think I started asking the questions way too
> > early,
> > since this was of little to no concern at the time (nor was Type2
> > device support).
>=20
>=20
> Maybe we can make the case now. I'll seize LPC to discuss this
> further.=20
> Will you be there?

Yep.  I'll be there, as will Dan.  We definitely need to find some time
and chat.


Cheers,
-PJ

