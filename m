Return-Path: <netdev+bounces-86109-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58C8E89D97F
	for <lists+netdev@lfdr.de>; Tue,  9 Apr 2024 14:55:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C99428BFEE
	for <lists+netdev@lfdr.de>; Tue,  9 Apr 2024 12:55:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA2AA12DDAB;
	Tue,  9 Apr 2024 12:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="wCQN7SfI"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDB8312D777
	for <netdev@vger.kernel.org>; Tue,  9 Apr 2024 12:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712667343; cv=none; b=MQazko4fq7iFPfzMYKba2PFkxkfk5GEU2Quez8CXe1xEqZr6WVtHZ8zSsk/LAFuNyZsIxvIAhUQ09k4XwNnhqCGJChIdqdE/xQxpqHZy4JfPrinNuqg+LvH46U5a3yecJbumFy3QI0nHhEIdLuZ8oBwC8FyaKiKzbwu4QWdS0OQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712667343; c=relaxed/simple;
	bh=vBJ0xFgJsDo3bbQXI7hHS1JyyAU59bvchgwyDnCExXg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DFeCsN0Zhz6wOUFFT53rED7KvHehGMB+uQFzfgJ7nmkUVpZTPBgjS37oeI3VLGLKGf5atDHkIKsiqjaSUcmc/jvAiLzbpzl6h0oof6lx3PJMhqkaZBLzNk6bvwnVYOytQlSeStrDAWX8QoT2DvfAYtnDTTMBw4MC/u00g7SvytA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=wCQN7SfI; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=cOau3DCxDmlovr9V4Z5T4Er7NsMGvlJeGMOY+E8+5lc=; b=wCQN7SfIvX27rKJwlf/WL7P2tY
	zBJKVajKu+CFP+AYpq540JgRMgr5PdT1rD2VaJjOgxVcBRfSs4NKf1X4Il02XwiHSNLQd1sodMmFp
	BriITPm3EY/hr3VJNBWxZ1cvtfMKbFJVlu2xk+qZmOGJ/EdTlsoeUpA7tsX9IEBu/ea8=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1ruB0a-00CZeY-50; Tue, 09 Apr 2024 14:55:28 +0200
Date: Tue, 9 Apr 2024 14:55:28 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Eric Woudstra <ericwouds@gmail.com>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>,
	Frank Wunderlich <frank-w@public-files.de>,
	Daniel Golle <daniel@makrotopia.org>, netdev@vger.kernel.org
Subject: Re: [PATCH v4 net-next 5/6] net: phy: realtek: add
 rtl822x_c45_get_features() to set supported port
Message-ID: <8f5a72d4-639f-4996-b686-288c65a782dd@lunn.ch>
References: <20240409073016.367771-1-ericwouds@gmail.com>
 <20240409073016.367771-6-ericwouds@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240409073016.367771-6-ericwouds@gmail.com>

On Tue, Apr 09, 2024 at 09:30:15AM +0200, Eric Woudstra wrote:
> Sets ETHTOOL_LINK_MODE_TP_BIT in phydev->supported.
> 
> Signed-off-by: Eric Woudstra <ericwouds@gmail.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

