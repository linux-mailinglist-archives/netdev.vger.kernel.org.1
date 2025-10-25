Return-Path: <netdev+bounces-232932-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CF865C09F89
	for <lists+netdev@lfdr.de>; Sat, 25 Oct 2025 22:16:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 15BF83B54C3
	for <lists+netdev@lfdr.de>; Sat, 25 Oct 2025 20:16:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 199EA2236FA;
	Sat, 25 Oct 2025 20:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="U/V2H4wL"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B00E1B21BF;
	Sat, 25 Oct 2025 20:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761423385; cv=none; b=ryqLnZTZD8tcPoHziE49nbXxTrrtmDt3veiy2yruVzFMdYx4uwdEHCSXKO53z3Cj5C2CZtSq9erawiUudyVdnFFycuUwyqXiN6SpK0+LhDSZi+gaYuNTolX1Hhqwlgctv0oqucv1LC+5UxHYI0md5nLtwB5Bhu9t3Y/TjPQsqDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761423385; c=relaxed/simple;
	bh=3Afwb71zb1N6myVjjYA6hFJn7w96SA4V6GHPeTeeinQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ASwimEmGXlMDbMEwLS3hvWWiPeMDMDWPxbGGymT8HvtCJ6fxY+hyZoEDvq9fIj3cItKe9VuXqwmjgVEOsp8ylxAdGODvKJyEZ2IVwWaNDfKevJcS7FCIBGgWoiCS8a6ZKay2bSHK127JhEZRCOeaSJ38DjTC4xRxGOW+LV4r8mg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=U/V2H4wL; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=ptu2lvAsmWbC1+GZWzVeaN9l6JpASXp+9xS7Tt431pM=; b=U/V2H4wLHjel/cldkoeg/9W0kC
	6l3Ry//gLoRAU9tuQQMmhG40KB4x86aaVnRZMo0STSKIvlz7qiVrCyrRdOes50I/THhe085VosR3b
	nCxAhCPm6DlGyJrWO4/n0uYdde7ay6mxlj8EqoXJFh2w0IdN6168kG5O6XXciYxzozQZjzyxSYWlc
	M65RIIDC3ONYLqIEE9PsXdVd0BsgicbXtrdsIn9vk7pWaO10Ams02NEWw8jFJP+w4P9/i9+wAzw4s
	0UtuyI1zglmGfv42q5vuTDgyGbdfx6o35jXycw1JNMS8N2oLJswaDYUpivPyMLVohfQPydoYlxRoq
	Sk8yLVuQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:43932)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1vCkgV-000000000NQ-0BUf;
	Sat, 25 Oct 2025 21:16:19 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1vCkgS-000000003zC-3YM2;
	Sat, 25 Oct 2025 21:16:16 +0100
Date: Sat, 25 Oct 2025 21:16:16 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: David Yang <mmyangfl@gmail.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 4/4] net: dsa: yt921x: Add LAG offloading
 support
Message-ID: <aP0wEBobQm0MQo4I@shell.armlinux.org.uk>
References: <20251025170606.1937327-1-mmyangfl@gmail.com>
 <20251025170606.1937327-5-mmyangfl@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251025170606.1937327-5-mmyangfl@gmail.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Sun, Oct 26, 2025 at 01:05:27AM +0800, David Yang wrote:
> +static int
> +yt921x_dsa_port_lag_check(struct dsa_switch *ds, struct dsa_lag lag,
> +			  struct netdev_lag_upper_info *info,
> +			  struct netlink_ext_ack *extack)
> +{
> +	struct dsa_port *dp;
> +	unsigned int members;

Reverse christmas-tree order please.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

