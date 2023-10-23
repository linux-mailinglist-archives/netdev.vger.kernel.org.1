Return-Path: <netdev+bounces-43488-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 64B507D394A
	for <lists+netdev@lfdr.de>; Mon, 23 Oct 2023 16:28:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D5917B20C06
	for <lists+netdev@lfdr.de>; Mon, 23 Oct 2023 14:28:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B18071B292;
	Mon, 23 Oct 2023 14:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="jfp2GZfW"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF82B134DF
	for <netdev@vger.kernel.org>; Mon, 23 Oct 2023 14:28:12 +0000 (UTC)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6CD3DD;
	Mon, 23 Oct 2023 07:28:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=sPMDCYa/eOvobhpB1VjCXUms41/R3FiMxkI8iUKywDY=; b=jfp2GZfWZO5vRu5SlGBeGwS9G1
	VBSd4G9YruH6A4xRuvPE7fXFrufnfnVlxioWMn8lSb6KR+CFKsyXji4GgyFcmTanIzQDXEcolTPp4
	MC9mDatDpeInPyav9nX9minyyJf66k2GRGtKYuuh8n1piL3P71dwv+ayBB7r/8tZKP4c=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1quvuW-00323v-AQ; Mon, 23 Oct 2023 16:28:04 +0200
Date: Mon, 23 Oct 2023 16:28:04 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: "Jia, Fang" <fang.jia@windriver.com>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	"David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: phy: fixed link 1000 or 100 set with autoneg off
Message-ID: <dfc37ead-2abe-4053-b0a6-911c9c387451@lunn.ch>
References: <d7aa45f8-adf8-ff9a-b2c4-04b0f2cc3c06@windriver.com>
 <c23dcdb0-f493-453d-82b9-b498f4d3c88b@gmail.com>
 <9dd0e0b8-751b-170a-7c8f-bc084efae69b@windriver.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9dd0e0b8-751b-170a-7c8f-bc084efae69b@windriver.com>

> Thanks very much for your reply.
> 
> Actually, due to some reason, the phydev's default aneg state is off.
> And we just found if use ethtool to set, it had the same result.

I find it surprising it defaults to aneg off. Are you sure something
has not turned it off before you look at it?

The emulator does not support writing to any registers. However,
fixed_mdio_write() does not return an error, it just does nothing.  It
needs testing, but maybe try making it return -EOPNOTSUPP. That should
prevent auto-neg being turned off, but it might also break everything
if it tries to do some other write during probe or link up. It could
be it needs a more select response, allowing writes to some bits, like
the reset bit, and start auto-neg, but not others like disable
auto-neg.

	Andrew

