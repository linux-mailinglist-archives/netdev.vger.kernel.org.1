Return-Path: <netdev+bounces-40832-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 76CA87C8C02
	for <lists+netdev@lfdr.de>; Fri, 13 Oct 2023 19:08:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8CB821C2129E
	for <lists+netdev@lfdr.de>; Fri, 13 Oct 2023 17:08:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 640CF219E6;
	Fri, 13 Oct 2023 17:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="W4mxzrwR"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1D7C21362
	for <netdev@vger.kernel.org>; Fri, 13 Oct 2023 17:08:25 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10395B7
	for <netdev@vger.kernel.org>; Fri, 13 Oct 2023 10:08:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1697216903;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jxrYnBgqo6Ypf3qFn6oPVVOuF0D+Jrw2SWHdpcdDDnA=;
	b=W4mxzrwRqNLlV1zgcAmZDjmoWfzsdgLf1klGeEsjpSyHOE7YDAzuemU1JY2/0otIM5KjIC
	2xuiDNniiVS5RRob9lr24PZHgEGRYgHWrrJZXUNt53X7A4hhXmWLDeX8vdQsY9ERr1M/SN
	7SgRhCor4oYUj8vBgHEMMNdCCsikZf0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-679-y7q8E_PHOtS-o4wjcSZ9Eg-1; Fri, 13 Oct 2023 13:08:07 -0400
X-MC-Unique: y7q8E_PHOtS-o4wjcSZ9Eg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 74E3581D785;
	Fri, 13 Oct 2023 17:08:06 +0000 (UTC)
Received: from p1.luc.cera.cz (unknown [10.45.225.161])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 0F19D1C060DF;
	Fri, 13 Oct 2023 17:08:04 +0000 (UTC)
From: Ivan Vecera <ivecera@redhat.com>
To: netdev@vger.kernel.org
Cc: Jesse Brandeburg <jesse.brandeburg@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org,
	intel-wired-lan@lists.osuosl.org
Subject: [PATCH net-next 5/5] i40e: Add PBA as board id info to devlink .info_get
Date: Fri, 13 Oct 2023 19:07:55 +0200
Message-ID: <20231013170755.2367410-6-ivecera@redhat.com>
In-Reply-To: <20231013170755.2367410-1-ivecera@redhat.com>
References: <20231013170755.2367410-1-ivecera@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Expose stored PBA ID string as unique board identifier via
devlink's .info_get command.

Signed-off-by: Ivan Vecera <ivecera@redhat.com>
---
 drivers/net/ethernet/intel/i40e/i40e_devlink.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_devlink.c b/drivers/net/ethernet/intel/i40e/i40e_devlink.c
index fb6144d74c98..9168ade8da47 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_devlink.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_devlink.c
@@ -29,7 +29,15 @@ static void i40e_info_fw_api(struct i40e_hw *hw, char *buf, size_t len)
 	snprintf(buf, len, "%u.%u", aq->api_maj_ver, aq->api_min_ver);
 }
 
+static void i40e_info_pba(struct i40e_hw *hw, char *buf, size_t len)
+{
+	buf[0] = '\0';
+	if (hw->pba_id)
+		strscpy(buf, hw->pba_id, len);
+}
+
 enum i40e_devlink_version_type {
+	I40E_DL_VERSION_FIXED,
 	I40E_DL_VERSION_RUNNING,
 };
 
@@ -41,6 +49,8 @@ static int i40e_devlink_info_put(struct devlink_info_req *req,
 		return 0;
 
 	switch (type) {
+	case I40E_DL_VERSION_FIXED:
+		return devlink_info_version_fixed_put(req, key, value);
 	case I40E_DL_VERSION_RUNNING:
 		return devlink_info_version_running_put(req, key, value);
 	}
@@ -90,6 +100,12 @@ static int i40e_devlink_info_get(struct devlink *dl,
 	i40e_info_civd_ver(hw, buf, sizeof(buf));
 	err = i40e_devlink_info_put(req, I40E_DL_VERSION_RUNNING,
 				    DEVLINK_INFO_VERSION_GENERIC_FW_UNDI, buf);
+	if (err)
+		return err;
+
+	i40e_info_pba(hw, buf, sizeof(buf));
+	err = i40e_devlink_info_put(req, I40E_DL_VERSION_FIXED,
+				    DEVLINK_INFO_VERSION_GENERIC_BOARD_ID, buf);
 
 	return err;
 }
-- 
2.41.0


