Return-Path: <netdev+bounces-296607-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 1zsbNMDYJmr0lgIAu9opvQ
	(envelope-from <netdev+bounces-296607-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 08 Jun 2026 16:59:12 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3102A657BAB
	for <lists+netdev@lfdr.de>; Mon, 08 Jun 2026 16:59:12 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=RfEhqGIZ;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296607-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-296607-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C81863107842
	for <lists+netdev@lfdr.de>; Mon,  8 Jun 2026 14:44:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 233183DF00B;
	Mon,  8 Jun 2026 14:41:40 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3A3A3DC850;
	Mon,  8 Jun 2026 14:41:37 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780929700; cv=none; b=J6SUfAwHJyYzO+r2NUg3snzMaf2AqIlLHjhc2ctWs7mbZUqkNCcCvs3eJo4Q/pUJM2ZjWZuGAev61i0uiOJzsglS4XeyBBnq01bf3VO0pz6mCsmthXhJ8qQRL/lBtajmPq1ZLQpj+c/NPVh5PCNE21gPUzpAQ5vxt7oXZxgYGSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780929700; c=relaxed/simple;
	bh=8tzhDeO5cGCbcljUPbAaJ0s9r+9VWW9CeiAAL+1d3CI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NYQoNB/zfu1iVCYcp9QNFzfNuwvRRYSdYCpAogEm2siFxozrEYaDouXB0RnVYJrBMT5Jsa5FVdkbHP+bwUxHfNCkGRZHJ/HijOEKcSPrrot+MQvLrSvNCHy1UJD9w5ydPUJe3eBohvXSU8cKIxdeeM76YbEyHxgpA7gGgR+vawM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RfEhqGIZ; arc=none smtp.client-ip=198.175.65.19
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780929698; x=1812465698;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=8tzhDeO5cGCbcljUPbAaJ0s9r+9VWW9CeiAAL+1d3CI=;
  b=RfEhqGIZsMXd6TaPwhRBVxFwky/Aglw7IcoqFtsrWSUrHNrb3aEfYlac
   zZGhlHCQikyfvfWxBuNMQPmAt1gE7CvPAXdQdTyFK6eQnpCClHqC+FUIH
   MM1Ind24d21JKWkiRHUh6uKaoGFlnjZCLXOEtMUbmCuazYAoBSCUt4YqM
   /BS5yNDcpAIu5YaLYH78XEVjqqmkx3SRZ/u/2YHweXuZ5EJgSkmztYOti
   fQkSy42a9QMJT2GNwIgvwb7xH8iCpu05X8pDyVChH5Q6of7Mlkpz8q+lU
   i1Eyo0s4TGgm3cKJVEEG0tki2mFVNQPlISkY6AtwUbOvohKdY96hZ6jHm
   w==;
X-CSE-ConnectionGUID: 3oGUrC30RyGLBeWH9J2FSg==
X-CSE-MsgGUID: xX9z3fuqSa+nbtzCaQrcgg==
X-IronPort-AV: E=McAfee;i="6800,10657,11811"; a="81641952"
X-IronPort-AV: E=Sophos;i="6.24,194,1774335600"; 
   d="scan'208";a="81641952"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2026 07:41:37 -0700
X-CSE-ConnectionGUID: 2FGg0PhCQAOoo4fPZDvcDw==
X-CSE-MsgGUID: 0DnUjv6rT6i6awrJDAbjWA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,194,1774335600"; 
   d="scan'208";a="249489708"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by orviesa003.jf.intel.com with ESMTP; 08 Jun 2026 07:41:32 -0700
Received: from mglak.igk.intel.com (mglak.igk.intel.com [10.237.112.146])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id 9679128791;
	Mon,  8 Jun 2026 15:41:29 +0100 (IST)
From: Larysa Zaremba <larysa.zaremba@intel.com>
To: intel-wired-lan@lists.osuosl.org,
	Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: aleksander.lobakin@intel.com,
	sridhar.samudrala@intel.com,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	Larysa Zaremba <larysa.zaremba@intel.com>,
	"Fijalkowski, Maciej" <maciej.fijalkowski@intel.com>,
	Emil Tantilov <emil.s.tantilov@intel.com>,
	Madhu Chittim <madhu.chittim@intel.com>,
	Josh Hay <joshua.a.hay@intel.com>,
	"Keller, Jacob E" <jacob.e.keller@intel.com>,
	jayaprakash.shanmugam@intel.com,
	Jiri Pirko <jiri@resnulli.us>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Richard Cochran <richardcochran@gmail.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	netdev@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Samuel Salin <Samuel.salin@intel.com>
Subject: [PATCH iwl-next v8 01/15] virtchnl: move virtchnl and virtchnl2 headers to 'include/linux/net/intel'
Date: Mon,  8 Jun 2026 16:41:06 +0200
Message-ID: <20260608144127.2751230-2-larysa.zaremba@intel.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20260608144127.2751230-1-larysa.zaremba@intel.com>
References: <20260608144127.2751230-1-larysa.zaremba@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-296607-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[26];
	FREEMAIL_CC(0.00)[intel.com,linux.intel.com,resnulli.us,davemloft.net,google.com,kernel.org,redhat.com,lwn.net,gmail.com,lunn.ch,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:intel-wired-lan@lists.osuosl.org,m:anthony.l.nguyen@intel.com,m:aleksander.lobakin@intel.com,m:sridhar.samudrala@intel.com,m:michal.swiatkowski@linux.intel.com,m:larysa.zaremba@intel.com,m:maciej.fijalkowski@intel.com,m:emil.s.tantilov@intel.com,m:madhu.chittim@intel.com,m:joshua.a.hay@intel.com,m:jacob.e.keller@intel.com,m:jayaprakash.shanmugam@intel.com,m:jiri@resnulli.us,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:corbet@lwn.net,m:richardcochran@gmail.com,m:przemyslaw.kitszel@intel.com,m:andrew+netdev@lunn.ch,m:netdev@vger.kernel.org,m:linux-doc@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:Samuel.salin@intel.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[larysa.zaremba@intel.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[larysa.zaremba@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,intel.com:email,intel.com:mid,intel.com:from_mime,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3102A657BAB

From: Victor Raj <victor.raj@intel.com>

virtchnl2 headers will be used by both idpf and ixd drivers, so they have
to be moved to an include directory. On top of that, it would be useful to
place all iavf headers together with other intel networking headers.

Move abovementioned intel header files into 'include/linux/net/intel'.

Suggested-by: Alexander Lobakin <aleksander.lobakin@intel.com>
Reviewed-by: Sridhar Samudrala <sridhar.samudrala@intel.com>
Signed-off-by: Victor Raj <victor.raj@intel.com>
Tested-by: Samuel Salin <Samuel.salin@intel.com>
Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>
---
 MAINTAINERS                                                   | 1 -
 drivers/net/ethernet/intel/i40e/i40e.h                        | 2 +-
 drivers/net/ethernet/intel/i40e/i40e_common.c                 | 2 +-
 drivers/net/ethernet/intel/i40e/i40e_prototype.h              | 2 +-
 drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.h            | 2 +-
 drivers/net/ethernet/intel/iavf/iavf.h                        | 2 +-
 drivers/net/ethernet/intel/iavf/iavf_common.c                 | 2 +-
 drivers/net/ethernet/intel/iavf/iavf_prototype.h              | 3 ++-
 drivers/net/ethernet/intel/iavf/iavf_types.h                  | 4 +---
 drivers/net/ethernet/intel/ice/ice.h                          | 2 +-
 drivers/net/ethernet/intel/ice/ice_common.h                   | 2 +-
 drivers/net/ethernet/intel/ice/ice_vf_lib.h                   | 2 +-
 drivers/net/ethernet/intel/ice/virt/virtchnl.h                | 2 +-
 drivers/net/ethernet/intel/idpf/idpf.h                        | 2 +-
 drivers/net/ethernet/intel/idpf/idpf_txrx.h                   | 2 +-
 drivers/net/ethernet/intel/idpf/idpf_virtchnl.h               | 2 +-
 include/linux/{avf => net/intel}/virtchnl.h                   | 0
 .../intel/idpf => include/linux/net/intel}/virtchnl2.h        | 0
 .../idpf => include/linux/net/intel}/virtchnl2_lan_desc.h     | 0
 19 files changed, 16 insertions(+), 18 deletions(-)
 rename include/linux/{avf => net/intel}/virtchnl.h (100%)
 rename {drivers/net/ethernet/intel/idpf => include/linux/net/intel}/virtchnl2.h (100%)
 rename {drivers/net/ethernet/intel/idpf => include/linux/net/intel}/virtchnl2_lan_desc.h (100%)

diff --git a/MAINTAINERS b/MAINTAINERS
index eb8cdcc76324..952f09b40711 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -12917,7 +12917,6 @@ T:	git git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue.git
 F:	Documentation/networking/device_drivers/ethernet/intel/
 F:	drivers/net/ethernet/intel/
 F:	drivers/net/ethernet/intel/*/
-F:	include/linux/avf/virtchnl.h
 F:	include/linux/net/intel/*/
 
 INTEL ETHERNET PROTOCOL DRIVER FOR RDMA
diff --git a/drivers/net/ethernet/intel/i40e/i40e.h b/drivers/net/ethernet/intel/i40e/i40e.h
index 83e780919ac9..1b6a8fbaa648 100644
--- a/drivers/net/ethernet/intel/i40e/i40e.h
+++ b/drivers/net/ethernet/intel/i40e/i40e.h
@@ -8,8 +8,8 @@
 #include <linux/pci.h>
 #include <linux/ptp_clock_kernel.h>
 #include <linux/types.h>
-#include <linux/avf/virtchnl.h>
 #include <linux/net/intel/i40e_client.h>
+#include <linux/net/intel/virtchnl.h>
 #include <net/devlink.h>
 #include <net/pkt_cls.h>
 #include <net/udp_tunnel.h>
diff --git a/drivers/net/ethernet/intel/i40e/i40e_common.c b/drivers/net/ethernet/intel/i40e/i40e_common.c
index 59f5c1e810eb..8dadfef2c09f 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_common.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_common.c
@@ -1,10 +1,10 @@
 // SPDX-License-Identifier: GPL-2.0
 /* Copyright(c) 2013 - 2021 Intel Corporation. */
 
-#include <linux/avf/virtchnl.h>
 #include <linux/bitfield.h>
 #include <linux/delay.h>
 #include <linux/etherdevice.h>
+#include <linux/net/intel/virtchnl.h>
 #include <linux/pci.h>
 #include "i40e_adminq_cmd.h"
 #include "i40e_devids.h"
diff --git a/drivers/net/ethernet/intel/i40e/i40e_prototype.h b/drivers/net/ethernet/intel/i40e/i40e_prototype.h
index 26bb7bffe361..e3d57550090e 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_prototype.h
+++ b/drivers/net/ethernet/intel/i40e/i40e_prototype.h
@@ -5,7 +5,7 @@
 #define _I40E_PROTOTYPE_H_
 
 #include <linux/ethtool.h>
-#include <linux/avf/virtchnl.h>
+#include <linux/net/intel/virtchnl.h>
 #include "i40e_debug.h"
 #include "i40e_type.h"
 
diff --git a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.h b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.h
index f558b45725c8..4e119c0502f3 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.h
+++ b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.h
@@ -4,7 +4,7 @@
 #ifndef _I40E_VIRTCHNL_PF_H_
 #define _I40E_VIRTCHNL_PF_H_
 
-#include <linux/avf/virtchnl.h>
+#include <linux/net/intel/virtchnl.h>
 #include <linux/netdevice.h>
 #include "i40e_type.h"
 
diff --git a/drivers/net/ethernet/intel/iavf/iavf.h b/drivers/net/ethernet/intel/iavf/iavf.h
index 050f8241ef5e..dc31202b2a94 100644
--- a/drivers/net/ethernet/intel/iavf/iavf.h
+++ b/drivers/net/ethernet/intel/iavf/iavf.h
@@ -27,6 +27,7 @@
 #include <linux/etherdevice.h>
 #include <linux/socket.h>
 #include <linux/jiffies.h>
+#include <linux/net/intel/virtchnl.h>
 #include <net/ip6_checksum.h>
 #include <net/pkt_cls.h>
 #include <net/pkt_sched.h>
@@ -37,7 +38,6 @@
 #include <net/net_shaper.h>
 
 #include "iavf_type.h"
-#include <linux/avf/virtchnl.h>
 #include "iavf_txrx.h"
 #include "iavf_fdir.h"
 #include "iavf_adv_rss.h"
diff --git a/drivers/net/ethernet/intel/iavf/iavf_common.c b/drivers/net/ethernet/intel/iavf/iavf_common.c
index 614a886bca99..277193a97d91 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_common.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_common.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 /* Copyright(c) 2013 - 2018 Intel Corporation. */
 
-#include <linux/avf/virtchnl.h>
+#include <linux/net/intel/virtchnl.h>
 #include <linux/bitfield.h>
 #include "iavf_type.h"
 #include "iavf_adminq.h"
diff --git a/drivers/net/ethernet/intel/iavf/iavf_prototype.h b/drivers/net/ethernet/intel/iavf/iavf_prototype.h
index 7f9f9dbf959a..1b1f6ede3920 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_prototype.h
+++ b/drivers/net/ethernet/intel/iavf/iavf_prototype.h
@@ -4,9 +4,10 @@
 #ifndef _IAVF_PROTOTYPE_H_
 #define _IAVF_PROTOTYPE_H_
 
+#include <linux/net/intel/virtchnl.h>
+
 #include "iavf_type.h"
 #include "iavf_alloc.h"
-#include <linux/avf/virtchnl.h>
 
 /* Prototypes for shared code functions that are not in
  * the standard function pointer structures.  These are
diff --git a/drivers/net/ethernet/intel/iavf/iavf_types.h b/drivers/net/ethernet/intel/iavf/iavf_types.h
index a095855122bf..35d6d8fcca04 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_types.h
+++ b/drivers/net/ethernet/intel/iavf/iavf_types.h
@@ -4,9 +4,7 @@
 #ifndef _IAVF_TYPES_H_
 #define _IAVF_TYPES_H_
 
-#include "iavf_types.h"
-
-#include <linux/avf/virtchnl.h>
+#include <linux/net/intel/virtchnl.h>
 #include <linux/ptp_clock_kernel.h>
 
 /* structure used to queue PTP commands for processing */
diff --git a/drivers/net/ethernet/intel/ice/ice.h b/drivers/net/ethernet/intel/ice/ice.h
index 725b130dd3a2..0027b93847c7 100644
--- a/drivers/net/ethernet/intel/ice/ice.h
+++ b/drivers/net/ethernet/intel/ice/ice.h
@@ -36,7 +36,7 @@
 #include <linux/bpf.h>
 #include <linux/btf.h>
 #include <linux/auxiliary_bus.h>
-#include <linux/avf/virtchnl.h>
+#include <linux/net/intel/virtchnl.h>
 #include <linux/cpu_rmap.h>
 #include <linux/dim.h>
 #include <linux/gnss.h>
diff --git a/drivers/net/ethernet/intel/ice/ice_common.h b/drivers/net/ethernet/intel/ice/ice_common.h
index e700ac0dc347..d9e7861e8ce0 100644
--- a/drivers/net/ethernet/intel/ice/ice_common.h
+++ b/drivers/net/ethernet/intel/ice/ice_common.h
@@ -5,13 +5,13 @@
 #define _ICE_COMMON_H_
 
 #include <linux/bitfield.h>
+#include <linux/net/intel/virtchnl.h>
 
 #include "ice.h"
 #include "ice_type.h"
 #include "ice_nvm.h"
 #include "ice_flex_pipe.h"
 #include "ice_parser.h"
-#include <linux/avf/virtchnl.h>
 #include "ice_switch.h"
 #include "ice_fdir.h"
 
diff --git a/drivers/net/ethernet/intel/ice/ice_vf_lib.h b/drivers/net/ethernet/intel/ice/ice_vf_lib.h
index 7a9c75d1d07c..fa436b3b1eac 100644
--- a/drivers/net/ethernet/intel/ice/ice_vf_lib.h
+++ b/drivers/net/ethernet/intel/ice/ice_vf_lib.h
@@ -8,9 +8,9 @@
 #include <linux/hashtable.h>
 #include <linux/bitmap.h>
 #include <linux/mutex.h>
+#include <linux/net/intel/virtchnl.h>
 #include <linux/pci.h>
 #include <net/devlink.h>
-#include <linux/avf/virtchnl.h>
 #include "ice_type.h"
 #include "ice_flow.h"
 #include "virt/fdir.h"
diff --git a/drivers/net/ethernet/intel/ice/virt/virtchnl.h b/drivers/net/ethernet/intel/ice/virt/virtchnl.h
index 71bb456e2d71..d11789b3ae1f 100644
--- a/drivers/net/ethernet/intel/ice/virt/virtchnl.h
+++ b/drivers/net/ethernet/intel/ice/virt/virtchnl.h
@@ -7,7 +7,7 @@
 #include <linux/types.h>
 #include <linux/bitops.h>
 #include <linux/if_ether.h>
-#include <linux/avf/virtchnl.h>
+#include <linux/net/intel/virtchnl.h>
 #include "ice_vf_lib.h"
 
 /* Restrict number of MAC Addr and VLAN that non-trusted VF can programmed */
diff --git a/drivers/net/ethernet/intel/idpf/idpf.h b/drivers/net/ethernet/intel/idpf/idpf.h
index ec1b75f039bb..984944bab28b 100644
--- a/drivers/net/ethernet/intel/idpf/idpf.h
+++ b/drivers/net/ethernet/intel/idpf/idpf.h
@@ -23,8 +23,8 @@ struct idpf_rss_data;
 
 #include <linux/net/intel/iidc_rdma.h>
 #include <linux/net/intel/iidc_rdma_idpf.h>
+#include <linux/net/intel/virtchnl2.h>
 
-#include "virtchnl2.h"
 #include "idpf_txrx.h"
 #include "idpf_controlq.h"
 
diff --git a/drivers/net/ethernet/intel/idpf/idpf_txrx.h b/drivers/net/ethernet/intel/idpf/idpf_txrx.h
index 4be5b3b6d3ed..08b048664029 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_txrx.h
+++ b/drivers/net/ethernet/intel/idpf/idpf_txrx.h
@@ -5,6 +5,7 @@
 #define _IDPF_TXRX_H_
 
 #include <linux/dim.h>
+#include <linux/net/intel/virtchnl2_lan_desc.h>
 
 #include <net/libeth/cache.h>
 #include <net/libeth/types.h>
@@ -13,7 +14,6 @@
 #include <net/xdp.h>
 
 #include "idpf_lan_txrx.h"
-#include "virtchnl2_lan_desc.h"
 
 #define IDPF_LARGE_MAX_Q			256
 #define IDPF_MAX_Q				16
diff --git a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.h b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.h
index 6876e3ed9d1b..972dd88cf3d2 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.h
+++ b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.h
@@ -4,7 +4,7 @@
 #ifndef _IDPF_VIRTCHNL_H_
 #define _IDPF_VIRTCHNL_H_
 
-#include "virtchnl2.h"
+#include <linux/net/intel/virtchnl2.h>
 
 #define IDPF_VC_XN_DEFAULT_TIMEOUT_MSEC	(60 * 1000)
 #define IDPF_VC_XN_IDX_M		GENMASK(7, 0)
diff --git a/include/linux/avf/virtchnl.h b/include/linux/net/intel/virtchnl.h
similarity index 100%
rename from include/linux/avf/virtchnl.h
rename to include/linux/net/intel/virtchnl.h
diff --git a/drivers/net/ethernet/intel/idpf/virtchnl2.h b/include/linux/net/intel/virtchnl2.h
similarity index 100%
rename from drivers/net/ethernet/intel/idpf/virtchnl2.h
rename to include/linux/net/intel/virtchnl2.h
diff --git a/drivers/net/ethernet/intel/idpf/virtchnl2_lan_desc.h b/include/linux/net/intel/virtchnl2_lan_desc.h
similarity index 100%
rename from drivers/net/ethernet/intel/idpf/virtchnl2_lan_desc.h
rename to include/linux/net/intel/virtchnl2_lan_desc.h
-- 
2.47.0


