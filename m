Return-Path: <netdev+bounces-117498-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 65B6994E205
	for <lists+netdev@lfdr.de>; Sun, 11 Aug 2024 17:56:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C3451F21249
	for <lists+netdev@lfdr.de>; Sun, 11 Aug 2024 15:56:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13C0E14C5A3;
	Sun, 11 Aug 2024 15:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="LkTFZb5W"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B67E7F6;
	Sun, 11 Aug 2024 15:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723391785; cv=none; b=rrcHrYRL+YcXVWBqtbRZjG7FtTtzzL5ep23wueLovKqthdBghyfJ3VklVXMlrEd5oM2TsFeon9XYHULJ1E0EI7NBLrc17qQzq3Hoe/b1CWmFPTzUR36AlmDgvZBUQJc6az8eMQfyfVnjrlT8SFK+KkXdC1Jh91fpqkSXH3qcRLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723391785; c=relaxed/simple;
	bh=fJ7Sgrwuix051ucIcIikUmIzihyvNxcSoJvFpwSE4yA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h9eOlkabng4Q5w2Qm849Kt7fi4OKWiAKhZoIt4FEc/QX9qMdsbaMJA6ccewtIpxVTSPZcZa1Cc6PytZI8jsz1vSlp0++zDMUOyxhVTaBO3FvPrrnU02nTvLRxDqgkm3ja3lDJipPJiIZLkN/gd5vBCkcQbuQRZE6FHCMGf5zysM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=LkTFZb5W; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=p4zTNVMDfUUoSXFCCF79aOPorInxT7uHzSiTMw8aCZM=; b=LkTFZb5WA8HyI5MCgYX8QLk3Kd
	hp0Uv5q39VUnOwJe9j6LR+7MAMg2PfiJu5RiuqU5g2R9KAjkRJyyoCYwlp9+peyI4ju5iA496X8Ov
	9T27WLUmKCprfW5dN5DYwg1fHyMKZvOOCyKBEqbBfjO78HfKdUnsa8KBbY0srCO5ggeI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sdAvU-004VWC-VJ; Sun, 11 Aug 2024 17:56:12 +0200
Date: Sun, 11 Aug 2024 17:56:12 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Parthiban Veerasooran <Parthiban.Veerasooran@microchip.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, horms@kernel.org, saeedm@nvidia.com,
	anthony.l.nguyen@intel.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, corbet@lwn.net,
	linux-doc@vger.kernel.org, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	devicetree@vger.kernel.org, horatiu.vultur@microchip.com,
	ruanjinjie@huawei.com, steen.hegelund@microchip.com,
	vladimir.oltean@nxp.com, masahiroy@kernel.org,
	alexanderduyck@fb.com, krzk+dt@kernel.org, robh@kernel.org,
	rdunlap@infradead.org, hkallweit1@gmail.com, linux@armlinux.org.uk,
	UNGLinuxDriver@microchip.com, Thorsten.Kummermehr@microchip.com,
	Pier.Beruto@onsemi.com, Selvamani.Rajagopal@onsemi.com,
	Nicolas.Ferre@microchip.com, benjamin.bigler@bernformulastudent.ch,
	linux@bigler.io
Subject: Re: [PATCH net-next v5 10/14] net: ethernet: oa_tc6: implement
 receive path to receive rx ethernet frames
Message-ID: <79bb1948-3d38-44f3-9653-ebdf80be9c2c@lunn.ch>
References: <20240730040906.53779-1-Parthiban.Veerasooran@microchip.com>
 <20240730040906.53779-11-Parthiban.Veerasooran@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240730040906.53779-11-Parthiban.Veerasooran@microchip.com>

On Tue, Jul 30, 2024 at 09:39:02AM +0530, Parthiban Veerasooran wrote:
> SPI rx data buffer can contain one or more receive data chunks. A receive
> data chunk consists a 64 bytes receive data chunk payload followed a
> 4 bytes data footer at the end. The data footer contains the information
> needed to determine the validity and location of the receive frame data
> within the receive data chunk payload and the host can use these
> information to generate ethernet frame. Initially the receive chunks
> available will be updated from the buffer status register and then it
> will be updated from the footer received on each spi data transfer. Tx
> data valid or empty chunks equal to the number receive chunks available
> will be transmitted in the MOSI to receive all the rx chunks.
> Additionally the receive data footer contains the below information as
> well. The received footer will be examined for the receive errors if any.
> 
> Signed-off-by: Parthiban Veerasooran <Parthiban.Veerasooran@microchip.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

