Return-Path: <netdev+bounces-98315-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 69D508D0A87
	for <lists+netdev@lfdr.de>; Mon, 27 May 2024 21:01:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 24EF3283371
	for <lists+netdev@lfdr.de>; Mon, 27 May 2024 19:01:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 987941607B1;
	Mon, 27 May 2024 19:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="OB5XT4Rd"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD46A1607AF;
	Mon, 27 May 2024 19:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716836444; cv=none; b=IWcvg1aUrwfdJEd+3LeWffn07z2GM7Cv0GMQ1TwxZz7T2hu+nRjE3XRjcboShNwKUtyXQv7UKH2kIhrPIR6U/J1AwC8Op6+lqKBKixmvRI/DRFeVYkTGfm3Cj13JTqzIBCn5Y8B6SZzNkZFju7iOFzNWaX5IJ5yoCncSA/PN/fU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716836444; c=relaxed/simple;
	bh=2uBLw2Sx6UBiIag7jcLM/uRvSK9uqL6b3mrS6Z7KwuM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n0b/RHnSXqrgTGh+ZRd4MgrGNDElXRxhQgPBXiUAwN5KqCBvEt2RWGWz54oQ2Qo31eNGw+QpXc7vmAMd9CE2EifyTsY+slnsar9oKn6DBmQmdAw88xO/xJvVl+cHaK7yUtkERVR0GoyjK63BT8JaoerEZULs/5LCz4Msn+KDcM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=OB5XT4Rd; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=37lIg3s+t3b4qmG4nLG2iDBlAi6+bbFulGijMGLbRU8=; b=OB5XT4RdOZy8fOvjvk2d6piuRk
	vfd0+RlJFNNtKH3IcMqZSirlvjb7mPXlqD4ZBtm4zyaObwAl/ngWfAL5icsMY63lGMjF/cndhR4vd
	oXlofZe+OnC8ok7jw5WG6OZIedTtxK9tY5ZYnywUU8j7hK1egDHtQKw4JejCqXuxvLYc=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sBfZq-00G69n-52; Mon, 27 May 2024 21:00:10 +0200
Date: Mon, 27 May 2024 21:00:10 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Boon Khai Ng <boon.khai.ng@intel.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Tien Sung Ang <tien.sung.ang@intel.com>,
	G Thomas Rohan <rohan.g.thomas@intel.com>,
	Looi Hong Aun <hong.aun.looi@intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Ilpo Jarvinen <ilpo.jarvinen@linux.intel.com>
Subject: Re: [Enable Designware XGMAC VLAN Stripping Feature v2 1/1] net:
 stmmac: dwxgmac2: Add support for HW-accelerated VLAN Stripping
Message-ID: <48176576-e1d2-4c45-967a-91cabb982a21@lunn.ch>
References: <20240527093339.30883-1-boon.khai.ng@intel.com>
 <20240527093339.30883-2-boon.khai.ng@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240527093339.30883-2-boon.khai.ng@intel.com>

> This implementation was ported from the dwmac4 driver.

How does it differ from dwmac4? Can the dwmac4 implementation just be
used, rather than duplicating all the code/bugs.

	Andrew

