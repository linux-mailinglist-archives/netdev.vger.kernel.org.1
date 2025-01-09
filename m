Return-Path: <netdev+bounces-156584-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C6283A071C6
	for <lists+netdev@lfdr.de>; Thu,  9 Jan 2025 10:43:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5219E7A3407
	for <lists+netdev@lfdr.de>; Thu,  9 Jan 2025 09:43:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98EF82153FC;
	Thu,  9 Jan 2025 09:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="EoIDPKrJ"
X-Original-To: netdev@vger.kernel.org
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CD582594BA
	for <netdev@vger.kernel.org>; Thu,  9 Jan 2025 09:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736415815; cv=none; b=lfhCyVthHyeXG49mw+eybGgGXwC5YIJIYSePF2lzUdexc5IwNJ3+2XQ+QZ3tdXOLlcf3pFvzZW5k8SHgzK4p6W15QsiIK3IqBPtVuy+4zN32l5j0+2M5n4b0ZSjoNNwlrYOlIbkxG6Lcg+H/c9Ppq45BSYYClwLhqfNYMk1eOZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736415815; c=relaxed/simple;
	bh=jl+hHYsJhHZdi/wM83dFJMZV7JHpgxTEx0S0uPkbFRI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=K7ztTKpVMEb+ajvS1LLrg4G5Wp7aUrry4ujSTtVkW/bC8g7Z46Yzmuqs2NdTccGsQ7CxS8Ukp34T3UCx84CnyXE9q2BatmCFpNorLElpymL1jkRWNJGxdutYIK7BpOABu2B2uc0UJQY8t/p7FJOVRliA38V9RrDQrN8xhCRfn3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=EoIDPKrJ; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id 2A0B92087B;
	Thu,  9 Jan 2025 10:43:32 +0100 (CET)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id E_7JkBh0VH5J; Thu,  9 Jan 2025 10:43:30 +0100 (CET)
Received: from cas-essen-02.secunet.de (rl2.secunet.de [10.53.40.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id 673852083E;
	Thu,  9 Jan 2025 10:43:30 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com 673852083E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1736415810;
	bh=U0ZP07AEtXBVSLOiTpZ0gkYgm6KU9D6B/tsaSJiuMLI=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:From;
	b=EoIDPKrJqgu1OHd+Gmbm707FtkOlFqU8renA3Ioj8BBKABywnU9C0mIvIgLLufZlM
	 5CdX5yqrZ2XgsMXTWYUS5XmOIOcOfflcdEb82nSXBf5ClMGvIPlHua/IiC+pJsKzIl
	 B0/77AhFex8oDjZqdbGAWUsNYnZYd8Z+/dx1fa5cu1DHMPuPSv5KFc1KKC0Lr/kAEg
	 IV8BuWHqk8gNrX+Uv/tOkGlSVsf3+9zgZH4maqEEn3fNUG8CUkB/i9gJ/z+YOzHgRM
	 eNfQer7Tp5o62qS/yqmYzDRBCIRaVynrH3VUJJPTZQdqc0XOxmw6sJcpBNPlo0Npks
	 KLQLuK/7eRpnw==
Received: from mbx-essen-02.secunet.de (10.53.40.198) by
 cas-essen-02.secunet.de (10.53.40.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 9 Jan 2025 10:43:30 +0100
Received: from gauss2.secunet.de (10.182.7.193) by mbx-essen-02.secunet.de
 (10.53.40.198) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 9 Jan
 2025 10:43:29 +0100
Received: by gauss2.secunet.de (Postfix, from userid 1000)
	id 881073183EE1; Thu,  9 Jan 2025 10:43:29 +0100 (CET)
From: Steffen Klassert <steffen.klassert@secunet.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
CC: Herbert Xu <herbert@gondor.apana.org.au>, Steffen Klassert
	<steffen.klassert@secunet.com>, <netdev@vger.kernel.org>
Subject: [PATCH 03/17] xfrm: netlink: add config (netlink) options
Date: Thu, 9 Jan 2025 10:43:07 +0100
Message-ID: <20250109094321.2268124-4-steffen.klassert@secunet.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250109094321.2268124-1-steffen.klassert@secunet.com>
References: <20250109094321.2268124-1-steffen.klassert@secunet.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: cas-essen-01.secunet.de (10.53.40.201) To
 mbx-essen-02.secunet.de (10.53.40.198)
X-EXCLAIMER-MD-CONFIG: 2c86f778-e09b-4440-8b15-867914633a10

From: Christian Hopps <chopps@labn.net>

Add netlink options for configuring IP-TFS SAs.

Signed-off-by: Christian Hopps <chopps@labn.net>
Tested-by: Antony Antony <antony.antony@secunet.com>
Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
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
index b2876e09328b..749ec56101ac 100644
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
@@ -3220,6 +3266,12 @@ const struct nla_policy xfrma_policy[XFRMA_MAX+1] = {
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
2.34.1


