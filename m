Return-Path: <netdev+bounces-212905-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 34392B22781
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 14:56:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C7AB567DD5
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 12:53:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35A1A26FDA5;
	Tue, 12 Aug 2025 12:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ga+htc7M"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29A4D27932F;
	Tue, 12 Aug 2025 12:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755003161; cv=none; b=ZT9AeiHY44YzdbT8ktWCouvCwbxvuV/Jjp/RRyv7XijzGVd7hGPxzAD6xomjJ9/bpfXPfGfX/29WGC7fxkHAQHfhgrnmZHqzymQn8dmznBK0den4KjlCguJaMUweR4rYaGFxD+udc8chqoCiu6MsSr6NOrh2ZlrnJhOgIHFnjSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755003161; c=relaxed/simple;
	bh=zODuDeLcVP9K71+Hxj4Eo8WlUKMrhfpkjX9hmtwzyYY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bsTI/3iXzJsdn6rkJgmzZL3u3/F+nUoO+o/41RHLuVLJv6vP8nkE9YTyoLnxKA8FmA1GiEA72rObsbsm1S3FAU9nQk6+D9xHDvA0OmhYl/Ry6bmuG1PBZ5N3jahf1GqcggUNQOYmGYlE7n2GmXZj8UDcebZudcXWbuLUDYS6jRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ga+htc7M; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-455fdfb5d04so27599145e9.2;
        Tue, 12 Aug 2025 05:52:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755003154; x=1755607954; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LoM3pHKDSpufsxbIRK7pt1DTxR4XUAze9GkDHudBN2I=;
        b=Ga+htc7M0j9xqj/BnEtyak7egTR7u7Y/lQEoPrnBTAtSfKHYxHRtL5abpbmNQOjv7V
         49y13tIdWfFnPyc+/7aazCAoUxxwMx+PnY5XFVouRJnL/ppYtASr+ZYIS1tCoCExmfPY
         bV2BpQVZWw7+hSpLZoXu9d6twN2nrO9XS66hXaC+B+a8wYTg0GMPPAn+TI/QFhs/XCwq
         hrRec5fJP7L0upazWsGCbxTaywn3SIl7VRvb5tge+pJsqOcnLbMjFXhGBUCLZAOgDLgR
         0y1w7b0mHWxXfLdsZQXzxUSNDu+OaOxA7kzWNHVZSqI7wlIZ3Eh3q8OOJsDVSdcL+swY
         OugQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755003154; x=1755607954;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LoM3pHKDSpufsxbIRK7pt1DTxR4XUAze9GkDHudBN2I=;
        b=xCA7Tvf1tmfe3AfNSDhpA10R2kUP6fv8lfW65FlagAw1VcgI8ZHXFtZ0i9ETGoKWzQ
         6h0EVCLL//Ldzs9VDd89ZVOw7+Vb3WJyP0glkcCG2KhVTEaSgAMvTsVh8aUrKmzck/7e
         /Jqh+a63PMcMFKDV2/Bk9AwbxfrPonMh2aQFUJ1ccI31in5XMRxksFSZ4Iuds29ew9/y
         M9siKUjKgx7rtxRH3bXe6sy19W3fkpBqZd+QRZLauz5VX7E+a+/uWgtSq6EkifAcuSQH
         cmcTz9mjZjeDW36kGRybFsXKoYVkg82O2WjBblWzS4VwApHf01JsGfftNkNYBWyUCBio
         zTOA==
X-Forwarded-Encrypted: i=1; AJvYcCUAGsHM29Khj2qE3vT/cx0GLRknRh4MqhH3tuymrfht26K80CO98Qv0Wk/v9w+j+6KYJGkDvHauxL5ALck=@vger.kernel.org
X-Gm-Message-State: AOJu0YwpEFmQ+61fQ/pFuCw665nGYN1P9D2lZWVOnP6qICnTQlYfPCt6
	dIM4yXKFu7KDq3Fsuc/LDCaY0qbUs6O/RUrerI2bAZVAMbupIHlmaFfLmkatVZbzLZSbDA==
X-Gm-Gg: ASbGncvohuI7PtmVtfP2oXD9FPq4r15y+iqtSvj5P8R7bg5ztmlcBVgLgKZ8l1U1RlP
	wBzZxqmKPizSdZ71jB8+NbqeJ43pOliHpDks6Fiql065UHoMFkuhO/s+kzzUNftxHpctCsBWh41
	Nnua+4Db7TbtcWd5caEcY8VlIXY2wJruxlAbAMw1HJkUgNlUoO9KF6coOjOLqw3RN21GHNKVFTf
	zoJo12qh+1lPLPeyLItztdrhXJOclm3IuFX0c5/UfeKAGr6XE89rygqEN/mr+ySNMFLh+BLCCBN
	W2w0AjY+B6FEa5GTBBOp2QcTSZU4rPB2xofF3nfa59gzfbqoj0FiEcFzsI9/foOiD3NDXjj5vWA
	qBhTxPaf3Ow0jpn3mqZbP8D9uO6dhy8mzdfp2mvJNiGnl
X-Google-Smtp-Source: AGHT+IG22qlMEx62qxiYpjyqH+9P5ewhYUnoB+ZDg90j3RDUxAx4LKKi8Oa2U5T8wq09+jS+AvjgzQ==
X-Received: by 2002:a05:600c:4f09:b0:458:bb0e:4181 with SMTP id 5b1f17b1804b1-45a10baf63dmr36820245e9.10.1755003154068;
        Tue, 12 Aug 2025 05:52:34 -0700 (PDT)
Received: from localhost ([45.10.155.17])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-459eec47306sm233487715e9.28.2025.08.12.05.52.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Aug 2025 05:52:33 -0700 (PDT)
From: Richard Gobert <richardbgobert@gmail.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	donald.hunter@gmail.com,
	andrew+netdev@lunn.ch,
	dsahern@kernel.org,
	shuah@kernel.org,
	daniel@iogearbox.net,
	jacob.e.keller@intel.com,
	razor@blackwall.org,
	idosch@nvidia.com,
	petrm@nvidia.com,
	menglong8.dong@gmail.com,
	martin.lau@kernel.org,
	linux-kernel@vger.kernel.org,
	Richard Gobert <richardbgobert@gmail.com>
Subject: [PATCH net-next v5 2/5] net: vxlan: add netlink option to bind vxlan sockets to local addresses
Date: Tue, 12 Aug 2025 14:51:52 +0200
Message-Id: <20250812125155.3808-3-richardbgobert@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250812125155.3808-1-richardbgobert@gmail.com>
References: <20250812125155.3808-1-richardbgobert@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, VXLAN sockets always bind to 0.0.0.0, even when a local
address is defined. This commit adds a netlink option to change
this behavior.

If two VXLAN endpoints are connected through two separate subnets,
they are each able to receive traffic through both subnets, regardless
of the local address. The new option will break this behavior.

Disable the option by default.

Signed-off-by: Richard Gobert <richardbgobert@gmail.com>
---
 drivers/net/vxlan/vxlan_core.c     | 43 +++++++++++++++++++++++++++---
 include/net/vxlan.h                |  1 +
 include/uapi/linux/if_link.h       |  1 +
 tools/include/uapi/linux/if_link.h |  1 +
 4 files changed, 43 insertions(+), 3 deletions(-)

diff --git a/drivers/net/vxlan/vxlan_core.c b/drivers/net/vxlan/vxlan_core.c
index f32be2e301f2..15fe9d83c724 100644
--- a/drivers/net/vxlan/vxlan_core.c
+++ b/drivers/net/vxlan/vxlan_core.c
@@ -3406,6 +3406,7 @@ static const struct nla_policy vxlan_policy[IFLA_VXLAN_MAX + 1] = {
 	[IFLA_VXLAN_LABEL_POLICY]       = NLA_POLICY_MAX(NLA_U32, VXLAN_LABEL_MAX),
 	[IFLA_VXLAN_RESERVED_BITS] = NLA_POLICY_EXACT_LEN(sizeof(struct vxlanhdr)),
 	[IFLA_VXLAN_MC_ROUTE]		= NLA_POLICY_MAX(NLA_U8, 1),
+	[IFLA_VXLAN_LOCALBIND]	= NLA_POLICY_MAX(NLA_U8, 1),
 };
 
 static int vxlan_validate(struct nlattr *tb[], struct nlattr *data[],
@@ -4044,15 +4045,37 @@ static int vxlan_nl2conf(struct nlattr *tb[], struct nlattr *data[],
 		conf->vni = vni;
 	}
 
+	if (data[IFLA_VXLAN_LOCALBIND]) {
+		if (changelink) {
+			NL_SET_ERR_MSG_ATTR(extack, tb[IFLA_VXLAN_LOCALBIND], "Cannot rebind locally");
+			return -EOPNOTSUPP;
+		}
+
+		err = vxlan_nl2flag(conf, data, IFLA_VXLAN_LOCALBIND,
+				    VXLAN_F_LOCALBIND, changelink,
+				    false, extack);
+		if (err)
+			return err;
+	}
+
 	if (data[IFLA_VXLAN_GROUP]) {
+		__be32 addr = nla_get_in_addr(data[IFLA_VXLAN_GROUP]);
+
 		if (changelink && (conf->remote_ip.sa.sa_family != AF_INET)) {
 			NL_SET_ERR_MSG_ATTR(extack, tb[IFLA_VXLAN_GROUP], "New group address family does not match old group");
 			return -EOPNOTSUPP;
 		}
 
-		conf->remote_ip.sin.sin_addr.s_addr = nla_get_in_addr(data[IFLA_VXLAN_GROUP]);
+		if ((conf->flags & VXLAN_F_LOCALBIND) && ipv4_is_multicast(addr)) {
+			NL_SET_ERR_MSG_ATTR(extack, tb[IFLA_VXLAN_GROUP], "Cannot add multicast group when bound locally");
+			return -EOPNOTSUPP;
+		}
+
+		conf->remote_ip.sin.sin_addr.s_addr = addr;
 		conf->remote_ip.sa.sa_family = AF_INET;
 	} else if (data[IFLA_VXLAN_GROUP6]) {
+		struct in6_addr addr = nla_get_in6_addr(data[IFLA_VXLAN_GROUP6]);
+
 		if (!IS_ENABLED(CONFIG_IPV6)) {
 			NL_SET_ERR_MSG_ATTR(extack, tb[IFLA_VXLAN_GROUP6], "IPv6 support not enabled in the kernel");
 			return -EPFNOSUPPORT;
@@ -4063,7 +4086,12 @@ static int vxlan_nl2conf(struct nlattr *tb[], struct nlattr *data[],
 			return -EOPNOTSUPP;
 		}
 
-		conf->remote_ip.sin6.sin6_addr = nla_get_in6_addr(data[IFLA_VXLAN_GROUP6]);
+		if ((conf->flags & VXLAN_F_LOCALBIND) && ipv6_addr_is_multicast(&addr)) {
+			NL_SET_ERR_MSG_ATTR(extack, tb[IFLA_VXLAN_GROUP6], "Cannot add multicast group when bound locally");
+			return -EOPNOTSUPP;
+		}
+
+		conf->remote_ip.sin6.sin6_addr = addr;
 		conf->remote_ip.sa.sa_family = AF_INET6;
 	}
 
@@ -4071,6 +4099,9 @@ static int vxlan_nl2conf(struct nlattr *tb[], struct nlattr *data[],
 		if (changelink && (conf->saddr.sa.sa_family != AF_INET)) {
 			NL_SET_ERR_MSG_ATTR(extack, tb[IFLA_VXLAN_LOCAL], "New local address family does not match old");
 			return -EOPNOTSUPP;
+		} else if (changelink && (conf->flags & VXLAN_F_LOCALBIND)) {
+			NL_SET_ERR_MSG_ATTR(extack, tb[IFLA_VXLAN_LOCAL], "Cannot change local address when bound locally");
+			return -EOPNOTSUPP;
 		}
 
 		conf->saddr.sin.sin_addr.s_addr = nla_get_in_addr(data[IFLA_VXLAN_LOCAL]);
@@ -4084,6 +4115,9 @@ static int vxlan_nl2conf(struct nlattr *tb[], struct nlattr *data[],
 		if (changelink && (conf->saddr.sa.sa_family != AF_INET6)) {
 			NL_SET_ERR_MSG_ATTR(extack, tb[IFLA_VXLAN_LOCAL6], "New local address family does not match old");
 			return -EOPNOTSUPP;
+		} else if (changelink && (conf->flags & VXLAN_F_LOCALBIND)) {
+			NL_SET_ERR_MSG_ATTR(extack, tb[IFLA_VXLAN_LOCAL6], "Cannot change local address when bound locally");
+			return -EOPNOTSUPP;
 		}
 
 		/* TODO: respect scope id */
@@ -4517,6 +4551,7 @@ static size_t vxlan_get_size(const struct net_device *dev)
 		nla_total_size(sizeof(__u8)) + /* IFLA_VXLAN_VNIFILTER */
 		/* IFLA_VXLAN_RESERVED_BITS */
 		nla_total_size(sizeof(struct vxlanhdr)) +
+		nla_total_size(sizeof(__u8)) + /* IFLA_VXLAN_LOCALBIND */
 		0;
 }
 
@@ -4596,7 +4631,9 @@ static int vxlan_fill_info(struct sk_buff *skb, const struct net_device *dev)
 	    nla_put_u8(skb, IFLA_VXLAN_REMCSUM_RX,
 		       !!(vxlan->cfg.flags & VXLAN_F_REMCSUM_RX)) ||
 	    nla_put_u8(skb, IFLA_VXLAN_LOCALBYPASS,
-		       !!(vxlan->cfg.flags & VXLAN_F_LOCALBYPASS)))
+		       !!(vxlan->cfg.flags & VXLAN_F_LOCALBYPASS)) ||
+	    nla_put_u8(skb, IFLA_VXLAN_LOCALBIND,
+		       !!(vxlan->cfg.flags & VXLAN_F_LOCALBIND)))
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


