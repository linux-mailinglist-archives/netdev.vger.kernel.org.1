Return-Path: <netdev+bounces-102199-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D002901DF0
	for <lists+netdev@lfdr.de>; Mon, 10 Jun 2024 11:16:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 04DDD280F5B
	for <lists+netdev@lfdr.de>; Mon, 10 Jun 2024 09:16:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF5CD74054;
	Mon, 10 Jun 2024 09:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="aYT+xqOM"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 485E518C31
	for <netdev@vger.kernel.org>; Mon, 10 Jun 2024 09:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718011007; cv=none; b=qlpZVc2nMvnCDeniiKHwiSugcFXOPmeDpaQNQjnvIkJK0FqcJGnQoih7Lc9MSAjvQxoxEo22bCbBhgCYLw32UZb5BmUVheCbRi8VIkRKceJ1vBNM/wfeWeYQvsjJxXA2nUMZ5DQylg0jXaN1NYAgJ93aTTZVxKKV01pkAjlpANw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718011007; c=relaxed/simple;
	bh=R8putuANeMom2KWkTIAXljKxoh8gGh2IOBJmBybdgRQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hPG/5C+lrazHmmo8jm7GlSov+GbCn0L6RqmktkZ6ju+D9hD00nMxh0LMtGiPr+ZvQQygcT/4jv/M3mmmoSOM4vz7q7palm7oRnnhhooHhF4Dg0SdC9Y97xd5FdkNN689H0FDQBLnNjkb2L9GCr5ixGil5JeWcFUHOTsriRHxZ4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=aYT+xqOM; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=cm5RXgxrGyPx0HOxnj0oADHLpbubFzGyui01dq/eV+M=; b=aYT+xqOMm+MujVFCcpmFNmy578
	TZcFmLK5hZ+5E2C1Yxnh9/hB8Uscvw7lDygmSQiSEZSVQN8veiUgHamVOpCSvvmTQqRoLno+P7SXe
	Pa3TgT7KxaDVZ2Hr4pKozzH/9l84aU20hSSHxgboUyKaqkng7Sv3G+bCzr04bU/A0Wt18IpiEBtai
	QoHMnocJlztKS2UgS6JiYXMqiLg5N7qC+hBQyutJFjyzeDYZ3CXQSrlJfIFodTTEyHw4rId6s2LCx
	N4RwKLvxQxHcsQqd81urbHiD8FW7D7xTGULLFdXCPZ37COcquJ/MmVyBOvc6RqoHTi8FaG91mC/6e
	QGgnIsAw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:59778)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1sGb8e-0001DJ-2T;
	Mon, 10 Jun 2024 10:16:28 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1sGb8e-0006lD-BD; Mon, 10 Jun 2024 10:16:28 +0100
Date: Mon, 10 Jun 2024 10:16:28 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Andrew Halaney <ahalaney@redhat.com>
Cc: Serge Semin <fancer.lancer@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH RFC net-next v2 1/8] net: stmmac: add infrastructure for
 hwifs to provide PCS
Message-ID: <ZmbEbIQY+6c/qadI@shell.armlinux.org.uk>
References: <Zlmzu7/ANyZxOOQL@shell.armlinux.org.uk>
 <E1sD0Ol-00EzBh-3f@rmk-PC.armlinux.org.uk>
 <gyiomer5eqxtq7q7zo5lwtokvdugs4jlb3nux3ry6xf5j27wtp@wl6s643vbn75>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <gyiomer5eqxtq7q7zo5lwtokvdugs4jlb3nux3ry6xf5j27wtp@wl6s643vbn75>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Wed, Jun 05, 2024 at 02:57:34PM -0500, Andrew Halaney wrote:
> On Fri, May 31, 2024 at 12:26:15PM GMT, Russell King (Oracle) wrote:
> > @@ -310,6 +315,9 @@ struct stmmac_ops {
> >  	void (*core_init)(struct mac_device_info *hw, struct net_device *dev);
> >  	/* Update MAC capabilities */
> >  	void (*update_caps)(struct stmmac_priv *priv);
> > +	/* Get phylink PCS (for MAC */
> 
> nit: unclosed parenthesis

Please learn to trim your review replies so your patch submitters don't
have to waste time scroll through lots of useless context. This has
been part of good netiquette for decades. Thanks.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

