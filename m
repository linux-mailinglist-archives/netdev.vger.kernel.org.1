Return-Path: <netdev+bounces-137856-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 69A429AA18E
	for <lists+netdev@lfdr.de>; Tue, 22 Oct 2024 13:58:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E8B81F236A7
	for <lists+netdev@lfdr.de>; Tue, 22 Oct 2024 11:58:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94E7A19CC31;
	Tue, 22 Oct 2024 11:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="kbjShftX"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 102D019AA53
	for <netdev@vger.kernel.org>; Tue, 22 Oct 2024 11:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729598293; cv=none; b=ZXfJqi+CHaDRLGCzi/V348UYxLMkw1nXh+pJnoit6J763FYwBusLmzDovdS8EBm0YxLs6lsZqHueOTwXe38/kD++2a88DJmb9F9wY8l+CUCbQgy5LdgJ/CL8MOMFcfwnxQPvoyJkzkfQ6QhJhDOyWnN/frc+mIKznrb6pVRXUdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729598293; c=relaxed/simple;
	bh=jJFR+jUlwTxMRU746TdrJZP2T/LCOrSXj0r45vKD38E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qdJAci4R4nNJ0QfWCPcFnSEuc4QAKL0DvdmMc0Ub2Sg4TXm3THuk7P70z7Lh/t/k5Fa9GZPnaFCZ4NNwacmIuwJoe7JifF31CW/Wqfj/wS+V5ZGeH3RHtUi+4zOtEbUiWx8PItB+cHh/CGFhNlbqvBvpaBbM7KXpoNiB5hESxpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=kbjShftX; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=Vbae9TUZh4nzVawQw8auzmrsmjIE3kAp9FUh4/x1Dtw=; b=kbjShftX0BVTqN5F21DlpbVYgw
	PhcA2dgvs6LeifyDPZ4gjzOX+XYGkDQ7RTXocga3KzoOrFA+q1J9TwghstjyfPFgk69fjBAyyWu1v
	pmpHckHVHQn1+2WLfZ7kHyNtvPMN9xm62zjfJSYcm1rnQJkXnuu7x+4hWu/0neZLaxroND6Qha/0G
	UNOhlKs7gtgUTw5nhKIzmbJXLE8tXzD5tn1vfvTjtxM3WBKsFcOF+3qjmPTZztkifZRYPB3XpmD0M
	RdtCPdK5sAfkbF+6nDLl5siU4Nsr8p0+RKq3QZuvnpqv9ZoFr/T7UrtKM6J3IX1pvrA/ULqh4FqqK
	q9iSUXhQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:58388)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1t3DWZ-0004oz-15;
	Tue, 22 Oct 2024 12:58:07 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1t3DWY-0002gp-05;
	Tue, 22 Oct 2024 12:58:06 +0100
Date: Tue, 22 Oct 2024 12:58:05 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Subject: Re: [PATCH net-next 3/3] net: phylink: simplify how SFP PHYs are
 attached
Message-ID: <ZxeTTTrU7VyUxYwk@shell.armlinux.org.uk>
References: <ZxeO2oJeQcH5H55X@shell.armlinux.org.uk>
 <E1t3DSr-000Vxg-Qx@rmk-PC.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1t3DSr-000Vxg-Qx@rmk-PC.armlinux.org.uk>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Tue, Oct 22, 2024 at 12:54:17PM +0100, Russell King (Oracle) wrote:
> There are a few issues with how SFP PHYs are attached:
> 
> a) The phylink_sfp_connect_phy() and phylink_sfp_config_phy() code
>    validates the configuration three times:
> 
> 1. To discover the support/advertising masks that the PHY/PCS/MAC
>    can support in order to select an interface.
> 2. To validate the selected interface.
> 3. When the PHY is brought up after being attached, another validation
>    is done.
> 
>    This is needlessly complex.
> 
> b) The configuration is set prior to the PHY being attached, which
>    means we don't have the PHY available in phylink_major_config()
>    for phylink_pcs_neg_mode() to make decisions upon.
> 
> We have already added an extra step to validate the selected interface,
> so we can now move the attachment and bringup of the PHY earlier,
> inside phylink_sfp_config_phy(). This results in the validation at
> step 2 above becoming entirely unnecessary, so remove that too.
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

There's a build warning in this patch, which I'll address - but please
let me have any comments in the mean time.

>  static int phylink_sfp_connect_phy(void *upstream, struct phy_device *phy)
>  {
>  	struct phylink *pl = upstream;
> -	phy_interface_t interface;
>  	u8 mode;
>  	int ret;

"ret" needs to be removed.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

