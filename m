Return-Path: <netdev+bounces-232241-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BB52C0315D
	for <lists+netdev@lfdr.de>; Thu, 23 Oct 2025 20:52:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 12B8A359113
	for <lists+netdev@lfdr.de>; Thu, 23 Oct 2025 18:52:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 510662D0C73;
	Thu, 23 Oct 2025 18:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="4W7Ltb5z"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C45D629A326
	for <netdev@vger.kernel.org>; Thu, 23 Oct 2025 18:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761245536; cv=none; b=tl/skS1QmyjV9RAKd/jLdL+11Qm/Wc5+knLWhtLO7LasPDwGm8klG7NdB6/8GbIESstdkAVPn+fk0O2E/vtXuMofzmbF+gH/U8n/Ntbe281+mkeZnGdap+E8Nzg3RbRu3uT1mLGZsv0CmuXDcM6VaD5PutH90tRE1kjtdvnD4pM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761245536; c=relaxed/simple;
	bh=motAv9yAc7rpmhzoOgwlYSExUo0W3KtE/gBps6lnMQ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tVzCuOInn7UlKWeEJNIfXlH3R/Uoryix6wPLUHX3bbWaWeq+KbqlqAkLvJpaszcYHCTOxagmrRwop0jGR6m3tmfm58tdFnzuhW4lvorkEINPNaksmGtqg7pydLP+hqsHnjWFRyHmJuy/ntYYwfCXNBmtWwirnLxXaqvIS9ncTtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=4W7Ltb5z; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=CcG50dMMXSISlPBoCDniPpurycAsgd8gSy7s4DyCZOk=; b=4W7Ltb5zwkN/3ATliMvoPnipDN
	J0g3vQ5GBsnTualcKGJnmKIZ2PsMPlUDlQlyfK1mjiNgfZEUxhaq08Yns3cKGW/8NpQcRY50Ga8RH
	DZdtnVT28pIMF9kcje9UbVU13vDCX5aP/x5IcTuJCDdzqC1ZPK1iywCDWOsF0jLO6bYA=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vC0Pu-00BufO-UY; Thu, 23 Oct 2025 20:52:06 +0200
Date: Thu, 23 Oct 2025 20:52:06 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>
Subject: Re: [PATCH net-next 8/8] net: stmmac: reorganise stmmac_hwif_init()
Message-ID: <d662bea8-2b16-4183-a2b9-e5946f83ae42@lunn.ch>
References: <aPn3MSQvjUWBb92P@shell.armlinux.org.uk>
 <E1vBrlg-0000000BMQS-0QYt@rmk-PC.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1vBrlg-0000000BMQS-0QYt@rmk-PC.armlinux.org.uk>

On Thu, Oct 23, 2025 at 10:38:00AM +0100, Russell King (Oracle) wrote:
> Reorganise stmmac_hwif_init() to handle the error case of
> stmmac_hwif_find() in the indented block, which follows normal
> programming pattern.
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

