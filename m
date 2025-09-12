Return-Path: <netdev+bounces-222731-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C146AB55825
	for <lists+netdev@lfdr.de>; Fri, 12 Sep 2025 23:12:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C3553AB53D
	for <lists+netdev@lfdr.de>; Fri, 12 Sep 2025 21:12:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78F0232ED36;
	Fri, 12 Sep 2025 21:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="0ehj3ZeM"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6539B1C84A0;
	Fri, 12 Sep 2025 21:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757711546; cv=none; b=iaQW3Y8wHJythIs+u8CrGMA3UkvQsog1sPg7jkheU6gJJqDWCzCJHri0/VIxoEGEt9VdXDJuZEDEFynoJN4gOP4D9TNWP04U98QZjpEU/UDiMCqozvdTbBXZwGlyCefTXBI5IZMQ8DFd+dj0v26r3SmLpGtCmgSGH1gXDLQ/DL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757711546; c=relaxed/simple;
	bh=mUt5ZSYyNvsuZ1VNqOu/MmO5Chhhf+kJqBJ4T1hGeVA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NFrNN6tcRCrm0mryE9e3iYNo+JHe1WP79/FJiNMHtFCMksjzxVofrmknSZgNMldk2qotfZW7fhuwKVXURTI2y8qgkX14pFEnE+0mmkDMoZe21ypCbGVwomm8OPMby0txr0heAFPtgpoTEQMznyCi15Mkc5GbqdhgPxW2C3dZFNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=0ehj3ZeM; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=rNdLjeplPkqfEmRszEB/ZVAWbTLvcxwpkaHxxGJD3SI=; b=0ehj3ZeMD3fcpWh2loBYgBjUez
	H9MB68zr1Au9biTqYNu2WceM5P4YqFr4CuBKtKYE6hry3sQCb2+FiXIBESG+p0z8KD2TeAA4a/BX1
	7woJpvBOKIABRSOFhD3RjvSQFBPW6Zkc2+HPDrJwzfdSc9rAT7CJdN/S+6TkGpr4tZTo=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uxB3u-008G35-BA; Fri, 12 Sep 2025 23:12:06 +0200
Date: Fri, 12 Sep 2025 23:12:06 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Vivian Wang <wangruikang@iscas.ac.cn>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, Jakub Kicinski <kuba@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Yixun Lan <dlan@gentoo.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Vivian Wang <uwu@dram.page>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Junhui Liu <junhui.liu@pigmoral.tech>,
	Simon Horman <horms@kernel.org>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org, spacemit@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Hendrik Hamerlinck <hendrik.hamerlinck@hammernet.be>
Subject: Re: [PATCH net-next v11 4/5] riscv: dts: spacemit: Add Ethernet
 support for BPI-F3
Message-ID: <0df5d251-3c2e-4b5a-8fb8-b5a6d00383c2@lunn.ch>
References: <20250912-net-k1-emac-v11-0-aa3e84f8043b@iscas.ac.cn>
 <20250912-net-k1-emac-v11-4-aa3e84f8043b@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250912-net-k1-emac-v11-4-aa3e84f8043b@iscas.ac.cn>

On Fri, Sep 12, 2025 at 02:13:56AM +0800, Vivian Wang wrote:
> Banana Pi BPI-F3 uses an RGMII PHY for each port and uses GPIO for PHY
> reset.
> 
> Tested-by: Hendrik Hamerlinck <hendrik.hamerlinck@hammernet.be>
> Signed-off-by: Vivian Wang <wangruikang@iscas.ac.cn>
> Reviewed-by: Yixun Lan <dlan@gentoo.org>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

