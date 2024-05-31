Return-Path: <netdev+bounces-99831-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 642B58D69BE
	for <lists+netdev@lfdr.de>; Fri, 31 May 2024 21:31:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A4F91C233AC
	for <lists+netdev@lfdr.de>; Fri, 31 May 2024 19:31:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6026117E46A;
	Fri, 31 May 2024 19:31:09 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from EX-PRD-EDGE01.vmware.com (EX-PRD-EDGE01.vmware.com [208.91.3.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3917D16D304;
	Fri, 31 May 2024 19:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=208.91.3.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717183869; cv=none; b=BDITTtEm8/HZC9Su8GqVgDvvU74lFSvv9U5ogdsdSNqOIqQAT929P1eAsgZxYEiLl0bGsK7S+yFc5YdTJ6bf0EOQ2VEItIKVdbxjaB28ld2uojyJWAwLwaRG2uZ+lBlPfxqXrPgGIdUHPG18CSaUp3tMGtbM8ghPK3KXL0KwZcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717183869; c=relaxed/simple;
	bh=fmNaQn/IwvJ2IsbnYJ+Za6oMl7krDzxwJu+FvRk4K3E=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lb2xDF+5M63t8+tPUjJroFuHXIpOOzECl4LPiXYhPU/57wI/yUpTreip2BeJBmHXE2lef9VQgJ8Q/5NPHpFJ5FtzkgDP9OlKj3T+OCdxkVRBN+uNja6TeHAisMRBpG4bwUN92s3U8WevhhcEZQBqMqRfaDFz7qy8gZ1D0lIfhV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com; spf=pass smtp.mailfrom=vmware.com; arc=none smtp.client-ip=208.91.3.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vmware.com
Received: from sc9-mailhost2.vmware.com (10.113.161.72) by
 EX-PRD-EDGE01.vmware.com (10.188.245.6) with Microsoft SMTP Server id
 15.1.2375.34; Fri, 31 May 2024 12:30:32 -0700
Received: from htb-1n-eng-dhcp122.eng.vmware.com (unknown [10.172.6.252])
	by sc9-mailhost2.vmware.com (Postfix) with ESMTP id 12C0B2018B;
	Fri, 31 May 2024 12:30:54 -0700 (PDT)
Received: by htb-1n-eng-dhcp122.eng.vmware.com (Postfix, from userid 0)
	id 0F04CB04D3; Fri, 31 May 2024 12:30:54 -0700 (PDT)
From: Ronak Doshi <ronak.doshi@broadcom.com>
To: <netdev@vger.kernel.org>
CC: Ronak Doshi <ronak.doshi@broadcom.com>, Broadcom internal kernel review
 list <bcm-kernel-feedback-list@broadcom.com>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, open list
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v2 net-next 1/4] vmxnet3: prepare for version 9 changes
Date: Fri, 31 May 2024 12:30:46 -0700
Message-ID: <20240531193050.4132-2-ronak.doshi@broadcom.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20240531193050.4132-1-ronak.doshi@broadcom.com>
References: <20240531193050.4132-1-ronak.doshi@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: SoftFail (EX-PRD-EDGE01.vmware.com: domain of transitioning
 ronak.doshi@broadcom.com discourages use of 10.113.161.72 as permitted
 sender)

vmxnet3 is currently at version 7 and this patch initiates the
preparation to accommodate changes for up to version 9. Introduced
utility macros for vmxnet3 version 9 comparison and update Copyright
information.

Signed-off-by: Ronak Doshi <ronak.doshi@broadcom.com>
Acked-by: Guolin Yang <guolin.yang@broadcom.com>
---
 drivers/net/vmxnet3/Makefile          | 2 +-
 drivers/net/vmxnet3/vmxnet3_defs.h    | 2 +-
 drivers/net/vmxnet3/vmxnet3_drv.c     | 2 +-
 drivers/net/vmxnet3/vmxnet3_ethtool.c | 2 +-
 drivers/net/vmxnet3/vmxnet3_int.h     | 8 +++++++-
 5 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/drivers/net/vmxnet3/Makefile b/drivers/net/vmxnet3/Makefile
index f82870c10205..59ef494ce2e0 100644
--- a/drivers/net/vmxnet3/Makefile
+++ b/drivers/net/vmxnet3/Makefile
@@ -2,7 +2,7 @@
 #
 # Linux driver for VMware's vmxnet3 ethernet NIC.
 #
-# Copyright (C) 2007-2022, VMware, Inc. All Rights Reserved.
+# Copyright (C) 2007-2024, VMware, Inc. All Rights Reserved.
 #
 # This program is free software; you can redistribute it and/or modify it
 # under the terms of the GNU General Public License as published by the
diff --git a/drivers/net/vmxnet3/vmxnet3_defs.h b/drivers/net/vmxnet3/vmxnet3_defs.h
index 41d6767283a6..67387bb7aa24 100644
--- a/drivers/net/vmxnet3/vmxnet3_defs.h
+++ b/drivers/net/vmxnet3/vmxnet3_defs.h
@@ -1,7 +1,7 @@
 /*
  * Linux driver for VMware's vmxnet3 ethernet NIC.
  *
- * Copyright (C) 2008-2022, VMware, Inc. All Rights Reserved.
+ * Copyright (C) 2008-2024, VMware, Inc. All Rights Reserved.
  *
  * This program is free software; you can redistribute it and/or modify it
  * under the terms of the GNU General Public License as published by the
diff --git a/drivers/net/vmxnet3/vmxnet3_drv.c b/drivers/net/vmxnet3/vmxnet3_drv.c
index 89ca6e75fcc6..b3f3136cc8be 100644
--- a/drivers/net/vmxnet3/vmxnet3_drv.c
+++ b/drivers/net/vmxnet3/vmxnet3_drv.c
@@ -1,7 +1,7 @@
 /*
  * Linux driver for VMware's vmxnet3 ethernet NIC.
  *
- * Copyright (C) 2008-2022, VMware, Inc. All Rights Reserved.
+ * Copyright (C) 2008-2024, VMware, Inc. All Rights Reserved.
  *
  * This program is free software; you can redistribute it and/or modify it
  * under the terms of the GNU General Public License as published by the
diff --git a/drivers/net/vmxnet3/vmxnet3_ethtool.c b/drivers/net/vmxnet3/vmxnet3_ethtool.c
index 7e8008d5378a..471f91c4204a 100644
--- a/drivers/net/vmxnet3/vmxnet3_ethtool.c
+++ b/drivers/net/vmxnet3/vmxnet3_ethtool.c
@@ -1,7 +1,7 @@
 /*
  * Linux driver for VMware's vmxnet3 ethernet NIC.
  *
- * Copyright (C) 2008-2022, VMware, Inc. All Rights Reserved.
+ * Copyright (C) 2008-2024, VMware, Inc. All Rights Reserved.
  *
  * This program is free software; you can redistribute it and/or modify it
  * under the terms of the GNU General Public License as published by the
diff --git a/drivers/net/vmxnet3/vmxnet3_int.h b/drivers/net/vmxnet3/vmxnet3_int.h
index 915aaf18c409..2926dfe8514f 100644
--- a/drivers/net/vmxnet3/vmxnet3_int.h
+++ b/drivers/net/vmxnet3/vmxnet3_int.h
@@ -1,7 +1,7 @@
 /*
  * Linux driver for VMware's vmxnet3 ethernet NIC.
  *
- * Copyright (C) 2008-2022, VMware, Inc. All Rights Reserved.
+ * Copyright (C) 2008-2024, VMware, Inc. All Rights Reserved.
  *
  * This program is free software; you can redistribute it and/or modify it
  * under the terms of the GNU General Public License as published by the
@@ -84,6 +84,8 @@
 	#define VMXNET3_RSS
 #endif
 
+#define VMXNET3_REV_9		8	/* Vmxnet3 Rev. 9 */
+#define VMXNET3_REV_8		7	/* Vmxnet3 Rev. 8 */
 #define VMXNET3_REV_7		6	/* Vmxnet3 Rev. 7 */
 #define VMXNET3_REV_6		5	/* Vmxnet3 Rev. 6 */
 #define VMXNET3_REV_5		4	/* Vmxnet3 Rev. 5 */
@@ -463,6 +465,10 @@ struct vmxnet3_adapter {
 	(adapter->version >= VMXNET3_REV_6 + 1)
 #define VMXNET3_VERSION_GE_7(adapter) \
 	(adapter->version >= VMXNET3_REV_7 + 1)
+#define VMXNET3_VERSION_GE_8(adapter) \
+	(adapter->version >= VMXNET3_REV_8 + 1)
+#define VMXNET3_VERSION_GE_9(adapter) \
+	(adapter->version >= VMXNET3_REV_9 + 1)
 
 /* must be a multiple of VMXNET3_RING_SIZE_ALIGN */
 #define VMXNET3_DEF_TX_RING_SIZE    512
-- 
2.11.0


