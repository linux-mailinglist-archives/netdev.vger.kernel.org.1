Return-Path: <netdev+bounces-230570-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C1569BEB2BB
	for <lists+netdev@lfdr.de>; Fri, 17 Oct 2025 20:16:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 55D49744C6B
	for <lists+netdev@lfdr.de>; Fri, 17 Oct 2025 18:16:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9873730505E;
	Fri, 17 Oct 2025 18:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="SKKZAasN"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3D202561D1;
	Fri, 17 Oct 2025 18:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760725002; cv=none; b=KVuosJuxkijDBq2qCxvd6ftgEQOSmPIm/HfcgXOqDaBfxdYy18PKQio4q7Pplkm3evKcXuraS2wP9HF1kfkRoMrPdaHZE3ydEohNxZuXWxCsQ4Dum5vQvhvpzPB4fOdNcEtlkkNziga39c7mi6qDFxSzm004YsKZ4JJiNt4+h0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760725002; c=relaxed/simple;
	bh=PzKxQGwu2lsRdLqcmha5dsUh0TOLFixGPNBu88zqJRo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VrtjqaVcqbQsMm5eeQ2yB7DEGd7ReL5hcwVL4Ivb0zlonKr3fRYGYMODFMWaXhahQV/6t9GsCyWlxV8LoMc19BIV780WeKOS19EE6/X6gHu6NEZAi2q32DRDIhhl+dNj8+K9U4GVZ/M1gh639QgmvIz5eo+BMaKoNdxdm3iwq1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=SKKZAasN; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=fO2f6mURH8bQZYGfr1Lrr+16q3HGGYwVpFWAgRU4ZMA=; b=SKKZAasNBz3jruAECyAjMqftbi
	YjSr/IHx0LNgu/gwWoBxRT9vJ672lGqiMf9jY4kjA2Qn9D08oJdRzxsGxmGq2xqatPMRanlpA+wgR
	jNN83D9izslqFUcUA/TJVo0ZhHqZtGG6cosMyVpjp4nEEG+kA60sYEKM5tVJTPmiKPrM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1v9ozx-00BJbN-Qd; Fri, 17 Oct 2025 20:16:17 +0200
Date: Fri, 17 Oct 2025 20:16:17 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Inochi Amaoto <inochiama@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Chen Wang <unicorn_wang@outlook.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	Han Gao <rabenda.cn@gmail.com>, Icenowy Zheng <uwu@icenowy.me>,
	Vivian Wang <wangruikang@iscas.ac.cn>, Yao Zi <ziyao@disroot.org>,
	netdev@vger.kernel.org, sophgo@lists.linux.dev,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Yixun Lan <dlan@gentoo.org>, Longbin Li <looong.bin@gmail.com>
Subject: Re: [PATCH] net: stmmac: dwmac-sophgo: Add phy interface filter
Message-ID: <34fcc4cd-cd3d-418a-8d06-7426d2514dee@lunn.ch>
References: <20251017011802.523140-1-inochiama@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251017011802.523140-1-inochiama@gmail.com>

On Fri, Oct 17, 2025 at 09:18:01AM +0800, Inochi Amaoto wrote:
> As the SG2042 has an internal rx delay, the delay should be remove
> when init the mac, otherwise the phy will be misconfigurated.

Are there any in tree DT blobs using invalid phy-modes? In theory,
they should not work, but sometimes there is other magic going on. I
just want to make sure this is not going to cause a regression.

Also, does the DT binding document list the valid phy-modes?

      Andrew

