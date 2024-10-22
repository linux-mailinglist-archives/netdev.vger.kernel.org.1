Return-Path: <netdev+bounces-137886-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D8FE19AB004
	for <lists+netdev@lfdr.de>; Tue, 22 Oct 2024 15:49:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5DB6EB21BB5
	for <lists+netdev@lfdr.de>; Tue, 22 Oct 2024 13:49:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1F1619EEC7;
	Tue, 22 Oct 2024 13:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="R+vJSxPK"
X-Original-To: netdev@vger.kernel.org
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A90F719D06A
	for <netdev@vger.kernel.org>; Tue, 22 Oct 2024 13:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729604969; cv=none; b=HODNbZVT4hGOvfNSx1F0WUn8jigqsUgEpll907sZ81yhB+/nbHGuGwyip2VJm7Rfd3o8WCt/ybkKNnIkNTtvXmXbqRZ/v6m7yS71AfF7s0zUJ/GgmvSDHsVNpUQS/ICxBn8a9h8b/3h93AyVZEpsIkku8kJ0uFHdm4Y0Vihky2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729604969; c=relaxed/simple;
	bh=etFE/XfKfGNkTN4qkaZwpQOhDtNguvmO6cqjL3rLPOM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GFfZvaqFKO/QKRM6/JGn4Mypl+TrJLyhFhdXHD/+y80K3ZxmLP4i/EDCuF/wcrqq+NtGEQPUCW0nXFKDBHjnJEnrEac/ChfkRpxjN+j4EUd0I7qyyMnpE6+fSEE3ZlqaE8IbRFgAx/H6RvDvT0F+MS2Zp9hElGitA3BzfoeHSSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=R+vJSxPK; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id D2CADE0002;
	Tue, 22 Oct 2024 13:49:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1729604960;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=47/p2sA8sbnItiXsAesySBc8z1hmWvEQPxQ5ofraF90=;
	b=R+vJSxPKMfQO1PecGvk+W6ntGjnaEk/jNzky8bLvxcuC63a1WE9I8gvnPOiqfjqacj5YpA
	VkMyZlkRhafcbQj10wodUPp+BQCGQKEIt3PSTbI6IWhDHo3W5nwz9If8nZRQb2eLY2PhVz
	sCB7YWqono1iOfW75TLv1luuBClgEPjZ3nITZIAYa4JQPAzmk8P/u1AhrN8gkHINO9MjED
	eLiHvOuFSuxR/hoSd5Xv1fsGU29lORFIqerRxWm8wg8oNYfdutihZKo/RNMUPKNkv24w0j
	uEXrk66m7DnWx1qHE+c3KAteZPz4gE19YXTt2U5LnAPJv7n2akPgH4sKX5DYvw==
Date: Tue, 22 Oct 2024 15:49:19 +0200
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, netdev@vger.kernel.org
Subject: Re: [PATCH net-next 3/3] net: phylink: simplify how SFP PHYs are
 attached
Message-ID: <20241022154919.1dba3e1a@device-21.home>
In-Reply-To: <E1t3DSr-000Vxg-Qx@rmk-PC.armlinux.org.uk>
References: <ZxeO2oJeQcH5H55X@shell.armlinux.org.uk>
	<E1t3DSr-000Vxg-Qx@rmk-PC.armlinux.org.uk>
Organization: Bootlin
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-GND-Sasl: maxime.chevallier@bootlin.com

Hi Russell,

On Tue, 22 Oct 2024 12:54:17 +0100
"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk> wrote:

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

This is indeed cleaner and easier to understand, thanks.

Modulo the warning,

Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
Tested-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

Thanks,

Maxime

