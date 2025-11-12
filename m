Return-Path: <netdev+bounces-237937-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A4538C51C49
	for <lists+netdev@lfdr.de>; Wed, 12 Nov 2025 11:50:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 195B14E461B
	for <lists+netdev@lfdr.de>; Wed, 12 Nov 2025 10:42:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E60D1304BA4;
	Wed, 12 Nov 2025 10:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="OEJ3/0DP"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7564F3016F1
	for <netdev@vger.kernel.org>; Wed, 12 Nov 2025 10:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762944136; cv=none; b=PRhcMsDhpo0mgOJl2VOKGdxn3vnWIsjMEUXM/fjeTQWCP8gB4iXqQqYlVq2O8SpyyYBntDlJ6wwLaHrT82Fofg6v4Iw6Baf0689p5h3N3WUSSIwDvziv74tm42k9QmOj3tHfham6lsp0HVPCV7r3SaW8u5kYLcBgVs7cf8Va73U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762944136; c=relaxed/simple;
	bh=4kN8XAEEDnSZZKTk+IUS9jDVN59dSwhqCW0ogRfntzE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u72i2D57836kBa6fApDQ4TsfK9/AGwspwIbUhIQkvu/Ld0UExeIF6OReA+YYw1PT+u+jvaMklK4vTTfR0VCv2UGw7hlMZgpvlXUuSVAA2dm5XSt6gbIi3n5Kq4u+z6TwcCW916Bmi2e7AsCMvf9DaSY8nwc3dWKkDZVEFejbOic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=OEJ3/0DP; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=8JEvk4+E9wPzGWMymfchoeMcAXIpJdIFMuVl+ty9xtg=; b=OEJ3/0DPP7YQ/wSy+UeXLkUgqs
	1lh5VcPGZxLCx7iSIKukbUKXQN+c5Hkut7gchek0YtRnrjKjT8DTawkbMRHIZxEKLuzeeUo4D3qAd
	UrWVDqTFz5jNeeVtJOJmmFudCv2+zt2fjLU8Yh/hwI80VfjuwIpOZXfPV9NVtu4sPuEGHilxJDQaX
	ZdPDRlKFdWyv+c9U9hPP4bwH5fk5cTI9yO9KA/GE7EhuUWS1tlup1GQRoVKiB20XSFXdUrEV9XTv5
	8EfY1r4kX02ssups+cW9bR1XgDgVAintB83bwBjiM33mqjmPy5EM6n+pCDdsG1pY8UDCBiHoOUnRB
	a1Daa4tg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:39768)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1vJ8Ij-000000003jn-3s3B;
	Wed, 12 Nov 2025 10:42:10 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1vJ8Ih-000000003ox-060E;
	Wed, 12 Nov 2025 10:42:07 +0000
Date: Wed, 12 Nov 2025 10:42:06 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Alexander Duyck <alexander.duyck@gmail.com>
Cc: netdev@vger.kernel.org, kuba@kernel.org, kernel-team@meta.com,
	andrew+netdev@lunn.ch, hkallweit1@gmail.com, pabeni@redhat.com,
	davem@davemloft.net
Subject: Re: [net-next PATCH v3 02/10] net: phy: Rename MDIO_CTRL1_SPEED for
 2.5G and 5G to reflect PMA values
Message-ID: <aRRkfg6zKW5gAOz6@shell.armlinux.org.uk>
References: <176279018050.2130772.17812295685941097123.stgit@ahduyck-xeon-server.home.arpa>
 <176279047080.2130772.6017646787024578804.stgit@ahduyck-xeon-server.home.arpa>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <176279047080.2130772.6017646787024578804.stgit@ahduyck-xeon-server.home.arpa>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Mon, Nov 10, 2025 at 08:01:10AM -0800, Alexander Duyck wrote:
> From: Alexander Duyck <alexanderduyck@fb.com>
> 
> The 2.5G and 5G values are not consistent between the PCS CTRL1 and PMA
> CTRL1 values. In order to avoid confusion between the two I am updating the
> values to include "PMA" in the name similar to values used in similar
> places.

As this us UAPI, please _add_ new values with _PCS_ and _PMA_ infixes
rather than renaming existing definitionsi.

Thanks.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

