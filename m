Return-Path: <netdev+bounces-105872-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EC23913562
	for <lists+netdev@lfdr.de>; Sat, 22 Jun 2024 19:34:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 78CDF1C21277
	for <lists+netdev@lfdr.de>; Sat, 22 Jun 2024 17:34:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32A4C1799B;
	Sat, 22 Jun 2024 17:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="jDNcRYf0"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96C381802B;
	Sat, 22 Jun 2024 17:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719077694; cv=none; b=ddhgboahL/IcGenyyrBCEMyFpibhNEw0r0DInWtcujOLg8bh9zzCevBbmlDiScMN8Er5IMO0NyuA+pdd6oJc9M5+CQzoFtvli9StnwE2+aeMrjluU6Q9NlfLUG+oiaJhgbVZvSe3EYnsFrOFjumqudTLosgUN3mr077/UiHxJ8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719077694; c=relaxed/simple;
	bh=TfHcmjKzifnQjo9AFRRTUUVFj1gY0HBNg7Fx0kDJyIg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nqVNGPe2JvWeTy5zZSQe100gLj9pTvj1Vv/CfBVsqUKFPdTijMIQrKsAaAsjBiLgKi+LhTp5ZuXO7++B2mgZPoYMXIR5ty6rDiQdFXK5FkIIaZWbNcJ63u8lGi+cPJbxZETleXqXeyGT+IWUfgzcGqCFAPS3PN7gR6qVXwdT2Fs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=jDNcRYf0; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=jlqkEc00ibYV9DaOr6Nbo+0w60AORzYwpkKfN96dOho=; b=jDNcRYf0pAbWw0DNMbRkHp/aTO
	0FfkgF+Azgg0MHM6ak6cG2+Prdzs0PisQ4oCqNhKG71ifSWYMGjOmbojrHkuQ4iuyhmNvSvxov1Xf
	9Q+Bzbc34j5lD1E40YNptCEOivXuK5bjbn31In0kpILpOn4QOWdwDosxJxvBDM9rsMaA=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sL4dL-000k3c-G1; Sat, 22 Jun 2024 19:34:39 +0200
Date: Sat, 22 Jun 2024 19:34:39 +0200
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
Subject: Re: [PATCH net-next v8 08/13] net: phy: mediatek: Change
 mtk-ge-soc.c line wrapping
Message-ID: <bb646b16-53ec-45ee-9ce8-977e9caf08db@lunn.ch>
References: <20240621122045.30732-1-SkyLake.Huang@mediatek.com>
 <20240621122045.30732-9-SkyLake.Huang@mediatek.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240621122045.30732-9-SkyLake.Huang@mediatek.com>

On Fri, Jun 21, 2024 at 08:20:40PM +0800, Sky Huang wrote:
> From: "SkyLake.Huang" <skylake.huang@mediatek.com>
> 
> This patch shrinks mtk-ge-soc.c line wrapping to 80 characters.
> 
> Signed-off-by: SkyLake.Huang <skylake.huang@mediatek.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

