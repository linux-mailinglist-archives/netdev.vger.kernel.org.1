Return-Path: <netdev+bounces-161945-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94FA8A24BD7
	for <lists+netdev@lfdr.de>; Sat,  1 Feb 2025 22:04:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 03004164B51
	for <lists+netdev@lfdr.de>; Sat,  1 Feb 2025 21:04:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36B551C1F19;
	Sat,  1 Feb 2025 21:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="T9C2WzKg"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E2C9126F1E;
	Sat,  1 Feb 2025 21:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738443837; cv=none; b=SazbrFm0z7BbSdpu60N65ihftMh3TcoF3PRkKqnObn6uDevfCd7Xpq1nx+S1Xe9IzTKKJLgcXXBVkm4iB8XLSzUIVqWUDgSw8LTlw2rY16EeMqdmHicdLnampXCADQMG1ZptcVbBMd81GnyGb8W2+/7LfgyKa2eHNKFXzbURPcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738443837; c=relaxed/simple;
	bh=odUsKlGwkfUbfxfaxYHZz3lD6um/dDkZCnsMc4cwX3E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B84Ftt/VTMmGV8oELxsKxEi0/TWWoISY2OM5+LR17s3jxihENU3DlVvSh6BWMfKT7RUw4GhqyXHyVQ/8o5ui8U52wu0dim5bQDqpQzu0bxHiGrsVNXqSWGizXyuy9f0vv6dZQXnFz4tt0wGluioqmu5TiHP+7nxqzR5cwoqkcpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=T9C2WzKg; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=FweREbWAF9D7Gp3jju3lmGOpsOLx/UZjW8DSTl3nrjw=; b=T9C2WzKg/K7gDXNBxmchjGGIka
	zDVCITjbBZ980TWBMymYMMrK/tnqpRbJr/2bOn9jHgO1cl0uIkIUY9VpFnBDV7j39q2B/8hSOQOy0
	OuQIAgHUdvpYDGjOgxx0ASb2AhMLAIpygoPSw1ZZoV6O1Y2vEqvlmxOVL1v7Vu+1W80M=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1teKeG-00A41v-On; Sat, 01 Feb 2025 22:03:28 +0100
Date: Sat, 1 Feb 2025 22:03:28 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Steven Price <steven.price@arm.com>
Cc: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Yanteng Si <si.yanteng@linux.dev>, Furong Xu <0x1207@gmail.com>,
	Joao Pinto <Joao.Pinto@synopsys.com>, netdev@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v4 3/3] net: stmmac: Specify hardware capability
 value when FIFO size isn't specified
Message-ID: <f92e21c5-106c-4a65-8fc5-06a0d281729b@lunn.ch>
References: <20250127013820.2941044-1-hayashi.kunihiko@socionext.com>
 <20250127013820.2941044-4-hayashi.kunihiko@socionext.com>
 <07af1102-0fa7-45ad-bcbc-aef0295ceb63@arm.com>
 <fc08926d-b9af-428f-8811-4bfe08acc5b7@lunn.ch>
 <f343c126-fed9-4209-a18d-61a4e604db2f@arm.com>
 <a4e31542-3534-4856-a90f-e47960ed0907@lunn.ch>
 <d6265f8e-51bc-4556-9ecb-bfb73f86260d@arm.com>
 <2ed9e7c7-e760-409e-a431-823bc3f21cb7@lunn.ch>
 <915713e1-b67f-4eae-82c6-8dceae8f97a7@arm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <915713e1-b67f-4eae-82c6-8dceae8f97a7@arm.com>

> The below works for me, I haven't got the hardware to actually test the 
> gmac4/xgmac paths:

Hi Steven

I think we have enough testing done, please could you officially
submit this patch.

Thanks
	Andrew

