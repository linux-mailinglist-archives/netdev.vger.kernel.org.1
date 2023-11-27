Return-Path: <netdev+bounces-51319-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C8FA7FA1CE
	for <lists+netdev@lfdr.de>; Mon, 27 Nov 2023 15:00:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 05BE828177A
	for <lists+netdev@lfdr.de>; Mon, 27 Nov 2023 14:00:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8AAD30FAC;
	Mon, 27 Nov 2023 14:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="XIsJZzvU"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5426E2D70;
	Mon, 27 Nov 2023 05:58:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=rrtNl5JxW/ttJG57sIz5JrgrG9aR/RE+F3iSWIj1zNg=; b=XIsJZzvU+x/0AlHUiHq2J0t3Xj
	ukMVOFYsrG4Nsq7Ur2oP04fe0gsKTMGBiNTkqgny484hFqCS1X1kauNAjafINudfcek9fyMh8PaLV
	RslY9CPMe6uqWHX21z46pFoQ2lb6RN79/EJ+iLkFUchMkydnTlA/FxZ3x9JSDMdcJbKE=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1r7c88-001Lke-8P; Mon, 27 Nov 2023 14:58:32 +0100
Date: Mon, 27 Nov 2023 14:58:32 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: =?iso-8859-1?Q?Ram=F3n_N=2ERodriguez?= <ramon.nordin.rodriguez@ferroamp.se>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] net: microchip_t1s: additional phy support and
 collision detect handling
Message-ID: <d79803b5-60ec-425b-8c5c-3e96ff351e09@lunn.ch>
References: <20231127104045.96722-1-ramon.nordin.rodriguez@ferroamp.se>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231127104045.96722-1-ramon.nordin.rodriguez@ferroamp.se>

> Collision detection
> This has been tested on a setup where one ARM system with a LAN8650
> mac-phy is daisy-chained to 8 mcus using lan8670 phys. Without the patch we
> were limited to really short cables, about 1m per node, but we were
> still getting a lot of connection drops.
> With the patch we could increase the total cable length to at least 40M.

Did you do any testing of collision detection enabled, PLCA disabled?

You say you think this is noise related. But the noise should be the
same with or without PLCA. I'm just thinking maybe collision detection
is just plain broken and should always be disabled?

I've not read much about T1S, but if we assume it is doing good old
fashioned CSMA/CD, with short cables the CS bit works well and the CD
is less important. CD was needed when you have 1000m cable, and you
can fit 64 bytes on the 1000m cable. So always turning of CD might be
appropriate.

	Andrew

