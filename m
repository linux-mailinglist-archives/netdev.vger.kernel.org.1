Return-Path: <netdev+bounces-108482-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 64EF0923F35
	for <lists+netdev@lfdr.de>; Tue,  2 Jul 2024 15:41:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 94EF01C21FCE
	for <lists+netdev@lfdr.de>; Tue,  2 Jul 2024 13:41:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6439A1B4C41;
	Tue,  2 Jul 2024 13:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="cCTD0IQD"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CB1318755A;
	Tue,  2 Jul 2024 13:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719927644; cv=none; b=Fko450wi8vyJ9Vhu53GPg5XpCeXgkhhSxDWK1eLUGLXvoIvBgJBnClIo0JQpFuwK2xVMe/1mqhbtpEPVww7LImIESBdgURuDqYGbzNNUs9xErvvRaOTeCDYuBxehpJWrkJWuv9NVD2km6X4Yl0/wAIytkOXg4WEOsfL/0WBjcuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719927644; c=relaxed/simple;
	bh=AU/qdBOM6SXuHEJq9Agt49uegv1H+uuZp34OljBygFo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dBaNZIksJo4HhFth9kpi6tNmEsAt7D323XVLcVgn4D3O7WMsNcr40c+upMZRibSIPQYwRwpJZPQO3QmPCOAVYsJFP4lMhJueOJ3yu7oRfrJLxL6H++ZL3Tc/AKNNpc4KGzyCInx7xaiLlM2WDwvYVlBF/H4HgagFCEy1z1Juylw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=cCTD0IQD; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=e4kZhyAqPLnjl0fZjSn+t21vrlos4A4MwU5pTA+wAIo=; b=cCTD0IQDupZaLwcS163PyH2DnE
	m1NGQ89xRwsjEC2RrxXZ1r0PREHCDdJNa0Csj1rorQ2E+eB3UCXHwiJjKq6Yo6JDyGbgNPERJIpHa
	KTOvWDpyXfELY+FWoA9rHf8+iTaXLEq2jaUNBtZX4DlyNdHtGKg0EoeY09x/4bT4gyPU=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sOdkB-001dpn-Jm; Tue, 02 Jul 2024 15:40:27 +0200
Date: Tue, 2 Jul 2024 15:40:27 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Michael Walle <michael@walle.cc>
Cc: Aleksandr Mishin <amishin@t-argos.ru>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org
Subject: Re: [PATCH net v2] net: phy: mscc-miim: Validate bus frequency
 obtained from Device Tree
Message-ID: <1c7eefe0-7262-45a0-b734-39b9202adfc5@lunn.ch>
References: <20240702110650.17563-1-amishin@t-argos.ru>
 <20240702130247.18515-1-amishin@t-argos.ru>
 <D2F2Y45Y1LQS.8GN3PG7ZYAPB@walle.cc>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <D2F2Y45Y1LQS.8GN3PG7ZYAPB@walle.cc>

On Tue, Jul 02, 2024 at 03:16:21PM +0200, Michael Walle wrote:
> Hi,
> 
> Please post a new version of a patch at the earliest after 24 hours,
> so reviewers got a chance to reply.

Just adding to that, please also read:

https://www.kernel.org/doc/html/latest/process/maintainer-netdev.html

	Andrew

