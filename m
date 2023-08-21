Return-Path: <netdev+bounces-29478-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1949783628
	for <lists+netdev@lfdr.de>; Tue, 22 Aug 2023 01:12:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C0AE280F75
	for <lists+netdev@lfdr.de>; Mon, 21 Aug 2023 23:12:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8AB01C29C;
	Mon, 21 Aug 2023 23:10:46 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D408C1BF12
	for <netdev@vger.kernel.org>; Mon, 21 Aug 2023 23:10:46 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD20B132
	for <netdev@vger.kernel.org>; Mon, 21 Aug 2023 16:10:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692659445; x=1724195445;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=DYV6vgKNGL/3pniyUBVOvaUjNI3FC7bMVCagc7ynVS0=;
  b=Yfm4iCYP8TsLWbHsD7mM4cH5+7uDeYYaqXVwccrF36Z59Xcdq8DcgUEC
   S/okJ55XoVOFZk+wFXD0DRGXnfuUWqzp411OayXw+7XRAO82TnrJVm/rM
   iSrf8B8sCtDmv395hUl+K24kIKER/V5Aujb5L7N1O8ki1A+6rBk5mJfQb
   oTSyuliazoec14kPx0AJGV2aWUhVw1bE7gKSsdsaZwS1uR6eHE1N8lGu5
   Hzu9StB1GKxQzzTL19Pk2fKP2JnPhfcnolDgi9nR/uGkdaAkfJ75bqNxI
   e/fgL4dwjvHp/f/VRmBJzSEMz936yW8wujiXjy0B7Kw2YYVzpIcYfveKb
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10809"; a="373698744"
X-IronPort-AV: E=Sophos;i="6.01,191,1684825200"; 
   d="scan'208";a="373698744"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2023 16:10:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10809"; a="982647709"
X-IronPort-AV: E=Sophos;i="6.01,191,1684825200"; 
   d="scan'208";a="982647709"
Received: from anambiarhost.jf.intel.com ([10.166.29.163])
  by fmsmga006.fm.intel.com with ESMTP; 21 Aug 2023 16:10:45 -0700
Subject: [net-next PATCH v2 8/9] netdev-genl: spec: Add PID in netdev
 netlink YAML spec
From: Amritha Nambiar <amritha.nambiar@intel.com>
To: netdev@vger.kernel.org, kuba@kernel.org, davem@davemloft.net
Cc: sridhar.samudrala@intel.com, amritha.nambiar@intel.com
Date: Mon, 21 Aug 2023 16:25:52 -0700
Message-ID: <169266035228.10199.6686102970974174171.stgit@anambiarhost.jf.intel.com>
In-Reply-To: <169266003844.10199.10450480941022607696.stgit@anambiarhost.jf.intel.com>
References: <169266003844.10199.10450480941022607696.stgit@anambiarhost.jf.intel.com>
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
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Add support in netlink spec(netdev.yaml) for PID of the
NAPI thread. Add code generated from the spec.

Signed-off-by: Amritha Nambiar <amritha.nambiar@intel.com>
---
 Documentation/netlink/specs/netdev.yaml |    5 +++++
 include/uapi/linux/netdev.h             |    1 +
 tools/include/uapi/linux/netdev.h       |    1 +
 tools/net/ynl/generated/netdev-user.c   |    6 ++++++
 tools/net/ynl/generated/netdev-user.h   |    2 ++
 5 files changed, 15 insertions(+)

diff --git a/Documentation/netlink/specs/netdev.yaml b/Documentation/netlink/specs/netdev.yaml
index aef40397b026..3472f086d523 100644
--- a/Documentation/netlink/specs/netdev.yaml
+++ b/Documentation/netlink/specs/netdev.yaml
@@ -95,6 +95,10 @@ attribute-sets:
         name: irq
         doc: The associated interrupt vector number for the napi
         type: u32
+      -
+        name: pid
+        doc: PID of the napi thread
+        type: s32
 
 operations:
   list:
@@ -143,6 +147,7 @@ operations:
             - rx-queues
             - tx-queues
             - irq
+            - pid
       dump:
         request:
           attributes:
diff --git a/include/uapi/linux/netdev.h b/include/uapi/linux/netdev.h
index d31241e155b9..b87ec27b2741 100644
--- a/include/uapi/linux/netdev.h
+++ b/include/uapi/linux/netdev.h
@@ -54,6 +54,7 @@ enum {
 	NETDEV_A_NAPI_RX_QUEUES,
 	NETDEV_A_NAPI_TX_QUEUES,
 	NETDEV_A_NAPI_IRQ,
+	NETDEV_A_NAPI_PID,
 
 	__NETDEV_A_NAPI_MAX,
 	NETDEV_A_NAPI_MAX = (__NETDEV_A_NAPI_MAX - 1)
diff --git a/tools/include/uapi/linux/netdev.h b/tools/include/uapi/linux/netdev.h
index d31241e155b9..b87ec27b2741 100644
--- a/tools/include/uapi/linux/netdev.h
+++ b/tools/include/uapi/linux/netdev.h
@@ -54,6 +54,7 @@ enum {
 	NETDEV_A_NAPI_RX_QUEUES,
 	NETDEV_A_NAPI_TX_QUEUES,
 	NETDEV_A_NAPI_IRQ,
+	NETDEV_A_NAPI_PID,
 
 	__NETDEV_A_NAPI_MAX,
 	NETDEV_A_NAPI_MAX = (__NETDEV_A_NAPI_MAX - 1)
diff --git a/tools/net/ynl/generated/netdev-user.c b/tools/net/ynl/generated/netdev-user.c
index a59377c70503..53a52055453d 100644
--- a/tools/net/ynl/generated/netdev-user.c
+++ b/tools/net/ynl/generated/netdev-user.c
@@ -65,6 +65,7 @@ struct ynl_policy_attr netdev_napi_policy[NETDEV_A_NAPI_MAX + 1] = {
 	[NETDEV_A_NAPI_RX_QUEUES] = { .name = "rx-queues", .type = YNL_PT_U32, },
 	[NETDEV_A_NAPI_TX_QUEUES] = { .name = "tx-queues", .type = YNL_PT_U32, },
 	[NETDEV_A_NAPI_IRQ] = { .name = "irq", .type = YNL_PT_U32, },
+	[NETDEV_A_NAPI_PID] = { .name = "pid", .type = YNL_PT_U32, },
 };
 
 struct ynl_policy_nest netdev_napi_nest = {
@@ -244,6 +245,11 @@ int netdev_napi_get_rsp_parse(const struct nlmsghdr *nlh, void *data)
 				return MNL_CB_ERROR;
 			dst->_present.irq = 1;
 			dst->irq = mnl_attr_get_u32(attr);
+		} else if (type == NETDEV_A_NAPI_PID) {
+			if (ynl_attr_validate(yarg, attr))
+				return MNL_CB_ERROR;
+			dst->_present.pid = 1;
+			dst->pid = mnl_attr_get_u32(attr);
 		}
 	}
 
diff --git a/tools/net/ynl/generated/netdev-user.h b/tools/net/ynl/generated/netdev-user.h
index 9edc5828ca89..b3bbcdd5b669 100644
--- a/tools/net/ynl/generated/netdev-user.h
+++ b/tools/net/ynl/generated/netdev-user.h
@@ -112,6 +112,7 @@ struct netdev_napi_get_rsp {
 		__u32 napi_id:1;
 		__u32 ifindex:1;
 		__u32 irq:1;
+		__u32 pid:1;
 	} _present;
 
 	__u32 napi_id;
@@ -121,6 +122,7 @@ struct netdev_napi_get_rsp {
 	unsigned int n_tx_queues;
 	__u32 *tx_queues;
 	__u32 irq;
+	__s32 pid;
 };
 
 void netdev_napi_get_rsp_free(struct netdev_napi_get_rsp *rsp);


