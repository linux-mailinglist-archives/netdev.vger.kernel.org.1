Return-Path: <netdev+bounces-32447-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DE407979A8
	for <lists+netdev@lfdr.de>; Thu,  7 Sep 2023 19:18:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 18DD0281450
	for <lists+netdev@lfdr.de>; Thu,  7 Sep 2023 17:18:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFB0913AD4;
	Thu,  7 Sep 2023 17:17:47 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A163413AC7
	for <netdev@vger.kernel.org>; Thu,  7 Sep 2023 17:17:47 +0000 (UTC)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D8611FFE;
	Thu,  7 Sep 2023 10:17:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=WtCoctKqrOuNL7YPM9mYObCf6Hdm7ApMb7s6UV96VRg=;
  b=HPx166wijMpi0SuqjYCYznd1XBpiCUbrQLc/PO/UMyEq3ZEUYTobIRDo
   3Rqqz8tTf3ziWlg9eiO0gtAOEfHBNxrgu+g1iTCYRdavySvFpyxmeL4HB
   GFAsE9lOiSmMbIKRRI/H8INxUF7Ej0oMCIoW7c5cwML7MMfndJw9rsVW5
   k=;
Authentication-Results: mail3-relais-sop.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=Julia.Lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="6.02,234,1688421600"; 
   d="scan'208";a="65324651"
Received: from i80.paris.inria.fr (HELO i80.paris.inria.fr.) ([128.93.90.48])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2023 11:55:29 +0200
From: Julia Lawall <Julia.Lawall@inria.fr>
To: alsa-devel@alsa-project.org
Cc: kernel-janitors@vger.kernel.org,
	Zhang Rui <rui.zhang@intel.com>,
	Amit Kucheria <amitk@kernel.org>,
	linux-pm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	netdev@vger.kernel.org,
	bcm-kernel-feedback-list@broadcom.com,
	linux-kernel@vger.kernel.org,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	linuxppc-dev@lists.ozlabs.org,
	linux-mmc@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-mediatek@lists.infradead.org,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-media@vger.kernel.org
Subject: [PATCH 00/11] add missing of_node_put
Date: Thu,  7 Sep 2023 11:55:10 +0200
Message-Id: <20230907095521.14053-1-Julia.Lawall@inria.fr>
X-Mailer: git-send-email 2.20.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Add of_node_put on a break out of an of_node loop.

---

 arch/powerpc/kexec/file_load_64.c                    |    8 ++++++--
 arch/powerpc/platforms/powermac/low_i2c.c            |    4 +++-
 arch/powerpc/platforms/powermac/smp.c                |    4 +++-
 drivers/bus/arm-cci.c                                |    4 +++-
 drivers/genpd/ti/ti_sci_pm_domains.c                 |    8 ++++++--
 drivers/gpu/drm/mediatek/mtk_disp_ovl_adaptor.c      |    4 +++-
 drivers/gpu/drm/mediatek/mtk_drm_drv.c               |    4 +++-
 drivers/media/platform/mediatek/mdp3/mtk-mdp3-comp.c |    1 +
 drivers/mmc/host/atmel-mci.c                         |    8 ++++++--
 drivers/net/ethernet/broadcom/asp2/bcmasp.c          |    1 +
 drivers/soc/dove/pmu.c                               |    5 ++++-
 drivers/thermal/thermal_of.c                         |    8 ++++++--
 sound/soc/sh/rcar/core.c                             |    1 +
 13 files changed, 46 insertions(+), 14 deletions(-)

