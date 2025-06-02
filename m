Return-Path: <netdev+bounces-194630-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C379ACB966
	for <lists+netdev@lfdr.de>; Mon,  2 Jun 2025 18:19:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8714C3B2918
	for <lists+netdev@lfdr.de>; Mon,  2 Jun 2025 16:18:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8FB72236F2;
	Mon,  2 Jun 2025 16:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="UTsq0rdA"
X-Original-To: netdev@vger.kernel.org
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA854EAF9
	for <netdev@vger.kernel.org>; Mon,  2 Jun 2025 16:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748881142; cv=none; b=oJE4mGzotarlLRugxhcNa/4dubeqHEowo5n4L+L1DdLud9XQHU9azrzNOM1pgvkOPyoLJWi+JDNYH5MhUIpnKym0MBO34DTW2mht1N8RJnGVE2ZoQue9e6BM3nkEqUU9KBe1m9KFMO2BzrVocT/McTnTMpnEwcgQMqr1DE5xDUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748881142; c=relaxed/simple;
	bh=FeHAqOZWp8WEa/07OySmkjrc1AGvp6/LlQs1Kynu+B8=;
	h=Mime-Version:Subject:From:To:CC:In-Reply-To:Message-ID:Date:
	 Content-Type:References; b=XTH+x9v/s0CoyJwBAFz5cn6F3sxOXibmSdorkfy+5WO1aRgSzZHxNV8efoY9Obu8x6eWyAnfkK1IlH4RrbxjDATD/KYNaPojRMfqb/OK8iGWu1mDAKJS2/TkDSvZpNAIur0SFPctlaSq4TqqFO2GIYHZg6+/pLdnxk7g94JzqKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=partner.samsung.com; spf=pass smtp.mailfrom=partner.samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=UTsq0rdA; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=partner.samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=partner.samsung.com
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20250602161858euoutp023939e63fc641661eccfbc8528729aa13~FRiELUwRq1205312053euoutp02X
	for <netdev@vger.kernel.org>; Mon,  2 Jun 2025 16:18:58 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20250602161858euoutp023939e63fc641661eccfbc8528729aa13~FRiELUwRq1205312053euoutp02X
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1748881138;
	bh=FeHAqOZWp8WEa/07OySmkjrc1AGvp6/LlQs1Kynu+B8=;
	h=Subject:Reply-To:From:To:CC:In-Reply-To:Date:References:From;
	b=UTsq0rdAjDyx88wAjUEZgSx/kLJsl0Z7g70So2OmYbNcGvFEXV6uMEDkEKNlA6d0O
	 N0ri/Sxm0MgiIcjnbstwg9upbwZf9UUJLLSw2D0TOhnBZT0HzlyEDngymlZL6sJb2j
	 +kISpyPlA7CBwT9/OoB9UGey+F52VVbus8/ii5eg=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Subject: RE: Re: Re: [PATCH bpf v2] xsk: Fix out of order segment free in
 __xsk_generic_xmit()
Reply-To: e.kubanski@partner.samsung.com
Sender: Eryk Kubanski <e.kubanski@partner.samsung.com>
From: Eryk Kubanski <e.kubanski@partner.samsung.com>
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>, Stanislav Fomichev
	<stfomichev@gmail.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"bjorn@kernel.org" <bjorn@kernel.org>, "magnus.karlsson@intel.com"
	<magnus.karlsson@intel.com>, "jonathan.lemon@gmail.com"
	<jonathan.lemon@gmail.com>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <aD3LNcG0qHHwPbiw@boxer>
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20250602161857eucms1p2fb159a3058fd7bf2b668282529226830@eucms1p2>
Date: Mon, 02 Jun 2025 18:18:57 +0200
X-CMS-MailID: 20250602161857eucms1p2fb159a3058fd7bf2b668282529226830
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20250530103506eucas1p1e4091678f4157b928ddfa6f6534a0009
X-EPHeader: Mail
X-ConfirmMail: N,general
X-CMS-RootMailID: 20250530103506eucas1p1e4091678f4157b928ddfa6f6534a0009
References: <aD3LNcG0qHHwPbiw@boxer> <aDnX3FVPZ3AIZDGg@mini-arch>
	<20250530103456.53564-1-e.kubanski@partner.samsung.com>
	<20250602092754eucms1p1b99e467d1483531491c5b43b23495e14@eucms1p1>
	<aD3DM4elo_Xt82LE@mini-arch>
	<CGME20250530103506eucas1p1e4091678f4157b928ddfa6f6534a0009@eucms1p2>

> Eryk, can you tell us a bit more about HW you're using? The problem you
> described simply can not happen for HW with in-order completions. You
> can't complete descriptor from slot 5 without going through completion of
> slot 3. So our assumption is you're using HW with out-of-order
> completions, correct?

Maciej this isn't reproduced on any hardware.
I found this bug while working on generic AF_XDP.

We're using MACVLAN deployment where, two or more
sockets share single MACVLAN device queue.
It doesn't even need to go out of host...

SKB doesn't even need to complete in this case
to observe this bug. It's enough if earlier writer
just fails after descriptor write. This case is
writen in my diagram Notes 5).

Are you sure that __dev_direct_xmit will keep
the packets on the same thread? What's about
NAPI, XPS, IRQs, etc?

If sendmsg() is issued by two threads, you don't
know which one will complete faster. You can still
have out-of-order completion in relation to
descrpitor CQ write.

This isn't problem with out-of-order HW completion,
but the problem with out-of-order completion in relation
to sendmsg() call and descriptor write.

But this doesn't even need to be sent, as I
explained above, situation where one of threads
fails is more than enough to catch that bug.

> If that is the case then we have to think about possible solutions which
> probably won't be straight-forward. As Stan said current fix is a no-go.

Okay what is your idea? In my opinion the only
thing I can do is to just push the descriptors
before or after __dev_direct_xmit() and keep
these descriptors in some stack array.
However this won't be compatible with behaviour
of DRV deployed AF_XDP. Descriptors will be returned
right after copy to SKB instead of after SKB is sent.
If this is fine for you, It's fine for me.

Otherwise this need to be tied to SKB lifetime,
but how?

