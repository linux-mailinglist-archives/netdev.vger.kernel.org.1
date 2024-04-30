Return-Path: <netdev+bounces-92397-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EE41F8B6E5F
	for <lists+netdev@lfdr.de>; Tue, 30 Apr 2024 11:30:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2ADE11C20342
	for <lists+netdev@lfdr.de>; Tue, 30 Apr 2024 09:30:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 728BF13D275;
	Tue, 30 Apr 2024 09:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kpnmail.nl header.i=@kpnmail.nl header.b="Asd25Pf5"
X-Original-To: netdev@vger.kernel.org
Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A61F127B5F
	for <netdev@vger.kernel.org>; Tue, 30 Apr 2024 09:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714469357; cv=none; b=edAqiV4LsfAKpzrLwr3goI2lKvifQf3u27aPXAetDCMVWC8IIMTFSJzWnp23/DV+4LJjewSj7gTiFrzQ7wguWvz0aBAbCcvXwq9LgR6n6cgBcfr0tOK9fSiOfvifaVBCT3o7GN9p7SkJDxwP5YWXCxziJGGx4v1Mfd7tcFid1BI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714469357; c=relaxed/simple;
	bh=nwQd1P4tHzaCRQ2y+46bHId+TC6Wd5mIsi2Yxig4ByE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AXKAXIAn7Gz1oXeXNvj+QgTLxLYlqf6t0quW6+4Q9SgUrOL+PQCeO14YBiy/kBmoAEHet9OVHR3eKc2KfljEpiOsVwt53Z2fgYRCurwDYDsnL8J5JUI+rf5HCL8hQDcvvPMF7gOhYPyQupRvTabATm98UtSpnB9F+V1rZ9PNrIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phenome.org; spf=none smtp.mailfrom=phenome.org; dkim=pass (1024-bit key) header.d=kpnmail.nl header.i=@kpnmail.nl header.b=Asd25Pf5; arc=none smtp.client-ip=195.121.94.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phenome.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=phenome.org
X-KPN-MessageId: 190f716b-06d4-11ef-836c-005056aba152
Received: from smtp.kpnmail.nl (unknown [10.31.155.37])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 190f716b-06d4-11ef-836c-005056aba152;
	Tue, 30 Apr 2024 11:29:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=kpnmail.nl; s=kpnmail01;
	h=content-type:mime-version:message-id:subject:to:from:date;
	bh=WGq3JwuNuzPQ1Rn3yqo44mCMjveSCbWPpWRNxnhftHU=;
	b=Asd25Pf5CP2orso1/GFKoCFuJV5ORcVBrSf9moRBvI7x5CULfkI+UUKgMFbbFqRX+BYYkKSGNSNya
	 dLvkJSuhaf39Im6wLRI66BxnExPKSfxPOO9N6axo2f5BPbFB6bZdiJ/NSMxXFBVZGeCsagwhuU5DG1
	 UCLK9Ou8tYS2V76g=
X-KPN-MID: 33|F9MidrO6Z5LTG675EAcaswBYJ7zhuX1ki56iy3n0pbqBLGdcsgjx1koPvIHLcO5
 wgxInEtD/Q7GylOhaGrf7Vo+YtLosomLTZkPOla2RUCA=
X-KPN-VerifiedSender: No
X-CMASSUN: 33|shbSJQ+ROo8angdZEi2HbpTK4+arKjgm6AZW1/xPJAoitR8Q/rQB6p+BzFWPDgJ
 HVOD09u39pB4xyg6lOgA22Q==
Received: from Antony2201.local (213-10-186-43.fixed.kpn.net [213.10.186.43])
	by smtp.xs4all.nl (Halon) with ESMTPSA
	id 19bf5d2f-06d4-11ef-a212-005056ab1411;
	Tue, 30 Apr 2024 11:29:11 +0200 (CEST)
Date: Tue, 30 Apr 2024 11:29:10 +0200
From: Antony Antony <antony@phenome.org>
To: Steffen Klassert <steffen.klassert@secunet.com>
Cc: Sabrina Dubroca <sd@queasysnail.net>,
	Antony Antony <antony.antony@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>, netdev@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	devel@linux-ipsec.org, Leon Romanovsky <leon@kernel.org>,
	Eyal Birger <eyal.birger@gmail.com>,
	Nicolas Dichtel <nicolas.dichtel@6wind.com>
Subject: Re: [PATCH ipsec-next v13 1/4] xfrm: Add Direction to the SA in or
 out
Message-ID: <ZjC55h1VR_E1Vi53@Antony2201.local>
References: <cover.1714118266.git.antony.antony@secunet.com>
 <21d941a355a4d7655bb8647ba3db145b83969a6f.1714118266.git.antony.antony@secunet.com>
 <Zi-OdMloMyZ-BynF@hog>
 <ZjCMxwhiIvAbqvxy@gauss3.secunet.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZjCMxwhiIvAbqvxy@gauss3.secunet.de>

On Tue, Apr 30, 2024 at 08:16:39AM +0200, Steffen Klassert via Devel wrote:
> On Mon, Apr 29, 2024 at 02:11:32PM +0200, Sabrina Dubroca wrote:
> > 2024-04-26, 10:05:06 +0200, Antony Antony wrote:
> > 
> > Sorry I didn't check all the remaining flags until now.
> > 
> > 
> > Apart from that, the series looks good now, so I can also ack it and
> > add those two extra flags as a follow-up patch. Steffen/Antony, let me
> > know what you prefer.
> 
> It would be nice if we could merge the patchset without known
> issues. OTOH this might be the last chance to get in in during
> this release cycle.
> 
> Antony, can you provide an update today?

yes. I just sent v14 with verification for the flags Sabrina proposed.

It would be be great to get this patch in this cycle.

