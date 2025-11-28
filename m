Return-Path: <netdev+bounces-242542-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 562E3C91D34
	for <lists+netdev@lfdr.de>; Fri, 28 Nov 2025 12:43:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 108D63AD0AF
	for <lists+netdev@lfdr.de>; Fri, 28 Nov 2025 11:43:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68DD930EF83;
	Fri, 28 Nov 2025 11:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="W8R86E/X"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A918A309EF2;
	Fri, 28 Nov 2025 11:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764330207; cv=none; b=KAQFBb2Uk6/olrlbGPyu9P9ANbXAcxe//Sm3Cvbonz+pgoQqKApoXm1/MCXNuakYVBFgFCZdUtLddj2/1iO6c33mtCBrqcceW3g/MZTfErO+MBlnTf7fMa1Q+sxXGm+pMYeQag1nXb7caG91QA964oXYyPT4CtcYZY6O16Iba4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764330207; c=relaxed/simple;
	bh=1keVhUFsBjBizDF5huJTPa3BQY18Ra7CtvvU7Ja25To=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rhTLSQS9fBuM87kA2mYvlFEVkbTJ34J22aG8fc7lI7BzA0zYfIW0Eqy+upBZrSb/s5Uso6JtO7jZyRvt8BpOr+/H08r7aST3btJskNMKiXYe8N/Da6ESUd/G1xJej+PVQhOxPbtYMyzEPDcn2OEmiUsreHlJYhvMwMsxCQwS4WI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=W8R86E/X; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=QrKQlAuZpdU6nIeLYz8+lcXyoiGVchquJU7YxtOarqM=; b=W8R86E/XLkl6l7xOc1zA2CISIY
	SmnV96c8GX29mxkWqOvnTaFtjUcWErz1yWG+rsZ2OXDnROWEd8sr9gaL8Pvp3b7D/m47JwETals5q
	XVco0IS9R2eCe+4vRoG32a+nED73HOtfz3/abN1Pta/DWv1XmhDGcjfmamXeR2geEo8lAdZMEPgCK
	YZAj7g8h86gjLhWluUkZuzIMt0Qtu4d0FJAeAsjnRZdysu0WwTMvxPx+hL+u24GVq8LrjuoZ73HFa
	DwGXQtFeUFNPbLxlLV2bgShH/x9gEs/Bg73QPf/8EK+jvkW2ajfP85ngJ2cMNbGxQqXB1QrgZ61b8
	Mb1wgoCA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:50892)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1vOwsi-000000006HJ-3QNL;
	Fri, 28 Nov 2025 11:43:20 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1vOwsg-000000003cF-0BSM;
	Fri, 28 Nov 2025 11:43:18 +0000
Date: Fri, 28 Nov 2025 11:43:17 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: david laight <david.laight@runbox.com>
Cc: David Yang <mmyangfl@gmail.com>, netdev@vger.kernel.org,
	Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v3 1/4] net: dsa: yt921x: Use *_ULL bitfield
 macros for VLAN_CTRL
Message-ID: <aSmK1T4maiYysTZ0@shell.armlinux.org.uk>
References: <20251126093240.2853294-1-mmyangfl@gmail.com>
 <20251126093240.2853294-2-mmyangfl@gmail.com>
 <20251128105141.50188c6f@pumpkin>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251128105141.50188c6f@pumpkin>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Fri, Nov 28, 2025 at 10:51:41AM +0000, david laight wrote:
> On Wed, 26 Nov 2025 17:32:34 +0800
> David Yang <mmyangfl@gmail.com> wrote:
> 
> > VLAN_CTRL should be treated as a 64-bit register. GENMASK and BIT
> > macros use unsigned long as the underlying type, which will result in a
> > build error on architectures where sizeof(long) == 4.
> 
> I suspect GENMASK() should generate u32 or u64 depending on the value
> of a constant 'high bit'.

I suggest checking before making such statements to save embarrasment.
The above is incorrect.

#define GENMASK_TYPE(t, h, l)                                   \
        ((t)(GENMASK_INPUT_CHECK(h, l) +                        \
             (type_max(t) << (l) &                              \
              type_max(t) >> (BITS_PER_TYPE(t) - 1 - (h)))))

#define GENMASK(h, l)           GENMASK_TYPE(unsigned long, h, l)
#define GENMASK_ULL(h, l)       GENMASK_TYPE(unsigned long long, h, l)

#define GENMASK_U8(h, l)        GENMASK_TYPE(u8, h, l)
#define GENMASK_U16(h, l)       GENMASK_TYPE(u16, h, l)
#define GENMASK_U32(h, l)       GENMASK_TYPE(u32, h, l)
#define GENMASK_U64(h, l)       GENMASK_TYPE(u64, h, l)
#define GENMASK_U128(h, l)      GENMASK_TYPE(u128, h, l)

Note that GENMASK(33, 15) will fail to build on 32-bit systems.

> I found code elsewhere that doesn't really want FIELD_PREP() to
> generate a 64bit value.
> 
> There are actually a lot of dubious uses of 'long' throughout
> the kernel that break on 32bit.
> (Actually pretty much all of them!)

If you're referring to the use of GENMASK() with bitfields larger
than 32-bits, then as can be seen from the above, the code wouldn't
even compile and our CI systems would be screaming about it. They
aren't, so I think your statement here is also wrong.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

