Return-Path: <netdev+bounces-165291-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C863A31802
	for <lists+netdev@lfdr.de>; Tue, 11 Feb 2025 22:44:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E90E162CF3
	for <lists+netdev@lfdr.de>; Tue, 11 Feb 2025 21:44:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9C3626A0B5;
	Tue, 11 Feb 2025 21:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="2etIAmS7"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33344264A68
	for <netdev@vger.kernel.org>; Tue, 11 Feb 2025 21:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739310115; cv=none; b=YiynoAc93mvKLgFiDIBDmuROq7ELmXq7sT2j7mKEDfU1YuSfcYv4l64A0zrsOedQMmgp3lKW8vU70672jwzb21KzR29tYLMQX7UcYuafTIWZWUddFqtkkJTuJZCBzeZgghsZN0HfZWEM7nQgmdtPnIaIQmq1NMbbssECxw0NXks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739310115; c=relaxed/simple;
	bh=snmeUmEq0sBEt4lGjJaOCLKkfJa7ykd9Ko5sIooocOI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ion54Nn6moFOIPy088/5ZPFrKcIQItfGcfc8GzBl7xw4yKI36Dflmupuj7DqreYpWtKgoCLyzkvO40viQX1bJyDBj5W43NI0CgBJZqKRXpK7tEaeD6pQPIU4YhB6SLdZ95sDtD6us4pL3tCsWztJ+NrU5GGklnLvVTjbimTSuiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=2etIAmS7; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=LnCxQ91jkpvGcDJ/ibowdTbFmJx0QvEiSvlyH6ryOfk=; b=2etIAmS77EasQVZry0j996cmOm
	JpEqYBc0rfMhh+YGWJdsG3Bx1cplZ4tSWLvYqr8hQwmGJ7LfIveP2Z4gKSMGlyxIh60UX6Bzoi77E
	rGGIWu69yer+prK8Pb4QNKQmIKOAjqJXhnao3zjZ/p7cAVGux2T26Q+GPTEymL1MxVlo=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1thxkJ-00DBcg-8B; Tue, 11 Feb 2025 22:24:43 +0100
Date: Tue, 11 Feb 2025 22:24:43 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	David Miller <davem@davemloft.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Simon Horman <horms@kernel.org>,
	Iyappan Subramanian <iyappan@os.amperecomputing.com>,
	Keyur Chudgar <keyur@os.amperecomputing.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH net-next] ixgene-v2: prepare for phylib stop exporting
 phy_10_100_features_array
Message-ID: <92040ddc-bd6c-40f0-807f-b17b7d0e6b39@lunn.ch>
References: <ad4b5c29-abbc-450c-bada-5f671c287325@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ad4b5c29-abbc-450c-bada-5f671c287325@gmail.com>

> +	linkmode_clear_bit(ETHTOOL_LINK_MODE_10baseT_Full_BIT,
> +			   phydev->supported);
> +	linkmode_clear_bit(ETHTOOL_LINK_MODE_10baseT_Half_BIT,
> +			   phydev->supported);
> +	linkmode_clear_bit(ETHTOOL_LINK_MODE_100baseT_Full_BIT,
> +			   phydev->supported);
> +	linkmode_clear_bit(ETHTOOL_LINK_MODE_100baseT_Half_BIT,
> +			   phydev->supported);
> +	linkmode_clear_bit(ETHTOOL_LINK_MODE_1000baseT_Half_BIT,
> +			   phydev->supported);
> +
> +	phy_advertise_supported(phydev);

phy_remove_link_mode() would be better. The MAC driver then does not
need to know about the insides of the phydev structure, and it
implicitly handles this last part.

    Andrew

---
pw-bot: cr

