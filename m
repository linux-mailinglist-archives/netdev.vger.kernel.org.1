Return-Path: <netdev+bounces-72846-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BE336859EF5
	for <lists+netdev@lfdr.de>; Mon, 19 Feb 2024 09:59:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D2AAD1C22505
	for <lists+netdev@lfdr.de>; Mon, 19 Feb 2024 08:59:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6A3522EE8;
	Mon, 19 Feb 2024 08:59:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.chopps.org (smtp.chopps.org [54.88.81.56])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 321522231A
	for <netdev@vger.kernel.org>; Mon, 19 Feb 2024 08:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.88.81.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708333166; cv=none; b=e8HEGsXQ6SLn8jkNIbeivhqT0mZ5hpIFQWmnl2ZPCa0KuzWwb0PqRf3VtIRXpIbAiml0SzytwXfuCqKX8L1iJ067khYloEq+07Jy3sJFvcuj8QUCrtnsi0ldOgnjTaO1WMultuTj/F/VkAvpAKqbZYudQMjHKLp2SBbwE1C/pd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708333166; c=relaxed/simple;
	bh=RhHhPybKoa9bvfJHl15ffx3xMyU9Yhl+1eIvtbiR6SQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Hr+IHhbumyNOdjpD2unzf43uckHQ16GNosjhiFyBzgVS4f1XDm4aL6B/ulUUtna5/L57z4kaluKirdsb26PfHH6W0IWNKZykTjOrcpHUhCm5D1LW5Ze2eHmsx6JchsvDsBaUvd5YF0VPXcFJDK73gn7iCKj07G02V3gKa3xe6xc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chopps.org; spf=fail smtp.mailfrom=chopps.org; arc=none smtp.client-ip=54.88.81.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chopps.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=chopps.org
Received: from labnh.int.chopps.org (172-222-091-149.res.spectrum.com [172.222.91.149])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by smtp.chopps.org (Postfix) with ESMTPSA id 6FFAD7D11A;
	Mon, 19 Feb 2024 08:59:24 +0000 (UTC)
From: Christian Hopps <chopps@chopps.org>
To: devel@linux-ipsec.org
Cc: Steffen Klassert <steffen.klassert@secunet.com>,
	netdev@vger.kernel.org,
	Christian Hopps <chopps@chopps.org>,
	Christian Hopps <chopps@labn.net>
Subject: [PATCH ipsec-next v1 5/8] iptfs: netlink: add config (netlink) options
Date: Mon, 19 Feb 2024 03:57:32 -0500
Message-ID: <20240219085735.1220113-6-chopps@chopps.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240219085735.1220113-1-chopps@chopps.org>
References: <20240219085735.1220113-1-chopps@chopps.org>
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
 include/uapi/linux/xfrm.h |  9 ++++++++-
 net/xfrm/xfrm_compat.c    | 10 ++++++++--
 net/xfrm/xfrm_user.c      | 16 ++++++++++++++++
 3 files changed, 32 insertions(+), 3 deletions(-)

diff --git a/include/uapi/linux/xfrm.h b/include/uapi/linux/xfrm.h
index 6a77328be114..fcb8f1583284 100644
--- a/include/uapi/linux/xfrm.h
+++ b/include/uapi/linux/xfrm.h
@@ -153,7 +153,8 @@ enum {
 #define XFRM_MODE_ROUTEOPTIMIZATION 2
 #define XFRM_MODE_IN_TRIGGER 3
 #define XFRM_MODE_BEET 4
-#define XFRM_MODE_MAX 5
+#define XFRM_MODE_IPTFS 5
+#define XFRM_MODE_MAX 6
 
 /* Netlink configuration messages.  */
 enum {
@@ -315,6 +316,12 @@ enum xfrm_attr_type_t {
 	XFRMA_SET_MARK_MASK,	/* __u32 */
 	XFRMA_IF_ID,		/* __u32 */
 	XFRMA_MTIMER_THRESH,	/* __u32 in seconds for input SA */
+	XFRMA_IPTFS_PKT_SIZE,	/* __u32 Size of outer packet, 0 for PMTU */
+	XFRMA_IPTFS_MAX_QSIZE,	/* __u32 max ingress queue size */
+	XFRMA_IPTFS_DONT_FRAG,	/* don't use fragmentation */
+	XFRMA_IPTFS_DROP_TIME,	/* __u32 usec to wait for next seq */
+	XFRMA_IPTFS_REORDER_WINDOW,	/* __u16 reorder window size */
+	XFRMA_IPTFS_INIT_DELAY,	/* __u32 initial packet wait delay (usec) */
 	__XFRMA_MAX
 
 #define XFRMA_OUTPUT_MARK XFRMA_SET_MARK	/* Compatibility */
diff --git a/net/xfrm/xfrm_compat.c b/net/xfrm/xfrm_compat.c
index 655fe4ff8621..0e533b89b17f 100644
--- a/net/xfrm/xfrm_compat.c
+++ b/net/xfrm/xfrm_compat.c
@@ -277,9 +277,15 @@ static int xfrm_xlate64_attr(struct sk_buff *dst, const struct nlattr *src)
 	case XFRMA_SET_MARK_MASK:
 	case XFRMA_IF_ID:
 	case XFRMA_MTIMER_THRESH:
+	case XFRMA_IPTFS_PKT_SIZE:
+	case XFRMA_IPTFS_MAX_QSIZE:
+	case XFRMA_IPTFS_DONT_FRAG:
+	case XFRMA_IPTFS_DROP_TIME:
+	case XFRMA_IPTFS_REORDER_WINDOW:
+	case XFRMA_IPTFS_INIT_DELAY:
 		return xfrm_nla_cpy(dst, src, nla_len(src));
 	default:
-		BUILD_BUG_ON(XFRMA_MAX != XFRMA_MTIMER_THRESH);
+		BUILD_BUG_ON(XFRMA_MAX != XFRMA_IPTFS_INIT_DELAY);
 		pr_warn_once("unsupported nla_type %d\n", src->nla_type);
 		return -EOPNOTSUPP;
 	}
@@ -434,7 +440,7 @@ static int xfrm_xlate32_attr(void *dst, const struct nlattr *nla,
 	int err;
 
 	if (type > XFRMA_MAX) {
-		BUILD_BUG_ON(XFRMA_MAX != XFRMA_MTIMER_THRESH);
+		BUILD_BUG_ON(XFRMA_MAX != XFRMA_IPTFS_INIT_DELAY);
 		NL_SET_ERR_MSG(extack, "Bad attribute");
 		return -EOPNOTSUPP;
 	}
diff --git a/net/xfrm/xfrm_user.c b/net/xfrm/xfrm_user.c
index ad01997c3aa9..d4c88d29703e 100644
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
+		     attrs[XFRMA_IPTFS_REORDER_WINDOW] ||
+		     attrs[XFRMA_IPTFS_INIT_DELAY]) &&
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
+	[XFRMA_IPTFS_REORDER_WINDOW]	= { .type = NLA_U16 },
+	[XFRMA_IPTFS_INIT_DELAY]	= { .type = NLA_U32 },
 };
 EXPORT_SYMBOL_GPL(xfrma_policy);
 
-- 
2.43.0


