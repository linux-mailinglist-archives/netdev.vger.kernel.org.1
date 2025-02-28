Return-Path: <netdev+bounces-170797-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 396E5A49F05
	for <lists+netdev@lfdr.de>; Fri, 28 Feb 2025 17:39:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1FD673B94BE
	for <lists+netdev@lfdr.de>; Fri, 28 Feb 2025 16:37:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE4C7271818;
	Fri, 28 Feb 2025 16:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="B9GH67kh"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FF2F2702B7;
	Fri, 28 Feb 2025 16:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740760659; cv=none; b=fWIe62gl189P8a/w/K2t4udKXIz+mX5bKZEXRiutNmKyaXlXsAuqUYako4cckjIhmTw02a14VqsLnQtdfQREou+mR3Gg3pMTyO/mUs4LaPriGgFyYGxL425psHQ/mJ8lm0S5Dh4BZzYakdXDqkdaxNMVSGvWnn61e16ntjfCn8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740760659; c=relaxed/simple;
	bh=epNnDncNDPb3P9Gfrg3v/n733ph9wy4EFsXFRHFRvKY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DrJKTISgP49HvjnI7vuEUnOMKgGonQjPzG4AZOUfVKvMqoU4UPIHgRYNVA7kA9vcj0puOH1VtSJrgRxfR7nTpGW4AsPTPA5y9bKQxY0sSEFZFz2ebPWabLJVBWQAtH81JIdaDbnx+5mrjfKqYUN1K+CEvOxVxjaObpTQatqDgIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=B9GH67kh; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=1VRZoqoHCK+crSI0o1Efw52ErTi5ppZiw43v7ZMPgsI=; b=B9GH67kh5Jx8WzgqtpIIffYyq3
	PWDB2DLd/vOU1AwfV204wkdgFxp78886X72/Ob+ubLCt+jeR4DCJpFk4VoO2BUpK2M2oQI87XSI0D
	3+dNH2QThUO2gaotwredUNBP3UQhuCf2nSiZ18yMiWTn0r2HRCWEOhldpdhbV3oGjP+I=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1to3MX-0010OP-I6; Fri, 28 Feb 2025 17:37:21 +0100
Date: Fri, 28 Feb 2025 17:37:21 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Mark Pearson <mpearson-lenovo@squebb.ca>
Cc: anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com,
	intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] e1000e: Link flap workaround option for false IRP events
Message-ID: <51f829a0-43e2-4cb5-ac0f-a0098d53ce7b@lunn.ch>
References: <mpearson-lenovo@squebb.ca>
 <20250226194422.1030419-1-mpearson-lenovo@squebb.ca>
 <36ae9886-8696-4f8a-a1e4-b93a9bd47b2f@lunn.ch>
 <50d86329-98b1-4579-9cf1-d974cf7a748d@app.fastmail.com>
 <1a4ed373-9d27-4f4b-9e75-9434b4f5cad9@lunn.ch>
 <9f460418-99c6-49f9-ac2c-7a957f781e17@app.fastmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9f460418-99c6-49f9-ac2c-7a957f781e17@app.fastmail.com>

> For the PHY - do you know a way of determining this easily?

Add printk()s to e1000e_get_phy_type_from_id().

	Andrew

