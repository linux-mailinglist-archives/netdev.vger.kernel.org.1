Return-Path: <netdev+bounces-183396-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 25B68A9093B
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 18:46:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AABD819084CA
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 16:45:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9C8D2153D5;
	Wed, 16 Apr 2025 16:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KNYJUhUX"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CF6D2135AC;
	Wed, 16 Apr 2025 16:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744821898; cv=none; b=YLI5mQATj6oDW3QvyKjYUJFgv7V6LKdDNHruoYSmA2VFFxH3ZpV6CaUmv7mrGB/k/Uam0vq4aH2TO2p5ecXhpBVU7uOQ8arf5cVt3fEjbBxButdTH5/iDL4Kya8wmxtT9RdWxOvnulykP+LVXCqOGr8f3MOt2pdXoiXghNEhUYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744821898; c=relaxed/simple;
	bh=0r0mi/BP6F0I5TWSsjujNCjEBDZ11myDs0TAlZWLbbk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MFxzrfBmiusH/lLMVlnN8Xf2WMqbvpEB/3eLcNi5EAqnWXQW1LL91v8xU5vmyHUf2GyiUUFL/+9uncsrhqQXqjc5iEKBadV2+xtOBYxJbYSc2eAkeI2TbbhtnuePefavSlg1dyaYuLJI2EA24CMdpcrZo8K3tHk80ICpSXXQoL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KNYJUhUX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EACAC4CEE2;
	Wed, 16 Apr 2025 16:44:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744821898;
	bh=0r0mi/BP6F0I5TWSsjujNCjEBDZ11myDs0TAlZWLbbk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KNYJUhUXz91F1oOr8Yl/Md/UxSC2sfD7qBpC1mgnGkKbbkKfVeoiCL6YOOeXEtz8T
	 s2RhhYPvZC7npN3ldiTPwO8UAccI74kCJr1mejeJVsfw2i6apEFf3loy5Xb6ymS2gy
	 lkrz/vrsZt+olcvVXyF38zfZVOlgGOP9zKHU6e0of4DD4SxJG5hC/NdY5rut8AuNSk
	 Q61bIGWiQBxC+HGVvh8sEVtXY3t11gFxwjmWRQyKGhcp4HPhp7fAfsX4lrQFr1M1RS
	 Mws1S3bIQfcmVS6PvCs5K1q9HrWBfNkAOBcE86ujyOUoHVYHJXbMOx+XCTIciOGU5c
	 94/5g9NU1aCVw==
From: Philipp Stanner <phasta@kernel.org>
To: Sunil Goutham <sgoutham@marvell.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Geetha sowjanya <gakula@marvell.com>,
	Subbaraya Sundeep <sbhatta@marvell.com>,
	hariprasad <hkelam@marvell.com>,
	Bharat Bhushan <bbhushan2@marvell.com>,
	Taras Chornyi <taras.chornyi@plvision.eu>,
	Daniele Venzano <venza@brownhat.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Thomas Gleixner <tglx@linutronix.de>,
	Philipp Stanner <phasta@kernel.org>,
	Helge Deller <deller@gmx.de>,
	Ingo Molnar <mingo@kernel.org>,
	Simon Horman <horms@kernel.org>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Sabrina Dubroca <sd@queasysnail.net>,
	Jacob Keller <jacob.e.keller@intel.com>
Cc: linux-arm-kernel@lists.infradead.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-parisc@vger.kernel.org
Subject: [PATCH 5/8] net: ethernet: sis900: Use pure PCI devres API
Date: Wed, 16 Apr 2025 18:44:05 +0200
Message-ID: <20250416164407.127261-7-phasta@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250416164407.127261-2-phasta@kernel.org>
References: <20250416164407.127261-2-phasta@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The currently used function pci_request_regions() is one of the
problematic "hybrid devres" PCI functions, which are sometimes managed
through devres, and sometimes not (depending on whether
pci_enable_device() or pcim_enable_device() has been called before).

The PCI subsystem wants to remove this behavior and, therefore, needs to
port all users to functions that don't have this problem.

Replace pci_request_regions() with pcim_request_all_regions().

Signed-off-by: Philipp Stanner <phasta@kernel.org>
---
 drivers/net/ethernet/sis/sis900.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/sis/sis900.c b/drivers/net/ethernet/sis/sis900.c
index 332cbd725900..df869f82cae8 100644
--- a/drivers/net/ethernet/sis/sis900.c
+++ b/drivers/net/ethernet/sis/sis900.c
@@ -468,7 +468,7 @@ static int sis900_probe(struct pci_dev *pci_dev,
 	SET_NETDEV_DEV(net_dev, &pci_dev->dev);
 
 	/* We do a request_region() to register /proc/ioports info. */
-	ret = pci_request_regions(pci_dev, "sis900");
+	ret = pcim_request_all_regions(pci_dev, "sis900");
 	if (ret)
 		goto err_out;
 
-- 
2.48.1


