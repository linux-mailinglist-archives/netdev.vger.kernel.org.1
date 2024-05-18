Return-Path: <netdev+bounces-97119-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A4AE8C92FA
	for <lists+netdev@lfdr.de>; Sun, 19 May 2024 00:04:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 20A2FB20D29
	for <lists+netdev@lfdr.de>; Sat, 18 May 2024 22:04:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D640760DD3;
	Sat, 18 May 2024 22:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="M4GnTiCD"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C2238F49
	for <netdev@vger.kernel.org>; Sat, 18 May 2024 22:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716069860; cv=none; b=czSw0KuFzmjqg/D8JyDGdP6tK+CM21hx9Ja7H/+ujZSrG98rgogueTIZzWqPkdtG8fnjzpDTWnMFTS/NiDS+cquVc3/X+Kr68tCKld/oOL6U4z/zMng7PYKzDi852mqFxjTNUoQa84AcoNL7WKqY8JzobjNyyuQ0FJYSoVsDICU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716069860; c=relaxed/simple;
	bh=VeBjcltzMKut8sOCnhgTsPC8aek4JCcQturkwx8EwQc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VClAiTH7BKXlOmITRlnI5DO9dk/3U5jNYjITlXjDNHMEf2hYkx89WUkDclHS+lWH4kmLHl+9RDAvzlMwTKPmekJkxYWCkKd69Z4nKUyBvzlH40XComTzpTfHIIg+GQThfPquh8I/cl0wakSX0BgZAd6fyEfVXVTkmAiDHMCXLbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=M4GnTiCD; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=G8cWDYjIfjfaOL6wCijQz3MHT+A2ObWAp2AqjG8z69k=; b=M4GnTiCDTqucskAlonP8Y1KRr4
	99XcFq+M+qOaXqFlkD4i34NqQ8hJXeSzcR0udy5IpPaDaN3ftTPd62ho4Hnt7oUKw/TtTnVC9C721
	xqKROtnL9dtqMWG2b6ucCqjj7d07VhIF+ktSI5YS7qREZqR0B8RCTHKzGgNpGW2Ekv8o=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1s8S9t-00FdV9-87; Sun, 19 May 2024 00:04:05 +0200
Date: Sun, 19 May 2024 00:04:05 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Alexey Dobriyan <adobriyan@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Subject: Re: [PATCH] net: set struct net_device::name earlier
Message-ID: <1c1dd2da-9541-4d9c-a302-0a961862cedd@lunn.ch>
References: <d116cbdb-4dc5-484a-b53b-fec50f8ef2bf@p183>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d116cbdb-4dc5-484a-b53b-fec50f8ef2bf@p183>

On Sat, May 18, 2024 at 11:24:57PM +0300, Alexey Dobriyan wrote:
> I've tried debugging networking allocations with bpftrace and doing
> 
> 	$dev = (struct net_device*)arg0;
> 	printf("dev %s\n", $dev->name);
> 
> doesn't print anything useful in functions called right after netdevice
> allocation. The reason is very simple: dev->name has not been set yet.
> 
> Make name copying much earlier for smoother debugging experience.

Does this really help? Instead of "" don't you get "eth%d"? The
expansion of the %d to eth42 does not happen until you register the
netdev.

	Andrew

