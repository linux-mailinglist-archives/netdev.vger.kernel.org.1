Return-Path: <netdev+bounces-154801-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 719769FFCFA
	for <lists+netdev@lfdr.de>; Thu,  2 Jan 2025 18:42:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D42D33A3344
	for <lists+netdev@lfdr.de>; Thu,  2 Jan 2025 17:42:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E005C1A238D;
	Thu,  2 Jan 2025 17:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="olFgcKKc"
X-Original-To: netdev@vger.kernel.org
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5960F1684AC;
	Thu,  2 Jan 2025 17:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735839713; cv=none; b=rPHUHQ2r5G+l/TGpQPcpjNnqJux9+mFtHJxQ/zzJpVfNLGkMRYNO+42IqoYThlzxdVM/IEZchN12yEisLedmx23bIe5z+Jnq+fXCTBnvx0LcKnhuuHqApL5TWIL4bLAUVNyTBtfEJNYYnUTLBYU3YLc/Eazvx6XUvfUbniJugWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735839713; c=relaxed/simple;
	bh=FfHMfV3m6N+lxueI9KsD0EdOdSpmT3d1lucrwtc/0bI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=klafs98UWyH/kYEia3vW2YyY0Jpzbgovom07qGXHhtNC6LsWR8+YVDL6/Bwz0N5TlE34nxDrL4ggxOF6NvxYc8w9nf3r6w+bnsiMR0hbJSJOcFYxLxfQpRP0zbNTJi/LIm8FRZ2YyggA4sYncTsFG5FvJWp+81PvmDrjQCPAm98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=olFgcKKc; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=MIME-Version:Message-ID:Date:Subject:From:Content-Type:From
	:Subject; bh=zewCXryLBAmS6GupELoPnKwlpgE7Rk2QDzMgSD+MVFI=; b=olFgcKKc4EOLq81i
	sJ8jXSXwXAlXOfgw7D0QFcqPozfsgmFSJCwFP+Z0yiudwX/ABF+NMtIHWUXMtj64wcyIjDdIL8nZH
	HfKJh9wvfC65Aj8yxhz+fJddHoNTnyNGMbTLQ+t1KZp3U2Yoh63fUoYizxEgMwiCv2IW3sImMmrlL
	xhvJiMpOOTAp1te3aScTHVPw/NOk92dTi3yILJ8UM7lPnRqQbXvXB6wAKhO/eFzeVMDszPMNucv9I
	nz58P/o7847X4Z1S0PofT/vWlCz4+dYFcsxUIOOwL5GH32sJnbq8DH7efXu8KBUUe5gEcpE66B2Sr
	ve1+cC7VCj1fjjJPuQ==;
Received: from localhost ([127.0.0.1] helo=dalek.home.treblig.org)
	by mx.treblig.org with esmtp (Exim 4.96)
	(envelope-from <linux@treblig.org>)
	id 1tTPCb-007u04-0P;
	Thu, 02 Jan 2025 17:41:45 +0000
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
Subject: [PATCH net-next 2/3] igc: Remove unused igc_read/write_pci_cfg wrappers
Date: Thu,  2 Jan 2025 17:41:41 +0000
Message-ID: <20250102174142.200700-3-linux@treblig.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250102174142.200700-1-linux@treblig.org>
References: <20250102174142.200700-1-linux@treblig.org>
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


