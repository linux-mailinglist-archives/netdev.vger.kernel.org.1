Return-Path: <netdev+bounces-228551-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D9E06BCE034
	for <lists+netdev@lfdr.de>; Fri, 10 Oct 2025 18:57:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E3235500F87
	for <lists+netdev@lfdr.de>; Fri, 10 Oct 2025 16:55:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DD8A2FC896;
	Fri, 10 Oct 2025 16:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="BmJ6TLz+"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 978092FC876;
	Fri, 10 Oct 2025 16:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760115309; cv=none; b=a0Eyq7QNRnlA2/G04uhf1e3Rc6ycje/GXUaLYPMYkDA3cv3vy0St4J3iPYSXGKOAkkcQUlhXD40PCMrMkAok8z7uBAMj3SwrcWaFAQCh0c21ytJZ5GXNZvji0LJZcpPRWJeY5gP0THDHg1ywsy8jHsnp7+0F5tKyylKictTv714=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760115309; c=relaxed/simple;
	bh=suRumcgYqoCReE8eyejZ0DNC/ShHcuzZ9zg6cgvFHCE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YjaWV+S50zk2riFKqaI7zPK14D3yL+cAPN3dEbxOf1LinDmIONht2+JMEgweio/v+6zuXAn8s3akHwpJ9gV+u3dC8X8BRK2pBUGmn3NN3iGEj+0JtJquirqg0UVYB2xhuBNrF6RTNOrKtMClhzDxF0T5zWyzzjfQySvV8wzGzjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=BmJ6TLz+; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=vscTT9HApN3I/7J7o6eTXeB4kqT2Uq/JxUsNpPc9x4c=; b=BmJ6TLz+3ImZgyegUyiBhBdxD6
	6t7z+p3q0qqdz29e9/eJ53uRu+bGZ1JD+F4O8+/JkzDTC0o1kuaU72MG9wZAY+OV7uRg1f7MlAwY1
	fxV7oYk88oPiZ73BA+Net4WlYvnjkrZ7uTsUByCBLA/Kegb9P0cyY4nR6GrNremzyFGY=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1v7GOE-00AcUe-SN; Fri, 10 Oct 2025 18:54:46 +0200
Date: Fri, 10 Oct 2025 18:54:46 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Conor Dooley <conor@kernel.org>
Cc: Thomas Wismer <thomas@wismer.xyz>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	Kory Maincent <kory.maincent@bootlin.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Thomas Wismer <thomas.wismer@scs.ch>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] dt-bindings: pse-pd: ti,tps23881: Add TPS23881B
Message-ID: <d93573b4-6faa-4af5-80ae-32d68092ff30@lunn.ch>
References: <20251004180351.118779-2-thomas@wismer.xyz>
 <20251004180351.118779-8-thomas@wismer.xyz>
 <20251007-stipulate-replace-1be954b0e7d2@spud>
 <20251008135243.22a908ec@pavilion>
 <e14c6932-efc9-4bf2-a07b-6bbb56d7ffbd@lunn.ch>
 <20251009223302.306e036a@pavilion>
 <8395a77f-b3ae-4328-9acb-58c6ac00bf9e@lunn.ch>
 <20251010-gigahertz-parakeet-4e8b62ffa9fd@spud>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251010-gigahertz-parakeet-4e8b62ffa9fd@spud>

> > So if the silicon and the DT disagree, you get -ENODEV or similar?
> > That is what i would recommend, so that broken DT blobs get found by
> > the developer.
> 
> I'm personally not a big fan of this kind of thing, as it prevents using
> fallbacks for new devices when done strictly. I only really like it
> being done this way if the driver does not produce errors for unknown
> part numbers, only if (using this case as an example) a b device is
> labeled as a non-b, or vice-versa. IOW, if the driver doesn't recognise
> the ID, believe what's in DT.

The issue we have seen in the past when not strictly checking the
compatible against the hardware, is that a number of DT blob ship with
the wrong compatible. Then sometime later you find you need to key
some feature off the compatible, but you cannot without breaking all
those devices which have the wrong compatible.

In order to be able to use the compatible, it has to be correct.

   Andrew

