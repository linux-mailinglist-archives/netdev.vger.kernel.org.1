Return-Path: <netdev+bounces-123121-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D441963B82
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 08:28:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3CF141F24FD2
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 06:28:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2293B1547D5;
	Thu, 29 Aug 2024 06:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b="yKEVa7u+"
X-Original-To: netdev@vger.kernel.org
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99575152165;
	Thu, 29 Aug 2024 06:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.160.73.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724912861; cv=none; b=rMb55bqfDMSe/o2x6Pfz+pDnxMJMQs5pY6F6YLoI65eqPkdxjXykeX7nGLVLkqvurBCoiZDlofROGhJJ8RuOXtlzqpScDcSIY+uAoDqfOtcR6HW7BnYV+yg+H6MFY+0jl3HvNX6PTt+TfoigkHhw3JfjPQGPEIFcU7r5T23ZDaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724912861; c=relaxed/simple;
	bh=j4hkk4D1grsXQRQs5w6Q7xKzebFR0yWWiUJtJpfe1K8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PtADED9TpTk+jXz7jfYHCzXyd2iK7hXmDHxnKAlddz+BJKpo5uQa3RDEEWnuw9/yagoCP5YvYcTrT+7ulpNgDz2R4Gx7BCWf/ErufnBrS/C4gWvGyBIuUn3gS1VNfmHecZMwznWEuG5/BPNNK7pEgejsNVZLjW8ZsXqT81V+3oM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org; spf=pass smtp.mailfrom=narfation.org; dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b=yKEVa7u+; arc=none smtp.client-ip=213.160.73.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=narfation.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1724912850;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=D77BSHaUFViLdDM7kfQVR6bNScj//7o43h1CahEFyCk=;
	b=yKEVa7u+YKRRiHQAM6lxvripiGVk3vjqz7lKBIVeKZNBe5iv6XAn73xLXiyE6+IMuf0S9F
	xEF+e9RPJQ6BPqy8eucpuPqKP4GS4j+eFDFsB1kENlay/dsePZfFulgtkYuv+shEqW3u4S
	rVZ1r/tbEATLDm41Ajlx3cKtoxak0Ao=
From: Sven Eckelmann <sven@narfation.org>
To: Xingyu Li <xli399@ucr.edu>
Cc: mareklindner@neomailbox.ch, sw@simonwunderlich.de, a@unstable.cc,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 b.a.t.m.a.n@lists.open-mesh.org, Yu Hao <yhao016@ucr.edu>
Subject: Re: BUG: general protection fault in batadv_bla_del_backbone_claims
Date: Thu, 29 Aug 2024 08:27:20 +0200
Message-ID: <2212852.CQOukoFCf9@sven-l14>
In-Reply-To:
 <CALAgD-7AOA0At+y0BR2MZ0WXPFM03tQneRbeGZQqiKy6=1T0rw@mail.gmail.com>
References:
 <CALAgD-7C3t=vRTvpnVvsZ_1YhgiiynDaX_ud0O6pxSBn3suADQ@mail.gmail.com>
 <13617673.uLZWGnKmhe@bentobox>
 <CALAgD-7AOA0At+y0BR2MZ0WXPFM03tQneRbeGZQqiKy6=1T0rw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart23944202.6Emhk5qWAg";
 micalg="pgp-sha512"; protocol="application/pgp-signature"

--nextPart23944202.6Emhk5qWAg
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"; protected-headers="v1"
From: Sven Eckelmann <sven@narfation.org>
To: Xingyu Li <xli399@ucr.edu>
Date: Thu, 29 Aug 2024 08:27:20 +0200
Message-ID: <2212852.CQOukoFCf9@sven-l14>
MIME-Version: 1.0

On Thursday, 29 August 2024 06:30:23 CEST Xingyu Li wrote:
> > Which line would that be in your build?
> 
> Somehow, the bug report does not include the line number in my end.

You can try to use gdb or similar tools to figure out more about it [1]. Maybe 
even adjust your kernel build to create better debuggable crashes

> 
> At the moment, I am unable to reproduce this crash with the provided
> reproducer.

Since I am missing information and you don't have a working reproducer - how 
should I then fix anything? Your comment from the first doesn't seem to apply 
and it is unclear how you came to the conclusion in the first place.

> > Can you reproduce it with it?
> 
> Sorry. The above syzkaller reproducer needs the additional support  to run it.
> But here is a C reproducer:
> https://gist.github.com/freexxxyyy/0be5002c45d7f060cb599dd7595cab78

I've tried to run it with the normal syz-execprog - but you seem to say now 
that this reproducer is not working the upstream one? In this case, please try 
to get it working with upstream. See also the mail from Kees Cook [2].

Kind regards,
	Sven

[1] https://www.open-mesh.org/projects/devtools/wiki/Crashlog_with_pstore#Decoding-the-stack-trace
[2] https://lore.kernel.org/r/202408281812.3F765DF@keescook
--nextPart23944202.6Emhk5qWAg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQS81G/PswftH/OW8cVND3cr0xT1ywUCZtAUyQAKCRBND3cr0xT1
yxDRAP0Xgpu7aT8LpohRYfvgXf8o+GrJZqVeEyS+5DchULBSkAD/UrteyweAjX2D
BFSV2WqmyRJuWVxsbsxYCo2hixPZhgM=
=D8Cf
-----END PGP SIGNATURE-----

--nextPart23944202.6Emhk5qWAg--




