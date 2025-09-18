Return-Path: <netdev+bounces-224618-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF272B86F49
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 22:52:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C9FE3BA952
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 20:51:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E7A82E8B8F;
	Thu, 18 Sep 2025 20:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="GItBVG+n"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C65F0214A9E
	for <netdev@vger.kernel.org>; Thu, 18 Sep 2025 20:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758228717; cv=none; b=nXoM+crdH8/e6gCTrcMj0Q/m3jyiTvI4ihVJZ4JF5+cgoAglwOBq5eQH0diZUd+IaSkwGX1gYseWnaNnQ26ZFm0P6hI/TyPFHT+tFe5I1wHyrlON7007+YJECK4PfZV0kP3if88dj9RPmjgn9v3uNW3Ytm4V3Qig1ZsWYzEkXkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758228717; c=relaxed/simple;
	bh=Vit21GTUZEmvPk/eii4c8F6o5hK9lVP7aTT67/pQ9XQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W8O7R0lqa3YH5KxcNsynv+RHViJ4Q7hUBUKMvWM8s+5SU6EVcDG1Ct7vDMrTDYThPgaQeMRP8mDIFZCsVb3YENDn7DrEtd1W87/+k07GaD3iEbocj4pdWitbrIfbo5hINni3EbqeoMUH3RzLD8uqAwZvdynZcpuLB5lq5ydXLe4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=GItBVG+n; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=IF9XtQmdE2mCa4u4gSsYmKxesfhRhpyslfjvoPaqexo=; b=GItBVG+nWtIp4kHHa9uzX1p1mF
	gx1CW0h1R+dS+dZTSMIpiLPDG0ZpwnA4P3jF5/2SMmrTJypVdKpg0F6+bEfh2/smF+lynoLmBj9W+
	sE9NV7ZMSIeGflk2visXsOcPWtwF2VLtNjBTTI6smwNvEVEdXNsYDiUJxnFC/sN9qkt4=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uzLbd-008sM7-JD; Thu, 18 Sep 2025 22:51:53 +0200
Date: Thu, 18 Sep 2025 22:51:53 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>
Subject: Re: [PATCH RFC net-next 08/20] net: dsa: mv88e6xxx: convert
 mv88e6xxx_hwtstamp_work() to take chip
Message-ID: <ddb6a45f-009c-4bb7-831d-4281c79970a4@lunn.ch>
References: <aMxDh17knIDhJany@shell.armlinux.org.uk>
 <E1uzIbU-00000006mzo-3MJE@rmk-PC.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1uzIbU-00000006mzo-3MJE@rmk-PC.armlinux.org.uk>

On Thu, Sep 18, 2025 at 06:39:32PM +0100, Russell King (Oracle) wrote:
> Instead of passing a pointer to the ptp_clock_info structure, pass a
> pointer to mv88e6xxx_chip instead. This allows the transition to the
> generic marvell PTP library easier.
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

