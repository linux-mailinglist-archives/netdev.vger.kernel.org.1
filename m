Return-Path: <netdev+bounces-141835-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C1D589BC820
	for <lists+netdev@lfdr.de>; Tue,  5 Nov 2024 09:38:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 534401F23D48
	for <lists+netdev@lfdr.de>; Tue,  5 Nov 2024 08:38:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E3171CF7AA;
	Tue,  5 Nov 2024 08:38:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.chopps.org (smtp.chopps.org [54.88.81.56])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF9E81C233C
	for <netdev@vger.kernel.org>; Tue,  5 Nov 2024 08:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.88.81.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730795911; cv=none; b=BBN4L2/UGHam+oXevY/jghiCJp4KNo3vfcJdFHTPhIrGN7Nn//kDr1pVCXaIxBh4B0wUFOYXUjmxpHg66tDDsj+LcQi1+4C/WVsS/WkjN77+CsSbEZjmgXdZj7O0wy72egZ/+nn5U7xEm3EEsZPynTV2seAVtKfdHKR65eaTLAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730795911; c=relaxed/simple;
	bh=3dZ6lE+241yXH658707KweYx75dkkPuH1aXqkfqImYg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cJVlUhzzT6goNWbqvsKveBzfEi8ETPnn/fFm0rTu3i0rC2kZcbWEmwjwLXg8aMxyAOp7EiN+XlYQWpubkW+Hwfhk+N2o6WDWFhiP8dh+D0lH+fH4rQfHetWL1rf2CEL3TOTcjEIDl1GO55CDC/NN5Jgp6zhpXeG3bjpyqDmRitQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chopps.org; spf=fail smtp.mailfrom=chopps.org; arc=none smtp.client-ip=54.88.81.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chopps.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=chopps.org
Received: from labnh.big (syn-172-222-091-149.res.spectrum.com [172.222.91.149])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by smtp.chopps.org (Postfix) with ESMTPSA id C1D747D128;
	Tue,  5 Nov 2024 08:38:28 +0000 (UTC)
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
Subject: [PATCH ipsec-next v13 03/15] xfrm: netlink: add config (netlink) options
Date: Tue,  5 Nov 2024 03:37:47 -0500
Message-ID: <20241105083759.2172771-4-chopps@chopps.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241105083759.2172771-1-chopps@chopps.org>
References: <20241105083759.2172771-1-chopps@chopps.org>
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
index d73a97e3030a..a23495c0e0a1 100644
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
@@ -323,6 +324,12 @@ enum xfrm_attr_type_t {
 	XFRMA_SA_DIR,		/* __u8 */
 	XFRMA_NAT_KEEPALIVE_INTERVAL,	/* __u32 in seconds for NAT keepalive */
 	XFRMA_SA_PCPU,		/* __u32 */
+	XFRMA_IPTFS_DROP_TIME,	/* __u32 in: usec to wait for next seq */
+	XFRMA_IPTFS_REORDER_WINDOW, /* __u16 in: reorder window size (pkts) */
+	XFRMA_IPTFS_DONT_FRAG,	/* out: don't use fragmentation */
+	XFRMA_IPTFS_INIT_DELAY,	/* __u32 out: initial packet wait delay (usec) */
+	XFRMA_IPTFS_MAX_QSIZE,	/* __u32 out: max ingress queue size (octets) */
+	XFRMA_IPTFS_PKT_SIZE,	/* __u32 out: size of outer packet, 0 for PMTU */
 	__XFRMA_MAX
 
 #define XFRMA_OUTPUT_MARK XFRMA_SET_MARK	/* Compatibility */
diff --git a/net/xfrm/xfrm_compat.c b/net/xfrm/xfrm_compat.c
index 5b9ee63e30b6..b8d2e6930041 100644
--- a/net/xfrm/xfrm_compat.c
+++ b/net/xfrm/xfrm_compat.c
@@ -284,9 +284,15 @@ static int xfrm_xlate64_attr(struct sk_buff *dst, const struct nlattr *src)
 	case XFRMA_SA_DIR:
 	case XFRMA_NAT_KEEPALIVE_INTERVAL:
 	case XFRMA_SA_PCPU:
+	case XFRMA_IPTFS_DROP_TIME:
+	case XFRMA_IPTFS_REORDER_WINDOW:
+	case XFRMA_IPTFS_DONT_FRAG:
+	case XFRMA_IPTFS_INIT_DELAY:
+	case XFRMA_IPTFS_MAX_QSIZE:
+	case XFRMA_IPTFS_PKT_SIZE:
 		return xfrm_nla_cpy(dst, src, nla_len(src));
 	default:
-		BUILD_BUG_ON(XFRMA_MAX != XFRMA_SA_PCPU);
+		BUILD_BUG_ON(XFRMA_MAX != XFRMA_IPTFS_PKT_SIZE);
 		pr_warn_once("unsupported nla_type %d\n", src->nla_type);
 		return -EOPNOTSUPP;
 	}
@@ -441,7 +447,7 @@ static int xfrm_xlate32_attr(void *dst, const struct nlattr *nla,
 	int err;
 
 	if (type > XFRMA_MAX) {
-		BUILD_BUG_ON(XFRMA_MAX != XFRMA_SA_PCPU);
+		BUILD_BUG_ON(XFRMA_MAX != XFRMA_IPTFS_PKT_SIZE);
 		NL_SET_ERR_MSG(extack, "Bad attribute");
 		return -EOPNOTSUPP;
 	}
diff --git a/net/xfrm/xfrm_user.c b/net/xfrm/xfrm_user.c
index b6ce2b3c6b87..e9b0f7a5804e 100644
--- a/net/xfrm/xfrm_user.c
+++ b/net/xfrm/xfrm_user.c
@@ -301,6 +301,16 @@ static int verify_newsa_info(struct xfrm_usersa_info *p,
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
@@ -421,6 +431,18 @@ static int verify_newsa_info(struct xfrm_usersa_info *p,
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
 
@@ -458,6 +480,30 @@ static int verify_newsa_info(struct xfrm_usersa_info *p,
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
 
 	if (!sa_dir && attrs[XFRMA_SA_PCPU]) {
@@ -3219,6 +3265,12 @@ const struct nla_policy xfrma_policy[XFRMA_MAX+1] = {
 	[XFRMA_SA_DIR]          = NLA_POLICY_RANGE(NLA_U8, XFRM_SA_DIR_IN, XFRM_SA_DIR_OUT),
 	[XFRMA_NAT_KEEPALIVE_INTERVAL] = { .type = NLA_U32 },
 	[XFRMA_SA_PCPU]		= { .type = NLA_U32 },
+	[XFRMA_IPTFS_DROP_TIME]		= { .type = NLA_U32 },
+	[XFRMA_IPTFS_REORDER_WINDOW]	= { .type = NLA_U16 },
+	[XFRMA_IPTFS_DONT_FRAG]		= { .type = NLA_FLAG },
+	[XFRMA_IPTFS_INIT_DELAY]	= { .type = NLA_U32 },
+	[XFRMA_IPTFS_MAX_QSIZE]		= { .type = NLA_U32 },
+	[XFRMA_IPTFS_PKT_SIZE]	= { .type = NLA_U32 },
 };
 EXPORT_SYMBOL_GPL(xfrma_policy);
 
-- 
2.47.0


