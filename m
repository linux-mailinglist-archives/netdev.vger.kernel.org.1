Return-Path: <netdev+bounces-42730-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A8B37CFFB6
	for <lists+netdev@lfdr.de>; Thu, 19 Oct 2023 18:37:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D867D2820A1
	for <lists+netdev@lfdr.de>; Thu, 19 Oct 2023 16:37:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CD5D27458;
	Thu, 19 Oct 2023 16:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NGW35ebD"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FD1C32C68
	for <netdev@vger.kernel.org>; Thu, 19 Oct 2023 16:37:32 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0BB4124
	for <netdev@vger.kernel.org>; Thu, 19 Oct 2023 09:37:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1697733450;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=aCk5y5U6S6pBpWhKJtSh1SurFp9oD5gnKu4jbHvlKmo=;
	b=NGW35ebDzS11SfHqb63WcU9VdCOYi7ofFv5tm9xM1Jx5A+IqhOW7VgY2/PJREj0Pz2aaUP
	68DfLTNd9rDvSqOU47mor35vvpoMiCrtmficM9AbxMtM/UukJeAHLFk4SVGTUi+kBAgiF0
	vndICMyDF/t7LDMpzGmxTuZoQt4V5L0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-444-TxVd3RA4PPiZ1DhsYil0lA-1; Thu, 19 Oct 2023 12:37:24 -0400
X-MC-Unique: TxVd3RA4PPiZ1DhsYil0lA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E3B828E6D01;
	Thu, 19 Oct 2023 16:37:23 +0000 (UTC)
Received: from p1.luc.com (unknown [10.45.226.105])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 0379925C8;
	Thu, 19 Oct 2023 16:37:21 +0000 (UTC)
From: Ivan Vecera <ivecera@redhat.com>
To: netdev@vger.kernel.org
Cc: Mateusz Palczewski <mateusz.palczewski@intel.com>,
	Simon Horman <horms@kernel.org>,
	Jesse Brandeburg <jesse.brandeburg@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Przemyslaw Patynowski <przemyslawx.patynowski@intel.com>,
	Sylwester Dziedziuch <sylwesterx.dziedziuch@intel.com>,
	intel-wired-lan@lists.osuosl.org (moderated list:INTEL ETHERNET DRIVERS),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net v2] i40e: Fix I40E_FLAG_VF_VLAN_PRUNING value
Date: Thu, 19 Oct 2023 18:37:20 +0200
Message-ID: <20231019163721.1333370-1-ivecera@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1

Commit c87c938f62d8f1 ("i40e: Add VF VLAN pruning") added new
PF flag I40E_FLAG_VF_VLAN_PRUNING but its value collides with
existing I40E_FLAG_TOTAL_PORT_SHUTDOWN_ENABLED flag.

Move the affected flag at the end of the flags and fix its value.

Reproducer:
[root@cnb-03 ~]# ethtool --set-priv-flags enp2s0f0np0 link-down-on-close on
[root@cnb-03 ~]# ethtool --set-priv-flags enp2s0f0np0 vf-vlan-pruning on
[root@cnb-03 ~]# ethtool --set-priv-flags enp2s0f0np0 link-down-on-close off
[ 6323.142585] i40e 0000:02:00.0: Setting link-down-on-close not supported on this port (because total-port-shutdown is enabled)
netlink error: Operation not supported
[root@cnb-03 ~]# ethtool --set-priv-flags enp2s0f0np0 vf-vlan-pruning off
[root@cnb-03 ~]# ethtool --set-priv-flags enp2s0f0np0 link-down-on-close off

The link-down-on-close flag cannot be modified after setting vf-vlan-pruning
because vf-vlan-pruning shares the same bit with total-port-shutdown flag
that prevents any modification of link-down-on-close flag.

Fixes: c87c938f62d8 ("i40e: Add VF VLAN pruning")
Cc: Mateusz Palczewski <mateusz.palczewski@intel.com>
Cc: Simon Horman <horms@kernel.org>
Signed-off-by: Ivan Vecera <ivecera@redhat.com>
---
 drivers/net/ethernet/intel/i40e/i40e.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e.h b/drivers/net/ethernet/intel/i40e/i40e.h
index 6e310a53946782..55bb0b5310d5b4 100644
--- a/drivers/net/ethernet/intel/i40e/i40e.h
+++ b/drivers/net/ethernet/intel/i40e/i40e.h
@@ -580,7 +580,6 @@ struct i40e_pf {
 #define I40E_FLAG_DISABLE_FW_LLDP		BIT(24)
 #define I40E_FLAG_RS_FEC			BIT(25)
 #define I40E_FLAG_BASE_R_FEC			BIT(26)
-#define I40E_FLAG_VF_VLAN_PRUNING		BIT(27)
 /* TOTAL_PORT_SHUTDOWN
  * Allows to physically disable the link on the NIC's port.
  * If enabled, (after link down request from the OS)
@@ -603,6 +602,7 @@ struct i40e_pf {
  *   in abilities field of i40e_aq_set_phy_config structure
  */
 #define I40E_FLAG_TOTAL_PORT_SHUTDOWN_ENABLED	BIT(27)
+#define I40E_FLAG_VF_VLAN_PRUNING		BIT(28)
 
 	struct i40e_client_instance *cinst;
 	bool stat_offsets_loaded;
-- 
2.41.0


