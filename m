Return-Path: <netdev+bounces-104095-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 82B1090B322
	for <lists+netdev@lfdr.de>; Mon, 17 Jun 2024 16:59:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 03F572856CE
	for <lists+netdev@lfdr.de>; Mon, 17 Jun 2024 14:59:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8376313A3EE;
	Mon, 17 Jun 2024 14:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="hcBRiCYn"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4399713A3E8;
	Mon, 17 Jun 2024 14:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718633274; cv=none; b=gQ1FNjCISo9gE72fEE5v21fwnd6/fVcpWWlQXSfWpKnukel2UKgjX+vAIVC7h4U+HSE6RHgjvieVpxbNkyESfAbMtmg2Km7XByz/RIqCrdFSivZwgi0WTV9tQWHYd7tCbmDCslDnFj+enL9M0fLCt57oxG37DBMQieZQ3mmQqWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718633274; c=relaxed/simple;
	bh=oOL+cR0NelQJ7T8PuJAtqUNS6iyKbFEbFFisE1Sv3Vo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kq1n6go7hxy7I0CaA1sr8YpB+4OucvlKGYJ7HYijlruy6CZ/AFSp76Ajv5BnOY2AOM3tAkGY/Hy4ncIY94lWFSChH4qot7cWluwzuol3xxjyodqGrAxYIvZqL3E+Qct5fjmqA2PGB4rY3y45TdS0Q3R1MG2W0YH7xArv615Mxu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=hcBRiCYn; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=s4pZXybdfEbiEYROzl0ZJRhyHT6yQIYzmvYkpxFhIbk=; b=hcBRiCYncwXqNHy0tmkzHWKEug
	TNmUb3tUoW41kzQhBuxvp8cSC7QoUwJeWxmlQBjrsVp1Mjx8ffYWzEetF4uWdtDr837uZtWJlpJNy
	7uARx8lPtTzgBx3WC8UlKCBqJYv0qwXCWOaQXe7hmylJ/ac6ItY4AqzEZQRkAlXCbGrc=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sJD1N-000H9J-5N; Mon, 17 Jun 2024 16:07:45 +0200
Date: Mon, 17 Jun 2024 16:07:45 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Justin Lai <justinlai0215@realtek.com>
Cc: Jakub Kicinski <kuba@kernel.org>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"jiri@resnulli.us" <jiri@resnulli.us>,
	"horms@kernel.org" <horms@kernel.org>,
	"rkannoth@marvell.com" <rkannoth@marvell.com>,
	Ping-Ke Shih <pkshih@realtek.com>,
	Larry Chiu <larry.chiu@realtek.com>
Subject: Re: [PATCH net-next v20 10/13] rtase: Implement ethtool function
Message-ID: <94c758fc-cfcf-4a11-95b6-ca57cc85ed3e@lunn.ch>
References: <20240607084321.7254-1-justinlai0215@realtek.com>
 <20240607084321.7254-11-justinlai0215@realtek.com>
 <20240612173505.095c4117@kernel.org>
 <82ea81963af9482aa45d0463a21956b5@realtek.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <82ea81963af9482aa45d0463a21956b5@realtek.com>

> > > +     strscpy(drvinfo->bus_info, pci_name(tp->pdev), 32);
> > 
> > Can you double check that overwriting these fields is actually needed?
> > I think core will fill this in for you in ethtool_get_drvinfo()
> 
> I have removed this line of code for testing. Before removing the code,
> I could obtain bus info by entering "ethtool -i". However, after removing
> the code, entering "ethtool -i" no longer retrieves the bus info.

https://elixir.bootlin.com/linux/latest/source/net/ethtool/ioctl.c#L710

	if (ops->get_drvinfo) {
		ops->get_drvinfo(dev, &rsp->info);
		if (!rsp->info.bus_info[0] && parent)
			strscpy(rsp->info.bus_info, dev_name(parent),
				sizeof(rsp->info.bus_info));

This suggests you have not set the parent device.

	Andrew

