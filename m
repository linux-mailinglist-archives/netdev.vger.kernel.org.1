Return-Path: <netdev+bounces-221310-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 67B0BB501C6
	for <lists+netdev@lfdr.de>; Tue,  9 Sep 2025 17:46:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 825C6189A62D
	for <lists+netdev@lfdr.de>; Tue,  9 Sep 2025 15:46:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3928D3191B5;
	Tue,  9 Sep 2025 15:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="tpVy6IaR"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AB9727A925
	for <netdev@vger.kernel.org>; Tue,  9 Sep 2025 15:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757432746; cv=none; b=TPdMh0hst/G/Nc4uKNqlPtP82nqMSOXJlp8PKUbKr8ohx64ssoSBXCOSHm+VJEn1OMNS6yYrwRhEV5mVRnIsNa2LZ+0GgIn1AB/hEM6Xj1m0wTsl0ZD+UOMb+dvqN5YOvT8DN+ePxscT/WqtLFE3VPe4mLuXOqX2TzKbhwp66ks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757432746; c=relaxed/simple;
	bh=yxd6D+YL1BHyR1YIbK5QjJ0u8DYLIX8USsTCe2qXXKM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Fq0sYbAe113vklnCFhSkoem1AajCHftHzR9aoPnd5kkqyPM+//cu4QhVZ2317Xvlyhe78zUynlmw8+3wG6JlUcT87iX3Y2gA8xtw11SzC6cocMVmfevPex3dkuch1nqbSsfwwErKnWwVUqUabJdtnCy3b/ahAvcutaWdTkpBSoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=tpVy6IaR; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=M8p9YsVseZ1gGdBaWVjtKQJpnmQi3B/dpxfiugdLXHI=; b=tpVy6IaRBtB0Q4LzSJkDP8EIQ7
	o92kIa05/3ewWzXZpe0LC6zJe1RbMpEIkW1lX3226OpB/wHJ4eegejLza4Tt9UUC0XRV04DYRMduu
	qlCeEAhR7CYSFyZ/+6J/8h2ltQQnElUjwbRP8BF07jyiC7ynW8oWHSWW1o35HlbkApSgkKuoUfhBx
	0MQV7SmHiKHqdvf53VMd+9qagLS4UtfLkCQ9ytJEY7ILF72jYYc7wa52BXCG0vkLpYhVesFm4mbKI
	w0Ib8r2TreScicA00A3Hi+Lt9sgrNEeLyaQURcmKeBeIMwnZLKepEH2C2Cwf+bzuZdnHmJdJ+d5va
	2MvXOljA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:53140)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1uw0XM-000000008P7-1qiA;
	Tue, 09 Sep 2025 16:45:40 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1uw0XL-000000000Xj-0Y6j;
	Tue, 09 Sep 2025 16:45:39 +0100
Date: Tue, 9 Sep 2025 16:45:38 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>
Subject: [PATCH net-next 0/4] net: dsa: mv88e6xxx: remove redundant
 ptp/timestamping code
Message-ID: <aMBLorDdDmIn1gDP@shell.armlinux.org.uk>
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

mv88e6xxx as accumulated some unused data structures and code over the
years. This series removes it and simplifies the code. See the patches
for each change.

 drivers/net/dsa/mv88e6xxx/chip.c |  2 +-
 drivers/net/dsa/mv88e6xxx/chip.h |  2 --
 drivers/net/dsa/mv88e6xxx/ptp.c  | 55 ++++++----------------------------------
 drivers/net/dsa/mv88e6xxx/ptp.h  |  2 --
 4 files changed, 9 insertions(+), 52 deletions(-)

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

