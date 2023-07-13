Return-Path: <netdev+bounces-17584-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D18A075218C
	for <lists+netdev@lfdr.de>; Thu, 13 Jul 2023 14:46:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B4ACF1C213AA
	for <lists+netdev@lfdr.de>; Thu, 13 Jul 2023 12:46:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8622B8BEE;
	Thu, 13 Jul 2023 12:46:51 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 773E5100B0
	for <netdev@vger.kernel.org>; Thu, 13 Jul 2023 12:46:51 +0000 (UTC)
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5206926B1;
	Thu, 13 Jul 2023 05:46:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689252386; x=1720788386;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=32kRKfdMgDzPzA7zG83cMwuqvw0HkhDshGCOND8kKRk=;
  b=fxSIoaW67HJ4JXON+sFsfRe3SAj+egnPB3bO2NSP58lcVmRfsFqHc5g+
   MMusC4bspqOJ9p3mQOj4hRoaZkCxPFEGGJYHaW36oCaBXPHJAKbc64R8d
   J3elUik7h1YyO6xnpfOljW59k6rTzMFJijA1cA5H+LlofdSYvxNwOaNM3
   8Bj9YxFW2D/LcCMh0C2YiPl3x9ahohnd7VzUwhsek73WpvHG1kRYSDIVZ
   09IE4BWc2wM5yFNlNnfuF426g4Va9BO2ZzjkB6Gp45SWDQnjM0DNn/RuH
   NaEce348aD8uayEU3GzZ2Hs7U/dtn8FpAhEJh3nhcCwtvjtojJ2w0cd+G
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10770"; a="367796963"
X-IronPort-AV: E=Sophos;i="6.01,202,1684825200"; 
   d="scan'208";a="367796963"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2023 05:46:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10770"; a="757144480"
X-IronPort-AV: E=Sophos;i="6.01,202,1684825200"; 
   d="scan'208";a="757144480"
Received: from ijarvine-mobl2.ger.corp.intel.com ([10.251.222.39])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2023 05:46:07 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: linux-pci@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Rob Herring <robh@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Lukas Wunner <lukas@wunner.de>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Moshe Shemesh <moshe@mellanox.com>,
	netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Dean Luick <dean.luick@cornelisnetworks.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	=?UTF-8?q?Jonas=20Dre=C3=9Fler?= <verdre@v0yd.nl>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Moshe Shemesh <moshe@nvidia.com>,
	Simon Horman <simon.horman@corigine.com>,
	stable@vger.kernel.org
Subject: [PATCH v4 07/11] net/mlx5: Use RMW accessors for changing LNKCTL
Date: Thu, 13 Jul 2023 15:45:01 +0300
Message-Id: <20230713124505.94866-8-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230713124505.94866-1-ilpo.jarvinen@linux.intel.com>
References: <20230713124505.94866-1-ilpo.jarvinen@linux.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Don't assume that only the driver would be accessing LNKCTL of the
upstream bridge. ASPM policy changes can trigger write to LNKCTL
outside of driver's control.

Use RMW capability accessors which do proper locking to avoid losing
concurrent updates to the register value.

Fixes: eabe8e5e88f5 ("net/mlx5: Handle sync reset now event")
Suggested-by: Lukas Wunner <lukas@wunner.de>
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Reviewed-by: Moshe Shemesh <moshe@nvidia.com>
Reviewed-by: Simon Horman <simon.horman@corigine.com>
Cc: stable@vger.kernel.org
---
 drivers/net/ethernet/mellanox/mlx5/core/fw_reset.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/fw_reset.c b/drivers/net/ethernet/mellanox/mlx5/core/fw_reset.c
index 4804990b7f22..99dcbd006357 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/fw_reset.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/fw_reset.c
@@ -384,16 +384,11 @@ static int mlx5_pci_link_toggle(struct mlx5_core_dev *dev)
 		pci_cfg_access_lock(sdev);
 	}
 	/* PCI link toggle */
-	err = pci_read_config_word(bridge, cap + PCI_EXP_LNKCTL, &reg16);
-	if (err)
-		return err;
-	reg16 |= PCI_EXP_LNKCTL_LD;
-	err = pci_write_config_word(bridge, cap + PCI_EXP_LNKCTL, reg16);
+	err = pcie_capability_set_word(bridge, PCI_EXP_LNKCTL, PCI_EXP_LNKCTL_LD);
 	if (err)
 		return err;
 	msleep(500);
-	reg16 &= ~PCI_EXP_LNKCTL_LD;
-	err = pci_write_config_word(bridge, cap + PCI_EXP_LNKCTL, reg16);
+	err = pcie_capability_clear_word(bridge, PCI_EXP_LNKCTL, PCI_EXP_LNKCTL_LD);
 	if (err)
 		return err;
 
-- 
2.30.2


