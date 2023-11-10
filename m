Return-Path: <netdev+bounces-47094-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98ECC7E7BEE
	for <lists+netdev@lfdr.de>; Fri, 10 Nov 2023 12:45:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CBD33B20FAA
	for <lists+netdev@lfdr.de>; Fri, 10 Nov 2023 11:45:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FF511946B;
	Fri, 10 Nov 2023 11:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1347171DA
	for <netdev@vger.kernel.org>; Fri, 10 Nov 2023 11:45:12 +0000 (UTC)
Received: from smtp.chopps.org (smtp.chopps.org [54.88.81.56])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id D1C57311A7
	for <netdev@vger.kernel.org>; Fri, 10 Nov 2023 03:45:10 -0800 (PST)
Received: from labnh.int.chopps.org (172-222-091-149.res.spectrum.com [172.222.91.149])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by smtp.chopps.org (Postfix) with ESMTPSA id AD0827D135;
	Fri, 10 Nov 2023 11:38:38 +0000 (UTC)
From: Christian Hopps <chopps@chopps.org>
To: devel@linux-ipsec.org
Cc: Steffen Klassert <steffen.klassert@secunet.com>,
	netdev@vger.kernel.org,
	Christian Hopps <chopps@labn.net>
Subject: [RFC ipsec-next 5/8] iptfs: netlink: add config (netlink) options
Date: Fri, 10 Nov 2023 06:37:16 -0500
Message-ID: <20231110113719.3055788-6-chopps@chopps.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231110113719.3055788-1-chopps@chopps.org>
References: <20231110113719.3055788-1-chopps@chopps.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Christian Hopps <chopps@labn.net>

Add netlink options for configuring IP-TFS SAs.

Signed-off-by: Christian Hopps <chopps@labn.net>
---
 include/uapi/linux/xfrm.h |  6 ++++++
 net/xfrm/xfrm_user.c      | 16 ++++++++++++++++
 2 files changed, 22 insertions(+)

diff --git a/include/uapi/linux/xfrm.h b/include/uapi/linux/xfrm.h
index 6a77328be114..fa6d264f2ad1 100644
--- a/include/uapi/linux/xfrm.h
+++ b/include/uapi/linux/xfrm.h
@@ -315,6 +315,12 @@ enum xfrm_attr_type_t {
 	XFRMA_SET_MARK_MASK,	/* __u32 */
 	XFRMA_IF_ID,		/* __u32 */
 	XFRMA_MTIMER_THRESH,	/* __u32 in seconds for input SA */
+	XFRMA_IPTFS_PKT_SIZE,	/* __u32 Size of outer packet, 0 for PMTU */
+	XFRMA_IPTFS_MAX_QSIZE,	/* __u32 max ingress queue size */
+	XFRMA_IPTFS_DONT_FRAG,	/* don't use fragmentation */
+	XFRMA_IPTFS_DROP_TIME,	/* __u32 usec to wait for next seq */
+	XFRMA_IPTFS_REORD_WIN,	/* __u16 reorder window size */
+	XFRMA_IPTFS_IN_DELAY,	/* __u32 initial packet wait delay (usec) */
 	__XFRMA_MAX
 
 #define XFRMA_OUTPUT_MARK XFRMA_SET_MARK	/* Compatibility */
diff --git a/net/xfrm/xfrm_user.c b/net/xfrm/xfrm_user.c
index ad01997c3aa9..ed95772bbd3f 100644
--- a/net/xfrm/xfrm_user.c
+++ b/net/xfrm/xfrm_user.c
@@ -272,6 +272,16 @@ static int verify_newsa_info(struct xfrm_usersa_info *p,
 			NL_SET_ERR_MSG(extack, "TFC padding can only be used in tunnel mode");
 			goto out;
 		}
+		if ((attrs[XFRMA_IPTFS_PKT_SIZE] ||
+		     attrs[XFRMA_IPTFS_MAX_QSIZE] ||
+		     attrs[XFRMA_IPTFS_DONT_FRAG] ||
+		     attrs[XFRMA_IPTFS_DROP_TIME] ||
+		     attrs[XFRMA_IPTFS_REORD_WIN] ||
+		     attrs[XFRMA_IPTFS_IN_DELAY]) &&
+		    p->mode != XFRM_MODE_IPTFS) {
+			NL_SET_ERR_MSG(extack, "IPTFS options can only be used in IPTFS mode");
+			goto out;
+		}
 		break;
 
 	case IPPROTO_COMP:
@@ -3046,6 +3056,12 @@ const struct nla_policy xfrma_policy[XFRMA_MAX+1] = {
 	[XFRMA_SET_MARK_MASK]	= { .type = NLA_U32 },
 	[XFRMA_IF_ID]		= { .type = NLA_U32 },
 	[XFRMA_MTIMER_THRESH]   = { .type = NLA_U32 },
+	[XFRMA_IPTFS_PKT_SIZE]	= { .type = NLA_U32 },
+	[XFRMA_IPTFS_MAX_QSIZE]	= { .type = NLA_U32 },
+	[XFRMA_IPTFS_DONT_FRAG]	= { .type = NLA_FLAG },
+	[XFRMA_IPTFS_DROP_TIME]	= { .type = NLA_U32 },
+	[XFRMA_IPTFS_REORD_WIN]	= { .type = NLA_U16 },
+	[XFRMA_IPTFS_IN_DELAY]	= { .type = NLA_U32 },
 };
 EXPORT_SYMBOL_GPL(xfrma_policy);
 
-- 
2.42.0


