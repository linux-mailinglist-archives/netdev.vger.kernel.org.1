Return-Path: <netdev+bounces-136608-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E32EF9A24D7
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 16:19:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F5AE1F21854
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 14:19:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EFE51DE3D9;
	Thu, 17 Oct 2024 14:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kYpcxIEP"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 383C51DDA09;
	Thu, 17 Oct 2024 14:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729174787; cv=none; b=svf9SQhWIqHZm8T/h1C//MnfUhoaeWmY2whMzV9o9Rr9jQFmJ5gxssmXgYuT4asq/KctXx+EBae+zB6aKRCeX64E8z+sTcO8hLCPbUVxE6nkBWWmP3cnba4MgspBHAWiNDZsZ6PEbp4XwIitT+ZSYqxgdeOBZhJPkvs0fPSLoKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729174787; c=relaxed/simple;
	bh=ukHkPZB2khOGiqqlMlSXcpRHso2j7wSVMvSaP3s51gg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tzv89XU4HTmnWoLgkQoL8UoBbqoWRy/ID783RDeWL7cchvtIiwY7C9Vu9Ys6hCiw2F19OU7i28D7CcX7/+jjwXvPQgVQaMeUkyDeYsxBuE6AsRegfmQVIsNwnleXqMbexmw2aWDQElMbt7JXSQbDUZIIyqUv1uopQPOPoplyVXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kYpcxIEP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF119C4CEC3;
	Thu, 17 Oct 2024 14:19:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729174786;
	bh=ukHkPZB2khOGiqqlMlSXcpRHso2j7wSVMvSaP3s51gg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kYpcxIEPCFmxdtvHeubils7hL0Cezn0iaR726SRo6UKezx1jTNCusInk7gNUJt/rz
	 IIlfhW05gkqNaWYPsFlwLQ2hK+Y9NGUXT7nLJxt8VWatjSdkOaDojLM4oTScTiIICj
	 7ohIrvzf73UomSwPFnbclu8MdzGDE+Q8/iGS6KffipT4kFSixF6PjlFeL/V7ud9xNX
	 48zGZ+isY9Q7hsXpNDsGnkScwsrVBZIV/4neYe4nmNzHdH+Wj2j+44nmKBgGEBA/tY
	 Yr+jzp16joQrQJGk1A2wXghJp63rFKTDDtVn4hzzMm6V0huxsda6HprAlPVTqSp4mO
	 4hENlhpS90aCA==
Date: Thu, 17 Oct 2024 15:19:41 +0100
From: Simon Horman <horms@kernel.org>
To: Sky Huang <SkyLake.Huang@mediatek.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
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
Subject: Re: [PATCH net-next v2 2/3] net: phy: mediatek-ge-soc: Shrink line
 wrapping to 80 characters
Message-ID: <20241017141941.GQ1697@kernel.org>
References: <20241017032213.22256-1-SkyLake.Huang@mediatek.com>
 <20241017032213.22256-3-SkyLake.Huang@mediatek.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241017032213.22256-3-SkyLake.Huang@mediatek.com>

On Thu, Oct 17, 2024 at 11:22:12AM +0800, Sky Huang wrote:
> From: "SkyLake.Huang" <skylake.huang@mediatek.com>
> 
> This patch shrinks line wrapping to 80 chars. Also, in
> tx_amp_fill_result(), use FIELD_PREP() to prettify code.
> 
> Signed-off-by: SkyLake.Huang <skylake.huang@mediatek.com>

Reviewed-by: Simon Horman <horms@kernel.org>


