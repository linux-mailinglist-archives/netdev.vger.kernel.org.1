Return-Path: <netdev-owner@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B60687410E9
	for <lists+netdev@lfdr.de>; Wed, 28 Jun 2023 14:32:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230093AbjF1Mc0 (ORCPT <rfc822;lists+netdev@lfdr.de>);
        Wed, 28 Jun 2023 08:32:26 -0400
Received: from mph.eclipse.net.uk ([81.168.73.77]:38990 "EHLO
        mint-fitpc2.localdomain" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S229454AbjF1McX (ORCPT
        <rfc822;netdev@vger.kernel.org>); Wed, 28 Jun 2023 08:32:23 -0400
Received: from palantir17.mph.net (palantir17 [192.168.0.4])
        by mint-fitpc2.localdomain (Postfix) with ESMTP id 68D65320134;
        Wed, 28 Jun 2023 13:32:20 +0100 (BST)
Received: from localhost ([::1] helo=palantir17.mph.net)
        by palantir17.mph.net with esmtp (Exim 4.95)
        (envelope-from <habetsm.xilinx@gmail.com>)
        id 1qEULM-0000jT-21;
        Wed, 28 Jun 2023 13:32:20 +0100
Subject: [PATCH net] sfc: support for devlink port requires MAE access
From:   Martin Habets <habetsm.xilinx@gmail.com>
To:     davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
        edumazet@google.com
Cc:     netdev@vger.kernel.org, ecree.xilinx@gmail.com,
        linux-net-drivers@amd.com
Date:   Wed, 28 Jun 2023 13:32:20 +0100
Message-ID: <168795553996.2797.7851805610285857967.stgit@palantir17.mph.net>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <netdev.vger.kernel.org>
X-Mailing-List: netdev@vger.kernel.org

On systems without MAE permission efx->mae is not initialised,
and trying to lookup an mport results in a NULL pointer
dereference.

Fixes: 25414b2a64ae ("sfc: add devlink port support for ef100")
Signed-off-by: Martin Habets <habetsm.xilinx@gmail.com>
---
 drivers/net/ethernet/sfc/efx_devlink.c |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/sfc/efx_devlink.c b/drivers/net/ethernet/sfc/efx_devlink.c
index ef9971cbb695..0384b134e124 100644
--- a/drivers/net/ethernet/sfc/efx_devlink.c
+++ b/drivers/net/ethernet/sfc/efx_devlink.c
@@ -622,6 +622,9 @@ static struct devlink_port *ef100_set_devlink_port(struct efx_nic *efx, u32 idx)
 	u32 id;
 	int rc;
 
+	if (!efx->mae)
+		return NULL;
+
 	if (efx_mae_lookup_mport(efx, idx, &id)) {
 		/* This should not happen. */
 		if (idx == MAE_MPORT_DESC_VF_IDX_NULL)


