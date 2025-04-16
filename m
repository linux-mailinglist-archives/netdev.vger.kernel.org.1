Return-Path: <netdev+bounces-183278-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 82D6BA8B908
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 14:28:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D7053AB54E
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 12:28:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98460221272;
	Wed, 16 Apr 2025 12:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="iqLfqMOP"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 162BC2327A1
	for <netdev@vger.kernel.org>; Wed, 16 Apr 2025 12:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744806511; cv=none; b=cG9A4PNLTdh5RlwNNB8R+nAlKOCITlUsb9TqEDmnUEvJoxPDR6ZHiLF+9BBmSIQYc4v7cil850UGNm9n9YMYxw7QfEn2HpMdCWCzx5UCK+q7qprUQS4OAPVWfP0FF2K0AXpl/nQ1HpMhR2IugkBgEXaR43TtMnGZ3OEIwqeFHwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744806511; c=relaxed/simple;
	bh=rkNqZzsqsytXu4XNRnjvbpXulGrjKfBIYaKK7CA9Vgg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xtxh3pjkvc4I6dhpltGeiAVF6GugCOPsBCER8sYeLNDCH1zbpyCY0BizNmNWrbPtbgLSWqeJBgplJbN4/+XrZpDIn42YNfLp2Kuym1tmgJaqXI2BSwQYQw0hZcLGXovHWoGY2B9TnL80MJU3zG1wfpuqAu4RGK34gRNFVxFYMoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=iqLfqMOP; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=MLeqxcCuX3BoT7U+FhDZa/UKFjGcWR5LVHuvgMXj9MA=; b=iqLfqMOPWoffq199Gd/V5c66wg
	CBrB0Kj4NnLc4sKIpIgvttRQfduIi4E9m4MKJjBijUcIl6btI73w5wN8VacxCEkuOvYI1c7JgEVMx
	S6Umj5FJcBENd8Y5GmjAUnLN7m85/3sIlyEv8qKq4B+MOi6xcwiX4dXew97/tZpNq0eU=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1u51sK-009cLA-2K; Wed, 16 Apr 2025 14:28:20 +0200
Date: Wed, 16 Apr 2025 14:28:20 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Matthias Brugger <matthias.bgg@gmail.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next] net: stmmac: mediatek: stop initialising
 plat->mac_interface
Message-ID: <c952e3ac-58d2-4913-a006-c8e9215e9d2e@lunn.ch>
References: <E1u4zyh-000xVE-PG@rmk-PC.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1u4zyh-000xVE-PG@rmk-PC.armlinux.org.uk>

On Wed, Apr 16, 2025 at 11:26:47AM +0100, Russell King (Oracle) wrote:
> Mediatek doesn't make use of mac_interface, and none of the in-tree
> DT files use the mac-mode property. Therefore, mac_interface already
> follows phy_interface. Remove this unnecessary assignment.
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

