Return-Path: <netdev+bounces-40827-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 874E27C8BF9
	for <lists+netdev@lfdr.de>; Fri, 13 Oct 2023 19:08:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D5968B209DF
	for <lists+netdev@lfdr.de>; Fri, 13 Oct 2023 17:08:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8DF321362;
	Fri, 13 Oct 2023 17:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hq2oLi9k"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 442FD219EA
	for <netdev@vger.kernel.org>; Fri, 13 Oct 2023 17:08:06 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46B6BCA
	for <netdev@vger.kernel.org>; Fri, 13 Oct 2023 10:08:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1697216884;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=TksTCekXADksDkw6zz27tOiFc5jOxJuDTlx+GNP+MB4=;
	b=hq2oLi9ku3aWrgMkBVE284jZ3NtEid8GcnsX3sLolUF3sLPIUi9BUsD2w+2Xo3kocsINxo
	EbcyaBXcIbLh7nkm1L2/FGXVsmQ9JLbBd2aPap2r49U3tnvz9o8PpXbAs69nFNHB1GKD+O
	iPCpNvlaKEY76CLCiIsEvnH1JqrF0pY=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-449-p1fc9ffLPHa4J1LrbnZu_A-1; Fri, 13 Oct 2023 13:07:58 -0400
X-MC-Unique: p1fc9ffLPHa4J1LrbnZu_A-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 24E832800E84;
	Fri, 13 Oct 2023 17:07:58 +0000 (UTC)
Received: from p1.luc.cera.cz (unknown [10.45.225.161])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 907BA1C060DF;
	Fri, 13 Oct 2023 17:07:56 +0000 (UTC)
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
Subject: [PATCH net-next 0/5] i40e: Add basic devlink support
Date: Fri, 13 Oct 2023 19:07:50 +0200
Message-ID: <20231013170755.2367410-1-ivecera@redhat.com>
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

The series adds initial support for devlink to i40e driver.

Patch-set overview:
Patch 1: Adds initial devlink support (devlink and port registration)
Patch 2: Refactors and split i40e_nvm_version_str()
Patch 3: Adds support for 'devlink dev info'
Patch 4: Refactors existing helper function to read PBA ID
Patch 5: Adds 'board.id' to 'devlink dev info' using PBA ID

Ivan Vecera (5):
  i40e: Add initial devlink support
  i40e: Split and refactor i40e_nvm_version_str()
  i40e: Add handler for devlink .info_get
  i40e: Refactor and rename i40e_read_pba_string()
  i40e: Add PBA as board id info to devlink .info_get

 drivers/net/ethernet/intel/Kconfig            |   1 +
 drivers/net/ethernet/intel/i40e/Makefile      |   3 +-
 drivers/net/ethernet/intel/i40e/i40e.h        | 136 ++++++++---
 drivers/net/ethernet/intel/i40e/i40e_common.c |  58 +++--
 .../net/ethernet/intel/i40e/i40e_devlink.c    | 224 ++++++++++++++++++
 .../net/ethernet/intel/i40e/i40e_devlink.h    |  18 ++
 .../net/ethernet/intel/i40e/i40e_ethtool.c    |   4 +-
 drivers/net/ethernet/intel/i40e/i40e_main.c   |  40 +++-
 .../net/ethernet/intel/i40e/i40e_prototype.h  |   3 +-
 drivers/net/ethernet/intel/i40e/i40e_type.h   |   3 +
 10 files changed, 414 insertions(+), 76 deletions(-)
 create mode 100644 drivers/net/ethernet/intel/i40e/i40e_devlink.c
 create mode 100644 drivers/net/ethernet/intel/i40e/i40e_devlink.h

-- 
2.41.0


