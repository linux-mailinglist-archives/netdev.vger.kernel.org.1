Return-Path: <netdev+bounces-114888-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8AF79448F3
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 12:02:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E99E21C20E82
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 10:02:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D0BA170A06;
	Thu,  1 Aug 2024 10:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="DLD41eff"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0680116D33D;
	Thu,  1 Aug 2024 10:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722506566; cv=none; b=Cu5K1plsvW6B4al6o7gu63tyiqmYx25BtODU3ujFsdh97XBpizaprEwT7g4p7R2Bn6vSCCjQRsBBlXghOWBCTtAANbb10X5T8qkEztsjQ+gf8CFhnxIOmvY4lNd5fJLgLbDmXRZqmwOteO7ai4AFAzHZsJaPM+K7SYoiyjZIdeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722506566; c=relaxed/simple;
	bh=7nVuvudTNhGqFPPn+GVAMISs9idDELDD2iaVimL0V3Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jEnNCRyTutTOsDOKNcSplyjS5oP5kqBMnZc2V1XAC4opRvZYk/Gp+3f804GwYaApxn+vgRhxhtFBDoMVZde1bb7K+MTSG4tLJ19e7SXmSpLVLKVRMOVLyj6I2YMmeLs6biTdPBkh+s8GgoQehV5sY3rw7DJhTS5G8YLY1EhYiZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=DLD41eff; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=wRbITLgig0NguqokG2GMOt0HANqT2BkB07SJ9OpfZkE=; b=DLD41effHB4KOOeFkcyN1V8wqU
	KY9V6N3s0qz+ryCZ+x1kTcNCRFcGXeFPRwwhh4tg7VXfqb2eJwh5XaEg0CLH7dX4O/mWeY64y7IMr
	6R+2aK054MliffRRXsdn0BrNISrCfplYHp+MiHu3lb9xsCfkUK+l2dudF8oaLgMwQOIP+CskDScAI
	QJWaRueSK32R7LSgKLEyVBP+qSuS1aerU3uVpSp0/rYm1zj/JujZNvQX38a/lgwbdKDJS8RlOXhbK
	zh7ehbqO68p2HpFREXW7TfDxJIsHlGaYA/nW7q5vpKBTlO1mz/qaoiv7P8w62ryeJJfMiqAF5cCYy
	za691Jcw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:47170)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1sZSde-0002K8-2A;
	Thu, 01 Aug 2024 11:02:26 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1sZSdh-00071Z-GC; Thu, 01 Aug 2024 11:02:29 +0100
Date: Thu, 1 Aug 2024 11:02:29 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Pawel Dembicki <paweldembicki@gmail.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: phy: vitesse: implement downshift in
 vsc73xx phys
Message-ID: <ZqtdNQB7BrQNTBSF@shell.armlinux.org.uk>
References: <20240801050909.584460-1-paweldembicki@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240801050909.584460-1-paweldembicki@gmail.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Thu, Aug 01, 2024 at 07:09:10AM +0200, Pawel Dembicki wrote:
> This commit implements downshift feature in vsc73xx family phys.
> 
> By default downshift was enabled with maximum tries.
> 
> Signed-off-by: Pawel Dembicki <paweldembicki@gmail.com>

Reviewed-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Thanks!

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

