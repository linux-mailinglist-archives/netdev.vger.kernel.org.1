Return-Path: <netdev+bounces-161435-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E501AA2160A
	for <lists+netdev@lfdr.de>; Wed, 29 Jan 2025 02:23:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D4B8E3A7C2B
	for <lists+netdev@lfdr.de>; Wed, 29 Jan 2025 01:23:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2890454723;
	Wed, 29 Jan 2025 01:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=cs.stanford.edu header.i=@cs.stanford.edu header.b="ljt6tnPp"
X-Original-To: netdev@vger.kernel.org
Received: from smtp1.cs.Stanford.EDU (smtp1.cs.stanford.edu [171.64.64.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FC0225A641
	for <netdev@vger.kernel.org>; Wed, 29 Jan 2025 01:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=171.64.64.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738113824; cv=none; b=aQDxYxHIgLhVzaYByzvt/vS0xecZEV2RFEOWguFj2jO0CDeXl7UQ1e71UHSSDveMnPpfB0axJmdQKqHEZIGaWCkdendvg2HuFRzK/grKPUz0lQP0WrYsTsbKMrdyvaxhKmMxml2VfXUyveUUbqLf6WJH2K5xDmCcN9HjCT0AT3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738113824; c=relaxed/simple;
	bh=fPGxbU6tf/bJc6dGIOKrCUDom6Jev5uMHySXg39PNAE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d+NbYfrTmodllu5gg/N9U8dlCMl+Ckrkg5zoHB9JEaslnKFLoMQk374b2xrxTtR+w1k8GWJXx++CCM/90tfeyR7iUwWqqFH5UHT+s7nYTl4eOZokHcfgrUI/XV3MorfyGynXVaMO5bL5RoGYdgS2JWKerp5/alCKSXv6R4jRjY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.stanford.edu; spf=pass smtp.mailfrom=cs.stanford.edu; dkim=pass (2048-bit key) header.d=cs.stanford.edu header.i=@cs.stanford.edu header.b=ljt6tnPp; arc=none smtp.client-ip=171.64.64.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.stanford.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cs.stanford.edu
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=cs.stanford.edu; s=cs2308; h=Content-Transfer-Encoding:Content-Type:Cc:To:
	Subject:Message-ID:Date:From:In-Reply-To:References:MIME-Version:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=6wbizC0rDTQo2Ne8O8piMPnqKqH+P56+h53XFh3hw+M=; t=1738113822; x=1738977822; 
	b=ljt6tnPptvLCQ/8zLYBWvw0mDh/2g++IAJ3gPynTHlNAXdZ8C99c22DmcKbEaFVLF4E9h3USWHz
	rnh+Hsehf96Nq59KPMtqXFostCqLInvAmxO1SSlMcUULlHUGFSt3CSnClTzFi9wGVQrXztmpkVN6F
	ae+V3Yy0oZWSwFX+GplBXw+mzkNltPyNTOigGMk/GrZkxslJY/6nJ9h5fA4uBvLIC6V/Bu6+l6HVx
	oXJNqJdZM1i/c3XIpEFVqCqr/7Mzr4Tq1f2zaWXqaH3l6reRVJKqkmpYu8gC7yt0GL3WTdvKJ9Ey/
	TUDWRdjoPhfL+xCe1BgiQPMZcJpB+b5K8Kxg==;
Received: from mail-oa1-f51.google.com ([209.85.160.51]:58837)
	by smtp1.cs.Stanford.EDU with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.94.2)
	(envelope-from <ouster@cs.stanford.edu>)
	id 1tcwns-0003qV-Dq
	for netdev@vger.kernel.org; Tue, 28 Jan 2025 17:23:41 -0800
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-29fad34bb62so3232218fac.1
        for <netdev@vger.kernel.org>; Tue, 28 Jan 2025 17:23:40 -0800 (PST)
X-Gm-Message-State: AOJu0YypQmZB/eQfvJChyLlgVR+G1thjUMH5fuzxV3c1b4+mGi+NSADA
	vGi62Y8v6Cfum5qCDP/cKdglgCQ6luZ8C1Wa9X0LMwGXnRgzV8T/20NsqXgLoNaHfUOwvR50AQY
	PCCQFnU/6JM5tUimsQOkFeyG/h5U=
X-Google-Smtp-Source: AGHT+IFzu0HLrA1zg+mD0SLiYJYaPMcWock6ZXac84dk1+2wIKqgbMNzcqguubuTek1tYBDtUNodMZ7Zy1jGV+SKKEE=
X-Received: by 2002:a05:6870:71c6:b0:29d:c764:70e1 with SMTP id
 586e51a60fabf-2b32f095f72mr664291fac.17.1738113819726; Tue, 28 Jan 2025
 17:23:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250115185937.1324-1-ouster@cs.stanford.edu> <20250115185937.1324-6-ouster@cs.stanford.edu>
 <1c82f56c-4353-407b-8897-b8a485606a5f@redhat.com> <CAGXJAmwyp6tSO4KT_NSHKHSnUn-GSzSN=ucfjnBuXbg8uiw2pg@mail.gmail.com>
 <2ace650b-5697-4fc4-91f9-4857fa64feea@redhat.com> <CAGXJAmxHDVhxKb3M0--rySAgewmLpmfJkAeRSBNRgZ=cQonDtg@mail.gmail.com>
 <9209dfbb-ca3a-4fb7-a2fb-0567394f8cda@redhat.com>
In-Reply-To: <9209dfbb-ca3a-4fb7-a2fb-0567394f8cda@redhat.com>
From: John Ousterhout <ouster@cs.stanford.edu>
Date: Tue, 28 Jan 2025 17:23:02 -0800
X-Gmail-Original-Message-ID: <CAGXJAmyb8s5xu9W1dXxhwnQfeY4=P21FquBymonUseM_OpaU2w@mail.gmail.com>
X-Gm-Features: AWEUYZmRO0MxBBnCLyP_-kaa0jfGYKP_TJrQtaQzwvUFxYemzfBHwQ_2VYIid0w
Message-ID: <CAGXJAmyb8s5xu9W1dXxhwnQfeY4=P21FquBymonUseM_OpaU2w@mail.gmail.com>
Subject: Re: [PATCH net-next v6 05/12] net: homa: create homa_rpc.h and homa_rpc.c
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, edumazet@google.com, horms@kernel.org, 
	kuba@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Score: -1.0
X-Spam-Level: 
X-Scan-Signature: 882c50607b8592e4560fe9069cd502a5

On Tue, Jan 28, 2025 at 12:20=E2=80=AFAM Paolo Abeni <pabeni@redhat.com> wr=
ote:
> ...
> > I think that might work, but it would suffer from the slow reclamation
> > problem I mentioned with RCU. It would also create more complexity in
> > the code (e.g. the allocation might still turn out to be redundant, so
> > there would need to be additional code to check for that: the lookup
> > would essentially have to be done twice in the case of creating a new
> > RPC). I'd rather not incur this complexity until there's evidence that
> > GFP_ATOMIC is causing problems.
>
> Have a look at tcp established socket lookup and the
> SLAB_TYPESAFE_BY_RCU flag usage for slab-based allocations. A combo of
> such flag for RPC allocation (using a dedicated kmem_cache) and RCU
> lookup should improve consistently the performances, with a consolidate
> code layout and no unmanageable problems with large number of objects
> waiting for the grace period.

I will check that out.

> >>> Homa needs to handle a very high rate of RPCs, so this would result i=
n
> >>> too much accumulated memory  (in particular, skbs don't get reclaimed
> >>> until the RPC is reclaimed).
> >>
> >> For the RPC struct, that above is a fair point, but why skbs need to b=
e
> >> freed together with the RCP struct? if you have skbs i.e. sitting in a
> >> RX queue, you can flush such queue when the RPC goes out of scope,
> >> without any additional delay.
> >
> > Reclaiming the skbs inline would be too expensive;
>
> Why? For other protocols the main skb free cost is due to memory
> accounting, that homa is currently not implementing, so I don't see why
> it should be critically expansive at this point (note that homa should
> performat least rmem/wmem accounting, but let put this aside for a
> moment). Could you please elaborate on this topic?

In my measurements, skb freeing is by far the largest cost in RPC
reaping. I'm not currently in a good position to remeasure this, but
my recollection is that it takes a few hundred ns to free an skb. A
large RPC (1 MByte is Homa's current limit) will have at least 100
skbs (with jumbo frames) and more than 600 skbs with 1500B frames:
that's 20-100 usec. The problem is that this can occur in a place
where it delays the processing of a packet for an unrelated short
message. Under good conditions, Homa can handle a short RPC in 15 usec
(end-to-end round-trip) so delaying a packet by 100 usec is a severe
penalty.

> [...]
> > Note that the bucket locks would be needed even with RCU usage, in
> > order to permit concurrent RPC creation in different buckets. Thus
> > Homa's locking scheme doesn't introduce additional locks; it
> > eliminates locks that would otherwise be needed on individual RPCs and
> > uses the bucket locks for 2 purposes.
>
> It depends on the relative frequency of RPC lookup vs RPC
> insertion/deletion. i.e. for TCP connections the lookup frequency is
> expected to be significantly higher than the socket creation and
> destruction.
>
> I understand the expected patter in quite different with homa RPC? If so
> you should at least consider a dedicated kmem_cache for such structs.

Right: Homa creates sockets even less often than TCP, but it creates
new RPCs all the time. For an RPC with short messages (very common)
the client will do one insertion and one lookup; the server will do an
insertion but never a lookup. Thus the relative frequency of lookup
vs. insertion is quite different in Homa from TCP. It might well be
worth looking at a kmem_cache for the RPC structs. I don't yet know
much about kmem_caches, but I'll put it on my "to do" list.


-John-

