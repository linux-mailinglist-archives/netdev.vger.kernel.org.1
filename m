Return-Path: <netdev+bounces-153626-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DA8D9F8DF9
	for <lists+netdev@lfdr.de>; Fri, 20 Dec 2024 09:29:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B1D718965E1
	for <lists+netdev@lfdr.de>; Fri, 20 Dec 2024 08:29:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3538154BE5;
	Fri, 20 Dec 2024 08:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="q8x20Npe"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A6348632B
	for <netdev@vger.kernel.org>; Fri, 20 Dec 2024 08:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734683336; cv=none; b=SRs093Gf4mln9SJBStd273BClwpBEq9Bx3PvEdjwDpyhsz1m/iINneCd8VXRfo8ur0KCQR1TkH7vIrcdLhhItLfXm+TMXd1fN+qFSLBdJZ5GJUZBNvEjppM02H2weOxY54UcKiL9DOyMPh+mm/jkNOoIA5HEm6Ns5ZpMHyFy8W4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734683336; c=relaxed/simple;
	bh=pGVOodZuvJCORj4KEc7yjJf4tz5VvbIsrKERPiOoBno=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dQ2fsvRmwG97RDT5BQwwFoysPTjNHSU6fVpGrt0beqOAXMz9GH2NJ8LKom/Yaag9MMiGkYvHQdwxZQNhuw76wDsaklVI8cQ+rIGcZ7ouxBxqT7/4KBq3Lno7IQhPn+ugkAPDgp4En/rt3Js5/glga53dgy4QmE6V74Etk0J3G1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=q8x20Npe; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=m4ML8MgMvicfSQMVKSYcNXydXQnt0lwOObinM5smP80=; b=q8x20NpeOIk06jTly9NiF3dju+
	WotAMoirkZ5rMvarrgGGTHhj0v8ZGN3vORCN97A+CV97o83MCiN0O79SxDxcjgbapwBIygsx9gc9W
	eTppoC5XSjxgYArAZ8URzKWQjqJiv85cvAvwGzPK2AMo7DAqX0geIn3CporlvGWo92cI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tOYNO-001vEg-Q8; Fri, 20 Dec 2024 09:28:50 +0100
Date: Fri, 20 Dec 2024 09:28:50 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: "Sverdlin, Alexander" <alexander.sverdlin@siemens.com>
Cc: "olteanv@gmail.com" <olteanv@gmail.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH net-next] net: dsa: honor "max-speed" for implicit PHYs
 on user ports
Message-ID: <7d3e83e9-df2d-4fc3-9ee0-75c401555ffc@lunn.ch>
References: <20241219173805.503900-1-alexander.sverdlin@siemens.com>
 <20241219174626.6ga354quln36v4de@skbuf>
 <eb62f85a050e47c3d8d9114b33f94f97822df06b.camel@siemens.com>
 <20241219193623.vanwiab3k7hz5tb5@skbuf>
 <b708216ed804755678f01f62b286928763a1f645.camel@siemens.com>
 <ba41f79205ff4c0c90de71a6be2dd4e2e9ade0f7.camel@siemens.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ba41f79205ff4c0c90de71a6be2dd4e2e9ade0f7.camel@siemens.com>

> However, after reading the whole referenced thread, I still have a question:
> will MFD approach (with both drivers and dt-bindings) will be a requirement
> for any new drivers or a simpler approach with "mdio {}" node under the
> switch node will still be acceptable?

There is a long history of MAC drivers having MDIO drivers embedded in
them. So i see no need for an MFD just to have an MDIO device. If
there are additional drivers, GPIO, I2C, etc, then an MFD makes sense.

	Andrew

