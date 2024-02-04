Return-Path: <netdev+bounces-68917-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B7A96848D63
	for <lists+netdev@lfdr.de>; Sun,  4 Feb 2024 13:13:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7305E282F6B
	for <lists+netdev@lfdr.de>; Sun,  4 Feb 2024 12:13:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F177321A0D;
	Sun,  4 Feb 2024 12:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="D3umHcB1"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C33422314
	for <netdev@vger.kernel.org>; Sun,  4 Feb 2024 12:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707048787; cv=none; b=b0mQrD4PXlJWvJntv/I7CuayFfddvbROnimKrJNU6ZNK8ywWL6dYoA0WIHM++Ytk3HU/1agmwR0Y+lhBVAFBhYlRHl3qny5KiS/j21C/3gwI8ZIvWV93H+AMuxE+y1UcsfZE+X2Ni0a3kJp/UazlPdanHhxsFV/q35OzTysCicY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707048787; c=relaxed/simple;
	bh=+qpV0ZAJj4JC7FuQfcBABDiQcEhxFhis8pMQzdmbspc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=ZxrELjPHp2HNyMau8HbwNUlw758mjgYDjX+8KAcnMdfhgULXVUv+zM2rvXIzI5/xifWgGtCAf+jZuGO2eKyiuvQQpw4wNEf9HE3DtKo02EQuuuCeLwQVMhapqvuMesC+qKc9UppIvR9RxVZwHqW6JqpA4/s5Jbqk0uQ28WH2Iqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=D3umHcB1; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=tfFGQOv5/GrEK0+zIwugqFLOB+gCx2wHcbHq6NIW+nA=; b=D3umHcB1QiRfAsodNiW0F/EiA3
	N3PiKr6gAVsu+YU/rw0WbxSwT6//3WFYU8I6qjtJBUC5S97kCGEmR7iENHpIOtG1w6jIxOeR4bClY
	V8unQnz0io3vRrv/ka7MEEB1qP5lBrSkQ8iR1Uma/PnrHJFvgNYzebSHbiG3N1EaIUumRx0b5wB++
	NpCxx0JzT1ZlHpuZSUERS9/vnBWzim/kUEJaCcVkWahed6YZrzGVDs4GYfkng6dHdQERV0lruNxHt
	ThzezR/v8iye6UN2NHTK1uKRnNnwk5nQEZk8CZ7kAPQtk4FWvvxsCnaqlRtkWSFNlkckTiyB/ZIxG
	LiYvTmLw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:55160)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1rWbMf-0007vK-34;
	Sun, 04 Feb 2024 12:12:51 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1rWbMZ-0001ke-TI; Sun, 04 Feb 2024 12:12:43 +0000
Date: Sun, 4 Feb 2024 12:12:43 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	bcm-kernel-feedback-list@broadcom.com,
	Byungho An <bh74.an@samsung.com>,
	Clark Wang <xiaoning.wang@nxp.com>,
	"David S. Miller" <davem@davemloft.net>,
	Doug Berger <opendmb@gmail.com>, Eric Dumazet <edumazet@google.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Jakub Kicinski <kuba@kernel.org>, Jose Abreu <joabreu@synopsys.com>,
	Justin Chen <justin.chen@broadcom.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org,
	NXP Linux Team <linux-imx@nxp.com>, Paolo Abeni <pabeni@redhat.com>,
	Shenwei Wang <shenwei.wang@nxp.com>,
	Vladimir Oltean <olteanv@gmail.com>, Wei Fang <wei.fang@nxp.com>
Subject: [PATCH net-next v2 0/6] net: eee network driver cleanups
Message-ID: <Zb9/O81fVAZw4ANr@shell.armlinux.org.uk>
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

Since commit d1420bb99515 ("net: phy: improve generic EEE ethtool
functions") changed phylib to set eee->eee_active and eee->eee_enabled,
overriding anything that drivers have set these to prior to calling
phy_ethtool_get_eee().

Therefore, drivers setting these members becomes redundant, since
phylib overwrites the values they set. This series finishes off
Heiner's work in the referenced commit by removing these redundant
writes in various drivers and any associated code or structure members
that become unnecessary.

v2: Address Andrew's comment on fec_main.c

 drivers/net/dsa/b53/b53_common.c                     | 6 ------
 drivers/net/ethernet/broadcom/asp2/bcmasp_ethtool.c  | 4 ----
 drivers/net/ethernet/broadcom/asp2/bcmasp_intf.c     | 5 +++--
 drivers/net/ethernet/broadcom/genet/bcmgenet.c       | 8 +++-----
 drivers/net/ethernet/broadcom/genet/bcmmii.c         | 5 +++--
 drivers/net/ethernet/freescale/fec_main.c            | 4 ----
 drivers/net/ethernet/samsung/sxgbe/sxgbe_common.h    | 1 -
 drivers/net/ethernet/samsung/sxgbe/sxgbe_ethtool.c   | 2 --
 drivers/net/ethernet/samsung/sxgbe/sxgbe_main.c      | 1 -
 drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c | 2 --
 10 files changed, 9 insertions(+), 29 deletions(-)
-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

