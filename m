Return-Path: <netdev+bounces-34611-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 370E87A4D98
	for <lists+netdev@lfdr.de>; Mon, 18 Sep 2023 17:54:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 08E281C2149E
	for <lists+netdev@lfdr.de>; Mon, 18 Sep 2023 15:54:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A59E320B1D;
	Mon, 18 Sep 2023 15:49:07 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 901901F92C
	for <netdev@vger.kernel.org>; Mon, 18 Sep 2023 15:49:05 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 027B219B6;
	Mon, 18 Sep 2023 08:46:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695051962; x=1726587962;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=zTpTCMfWjtWGKDy0jqcFW3mar26wQ+s3+v+7yTP0erY=;
  b=ZPQdPh0V60UWeaLLo6ePQfn6wSS3Fj+EQdbGY4YCnQRFrQmuFhPC6RCw
   qgWnDG4W4q1aF+pkm6H/iTgzKjiXWHepkegUx9/XXYT50gwWxT14Z360j
   xHHi/B+UJFRXpv1I+x6z5zBEqTTHgm1nU49h7E/u52VZShBe5c1Q2TQBe
   sAdrf065s7ZfjN3MYST2uRAb9BIeZzTLPWuiyXSPJBmmKaU2TRRpXw680
   CMJ0qv777UJ84g+M3IQ60P0ul+kP3cUyupUSuD53cTw7W4IqW2nenVspd
   ny++0bRVkB9UqmQVLihlCjSnmSGHqa7r1MkMiIbcmBEnI4JhVa7RKJ90s
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10837"; a="446113490"
X-IronPort-AV: E=Sophos;i="6.02,156,1688454000"; 
   d="scan'208";a="446113490"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2023 06:13:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10837"; a="811342491"
X-IronPort-AV: E=Sophos;i="6.02,156,1688454000"; 
   d="scan'208";a="811342491"
Received: from nprotaso-mobl1.ccr.corp.intel.com (HELO ijarvine-mobl2.ger.corp.intel.com) ([10.252.49.156])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2023 06:12:54 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: linux-pci@vger.kernel.org,
	Bjorn Helgaas <helgaas@kernel.org>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Rob Herring <robh@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Lukas Wunner <lukas@wunner.de>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
	linux-kernel@vger.kernel.org,
	Jesse Brandeburg <jesse.brandeburg@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org
Cc: ath10k@lists.infradead.org,
	ath11k@lists.infradead.org,
	ath12k@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-bluetooth@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	linux-rdma@vger.kernel.org,
	linux-wireless@vger.kernel.org,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v2 08/13] e1000e: Remove unreliable pci_disable_link_state{,_locked}() workaround
Date: Mon, 18 Sep 2023 16:10:58 +0300
Message-Id: <20230918131103.24119-9-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230918131103.24119-1-ilpo.jarvinen@linux.intel.com>
References: <20230918131103.24119-1-ilpo.jarvinen@linux.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

pci_disable_link_state() and pci_disable_link_state_locked() were made
reliable regardless of ASPM CONFIG and OS being disallowed to change
ASPM states to allow drivers to rely on them working.

Remove driver working around unreliable
pci_disable_link_state{,_locked}() from e1000e driver and just call the
functions directly.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/net/ethernet/intel/e1000e/netdev.c | 77 +---------------------
 1 file changed, 2 insertions(+), 75 deletions(-)

diff --git a/drivers/net/ethernet/intel/e1000e/netdev.c b/drivers/net/ethernet/intel/e1000e/netdev.c
index f536c856727c..fbe468061591 100644
--- a/drivers/net/ethernet/intel/e1000e/netdev.c
+++ b/drivers/net/ethernet/intel/e1000e/netdev.c
@@ -6765,79 +6765,6 @@ static int __e1000_shutdown(struct pci_dev *pdev, bool runtime)
 	return 0;
 }
 
-/**
- * __e1000e_disable_aspm - Disable ASPM states
- * @pdev: pointer to PCI device struct
- * @state: bit-mask of ASPM states to disable
- * @locked: indication if this context holds pci_bus_sem locked.
- *
- * Some devices *must* have certain ASPM states disabled per hardware errata.
- **/
-static void __e1000e_disable_aspm(struct pci_dev *pdev, u16 state, int locked)
-{
-	struct pci_dev *parent = pdev->bus->self;
-	u16 aspm_dis_mask = 0;
-	u16 pdev_aspmc, parent_aspmc;
-
-	switch (state) {
-	case PCIE_LINK_STATE_L0S:
-	case PCIE_LINK_STATE_L0S | PCIE_LINK_STATE_L1:
-		aspm_dis_mask |= PCI_EXP_LNKCTL_ASPM_L0S;
-		fallthrough; /* can't have L1 without L0s */
-	case PCIE_LINK_STATE_L1:
-		aspm_dis_mask |= PCI_EXP_LNKCTL_ASPM_L1;
-		break;
-	default:
-		return;
-	}
-
-	pcie_capability_read_word(pdev, PCI_EXP_LNKCTL, &pdev_aspmc);
-	pdev_aspmc &= PCI_EXP_LNKCTL_ASPMC;
-
-	if (parent) {
-		pcie_capability_read_word(parent, PCI_EXP_LNKCTL,
-					  &parent_aspmc);
-		parent_aspmc &= PCI_EXP_LNKCTL_ASPMC;
-	}
-
-	/* Nothing to do if the ASPM states to be disabled already are */
-	if (!(pdev_aspmc & aspm_dis_mask) &&
-	    (!parent || !(parent_aspmc & aspm_dis_mask)))
-		return;
-
-	dev_info(&pdev->dev, "Disabling ASPM %s %s\n",
-		 (aspm_dis_mask & pdev_aspmc & PCI_EXP_LNKCTL_ASPM_L0S) ?
-		 "L0s" : "",
-		 (aspm_dis_mask & pdev_aspmc & PCI_EXP_LNKCTL_ASPM_L1) ?
-		 "L1" : "");
-
-#ifdef CONFIG_PCIEASPM
-	if (locked)
-		pci_disable_link_state_locked(pdev, state);
-	else
-		pci_disable_link_state(pdev, state);
-
-	/* Double-check ASPM control.  If not disabled by the above, the
-	 * BIOS is preventing that from happening (or CONFIG_PCIEASPM is
-	 * not enabled); override by writing PCI config space directly.
-	 */
-	pcie_capability_read_word(pdev, PCI_EXP_LNKCTL, &pdev_aspmc);
-	pdev_aspmc &= PCI_EXP_LNKCTL_ASPMC;
-
-	if (!(aspm_dis_mask & pdev_aspmc))
-		return;
-#endif
-
-	/* Both device and parent should have the same ASPM setting.
-	 * Disable ASPM in downstream component first and then upstream.
-	 */
-	pcie_capability_clear_word(pdev, PCI_EXP_LNKCTL, aspm_dis_mask);
-
-	if (parent)
-		pcie_capability_clear_word(parent, PCI_EXP_LNKCTL,
-					   aspm_dis_mask);
-}
-
 /**
  * e1000e_disable_aspm - Disable ASPM states.
  * @pdev: pointer to PCI device struct
@@ -6848,7 +6775,7 @@ static void __e1000e_disable_aspm(struct pci_dev *pdev, u16 state, int locked)
  **/
 static void e1000e_disable_aspm(struct pci_dev *pdev, u16 state)
 {
-	__e1000e_disable_aspm(pdev, state, 0);
+	pci_disable_link_state(pdev, state);
 }
 
 /**
@@ -6861,7 +6788,7 @@ static void e1000e_disable_aspm(struct pci_dev *pdev, u16 state)
  **/
 static void e1000e_disable_aspm_locked(struct pci_dev *pdev, u16 state)
 {
-	__e1000e_disable_aspm(pdev, state, 1);
+	pci_disable_link_state_locked(pdev, state);
 }
 
 static int e1000e_pm_thaw(struct device *dev)
-- 
2.30.2


