Return-Path: <netdev+bounces-240929-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 83795C7C25E
	for <lists+netdev@lfdr.de>; Sat, 22 Nov 2025 03:01:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 2B1CA344217
	for <lists+netdev@lfdr.de>; Sat, 22 Nov 2025 02:01:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4A4772617;
	Sat, 22 Nov 2025 02:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Iu8YiCQ0"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B821A59;
	Sat, 22 Nov 2025 02:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763776914; cv=none; b=dwn+Z4kvuBZL/5vAljdrtLGBLpWhOB+XHvvg6tPajFBHbAmKgXXLICq6HeP75oinzm1ytQhR18y+dLr2uRfSz+pTsx1kRaX8fXgPa6LRHO7ZfaQmbYVsbXTYMslTE24cwGJRkl/sS55hx6DrwhIC88qX+NfPIVr7kJ+BJi8WT20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763776914; c=relaxed/simple;
	bh=x8yYmvaX27mwXGxHyXnUFkJlDjath11TjjrcoaUYDRk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qck9IwEfIOqZi7lp5cC3H7xdhxpvnQr0AgnsfDu90vRFW+EMFlqCwPJ/mxdQfNU212xDyMscgHzQI06q/xm9LzgGK+JtIz10xjj5aVQIXIDs/Vfq48RAP0z+imHJ5L7gRE/+ZbHfoeRKlJbRsfvScOBjU4ojgRBKPm+nTc+P6s8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Iu8YiCQ0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A62B8C116D0;
	Sat, 22 Nov 2025 02:01:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763776914;
	bh=x8yYmvaX27mwXGxHyXnUFkJlDjath11TjjrcoaUYDRk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Iu8YiCQ0weDOv6bNLMwqafm4JoxnBQBvWFBC2H6gowm+bKoyAzWWp1fi4SIoh5a8e
	 mKWrMIonXpETU95C3G2zt/I9lFHwzIfhtTYVF5MnfyzIB01PL6WqN/GzSl4t9K6O4E
	 WtB6Dkvg9VizjCsJLe/b760qknJb2QqRM2m2CG9f4gyC+lh5NnULrBiJ6bXBnrSBAD
	 FZZ+ZwkG3FUdY4Q2Kudon5hg5iflCgMxaLoKEw4CD16w3QPHe+LrxuAW3PzQm9BtuK
	 RRXOAJBGqnfBV4rs2B0ePkMjQdqLyb7F1Tt8ee7AWXCvZKfkSiCjZ7sLi1RnsovtvF
	 gTwPyhyp9kZbw==
Date: Fri, 21 Nov 2025 18:01:52 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Jiefeng <jiefeng.z.zhang@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, pabeni@redhat.com,
 andrew+netdev@lunn.ch, edumazet@google.com, linux-kernel@vger.kernel.org,
 irusskikh@marvell.com
Subject: Re: [PATCH net] net: atlantic: fix fragment overflow handling in RX
 path
Message-ID: <20251121180152.562f3361@kernel.org>
In-Reply-To: <CADEc0q53dNkcfk+0ZKMRrqX99OfB-KonrZ8eO2r1EC-KLkfXgA@mail.gmail.com>
References: <20251118070402.56150-1-jiefeng.z.zhang@gmail.com>
	<20251118122430.65cc5738@kernel.org>
	<CADEc0q4sEACJY03CYxOWPPvPrB=n7==2KqHz57AY+CR6gSJjAw@mail.gmail.com>
	<20251119190333.398954bf@kernel.org>
	<CADEc0q5unWeMYznB_gJEUSRTy1HyCZO_8aNHhVpKPy9k0-j8Qg@mail.gmail.com>
	<CADEc0q53dNkcfk+0ZKMRrqX99OfB-KonrZ8eO2r1EC-KLkfXgA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 22 Nov 2025 09:36:29 +0800 Jiefeng wrote:
> > Thank you for the feedback! I've updated the patch to v2 based on your
> > suggestion to skip extracting the zeroth fragment when frag_cnt ==
> > MAX_SKB_FRAGS.
> > This approach is simpler and aligns with your comment that extracting the
> > zeroth fragment is just a performance optimization, not necessary for
> > correctness.
> >
> > I've also included the stack trace from production (without timestamps) in
> > the commit message:
> >
> > The fix adds a check to skip extracting the zeroth fragment when
> > frag_cnt == MAX_SKB_FRAGS, preventing the fragment overflow.
> >
> > Please review the v2 patch.  
> 
> Hi, I've reconsidered the two approaches and I
> think fixing the existing check (assuming there will be an extra frag if
> buff->len > AQ_CFG_RX_HDR_SIZE) makes more sense. This approach:
> 
> 1. Prevents the overflow earlier in the code path
> 2. Ensures data completeness (all fragments are accounted for)
> 3. Avoids potential data loss from skipping the zeroth fragment
> 
> If you agree, I'll submit a v3 patch based on this approach. The fix
> will modify the existing check to include the potential zeroth
> fragment in the fragment count calculation.
> 
> Please let me know if this approach is acceptable.

Right, v2 is not correct. You'd need to calculate hdr_len earlier,
already taking into account whether there is space for the zeroth
frag. And if not - you can just allocate napi_alloc_skb() with enough
space, and copy the full buf. This would avoid the data loss.

