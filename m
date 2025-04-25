Return-Path: <netdev+bounces-185933-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 316F5A9C299
	for <lists+netdev@lfdr.de>; Fri, 25 Apr 2025 11:00:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6564D1BA7215
	for <lists+netdev@lfdr.de>; Fri, 25 Apr 2025 09:00:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 725E823BCF1;
	Fri, 25 Apr 2025 08:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QYUZQrCs"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4466A23AE9A;
	Fri, 25 Apr 2025 08:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745571507; cv=none; b=rbaY8q2FOIPfDABWzFU7gaFOIYV7X3UvIjbhgSRBhM197RvXK6f+LrO/rsp3OwWDlkz/Tl4YnhrXhmNaxYBcV3e1yDJgHQzyfrQrxXktxDs/dsye3vyZW4wJj4rahNIzxs3weHnNMMhaN6jWvGOi5L5+lwGlqgt2lLIriIQx9Us=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745571507; c=relaxed/simple;
	bh=ReLh28MMXe+RCC+isNK/dhc8sJPi0We7tbuIOvBGcMQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lcSFhu+430llhAPSVs/dLirKAeoy0JOzG8/5DX4fIBlJ4Yuv05ahXFdugSGebTvyyfYnE2PGRtycEY1oXxohR8l07ZFly7Vc86CvaIznriSVedY8Yng1yJIYjHiEP/cd71eBuZiGyo6Hvld7gk3rzoUd8l3RelqPz4stl26OVjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QYUZQrCs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56035C4CEEA;
	Fri, 25 Apr 2025 08:58:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745571506;
	bh=ReLh28MMXe+RCC+isNK/dhc8sJPi0We7tbuIOvBGcMQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QYUZQrCso3T23LALKw0C7Xd397quUlqZYpWiKk/VQfZ9Ut/+uMgj4EkwVQeor3alh
	 NItGOYyddkAC+RODzbwkyubLdDUXr0qIgf5ln/ndPKYL2+DjJyg2pTavXrlY97Mfqm
	 gXkDzipiyPOaB66oPZ45HGkjedVytgq1whLTfr1wy19bfn5DH/BwHuyhK9W9gzX+nD
	 kT2FYv7rR6fysxtZ/wpIUEbShtnTqOeyLiryXitRzDaYdyY2jAHBcESzqQpeWGr+iR
	 DQVQhnfsa+67LbQpP1vuUCjI3qRNT13MqRbz3bgwYu6FYWWiN4FS8VKJ17VsvjC8AR
	 3yD1Oovvs9ezw==
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
	Philipp Stanner <phasta@kernel.org>,
	Helge Deller <deller@gmx.de>,
	Simon Horman <horms@kernel.org>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Shannon Nelson <shannon.nelson@amd.com>,
	Sabrina Dubroca <sd@queasysnail.net>
Cc: linux-arm-kernel@lists.infradead.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-parisc@vger.kernel.org
Subject: [PATCH v2 5/8] net: ethernet: sis900: Use pure PCI devres API
Date: Fri, 25 Apr 2025 10:57:38 +0200
Message-ID: <20250425085740.65304-7-phasta@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250425085740.65304-2-phasta@kernel.org>
References: <20250425085740.65304-2-phasta@kernel.org>
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
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
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


