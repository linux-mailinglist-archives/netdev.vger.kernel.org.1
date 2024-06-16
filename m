Return-Path: <netdev+bounces-103850-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E7699909E2A
	for <lists+netdev@lfdr.de>; Sun, 16 Jun 2024 17:36:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E55A28142F
	for <lists+netdev@lfdr.de>; Sun, 16 Jun 2024 15:36:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0A031095B;
	Sun, 16 Jun 2024 15:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="vWmkIGWe"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A8E0ECF;
	Sun, 16 Jun 2024 15:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718552161; cv=none; b=SPo1ZGObERtRkhyoRhW7jyzOQZkCfsMkQm4HnuEgZ/4hNGm/9AQ+iaM2s0sMUwaFMGYQkYGypznHtKHO+EC38lDCShYJ8ECYeshPCzCkIiXCJxfcJlsUoz7ckHrS5/tiZPPIrpuFpManFCo7swuiLL36a5pTTTRqjdziIip19Vs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718552161; c=relaxed/simple;
	bh=LOI867/+QyASPFl05QqM8rdNaj3xPQj92rpYPHp0V/M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uBGnLoildD3oOdm8ndAf9gKgh8U+njmwtOEtlePjsxb6VSeW5xW5Iq8TnW9Q3aKwPSprp+HtoB1fqCzL+zuftm/tE9mSgnMHXKGPTd+EWxteoHWYeHQno3OhIwdd1WkXyXKyvRuE9SKE7AomJ+waYcJD8fCey4nfTja4alvfYms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=vWmkIGWe; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=CzgUYlbwpAE7jfJG5Wq5ME+fPoSlySfMs6W+eYQNnaI=; b=vWmkIGWewCwx6GcJleZj4n7Q/q
	/r4y9PA8YSdD7Fu2GUNK0DH1Fm7DAbipBVkbVcczFnaZhOiReYm8cWth5bVEV5kwV9ho6RhEOLlx5
	PI/r27HWfDnHJKcnB0rWH3LReDyIrbo61cxA36REky69wMwQkV6vXBxVlWF05oj6N0Y8=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sIrv2-000BgU-Kq; Sun, 16 Jun 2024 17:35:48 +0200
Date: Sun, 16 Jun 2024 17:35:48 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Matthias Schiffer <mschiffer@universe-factory.net>
Cc: =?utf-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Daniel Golle <daniel@makrotopia.org>,
	DENG Qingfang <dqfext@gmail.com>,
	Sean Wang <sean.wang@mediatek.com>
Subject: Re: [PATCH net-next 2/2] net: dsa: mt7530: add support for bridge
 port isolation
Message-ID: <0dcdf71c-8b47-4490-bee2-8551c75f19e0@lunn.ch>
References: <378bc964b49f9e9954336e99009932ac22bfe172.1718400508.git.mschiffer@universe-factory.net>
 <15263cb9bbc63d5cc66428e7438e0b5324306aa4.1718400508.git.mschiffer@universe-factory.net>
 <4eaf2bcb-4fad-4211-a48e-079a5c2a6767@arinc9.com>
 <8b80f4c7-a6bc-4ac9-bee4-9a36e70a6474@universe-factory.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8b80f4c7-a6bc-4ac9-bee4-9a36e70a6474@universe-factory.net>

> As far as I can tell, the rules are:
> 
> - non-isolated ports can communicate with every port
> - isolated ports can't communicate with other isolated ports
> - communication is symmetric

It is a bit more subtle than that.

By default, all ports should be isolated. They can exchange packets
with the CPU port, but nothing else. This goes back to the model of
switches just look like a bunch of netdev interfaces. By default,
linux netdev interfaces are standalone. You need to add a bridge
before packets can flow between ports.

Once you add a bridge, ports within that bridge can exchange
packets. However, there can be multiple bridges. So a port needs to be
isolated from ports in another bridge, but non-isolated to ports
within the same bridge.

       Andrew

