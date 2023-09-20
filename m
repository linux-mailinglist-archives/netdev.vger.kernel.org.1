Return-Path: <netdev+bounces-35223-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 772E17A7BB2
	for <lists+netdev@lfdr.de>; Wed, 20 Sep 2023 13:55:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2CC6D2815B6
	for <lists+netdev@lfdr.de>; Wed, 20 Sep 2023 11:55:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF304208BB;
	Wed, 20 Sep 2023 11:55:01 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61A1528E00
	for <netdev@vger.kernel.org>; Wed, 20 Sep 2023 11:55:00 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 668A592
	for <netdev@vger.kernel.org>; Wed, 20 Sep 2023 04:54:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1695210897;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=FbqkaALD9koK0woUrwUvX01fiQlAL8xBltNKiAO1nLU=;
	b=GWpM69VM8QjjwUP6X/XXGhNuIFqOChTIMh5zdAudy7x2lICDNEPdzbnM8fw18W4KuURceH
	IyOfVc5ScB5W2IypzkvmfKbgt/VphQFSeDASw2HUyL8foYzmg2oSeIdZ05lrvpjR8ZQTsH
	Eq1zJ5u7vIHV7hebzJy6nDVLlUEg42c=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-412-yWqD37fVOf2OKXhamFjCVw-1; Wed, 20 Sep 2023 07:54:53 -0400
X-MC-Unique: yWqD37fVOf2OKXhamFjCVw-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7DD863812591;
	Wed, 20 Sep 2023 11:54:52 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.45.225.145])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 3BE43492C37;
	Wed, 20 Sep 2023 11:54:51 +0000 (UTC)
From: Michal Schmidt <mschmidt@redhat.com>
To: intel-wired-lan@lists.osuosl.org
Cc: Jacob Keller <jacob.e.keller@intel.com>,
	Leyi Rong <leyi.rong@intel.com>,
	Michal Jaron <michalx.jaron@intel.com>,
	Mateusz Palczewski <mateusz.palczewski@intel.com>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Subject: [PATCH net] ice: always add legacy 32byte RXDID in supported_rxdids
Date: Wed, 20 Sep 2023 13:54:38 +0200
Message-ID: <20230920115439.61172-1-mschmidt@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_NONE autolearn=no autolearn_force=no
	version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

When the PF and VF drivers both support flexible rx descriptors and have
negotiated the VIRTCHNL_VF_OFFLOAD_RX_FLEX_DESC capability, the VF driver
queries the PF for the list of supported descriptor formats
(VIRTCHNL_OP_GET_SUPPORTED_RXDIDS). The PF driver is supposed to set the
supported_rxdids bits that correspond to the descriptor formats the
firmware implements. The legacy 32-byte rx desc format is always
supported, even though it is not expressed in GLFLXP_RXDID_FLAGS.

The ice driver does not advertise the legacy 32-byte rx desc support,
which leads to this failure to bring up the VF using the Intel
out-of-tree iavf driver:
 iavf 0000:41:01.0: PF does not list support for default Rx descriptor format
 ...
 iavf 0000:41:01.0: PF returned error -5 (VIRTCHNL_STATUS_ERR_PARAM) to our request 6

The in-tree iavf driver does not expose this bug, because it does not
yet implement VIRTCHNL_VF_OFFLOAD_RX_FLEX_DESC.

The ice driver must always set the ICE_RXDID_LEGACY_1 bit in
supported_rxdids. The Intel out-of-tree ice driver and the ice driver in
DPDK both do this.

I copied this piece of the code and the comment text from the Intel
out-of-tree driver.

Fixes: e753df8fbca5 ("ice: Add support Flex RXD")
Signed-off-by: Michal Schmidt <mschmidt@redhat.com>
---
 drivers/net/ethernet/intel/ice/ice_virtchnl.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_virtchnl.c b/drivers/net/ethernet/intel/ice/ice_virtchnl.c
index b03426ac932b..db97353efd06 100644
--- a/drivers/net/ethernet/intel/ice/ice_virtchnl.c
+++ b/drivers/net/ethernet/intel/ice/ice_virtchnl.c
@@ -2617,12 +2617,14 @@ static int ice_vc_query_rxdid(struct ice_vf *vf)
 		goto err;
 	}
 
-	/* Read flexiflag registers to determine whether the
-	 * corresponding RXDID is configured and supported or not.
-	 * Since Legacy 16byte descriptor format is not supported,
-	 * start from Legacy 32byte descriptor.
+	/* RXDIDs supported by DDP package can be read from the register
+	 * to get the supported RXDID bitmap. But the legacy 32byte RXDID
+	 * is not listed in DDP package, add it in the bitmap manually.
+	 * Legacy 16byte descriptor is not supported.
 	 */
-	for (i = ICE_RXDID_LEGACY_1; i < ICE_FLEX_DESC_RXDID_MAX_NUM; i++) {
+	rxdid->supported_rxdids |= BIT(ICE_RXDID_LEGACY_1);
+
+	for (i = ICE_RXDID_FLEX_NIC; i < ICE_FLEX_DESC_RXDID_MAX_NUM; i++) {
 		regval = rd32(hw, GLFLXP_RXDID_FLAGS(i, 0));
 		if ((regval >> GLFLXP_RXDID_FLAGS_FLEXIFLAG_4N_S)
 			& GLFLXP_RXDID_FLAGS_FLEXIFLAG_4N_M)
-- 
2.41.0


