Return-Path: <netdev+bounces-132552-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CE59199219F
	for <lists+netdev@lfdr.de>; Sun,  6 Oct 2024 23:20:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 90A342810C7
	for <lists+netdev@lfdr.de>; Sun,  6 Oct 2024 21:20:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3F5218A920;
	Sun,  6 Oct 2024 21:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="pcbedZ9p"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ECE1189B86;
	Sun,  6 Oct 2024 21:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728249613; cv=none; b=V8/1GQS1kc+eQN6lr2PgMCIfinrdDzjtgu4LPl1RO1o8BdES2fMA2fA+AOBtis0Zm7LhKXC+s/eZ6e/5LxOKIvL28oYoqACjBiNKA/T2KfhA3B2qau7no78N1ExomuEskhlVywty6xVxcqKKlok70aRnPGUfs3CzICsQcxvWUXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728249613; c=relaxed/simple;
	bh=QRfSmV23SvySzYBCBzki9/e2ijPl/XrMNV5TFw6xwlI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VQBP9w0q1TSSE35mGBtYFtxfkre+Jv7rydVIqKdhzxovyoUM14KXO6sNd/PCTs9fqmKncZ7W3DTaLp2FfaKheyPPX/qxLE6hT0LuxvbDw6qtw781uWPdirrsYtKf9K+GZyqyilWCybeYm5xNZprfdeGRy1SdxWzSEkVcOGNiYB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=pcbedZ9p; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=qC7y0ivdnQi0t2L4Lgh5EegrEHGLmC38c5XXEgB6rNk=; b=pcbedZ9pnaG5r0FZ5/zVtwFxJO
	chwX+6opJDfgMWnNiA8vunfhR25hXiwgDDY7jCe3TP8ZP9Nz4KXvUDdsKZhUEpZzjem32AkbWSLSx
	Jo8kMETxKGe1pZOizbyxRI5d8kcrHzTOeaIRjAV0nXvzQGjrbBGKd4/882pRwvH8J5fc=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sxYfY-009CyC-TX; Sun, 06 Oct 2024 23:20:00 +0200
Date: Sun, 6 Oct 2024 23:20:00 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Sky Huang <SkyLake.Huang@mediatek.com>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Daniel Golle <daniel@makrotopia.org>,
	Qingfang Deng <dqfext@gmail.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Steven Liu <Steven.Liu@mediatek.com>
Subject: Re: [PATCH net-next 2/9] net: phy: mediatek: Fix spelling errors and
 rearrange variables
Message-ID: <8bf8b406-8302-4e74-8197-88f9aa76c28e@lunn.ch>
References: <20241004102413.5838-1-SkyLake.Huang@mediatek.com>
 <20241004102413.5838-3-SkyLake.Huang@mediatek.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241004102413.5838-3-SkyLake.Huang@mediatek.com>

On Fri, Oct 04, 2024 at 06:24:06PM +0800, Sky Huang wrote:
> From: "SkyLake.Huang" <skylake.huang@mediatek.com>
> 
> This patch fixes spelling errors which comes from mediatek-ge-soc.c and
> rearrange variables with reverse Xmas tree order.
> 
> Signed-off-by: SkyLake.Huang <skylake.huang@mediatek.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

