Return-Path: <netdev+bounces-86121-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41AD089D9B0
	for <lists+netdev@lfdr.de>; Tue,  9 Apr 2024 15:02:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 73A35B255EA
	for <lists+netdev@lfdr.de>; Tue,  9 Apr 2024 13:02:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6472D12E1F8;
	Tue,  9 Apr 2024 12:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="umM6X5LZ"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8985A12E1EE
	for <netdev@vger.kernel.org>; Tue,  9 Apr 2024 12:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712667580; cv=none; b=hU1FBVeZ8IDg3Mlv6b7+gVRPyMO7bCFV/tMS+ft5wuDaHZF2QWqBzFxWzJ9DlS3VnIrilrGNI2THFPTfFQQ47NX36roW6pyS3AZv1VDlXNNOYbReryfiTcQmheIq9fBpX3ImPzEL1bwKvQ8mn5Pe3Tw+0y7Qnmz/zLZ7SnGDMmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712667580; c=relaxed/simple;
	bh=jQJKiYpggXZsVIvtiU6FzaXSQIqNLDYtFSYQhKgi2gg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VSM9gybtz3QrvyRYRb1qmZljYJWIPhEUrjbUFyrwiqlCbHvMwKE4rG/Z5Srfc/BcH4NfaCV0tKxFf/Y8Gp+KhYeWYNYJ0F0WEo+oqjZ75JqUwhjIYgtFSz4eVH6EkF/Db38p5scRQ4Qc4ykxixmHGbT1qSiYtk2RtY5kukuuHQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=umM6X5LZ; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=PKdKIZDXiyhovL0/1WHUbsMIMdPri30JkTxtUvEKHtM=; b=um
	M6X5LZ+jihGlBcpkpLHUc6WjZ6Vl1vR0L+nbTQXR5aOORe/ZonSV0Hms5M5R3AJ2qpiJf35BABv0X
	HXjQNm+v3dY9cmZtG8e8lQlckkuaYz3PFeULMbIUVT4NmvlmllZHYxshI60eKawG8gnfiYfwNwJek
	60Irhm3EDKMmzpw=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1ruB4T-00CZiz-6r; Tue, 09 Apr 2024 14:59:29 +0200
Date: Tue, 9 Apr 2024 14:59:29 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Eric Woudstra <ericwouds@gmail.com>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>,
	Frank Wunderlich <frank-w@public-files.de>,
	Daniel Golle <daniel@makrotopia.org>, netdev@vger.kernel.org,
	Alexander Couzens <lynxis@fe80.eu>,
	Russell King <rmk+kernel@armlinux.org.uk>
Subject: Re: [PATCH v4 net-next 1/6] net: phy: realtek: configure SerDes mode
 for rtl822xb PHYs
Message-ID: <417f3e08-136b-47db-880b-c80aa5698c9b@lunn.ch>
References: <20240409073016.367771-1-ericwouds@gmail.com>
 <20240409073016.367771-2-ericwouds@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240409073016.367771-2-ericwouds@gmail.com>

On Tue, Apr 09, 2024 at 09:30:11AM +0200, Eric Woudstra wrote:
> From: Alexander Couzens <lynxis@fe80.eu>
> 
> The rtl8221b and rtl8226b series support switching SerDes mode between
> 2500base-x and sgmii based on the negotiated copper speed.
> 
> Configure this switching mode according to SerDes modes supported by
> host.
> 
> There is an additional datasheet for RTL8226B/RTL8221B called
> "SERDES MODE SETTING FLOW APPLICATION NOTE" where a sequence is
> described to setup interface and rate adapter mode.
> 
> However, there is no documentation about the meaning of registers
> and bits, it's literally just magic numbers and pseudo-code.
> 
> Signed-off-by: Alexander Couzens <lynxis@fe80.eu>
> [ refactored, dropped HiSGMII mode and changed commit message ]
> Signed-off-by: Marek Behún <kabel@kernel.org>
> [ changed rtl822x_update_interface() to use vendor register ]
> [ always fill in possible interfaces ]
> [ only apply to rtl8221b and rtl8226b phy's ]
> [ set phydev->rate_matching in .config_init() ]
> Signed-off-by: Eric Woudstra <ericwouds@gmail.com>
> 
> Reviewed-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Hi Eric

The ordering of these tags should put your Signed-off-by last.
Reviewed-by: should come before them, without any blank lines. As the
patch makes it way towards mainline, each Maintainer will add a
Signed-off: by, and it is nice to keep them together.

This is not enough to need a respin, but please remember this for
future patches.

       Andrew

