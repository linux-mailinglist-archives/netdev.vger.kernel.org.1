Return-Path: <netdev+bounces-131074-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4525098C7FB
	for <lists+netdev@lfdr.de>; Wed,  2 Oct 2024 00:13:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 692861C2199A
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 22:13:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D9BC1CEAB8;
	Tue,  1 Oct 2024 22:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="s58dyKbt"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82B8E1CDA2F
	for <netdev@vger.kernel.org>; Tue,  1 Oct 2024 22:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727820794; cv=none; b=lAZd1hM90cLMUDHUsr5R8ipKsU6lPbdXinMMcqamYNGJruXyL2QKdN+9O/xHVa/YzNtuMGxpx1XRHIU14Ary2AMrkpq3WkQZI4kqfGq0g/kBTyQiG1X10AB+wvYILuGPTNmoQvNIHuxLrxKQpRUqAZCNdJE7e1hus+eSNOsm7iM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727820794; c=relaxed/simple;
	bh=put866ZVCtc62GJSg31NlbZR9rIKaGC/mOKe/tGAhf0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aohZq8iX3VyqbpOhf4aEszoana8QxnRqfjN3uYkkIaV0vdsuqMA91mrc4DSFi5TDqH+Orv/ERzOrRQLTBTMEaBFRGR+Pma7M6rhOujDTT4N6AUGUi+QouiUY0FW+p59Eo7BMslCNPjDJlkjqxz5OEE2DQ3/JrWIPZ4BH575ybGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=s58dyKbt; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=fHhlytrsq2oceOsHWIaLDAe6z684pIx/Z6+B5LZdVlQ=; b=s58dyKbtPOcl8XIOjmiF80YoEa
	4LIa02Sv7Sm+FHmqEzItHjvO8niiPayMSdg22rhLB5Vtt6TDd2opiaZF/tgJC0wSaf11JYyIDPkaE
	Q3azoOKlC4hZSjQXz4H0qe3Gkm465HgiHo7DYnNh5wPuzw/jdVVOA67Y065KFORHQEJs=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1svl72-008mSM-So; Wed, 02 Oct 2024 00:12:56 +0200
Date: Wed, 2 Oct 2024 00:12:56 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Jiawen Wu <jiawenwu@trustnetic.com>,
	Jose Abreu <joabreu@synopsys.com>,
	Jose Abreu <Jose.Abreu@synopsys.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Mengyuan Lou <mengyuanlou@net-swift.com>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Vladimir Oltean <olteanv@gmail.com>
Subject: Re: [PATCH net-next 05/10] net: wangxun: txgbe: use phylink_pcs
 internally
Message-ID: <efcd446c-16cf-487d-9343-db9ed039235a@lunn.ch>
References: <ZvwdKIp3oYSenGdH@shell.armlinux.org.uk>
 <E1svfMV-005ZIR-FE@rmk-PC.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1svfMV-005ZIR-FE@rmk-PC.armlinux.org.uk>

On Tue, Oct 01, 2024 at 05:04:31PM +0100, Russell King (Oracle) wrote:
> Use xpcs_create_pcs_mdiodev() to create the XPCS instance, storing
> and using the phylink_pcs pointer internally, rather than dw_xpcs.
> Use xpcs_destroy_pcs() to destroy the XPCS instance when we've
> finished with it.
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

It would be good if the net-swift.com people gave a Reviewed-by: or a
Tested-by.

To me, this looks O.K.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

