Return-Path: <netdev+bounces-56821-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BC71F810F16
	for <lists+netdev@lfdr.de>; Wed, 13 Dec 2023 11:58:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4E22AB20BD8
	for <lists+netdev@lfdr.de>; Wed, 13 Dec 2023 10:58:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3748822EFB;
	Wed, 13 Dec 2023 10:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="u7wVbB2p"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2ED9112A;
	Wed, 13 Dec 2023 02:58:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=mGIQDTPQtHNZfQHDhzO46ShItOaXBrTUkfxx2nG5SQY=; b=u7wVbB2pV5gntyL4PYXEwy2kdJ
	u/EwwnGsIUcLsYSsvJRCle6GQ8iC3RZSiPxEj9f8pG+3hewpcncW/zHnPcttRW+nebLpb9zUkZ/6S
	5sydG1e30JK1vCa+ujf9NWPiO2Wdou9AWl7gCyzTEOFIWZzawGXVS7KPBK2OrQPper4I=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rDMw4-002oEF-E9; Wed, 13 Dec 2023 11:57:52 +0100
Date: Wed, 13 Dec 2023 11:57:52 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Justin Chen <justin.chen@broadcom.com>
Cc: netdev@vger.kernel.org, Doug Berger <opendmb@gmail.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] net: mdio: mdio-bcm-unimac: Delay before first poll
Message-ID: <c3cc7a9d-d464-48e7-beb7-b90b1abbcfc7@lunn.ch>
References: <20231213000249.2020835-1-justin.chen@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231213000249.2020835-1-justin.chen@broadcom.com>

On Tue, Dec 12, 2023 at 04:02:49PM -0800, Justin Chen wrote:
> With a clock interval of 400 nsec and a 64 bit transactions (32 bit
> preamble & 16 bit control & 16 bit data), it is reasonable to assume
> the mdio transaction will take 25.6 usec. Add a 30 usec delay before
> the first poll to reduce the chance of a 1000-2000 usec sleep.

#define  MDIO_C45               0

suggests the hardware can do C45? The timing works out different then.
Maybe add a comment by the udelay() that is assumes C22, to give a
clue to somebody who is adding C45 support the delay needs to be
re-evaluated.

	Andrew

