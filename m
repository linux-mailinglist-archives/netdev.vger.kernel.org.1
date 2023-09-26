Return-Path: <netdev+bounces-36325-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D60D07AF2C8
	for <lists+netdev@lfdr.de>; Tue, 26 Sep 2023 20:27:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sy.mirrors.kernel.org (Postfix) with ESMTP id 4A8B4B20A15
	for <lists+netdev@lfdr.de>; Tue, 26 Sep 2023 18:27:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D61345F53;
	Tue, 26 Sep 2023 18:27:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD43E38FA5
	for <netdev@vger.kernel.org>; Tue, 26 Sep 2023 18:27:22 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2747CC0
	for <netdev@vger.kernel.org>; Tue, 26 Sep 2023 11:27:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1695752840;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EZhuG50Q5miV4PoSUjX8aTRuuoG/6ZgIoL2i9m/DJWw=;
	b=Bs7lij1pa5kq98quhtYyK9nde8aWptuBLAjmngY/RJISHdXZb+4t3mBab7BWsqKqQA8xYX
	MVNfhF/tRbDNM1Svouev/GidCLy5U/VVTR8MgM46Pj69SQF1XxdjXNA9XzMWMZH7evLVV9
	4c82rLavIYpA24XLIdI2DDAJFIsPtAU=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-58-A5drtdzlOamPXT2UA02Ffg-1; Tue, 26 Sep 2023 14:27:17 -0400
X-MC-Unique: A5drtdzlOamPXT2UA02Ffg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3EE721C0653D;
	Tue, 26 Sep 2023 18:27:17 +0000 (UTC)
Received: from p1.luc.cera.cz (unknown [10.45.225.119])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 9AB3640C6EA8;
	Tue, 26 Sep 2023 18:27:15 +0000 (UTC)
From: Ivan Vecera <ivecera@redhat.com>
To: netdev@vger.kernel.org
Cc: poros@redhat.com,
	mschmidt@redhat.com,
	jesse.brandeburg@intel.com,
	anthony.l.nguyen@intel.com,
	davem@davemloft.net,
	kuba@kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	intel-wired-lan@lists.osuosl.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next 2/9] i40e: Move I40E_MASK macro to i40e_register.h
Date: Tue, 26 Sep 2023 20:27:03 +0200
Message-ID: <20230926182710.2517901-3-ivecera@redhat.com>
In-Reply-To: <20230926182710.2517901-1-ivecera@redhat.com>
References: <20230926182710.2517901-1-ivecera@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_NONE autolearn=no autolearn_force=no
	version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

The macro is practically used only in i40e_register.h header file except
few I40E_MDIO_CLAUSE* macros that are defined in i40e_type.h
Move I40E_MASK macro to i40e_register.h header, I40E_MDIO_CLAUSE* macros
are refactored in subsequent patch.

Signed-off-by: Ivan Vecera <ivecera@redhat.com>
---
 drivers/net/ethernet/intel/i40e/i40e_register.h | 3 +++
 drivers/net/ethernet/intel/i40e/i40e_type.h     | 3 ---
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_register.h b/drivers/net/ethernet/intel/i40e/i40e_register.h
index 7339003aa17c..eebb5735772b 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_register.h
+++ b/drivers/net/ethernet/intel/i40e/i40e_register.h
@@ -4,6 +4,9 @@
 #ifndef _I40E_REGISTER_H_
 #define _I40E_REGISTER_H_
 
+/* I40E_MASK is a macro used on 32 bit registers */
+#define I40E_MASK(mask, shift) ((u32)(mask) << (shift))
+
 #define I40E_GL_ATQLEN_ATQCRIT_SHIFT 30
 #define I40E_GL_ATQLEN_ATQCRIT_MASK I40E_MASK(0x1, I40E_GL_ATQLEN_ATQCRIT_SHIFT)
 #define I40E_PF_ARQBAH 0x00080180 /* Reset: EMPR */
diff --git a/drivers/net/ethernet/intel/i40e/i40e_type.h b/drivers/net/ethernet/intel/i40e/i40e_type.h
index 658bc8913278..60b55d66d648 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_type.h
+++ b/drivers/net/ethernet/intel/i40e/i40e_type.h
@@ -11,9 +11,6 @@
 #include "i40e_lan_hmc.h"
 #include "i40e_devids.h"
 
-/* I40E_MASK is a macro used on 32 bit registers */
-#define I40E_MASK(mask, shift) ((u32)(mask) << (shift))
-
 #define I40E_MAX_VSI_QP			16
 #define I40E_MAX_VF_VSI			4
 #define I40E_MAX_CHAINED_RX_BUFFERS	5
-- 
2.41.0


