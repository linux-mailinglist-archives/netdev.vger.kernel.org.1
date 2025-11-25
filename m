Return-Path: <netdev+bounces-241575-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BABA8C85F94
	for <lists+netdev@lfdr.de>; Tue, 25 Nov 2025 17:27:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2BA403A6E8B
	for <lists+netdev@lfdr.de>; Tue, 25 Nov 2025 16:27:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5BC132694B;
	Tue, 25 Nov 2025 16:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="ZbaNjvR0"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2501F3254B4;
	Tue, 25 Nov 2025 16:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764088026; cv=none; b=uG7DQvjAwPh3LOZrM42yC+ka5P3r0cBxlsOZTtfvSxngwGFWXmXKNWyHnCoCwE+nxqbWQzxheAr3qBB6ggcRTE5a4pf52QcCl9fkAZEeHlCPVP1hUJt7RdE7TmWWt7fH32CC0yoL/sEkz2V9QIL0YANZtzcoxZlEc7tgZagZlB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764088026; c=relaxed/simple;
	bh=EkWnzLl+Px6ZhoYCER/PrCiBKkewlg647OIcIEK8gII=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TObcqasM51a2EBh7kafJO8Mvj5vf6lHfZAwP+OkCeit3fkaOhYVjfFdzgpUHr3fMojgmmQ3hTTNTbM0CIFXJaofS4EX5nxiYnMGW/D2LZnZVU4RHRsWsRTjONKZAH3Zb7HTgs0YRl874lrcajrJopzUJLFtiGZGYec7gE8MC7sU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=ZbaNjvR0; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=7nzjYoLuwpYnz7W92bzjIjzD0CCCnI7l331fHmFyPX4=; b=ZbaNjvR02uqUoXkpFZUTGgs/dw
	kA52jOICIIw7Fki34N9cRTDMfueZcuh7g8ekx2s9FpvqAiQFP6a8N1GMfCpkk5/UkcoVuqwPrIjXb
	iDuiEfrVWUTjl4BiUtFA3l9jBK1c4jmNYGosHWrV1lPV4pmk0NbbnCPjBKuuYWvFEkXQ=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vNvsJ-00F264-O9; Tue, 25 Nov 2025 17:26:43 +0100
Date: Tue, 25 Nov 2025 17:26:43 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: rohan.g.thomas@altera.com
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Jose Abreu <Jose.Abreu@synopsys.com>,
	Fugang Duan <fugang.duan@nxp.com>,
	Kurt Kanzenbach <kurt@linutronix.de>, netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: stmmac: Fix E2E delay mechanism
Message-ID: <e721d2d5-73cc-4c32-b99c-55f0fb625563@lunn.ch>
References: <20251125-ext-ptp-fix-v1-1-83f9f069cb36@altera.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251125-ext-ptp-fix-v1-1-83f9f069cb36@altera.com>

On Tue, Nov 25, 2025 at 10:50:02PM +0800, Rohan G Thomas via B4 Relay wrote:
> From: Rohan G Thomas <rohan.g.thomas@altera.com>
> 
> For E2E delay mechanism, "received DELAY_REQ without timestamp" error
> messages shows up for dwmac v3.70+ and dwxgmac IPs.
> 
> This issue affects socfpga platforms, Agilex7 (dwmac 3.70) and
> Agilex5 (dwxgmac). According to the databook, to enable timestamping
> for all events, the SNAPTYPSEL bit in the MAC_Timestamp_Control
> register must be set to 2'b00, and the TSEVNTENA bit must be cleared
> to 0'b0.
> 
> Commit 3cb958027cb8 ("net: stmmac: Fix E2E delay mechanism") already
> addresses this problem for all dwmacs above version v4.10. However,
> same holds true for v3.70 and above, as well as for dwxgmac. Updates
> the check accordingly.
> 
> Fixes: 14f347334bf2 ("net: stmmac: Correctly take timestamp for PTPv2")
> Fixes: f2fb6b6275eb ("net: stmmac: enable timestamp snapshot for required PTP packets in dwmac v5.10a")
> Fixes: 3cb958027cb8 ("net: stmmac: Fix E2E delay mechanism")

Given the list of Fixes: do you want this back ported to stable? If
so, you should not submit it for net-next.

	Andrew

