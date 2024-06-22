Return-Path: <netdev+bounces-105869-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AB462913555
	for <lists+netdev@lfdr.de>; Sat, 22 Jun 2024 19:20:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 428CC1F219C1
	for <lists+netdev@lfdr.de>; Sat, 22 Jun 2024 17:20:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6F67179AF;
	Sat, 22 Jun 2024 17:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="XH+6xX5H"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2199C175A1;
	Sat, 22 Jun 2024 17:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719076849; cv=none; b=DSBbEQCbCJVnvqhUEOzcgmcLuxgnzw5X0bG95LflkZIPz98E3jhCvFVv7YfMolqZVXu8vZeVai4nLc494XruZcQcrYKyTxyv4us1eIMniiFHab8q7w1ZyArqTk6xOabD2uf5CrwhnzntAZSLcxAikgze8P/hBTogGDrJcJ7is9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719076849; c=relaxed/simple;
	bh=bP7xFXi9LJmSGi264gVlNRPf8kl9fD+RsNRf18Zs5Fs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TlM0r8C+SPZ3OkgJ772GvuVxAqeCKdVNNGKnSfL1WORxKZe1o6e9o5UrlWnzFdZGEVOJrpa4b1aWQSqv3ZE7wUQBAfdePmQCgT4AcOohqSyZRwjhefTgpjIgiI82Qrk48If0DHH+398qJF7jTmtotf16KtG7J1K/zqptt+UxUR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=XH+6xX5H; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=YXD2wMwEUuYlPl09QSsdSMQVJ6NNgeICzcUR3ZE6Znk=; b=XH+6xX5HohM87kQ/r0OTytDmu8
	h1v24hAOQOLEw7EvBUtApLavbNrQzHfJx8ECRm2VM4c/5kgL/uNghhiSxWk+2zfev2DlVTO18BSlF
	8YpNF2cAOdqqCkg5iJPUBT/qjRGGetgz8iTrQH3ARuORB4Bd7OnL3aakf5woyARhR24Q=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sL4Pj-000jyr-7v; Sat, 22 Jun 2024 19:20:35 +0200
Date: Sat, 22 Jun 2024 19:20:35 +0200
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
Subject: Re: [PATCH net-next v8 05/13] net: phy: mediatek: Integrate
 read/write page helper functions
Message-ID: <f361e137-ef94-4e27-bbee-1669c150cab6@lunn.ch>
References: <20240621122045.30732-1-SkyLake.Huang@mediatek.com>
 <20240621122045.30732-6-SkyLake.Huang@mediatek.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240621122045.30732-6-SkyLake.Huang@mediatek.com>

On Fri, Jun 21, 2024 at 08:20:37PM +0800, Sky Huang wrote:
> From: "SkyLake.Huang" <skylake.huang@mediatek.com>
> 
> This patch integrates read/write page helper functions as MTK phy lib.
> They are basically the same in mtk-ge.c & mtk-ge-soc.c.
> 
> Signed-off-by: SkyLake.Huang <skylake.huang@mediatek.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

