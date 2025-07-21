Return-Path: <netdev+bounces-208623-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ECCA9B0C637
	for <lists+netdev@lfdr.de>; Mon, 21 Jul 2025 16:24:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D4F393B66FC
	for <lists+netdev@lfdr.de>; Mon, 21 Jul 2025 14:23:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24EB62DAFB7;
	Mon, 21 Jul 2025 14:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="yuZy083T"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 891AE2DA767;
	Mon, 21 Jul 2025 14:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753107849; cv=none; b=EoPqx73CX7U8MmMANpPcNrthqZIWhsKEXYug8nSt40xET1igtKOleJlSX9qgGsEx3iyZ9ypRXkS0/xrznUG7VdAfgZviHA2NGiQfoJ1z8H7yKyzdveaS026ewxLPV5vv4p7g4ynLXNT2v7WyqLL2zCo7S4QZHhL+KeVlbb90U4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753107849; c=relaxed/simple;
	bh=1XwZqdGrESrEbYeqeKIYsPwLevTf/uNHNa8KyPX6EV8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nscRUoxKno1xnFWmjmRIcl427xewNdq/Jt6WKoggvKNqVhN5nG2xo+wyQDHffpwim4XpjoWKI00ud9/1PSI+4N2H2KRFMdjugEAzwSX4yRkjxbNlu+OIPDWo/707KtQaJo4b63Mm/KNpbYELqRIAQSqfd5oyA6aaM/hSuSepIJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=yuZy083T; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=hHzpUiLN7Jg4Lz4KXx4NfLv+H9x1eSd9BwpY3gu+U20=; b=yuZy083TIKWJigFiyJMEIO7mEL
	CW77wF+9YJR9suubJ3/IY4OYuLkd52G6nptaS9fV7lW7Fj7Lkt1mA/V95X650ZAgj2wdFYvoe6Jh0
	UeN4rX/9MDUAAXnFyZW8Rr+OYnT+phRL+5FFl1AfFJOmVXjgQuyBgzO7I2Mkn/dgetuM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1udrQo-002Mif-LR; Mon, 21 Jul 2025 16:23:54 +0200
Date: Mon, 21 Jul 2025 16:23:54 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Gatien CHEVALLIER <gatien.chevallier@foss.st.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Christophe Roullier <christophe.roullier@foss.st.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Simon Horman <horms@kernel.org>,
	Tristram Ha <Tristram.Ha@microchip.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 3/4] net: phy: smsc: fix and improve WoL support
Message-ID: <a3b97fbd-8c4f-4657-aeca-732aee3782c3@lunn.ch>
References: <20250721-wol-smsc-phy-v1-0-89d262812dba@foss.st.com>
 <20250721-wol-smsc-phy-v1-3-89d262812dba@foss.st.com>
 <cca8e9e6-a063-4e00-87af-f59ea926cce3@lunn.ch>
 <b95e3439-717b-4159-acf9-7ce76d1c43d4@foss.st.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b95e3439-717b-4159-acf9-7ce76d1c43d4@foss.st.com>

> I wanted to state clearly that the wake up happended because of a WoL
> event but sure, I understand that it's best if log isn't spammed. Do you
> prefer it completely removed or dev_info()->dev_dbg() ?

phydev_dbg() is fine.

	Andrew

