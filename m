Return-Path: <netdev+bounces-138247-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 176CF9ACB73
	for <lists+netdev@lfdr.de>; Wed, 23 Oct 2024 15:41:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 932DBB21797
	for <lists+netdev@lfdr.de>; Wed, 23 Oct 2024 13:41:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89D1F1AAE02;
	Wed, 23 Oct 2024 13:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="hoBuPhCs"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0AE612B71
	for <netdev@vger.kernel.org>; Wed, 23 Oct 2024 13:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729690891; cv=none; b=hx2gu71GQKoTSVy8wZsbY/m2Pkxv1bpSUwutFL1LFaWWsFQ8fBa108xCxmEd+/jxbcc5gi09WqkJ93x/jz6EayllTjwcYa/aQnnNL7xc4t92lyogW5mRPoc15jwuDMbJ42RdQoUit1a4QRpS046n8YUuiNv+Qv1HWrzPDX7ZJas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729690891; c=relaxed/simple;
	bh=lEZi/t23+sJwkTnHRYVlC7SkLp2F6y8GPtaON0HJhno=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=egUajSTEwIzEZcfUVGTOec/lfmq2G9sPK+JTspjZXUuhAXpDikOOx5ou0mPhs15RoXaO6/jEQrittl2Wg+Z2Ih3D2/M1Z0WEZxMhoFfL4wOXQfZcWteJ831SZ2+Gi29uSSQVmGULzg1Pe0R4EjqEzfvR2RyZkttVvF9vmTaqWyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=hoBuPhCs; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=CfuCPykxNhwUmxI5KtslFkMAwUPu7B72Zr3LX4mpMvo=; b=hoBuPhCsr5/611SL0VNqa+EYS/
	QA3IxU+AVZ45FCHQU4+DIs8RqESnRcaVDLJEhDu6z1EYZQmdimFS3fZfXTbDnToblsbOFlAW2DXE5
	cPHNxaDTVhw/UwFPB3k2EqK8pz7SJmz1sNFChGeRJ2jD4xikRX4J7Uhi+831kHD6KdZECc3RCvIun
	H7OdbMUOPUwakUBh5pgdV/9YCQn28AntpeGIzNYXH4s1xpOlyNid+VV6XFyE2EmDceD8CrSQgqtrC
	bHye6dB6BhgNNp+m/vGqSJoArYYliztNSn5mogsPEt7hzB4C9pr61NCfIz3wlyK7UxDO1mLq62b6m
	GukjPrFg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:53268)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1t3bc0-0006Ua-15;
	Wed, 23 Oct 2024 14:41:20 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1t3bby-0003ja-05;
	Wed, 23 Oct 2024 14:41:18 +0100
Date: Wed, 23 Oct 2024 14:41:17 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net-next v2 0/3] net: phylink: simplify SFP PHY attachment
Message-ID: <Zxj8_clRmDA_G7uH@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

Hi,

These two patches simplify how we attach SFP PHYs.

The first patch notices that at the two sites where we call
sfp_select_interface(), if that fails, we always print the same error.
Move this into its own function.

The second patch adds an additional level of validation, checking that
the returned interface is one that is supported by the MAC/PCS.

The last patch simplifies how SFP PHYs are attached, reducing the
number of times that we do validation in this path.

 drivers/net/phy/phylink.c | 83 ++++++++++++++++++++++++-----------------------
 1 file changed, 42 insertions(+), 41 deletions(-)

Changes since v1:
 - Fixed build warning.
 - Added r-b/t-b from Maxime.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

