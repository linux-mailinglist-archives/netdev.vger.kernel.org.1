Return-Path: <netdev+bounces-53269-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 924E0801DB7
	for <lists+netdev@lfdr.de>; Sat,  2 Dec 2023 17:28:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B80BD1C20915
	for <lists+netdev@lfdr.de>; Sat,  2 Dec 2023 16:28:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B1221C6A8;
	Sat,  2 Dec 2023 16:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="2thgjsDD"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB046102;
	Sat,  2 Dec 2023 08:28:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=8ciHNODe1XPDwRK+aaMl61d1zRycOP5g608zUMVfPxw=; b=2thgjsDDHgmxMZfWqUFviHaPEK
	n+R1DfQa8qc2fTb2/P/ct6SRk4m0gUInbJ4AyF/msduCPmpGvMSLhmGfUU3VlU8oHZtfLeqQqaYNB
	AecDJKiEpOv84dLDKIKHkv9DawjHv9H8rLIn2t0UfrdL5WY0guaQm91jw67cXr7xbxX4=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1r9SqT-001rE6-RY; Sat, 02 Dec 2023 17:27:57 +0100
Date: Sat, 2 Dec 2023 17:27:57 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Justin Lai <justinlai0215@realtek.com>, davem@davemloft.net,
	edumazet@google.com, pabeni@redhat.com,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	pkshih@realtek.com, larry.chiu@realtek.com
Subject: Re: [PATCH net-next v13 01/13] rtase: Add pci table supported in
 this module
Message-ID: <27b2b87a-929d-4b97-9265-303391982d27@lunn.ch>
References: <20231130114327.1530225-1-justinlai0215@realtek.com>
 <20231130114327.1530225-2-justinlai0215@realtek.com>
 <20231201203602.7e380716@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231201203602.7e380716@kernel.org>

On Fri, Dec 01, 2023 at 08:36:02PM -0800, Jakub Kicinski wrote:
> On Thu, 30 Nov 2023 19:43:15 +0800 Justin Lai wrote:
> > + *  Below is a simplified block diagram of the chip and its relevant interfaces.
> > + *
> > + *               *************************
> > + *               *                       *
> > + *               *  CPU network device   *
> > + *               *                       *
> > + *               *   +-------------+     *
> > + *               *   |  PCIE Host  |     *
> > + *               ***********++************
> > + *                          ||
> > + *                         PCIE
> > + *                          ||
> > + *      ********************++**********************
> > + *      *            | PCIE Endpoint |             *
> > + *      *            +---------------+             *
> > + *      *                | GMAC |                  *
> > + *      *                +--++--+  Realtek         *
> > + *      *                   ||     RTL90xx Series  *
> > + *      *                   ||                     *
> > + *      *     +-------------++----------------+    *
> > + *      *     |           | MAC |             |    *
> > + *      *     |           +-----+             |    *
> > + *      *     |                               |    *
> > + *      *     |     Ethernet Switch Core      |    *
> > + *      *     |                               |    *
> > + *      *     |   +-----+           +-----+   |    *
> > + *      *     |   | MAC |...........| MAC |   |    *
> > + *      *     +---+-----+-----------+-----+---+    *
> > + *      *         | PHY |...........| PHY |        *
> > + *      *         +--++-+           +--++-+        *
> > + *      *************||****************||***********
> > + *
> > + *  The block of the Realtek RTL90xx series is our entire chip architecture,
> > + *  the GMAC is connected to the switch core, and there is no PHY in between.
> > + *  In addition, this driver is mainly used to control GMAC, but does not
> > + *  control the switch core, so it is not the same as DSA.
> 
> Okay, but you seem to only register one netdev.
> 
> Which MAC is it for?

The GMAC one. This is going to be a DSA system, and this driver is for
the conduit MAC the CPU uses. At some point, i hope there is a DSA
driver added, or the existing realtek driver is extended to support
this switch.

       Andrew
 

