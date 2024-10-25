Return-Path: <netdev+bounces-139104-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C2AF9B038D
	for <lists+netdev@lfdr.de>; Fri, 25 Oct 2024 15:14:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BDFBA1C21513
	for <lists+netdev@lfdr.de>; Fri, 25 Oct 2024 13:14:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CA8B1632E2;
	Fri, 25 Oct 2024 13:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="uKWDdZ4e"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB2441632C3
	for <netdev@vger.kernel.org>; Fri, 25 Oct 2024 13:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729862082; cv=none; b=gQ6gUAOrf9Ajjx24F8xCbZsCY1q6Dsi+2ekQUfI3AgIwtkPC8HcfOwuSk/A9PfO27kfvlQqFxDxLhtndQ5cYkBX5asfhciEA/BmX2SClXpA/TyjpHgaXks04WS984KCllMeCyTh9YrewmzOjkYOrgiMoeVhE7IzBY3ys2swt7Lo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729862082; c=relaxed/simple;
	bh=taRvG3mbZWxhJomxNtS32je7kOgknZwcuG9rcEnnrTY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HnWjtXUfnRtyZLjLullDcSH3XXvYKYN0X2NjPmjgyj72eH5syhxmPOzGZtIAZr7skm0/NPxxfMH0f0+TBuTLpJJgYJZwCstsoU3QNpRYAKtlxwv0LjdeUk7Mp+YEh2IsF5+yIkWMsmqoBRHlfjWFLG8tC021aOwjnYnYEVwYYY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=uKWDdZ4e; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=6Lox/9z3qadAmzLbl7a2i3kRFRJoSJ6miROGpQapL44=; b=uK
	WDdZ4eL/E35tvvgvoLOi9Jh5QpQJ7FrVHlpH5A+uY7pe4pdBV5a2K6cwMJ/urVv45IyBOm7GinAJN
	oW1rpNOnvqAn5g2X3U415ozr6OTKDbcqh3PFVLvO+k3cFjIELPTfRjEFhBXSe3vjRZ+rXhXK3fXP4
	WRoe7LWWfvvSl6o=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1t4K94-00BFNK-1K; Fri, 25 Oct 2024 15:14:26 +0200
Date: Fri, 25 Oct 2024 15:14:26 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: "zhangzekun (A)" <zhangzekun11@huawei.com>
Cc: justin.chen@broadcom.com, florian.fainelli@broadcom.com,
	andrew+netdev@lunn.ch, davem@davemloft.net, o.rempel@pengutronix.de,
	kory.maincent@bootlin.com, horms@kernel.org, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
	chenjun102@huawei.com
Subject: Re: [PATCH net 1/2] net: bcmasp: Add missing of_node_get() before
 of_find_node_by_name()
Message-ID: <0c9ea6c2-535d-4ce8-aea1-7523b5304635@lunn.ch>
References: <20241024015909.58654-1-zhangzekun11@huawei.com>
 <20241024015909.58654-2-zhangzekun11@huawei.com>
 <d3c3c6b5-499a-4890-9829-ae39022fec87@lunn.ch>
 <9ed41df0-7d35-4f64-87d7-e0717d9c172b@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9ed41df0-7d35-4f64-87d7-e0717d9c172b@huawei.com>

On Fri, Oct 25, 2024 at 10:41:22AM +0800, zhangzekun (A) wrote:
> 
> 
> 在 2024/10/24 19:56, Andrew Lunn 写道:
> > On Thu, Oct 24, 2024 at 09:59:08AM +0800, Zhang Zekun wrote:
> > > of_find_node_by_name() will decrease the refcount of the device_node.
> > > So, get the device_node before passing to it.
> > 
> > This seems like an odd design. Why does it decrement the reference
> > count?
> > 
> > Rather than adding missing of_node_get() everywhere, should we be
> > thinking about the design and fixing it to be more logical?
> > 
> > 	Andrew
> 
> Hi, Andrew,
> 
> of_find* API is used as a iterater of the for loop defined in
> "include/linux/of.h", which is already wildly used. I think is reasonable to
> put the previous node when implement a loop, besides, the functionality has
> been documented before the definiton of of_find* APIs.
> The logical change of these series of APIs would require a large number of
> conversions in the driver subsys, and I don't think it it necessary.

Do you have a rough idea how many missing gets there are because of
this poor design?

A quick back of the envelope analysis, which will be inaccurate...

$ grep -r of_find_node_by_name | wc
     68     348    5154

Now, a lot of these pass NULL as the node pointer:

$ grep -r of_find_node_by_name | grep NULL | wc
     47     232    3456

so there are only about 20 call sites which are interesting. Have you
looked at them all?

What percentage of these are not in a loop and hence don't want the
decrement?

What percentage are broken?

We have to assume a similar number of new instances will also be
broken, so you have an endless job of fixing these new broken cases as
they are added.

If you found that 15 of the 20 are broken, it makes little difference
changing the call to one which is not broken by design. If it is only
5 from 20 which are broken, then yes, it might be considered pointless
churn changing them all, and you have a little job for life...

	Andrew

