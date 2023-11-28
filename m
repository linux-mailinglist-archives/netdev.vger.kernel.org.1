Return-Path: <netdev+bounces-51550-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D346A7FB075
	for <lists+netdev@lfdr.de>; Tue, 28 Nov 2023 04:33:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2FC3BB210BE
	for <lists+netdev@lfdr.de>; Tue, 28 Nov 2023 03:33:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 809F0D27C;
	Tue, 28 Nov 2023 03:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cghSHmtf"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DDBB187
	for <netdev@vger.kernel.org>; Mon, 27 Nov 2023 19:33:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701142429; x=1732678429;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=LKHG3LX0yimEcliqN2x8OJPxjSlyf2AQpmRTus7+o24=;
  b=cghSHmtfqXr3X92wTqrVSEKlTrH1PDWBfWumMNCS0vfVMgndus17jKXO
   XiPUuNprsEvYyqMg4XogxeY/QiGE/ZIMzSV9T8hFc+zbENWFYPsY8tBYz
   sQyGxa8GSsxH5Zg1DCEJxuVjfW0JoYbcch2eJWgjwmJtBGmiGiYSbJjB8
   h60nIPc+DfrE7NysKjgDMDBskJXDyV3TUZE4cfhgfAdVeR4YImuzrvJpr
   Sg18Fu4kNjLyXK2T8pREJGa7aNZB3iTfw06vFMQw/yuMXiMy4syopynhF
   Vft9yunpM7YeNw9RPI3zSCbpnGEsmtZUUWATojckUgN8wa9RbpFY8lKUx
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10907"; a="373013064"
X-IronPort-AV: E=Sophos;i="6.04,232,1695711600"; 
   d="scan'208";a="373013064"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Nov 2023 19:33:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10907"; a="834524775"
X-IronPort-AV: E=Sophos;i="6.04,232,1695711600"; 
   d="scan'208";a="834524775"
Received: from anambiarhost.jf.intel.com ([10.166.29.163])
  by fmsmga008.fm.intel.com with ESMTP; 27 Nov 2023 19:33:48 -0800
Subject: [net-next PATCH v9 09/11] netdev-genl: spec: Add PID in netdev
 netlink YAML spec
From: Amritha Nambiar <amritha.nambiar@intel.com>
To: netdev@vger.kernel.org, kuba@kernel.org, pabeni@redhat.com
Cc: sridhar.samudrala@intel.com, amritha.nambiar@intel.com
Date: Mon, 27 Nov 2023 19:50:14 -0800
Message-ID: <170114341475.10303.648615197930542614.stgit@anambiarhost.jf.intel.com>
In-Reply-To: <170114286635.10303.8773144948795839629.stgit@anambiarhost.jf.intel.com>
References: <170114286635.10303.8773144948795839629.stgit@anambiarhost.jf.intel.com>
User-Agent: StGit/unknown-version
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

Add support in netlink spec(netdev.yaml) for PID of the
NAPI thread. Add code generated from the spec.

Signed-off-by: Amritha Nambiar <amritha.nambiar@intel.com>
Reviewed-by: Sridhar Samudrala <sridhar.samudrala@intel.com>
---
 Documentation/netlink/specs/netdev.yaml |    7 +++++++
 include/uapi/linux/netdev.h             |    1 +
 tools/include/uapi/linux/netdev.h       |    1 +
 tools/net/ynl/generated/netdev-user.c   |    6 ++++++
 tools/net/ynl/generated/netdev-user.h   |    2 ++
 5 files changed, 17 insertions(+)

diff --git a/Documentation/netlink/specs/netdev.yaml b/Documentation/netlink/specs/netdev.yaml
index 4161f302352d..382022a0d039 100644
--- a/Documentation/netlink/specs/netdev.yaml
+++ b/Documentation/netlink/specs/netdev.yaml
@@ -108,6 +108,12 @@ attribute-sets:
         name: irq
         doc: The associated interrupt vector number for the napi
         type: u32
+      -
+        name: pid
+        doc: PID of the napi thread, if NAPI is configured to operate in
+             threaded mode. If NAPI is not in threaded mode (i.e. uses normal
+             softirq context), the attribute will be absent.
+        type: u32
   -
     name: queue
     attributes:
@@ -202,6 +208,7 @@ operations:
             - id
             - ifindex
             - irq
+            - pid
       dump:
         request:
           attributes:
diff --git a/include/uapi/linux/netdev.h b/include/uapi/linux/netdev.h
index 10ddb7cfde07..c4be7fadfdf9 100644
--- a/include/uapi/linux/netdev.h
+++ b/include/uapi/linux/netdev.h
@@ -73,6 +73,7 @@ enum {
 	NETDEV_A_NAPI_IFINDEX = 1,
 	NETDEV_A_NAPI_ID,
 	NETDEV_A_NAPI_IRQ,
+	NETDEV_A_NAPI_PID,
 
 	__NETDEV_A_NAPI_MAX,
 	NETDEV_A_NAPI_MAX = (__NETDEV_A_NAPI_MAX - 1)
diff --git a/tools/include/uapi/linux/netdev.h b/tools/include/uapi/linux/netdev.h
index 10ddb7cfde07..c4be7fadfdf9 100644
--- a/tools/include/uapi/linux/netdev.h
+++ b/tools/include/uapi/linux/netdev.h
@@ -73,6 +73,7 @@ enum {
 	NETDEV_A_NAPI_IFINDEX = 1,
 	NETDEV_A_NAPI_ID,
 	NETDEV_A_NAPI_IRQ,
+	NETDEV_A_NAPI_PID,
 
 	__NETDEV_A_NAPI_MAX,
 	NETDEV_A_NAPI_MAX = (__NETDEV_A_NAPI_MAX - 1)
diff --git a/tools/net/ynl/generated/netdev-user.c b/tools/net/ynl/generated/netdev-user.c
index 2bd57420b548..5f3ca6ef9aa6 100644
--- a/tools/net/ynl/generated/netdev-user.c
+++ b/tools/net/ynl/generated/netdev-user.c
@@ -102,6 +102,7 @@ struct ynl_policy_attr netdev_napi_policy[NETDEV_A_NAPI_MAX + 1] = {
 	[NETDEV_A_NAPI_IFINDEX] = { .name = "ifindex", .type = YNL_PT_U32, },
 	[NETDEV_A_NAPI_ID] = { .name = "id", .type = YNL_PT_U32, },
 	[NETDEV_A_NAPI_IRQ] = { .name = "irq", .type = YNL_PT_U32, },
+	[NETDEV_A_NAPI_PID] = { .name = "pid", .type = YNL_PT_U32, },
 };
 
 struct ynl_policy_nest netdev_napi_nest = {
@@ -400,6 +401,11 @@ int netdev_napi_get_rsp_parse(const struct nlmsghdr *nlh, void *data)
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
index de7205b63ccf..8337735389bf 100644
--- a/tools/net/ynl/generated/netdev-user.h
+++ b/tools/net/ynl/generated/netdev-user.h
@@ -214,11 +214,13 @@ struct netdev_napi_get_rsp {
 		__u32 id:1;
 		__u32 ifindex:1;
 		__u32 irq:1;
+		__u32 pid:1;
 	} _present;
 
 	__u32 id;
 	__u32 ifindex;
 	__u32 irq;
+	__u32 pid;
 };
 
 void netdev_napi_get_rsp_free(struct netdev_napi_get_rsp *rsp);


