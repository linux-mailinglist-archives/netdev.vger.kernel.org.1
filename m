Return-Path: <netdev+bounces-166836-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E8E7A377F4
	for <lists+netdev@lfdr.de>; Sun, 16 Feb 2025 23:01:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 74D207A3C58
	for <lists+netdev@lfdr.de>; Sun, 16 Feb 2025 22:00:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16D40481CD;
	Sun, 16 Feb 2025 22:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="PF5JxTjZ"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1E0D23BB
	for <netdev@vger.kernel.org>; Sun, 16 Feb 2025 22:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739743266; cv=none; b=e15wy1HR1Np0umU2oBmq5p9wT2+xH7hOf2MBtDIhVs4wp6xFnW0Nch5x65IZaggwPjaGtUUj0zr6UaH+U8W5fSaLFFMtlvfBe6DlWY0Ck4JhhY8pxleVyxjTl14QGgzVPbKYtFwQokka1e1AQjkmrftWxXj2NPwXTAgwZLVmR0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739743266; c=relaxed/simple;
	bh=InQY2NsA52H8M0uCiCKAEXjmzCt9fHEO55hRWn7w4ww=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XntRNMIRuwg9SKf5pHPKK/CMj/xICw53YofrIriTmP3eM+S6Zja9kdf4vfOdYN1TFpBCoNn61Bq07uwuz0/V5fkuCvEVd6XDUUc5mBcIDE1gkEb9HfBXuObg0yFeqYZFo1J+CUQB4u4T3jWyTBuVaJJD0eWh/iqIPhgKvn1XSAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=PF5JxTjZ; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=OH2gKBs19qU34hrEJw4FLolsoYqjaTqxFWF7b4gfdyk=; b=PF5JxTjZ7k3WdDiJY3IONZPt6K
	KVDCwpCZ+TMe3BQqOJHdDbSkBCvXdfDKfe75fTYX5z8ReyTLfjlxTTA7tAMO6gEdF1iKKpuk9aMaV
	0dzbgSo+23Jboiy0HNm5F0xn2Ka3uHYPTgrGoFgfR0k0vmTibsd0VBSS9fw3hcAPy2wI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tjmh3-00EldG-CQ; Sun, 16 Feb 2025 23:00:53 +0100
Date: Sun, 16 Feb 2025 23:00:53 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Russell King - ARM Linux <linux@armlinux.org.uk>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	David Miller <davem@davemloft.net>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH net-next 2/6] net: phy: improve phy_disable_eee_mode
Message-ID: <1e86f9db-5501-4e09-a52b-b1c12ffda1f4@lunn.ch>
References: <3caa3151-13ac-44a8-9bb6-20f82563f698@gmail.com>
 <92164896-38ff-4474-b98b-e83fc05b9509@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <92164896-38ff-4474-b98b-e83fc05b9509@gmail.com>

On Sun, Feb 16, 2025 at 10:16:34PM +0100, Heiner Kallweit wrote:
> If a mode is to be disabled, remove it from advertising_eee.
> Disabling EEE modes shall be done before calling phy_start(),
> warn if that's not the case.
> 
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

