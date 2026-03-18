Return-Path: <netdev+bounces-269099-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UAreMKHXumkycgIAu9opvQ
	(envelope-from <netdev+bounces-269099-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 17:49:37 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 285022BF9B4
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 17:49:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5326030D341F
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 16:33:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBF013A7583;
	Wed, 18 Mar 2026 16:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="x+ArvTIh"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A57592D7D42
	for <netdev@vger.kernel.org>; Wed, 18 Mar 2026 16:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773849977; cv=none; b=p6k9T/JXhdGtZn0TwQsREleRg3NoLfQbI4qcOnPSgCwgn1so9QfsL8ERfqbtNKHwN+u2yHjpb9LivTa41TFAn/KvUFnl6K2E3uA4+EpiOrc2JwiPsSC/5DBwdPlwOrJK22s5SAHI72tiYbzAzAFo9K+Mce33qG8U1KRY8V2IWBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773849977; c=relaxed/simple;
	bh=kyutswtgbACdq0vf5h5FKJXrPfOW6y5/NDBFsG6cBHI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=kzMmgnSnOSVbi2nATRHlBK0O4l53zsjGV5MfXNQt+MFWpjYhR5GT4AN7f/qHvum/uwa8WlamV/3r2NlTTwAOxn6mIJGpAqk4olGo65WxhvPUrA7xs55rtsQoSxCIxVdnOm7ll1UZ1Bqii8v+WeuvuIe/Vp6H97EP/NzuV0wiXr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=x+ArvTIh; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=Pk5nclcW+6iifoD+wiY2hL2mIge4xLaV5a7mcWnT1EY=; b=x+ArvTIhdWq2+6kaZOZjYe3TYm
	DXe5hgScMMEUzGWzPg3xECJK6RXUDKzOiYjzY/8U3T53w0ivjclMZ/q3Ppi2DPCryo8Mpa/W3sDDz
	aMTS3n196VQShi4l3vjiPyXjiacf4JJ3leZbVSoeVyxxIORCppNiZXmsmieOdpI5EpHbskeYGfqnN
	zfuq48lyznPdb3X/vRk5SCnrMlZs3E+Qhmu0Hh23gq6y/gmbw93oxCWq0/+c+XYTyA1b20YD3Z9wp
	oM2zjd2eYqLavk7rj3uEm9eHzddmMlRonyugp4mEqpAfzayWOBGmg68BI0tv1AZ5Rj/qtm1x0YWbt
	vPnyHJFA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:38190)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1w2tPB-000000003e2-2F64;
	Wed, 18 Mar 2026 16:05:57 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1w2tP8-000000007Cp-0Sn6;
	Wed, 18 Mar 2026 16:05:54 +0000
Date: Wed, 18 Mar 2026 16:05:53 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Mohd Ayaan Anwar <mohd.anwar@oss.qualcomm.com>,
	netdev@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>,
	Vinod Koul <vkoul@kernel.org>
Subject: [PATCH net-next v2 maybe? 0/5] net: stmmac: improve PCS support
Message-ID: <abrNYVfZ1Iwff2EI@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spamd-Result: default: False [1.14 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	R_DKIM_REJECT(1.00)[armlinux.org.uk:s=pandora-2019];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[armlinux.org.uk : SPF not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-269099-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	DKIM_TRACE(0.00)[armlinux.org.uk:-];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[linux@armlinux.org.uk,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	NEURAL_SPAM(0.00)[0.631];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	SUBJECT_HAS_QUESTION(0.00)[]
X-Rspamd-Queue-Id: 285022BF9B4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

I am losing track of what version we're at, because each time the
series is reworked, changing the approach, which changes the
patches quite a bit, it makes it difficult. We've gone RFC to non-RFC
back to RFC and then to non-RFC again.

This series is the next of the three part series sorting out the PCS
support in stmmac, building on part 2:

	net: stmmac: qcom-ethqos: further serdes reorganisation

Similar patches have been posted previously. This series does away with
the common SerDes PHY support, instead using a flag to indicate whether
2500Mbps mode is supported (STMMAC_FLAG_SERDES_SUPPORTS_2500M.) At this
time, I have no plans to resurect the common SerDes PHY support - the
generic PHY layer implementations are just too random to consider that,
and I certainly do not want the extra work of fixing that.

Changes from RFC v3:
- only set default_an_inband if using SGMII/2500BASE-X mode.
Changes from previous non-RFC posting:
- add a patch moving default_an_inband to struct plat_stmmacenet_data
- only include the first four patches from the previous posting
- add pcs_an_restart() support for BASE-X, but only if we have
  TBI/RTBI support.

The reasoning here is that these patches should be safe to merge and
should not impact qcom-ethqos in any way.

We can then figure out how to work around qcom-ethqos hacks without
having to keep re-posting these same patches time and time again.

 drivers/net/ethernet/stmicro/stmmac/common.h       |   4 -
 drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c  |   4 +-
 drivers/net/ethernet/stmicro/stmmac/dwmac1000.h    |  12 +-
 .../net/ethernet/stmicro/stmmac/dwmac1000_core.c   |  11 +-
 drivers/net/ethernet/stmicro/stmmac/dwmac4.h       |  10 +-
 drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c  |  10 +-
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c  |  13 +-
 drivers/net/ethernet/stmicro/stmmac/stmmac_pcs.c   | 156 ++++++++++++++++++++-
 drivers/net/ethernet/stmicro/stmmac/stmmac_pcs.h   |  14 +-
 include/linux/stmmac.h                             |   3 +-
 10 files changed, 186 insertions(+), 51 deletions(-)

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

