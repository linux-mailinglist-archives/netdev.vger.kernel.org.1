Return-Path: <netdev+bounces-219929-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 430DFB43B5D
	for <lists+netdev@lfdr.de>; Thu,  4 Sep 2025 14:20:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 107775862EF
	for <lists+netdev@lfdr.de>; Thu,  4 Sep 2025 12:20:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C12262D24A4;
	Thu,  4 Sep 2025 12:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="aOwi/4Hr"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8410B2C11D0;
	Thu,  4 Sep 2025 12:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756988410; cv=none; b=ahk0KG64CtMTYCY7we1n+lhEg3VSE2yDiFYp3rHGD2DgNnZMuFD7TVQEPoOtrjPq9HIUkPah3SECCZNrb387NhAsKqM+2fyJJW7eUhscyWd6rtb86gEHQqqzFQAyMn9CawlDGG9hqG+4pV5SMfhlc0Qsie1ZhonMMMhdnf5j+to=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756988410; c=relaxed/simple;
	bh=3GXl5luhhTUKYF9aCd1U+wf3T4mx4Hai3Gkyv64J46U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Yhn7Piv6BqR4ldTRiijxaTZ9Fy4J+A+Sa2kIlM1ojMF5uC9s1IbB69+WBlpAXh5gi4VGml9JDK1fa8H3XSnRlttwWFuF7bf9WZHGoysNEWMiF2KEDo7dM9kSIkAcBUYrLy1UMfaOL9DDXsAMKTRXATO4UX1Izxw5VqTl2Uh8wtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=aOwi/4Hr; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=xueju8pyrzkvbfou/fOy1T9cTy0Q9nwZfUtGrgUnzqQ=; b=aOwi/4HrGn3ydT4BNPqiXoH3c3
	hdc/p1UskF2YdgVlnXEStcTFTk7ufHBprnPSEYE/BZUyprLfv3S9Yvr8Lpdk3+LCexA13Pu4LQjEY
	+HXBD8HCiZjBnxPAQpwDCOHpdjxxztt4CKIkgv+o6JKluVa1FHr5ktXy5n9ZpVzm52PU=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uu8wf-007Cys-GX; Thu, 04 Sep 2025 14:20:05 +0200
Date: Thu, 4 Sep 2025 14:20:05 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Jack Ping Chng <jchng@maxlinear.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
	"edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"robh@kernel.org" <robh@kernel.org>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>,
	Yi xin Zhu <yzhu@maxlinear.com>,
	Suresh Nagaraj <sureshnagaraj@maxlinear.com>
Subject: Re: [PATCH net-next v3 2/2] net: maxlinear: Add support for MxL LGM
 SoC
Message-ID: <e4423dd3-79f0-4c5a-a14e-cb62cc6dce18@lunn.ch>
References: <20250829124843.881786-1-jchng@maxlinear.com>
 <20250829124843.881786-3-jchng@maxlinear.com>
 <65771930-d023-49e1-87a7-e8c231e20014@lunn.ch>
 <PH7PR19MB56360AF7B6FCB1AAD0B27120B407A@PH7PR19MB5636.namprd19.prod.outlook.com>
 <398ad4b1-1bd3-4adc-8bda-5cc8f1b99716@lunn.ch>
 <PH7PR19MB56366632D5609B0B51FE8939B406A@PH7PR19MB5636.namprd19.prod.outlook.com>
 <8fa4504e-e486-41d0-9140-b24187626850@lunn.ch>
 <PH7PR19MB563690779EFD1FEB867A81BEB400A@PH7PR19MB5636.namprd19.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PH7PR19MB563690779EFD1FEB867A81BEB400A@PH7PR19MB5636.namprd19.prod.outlook.com>

> To clarify, this driver does not implement any switch functionality.

So you have all this nice hardware to accelerate L2, L3, etc, but you
are not going to use it? Linux will always ignore it and do it all in
software?

Somehow, i don't think this is true. At some point, you will want to
make use of that hardware. And Linux has very specific ways to do
that. You need to be looking forward to the time you start to use this
hardware, because if you get it wrong now, you will end up throwing
this driver away and starting again. I've seen it happen.

> Its purpose is limited to controlling individual MACs, without support
> for bridging, VLANs, or other switch-related features.
> All packet forwarding and routing will be handled entirely by the Linux
> networking stack.
> Also, we have separate Tx/Rx channels mapped to the interfaces we are
> registering. We also have a separate packet processor engine for
> bridging and routing based on the sessions.

So this sounds like a pure switchdev driver, although DSA could still
be used. So, look forward, spend some time looking at other drivers
which implement the swichdev API, look at the mediatek drivers which
do acceleration of NAT, and make sure your architecture is correct.

	Andrew

