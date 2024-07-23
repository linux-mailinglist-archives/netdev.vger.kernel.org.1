Return-Path: <netdev+bounces-112656-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D169593A681
	for <lists+netdev@lfdr.de>; Tue, 23 Jul 2024 20:36:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C4822834DB
	for <lists+netdev@lfdr.de>; Tue, 23 Jul 2024 18:36:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5972A157A61;
	Tue, 23 Jul 2024 18:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="u3qZNtTv"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AED91586C4;
	Tue, 23 Jul 2024 18:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721759743; cv=none; b=BXTha9qeFiW/ReW5CE2a96f9Dc9pr8j1fS34H+ypsgbfQs9W0CSBO/rnLusOLXVpqB6JQfBcpZxvBGaJpRuGkOt/ADCpTRrmXI3S2/hx9RHwskJ5uDpXo5pknT/8tkDVQaVlA3ALsWA7ZhJBARckfngurNBtpwrGTa1woCCuKvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721759743; c=relaxed/simple;
	bh=j1yG04/Y6ABv4sOsIEu+Kk3XIVdtRL5syAZ9Q9Un/ck=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N4Ss6Bz4AsstmgiTAzG+LWqDrMbmWV/1UYPVsF+/FNqsmJ+E3s2CkVtLijYf+Q1HaKJcZbS/tzZbGmUyKhmyFc6gEAlfvrX9EdNzLC2SqwYU5g0Zs3hrU7SH/qb59nfWhTwqFd9XYGw8CqXDWXuTlLIYJzHUzGxOZaMS/qT8xgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=u3qZNtTv; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=dP9Q0gxDLP4kvOdzSqHu4jLBkTIETDjf8rYJB3V64qQ=; b=u3qZNtTv/d2J7bsIQ3DZZpuQgx
	3CWzZzrWdGtnNZs3nav8CcEDj5dF6HHfP5UuynlfG60Sr1p0BaevwTiaKLmVrmYEsD3bZ0oG8TFLY
	4nwPo6tFIRLvbeESw/abfgzqbr/cZT0mgQlM6GeTXixZPp5UAsuaczlCKIgf7Hn4cLtk=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sWKM0-0035EM-DW; Tue, 23 Jul 2024 20:35:16 +0200
Date: Tue, 23 Jul 2024 20:35:16 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Daniel Golle <daniel@makrotopia.org>
Cc: Felix Fietkau <nbd@nbd.name>, Sean Wang <sean.wang@mediatek.com>,
	Mark Lee <Mark-MC.Lee@mediatek.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH net] net: ethernet: mtk_eth_soc: drop clocks unused by
 Ethernet driver
Message-ID: <125775a6-42f2-4294-9593-518ad6c852f7@lunn.ch>
References: <38559102c729a811dc8a85f6c7cee07228cffd3e.1721739769.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <38559102c729a811dc8a85f6c7cee07228cffd3e.1721739769.git.daniel@makrotopia.org>

On Tue, Jul 23, 2024 at 02:04:02PM +0100, Daniel Golle wrote:
> Clocks for SerDes and PHY are going to be handled by standalone drivers
> for each of those hardware components. Drop them from the Ethernet driver.

Please could you explain in more details how this does not break
backwards compatibility. Should there also be a depends on, to ensure
the new driver is loaded? Will old DT blobs still work?

Thanks
	Andrew

