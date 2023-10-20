Return-Path: <netdev+bounces-42944-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DE847D0BA9
	for <lists+netdev@lfdr.de>; Fri, 20 Oct 2023 11:25:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC1792823D6
	for <lists+netdev@lfdr.de>; Fri, 20 Oct 2023 09:25:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABFF712E56;
	Fri, 20 Oct 2023 09:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94C6112E50
	for <netdev@vger.kernel.org>; Fri, 20 Oct 2023 09:25:24 +0000 (UTC)
Received: from mail.nfschina.com (unknown [42.101.60.195])
	by lindbergh.monkeyblade.net (Postfix) with SMTP id 83D7219B1;
	Fri, 20 Oct 2023 02:25:06 -0700 (PDT)
Received: from localhost.localdomain (unknown [180.167.10.98])
	by mail.nfschina.com (Maildata Gateway V2.8.8) with ESMTPA id 2B9B0604FCB31;
	Fri, 20 Oct 2023 17:25:01 +0800 (CST)
X-MD-Sfrom: suhui@nfschina.com
X-MD-SrcIP: 180.167.10.98
From: Su Hui <suhui@nfschina.com>
To: jesse.brandeburg@intel.com,
	anthony.l.nguyen@intel.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: Su Hui <suhui@nfschina.com>,
	intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: [PATCH] igb: e1000_82575: add an error code check in igb_set_d0_lplu_state_82575
Date: Fri, 20 Oct 2023 17:24:31 +0800
Message-Id: <20231020092430.209765-1-suhui@nfschina.com>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

igb_set_d0_lplu_state_82575() check all phy->ops.read_reg()'s return value
except this one, just fix this.

Signed-off-by: Su Hui <suhui@nfschina.com>
---
 drivers/net/ethernet/intel/igb/e1000_82575.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/intel/igb/e1000_82575.c b/drivers/net/ethernet/intel/igb/e1000_82575.c
index 8d6e44ee1895..e765d5ee3661 100644
--- a/drivers/net/ethernet/intel/igb/e1000_82575.c
+++ b/drivers/net/ethernet/intel/igb/e1000_82575.c
@@ -978,6 +978,9 @@ static s32 igb_set_d0_lplu_state_82575(struct e1000_hw *hw, bool active)
 		/* When LPLU is enabled, we should disable SmartSpeed */
 		ret_val = phy->ops.read_reg(hw, IGP01E1000_PHY_PORT_CONFIG,
 						&data);
+		if (ret_val)
+			goto out;
+
 		data &= ~IGP01E1000_PSCFR_SMART_SPEED;
 		ret_val = phy->ops.write_reg(hw, IGP01E1000_PHY_PORT_CONFIG,
 						 data);
-- 
2.30.2


