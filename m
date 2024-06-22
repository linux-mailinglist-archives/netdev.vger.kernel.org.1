Return-Path: <netdev+bounces-105873-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AF1091356D
	for <lists+netdev@lfdr.de>; Sat, 22 Jun 2024 19:42:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 03FE71F224BF
	for <lists+netdev@lfdr.de>; Sat, 22 Jun 2024 17:42:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 032BC1863E;
	Sat, 22 Jun 2024 17:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="RYVH1pld"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D751381AA;
	Sat, 22 Jun 2024 17:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719078127; cv=none; b=tG+3o13/wjezA/C0NJ0o5TeausC5vpujE0EW8ilkhF6zfBuLiHnvLd7DiaOWNQjY+J7yZMvMw7MbG8x6a6g1vmd0J0URP8dokTbNeVoVnzpRIK7Afrre8G3YGX8k7efYIPQ12hNPZnU2XMu5OXwq6NZsmwN5ikYUpU3DAAC4CQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719078127; c=relaxed/simple;
	bh=wza8kKhlLzI4l62hN1aOx/UN5TokwhHIOXAK7bG0YJY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rNRCrMNg1Bvk7AiMk8Okkfp0qNz03EfrHgBUp/jOcVVIo8ztVhZSHbYvodWn+aeE54vkIHHo1P2FDwnAyTLpGt0DdL6cQ8NPs8jpFP0zBj20rU4IrPTntqqkWHoUvBYar8EGMSMMqPOyDna+Pe24kvNfSYHyN1PMksO10YOeTPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=RYVH1pld; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=w5rwYa7bI68oLnkoYbazba1jipftrm7TeicnDw0Zws8=; b=RYVH1pldyhqC5cJIpFRMib/IKx
	0a0Navc+8oGu/NcUrNmMVRDhCMDQMk8g64AhzlgmziYjKH5Qz4FHScUlRTuaIo1SzY2KDQ2OGcP27
	MNNPE5gv7h1p8Hg2qUURub2dzU+J/zLwLMeRwN8zqxC6kiYhlGZD64SeuHpyFRDm3Dew=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sL4kN-000k5J-B6; Sat, 22 Jun 2024 19:41:55 +0200
Date: Sat, 22 Jun 2024 19:41:55 +0200
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
Subject: Re: [PATCH net-next v8 09/13] net: phy: mediatek: Add token ring
 access helper functions in mtk-phy-lib
Message-ID: <2c0ce908-55a5-4194-ac7b-68828ed10399@lunn.ch>
References: <20240621122045.30732-1-SkyLake.Huang@mediatek.com>
 <20240621122045.30732-10-SkyLake.Huang@mediatek.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240621122045.30732-10-SkyLake.Huang@mediatek.com>

On Fri, Jun 21, 2024 at 08:20:41PM +0800, Sky Huang wrote:
> From: "SkyLake.Huang" <skylake.huang@mediatek.com>
> 
> This patch adda TR(token ring) manipulations and add correct

s/adda/adds

plus "adds the correct macro names for"

> macro name for those magic numbers. TR is a way to access
> proprietary register on page 52b5. Use these helper functions

registers

> +/* ch_addr = 0x2, node_addr = 0xd, data_addr = 0x8 */
> +/* clear this bit if wanna select from AFE */
> +/* Regsigdet_sel_1000 */
> +#define EEE1000_SELECT_SIGNEL_DETECTION_FROM_DFE	BIT(4)

Should that be SIGNAL?

	Andrew

