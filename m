Return-Path: <netdev+bounces-185213-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 461C0A99519
	for <lists+netdev@lfdr.de>; Wed, 23 Apr 2025 18:29:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C2EBD5A8191
	for <lists+netdev@lfdr.de>; Wed, 23 Apr 2025 16:16:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0FC62798E9;
	Wed, 23 Apr 2025 16:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rXjqOXtb"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A94E97081C;
	Wed, 23 Apr 2025 16:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745424973; cv=none; b=hZ2say73wx/7fYEWj88pPIrTi3645vz52A3vevsp92nS9aWxa7hSHHZwxgQEJAWMexSTE8JKT/RdrKyKnSB0R56DYhEnSkjZscJbdV9Nkw9Uy0dmnTcF3oWOuhX7Y+y9A3jMdAAIa54yO2DD5UEwIvx8p18Sd6TYkqpy+0KmZEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745424973; c=relaxed/simple;
	bh=nfwTXpjDniJet8uRyJolK5Eq9zCVpA6j7omF0J8cUG8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OR3w1jMYIoFs5fEBnkE2PHUQBpKX/XNn/ota0CPBXy5AeRUZZBfSKLcLpfoBaU48i2OaXy9D+wnzYQOsRxc5PTFWhXMcIMBnjMYEXiP617cHd0E85f4MgJK3uEvGA1An9iwJPXq+pvbCoLaIVGjg+4bZHhYBBMwQ75DEzea4B2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rXjqOXtb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1ED7C4CEE2;
	Wed, 23 Apr 2025 16:16:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745424973;
	bh=nfwTXpjDniJet8uRyJolK5Eq9zCVpA6j7omF0J8cUG8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rXjqOXtbX0/7dQRCbYS2KUqZR5ipICV1dayWh3Qy0iTw8GnBa8YiVvKvTIRyyjsCg
	 iCayn/B4TjY44D74JfVPc4Mxoub8FBAXru6EYVDvgQReO1JwsaEZZWW3DpwRJsOUKx
	 blEufBkOLsu4EnXwdcb1L94Ar0NWMpox6M8FzNZn8fyyU4g83URhq/Z1OWO3TEX7cW
	 m/I1pq8BkyA9yPoAyPQmpt26l3Yo7Ex2DKEV5HDWHNzMALy5rVnZmUUmxQpBywRc3r
	 Fnk2fruUR0ONftOfn149sWIeNoh2NNyWTS+pwbyaAzvD5RzzrX3VI8gZiFZJzenAF1
	 GLh4a9VXxr7dw==
Date: Wed, 23 Apr 2025 17:16:08 +0100
From: Simon Horman <horms@kernel.org>
To: Justin Lai <justinlai0215@realtek.com>
Cc: "kuba@kernel.org" <kuba@kernel.org>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	Ping-Ke Shih <pkshih@realtek.com>,
	Larry Chiu <larry.chiu@realtek.com>, Andrew Lunn <andrew@lunn.ch>,
	David Laight <david.laight.linux@gmail.com>
Subject: Re: [PATCH net v3 3/3] rtase: Fix a type error in min_t
Message-ID: <20250423161608.GB2843373@horms.kernel.org>
References: <20250417085659.5740-1-justinlai0215@realtek.com>
 <20250417085659.5740-4-justinlai0215@realtek.com>
 <20250422132831.GH2843373@horms.kernel.org>
 <040b019af779423f96752f10a697195b@realtek.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <040b019af779423f96752f10a697195b@realtek.com>

On Wed, Apr 23, 2025 at 10:53:53AM +0000, Justin Lai wrote:
> > 
> > + David Laight
> > 
> > On Thu, Apr 17, 2025 at 04:56:59PM +0800, Justin Lai wrote:
> > > Fix a type error in min_t.
> > >
> > > Fixes: a36e9f5cfe9e ("rtase: Add support for a pci table in this
> > > module")
> > > Signed-off-by: Justin Lai <justinlai0215@realtek.com>
> > > Reviewed-by: Andrew Lunn <andrew@lunn.ch>
> > > ---
> > >  drivers/net/ethernet/realtek/rtase/rtase_main.c | 4 ++--
> > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/drivers/net/ethernet/realtek/rtase/rtase_main.c
> > > b/drivers/net/ethernet/realtek/rtase/rtase_main.c
> > > index 55b8d3666153..bc856fb3d6f3 100644
> > > --- a/drivers/net/ethernet/realtek/rtase/rtase_main.c
> > > +++ b/drivers/net/ethernet/realtek/rtase/rtase_main.c
> > > @@ -1923,7 +1923,7 @@ static u16 rtase_calc_time_mitigation(u32
> > time_us)
> > >       u8 msb, time_count, time_unit;
> > >       u16 int_miti;
> > >
> > > -     time_us = min_t(int, time_us, RTASE_MITI_MAX_TIME);
> > > +     time_us = min_t(u32, time_us, RTASE_MITI_MAX_TIME);
> > 
> > Hi Justin, Andrew, David, all,
> > 
> > I may be on the wrong track here, but near the top of minmax.h I see:
> > 
> > /*
> >  * min()/max()/clamp() macros must accomplish several things:
> >  *
> >  * - Avoid multiple evaluations of the arguments (so side-effects like
> >  *   "x++" happen only once) when non-constant.
> >  * - Perform signed v unsigned type-checking (to generate compile
> >  *   errors instead of nasty runtime surprises).
> >  * - Unsigned char/short are always promoted to signed int and can be
> >  *   compared against signed or unsigned arguments.
> >  * - Unsigned arguments can be compared against non-negative signed
> > constants.
> >  * - Comparison of a signed argument against an unsigned constant fails
> >  *   even if the constant is below __INT_MAX__ and could be cast to int.
> >  */
> > 
> > So, considering the 2nd last point, I think we can simply use min() both above
> > and below. Which would avoid the possibility of casting to the wrong type again
> > in future.
> > 
> > Also, aside from which call is correct. Please add some colour to the commit
> > message describing why this is a bug if it is to be treated as a fix for net rather
> > than a clean-up for net-next.
> > 
> > >
> > >       if (time_us > RTASE_MITI_TIME_COUNT_MASK) {
> > >               msb = fls(time_us);
> > > @@ -1945,7 +1945,7 @@ static u16 rtase_calc_packet_num_mitigation(u16
> > pkt_num)
> > >       u8 msb, pkt_num_count, pkt_num_unit;
> > >       u16 int_miti;
> > >
> > > -     pkt_num = min_t(int, pkt_num, RTASE_MITI_MAX_PKT_NUM);
> > > +     pkt_num = min_t(u16, pkt_num, RTASE_MITI_MAX_PKT_NUM);
> > >
> > >       if (pkt_num > 60) {
> > >               pkt_num_unit = RTASE_MITI_MAX_PKT_NUM_IDX;
> > > --
> > > 2.34.1
> > >
> 
> Hi Simon,
> 
> According to a more detailed clarification, this part is actually an
> enhancement and does not cause any issues during operation, so it is
> not a real bug. Therefore, I will post this patch in net-next.

Thanks. Please do consider using min() instead of min_t() when you post the
patch to net-next.

