Return-Path: <netdev+bounces-154305-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CC6519FCBFB
	for <lists+netdev@lfdr.de>; Thu, 26 Dec 2024 17:53:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A40987A16DD
	for <lists+netdev@lfdr.de>; Thu, 26 Dec 2024 16:52:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E25D1428E7;
	Thu, 26 Dec 2024 16:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="VKUFBX6e"
X-Original-To: netdev@vger.kernel.org
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51B54EC5;
	Thu, 26 Dec 2024 16:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735231957; cv=none; b=YZKvJa9l8hfYvh0aqqGqmgVaY7m1fJWG198DmkL30B0Ai6q6+2lJMVbAmH5PJ4We1y8w7kk5iawBsut5lUG9nvGwYzamXw0HvJyrsVc8g9PQhw9vew/FzwrU+pIwlvjjel+dXg9nSmer9KN5XOrrHXSeIrTFLcPcdry/I16+rxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735231957; c=relaxed/simple;
	bh=FfHMfV3m6N+lxueI9KsD0EdOdSpmT3d1lucrwtc/0bI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sLRP1DRmxx1OnYK5PNM1fYjXqdGgyI9BFlV+ZuRo/VS5JIc2IEkb5Et6zn3YmPi9RGf7fqBefTm1BNAj7Mo7MIUXAFoPzh6cVa9fEVOkUO3CT4BI34tXV54hy0ufX2QKa8d4y9Kxl1W1knY4qATGWxLasNDdVyeumUyLV/11AYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=VKUFBX6e; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=MIME-Version:Message-ID:Date:Subject:From:Content-Type:From
	:Subject; bh=zewCXryLBAmS6GupELoPnKwlpgE7Rk2QDzMgSD+MVFI=; b=VKUFBX6eoigWH2fU
	UaSvitHog9H9Hgo/eFU/GROMJPIk7yTVpAJZ6VT9ugngCqffiqtzxbJ1Dd3c29n5sehqyNeDPjdyL
	zt90AgJvEL8JnoOpGYj8iQuoBwxPC6LZovwizBp1zY+NKwoGErtkXKf0eV1B8AyG9XYBrLgcRdqy7
	AjMXaOT24qh/YgqTs6VJh8yCXPXJrXsaziCS7Iosz/N0335sfTIXxXU2AhzwbhpROKHOXTWdpur0P
	4X1Bc0Jkbl7314fJjLLE4bVQH3T9Yi73ajhLaZYHOjHkh0fHWGU++29NUDu5vO1J+2IIdDmIcRjE3
	FnN1CqyH5Gj8T83oOg==;
Received: from localhost ([127.0.0.1] helo=dalek.home.treblig.org)
	by mx.treblig.org with esmtp (Exim 4.96)
	(envelope-from <linux@treblig.org>)
	id 1tQr5t-007IaP-2F;
	Thu, 26 Dec 2024 16:52:17 +0000
From: linux@treblig.org
To: anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Dr. David Alan Gilbert" <linux@treblig.org>
Subject: [RFC net-next 2/3] igc: Remove unused igc_read/write_pci_cfg wrappers
Date: Thu, 26 Dec 2024 16:52:14 +0000
Message-ID: <20241226165215.105092-3-linux@treblig.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241226165215.105092-1-linux@treblig.org>
References: <20241226165215.105092-1-linux@treblig.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Dr. David Alan Gilbert" <linux@treblig.org>

igc_read_pci_cfg() and igc_write_pci_cfg were added in 2018 as part of
commit 146740f9abc4 ("igc: Add support for PF")
but have remained unused.

Remove them.

Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
---
 drivers/net/ethernet/intel/igc/igc_hw.h   |  2 --
 drivers/net/ethernet/intel/igc/igc_main.c | 14 --------------
 2 files changed, 16 deletions(-)

diff --git a/drivers/net/ethernet/intel/igc/igc_hw.h b/drivers/net/ethernet/intel/igc/igc_hw.h
index d9d1a1a11daf..7ec7e395020b 100644
--- a/drivers/net/ethernet/intel/igc/igc_hw.h
+++ b/drivers/net/ethernet/intel/igc/igc_hw.h
@@ -281,7 +281,5 @@ struct net_device *igc_get_hw_dev(struct igc_hw *hw);
 
 s32  igc_read_pcie_cap_reg(struct igc_hw *hw, u32 reg, u16 *value);
 s32  igc_write_pcie_cap_reg(struct igc_hw *hw, u32 reg, u16 *value);
-void igc_read_pci_cfg(struct igc_hw *hw, u32 reg, u16 *value);
-void igc_write_pci_cfg(struct igc_hw *hw, u32 reg, u16 *value);
 
 #endif /* _IGC_HW_H_ */
diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
index 27872bdea9bd..9c92673a7240 100644
--- a/drivers/net/ethernet/intel/igc/igc_main.c
+++ b/drivers/net/ethernet/intel/igc/igc_main.c
@@ -6780,20 +6780,6 @@ static const struct net_device_ops igc_netdev_ops = {
 };
 
 /* PCIe configuration access */
-void igc_read_pci_cfg(struct igc_hw *hw, u32 reg, u16 *value)
-{
-	struct igc_adapter *adapter = hw->back;
-
-	pci_read_config_word(adapter->pdev, reg, value);
-}
-
-void igc_write_pci_cfg(struct igc_hw *hw, u32 reg, u16 *value)
-{
-	struct igc_adapter *adapter = hw->back;
-
-	pci_write_config_word(adapter->pdev, reg, *value);
-}
-
 s32 igc_read_pcie_cap_reg(struct igc_hw *hw, u32 reg, u16 *value)
 {
 	struct igc_adapter *adapter = hw->back;
-- 
2.47.1


