Return-Path: <netdev+bounces-216761-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B3DB6B3510C
	for <lists+netdev@lfdr.de>; Tue, 26 Aug 2025 03:38:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C3BE5189DEC5
	for <lists+netdev@lfdr.de>; Tue, 26 Aug 2025 01:39:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F6A91DDC23;
	Tue, 26 Aug 2025 01:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="IdbnE3yA"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5554B946A;
	Tue, 26 Aug 2025 01:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756172331; cv=none; b=nCaEVcHqbbL3f66MsavYrfa+HC9hTY2ul5SNSMkq1Qcgs24x8mNxC8jU8a2kfADae0Dt4fPjgOVsfLMFT7rPLpTWZtJ4c1XSqyijB9ct0c3zACn/Eq7kuTYYCgQC4o/4DkSdGF+oe6jX6vynxD64T5NG+JfoUzR45aRiiOI+Dmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756172331; c=relaxed/simple;
	bh=fD0ndxnvZycsxVtcufMcnDWhLUAMDk/3xLz6OiPLB0M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sc8qtIpbYpLxCpexH/1ypDLL9ZdAZ2Y9HWavjSwwY7lqt/9ueij9Pt9e9tGXEH4V+Vcpu8inBVG8rLx9hj+aoD5eV2S145UDcWoRc4/KVsNkXeDRyqfkYsLLwdMIb7THif+Lv0jmv3rDeaT3q+fOvTFBocTQ8CCtbjX1OLdsI7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=IdbnE3yA; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=c3ZWt4MQdbS0NrnrEhdQILs1OHm77zmgWOkACjWpl9g=; b=IdbnE3yA9UgAPDSpjmXQsqKakL
	UtYqjCX0bo/ff04ZB9Gp+CL2LX4pgho2MCWKLBBR1M/27Vb5DHfL8IfQHrYF8V5J3Ur3urHh3Yi5h
	z6KeCl57b8HjxDsR0coKHUVQhwXJCJR2wtE2OdbM5xtCWGOQOwdfwnK3BSWond2Xk7Xo=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uqidv-0061ME-1x; Tue, 26 Aug 2025 03:38:35 +0200
Date: Tue, 26 Aug 2025 03:38:35 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Daniel Golle <daniel@makrotopia.org>
Cc: Hauke Mehrtens <hauke@hauke-m.de>, Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, Andreas Schirm <andreas.schirm@siemens.com>,
	Lukas Stockmann <lukas.stockmann@siemens.com>,
	Alexander Sverdlin <alexander.sverdlin@siemens.com>,
	Peter Christen <peter.christen@siemens.com>,
	Avinash Jayaraman <ajayaraman@maxlinear.com>,
	Bing tao Xu <bxu@maxlinear.com>, Liang Xu <lxu@maxlinear.com>,
	Juraj Povazanec <jpovazanec@maxlinear.com>,
	"Fanni (Fang-Yi) Chan" <fchan@maxlinear.com>,
	"Benny (Ying-Tsan) Weng" <yweng@maxlinear.com>,
	"Livia M. Rosu" <lrosu@maxlinear.com>,
	John Crispin <john@phrozen.org>
Subject: Re: [PATCH net-next 5/6] net: dsa: lantiq_gswip: support standard
 MDIO node name
Message-ID: <b85ca9ee-980e-4ffd-9899-11beb6539b44@lunn.ch>
References: <cover.1756163848.git.daniel@makrotopia.org>
 <6f4b14df1eef78c09481784555a911b7505d1943.1756163848.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6f4b14df1eef78c09481784555a911b7505d1943.1756163848.git.daniel@makrotopia.org>

On Tue, Aug 26, 2025 at 01:14:30AM +0100, Daniel Golle wrote:
> Instead of matching against the child node's compatible string also
> support locating the node of the device tree node of the MDIO bus
> in the standard way by referencing the node name ("mdio").
> 
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

