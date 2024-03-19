Return-Path: <netdev+bounces-80569-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E014A87FD53
	for <lists+netdev@lfdr.de>; Tue, 19 Mar 2024 13:05:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E80C1C21D6A
	for <lists+netdev@lfdr.de>; Tue, 19 Mar 2024 12:05:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 871627F480;
	Tue, 19 Mar 2024 12:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="RFwFIzle"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A45697EEEA
	for <netdev@vger.kernel.org>; Tue, 19 Mar 2024 12:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710849949; cv=none; b=YswTpkaBzpuQuQXJ6TO39N4sANNHlG7TA9Jus2KFTkV5WOTFJcPH5V1n8icp1iDR0AcodjfMSpDm8LNNBc3iO0R/VojF8JmEb1iz7vMefPWH/OJzb4oWuD0Dd5mSd1bRRCJ/fhcbR8SllM8iHh4Oes7cTrW0LAmYHTyCOulX9BA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710849949; c=relaxed/simple;
	bh=gyKAZWI5VLvKLDSsM08uC/wPkhGWbQB/9wp2kdBAl28=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k0AeFVAWiKT854NvG/YFaAj0VID2knYLAbFZz30i3X9sPMhKPY9040qwDms3nCsx2TqIaI2mPKLIQ+FtYzxIVxkPbHs6cCbtB10hzkQW8At7NeEjEqRN7H91HgjxtCcGKTn+3HM0iFtqC2tOlkNRbE0kMMwqschHB5ZxFYNJIIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=RFwFIzle; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=4jfICV3XzhXGR2pafhFT7jEM67I8yt+gpnJLlD9GXkA=; b=RFwFIzleQ45OjIofpfc3MFZiKV
	+e8GWi8oFrCVJ51bnxHyzav22QfxcBBeWZRu587VLxN3SaI9RtxuKxYVg9lPBu5NpPjjocfatQ+sp
	JXe5W3z8gn+xS8XqBaBJ0pa9F0+KUQb9p+J+rGFKuJ4iHEy3VJbLnlsH4LPwJuTD95ns=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rmYDv-00Ah8s-Kq; Tue, 19 Mar 2024 13:05:43 +0100
Date: Tue, 19 Mar 2024 13:05:43 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Paolo Abeni <pabeni@redhat.com>
Cc: "Jan Petrous (OSS)" <jan.petrous@oss.nxp.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>
Subject: Re: [PATCH net-next v2] net: phy: don't resume device not in use
Message-ID: <f6f62bef-5766-4fe1-a6f1-6f18d627737e@lunn.ch>
References: <AM9PR04MB8506772CFCC05CE71C383A6AE2202@AM9PR04MB8506.eurprd04.prod.outlook.com>
 <c5238a4e-b4b1-484a-87f3-ea942b6aa04a@lunn.ch>
 <AM9PR04MB8506A1FC6679E96B34F21E94E2202@AM9PR04MB8506.eurprd04.prod.outlook.com>
 <AM9PR04MB8506791F9A2A1EF4B33AAAF4E2282@AM9PR04MB8506.eurprd04.prod.outlook.com>
 <5a27414c77ae0b0fc94981354fa6931031b3d6fc.camel@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5a27414c77ae0b0fc94981354fa6931031b3d6fc.camel@redhat.com>

> Please note that the 'net-next' tree is closed for the merge window.
> You will have to repost in when the tree will re-open in a week or so.
> 
> However this change could be suitable for the 'net' tree, if Andrew
> agrees. If, please re-sent targeting such tree and including a
> reasonable 'Fixes' tag.

This is the sort of change that i think it should only be in net-next.
Suspend/resume is complex and not tested too well. There is a chance
of regression with this change. So we should introduce it slowly.

	Andrew

