Return-Path: <netdev+bounces-182429-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AE4AA88B70
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 20:36:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 54B46179BD7
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 18:36:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 387C928BAAF;
	Mon, 14 Apr 2025 18:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="yBqLlOBv"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DB58289374;
	Mon, 14 Apr 2025 18:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744655627; cv=none; b=qYMf/msedmmNsPtSpAsOIHN4PJHdGZRhebKJJINfcFB4ccAXxAC5PMDk1LrbVvceg4F6TwZnxpVP5UBZrVyS0/8NwDmGV36i+bCcjuBukJzprL8VHTBDlGALHgx/GOQKyv9c2OQ5HeVQItiV2xK1gQlP56y0eXu5F1GKLY8XH8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744655627; c=relaxed/simple;
	bh=0KlXQUK/yjPJs0KzyxFhDati+DmJRIoM6Y0yhXzHQtM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nrQ6P/xG0qwuUI0qctsH45exSsybUqN36x4v3iuXW23izm5JC6nuE6XipKaCDYcGFm1bc+a8KcuZkCRXsG7eh9BKcAM6pmiRgOfjqR9B+JpCwe7Shbo67OOANG0cmmt6qVoialnphqhAmosbP5T0EFbBxhCLqopDduTuOZA7gL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=yBqLlOBv; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=6Q1p3SoV9fj9HQbqaNCm0CDhPwNjm8pWMFbjGasjMes=; b=yBqLlOBv3qyaA7CLZ4BZMWHM6t
	NzdK8UQt7WEVrI8DSvBtHl3QK/tWZJPuKoFK9hbzx4pDhEU6Ey4dObR5j1wWRxQOIIOh0LcYtD9QP
	gDCzqX2MzratlnYF8yOk+zp5ODLN8t18YdZNEGioy/r+IvsffSk7LzLYsBhwhqS7KR9w=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1u4Ocb-009FfA-H7; Mon, 14 Apr 2025 20:33:29 +0200
Date: Mon, 14 Apr 2025 20:33:29 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Daniel Golle <daniel@makrotopia.org>
Cc: Bo-Cun Chen <bc-bocun.chen@mediatek.com>, Felix Fietkau <nbd@nbd.name>,
	Sean Wang <sean.wang@mediatek.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Florian Fainelli <f.fainelli@gmail.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH net 5/5] net: ethernet: mtk_eth_soc: convert cap_bit in
 mtk_eth_muxc struct to u64
Message-ID: <7d990c0a-c9d3-4d07-bae7-70e4438fd6a2@lunn.ch>
References: <08498e31e830cf0ee1ceb4fc1313d5c528a69150.1744654076.git.daniel@makrotopia.org>
 <dde46bff10fc0ac5e7c6facd1bab018b147356d9.1744654076.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dde46bff10fc0ac5e7c6facd1bab018b147356d9.1744654076.git.daniel@makrotopia.org>

On Mon, Apr 14, 2025 at 07:12:53PM +0100, Daniel Golle wrote:
> From: Bo-Cun Chen <bc-bocun.chen@mediatek.com>
> 
> Wihtout this patch, the mtk_eth_mux_setup() function may not correctly
> search the Mux.

This commit message is not particularly good, especially for a Fixes:
patch. Please could you expand it.


    Andrew

---
pw-bot: cr

