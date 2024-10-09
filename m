Return-Path: <netdev+bounces-133913-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D03499777A
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 23:28:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 180ABB2120C
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 21:28:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B7221E1A15;
	Wed,  9 Oct 2024 21:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="mt6VVG8h"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E180840849;
	Wed,  9 Oct 2024 21:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728509277; cv=none; b=ClYn53L6fcnbTIvCYhMZeKWAIkB8pJ/zl9M5NR4xeu71MBdHUN9RLFUkMZQ4iH5jhXUHVAfvF705F+tUx4gQMj0dwOkXQ0+Ng/lRuGMA82/ZtFjNlcgYJwN2R/0OGVra5OP09YpjdXcvumM8ZHnobFXxO+RTlKo+qjKN4BV4/g8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728509277; c=relaxed/simple;
	bh=ainHOw4Ua0qbGXmen8DD/3dmJodbMIUGFkPPxoCJcvM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EsCTV2s9vlvCTpYUd+eZL2MsILFVfcOUmri8jGSBEEDFVFxn1kyEnrw3I/DCcs2VkWMCvUHPwZyBMkLw/wc7zDBX+lMpM2D+JmyExxV2DXYfrg74emgzTBjCrv26vjsTkVLV9xMrtjnRSVZiot0PsS/iCEf5DokxZi/L3yz7w1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=mt6VVG8h; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=1ZHaiqEDhqVmUaU2flF6CKG/GFCPewK/7YW45FHwl2s=; b=mt6VVG8hicoCdxs+l5DuL861/E
	9wqwexImAPoInknT9yjguDi0Q1CLf6ijsOF+YC48tn5KT61UkdANeEA2sFIFxunN3e/ZBmZoMDwEw
	9gyiMvjO8GfsuJaCoy83kk+6GHC7BurcYhrnUD+flgsMrYEr/8KURN9K2f1nr/LBISN4=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1syeDQ-009XsP-3H; Wed, 09 Oct 2024 23:27:28 +0200
Date: Wed, 9 Oct 2024 23:27:28 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Aryan Srivastava <aryan.srivastava@alliedtelesis.co.nz>
Cc: Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v0] net: dsa: mv88e6xxx: Fix uninitialised err
 value
Message-ID: <78bedc6e-01fc-4d6c-8521-76e2b941c4a7@lunn.ch>
References: <20241009212319.1045176-1-aryan.srivastava@alliedtelesis.co.nz>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241009212319.1045176-1-aryan.srivastava@alliedtelesis.co.nz>

On Thu, Oct 10, 2024 at 10:23:19AM +1300, Aryan Srivastava wrote:
> The err value in mv88e6xxx_region_atu_snapshot is now potentially
> uninitialised on return. Initialise err as 0.
> 
> Fixes: ada5c3229b32 ("net: dsa: mv88e6xxx: Add FID map cache")
> Signed-off-by: Aryan Srivastava <aryan.srivastava@alliedtelesis.co.nz>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

