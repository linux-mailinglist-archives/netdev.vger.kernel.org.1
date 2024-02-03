Return-Path: <netdev+bounces-68858-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 767BB8488DC
	for <lists+netdev@lfdr.de>; Sat,  3 Feb 2024 21:53:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 07BC9284265
	for <lists+netdev@lfdr.de>; Sat,  3 Feb 2024 20:53:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D18610A1B;
	Sat,  3 Feb 2024 20:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="b0oNVtWN"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAB8CF9C1
	for <netdev@vger.kernel.org>; Sat,  3 Feb 2024 20:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706993613; cv=none; b=ijZqnUxk2S84qpgGEDrvcHck6t1qkeA37MsfV7pGqG3rqCzOlZ0Xcq+e/cyiS2CbjOrgSQya9eKS3GZ1EwTpHELQrxwHAMVE83w0O5k8LYtAwUjBd6pLN7rdIp1d0qNMDYbXZqQi2QFNDUXL6uDrocVeBuTxPg5TOQLKxLxaP5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706993613; c=relaxed/simple;
	bh=FP9TqIzrkZBCBUoJWJVKkr2jI7AoIvjhGcbd5JMn2sc=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=BAC6iIeZm0/81goa07BEp6X9eaJ5pTDnFkQVgRW+b3foEkzWz0/mev/nBgV7MMkbPZsUfCxbsXx0RV3QhlQM4Z4mFoLAdbwJYPG+MGzWzxup48itB1oTa/CK8/wLe7teNKTBqi5vMyDOgG2d0ebAI1agxjN5kGI0SbYRj3epT68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=b0oNVtWN; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=Cc:To:Content-Transfer-Encoding:Content-Type:MIME-Version:
	Message-Id:Date:Subject:From:From:Sender:Reply-To:Subject:Date:Message-ID:To:
	Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
	Content-Description:Content-Disposition:In-Reply-To:References;
	bh=Zfy0KMJXRNjkm1SfSA1Hn32Ds4Xy6i/3b04riJZveoQ=; b=b0oNVtWNoP+IN1DTMvuOQNKV+3
	/7kWVXkOeC7qyxYoCu5rzQ5Ofmu62IrgfmedObm99ddhyB+uU/LzRVD3+zxk/iGNdg1/Xs/ksvQrt
	GFDQ/39ebKPnA/Jt+q+zAizo2VLEP0dQyEkh4MMZGYyNNlimGCK1K47ApTutXtiptvt8=;
Received: from c-76-156-36-110.hsd1.mn.comcast.net ([76.156.36.110] helo=thinkpad.home.lunn.ch)
	by vps0.lunn.ch with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rWN0s-006vPr-P3; Sat, 03 Feb 2024 21:53:22 +0100
From: Andrew Lunn <andrew@lunn.ch>
Subject: [PATCH net-next 0/2] Unify C22 and C45 error handling during bus
 enumeration
Date: Sat, 03 Feb 2024 14:52:47 -0600
Message-Id: <20240203-unify-c22-c45-scan-error-handling-v1-0-8aa9fa3c4fca@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJ+nvmUC/x2NwQrCQAwFf6Xk7INtrGL9FfHQ3WZrQFLJVqmU/
 ruLx4FhZqMirlLo2mzk8tGis1VoDw2lx2CTQMfKxIG7wOGIt2n+IjEjdSeUNBjEfXZUe3yqTbi
 ElmM89zHmnmrn5ZJ1/T9uZLLAZF3ovu8/kKfcp30AAAA=
To: Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Florian Fainelli <f.fainelli@gmail.com>, 
 Vladimir Oltean <olteanv@gmail.com>
Cc: netdev@vger.kernel.org, Tim Menninger <tmenninger@purestorage.com>, 
 Andrew Lunn <andrew@lunn.ch>
X-Mailer: b4 0.12.4

When enumerating an MDIO bus, an MDIO bus driver can return -ENODEV to
a C22 read transaction to indicate there is no device at that address
on the bus. Enumeration will then continue with the next address on
the bus.

Modify C44 enumeration so that it also accepts -ENODEV and moves to
the next address on the bus, rather than consider -ENODEV as a fatal
error.

Convert the mv88e6xxx driver to return -ENODEV rather than 0xffff on
read for families which do not support C45 bus transactions. This is
more efficient, since enumeration will scan multiple devices at one
address when 0xffff is returned, where as -EONDEV immediately jumps to
the next address on the bus.

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
---
Andrew Lunn (2):
      net: phy: c45 scanning: Don't consider -ENODEV fatal
      net: dsa: mv88e6xxx: Return -ENODEV when C22/C45 not supported

 drivers/net/dsa/mv88e6xxx/chip.c | 4 ++--
 drivers/net/phy/phy_device.c     | 8 ++++++--
 2 files changed, 8 insertions(+), 4 deletions(-)
---
base-commit: d6aa8e0aa605a6baba08220e4a83fa2619a4c4d7
change-id: 20240203-unify-c22-c45-scan-error-handling-8012bb69bbf9

Best regards,
-- 
Andrew Lunn <andrew@lunn.ch>


