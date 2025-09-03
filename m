Return-Path: <netdev+bounces-219678-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A2D0FB4296A
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 21:03:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 124B53BF7F9
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 19:03:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C78ED369339;
	Wed,  3 Sep 2025 19:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a3+ggaHG"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA82E2C2AA2
	for <netdev@vger.kernel.org>; Wed,  3 Sep 2025 19:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756926169; cv=none; b=qG+JbH5KhoECUX3ecEOEwunrjCa/QOU6MbKZ+2ItwX02Rek22MIEza+lyGb49jvC/e4Efok+BZkka7xCuSvQqB1k/ksvQfbsp9uiABZCL2WJmXKg01cA0HH49C6P4FMFbJsfHZWFkmIcBOUwwKkwxZYXzQvoQkBpzE1B+/9c1oQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756926169; c=relaxed/simple;
	bh=xTtxSXE1yvDONysLDA9KqzBNgxSs0B2LZNlNuY0JSO4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OH+2TOU1wlbAe6wL8/YKjooARNiCtuw4pHCGMbXb4BIOe9vl1WMCMO+V96uKhYUrS49x7YmNrLLlpMxD+3oyuyMyxeuwkwlyMzI3o++fhvXtbAb4uF7nAIc8xfwGCMmPKhsEMLs3O8FQgt8FogQUovwtgeNZKAGFRXZwaBvQ+0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=a3+ggaHG; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756926165;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=YRc9qQhtPu4aJgrWe6QIrpHXB4Ut/KhAlfEhBqE7V54=;
	b=a3+ggaHGJNThzghQzQ5y5JSHDBOZASzUDpVLUOAD9oo+9YqzGdc0EOiP9cyQAPq9W1VqY6
	nf3O0tZd7hY36G2UM6NlpbCT3UAtdH2/P/sjconKsFWD5zo+KjNKmXnjTdHd/0hxsvi7RT
	cbOqOfnTkayrNdnkNS6J9jZRRwS/eM4=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-680-joMlbTwsPGCM0ErbIFOjOg-1; Wed, 03 Sep 2025 15:02:44 -0400
X-MC-Unique: joMlbTwsPGCM0ErbIFOjOg-1
X-Mimecast-MFC-AGG-ID: joMlbTwsPGCM0ErbIFOjOg_1756926163
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-45cb612d362so1362895e9.3
        for <netdev@vger.kernel.org>; Wed, 03 Sep 2025 12:02:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756926163; x=1757530963;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YRc9qQhtPu4aJgrWe6QIrpHXB4Ut/KhAlfEhBqE7V54=;
        b=auXnYtkU/IeivZJ3yVEP51LTMc0oPJFsCb+HFo9BV++hdCOxSXEzrw10k2VD3Mr5Q/
         PX5YIlR23VVEtXVLjwyi100DT090W7damhYfwXMoz3T2WZIWCGfPxeBvaUKMWsnevXMM
         o7QVRG4zKH5SqABZIpis5W1mZcsCPOIb7enfMgs+iyvyHkPFbpnHFaJ3ghHkXsH2oAPb
         wo/MIDjCq/3TTWSh6ZMMiDUnIsS54nv4U+rrBuQPgW0kuk1dj95Gm95JBjMdJuaGj3dG
         jNyrcqDKu1u6eHZo51diF75g1by/xOAgKZDb1iMEyu3SLSyQ0W36HVHv885AzPGLBNRE
         ZqOA==
X-Forwarded-Encrypted: i=1; AJvYcCVnSUm+spXyTBeXvXj+Ayj69hw3Oj/CmsrTjH2DJQE2y5Xrlbj7KpruqWwskCfXrJrQcWiunoI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxfwk0QKti0ng5vxj1WeJPIvgL7nMj79Xwd0x696eg+rjnKm7Ad
	q1oj4Bwx6HHtnx9ZgwylXivk/oLN1Al5VCG3ctQEKASHCY5oYk4uuywOl/4gSy6OIySL9LIvGfS
	btklHJ5TMoA/lmjuPK5kvL1QNH+uvzvyljqMDO0c+2m8el7f/R7HVnSfVGA==
X-Gm-Gg: ASbGnctxp8EiQc1Td24UgYbbUXRXlxC9oBUH2OviiRcJ1lCxfoHEwfYY3bFcCFPYpBP
	K2cQDjERw9CjsM3x+7BeeaSjjpnjOL5XA6JDZl63YQAjBUEqXDu2HTobCKG1p5oU+ycsgDhVJoE
	B9YGRyPCYzU0iFbwevMh6h7fi2P7GJJlYQwcoqwoyn7lLwVV8l9xbomyZGp0Bk9vBmA9Fx7oz+A
	rg2WdVBC5J4P9g5e0UprTZNzw4qQ+PE104esC7+8knOTcIBpSrCt9LUqACW18zQGgDrB5zT+Kkj
	tnEE1DJ9CaXe+zK4pq5nG8WnMqKxzejr/jSr5JmlKI/bcAc=
X-Received: by 2002:a05:600c:3b14:b0:45b:9c93:d237 with SMTP id 5b1f17b1804b1-45cfc8a9d32mr15316605e9.14.1756926162961;
        Wed, 03 Sep 2025 12:02:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHlZeBDIpo6ChshSjx9wt03zDRLgVFsNe6iBStfpel8EqkMRCiAdP47I2pV+o8YyqRg2cs+qw==
X-Received: by 2002:a05:600c:3b14:b0:45b:9c93:d237 with SMTP id 5b1f17b1804b1-45cfc8a9d32mr15316305e9.14.1756926162511;
        Wed, 03 Sep 2025 12:02:42 -0700 (PDT)
Received: from fedora.redhat.com ([2001:4df4:5814:7700:7fb2:f956:4fb9:7689])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b6f0c6b99sm331978655e9.4.2025.09.03.12.02.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Sep 2025 12:02:42 -0700 (PDT)
From: mheib@redhat.com
To: intel-wired-lan@lists.osuosl.org
Cc: przemyslawx.patynowski@intel.com,
	jiri@resnulli.us,
	netdev@vger.kernel.org,
	horms@kernel.org,
	jacob.e.keller@intel.com,
	aleksandr.loktionov@intel.com,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	Mohammad Heib <mheib@redhat.com>
Subject: [PATCH net-next,v2,1/2] devlink: Add new "max_mac_per_vf" generic device param
Date: Wed,  3 Sep 2025 22:02:28 +0300
Message-ID: <20250903190229.49193-1-mheib@redhat.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mohammad Heib <mheib@redhat.com>

Add a new device generic parameter to controls the maximum
number of MAC filters allowed per VF.

While this parameter is named `max_mac_per_vf`, the exact enforcement
policy may vary between drivers. For example, i40e applies this limit
only to trusted VFs, whereas other drivers may choose to apply it
uniformly across all VFs. The goal is to provide a consistent devlink
interface, while allowing flexibility for driver-specific behavior.

For example, to limit a VF to 3 MAC addresses:
 $ devlink dev param set pci/0000:3b:00.0 name max_mac_per_vf \
        value 3 \
        cmode runtime

Signed-off-by: Mohammad Heib <mheib@redhat.com>
---
 Documentation/networking/devlink/devlink-params.rst | 8 ++++++++
 include/net/devlink.h                               | 4 ++++
 net/devlink/param.c                                 | 5 +++++
 3 files changed, 17 insertions(+)

diff --git a/Documentation/networking/devlink/devlink-params.rst b/Documentation/networking/devlink/devlink-params.rst
index 211b58177e12..2bc9995fd849 100644
--- a/Documentation/networking/devlink/devlink-params.rst
+++ b/Documentation/networking/devlink/devlink-params.rst
@@ -143,3 +143,11 @@ own name.
    * - ``clock_id``
      - u64
      - Clock ID used by the device for registering DPLL devices and pins.
+   * - ``max_mac_per_vf``
+     - u32
+     - Controls the maximum number of MAC address filters that can be assigned
+       to a Virtual Function (VF).
+       The exact enforcement may depend on driver capabilities. For example,
+       some drivers may apply this limit only to *trusted* VFs, while others may
+       apply it to all VFs uniformly. This allows a consistent parameter across
+       devices while leaving flexibility for driver-specific behavior.
diff --git a/include/net/devlink.h b/include/net/devlink.h
index b32c9ceeb81d..dde5dcbca625 100644
--- a/include/net/devlink.h
+++ b/include/net/devlink.h
@@ -530,6 +530,7 @@ enum devlink_param_generic_id {
 	DEVLINK_PARAM_GENERIC_ID_EVENT_EQ_SIZE,
 	DEVLINK_PARAM_GENERIC_ID_ENABLE_PHC,
 	DEVLINK_PARAM_GENERIC_ID_CLOCK_ID,
+	DEVLINK_PARAM_GENERIC_ID_MAX_MAC_PER_VF,
 
 	/* add new param generic ids above here*/
 	__DEVLINK_PARAM_GENERIC_ID_MAX,
@@ -594,6 +595,9 @@ enum devlink_param_generic_id {
 #define DEVLINK_PARAM_GENERIC_CLOCK_ID_NAME "clock_id"
 #define DEVLINK_PARAM_GENERIC_CLOCK_ID_TYPE DEVLINK_PARAM_TYPE_U64
 
+#define DEVLINK_PARAM_GENERIC_MAX_MAC_PER_VF_NAME "max_mac_per_vf"
+#define DEVLINK_PARAM_GENERIC_MAX_MAC_PER_VF_TYPE DEVLINK_PARAM_TYPE_U32
+
 #define DEVLINK_PARAM_GENERIC(_id, _cmodes, _get, _set, _validate)	\
 {									\
 	.id = DEVLINK_PARAM_GENERIC_ID_##_id,				\
diff --git a/net/devlink/param.c b/net/devlink/param.c
index 41dcc86cfd94..62fd789ae01c 100644
--- a/net/devlink/param.c
+++ b/net/devlink/param.c
@@ -102,6 +102,11 @@ static const struct devlink_param devlink_param_generic[] = {
 		.name = DEVLINK_PARAM_GENERIC_CLOCK_ID_NAME,
 		.type = DEVLINK_PARAM_GENERIC_CLOCK_ID_TYPE,
 	},
+	{
+		.id = DEVLINK_PARAM_GENERIC_ID_MAX_MAC_PER_VF,
+		.name = DEVLINK_PARAM_GENERIC_MAX_MAC_PER_VF_NAME,
+		.type = DEVLINK_PARAM_GENERIC_MAX_MAC_PER_VF_TYPE,
+	},
 };
 
 static int devlink_param_generic_verify(const struct devlink_param *param)
-- 
2.50.1


