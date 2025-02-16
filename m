Return-Path: <netdev+bounces-166809-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 25E01A375FB
	for <lists+netdev@lfdr.de>; Sun, 16 Feb 2025 17:48:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3CC527A2030
	for <lists+netdev@lfdr.de>; Sun, 16 Feb 2025 16:47:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC53D19415E;
	Sun, 16 Feb 2025 16:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="CjAX5t/w"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4014227735;
	Sun, 16 Feb 2025 16:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739724511; cv=none; b=T1X8ynOTmsjYNDOKi4vAf6AI4GtgRqjRZTpc4YicktrffOdAUhAKkpno0O0zSFp8z+3Nmz4g7I39kC/NEtbficdGeps0VBYZKnMahDjXsFUFnlT/wg5c6bVgNJovl8lgpO3v45cJZ9lxx+u6EPeYpfzmlJF+KaC4FmjUXDsLARg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739724511; c=relaxed/simple;
	bh=YaCN11o5s4eiGs1kwprfPe04mQLbTeCenPeeUvD8lfw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IoTBYrT3pAolUNW1JJlkK7lvnLM+cqgPswj9AqtRXMpXCNUjTtJZbiRH/NF2RvdNkhokn6GkvoVKAes9fqt23tTMmMjolwrL0gi7YwHN1QzT3Y55F634nsAJ49c6XI5f0Z37KKHohaJzUMGi3+aUzHtqGjHVRgScTn6ogRBpVgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=CjAX5t/w; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=W9iGUSJ3ng3saazA3eH7xbtGqjW36iAkpX0N9GsxsH0=; b=CjAX5t/wn7I13nrR/DJozEaX5J
	9uVUbiR7NCiIGFM/nonWXHf/BgmCoFNfe5JqFZ6Z/hDyezEpfmDNI6xtawyahWElwCI+NcC6W3qYn
	mrfYv00xUNz0RPkpvlvQogLKe2bla3FuKUaC43VAgU6i94iFUiNvj/8k0BH2+OKZ/JI8=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tjhoZ-00Ehkc-T4; Sun, 16 Feb 2025 17:48:19 +0100
Date: Sun, 16 Feb 2025 17:48:19 +0100
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
	Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Steven Liu <Steven.Liu@mediatek.com>
Subject: Re: [PATCH net-next v2 1/5] net: phy: mediatek: Change to more
 meaningful macros
Message-ID: <f3d4758c-fc84-4ffd-a48c-7ad5a5a07849@lunn.ch>
References: <20250213080553.921434-1-SkyLake.Huang@mediatek.com>
 <20250213080553.921434-2-SkyLake.Huang@mediatek.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250213080553.921434-2-SkyLake.Huang@mediatek.com>

On Thu, Feb 13, 2025 at 04:05:49PM +0800, Sky Huang wrote:
> From: Sky Huang <skylake.huang@mediatek.com>
> 
> Replace magic number with more meaningful macros in mtk-ge.c.
> Also, move some common macros into mtk-phy-lib.c.
> 
> Signed-off-by: Sky Huang <skylake.huang@mediatek.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

