Return-Path: <netdev+bounces-120282-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E3D5958C8C
	for <lists+netdev@lfdr.de>; Tue, 20 Aug 2024 18:44:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2AB97284099
	for <lists+netdev@lfdr.de>; Tue, 20 Aug 2024 16:44:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96E6C1BC080;
	Tue, 20 Aug 2024 16:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="DS30kPZC"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDBD818F2C1;
	Tue, 20 Aug 2024 16:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724172257; cv=none; b=aMrTO0Si8M5fl/dAUuYX+SBN70wWKD3po2ZjAjpUiX+H2+KNQyj3vo+ZC5heZeiRmZGsZcW7VoBBaBocARY5G003zdkcl0ogkH9I6FkAvQWhei/piHTTec/jPzANAlNYYkdriMS1HV1U43TEgBUhoM6nLc1nvayMNTh68GF8zts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724172257; c=relaxed/simple;
	bh=Qjj+9izp25TvBwBsTDLF/yJMu6CH193oiwUSa0qDnBQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kBZGT8BRf+Y6wpBkkPXigM9kVxfC9MFDYlMYrxKkajydpCvDKuK9vxI58Rv6LE1wWJkIUcwYm3BU0c+lNGJxyKwe3AibeYzps3HtiaaPaDPBl1QoiFLaEevf8Vv6hig8Z7jy5u7iXlNHD21H4/rJpOXOL+C6XnHV06Lvvotze/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=DS30kPZC; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=uNp8JfQZ/CsGVg0YHtSg5nn6B5Br8vXTZ9T6ZhVYxEw=; b=DS30kPZC3xo53vrpQGvXLsHWnw
	JHMLtMLZDlSaA43KSh3pf4DF/Ey80GLTNE6q7ELV2MarWQMFtAvNZFJ9/8exNeocFPs6vNhnLoFfJ
	kv1uNTi2RwR7sp3cl49p4OXuEeg/N3QoVWeJnlf0obVPIzbD6e6lae1/mkd6GNaay8Cg=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sgRxj-005FQU-OC; Tue, 20 Aug 2024 18:44:03 +0200
Date: Tue, 20 Aug 2024 18:44:03 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>, kernel@pengutronix.de,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	Russell King <linux@armlinux.org.uk>
Subject: Re: [PATCH net-next v2 2/3] ethtool: Add support for specifying
 information source in cable test results
Message-ID: <426c06ae-90f7-4a58-84e1-aa9389578c60@lunn.ch>
References: <20240820101256.1506460-1-o.rempel@pengutronix.de>
 <20240820101256.1506460-3-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240820101256.1506460-3-o.rempel@pengutronix.de>

On Tue, Aug 20, 2024 at 12:12:55PM +0200, Oleksij Rempel wrote:
> Enhance the ethtool cable test interface by introducing the ability to
> specify the source of the diagnostic information for cable test results.
> This is particularly useful for PHYs that offer multiple diagnostic
> methods, such as Time Domain Reflectometry (TDR) and Active Link Cable
> Diagnostic (ALCD).
> 
> Key changes:
> - Added `ethnl_cable_test_result_with_src` and
>   `ethnl_cable_test_fault_length_with_src` functions to allow specifying
>   the information source when reporting cable test results.
> - Updated existing `ethnl_cable_test_result` and
>   `ethnl_cable_test_fault_length` functions to use TDR as the default
>   source, ensuring backward compatibility.
> - Modified the UAPI to support these new attributes, enabling drivers to
>   provide more detailed diagnostic information.
> 
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

