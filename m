Return-Path: <netdev+bounces-117211-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97F7494D1CD
	for <lists+netdev@lfdr.de>; Fri,  9 Aug 2024 16:07:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA1CE1C2118D
	for <lists+netdev@lfdr.de>; Fri,  9 Aug 2024 14:07:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 581E519580A;
	Fri,  9 Aug 2024 14:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="DxTWhrd8"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D589D174EE4;
	Fri,  9 Aug 2024 14:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723212470; cv=none; b=LPDb9UfIUJrXnejeVpL4axPeATgw+C/RxKy1DqUDdtvFO5K8oCpsMlhNd7qA9U7KHPbiLrp4bWX5qqckOrcxouM6/hhgQfXVgdUOljAOGgdSnJhoxPeXGutZgn17EQCrMOfz57LVgv0WB235B3dr0kl5rgsvM9fT7hP87FzdpJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723212470; c=relaxed/simple;
	bh=zD7h3HcvCWWIIf6aYLP1APhfS/6dRb7y9zsTZS2srzY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZT2I59v5pkeUCHOcVkHHkStmuxc4TWM2zYDNMh57MPbgb6vpUxQY0N40RSlrmr8JBgrunq4xnVuAVxi9Ug0GPLH8tZAc/0lvvQpBIN8Y+/34aWy6KhFmZpTn6zA83fH1BUK6uQxukB5HmpfZkBBjdJOWEe4t5ttqQRHiUb91VMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=DxTWhrd8; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=ZSK0gaAnl4gyzygkdHSHTkwq9hcA+qPNT/OCFaD2XEs=; b=Dx
	TWhrd8Xv/qraGB327AeRXqRXNg1bXzVMJxQALXC5igncAL7qK5ti+I6g66UoRjhexA7IvlTAkJvtO
	pE+MdcXY6fNxsNG8xNDLf7vxr+TgDSUgjUmlCWvag+fk8mnnLLgUfTgnuJw33puLGqHytmLuyi06r
	JTgWl7oUXm3X+aY=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1scQHM-004NqI-Gz; Fri, 09 Aug 2024 16:07:40 +0200
Date: Fri, 9 Aug 2024 16:07:40 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: SkyLake Huang =?utf-8?B?KOm7g+WVn+a+pCk=?= <SkyLake.Huang@mediatek.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"linux@armlinux.org.uk" <linux@armlinux.org.uk>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"edumazet@google.com" <edumazet@google.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"dqfext@gmail.com" <dqfext@gmail.com>,
	"matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"hkallweit1@gmail.com" <hkallweit1@gmail.com>,
	"daniel@makrotopia.org" <daniel@makrotopia.org>,
	"angelogioacchino.delregno@collabora.com" <angelogioacchino.delregno@collabora.com>,
	Steven Liu =?utf-8?B?KOWKieS6uuixqik=?= <steven.liu@mediatek.com>
Subject: Re: [PATCH net-next v10 00/13] net: phy: mediatek: Introduce
 mtk-phy-lib and add 2.5Gphy support
Message-ID: <9d1e9cf8-8cd5-4ec6-ba1e-d55ed5e1afa5@lunn.ch>
References: <20240701105417.19941-1-SkyLake.Huang@mediatek.com>
 <0935426d09f3bf83b119e8f6bf498479a62845c0.camel@mediatek.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0935426d09f3bf83b119e8f6bf498479a62845c0.camel@mediatek.com>

On Fri, Aug 09, 2024 at 10:58:02AM +0000, SkyLake Huang (黃啟澤) wrote:
> Gentle ping.

Hi Daniel

What is your take on this patchset? Are you happy to give Reviewed-by:
for them?

    Andrew

