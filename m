Return-Path: <netdev+bounces-193083-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F6BFAC270A
	for <lists+netdev@lfdr.de>; Fri, 23 May 2025 18:01:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A0611C04371
	for <lists+netdev@lfdr.de>; Fri, 23 May 2025 16:00:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68D25221557;
	Fri, 23 May 2025 16:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="DtjbRj+q"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A292C101DE;
	Fri, 23 May 2025 16:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748016037; cv=none; b=TeKzYYcToBZkApCLwThLZTqxuFLwM4RtKH9hge/LKYQhZNO6XBy8fO/9poqaMbg8kC/PTWXk63BrPW/gKYhXeGivDDOubv6O98nfiUpg5jGh2Dyj8m115Ufxl+vshpyvnOnitJbzqD9qYA438U+gwfJboFTD6y+oszjBQ2vPdbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748016037; c=relaxed/simple;
	bh=fU0RcL4y66XsAfVL92CS4laVTLbKG9/0vaig+rg2qEM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KpMphs+ixys7snE1+k0JSJah9Pi2mvAiyaTaBdSUfoKAZdi2H71IdNHr+qatZXiRaeHWaE9N9/JuuReE3KfcS1UiE1BTXelk46ZYNZZELQCu8KURkcrSMThjzzC7PEMA1vsdPk8pnBzkxKikYyEe8LPROzvLYiaDu0jABS+PLds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=DtjbRj+q; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=X5oFqlzs/QpinLejGwTKxPxImZNfhcVenhovwsDfQr4=; b=DtjbRj+qIPPssXo1BXXM3fPYD/
	iiJ5YaEAjvPMnIpQEUP3zONOCwkQ9jjpD9I+EoY2xb/lgpWcFDOiBS8cpjcMITBkK5T16MTsNI4hN
	dAw97qN0sgmtzHWyFbE8J7Tm/jnXwayvwasRXz4vR1UyEfHMfyxoqyyuoONON2gecy5c=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uIUom-00DcwT-OV; Fri, 23 May 2025 18:00:20 +0200
Date: Fri, 23 May 2025 18:00:20 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	"Chester A. Unal" <chester.a.unal@arinc9.com>,
	Daniel Golle <daniel@makrotopia.org>,
	DENG Qingfang <dqfext@gmail.com>,
	Sean Wang <sean.wang@mediatek.com>,
	SkyLake Huang <SkyLake.Huang@mediatek.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	=?utf-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>,
	Landen Chao <Landen.Chao@mediatek.com>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [net-next PATCH 2/3] net: dsa: mt7530: Add AN7583 support
Message-ID: <a4366913-2368-4d59-b3c0-4c534c9b2c4d@lunn.ch>
References: <20250522165313.6411-1-ansuelsmth@gmail.com>
 <20250522165313.6411-3-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250522165313.6411-3-ansuelsmth@gmail.com>

On Thu, May 22, 2025 at 06:53:10PM +0200, Christian Marangi wrote:
> Add Airoha AN7583 Switch support. This is based on Airoha EN7581 that is
> based on Mediatek MT7988 Switch.
> 
> Airoha AN7583 require additional tweak to the GEPHY_CONN_CFG register to
> make the internal PHY work.
> 
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

