Return-Path: <netdev+bounces-207836-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C0EDEB08C36
	for <lists+netdev@lfdr.de>; Thu, 17 Jul 2025 13:56:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 017BC167C8B
	for <lists+netdev@lfdr.de>; Thu, 17 Jul 2025 11:56:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41BF32BCF5B;
	Thu, 17 Jul 2025 11:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d0Z2LcwG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A5EC29B8C6;
	Thu, 17 Jul 2025 11:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752753293; cv=none; b=NnpppR14oU+CxhuW8zzbk7mCsu9sVIbUhdfu2RqSl6vjwEEDzyhGde0m918p14/o+KcIreRgF4LM46AzEBTckPoU0P+f8WB/C/1QRYAArCS8MaEqYl0r+1r2VFMu04oiUG/4vGLCWRdSwQ3ZO2CKFTHjatBnHho8SA09S4AVi+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752753293; c=relaxed/simple;
	bh=ZFTE9/tnzFVqQ/jpUyc9fn2dWpNVca7VzfF8id7e4ME=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bonXBga2XwjysFa3QSyTsW6Szp6+osfwk3l1gPd5LZqt0knx4fj/5exYLa8XZ8c/33+pMUJOQtkkJhHafOoeItEmvqZAbbAmDQ6kCHs7gNzjJvWDyg7smq/3QwdXB0DRqHLNctay6iY92mO4myMcd5i9b39kGwhLH5ukn1c7o0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d0Z2LcwG; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3ab112dea41so487859f8f.1;
        Thu, 17 Jul 2025 04:54:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752753289; x=1753358089; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=O8Mfc0zC4ruO3OtFu2emQU/6si00PFdROnoPrUh9e2g=;
        b=d0Z2LcwGU9c+7mRocx54WRqCjqEiAZ+rLZ3jx9otzRz4TXfUQz8tDQDghwuldRobcg
         G+djiqVvCkXR2dGg38SfKhXkWPNFHhRUZgc6RfPkfxOmxsX3Z+XGuv+At5m7tKrXyp3p
         vSxJnUeUBaAfhOFqj+CNq119Kcj+NMZRRFTlu2IUPMJwKkCYn8yo0GXYkCMjP8YFfKW5
         vkK8D6vMNDG5kTpE8Z4OqlFakzYt+9o1Kp3F88xe4z2dDFbtIjn0n5OjB1KVZ9pPEXWc
         tOUcn5zOeAvULNDCRFqf291PAfWsPgQXA9X0rMlNc7XrG3KdkVkc16xt1Xv/RgE8jtpG
         STvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752753289; x=1753358089;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O8Mfc0zC4ruO3OtFu2emQU/6si00PFdROnoPrUh9e2g=;
        b=ntdFewFYjyYhuZQ2BOR1Ra4MS9MnlAN2pcWDH5h9DN7GxIZsC02KPeGV8O0v++k3BD
         dPA/bWoeScGhAJn/y5xujy3zqfbqrNd9r8teM1SlA8QQzt8Jv1wg1e3zinlmuZNPSoph
         zOwFGESUoQAeVFfsWQNs+xgP6hXjyqMRj9ZkSvCZIBSL5XZ3CD/xPt6Bwbs6XAI7nu0u
         tpLrw/lllqQI5BxoqfvOso4qFqzQ16c09d1uZa6uh8OCJKkXCGUCmZ36gwo+DajfgSs/
         8avGkcrHG7TDVfsEpnAE+rf9WCmCwmfM82HmrqN1mdXed8bJn74RqFsVc/DbO6lYvjbG
         /6qA==
X-Forwarded-Encrypted: i=1; AJvYcCUV0asUc22C6HNWLxweWTtjRO3WNpP+BEdXyXELs5CFtolUPRYzfD73r/YhrqbK2rsvKWmBR3XLRB0LPYs=@vger.kernel.org, AJvYcCVwQXAmq7EQqG+rcLzMP5qkm4etGa6Wj4dPhWw86SKlaAsoY/FbPJNnVHbq0bhsQaHxywqec4CU@vger.kernel.org
X-Gm-Message-State: AOJu0YzPx61UPR0x1uUnFJxQ53fn6+UWttxC9JUYZHgB33pVWWlAHd8f
	YXQ3cYRzehZymKgyL04gFloToTKIdxzKd8j5xqZPhqqtw2s22LxDyhia
X-Gm-Gg: ASbGnctbXdxH+6jizfVRQX5TDmnygzRkh9N90FVFp+qUENyAXA9/1HOFJRGK9+F7ifd
	kW0brklCWX8pjCbnkgNlpZwoXXSWxS/pOyVMOM4iJDttyNoUjS8h7E85EXDa3q8OMeieoiqAMG1
	Z/0ARGNNbxFMr6WJ3IFj5xStotFuBqdEBI/yqqUyTCLa83W45cATXX53125EbhD24CTqrDIMi0S
	JpeGeAJltTKO6BYLLrxkIZU+UNiW5ATMlBpGlowd6AXyTwyoOfhq7WHUbxGCozMGX+xn8UIFNIH
	5O8ZFSlFdKPugZT+0LbDtkJXYzSicSpYLaGjLHXhQtcA9CkbvZ/P5I+CarI6SiLE+3QyYo7O05Q
	=
X-Google-Smtp-Source: AGHT+IFlF7Ulk737hZOgnk1vPg2m+0Ci7dbyi5Qm7lCWMR24A4HwlV4HDqyguvUQ3ePsFuK2AbCmAQ==
X-Received: by 2002:a05:6000:4606:b0:3a5:3af1:e21b with SMTP id ffacd0b85a97d-3b60dd9988amr4870756f8f.47.1752753289242;
        Thu, 17 Jul 2025 04:54:49 -0700 (PDT)
Received: from localhost ([45.84.137.104])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b5e8dc2131sm20196347f8f.29.2025.07.17.04.54.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jul 2025 04:54:48 -0700 (PDT)
From: Richard Gobert <richardbgobert@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	dsahern@kernel.org,
	razor@blackwall.org,
	idosch@nvidia.com,
	petrm@nvidia.com,
	menglong8.dong@gmail.com,
	richardbgobert@gmail.com,
	daniel@iogearbox.net,
	martin.lau@kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v4 2/4] net: vxlan: add netlink option to bind vxlan sockets to local addresses
Date: Thu, 17 Jul 2025 13:54:10 +0200
Message-Id: <20250717115412.11424-3-richardbgobert@gmail.com>
In-Reply-To: <20250717115412.11424-1-richardbgobert@gmail.com>
References: <20250717115412.11424-1-richardbgobert@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, VXLAN sockets always bind to 0.0.0.0, even when a local
address is defined. This commit changes this behavior.

If two VXLAN endpoints are connected through two separate subnets,
they are each able to receive traffic through both subnets, regardless
of the local address. This commit breaks this behavior.

Add a netlink option to configure the new behavior. Since the scenario
described above is unrealistic, default to binding the socket to the
local address.

It is highly unlikely this change will break any networks.

Signed-off-by: Richard Gobert <richardbgobert@gmail.com>
---
 drivers/net/vxlan/vxlan_core.c     | 23 ++++++++++++++++++++++-
 include/net/vxlan.h                |  1 +
 include/uapi/linux/if_link.h       |  1 +
 tools/include/uapi/linux/if_link.h |  1 +
 4 files changed, 25 insertions(+), 1 deletion(-)

diff --git a/drivers/net/vxlan/vxlan_core.c b/drivers/net/vxlan/vxlan_core.c
index bcde95cb2a2e..667ff17c4569 100644
--- a/drivers/net/vxlan/vxlan_core.c
+++ b/drivers/net/vxlan/vxlan_core.c
@@ -3406,6 +3406,7 @@ static const struct nla_policy vxlan_policy[IFLA_VXLAN_MAX + 1] = {
 	[IFLA_VXLAN_LABEL_POLICY]       = NLA_POLICY_MAX(NLA_U32, VXLAN_LABEL_MAX),
 	[IFLA_VXLAN_RESERVED_BITS] = NLA_POLICY_EXACT_LEN(sizeof(struct vxlanhdr)),
 	[IFLA_VXLAN_MC_ROUTE]		= NLA_POLICY_MAX(NLA_U8, 1),
+	[IFLA_VXLAN_LOCALBIND]	= { .type = NLA_U8 },
 };
 
 static int vxlan_validate(struct nlattr *tb[], struct nlattr *data[],
@@ -4071,6 +4072,9 @@ static int vxlan_nl2conf(struct nlattr *tb[], struct nlattr *data[],
 		if (changelink && (conf->saddr.sa.sa_family != AF_INET)) {
 			NL_SET_ERR_MSG_ATTR(extack, tb[IFLA_VXLAN_LOCAL], "New local address family does not match old");
 			return -EOPNOTSUPP;
+		} else if (changelink && (conf->flags & VXLAN_F_LOCALBIND)) {
+			NL_SET_ERR_MSG_ATTR(extack, tb[IFLA_VXLAN_LOCAL], "Cannot change local address when bound locally");
+			return -EOPNOTSUPP;
 		}
 
 		conf->saddr.sin.sin_addr.s_addr = nla_get_in_addr(data[IFLA_VXLAN_LOCAL]);
@@ -4084,6 +4088,9 @@ static int vxlan_nl2conf(struct nlattr *tb[], struct nlattr *data[],
 		if (changelink && (conf->saddr.sa.sa_family != AF_INET6)) {
 			NL_SET_ERR_MSG_ATTR(extack, tb[IFLA_VXLAN_LOCAL6], "New local address family does not match old");
 			return -EOPNOTSUPP;
+		} else if (changelink && (conf->flags & VXLAN_F_LOCALBIND)) {
+			NL_SET_ERR_MSG_ATTR(extack, tb[IFLA_VXLAN_LOCAL6], "Cannot change local address when bound locally");
+			return -EOPNOTSUPP;
 		}
 
 		/* TODO: respect scope id */
@@ -4354,6 +4361,17 @@ static int vxlan_nl2conf(struct nlattr *tb[], struct nlattr *data[],
 		}
 	}
 
+	if (data[IFLA_VXLAN_LOCALBIND]) {
+		err = vxlan_nl2flag(conf, data, IFLA_VXLAN_LOCALBIND,
+				    VXLAN_F_LOCALBIND, changelink,
+				    false, extack);
+		if (err)
+			return err;
+	} else {
+		/* default to bind to the local address on a new device */
+		conf->flags |= VXLAN_F_LOCALBIND;
+	}
+
 	return 0;
 }
 
@@ -4517,6 +4535,7 @@ static size_t vxlan_get_size(const struct net_device *dev)
 		nla_total_size(sizeof(__u8)) + /* IFLA_VXLAN_VNIFILTER */
 		/* IFLA_VXLAN_RESERVED_BITS */
 		nla_total_size(sizeof(struct vxlanhdr)) +
+		nla_total_size(sizeof(__u8)) + /* IFLA_VXLAN_LOCALBIND */
 		0;
 }
 
@@ -4596,7 +4615,9 @@ static int vxlan_fill_info(struct sk_buff *skb, const struct net_device *dev)
 	    nla_put_u8(skb, IFLA_VXLAN_REMCSUM_RX,
 		       !!(vxlan->cfg.flags & VXLAN_F_REMCSUM_RX)) ||
 	    nla_put_u8(skb, IFLA_VXLAN_LOCALBYPASS,
-		       !!(vxlan->cfg.flags & VXLAN_F_LOCALBYPASS)))
+		       !!(vxlan->cfg.flags & VXLAN_F_LOCALBYPASS)) ||
+		nla_put_u8(skb, IFLA_VXLAN_LOCALBIND,
+			   !!(vxlan->cfg.flags & VXLAN_F_LOCALBIND)))
 		goto nla_put_failure;
 
 	if (nla_put(skb, IFLA_VXLAN_PORT_RANGE, sizeof(ports), &ports))
diff --git a/include/net/vxlan.h b/include/net/vxlan.h
index 0ee50785f4f1..e356b5294535 100644
--- a/include/net/vxlan.h
+++ b/include/net/vxlan.h
@@ -333,6 +333,7 @@ struct vxlan_dev {
 #define VXLAN_F_MDB			0x40000
 #define VXLAN_F_LOCALBYPASS		0x80000
 #define VXLAN_F_MC_ROUTE		0x100000
+#define VXLAN_F_LOCALBIND		0x200000
 
 /* Flags that are used in the receive path. These flags must match in
  * order for a socket to be shareable
diff --git a/include/uapi/linux/if_link.h b/include/uapi/linux/if_link.h
index 784ace3a519c..7350129b1444 100644
--- a/include/uapi/linux/if_link.h
+++ b/include/uapi/linux/if_link.h
@@ -1399,6 +1399,7 @@ enum {
 	IFLA_VXLAN_LABEL_POLICY, /* IPv6 flow label policy; ifla_vxlan_label_policy */
 	IFLA_VXLAN_RESERVED_BITS,
 	IFLA_VXLAN_MC_ROUTE,
+	IFLA_VXLAN_LOCALBIND,
 	__IFLA_VXLAN_MAX
 };
 #define IFLA_VXLAN_MAX	(__IFLA_VXLAN_MAX - 1)
diff --git a/tools/include/uapi/linux/if_link.h b/tools/include/uapi/linux/if_link.h
index 7e46ca4cd31b..eee934cc2cf4 100644
--- a/tools/include/uapi/linux/if_link.h
+++ b/tools/include/uapi/linux/if_link.h
@@ -1396,6 +1396,7 @@ enum {
 	IFLA_VXLAN_VNIFILTER, /* only applicable with COLLECT_METADATA mode */
 	IFLA_VXLAN_LOCALBYPASS,
 	IFLA_VXLAN_LABEL_POLICY, /* IPv6 flow label policy; ifla_vxlan_label_policy */
+	IFLA_VXLAN_LOCALBIND,
 	__IFLA_VXLAN_MAX
 };
 #define IFLA_VXLAN_MAX	(__IFLA_VXLAN_MAX - 1)
-- 
2.36.1


