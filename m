Return-Path: <netdev+bounces-84199-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ADC53896040
	for <lists+netdev@lfdr.de>; Wed,  3 Apr 2024 01:37:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 69D2C286B06
	for <lists+netdev@lfdr.de>; Tue,  2 Apr 2024 23:37:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19ADD5026B;
	Tue,  2 Apr 2024 23:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="MGAuIqam"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 247313E487;
	Tue,  2 Apr 2024 23:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712101057; cv=none; b=m+eOPt02N3M8Qgn8pgwY4cF3KAFm4dfo9bG67hMeUT0lUQTmg85f2A0E0qgweR5CvYati/YaFz5nyKBTe1DBiF5kCnVlBxoHjExYpWsHVIjVUeZKUXGi1o9yLVJEADlpFBKfjfhii7KwsjndUullL3y4xnQgnwfm0esgvoFzj2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712101057; c=relaxed/simple;
	bh=+ODrOgaH+i3zGrDGCN9VqXnzlahNw8ThMoXJDbGJEHk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SLdE1Os/5dMt1PeBqFMLI2SNg8la4SLkZasRfWQZr+Zc51/7VhkuORhsgF99Q+bxyBWoPvHUNxVTv1exiVN54392EOFrjtHTvoEi0BuFimXTRJ1YK1hBjEC2fS7GrplwwH6qAU+7nIcnY8FJpdNrT0Edj2mdM/3C7j2bL2cxgI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=MGAuIqam; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=czqakSuEwNxUKTTR2ylWGLpQOSR/+zx9zGf/y+PgSNM=; b=MGAuIqamqxv4U5Isqea8yjDp1c
	UPR9t9sx3/b6eE7edPol/vtifmZ4P2iL6g26IOkYIEjy8ZrcWJxhQ3ye85Lq5v8drGewYb7ZGlwAw
	ljIvddpHksjAQbYytCuvQHFITFSJFSKy0OBY8dRN7ZyjxmpuoMZhaGpiIh50Mq2QYO1U=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rrnh1-00Bztx-0H; Wed, 03 Apr 2024 01:37:27 +0200
Date: Wed, 3 Apr 2024 01:37:26 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Pawel Dembicki <paweldembicki@gmail.com>
Cc: netdev@vger.kernel.org, Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Dimitri Fedrau <dima.fedrau@gmail.com>,
	Stefan Eichenberger <eichest@gmail.com>,
	Kory Maincent <kory.maincent@bootlin.com>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Ahmed Zaki <ahmed.zaki@intel.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v3 2/3] net: ethtool: Add impedance mismatch
 result code to cable test
Message-ID: <50748ea1-4b53-4b6c-b08b-1ad230d838b7@lunn.ch>
References: <20240402201123.2961909-1-paweldembicki@gmail.com>
 <20240402201123.2961909-2-paweldembicki@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240402201123.2961909-2-paweldembicki@gmail.com>

On Tue, Apr 02, 2024 at 10:11:19PM +0200, Pawel Dembicki wrote:
> Some PHYs can recognize during a cable test if the impedance in the cable
> is okay. They can detect reflections caused by impedance discontinuity
> between a regular 100 Ohm cable and an abnormal part with a higher or
> lower impedance.
> 
> This commit introduces a new result code:
> ETHTOOL_A_CABLE_RESULT_CODE_IMPEDANCE_MISMATCH,
> which represents the results of a cable test indicating issues with
> impedance integrity.
> 
> Signed-off-by: Pawel Dembicki <paweldembicki@gmail.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

