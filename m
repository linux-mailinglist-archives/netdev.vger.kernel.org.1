Return-Path: <netdev+bounces-215724-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ECBAAB300B5
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 19:04:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D54A1587E1C
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 17:04:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B9332FB624;
	Thu, 21 Aug 2025 17:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="qBdtO3cA"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B16992FB62B;
	Thu, 21 Aug 2025 17:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755795837; cv=none; b=BpZ5v7vUiIPikkyuqt2h2ZmjVJOljGWlyXs8IkcprcExX604CpHya1vI4FjQcNvfPzSicCIZvArHkZlUHqxF0SnkczJDO8EIEpPd0JKm/SJuWV6dxf4CEhDftrhDpsG1fVl7qs+RWkuYp0+MYYgRceCZtdqgUOdhiHd9oZhcbQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755795837; c=relaxed/simple;
	bh=zST2lgy3sN3VlnQjMfYCnDBwSTsHCfLZY52u/GQApsU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VJnqKDHRB5jJ2LYIYzeSNHO4lVfe6NUBopy8kJfxJhgTh0hJYVrzIxHZ45Vm+wi4SZlv8xc5WqMAePqyzxScu/+j318ZWQUYDN+8cuShJ4gOOriTiLxQH6ypuRw/18n8T6H7EVEx1qL9sYtco611IZ2VHEOfZJ6JM0qMQU35vZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=qBdtO3cA; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=FsQ6glM8E2Fm3GYBU8rO+vl9K7vuBOAnCV5mG0HmHPw=; b=qB
	dtO3cAS63s1y0aKe7siuEHqulwQJlnXsrOJNHBp3D0tqG5u/qDXmAmY2Wu5KT/LN7XMo5euT+50lo
	2JHExIpUIL/m3Pb/GQ2pIQF0HGJLd2+CXniQ/EQVK6Xu6r2mRQ0RuJWS5hAKryuoJiIBXwA+fHu3Q
	GhdYH4Ju8aV537s=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1up8hL-005ThV-Lf; Thu, 21 Aug 2025 19:03:35 +0200
Date: Thu, 21 Aug 2025 19:03:35 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: "Sverdlin, Alexander" <alexander.sverdlin@siemens.com>
Cc: "hauke@hauke-m.de" <hauke@hauke-m.de>,
	"olteanv@gmail.com" <olteanv@gmail.com>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"linux@armlinux.org.uk" <linux@armlinux.org.uk>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"arkadis@mellanox.com" <arkadis@mellanox.com>,
	"daniel@makrotopia.org" <daniel@makrotopia.org>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"edumazet@google.com" <edumazet@google.com>,
	"f.fainelli@gmail.com" <f.fainelli@gmail.com>,
	"horms@kernel.org" <horms@kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"john@phrozen.org" <john@phrozen.org>,
	"Stockmann, Lukas" <lukas.stockmann@siemens.com>,
	"yweng@maxlinear.com" <yweng@maxlinear.com>,
	"fchan@maxlinear.com" <fchan@maxlinear.com>,
	"lxu@maxlinear.com" <lxu@maxlinear.com>,
	"jpovazanec@maxlinear.com" <jpovazanec@maxlinear.com>,
	"Schirm, Andreas" <andreas.schirm@siemens.com>,
	"Christen, Peter" <peter.christen@siemens.com>,
	"ajayaraman@maxlinear.com" <ajayaraman@maxlinear.com>,
	"bxu@maxlinear.com" <bxu@maxlinear.com>,
	"lrosu@maxlinear.com" <lrosu@maxlinear.com>
Subject: Re: [PATCH RFC net-next 12/23] net: dsa: lantiq_gswip: support 4k
 VLANs on API 2.2 or later
Message-ID: <dfb11982-5a7f-495c-8b25-aa1365ab8fe9@lunn.ch>
References: <aKDhwYPptuC94u-f@pidgin.makrotopia.org>
 <88bdaad0bb744dc401e94d97aba002431ac0b03b.camel@siemens.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <88bdaad0bb744dc401e94d97aba002431ac0b03b.camel@siemens.com>

> > @@ -269,7 +270,8 @@ struct gswip_priv {
> >  	struct dsa_switch *ds;
> >  	struct device *dev;
> >  	struct regmap *rcu_regmap;
> > -	struct gswip_vlan vlans[64];
> > +	struct gswip_vlan (*vlans)[];
> 
> ... if this would be just "struct gswip_vlan *vlans;"?

Could it be moved to the end of the structure and made into an
flexible array?

	Andrew

