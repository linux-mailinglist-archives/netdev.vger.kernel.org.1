Return-Path: <netdev+bounces-258917-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SGYbImY8k2kg2wEAu9opvQ
	(envelope-from <netdev+bounces-258917-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 16 Feb 2026 16:48:54 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AE63F145C3F
	for <lists+netdev@lfdr.de>; Mon, 16 Feb 2026 16:48:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5F40C3001047
	for <lists+netdev@lfdr.de>; Mon, 16 Feb 2026 15:48:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EE35310644;
	Mon, 16 Feb 2026 15:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="rI2tUXye"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 661C22690EC;
	Mon, 16 Feb 2026 15:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771256929; cv=none; b=Aqv7GCvAcnlWbgyACyljk9GukG1yg2n6vUUm1u+5PAsl+gvF6Q41uOgLwgL/xYbvRV9gsJedEh4h3jah0T8NGZf2BNhImBfNaaaglCd+1uEh9RbhMwdUkZ4AcOCyj8nelFRAIeIn6rGw0vZvHTq+aEQlLbs1rH3vq3jT42E3J2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771256929; c=relaxed/simple;
	bh=q+g/DlkJNq74PkDhASSFNfZPUvOBH5818ThhmdshVsk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lDIpZ7CIOjHFiStacNkUrllpvBjHuSkSmjpfs0ljWvUcU0dCqy0kq0/0qY7FFehrYnxssN99NdouYBhqdcE2lZJjq0nBMAdlDrjIoRFaYrW+B94U0UoSEPxaDarnt3l8RlwwMlzfg2NywgkHvMsSBskK/w6P/SrmGoteQmb/NL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=rI2tUXye; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=aSeE11hwULDq1Qr2S0vwgJhcVhLNVAv9uROXpPzDh+s=; b=rI2tUXyeeBZZjXVwiBZvt4GiGS
	02n4dK2eJnvWLYlxm+8UAkFMSvbiWu6+T4X/3ciBZffmyv4uSsDAKpZ9f38wk6Ekh2W+Eq7Dr3Q9O
	jB8chtJY7vZyeWSFNvkSI5jH+oja7Ezy1kh8GvNBVAIg5CuLUQvz44VQkksjdepKlttM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vs0pp-007Vn1-VN; Mon, 16 Feb 2026 16:48:29 +0100
Date: Mon, 16 Feb 2026 16:48:29 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Yao Zi <me@ziyao.cc>
Cc: "Russell King (Oracle)" <linux@armlinux.org.uk>,
	Heiko Stuebner <heiko@sntech.de>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, netdev@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
Subject: Re: Problematic understanding of phy-mode in Rockchip DWMAC driver
Message-ID: <90322c98-802f-4c88-8684-568f352d424f@lunn.ch>
References: <aY9s5PXP4zZ7R6fa@pie>
 <aY9xsslT56D9LGLe@shell.armlinux.org.uk>
 <aZKgq0-aptu-PnsB@pie>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aZKgq0-aptu-PnsB@pie>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-258917-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	FREEMAIL_CC(0.00)[armlinux.org.uk,sntech.de,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,lists.infradead.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[lunn.ch:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev,dt];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: AE63F145C3F
X-Rspamd-Action: no action

On Mon, Feb 16, 2026 at 04:44:27AM +0000, Yao Zi wrote:
> On Fri, Feb 13, 2026 at 06:47:14PM +0000, Russell King (Oracle) wrote:
> > On Fri, Feb 13, 2026 at 06:26:44PM +0000, Yao Zi wrote:
> > > Hi folks,
> > > 
> > > I was looking through the RGMII delay setup logic found in
> > > rk_gmac_powerup() of dwmac-rk.c, and found its behavior is strange,
> > 
> > dwmac-rk is very broken and is unfixable thanks to Rockchip not
> > understanding the RGMII interface modes used by the kernel.
> > 
> > It is what it is, we can't change it without causing regressions.
> > Please do not try to fix it.
> 
> Thanks for confirming. I understand concerns about regressions and
> agree keeping the driver/dts as-is is better.
> 
> However, should we mention the difference between "phy-mode" defined
> ethernet-controller.yaml and "phy-mode" understood by dwmac-rk
> driver in rockchip-dwmac.yaml to avoid confusion in the future?

I've been telling DT developers to set the correct phy-mode,
'rgmii-id', and the vendor properties for MAC delays to 0. That works,
and it consistent with the documentation.

As far as i know, dwmac-rk only gets things wrong when you try to get
the MAC to add the 2ns delays. And that is not a recommended
configuration. So i don't think it is too important to document a not
recommended configuration is broken.

	Andrew

