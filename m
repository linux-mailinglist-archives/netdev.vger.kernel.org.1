Return-Path: <netdev+bounces-22485-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E8B376799F
	for <lists+netdev@lfdr.de>; Sat, 29 Jul 2023 02:34:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7FCD11C21979
	for <lists+netdev@lfdr.de>; Sat, 29 Jul 2023 00:34:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F4CA1840;
	Sat, 29 Jul 2023 00:32:48 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53E987C
	for <netdev@vger.kernel.org>; Sat, 29 Jul 2023 00:32:48 +0000 (UTC)
Received: from mgamail.intel.com (unknown [134.134.136.20])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5CA935A0
	for <netdev@vger.kernel.org>; Fri, 28 Jul 2023 17:32:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690590765; x=1722126765;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=G3M70G3UVMFvC69ARVZ1G0JHf+/eAjDk5iT62sTYQJA=;
  b=OICH6mewVonMtfP4SkGPgoTfvm606FESGLKNWAbUY+lAdxvaLGmreaGP
   NhdNdk3dOSqIj1ojNqPlajfXdU3UzTww9CPnvqK7vcxkUqmIRwgK0MoUk
   ODGy6dQ2j57uSWoN1hDJE/SfazfW2RZHINoVGxj8Y9qcSjhcx2NTI+FPX
   Pz+GKj0EzlyH7a98ZJshcZF2pfm876pQCFKMTu34cLBd2bmFn48+vmNV4
   o8jA07uWdsY1yzRk4WDORrNtCBPQqW7OvdNCtz734GEVQmy6/aVMW7tYb
   jE4NnUiRd9A2jLtTLtmljuMcBdedej1ftOS2bRQS245ARNnby6EveKNLa
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10785"; a="358742229"
X-IronPort-AV: E=Sophos;i="6.01,238,1684825200"; 
   d="scan'208";a="358742229"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2023 17:32:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10785"; a="901478238"
X-IronPort-AV: E=Sophos;i="6.01,238,1684825200"; 
   d="scan'208";a="901478238"
Received: from anambiarhost.jf.intel.com ([10.166.29.163])
  by orsmga005.jf.intel.com with ESMTP; 28 Jul 2023 17:32:45 -0700
Subject: [net-next PATCH v1 8/9] netdev-genl: spec: Add PID in netdev
 netlink YAML spec
From: Amritha Nambiar <amritha.nambiar@intel.com>
To: netdev@vger.kernel.org, kuba@kernel.org, davem@davemloft.net
Cc: sridhar.samudrala@intel.com, amritha.nambiar@intel.com
Date: Fri, 28 Jul 2023 17:47:33 -0700
Message-ID: <169059165317.3736.10093661858792590128.stgit@anambiarhost.jf.intel.com>
In-Reply-To: <169059098829.3736.381753570945338022.stgit@anambiarhost.jf.intel.com>
References: <169059098829.3736.381753570945338022.stgit@anambiarhost.jf.intel.com>
User-Agent: StGit/unknown-version
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Add support in netlink spec(netdev.yaml) for PID of the
NAPI thread. Add code generated from the spec.

Signed-off-by: Amritha Nambiar <amritha.nambiar@intel.com>
---
 Documentation/netlink/specs/netdev.yaml |    4 ++++
 include/uapi/linux/netdev.h             |    1 +
 tools/include/uapi/linux/netdev.h       |    1 +
 tools/net/ynl/generated/netdev-user.c   |    6 ++++++
 tools/net/ynl/generated/netdev-user.h   |    2 ++
 5 files changed, 14 insertions(+)

diff --git a/Documentation/netlink/specs/netdev.yaml b/Documentation/netlink/specs/netdev.yaml
index c7f72038184d..8cbdf1f72527 100644
--- a/Documentation/netlink/specs/netdev.yaml
+++ b/Documentation/netlink/specs/netdev.yaml
@@ -89,6 +89,10 @@ attribute-sets:
         name: irq
         doc: The associated interrupt vector number for the napi
         type: u32
+      -
+        name: pid
+        doc: PID of the napi thread
+        type: s32
   -
     name: napi
     attributes:
diff --git a/include/uapi/linux/netdev.h b/include/uapi/linux/netdev.h
index 17782585be72..d01db79615e4 100644
--- a/include/uapi/linux/netdev.h
+++ b/include/uapi/linux/netdev.h
@@ -53,6 +53,7 @@ enum {
 	NETDEV_A_NAPI_INFO_ENTRY_RX_QUEUES,
 	NETDEV_A_NAPI_INFO_ENTRY_TX_QUEUES,
 	NETDEV_A_NAPI_INFO_ENTRY_IRQ,
+	NETDEV_A_NAPI_INFO_ENTRY_PID,
 
 	__NETDEV_A_NAPI_INFO_ENTRY_MAX,
 	NETDEV_A_NAPI_INFO_ENTRY_MAX = (__NETDEV_A_NAPI_INFO_ENTRY_MAX - 1)
diff --git a/tools/include/uapi/linux/netdev.h b/tools/include/uapi/linux/netdev.h
index 17782585be72..d01db79615e4 100644
--- a/tools/include/uapi/linux/netdev.h
+++ b/tools/include/uapi/linux/netdev.h
@@ -53,6 +53,7 @@ enum {
 	NETDEV_A_NAPI_INFO_ENTRY_RX_QUEUES,
 	NETDEV_A_NAPI_INFO_ENTRY_TX_QUEUES,
 	NETDEV_A_NAPI_INFO_ENTRY_IRQ,
+	NETDEV_A_NAPI_INFO_ENTRY_PID,
 
 	__NETDEV_A_NAPI_INFO_ENTRY_MAX,
 	NETDEV_A_NAPI_INFO_ENTRY_MAX = (__NETDEV_A_NAPI_INFO_ENTRY_MAX - 1)
diff --git a/tools/net/ynl/generated/netdev-user.c b/tools/net/ynl/generated/netdev-user.c
index 74c24be5641c..51f69a4ea59b 100644
--- a/tools/net/ynl/generated/netdev-user.c
+++ b/tools/net/ynl/generated/netdev-user.c
@@ -52,6 +52,7 @@ struct ynl_policy_attr netdev_napi_info_entry_policy[NETDEV_A_NAPI_INFO_ENTRY_MA
 	[NETDEV_A_NAPI_INFO_ENTRY_RX_QUEUES] = { .name = "rx-queues", .type = YNL_PT_U32, },
 	[NETDEV_A_NAPI_INFO_ENTRY_TX_QUEUES] = { .name = "tx-queues", .type = YNL_PT_U32, },
 	[NETDEV_A_NAPI_INFO_ENTRY_IRQ] = { .name = "irq", .type = YNL_PT_U32, },
+	[NETDEV_A_NAPI_INFO_ENTRY_PID] = { .name = "pid", .type = YNL_PT_U32, },
 };
 
 struct ynl_policy_nest netdev_napi_info_entry_nest = {
@@ -119,6 +120,11 @@ int netdev_napi_info_entry_parse(struct ynl_parse_arg *yarg,
 				return MNL_CB_ERROR;
 			dst->_present.irq = 1;
 			dst->irq = mnl_attr_get_u32(attr);
+		} else if (type == NETDEV_A_NAPI_INFO_ENTRY_PID) {
+			if (ynl_attr_validate(yarg, attr))
+				return MNL_CB_ERROR;
+			dst->_present.pid = 1;
+			dst->pid = mnl_attr_get_u32(attr);
 		}
 	}
 
diff --git a/tools/net/ynl/generated/netdev-user.h b/tools/net/ynl/generated/netdev-user.h
index a0833eb9a52f..942f377876b0 100644
--- a/tools/net/ynl/generated/netdev-user.h
+++ b/tools/net/ynl/generated/netdev-user.h
@@ -24,6 +24,7 @@ struct netdev_napi_info_entry {
 	struct {
 		__u32 napi_id:1;
 		__u32 irq:1;
+		__u32 pid:1;
 	} _present;
 
 	__u32 napi_id;
@@ -32,6 +33,7 @@ struct netdev_napi_info_entry {
 	unsigned int n_tx_queues;
 	__u32 *tx_queues;
 	__u32 irq;
+	__s32 pid;
 };
 
 /* ============== NETDEV_CMD_DEV_GET ============== */


