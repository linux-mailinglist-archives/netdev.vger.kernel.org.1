Return-Path: <netdev+bounces-130012-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A010987916
	for <lists+netdev@lfdr.de>; Thu, 26 Sep 2024 20:24:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D7FF1281621
	for <lists+netdev@lfdr.de>; Thu, 26 Sep 2024 18:24:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F6AA16191E;
	Thu, 26 Sep 2024 18:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="KIQv53zq"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DB8233C9;
	Thu, 26 Sep 2024 18:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727375039; cv=none; b=QnZf12kOeqNcdIZe60YL5l/P1f7x0XuYUMpHjXARiQtsWN2UORL2qzvRHKYMoMfWGaw2jYBzfES0x5TIRO4ZzcY7ikaN4XKOTYokgdEtuMNEmltUNTSKnlzP/xXB27Meu5XA/HsIxISUvt5lN7JAHzKRwuzqXMAX5WbZ9/23G80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727375039; c=relaxed/simple;
	bh=NQXOLc6kXr3FnNFygNKVd6RgpRrtA53SbbFWxYM/3W8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SzUL/ryqVBY4iB62YvXPt5ytuWnlAuPuAJLQ0DiWOvgY6NFMxPEl99PQ09K7ZOHZu+BkY/eNdkrDdXYVpOQ8ejSg0PDKRFgoZxrFuSFJITc2vNu6C5DXPdu8K0vnVh7c6AB1oMPR+N9CjeWFG4uBj0XWeuqnUHfWeeWjUL2+V4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=KIQv53zq; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=Xyxq1hzO7uPxbClYISo8yIzxqOiUVL2N8zCxWxmwYmk=; b=KIQv53zqR76AnG7/XgXxwA6gAR
	Ka9x8fFapRY9dNxso8ODjLZPmuQjTos01ZAN8ukm47V0V4o/HRV8EXRhH3523KP0MaRyhDQ/4L4Qt
	XFk4kUp3tkHq/lr7L2TAC1gBfbYTwMUzYUEqGDVt67NVXHJttIOdayxCXD4xQDKMhoaM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1stt8y-008P2y-EE; Thu, 26 Sep 2024 20:23:12 +0200
Date: Thu, 26 Sep 2024 20:23:12 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Drew Fustini <dfustini@tenstorrent.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Giuseppe Cavallaro <peppe.cavallaro@st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	Jisheng Zhang <jszhang@kernel.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Emil Renner Berthing <emil.renner.berthing@canonical.com>,
	Drew Fustini <drew@pdp7.com>, Guo Ren <guoren@kernel.org>,
	Fu Wei <wefu@redhat.com>, Conor Dooley <conor@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-riscv@lists.infradead.org
Subject: Re: [PATCH v2 0/3] Add the dwmac driver support for T-HEAD TH1520 SoC
Message-ID: <5e379911-e3de-478c-b785-61dbcc9627b1@lunn.ch>
References: <20240926-th1520-dwmac-v2-0-f34f28ad1dc9@tenstorrent.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240926-th1520-dwmac-v2-0-f34f28ad1dc9@tenstorrent.com>

> Regarding rx and tx internal delays, that same section in the manual
> doesn't specify what unit is represented by the delay_ctrl bit field in
> GMAC_RXCLK_DELAY_CTRL and GMAC_TXCLK_DELAY_CTRL. It is only 5 bits and
> a max value of 31 seems too small to represent picoseconds. The vendor
> kernel [2] uses properties named "rx-clk-delay" and "tx-clk-delay" but
> doesn't indicate any units. I see ti,dp83867.yaml adds vendor specific
> rx and tx delay properties so that is what I've now done in this series.
> Note: the hardware default value of 0 for delay_ctrl works okay for the
> TH1520 hardware that I have.

I assume you are talking about RGMII delays here?

Do you have a board which needs to set these delays? In general, linux
has the PHY provide the 2ns delay. You only need the MAC to add the
delays if a PHY is being used which cannot add the needed
delays. Occasionally you need to fine tune the delay, and the MAC
delays can then be interesting. But since you have no idea what the
units are, i would prefer to simply hard code it to 0, unless is it
really needed.

	Andrew

