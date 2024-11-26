Return-Path: <netdev+bounces-147516-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6843C9D9EAA
	for <lists+netdev@lfdr.de>; Tue, 26 Nov 2024 22:06:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 12ADEB26598
	for <lists+netdev@lfdr.de>; Tue, 26 Nov 2024 21:06:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 500191DEFFC;
	Tue, 26 Nov 2024 21:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="GpeOe90d"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8A2C17C219
	for <netdev@vger.kernel.org>; Tue, 26 Nov 2024 21:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732655212; cv=none; b=eeGB2sSuk+v/IqL5lN59aFNAes3ekli3WigigRb/3ShcMInM6ZkyCV7Uf4qF4QKTf+U/9TLaqyKPPibix6HdhVZuG2SLl4JRqEQRgqgXk5cv2lx/M1cS2mmFafZtjpanZo89nicipBtYgoe98BR6PWTtjpo2J2i377386FfVC+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732655212; c=relaxed/simple;
	bh=5X826ci43sBcGyrKBl7krBqnWOAFhNHw5Sgj4SdxFCo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uNv1N2IgzpYTPMFKhNGicz4NN26Pg0sFCfGhPekf/U1RudFHnj6f4or5filt8Qyvf/Pl2YXAi1SEO6kJu/Tie5sOAWviSob5wRkZvUs/EGXvJDNpITSsVV9FtggOURIncukRuRnqek6keP6D+eMHtW4xeuF0yH30oYKhsnIvZW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=GpeOe90d; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=eK29JLfQGYjMLr8qhnzk5waWYaHeLXYhWdUAvgw0WG4=; b=GpeOe90dHC49t0syfVOCe2POOB
	/n5MKXelcj8x27JmVo5+BfSZRIPrfTx5eYKF8t+cjBAHJhwmGziGafDG8eCH1LEgBHr2a3jKPV37U
	Lzcvck5apsQ9B/iP07R8Ijtu5MKwCToNWVOM1klEtUtfUmZcvxVcl0vmphpGc/0TXoMs=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tG2lZ-00EZDF-5Q; Tue, 26 Nov 2024 22:06:37 +0100
Date: Tue, 26 Nov 2024 22:06:37 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Alexander Couzens <lynxis@fe80.eu>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Daniel Golle <daniel@makrotopia.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Ioana Ciornei <ioana.ciornei@nxp.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Jose Abreu <Jose.Abreu@synopsys.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Marcin Wojtas <marcin.s.wojtas@gmail.com>,
	Matthias Brugger <matthias.bgg@gmail.com>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH RFC net-next 10/16] net: mvneta: implement
 pcs_inband_caps() method
Message-ID: <6231ab62-91e2-4874-aec7-f53e58a85250@lunn.ch>
References: <Z0WTpE8wkpjMiv_J@shell.armlinux.org.uk>
 <E1tFrog-005xQY-LH@rmk-PC.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1tFrog-005xQY-LH@rmk-PC.armlinux.org.uk>

On Tue, Nov 26, 2024 at 09:25:06AM +0000, Russell King (Oracle) wrote:
> Report the PCS in-band capabilities to phylink for Marvell NETA
> interfaces.
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

