Return-Path: <netdev+bounces-52691-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 087697FFB5F
	for <lists+netdev@lfdr.de>; Thu, 30 Nov 2023 20:31:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9C790B20D0C
	for <lists+netdev@lfdr.de>; Thu, 30 Nov 2023 19:31:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 494EC52F66;
	Thu, 30 Nov 2023 19:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GikRZv8V"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0CCBD54
	for <netdev@vger.kernel.org>; Thu, 30 Nov 2023 11:31:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1701372699;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=XUKjduYx0sBCtPzyCQgJXjX+AsFij/jhpdfQd/PC2MQ=;
	b=GikRZv8VuIhIBuJYU1ysB2OdyhHoGEHSGc8OHyRIywo7LvrsOcgMuAuhfM6D+u7A24DmqV
	aZMWTvkg05fmW6B5r2vg7YR0GPccraxbuUC1+iXSXMByKpKA6MzwYz64zDFkPjY2O9jJB1
	O9dJlhoUl5CkVVSCdpqcZkYOrfdkxas=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-84-ruzrkH6zNcqvsDcI07CyeA-1; Thu, 30 Nov 2023 14:31:38 -0500
X-MC-Unique: ruzrkH6zNcqvsDcI07CyeA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id ACBB485A58C;
	Thu, 30 Nov 2023 19:31:37 +0000 (UTC)
Received: from p1.luc.cera.cz (unknown [10.45.225.216])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 061F31C060AE;
	Thu, 30 Nov 2023 19:31:35 +0000 (UTC)
From: Ivan Vecera <ivecera@redhat.com>
To: netdev@vger.kernel.org
Cc: Jesse Brandeburg <jesse.brandeburg@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
	intel-wired-lan@lists.osuosl.org (moderated list:INTEL ETHERNET DRIVERS),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH iwl-net] i40e: Fix wrong mask used during DCB config
Date: Thu, 30 Nov 2023 20:31:34 +0100
Message-ID: <20231130193135.1580284-1-ivecera@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7

Mask used for clearing PRTDCB_RETSTCC register in function
i40e_dcb_hw_rx_ets_bw_config() is incorrect as there is used
define I40E_PRTDCB_RETSTCC_ETSTC_SHIFT instead of define
I40E_PRTDCB_RETSTCC_ETSTC_MASK.

The PRTDCB_RETSTCC register is used to configure whether ETS
or strict priority is used as TSA in Rx for particular TC.

In practice it means that once the register is set to use ETS
as TSA then it is not possible to switch back to strict priority
without CoreR reset.

Fix the value in the clearing mask.

Fixes: 90bc8e003be2 ("i40e: Add hardware configuration for software based DCB")
Signed-off-by: Ivan Vecera <ivecera@redhat.com>
---
 drivers/net/ethernet/intel/i40e/i40e_dcb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_dcb.c b/drivers/net/ethernet/intel/i40e/i40e_dcb.c
index 68602fc375f6..073ffbfcbe8d 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_dcb.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_dcb.c
@@ -1576,7 +1576,7 @@ void i40e_dcb_hw_rx_ets_bw_config(struct i40e_hw *hw, u8 *bw_share,
 		reg = rd32(hw, I40E_PRTDCB_RETSTCC(i));
 		reg &= ~(I40E_PRTDCB_RETSTCC_BWSHARE_MASK     |
 			 I40E_PRTDCB_RETSTCC_UPINTC_MODE_MASK |
-			 I40E_PRTDCB_RETSTCC_ETSTC_SHIFT);
+			 I40E_PRTDCB_RETSTCC_ETSTC_MASK);
 		reg |= ((u32)bw_share[i] << I40E_PRTDCB_RETSTCC_BWSHARE_SHIFT) &
 			 I40E_PRTDCB_RETSTCC_BWSHARE_MASK;
 		reg |= ((u32)mode[i] << I40E_PRTDCB_RETSTCC_UPINTC_MODE_SHIFT) &
-- 
2.41.0


