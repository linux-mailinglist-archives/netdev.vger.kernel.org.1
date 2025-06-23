Return-Path: <netdev+bounces-200149-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C09CDAE36BA
	for <lists+netdev@lfdr.de>; Mon, 23 Jun 2025 09:25:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F37F83AEC9B
	for <lists+netdev@lfdr.de>; Mon, 23 Jun 2025 07:25:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE7E51EFF9F;
	Mon, 23 Jun 2025 07:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="sg0HsJvW"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 843FA2EAE5;
	Mon, 23 Jun 2025 07:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750663538; cv=none; b=XoUpYl8Jz6+Da4LgAt1cEQemabBfG9wUKm3SIEjn35lkNqaZySZEdMyKU0Am6NO0mKy3hUfNzsSEcfvc5Heh2J/SuRWYS1FOlG/hAXHf1Zoz0BFG922D/s+dO5EGlRflFobj0Oj4TA7xwe7BJKfEFEb4QYv/LBi5ih8HHyA5eyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750663538; c=relaxed/simple;
	bh=qrWwGHucouDZh2t1tAu8TyL00Fd2aq1gdpXqthU5zy8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WHEH4tU5EEZPlId95oix84HgwdBv1nb7TQhAG0gpbeuAI7HMC7cbALXT3B1XnK1Y4YDyC6ui5daQodMoaBYpsje0fFR82XbRAA7i3sVoFwm7Vy2vPdh0mTcdKl7A+evN6WZcuBtXV3GXE6EIhLHoZRDmf6YlXube7jDusctH4vA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=sg0HsJvW; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=Cd3lQ68F49FcJhWhZAZYZUquvzxLE9gTxVzwWcJXNf8=; b=sg0HsJvWfvJwCHkDvTM+OEva7k
	6Se526NxBlBc7oZ+nx903RVvTiutVv2rjAd0L7HmnprxnbY5EqljKCYfSxlpSUJ2p+OWlA0aKs4Hs
	noPlTAhJMeVxLLwK9S0HkDh95hb/a/kZ1e/+iO3V2LL9q0I6LlIUOUvIdK5/DRTCgRLI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uTbXw-00GfJ5-6o; Mon, 23 Jun 2025 09:24:52 +0200
Date: Mon, 23 Jun 2025 09:24:52 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Inochi Amaoto <inochiama@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen Wang <unicorn_wang@outlook.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Richard Cochran <richardcochran@gmail.com>,
	Alexander Sverdlin <alexander.sverdlin@gmail.com>,
	Thomas Bonnefille <thomas.bonnefille@bootlin.com>,
	Yu Yuan <yu.yuan@sjtu.edu.cn>, Ze Huang <huangze@whut.edu.cn>,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	sophgo@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org, Yixun Lan <dlan@gentoo.org>,
	Longbin Li <looong.bin@gmail.com>
Subject: Re: [PATCH net-next RFC v2 3/4] riscv: dts: sophgo: Add mdio
 multiplexer device for cv18xx
Message-ID: <48769988-9ece-41d3-93fe-607061d68fff@lunn.ch>
References: <20250623003049.574821-1-inochiama@gmail.com>
 <20250623003049.574821-4-inochiama@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250623003049.574821-4-inochiama@gmail.com>

> +			external_mdio: mdio@1 {
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +				reg = <0x80>;

Since reg is 0x80, the normal convention is this is mdio@80.

	Andrew

