Return-Path: <netdev+bounces-57082-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C697812121
	for <lists+netdev@lfdr.de>; Wed, 13 Dec 2023 23:01:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 96AE1B20D05
	for <lists+netdev@lfdr.de>; Wed, 13 Dec 2023 22:00:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F6187FBC6;
	Wed, 13 Dec 2023 22:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="ZG2RL06N"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E4AB100;
	Wed, 13 Dec 2023 14:00:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=cJnDldXUMVBXHPmZzYrdgqvYdMUeT9OgJCCFvtyCOEU=; b=ZG2RL06Ny69UkzRtQRCv4x2JZi
	NjHYO7rghvqANL0SpfwjBfRtZi3a9B5fNH4sa+2Hf7p+aOYd6vZPLEm8H2hoMwGNbz8g4ZIZDPnRH
	OYsP2dkgBrI5/xqKaK5K41MY71IanHPsK2/yzYD8uUwHlEb6ZnOK6QSch4sEWLwmKfDs=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rDXHT-002rUq-4l; Wed, 13 Dec 2023 23:00:39 +0100
Date: Wed, 13 Dec 2023 23:00:39 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Justin Chen <justin.chen@broadcom.com>, netdev@vger.kernel.org,
	Doug Berger <opendmb@gmail.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] net: mdio: mdio-bcm-unimac: Delay before first poll
Message-ID: <9c51ecda-4930-4c27-91d6-407efd860aa9@lunn.ch>
References: <20231213000249.2020835-1-justin.chen@broadcom.com>
 <c3cc7a9d-d464-48e7-beb7-b90b1abbcfc7@lunn.ch>
 <ZXnHNTreKY/F2Aqm@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZXnHNTreKY/F2Aqm@shell.armlinux.org.uk>

On Wed, Dec 13, 2023 at 03:01:09PM +0000, Russell King (Oracle) wrote:
> On Wed, Dec 13, 2023 at 11:57:52AM +0100, Andrew Lunn wrote:
> > On Tue, Dec 12, 2023 at 04:02:49PM -0800, Justin Chen wrote:
> > > With a clock interval of 400 nsec and a 64 bit transactions (32 bit
> > > preamble & 16 bit control & 16 bit data), it is reasonable to assume
> > > the mdio transaction will take 25.6 usec. Add a 30 usec delay before
> > > the first poll to reduce the chance of a 1000-2000 usec sleep.
> > 
> > #define  MDIO_C45               0
> > 
> > suggests the hardware can do C45? The timing works out different then.
> > Maybe add a comment by the udelay() that is assumes C22, to give a
> > clue to somebody who is adding C45 support the delay needs to be
> > re-evaluated.
> 
> Note, however, that the driver only supports C22 operations (it only
> populates the read|write functions, not the c45 variants).

Yes, i checked that. Which is why i used the wording 'a clue to
somebody who is adding C45'. Not everybody adding such support would
figure out the relevance of 30us and that it might not be optimal for
C45. A comment might point them on the right line of thinking. That is
all i was trying to say.

    Andrew

     

