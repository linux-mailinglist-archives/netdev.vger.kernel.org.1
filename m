Return-Path: <netdev+bounces-233697-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E8BD3C17731
	for <lists+netdev@lfdr.de>; Wed, 29 Oct 2025 01:02:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0EFE84F142C
	for <lists+netdev@lfdr.de>; Wed, 29 Oct 2025 00:01:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 853848F5B;
	Wed, 29 Oct 2025 00:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="Vyad4FrE"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87003A41
	for <netdev@vger.kernel.org>; Wed, 29 Oct 2025 00:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761696096; cv=none; b=CzKGHvYeMRzCUpm60CF39Bwrl2MPvmQqI/DOU0+bjHmQTjVVi2K/DPQHo27lK2SokqWzz2gN7baryFKbDuZzvQEIz7TlvCcz3RBsp0qQjs4uAMOz1P8SYVwJ2Hr30/mamuIyINrtmTXAFy8DM3u0rVZVcbm89gpVdYV8O/7bRVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761696096; c=relaxed/simple;
	bh=8mVwAQHQcMN7XIIFIbLD9IFQQThwuKYQQA3VP/7U9CI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=FNRCdqwkEEK6/nzLWs5jBtjiZCK0Iut8yeR0klJSM5gKJlbUDCAA8mEJ8EaC2mj3yKcugK7JiGZ/0fqjYhBvDQxZ8WWbYDhnsLvxqEL5X0Izp7SUgXURUXXPsH2mmis/e5xZtXi6/EkTHT5/ULkYPDpUFQoTXxwuIoxnGJFkbIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=Vyad4FrE; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=M3WA5E7+cy9RohdVFrjxmxJVZbOtCukuTF1uMkF0/0U=; b=Vyad4FrEExaL7FkATlCAhSO1Tm
	SdG0BZo7VdEY0Tt0bvik1+wXq6izLDz10l+Gh+ibkFdT8pEvvIKdv8+c2EKZzQPeDfoMEJmLdtiKs
	1ur4x7fRCKhId0rUbGKvX8yagFrABdz+Hgq+0FZqZmJfoLvl+0pOPYWjBr3sKRQ9UXzuubm+tu9qx
	W+FCY9OYF1q35EXP6+Yw2J79AGCTMRp+jZACw6YqmUp5OdH4X2JiWOoslYCNemsQYJuoYTVdSoii/
	p/ZF+W8K8jFqMNmboMn8+4bRnyJdzcBdtP3AUxgG+hg2/XRvca6W8kk929WjWlMt7SW6irJE4r5pV
	peELBMCA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:57384)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1vDtd1-000000003g6-34U2;
	Wed, 29 Oct 2025 00:01:27 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1vDtcz-000000006yS-2jNj;
	Wed, 29 Oct 2025 00:01:25 +0000
Date: Wed, 29 Oct 2025 00:01:25 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>
Subject: [PATCH net-next v3 0/8] net: stmmac: hwif.c cleanups
Message-ID: <aQFZVSGJuv8-_DIo@shell.armlinux.org.uk>
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

This series cleans up hwif.c:

- move the reading of the version information out of stmmac_hwif_init()
  into its own function, stmmac_get_version(), storing the result in a
  new struct.

- simplify stmmac_get_version().

- read the version register once, passing it to stmmac_get_id() and
  stmmac_get_dev_id().

- move stmmac_get_id() and stmmac_get_dev_id() into
  stmmac_get_version()

- define version register fields and use FIELD_GET() to decode

- start tackling the big loop in stmmac_hwif_init() - provide a
  function, stmmac_hwif_find(), which looks up the hwif entry, thus
  making a much smaller loop, which improves readability of this code.

- change the use of '^' to '!=' when comparing the dev_id, which is
  what is really meant here.

- reorganise the test after calling stmmac_hwif_init() so that we
  handle the error case in the indented code, and the success case
  with no indent, which is the classical arrangement.

---
v3:
- fix conflict with PCS IRQ changes
v2:
- fix "verison" typo, impacting patches 2, 3, and 4.
- added reviewed-by / tested-bys

 drivers/net/ethernet/stmicro/stmmac/common.h |   3 +
 drivers/net/ethernet/stmicro/stmmac/hwif.c   | 166 +++++++++++++++------------
 2 files changed, 98 insertions(+), 71 deletions(-)
 
-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

