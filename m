Return-Path: <netdev+bounces-31570-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D161378ECF2
	for <lists+netdev@lfdr.de>; Thu, 31 Aug 2023 14:19:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8AB4E281548
	for <lists+netdev@lfdr.de>; Thu, 31 Aug 2023 12:19:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B23A1111BE;
	Thu, 31 Aug 2023 12:19:20 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A64831170B
	for <netdev@vger.kernel.org>; Thu, 31 Aug 2023 12:19:20 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9ABB1A6
	for <netdev@vger.kernel.org>; Thu, 31 Aug 2023 05:19:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1693484359;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=oET/UC3oZ/ERnpqoK6/p2ncmcfVMZqsG2bSEB3AWRgs=;
	b=ht5Kkw8G3YvHTf60pev3dNHDwMukTOnrqp5+VI2Pr2eXqsohkpSFQE3cKfpsf+E1+TK+wQ
	Awi3nrfuPXyHIe1MaC+rcIC2JgxPSyL/K1WljrFp15iihN68TQVCyssci+Hc61IizF27Zd
	IgxLk6X4ouy2WY2UIKQIwfTIxVRricw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-695-_RgXO7JhPNGXqn6p9FfHzw-1; Thu, 31 Aug 2023 08:19:15 -0400
X-MC-Unique: _RgXO7JhPNGXqn6p9FfHzw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2FAA08022E4;
	Thu, 31 Aug 2023 12:19:15 +0000 (UTC)
Received: from calimero.vinschen.de (unknown [10.39.192.15])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 0DCA69A;
	Thu, 31 Aug 2023 12:19:15 +0000 (UTC)
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 06F3DA81EA3; Thu, 31 Aug 2023 14:19:14 +0200 (CEST)
From: Corinna Vinschen <vinschen@redhat.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>,
	jesse.brandeburg@intel.com,
	intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org
Subject: [PATCH v2 net] igb: disable virtualization features on 82580
Date: Thu, 31 Aug 2023 14:19:13 +0200
Message-ID: <20230831121914.660875-1-vinschen@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Disable virtualization features on 82580 just as on i210/i211.
This avoids that virt functions are acidentally called on 82850.

Fixes: 55cac248caa4 ("igb: Add full support for 82580 devices")
Signed-off-by: Corinna Vinschen <vinschen@redhat.com>
---
 drivers/net/ethernet/intel/igb/igb_main.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
index 1ab787ed254d..13ba9c74bd84 100644
--- a/drivers/net/ethernet/intel/igb/igb_main.c
+++ b/drivers/net/ethernet/intel/igb/igb_main.c
@@ -3933,8 +3933,9 @@ static void igb_probe_vfs(struct igb_adapter *adapter)
 	struct pci_dev *pdev = adapter->pdev;
 	struct e1000_hw *hw = &adapter->hw;
 
-	/* Virtualization features not supported on i210 family. */
-	if ((hw->mac.type == e1000_i210) || (hw->mac.type == e1000_i211))
+	/* Virtualization features not supported on i210 and 82580 family. */
+	if ((hw->mac.type == e1000_i210) || (hw->mac.type == e1000_i211) ||
+	    (hw->mac.type == e1000_82580))
 		return;
 
 	/* Of the below we really only want the effect of getting
-- 
2.31.1


