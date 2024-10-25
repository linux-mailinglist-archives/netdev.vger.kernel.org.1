Return-Path: <netdev+bounces-139096-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94BE79B02B9
	for <lists+netdev@lfdr.de>; Fri, 25 Oct 2024 14:45:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A36191C211EA
	for <lists+netdev@lfdr.de>; Fri, 25 Oct 2024 12:44:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 718AD1F757C;
	Fri, 25 Oct 2024 12:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="1ypYJ/kz"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83A5C146A6F
	for <netdev@vger.kernel.org>; Fri, 25 Oct 2024 12:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729860298; cv=none; b=omCu7iD+lzMpa8k8A2nqn9fgM80iB11EvaIObrthiOwZ8ruHBGvTrVvVsI9WEHQrVTvVhfAR1G/s+Q5+oqvu/z66RSFGeQTiNX4TOPL19RwSd0Jb4fd8ujW7JQuuzRTuEec2Q1L7Q3d9CAbIFugUFP/ftVzKxystk1W+3Lvhnb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729860298; c=relaxed/simple;
	bh=JbE+WUqU1O6yljLN6jfjTVU9pC+a5CHmCdyPsOqKbpo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cwL83taIzByOXc4FspenlQyTHnC9+nsRDaAA5x16s6Ooo+Z8yy0SpnHdFEzYhP4blqYN1d4hDkQg3lqIsl8fOqVeoaXaXdnS8Iwyet5DuC/hoaAIrOnMPG6HGZB1QdiINQ9Jj9sCdo/cWbnvImMn608iu+u8tzNytOqmeFoN7Wg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=1ypYJ/kz; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=2kqleHlib7lvZdeaK0vG+ttZGLYW63ynkNgZzmLrBig=; b=1ypYJ/kzQcWgZULES4gJQy5gZ9
	Wbrz0pbaOLPpZYImgB2sE+GA5ewpMqveaydnVMvVNqMK5BuQ9K/P22wx0rFJgjkQDVMGYWDBraSID
	dwFviV7YSxgH31pVRI/QG71cGAzQ/6/Ed9X1CpyT/BKiTwzYOv1SSr5m2iyXV4dXHfOM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1t4JgI-00BFBc-8z; Fri, 25 Oct 2024 14:44:42 +0200
Date: Fri, 25 Oct 2024 14:44:42 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: "Abhishek Chauhan (ABC)" <quic_abchauha@quicinc.com>
Cc: "Russell King (Oracle)" <linux@armlinux.org.uk>,
	Serge Semin <fancer.lancer@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	Andrew Halaney <ahalaney@redhat.com>,
	Simon Horman <horms@kernel.org>, Jon Hunter <jonathanh@nvidia.com>,
	kernel@quicinc.com
Subject: Re: [PATCH net v1] net: stmmac: Disable PCS Link and AN interrupt
 when PCS AN is disabled
Message-ID: <bc891f4e-4a3a-4664-b52c-871d173b7607@lunn.ch>
References: <20241018222407.1139697-1-quic_abchauha@quicinc.com>
 <60119fa1-e7b1-4074-94ee-7e6100390444@lunn.ch>
 <ZxYc2I9vgVL8i4Dz@shell.armlinux.org.uk>
 <ZxYfmtPYd0yL51C5@shell.armlinux.org.uk>
 <89f188d2-2d4e-43bf-98f3-aae7e9d68cab@quicinc.com>
 <5e5783f0-6949-4d04-a887-e6b873ae42ff@quicinc.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5e5783f0-6949-4d04-a887-e6b873ae42ff@quicinc.com>

> Serge can you please respond on the PCS support in stmmac ?

Unfortunately, Serge has been removed as Maintainer of stmmac as part
of the Russian  sanctions.

stmmac currently has no active Maintainer.

	Andrew

