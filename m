Return-Path: <netdev+bounces-48520-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84C817EEA86
	for <lists+netdev@lfdr.de>; Fri, 17 Nov 2023 02:01:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 14B7A2812EB
	for <lists+netdev@lfdr.de>; Fri, 17 Nov 2023 01:01:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24EDC817;
	Fri, 17 Nov 2023 01:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hDd1DzEZ"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22276129
	for <netdev@vger.kernel.org>; Thu, 16 Nov 2023 17:00:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700182857; x=1731718857;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=i8eR8vzskm4EGOPd3b1RA0YscHZ39w0sfT2CwKhySj0=;
  b=hDd1DzEZ67rNu4WIkp7NuJl2dUVsSyXbp5TThDYOQ+tjEZHaLFYvoQP0
   M9OHJCBlY4Tp1S029/ShANwIynZPaKEUu21Of1j+3G3StRsRfZfV0qG7O
   2hpE1NMXEyZEDw9xlEVvtWiMA24U65Tft9NHky4j3vrrtVS2v8xHdRQlE
   KxmQjcc6/Kg78oaR1WAvKGrbuAB9wPqkVJ9/WbtTrBm/xEWrXMgIKGcmO
   /aItRnOM7lrY93cETFJF2fViat/gzPTG4S44r6nL8yaYfqX2VNxFtrDex
   Nt5LHYSVlQuVZuMuh51K0yokaIaVEf/YI9dK76G3QV5Sl2NTSGWQB1YmQ
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10896"; a="381605260"
X-IronPort-AV: E=Sophos;i="6.04,205,1695711600"; 
   d="scan'208";a="381605260"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2023 17:00:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10896"; a="759019607"
X-IronPort-AV: E=Sophos;i="6.04,205,1695711600"; 
   d="scan'208";a="759019607"
Received: from anambiarhost.jf.intel.com ([10.166.29.163])
  by orsmga007.jf.intel.com with ESMTP; 16 Nov 2023 17:00:56 -0800
Subject: [net-next PATCH v8 07/10] netdev-genl: spec: Add irq in netdev
 netlink YAML spec
From: Amritha Nambiar <amritha.nambiar@intel.com>
To: netdev@vger.kernel.org, kuba@kernel.org, pabeni@redhat.com
Cc: sridhar.samudrala@intel.com, amritha.nambiar@intel.com
Date: Thu, 16 Nov 2023 17:17:14 -0800
Message-ID: <170018383470.3767.4128247251513369127.stgit@anambiarhost.jf.intel.com>
In-Reply-To: <170018355327.3767.5169918029687620348.stgit@anambiarhost.jf.intel.com>
References: <170018355327.3767.5169918029687620348.stgit@anambiarhost.jf.intel.com>
User-Agent: StGit/unknown-version
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

Add support in netlink spec(netdev.yaml) for interrupt number
among the NAPI attributes. Add code generated from the spec.

Signed-off-by: Amritha Nambiar <amritha.nambiar@intel.com>
Reviewed-by: Sridhar Samudrala <sridhar.samudrala@intel.com>
---
 Documentation/netlink/specs/netdev.yaml |    5 +++++
 include/uapi/linux/netdev.h             |    1 +
 tools/include/uapi/linux/netdev.h       |    1 +
 tools/net/ynl/generated/netdev-user.c   |    6 ++++++
 tools/net/ynl/generated/netdev-user.h   |    2 ++
 5 files changed, 15 insertions(+)

diff --git a/Documentation/netlink/specs/netdev.yaml b/Documentation/netlink/specs/netdev.yaml
index d68ab270618e..4161f302352d 100644
--- a/Documentation/netlink/specs/netdev.yaml
+++ b/Documentation/netlink/specs/netdev.yaml
@@ -104,6 +104,10 @@ attribute-sets:
         name: id
         doc: ID of the NAPI instance.
         type: u32
+      -
+        name: irq
+        doc: The associated interrupt vector number for the napi
+        type: u32
   -
     name: queue
     attributes:
@@ -197,6 +201,7 @@ operations:
           attributes:
             - id
             - ifindex
+            - irq
       dump:
         request:
           attributes:
diff --git a/include/uapi/linux/netdev.h b/include/uapi/linux/netdev.h
index ee590cbb9782..10ddb7cfde07 100644
--- a/include/uapi/linux/netdev.h
+++ b/include/uapi/linux/netdev.h
@@ -72,6 +72,7 @@ enum {
 enum {
 	NETDEV_A_NAPI_IFINDEX = 1,
 	NETDEV_A_NAPI_ID,
+	NETDEV_A_NAPI_IRQ,
 
 	__NETDEV_A_NAPI_MAX,
 	NETDEV_A_NAPI_MAX = (__NETDEV_A_NAPI_MAX - 1)
diff --git a/tools/include/uapi/linux/netdev.h b/tools/include/uapi/linux/netdev.h
index ee590cbb9782..10ddb7cfde07 100644
--- a/tools/include/uapi/linux/netdev.h
+++ b/tools/include/uapi/linux/netdev.h
@@ -72,6 +72,7 @@ enum {
 enum {
 	NETDEV_A_NAPI_IFINDEX = 1,
 	NETDEV_A_NAPI_ID,
+	NETDEV_A_NAPI_IRQ,
 
 	__NETDEV_A_NAPI_MAX,
 	NETDEV_A_NAPI_MAX = (__NETDEV_A_NAPI_MAX - 1)
diff --git a/tools/net/ynl/generated/netdev-user.c b/tools/net/ynl/generated/netdev-user.c
index a49265f4f4d9..2bd57420b548 100644
--- a/tools/net/ynl/generated/netdev-user.c
+++ b/tools/net/ynl/generated/netdev-user.c
@@ -101,6 +101,7 @@ struct ynl_policy_nest netdev_queue_nest = {
 struct ynl_policy_attr netdev_napi_policy[NETDEV_A_NAPI_MAX + 1] = {
 	[NETDEV_A_NAPI_IFINDEX] = { .name = "ifindex", .type = YNL_PT_U32, },
 	[NETDEV_A_NAPI_ID] = { .name = "id", .type = YNL_PT_U32, },
+	[NETDEV_A_NAPI_IRQ] = { .name = "irq", .type = YNL_PT_U32, },
 };
 
 struct ynl_policy_nest netdev_napi_nest = {
@@ -394,6 +395,11 @@ int netdev_napi_get_rsp_parse(const struct nlmsghdr *nlh, void *data)
 				return MNL_CB_ERROR;
 			dst->_present.ifindex = 1;
 			dst->ifindex = mnl_attr_get_u32(attr);
+		} else if (type == NETDEV_A_NAPI_IRQ) {
+			if (ynl_attr_validate(yarg, attr))
+				return MNL_CB_ERROR;
+			dst->_present.irq = 1;
+			dst->irq = mnl_attr_get_u32(attr);
 		}
 	}
 
diff --git a/tools/net/ynl/generated/netdev-user.h b/tools/net/ynl/generated/netdev-user.h
index 33ba75905ee1..de7205b63ccf 100644
--- a/tools/net/ynl/generated/netdev-user.h
+++ b/tools/net/ynl/generated/netdev-user.h
@@ -213,10 +213,12 @@ struct netdev_napi_get_rsp {
 	struct {
 		__u32 id:1;
 		__u32 ifindex:1;
+		__u32 irq:1;
 	} _present;
 
 	__u32 id;
 	__u32 ifindex;
+	__u32 irq;
 };
 
 void netdev_napi_get_rsp_free(struct netdev_napi_get_rsp *rsp);


