Return-Path: <netdev+bounces-183395-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 745AEA90936
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 18:45:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5399744717E
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 16:45:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6357D217703;
	Wed, 16 Apr 2025 16:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FYTb/0PU"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3713C21506B;
	Wed, 16 Apr 2025 16:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744821892; cv=none; b=slhqR4jqXrKMO2l1KVwugCirNT6Cen6cV6ewCRM+Ve0oaZ4aYahxqRTc488712diSmXRKKNN2nkIhadxFb1jroBqHXGlgTGyScz/w9MPcwiPwfLITleN94OO83gJS3xiBHBYO+XB+2f8saFSJKIdn8NhsSmW6x8TuH6OoWF7Qfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744821892; c=relaxed/simple;
	bh=VylpoJr/xCnl8WcBXr2d8cdXmdql2CE4ZK2UhVwVCpQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UkHkH1lR7KWfH75TYeqs53UAyvO++hky3Y02Mf3MpV30jQyaGKwrOMVVL1f6bgIYYzukxmelLSc7w7XeTyj+7PsyyfTsKNKAQJiqYLd4WgoO/zPd8vj0RI3bvdNERrFcvwMyPZGv7lSUadL0PIwpLQ1HmUUqxc8qNlMVwys9ARE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FYTb/0PU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B8BEC4CEE4;
	Wed, 16 Apr 2025 16:44:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744821892;
	bh=VylpoJr/xCnl8WcBXr2d8cdXmdql2CE4ZK2UhVwVCpQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FYTb/0PUk8ojmN7UBIxKHfkRSeMEwg/0hUpAiEDvb0zobjPvLYKXP1UYT/FK+pmnf
	 Y0TfMWE/fCWME4nMJEB8KEc8SN09++vKcmgsztDEOkQ2+iqSWaePeSzhGbJxB6xA14
	 Gh3FPo2jopKKvJG1vAsP4mIFk3Qy7e1AcpgsFpR+awci4na/nE3YcNcxUPr+8Ik4U6
	 FIojIt+lijROedTs4jPsDFDtUzuqcsYD6HXqjaIOYcL3cJgrx96dKivmrWnjjxTFkN
	 ObF5qD9Rc32Wi9S7wecLwzKdiTnspJHg77XIyP1sufOGbSm+OLUcXLWY5ALJv55erA
	 niIsPcRdjxHVQ==
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
Subject: [PATCH 4/8] net: ethernet: natsemi: Use pure PCI devres API
Date: Wed, 16 Apr 2025 18:44:04 +0200
Message-ID: <20250416164407.127261-6-phasta@kernel.org>
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
 drivers/net/ethernet/natsemi/natsemi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/natsemi/natsemi.c b/drivers/net/ethernet/natsemi/natsemi.c
index 05606692e631..dd279788cf9e 100644
--- a/drivers/net/ethernet/natsemi/natsemi.c
+++ b/drivers/net/ethernet/natsemi/natsemi.c
@@ -846,7 +846,7 @@ static int natsemi_probe1(struct pci_dev *pdev, const struct pci_device_id *ent)
 		return -ENOMEM;
 	SET_NETDEV_DEV(dev, &pdev->dev);
 
-	i = pci_request_regions(pdev, DRV_NAME);
+	i = pcim_request_all_regions(pdev, DRV_NAME);
 	if (i)
 		goto err_pci_request_regions;
 
-- 
2.48.1


