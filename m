Return-Path: <netdev+bounces-155014-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D1F07A00A50
	for <lists+netdev@lfdr.de>; Fri,  3 Jan 2025 15:12:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AEBD53A366D
	for <lists+netdev@lfdr.de>; Fri,  3 Jan 2025 14:12:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BA1A1F9EB4;
	Fri,  3 Jan 2025 14:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="HjlnD0oz"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C57931F866F
	for <netdev@vger.kernel.org>; Fri,  3 Jan 2025 14:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735913544; cv=none; b=HKdfbWjrfUmhqc8DFiq49BXcPOOWnm+lM2kOlfausn4dpYAciKZkA/xDF8NdCooXeXIDFOfDLyaFwbMM9f1qnycKppCMmWFVvPsN/C1oRVqVXLEN+ID44FL7e/S64O8y8aiTe9UweVJ1U1WQPSskuTL8MbGg5t9TTUx8c3vh6fc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735913544; c=relaxed/simple;
	bh=ODFuCy+iX2AP+loWkgPxgpHyra0t7hssoSP/S/j+32Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BbnyY1tY1F/tSqQV1uSUxAfGXP/bcUW870NVw3HaVdiidrDwIbT6OGxWdyBhRjbW5DMYAqISOeHvnEF0AsvswUle2GhREbUmGt9Ho43VdfXf7jUnFpmJ3Ub9YsnTBd6zGC3NzSWScMJz95F9vtAxPeQE3Qkep1itU1Vlt8TD2UM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=HjlnD0oz; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=XN46AjO8IDneInfOG+KJ9O3S8oREzjDocSe9mDDvIHU=; b=HjlnD0ozwv8AD3BfQCO43re43L
	liAix/ZxCNDQugVKqxE7QTtIcKTt0iwI7NNJigkZ/VqlaM4xW8gx82NJ/Jt4uK0tH7NxqX60ebMrq
	/WeX5MxYU5TNSpFGUvYnQtaY6y7XEfzTPtFSEf4W+bkweg2kmlRMdO8Zg++9J8qxBJHM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tTiPO-0013bq-MC; Fri, 03 Jan 2025 15:12:14 +0100
Date: Fri, 3 Jan 2025 15:12:14 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Niklas Cassel <cassel@kernel.org>
Cc: "Russell King (Oracle)" <linux@armlinux.org.uk>,
	Francesco Valla <francesco@valla.it>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>, netdev@vger.kernel.org,
	Anand Moon <linux.amoon@gmail.com>
Subject: Re: [PATCH] net: phy: don't issue a module request if a driver is
 available
Message-ID: <cff14918-0143-4309-9317-675c18ad3a8f@lunn.ch>
References: <20250101235122.704012-1-francesco@valla.it>
 <Z3ZzJ3aUN5zrtqcx@shell.armlinux.org.uk>
 <7103704.9J7NaK4W3v@fedora.fritz.box>
 <d5bbf98e-7dff-436e-9759-0d809072202f@lunn.ch>
 <Z3fJQEVV4ACpvP3L@ryzen>
 <Z3fTS5hOGawu18aH@shell.armlinux.org.uk>
 <Z3fc2jiJJDzbCHLu@ryzen>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z3fc2jiJJDzbCHLu@ryzen>

> FWIW, the patch in $subject does make the splat go away for me.
> (I have the PHY driver built as built-in).
> 
> The patch in $subject does "Add a list of registered drivers and check
> if one is already available before resorting to call request_module();
> in this way, if the PHY driver is already there, the MDIO bus can perform
> the async probe."

Lets take a step backwards.

How in general should module loading work with async probe? Lets
understand that first.

Then we can think about what is special about PHYs, and how we can fit
into the existing framework.

	Andrew

