Return-Path: <netdev+bounces-234490-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FA65C21897
	for <lists+netdev@lfdr.de>; Thu, 30 Oct 2025 18:44:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 20B394031B8
	for <lists+netdev@lfdr.de>; Thu, 30 Oct 2025 17:44:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2AC736A5FA;
	Thu, 30 Oct 2025 17:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="dbHz8lSp"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 525EB315D4E;
	Thu, 30 Oct 2025 17:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761846237; cv=none; b=ACwFfK0Cw/I+yTNF4FBHg+LlbXEyAoIoPFFcjoCBMDL2TbmkI6M+cXxpcouni61Usxb0XE383qYIdsmmRM4qjNHHbh6Q5vGEoxEh32zi+/FrYsF1GdjeEJjha9olB6YGQKOn3GyS1IjgNv93gHLh+nPbTnhwjFSd90voAQhVkxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761846237; c=relaxed/simple;
	bh=SKqGBAJpdAvAm7U4Ze3CcD/5Ri7P82K7N/2THFTytnU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MAmpQDi3rh/6NCKsteFcVIOv6F5Ejcyfc1NT+kL6EZ/YrtczIX0M4aue8Z8g6qF+0O/DPVQBVM868aZKOVIHxZ02YHAZnLfktjuSj8Hvd1SDN3BCcMMXsBeU/580Pn0yMMG/OcDVqohRl6KaJFN6JdqMnG+G9RGqaqf0LI/t+a4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=dbHz8lSp; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=PQFPQ4UaPvdwHCfiNG96CUeOxZvU3PKXUW+JDvEAvTo=; b=dbHz8lSpYu19XseZCh607/8zao
	6INomKCru+g2sXtxtpvMGSCF7l/xDlNMjFEWRDTbu9i2LBbVaoe3iICZKhWeolE3ov6vcpBLQPZvB
	qmB3FTG3f7VBHwH3YO/SuvoxZSfy6g9HOwQ0Yr6Az0L8cr+n9fm7TWL4/iu7NBNel7w4=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vEWge-00CX5T-GB; Thu, 30 Oct 2025 18:43:48 +0100
Date: Thu, 30 Oct 2025 18:43:48 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Wei Fang <wei.fang@nxp.com>
Cc: claudiu.manoil@nxp.com, vladimir.oltean@nxp.com, xiaoning.wang@nxp.com,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, aziz.sellami@nxp.com,
	imx@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 0/3] net: enetc: add port MDIO support for both
 i.MX94 and i.MX95
Message-ID: <f6db67ec-9eb0-4730-af18-31214afe2e09@lunn.ch>
References: <20251030091538.581541-1-wei.fang@nxp.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251030091538.581541-1-wei.fang@nxp.com>

> Similar to the external MDIO registers, each ENETC has a set of internal
> MDIO registers to access its on-die PHY (PCS), so internal MDIO support
> is also added.

Any reason to not just hard code it to 0?
What is the reset default?

DT describes hardware, not configuration. So getting this from DT
seems wrong.

    Andrew

