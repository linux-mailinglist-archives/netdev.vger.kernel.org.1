Return-Path: <netdev+bounces-166810-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C323A37604
	for <lists+netdev@lfdr.de>; Sun, 16 Feb 2025 17:51:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A15CB188DFB5
	for <lists+netdev@lfdr.de>; Sun, 16 Feb 2025 16:49:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F0FD199935;
	Sun, 16 Feb 2025 16:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="z+eRINOK"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FC2213BAE4;
	Sun, 16 Feb 2025 16:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739724544; cv=none; b=rU2qTQcpLuE0hGgSqxF5nsdT+CoP3sL3R2C+fURv9tHz7s+SdJ99e41U/S4Ar6vm6RagFaGthkh0ZPux9eWrL81pCkEkzkqvebPcRcM64Csm2J9PD9d4esnQALUeAdQO3ZSy4X3foSBKMKXvclGGkUraApfpRfW5SuBBKPMnhV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739724544; c=relaxed/simple;
	bh=l6Wmr8aGDZ7EoLQlDvWffqo0jFPBM0U4wC45oHxMfUk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hyZamKRCbc/s1m5Zqf3aDHocahMLEjc5aanG//zgryTz/mkUIdTGNgzxuwPesIwLlHqo3K/38Pcpb7g3zC7Mm6OWtnJKEMejdzosXbp1z5Lhn0qlHf9NtaifDJFrgjpZ8lwyizYxPTeqL0Adt+30konXcvemFR8qeL9bpngVqSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=z+eRINOK; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=RadiTnToO2eHxea4KifxVQwm6ZSAOw4mc4CFwbh8oiA=; b=z+eRINOK34wxEmFM4pnZfDaHxV
	v3mPGn843AojGYC2GGcna2leAdsRkWnIvoIIEJ0lTx/NP2cySfJe+2JouHHRMCtcx1NmpIe4/hHUR
	4FR67Z85uhAK2+OLZcw/0Y4fubPa9oscKYw9c6tb6EaAQzzZ4/CK7YCcQ2g89lsMWeiM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tjhp6-00EhlU-AE; Sun, 16 Feb 2025 17:48:52 +0100
Date: Sun, 16 Feb 2025 17:48:52 +0100
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
Subject: Re: [PATCH net-next v2 3/5] net: phy: mediatek: Add token ring set
 bit operation support
Message-ID: <2303dfa2-2bd4-4195-b987-22daea9fb80c@lunn.ch>
References: <20250213080553.921434-1-SkyLake.Huang@mediatek.com>
 <20250213080553.921434-4-SkyLake.Huang@mediatek.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250213080553.921434-4-SkyLake.Huang@mediatek.com>

On Thu, Feb 13, 2025 at 04:05:51PM +0800, Sky Huang wrote:
> From: Sky Huang <skylake.huang@mediatek.com>
> 
> Previously in mtk-ge-soc.c, we set some register bits via token
> ring, which were implemented in three __phy_write().
> Now we can do the same thing via __mtk_tr_set_bits() helper.
> 
> Signed-off-by: Sky Huang <skylake.huang@mediatek.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

