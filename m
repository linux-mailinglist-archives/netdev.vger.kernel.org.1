Return-Path: <netdev+bounces-163691-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ECA7A2B5D3
	for <lists+netdev@lfdr.de>; Thu,  6 Feb 2025 23:53:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC16F3A6F52
	for <lists+netdev@lfdr.de>; Thu,  6 Feb 2025 22:52:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EE2123AE70;
	Thu,  6 Feb 2025 22:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="juRHjv2n"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F0B2237713;
	Thu,  6 Feb 2025 22:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738882148; cv=none; b=nvuUPrTB2yjaAcbH7C+BIbOTNBtX+DesF6WyTULyQyYU5qLUC/6nA6QOjqAMQZV9KEwfwk8dSddYIWQehN/9knajOIbjBkDqMVGEZlk8AGiL4gvnH0nEfdfiyQRyfMWLocDq3CFPLNe1N2D3g04sBqqoeP9dBZx7tfEvIh6ezJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738882148; c=relaxed/simple;
	bh=QnQFc5ZW75ig736Zq4+Ro2NikvR2vGrF6BVl9X/+chs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kWqmFl095VlHJFUL7wxYtjkRKWs+2jjGAdGMvq/WsuVux+L2N7OUyxsi533eKctKSf57ReCZYfk3BHNS7fw7iwNtUcB3ema9zJpOHIv2X1rWZwF2Fqv5fjY0WPv2PP2g37DCFRLYyZWxLE7jt+M5igyRXDUE2yLPc+bDsVsMrfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=juRHjv2n; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=XOSx2sfWIkI9mBDKykXkoY9x3FYft266g8j9/dZB04w=; b=juRHjv2n+fKYuD6WHRHIhhjvlh
	Vtjwc9Xzmg7ts41hb/43PvfAfwxPd9MLLH/y29BoqJABpBBgu22W//cuSVwMjd2uxaAP2r23YSybs
	v/04cy12RHHAmaMg3Q9oLy6gSYR1UdA3DKKT5UbSKLYry/46OQfOKlvTLQEujH8VaXTA=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tgAfS-00Bemr-0z; Thu, 06 Feb 2025 23:48:18 +0100
Date: Thu, 6 Feb 2025 23:48:18 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Dave Hansen <dave.hansen@intel.com>
Cc: Choong Yong Liang <yong.liang.choong@linux.intel.com>,
	Simon Horman <horms@kernel.org>, Jose Abreu <joabreu@synopsys.com>,
	Jose Abreu <Jose.Abreu@synopsys.com>,
	David E Box <david.e.box@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H . Peter Anvin" <hpa@zytor.com>,
	Rajneesh Bhardwaj <irenic.rajneesh@gmail.com>,
	David E Box <david.e.box@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jiawen Wu <jiawenwu@trustnetic.com>,
	Mengyuan Lou <mengyuanlou@net-swift.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Hans de Goede <hdegoede@redhat.com>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Serge Semin <fancer.lancer@gmail.com>, x86@kernel.org,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	platform-driver-x86@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH net-next v7 3/7] arch: x86: add IPC mailbox accessor
 function and add SoC register access
Message-ID: <9f6f009d-a2c0-4a6c-b9df-4045f767f8ab@lunn.ch>
References: <20250206131859.2960543-1-yong.liang.choong@linux.intel.com>
 <20250206131859.2960543-4-yong.liang.choong@linux.intel.com>
 <063bd012-d377-4d3d-9dcc-57e360d8f462@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <063bd012-d377-4d3d-9dcc-57e360d8f462@intel.com>

On Thu, Feb 06, 2025 at 08:46:24AM -0800, Dave Hansen wrote:
> On 2/6/25 05:18, Choong Yong Liang wrote:
> > 
> > - Exports intel_pmc_ipc() for host access to the PMC IPC mailbox
> > - Add support to use IPC command allows host to access SoC registers 
> > through PMC firmware that are otherwise inaccessible to the host due
> > to security policies.
> 
> I'm not quite parsing that second bullet as a complete sentence.
> 
> But that sounds scary! Why is the fact that they are "otherwise
> inaccessible" relevant here?

And i wounder what other interesting things can be accessed in this
indirect manor, which the security policy would not otherwise allow.

Somebody is going to have fun here. Or is already have fun here.

	 Andrew

