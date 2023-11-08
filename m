Return-Path: <netdev+bounces-46673-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 687A87E5AC0
	for <lists+netdev@lfdr.de>; Wed,  8 Nov 2023 17:01:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D83F281396
	for <lists+netdev@lfdr.de>; Wed,  8 Nov 2023 16:01:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 478CE3065E;
	Wed,  8 Nov 2023 16:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="V6v8JFgy"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8D3030656
	for <netdev@vger.kernel.org>; Wed,  8 Nov 2023 16:01:13 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A1C0172E
	for <netdev@vger.kernel.org>; Wed,  8 Nov 2023 08:01:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1699459272;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=rQ51b9eM0IFRwZBnxfiG5qJhLYeuJ0C09QIPA+aM9L8=;
	b=V6v8JFgyd2A9aSBoKB20USk6q8fS3KpxFsQZzRcnLyvE+GV0Sya9ekmjEy2DHOBfoBn7Q/
	jmUmJdxp7A7pqu3PCE1pDou733tj49ny/QgAjiw+6p4s11J3aEXkcTRuL2yi3Nyv7WLANF
	Gz9XZZogDas0t0ebVAeTnUD2H4k5VuE=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-104-3s9y6T4AMICaPuwOeGB2SA-1; Wed,
 08 Nov 2023 11:01:08 -0500
X-MC-Unique: 3s9y6T4AMICaPuwOeGB2SA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A634A3810D35;
	Wed,  8 Nov 2023 16:01:06 +0000 (UTC)
Received: from p1.luc.cera.cz (unknown [10.45.225.110])
	by smtp.corp.redhat.com (Postfix) with ESMTP id C75042166B27;
	Wed,  8 Nov 2023 16:01:04 +0000 (UTC)
From: Ivan Vecera <ivecera@redhat.com>
To: intel-wired-lan@lists.osuosl.org
Cc: Jacob Keller <jacob.e.keller@intel.com>,
	Wojciech Drewek <wojciech.drewek@intel.com>,
	Jesse Brandeburg <jesse.brandeburg@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
	Neerav Parikh <neerav.parikh@intel.com>,
	netdev@vger.kernel.org (open list:NETWORKING DRIVERS),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH iwl-net] i40e: Fix waiting for queues of all VSIs to be disabled
Date: Wed,  8 Nov 2023 17:01:03 +0100
Message-ID: <20231108160104.86140-1-ivecera@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6

The function i40e_pf_wait_queues_disabled() iterates all PF's VSIs
up to 'pf->hw.func_caps.num_vsis' but this is incorrect because
the real number of VSIs can be up to 'pf->num_alloc_vsi' that
can be higher. Fix this loop.

Fixes: 69129dc39fac ("i40e: Modify Tx disable wait flow in case of DCB reconfiguration")
Signed-off-by: Ivan Vecera <ivecera@redhat.com>
---
 drivers/net/ethernet/intel/i40e/i40e_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index 6a2907674583..de19d753ba83 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -5340,7 +5340,7 @@ static int i40e_pf_wait_queues_disabled(struct i40e_pf *pf)
 {
 	int v, ret = 0;
 
-	for (v = 0; v < pf->hw.func_caps.num_vsis; v++) {
+	for (v = 0; v < pf->num_alloc_vsi; v++) {
 		if (pf->vsi[v]) {
 			ret = i40e_vsi_wait_queues_disabled(pf->vsi[v]);
 			if (ret)
-- 
2.41.0


