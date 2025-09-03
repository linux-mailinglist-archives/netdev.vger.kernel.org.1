Return-Path: <netdev+bounces-219392-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BCAAB4118D
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 02:56:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 50BED1698E4
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 00:56:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3AB819AD70;
	Wed,  3 Sep 2025 00:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="GVPROCOW"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 958DB14EC73
	for <netdev@vger.kernel.org>; Wed,  3 Sep 2025 00:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756860994; cv=none; b=LQwgz0HUjyu56waM3juvzWIUko0ppBugm/7SN06BzAHMauLkOjNy5tKWVoIAgF/3w/lDW9CofaUU2MEzmenuaGPgO+q2O6GE8m/wqQQTZ4lUnm0LFi8ggofya2LSBn9A5XaSfphDIBIvXlRyKJco4Mhb3Vvf5/8Z8akDashJWtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756860994; c=relaxed/simple;
	bh=gPhCxzWMjP/B+FOPWFrqf3deDMIx9iPYPxX74D8xUc4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oqOEd6i0pPiBB48jaocVO9whMBNlatuD+R1ZamQkgQC2Ee0jV23tSzB+MMaS7tnQgI05vH2G9MJScm+d6icoukvGZJNFPMFnQe0/3tiaS1INWgn9El/Cw0fSMBH4ngXNFiQ16IFNaLmfybqqRJey+lNwE1ZWdB3WT82hafKYNcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=GVPROCOW; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=esIdmYBzlmv5MWRKYcVnNuB30BAfo1cI9pH/WHwInoI=; b=GVPROCOWmpmOB2/pkEv5Ttg0pv
	b8RIcNQLwZG12DNItSoSJnvOxhFZgnXTeLo55XnzyzZC5xRFWHoGw26CbNESIRpdq3pWtKiUXDgwB
	zkgbi4J5FwkvDBgJcEoJfkbSYMvVVhk9rZwJ8+6PN8sK5s8igTNzT6g1DJ/gPCOOZ9gI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1utbnW-006xK3-4q; Wed, 03 Sep 2025 02:56:26 +0200
Date: Wed, 3 Sep 2025 02:56:26 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net] net: phylink: move PHY interrupt request to non-fail
 path
Message-ID: <093c8097-2b74-4678-a9b0-08f1ab0add63@lunn.ch>
References: <E1ut35k-00000001UEl-0iq6@rmk-PC.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1ut35k-00000001UEl-0iq6@rmk-PC.armlinux.org.uk>

> +	if (ret == 0 && phy_interrupt_is_valid(phy))
> +		phy_request_interrupt(phy);
> +

ret == 0 is a bit of an anti pattern, but O.K:

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

