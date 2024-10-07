Return-Path: <netdev+bounces-132728-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ABE9C992E7D
	for <lists+netdev@lfdr.de>; Mon,  7 Oct 2024 16:12:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2633D1F21861
	for <lists+netdev@lfdr.de>; Mon,  7 Oct 2024 14:12:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F6F91D5AAD;
	Mon,  7 Oct 2024 14:11:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.chopps.org (smtp.chopps.org [54.88.81.56])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 877091D54C2
	for <netdev@vger.kernel.org>; Mon,  7 Oct 2024 14:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.88.81.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728310291; cv=none; b=ajaosD3L6Wh+4JTFdX+WLk768wmvIZ3+RuJQaRLAyAcvx6WND3trtjN15hjRCtNQkalzP/a2sB2MsNWOzeaXBFLiAflUlwcq66Wks9fMRknIugEGBYFeBo5UComQ1raJpEW5U/JabM6T3rm9jHT6N491bJrsny0iadT30UxOCJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728310291; c=relaxed/simple;
	bh=LLJzQ1GJEkYhPc4BuT3tOF5IZO6oMC9dKKK9MUg8hpY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qk0hATNSOX21t1T19NgUKYH0h4i11FvhpdYIELc7SU+Qt4E0RkPpp73aWkHm9xxiUUBKpJ2GwggU54IkzgUg6o2fi+s0PCRbfluFnBLOp3CZHAWRkHKjjAx3pllh4pB2LsWTy9x0BU0BqFoZMo+h0bHj3Fql7r8AclbFLDukwB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chopps.org; spf=fail smtp.mailfrom=chopps.org; arc=none smtp.client-ip=54.88.81.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chopps.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=chopps.org
Received: from labnh.big (syn-172-222-091-149.res.spectrum.com [172.222.91.149])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by smtp.chopps.org (Postfix) with ESMTPSA id 573E97D136;
	Mon,  7 Oct 2024 13:59:48 +0000 (UTC)
From: Christian Hopps <chopps@chopps.org>
To: devel@linux-ipsec.org
Cc: Steffen Klassert <steffen.klassert@secunet.com>,
	netdev@vger.kernel.org,
	Florian Westphal <fw@strlen.de>,
	Sabrina Dubroca <sd@queasysnail.net>,
	Simon Horman <horms@kernel.org>,
	Antony Antony <antony@phenome.org>,
	Christian Hopps <chopps@chopps.org>,
	Christian Hopps <chopps@labn.net>
Subject: [PATCH ipsec-next v12 04/16] xfrm: netlink: add config (netlink) options
Date: Mon,  7 Oct 2024 09:59:16 -0400
Message-ID: <20241007135928.1218955-5-chopps@chopps.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20241007135928.1218955-1-chopps@chopps.org>
References: <20241007135928.1218955-1-chopps@chopps.org>
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
 include/uapi/linux/xfrm.h |  9 ++++++-
 net/xfrm/xfrm_compat.c    | 10 ++++++--
 net/xfrm/xfrm_user.c      | 52 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 68 insertions(+), 3 deletions(-)

diff --git a/include/uapi/linux/xfrm.h b/include/uapi/linux/xfrm.h
index f28701500714..042ebf94bb3d 100644
--- a/include/uapi/linux/xfrm.h
+++ b/include/uapi/linux/xfrm.h
@@ -158,7 +158,8 @@ enum {
 #define XFRM_MODE_ROUTEOPTIMIZATION 2
 #define XFRM_MODE_IN_TRIGGER 3
 #define XFRM_MODE_BEET 4
-#define XFRM_MODE_MAX 5
+#define XFRM_MODE_IPTFS 5
+#define XFRM_MODE_MAX 6
 
 /* Netlink configuration messages.  */
 enum {
@@ -322,6 +323,12 @@ enum xfrm_attr_type_t {
 	XFRMA_MTIMER_THRESH,	/* __u32 in seconds for input SA */
 	XFRMA_SA_DIR,		/* __u8 */
 	XFRMA_NAT_KEEPALIVE_INTERVAL,	/* __u32 in seconds for NAT keepalive */
+	XFRMA_IPTFS_DROP_TIME,	/* __u32 in: usec to wait for next seq */
+	XFRMA_IPTFS_REORDER_WINDOW, /* __u16 in: reorder window size (pkts) */
+	XFRMA_IPTFS_DONT_FRAG,	/* out: don't use fragmentation */
+	XFRMA_IPTFS_INIT_DELAY,	/* __u32 out: initial packet wait delay (usec) */
+	XFRMA_IPTFS_MAX_QSIZE,	/* __u32 out: max ingress queue size (octets) */
+	XFRMA_IPTFS_PKT_SIZE,	/* __u32 out: size of outer packet, 0 for PMTU */
 	__XFRMA_MAX
 
 #define XFRMA_OUTPUT_MARK XFRMA_SET_MARK	/* Compatibility */
diff --git a/net/xfrm/xfrm_compat.c b/net/xfrm/xfrm_compat.c
index 91357ccaf4af..5c55e07f3d10 100644
--- a/net/xfrm/xfrm_compat.c
+++ b/net/xfrm/xfrm_compat.c
@@ -282,9 +282,15 @@ static int xfrm_xlate64_attr(struct sk_buff *dst, const struct nlattr *src)
 	case XFRMA_MTIMER_THRESH:
 	case XFRMA_SA_DIR:
 	case XFRMA_NAT_KEEPALIVE_INTERVAL:
+	case XFRMA_IPTFS_DROP_TIME:
+	case XFRMA_IPTFS_REORDER_WINDOW:
+	case XFRMA_IPTFS_DONT_FRAG:
+	case XFRMA_IPTFS_INIT_DELAY:
+	case XFRMA_IPTFS_MAX_QSIZE:
+	case XFRMA_IPTFS_PKT_SIZE:
 		return xfrm_nla_cpy(dst, src, nla_len(src));
 	default:
-		BUILD_BUG_ON(XFRMA_MAX != XFRMA_NAT_KEEPALIVE_INTERVAL);
+		BUILD_BUG_ON(XFRMA_MAX != XFRMA_IPTFS_PKT_SIZE);
 		pr_warn_once("unsupported nla_type %d\n", src->nla_type);
 		return -EOPNOTSUPP;
 	}
@@ -439,7 +445,7 @@ static int xfrm_xlate32_attr(void *dst, const struct nlattr *nla,
 	int err;
 
 	if (type > XFRMA_MAX) {
-		BUILD_BUG_ON(XFRMA_MAX != XFRMA_NAT_KEEPALIVE_INTERVAL);
+		BUILD_BUG_ON(XFRMA_MAX != XFRMA_IPTFS_PKT_SIZE);
 		NL_SET_ERR_MSG(extack, "Bad attribute");
 		return -EOPNOTSUPP;
 	}
diff --git a/net/xfrm/xfrm_user.c b/net/xfrm/xfrm_user.c
index 55f039ec3d59..f6ed019192f3 100644
--- a/net/xfrm/xfrm_user.c
+++ b/net/xfrm/xfrm_user.c
@@ -297,6 +297,16 @@ static int verify_newsa_info(struct xfrm_usersa_info *p,
 			NL_SET_ERR_MSG(extack, "TFC padding can only be used in tunnel mode");
 			goto out;
 		}
+		if ((attrs[XFRMA_IPTFS_DROP_TIME] ||
+		     attrs[XFRMA_IPTFS_REORDER_WINDOW] ||
+		     attrs[XFRMA_IPTFS_DONT_FRAG] ||
+		     attrs[XFRMA_IPTFS_INIT_DELAY] ||
+		     attrs[XFRMA_IPTFS_MAX_QSIZE] ||
+		     attrs[XFRMA_IPTFS_PKT_SIZE]) &&
+		    p->mode != XFRM_MODE_IPTFS) {
+			NL_SET_ERR_MSG(extack, "IP-TFS options can only be used in IP-TFS mode");
+			goto out;
+		}
 		break;
 
 	case IPPROTO_COMP:
@@ -417,6 +427,18 @@ static int verify_newsa_info(struct xfrm_usersa_info *p,
 			goto out;
 		}
 
+		if (attrs[XFRMA_IPTFS_DROP_TIME]) {
+			NL_SET_ERR_MSG(extack, "IP-TFS drop time should not be set for output SA");
+			err = -EINVAL;
+			goto out;
+		}
+
+		if (attrs[XFRMA_IPTFS_REORDER_WINDOW]) {
+			NL_SET_ERR_MSG(extack, "IP-TFS reorder window should not be set for output SA");
+			err = -EINVAL;
+			goto out;
+		}
+
 		if (attrs[XFRMA_REPLAY_VAL]) {
 			struct xfrm_replay_state *replay;
 
@@ -454,6 +476,30 @@ static int verify_newsa_info(struct xfrm_usersa_info *p,
 			}
 
 		}
+
+		if (attrs[XFRMA_IPTFS_DONT_FRAG]) {
+			NL_SET_ERR_MSG(extack, "IP-TFS don't fragment should not be set for input SA");
+			err = -EINVAL;
+			goto out;
+		}
+
+		if (attrs[XFRMA_IPTFS_INIT_DELAY]) {
+			NL_SET_ERR_MSG(extack, "IP-TFS initial delay should not be set for input SA");
+			err = -EINVAL;
+			goto out;
+		}
+
+		if (attrs[XFRMA_IPTFS_MAX_QSIZE]) {
+			NL_SET_ERR_MSG(extack, "IP-TFS max queue size should not be set for input SA");
+			err = -EINVAL;
+			goto out;
+		}
+
+		if (attrs[XFRMA_IPTFS_PKT_SIZE]) {
+			NL_SET_ERR_MSG(extack, "IP-TFS packet size should not be set for input SA");
+			err = -EINVAL;
+			goto out;
+		}
 	}
 
 out:
@@ -3176,6 +3222,12 @@ const struct nla_policy xfrma_policy[XFRMA_MAX+1] = {
 	[XFRMA_MTIMER_THRESH]   = { .type = NLA_U32 },
 	[XFRMA_SA_DIR]          = NLA_POLICY_RANGE(NLA_U8, XFRM_SA_DIR_IN, XFRM_SA_DIR_OUT),
 	[XFRMA_NAT_KEEPALIVE_INTERVAL] = { .type = NLA_U32 },
+	[XFRMA_IPTFS_DROP_TIME]		= { .type = NLA_U32 },
+	[XFRMA_IPTFS_REORDER_WINDOW]	= { .type = NLA_U16 },
+	[XFRMA_IPTFS_DONT_FRAG]		= { .type = NLA_FLAG },
+	[XFRMA_IPTFS_INIT_DELAY]	= { .type = NLA_U32 },
+	[XFRMA_IPTFS_MAX_QSIZE]		= { .type = NLA_U32 },
+	[XFRMA_IPTFS_PKT_SIZE]	= { .type = NLA_U32 },
 };
 EXPORT_SYMBOL_GPL(xfrma_policy);
 
-- 
2.46.0


