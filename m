Return-Path: <netdev+bounces-169761-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A9AFA45A28
	for <lists+netdev@lfdr.de>; Wed, 26 Feb 2025 10:32:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D89D167B67
	for <lists+netdev@lfdr.de>; Wed, 26 Feb 2025 09:32:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D475022425F;
	Wed, 26 Feb 2025 09:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b="T7cC3SaX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f100.google.com (mail-ej1-f100.google.com [209.85.218.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0027F15573A
	for <netdev@vger.kernel.org>; Wed, 26 Feb 2025 09:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740562357; cv=none; b=XeqBA1ME+t4TLiE6WjpN3IFXl/zJtX9WqJxfwWXuawtSbsjYiSluhHzRRE7RI2lEQ4ENzhYx1z/Ynv36Q3dbwE4LXWFuNEg9cMiM6Ik2/DSAsgTyekhgcERy90ColoryEWVIkh5WVtTJPy0JrMLwsbOpmb3127/pd+DyCqxCqL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740562357; c=relaxed/simple;
	bh=Xn9nQdyUSyfKvlLeaOex1D1vL5KHm+i7FO0+HVgubK4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UgVm0yHXSFUmUojzuNyVqMJLSz9Y8uCVhly1+Yd6KxQCb2F7AZZ90DyHYY8unSVl1o1QvVjz9AytBW42TCIqP4mPoPniaa/GSupZkLDHWaPXwToaTrADzDy4PUS/1Fy5GpXm2X3DQYdgVOn6oTKcdR7RCnBT00DkU/nzTAQQusE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com; spf=pass smtp.mailfrom=6wind.com; dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b=T7cC3SaX; arc=none smtp.client-ip=209.85.218.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=6wind.com
Received: by mail-ej1-f100.google.com with SMTP id a640c23a62f3a-ab7e08f56a0so116354366b.1
        for <netdev@vger.kernel.org>; Wed, 26 Feb 2025 01:32:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google; t=1740562354; x=1741167154; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ovapIaAmKYWmwn6q03ORg6+lXlCnZf5DsxFrhWyykKk=;
        b=T7cC3SaXzdzf1XqWhvVFgwRMg3BMq8UxpHW0f++ed9PZ/5ADkU935UPDhCJ9vfdW+B
         1z/2e4UwCEWPXty7pWMyJJoTX9nz8NeeeUdZOZUM2PvZllPn1da2UKEqldyK6u3ADcX1
         sm+6Wv7P1pT+10nLSWkAEuCrIUIuTP5yjOhyYuE07I24wCjkO1K7XSS/UbB//5FjU4rE
         jURfKcFEU7PaEI9HHN57J/OCdGRNrMBbgU5RJ5ppGPnYaO6U6oK+fNnnqjRayMIjSGVk
         5TEa/0pPH2yiGr8+6j6CWb3K2zP43VZrDc+YCKZvxeC4Hc0nf05zDxfoYXOS2Jg4VJT4
         o7Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740562354; x=1741167154;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ovapIaAmKYWmwn6q03ORg6+lXlCnZf5DsxFrhWyykKk=;
        b=B/hq91cm+URZPBYBJdCBsd55Hqr50BINBPWiGpwFlfia1PeKXQyo0LyfQ+dsdjM2oL
         dhBHAB5VPywkUFSzfcDm+NWd7OpdjHhq4HIeSZJHvqEtuMhz7tOBAGheLqXX+FN8hiWb
         3Br8nITXI95GLopRwJGPLWfrb4N8zTmQZWH0lZ1sIB8raSHyb6GqFFQ2/4CVYK6Zw4SJ
         FRwohXBVqblKCw3LajdUXjq/wZMAT6XglwkwiSvKncSzHpRnoFpt20lh+VH+pXkeuACh
         B96qT4TZhA0/N32kjNKkTC4b+uyXDmzXQPXpb+qdbMwP7yxjUVwBpW/chZpl1Kbl3cBf
         dfSQ==
X-Forwarded-Encrypted: i=1; AJvYcCW9ZHBXG3oMUq4vWYl5pIdZukSmSlr9L1sTzMoeCzcwatkfU5abghdhD05ApMPrtD/otu/chV8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyAoRCQ/jdTxQUiZXBhVuXnL3hVGDS+mllYSLduicvlY2F8fILS
	QZfmZQpupRX5QSe5OgT94iUh2bmxyP/6kdkVFHwWjOQfxus9gSeDBWSsERrFsga5q1Nc6Wd7MWT
	Ak4qvzAD/sA6HIc3b0+vo52yp01dxFuER
X-Gm-Gg: ASbGnctq38fAfq0gIRozu6P4+OnFxlISOFdoxCdFuy+cAnSWijC4n+rjaJnh/io8IEC
	nvuyxFKYKe1GiMnw+nPACbNqFPWFXe6Z5nt3Bh91aWUJ13tI09JHTS9V1vRXLZDRC1PTTDvM1Uw
	apEQ4CgJlpbwFCeKdYK5aJwKwRx7D+Pkan3vNa8ncqM68Lk6vyLyMvk/NDhYMseO+hJS/GSxafi
	aFtDLRBe+WgQCwk3Hu6QU+SQtWIQNMNpwFqDmwckJPCCQFOTypPl4j1Y7AUIhPRWyPEqX9kEBAU
	ip1jZeGKhZtTwH+zUGPNm+eDo7e8sGoFbMSvfYpGK+xt8f35kWApU+Od2bTFx/vZf21LkeY=
X-Google-Smtp-Source: AGHT+IGmiGmhGufkYOzTRBNTnOgBrngu1sNWRp0fXIgASdBl+l/sPbLfNQlHnZTGLwHAbtxXlt1czuKGJSLf
X-Received: by 2002:a17:907:2ce2:b0:ab7:cd83:98bb with SMTP id a640c23a62f3a-abc09a3c1c5mr789248366b.5.1740562354085;
        Wed, 26 Feb 2025 01:32:34 -0800 (PST)
Received: from smtpservice.6wind.com ([185.13.181.2])
        by smtp-relay.gmail.com with ESMTP id a640c23a62f3a-abed1ad1217sm20053866b.22.2025.02.26.01.32.33;
        Wed, 26 Feb 2025 01:32:34 -0800 (PST)
X-Relaying-Domain: 6wind.com
Received: from bretzel (bretzel.dev.6wind.com [10.17.1.57])
	by smtpservice.6wind.com (Postfix) with ESMTPS id CB0721669B;
	Wed, 26 Feb 2025 10:32:33 +0100 (CET)
Received: from dichtel by bretzel with local (Exim 4.94.2)
	(envelope-from <nicolas.dichtel@6wind.com>)
	id 1tnDmL-002hmf-J5; Wed, 26 Feb 2025 10:32:33 +0100
From: Nicolas Dichtel <nicolas.dichtel@6wind.com>
To: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: Ido Schimmel <idosch@idosch.org>,
	Andrew Lunn <andrew@lunn.ch>,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	netdev@vger.kernel.org,
	Nicolas Dichtel <nicolas.dichtel@6wind.com>
Subject: [PATCH net-next v5 2/3] net: advertise netns_immutable property via netlink
Date: Wed, 26 Feb 2025 10:31:57 +0100
Message-ID: <20250226093232.644814-3-nicolas.dichtel@6wind.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250226093232.644814-1-nicolas.dichtel@6wind.com>
References: <20250226093232.644814-1-nicolas.dichtel@6wind.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since commit 05c1280a2bcf ("netdev_features: convert NETIF_F_NETNS_LOCAL to
dev->netns_local"), there is no way to see if the netns_immutable property
s set on a device. Let's add a netlink attribute to advertise it.

Signed-off-by: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: Alexander Lobakin <aleksander.lobakin@intel.com>
Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 Documentation/netlink/specs/rt_link.yaml | 3 +++
 include/uapi/linux/if_link.h             | 1 +
 net/core/rtnetlink.c                     | 3 +++
 3 files changed, 7 insertions(+)

diff --git a/Documentation/netlink/specs/rt_link.yaml b/Documentation/netlink/specs/rt_link.yaml
index 0d492500c7e5..d13b14c6b9d7 100644
--- a/Documentation/netlink/specs/rt_link.yaml
+++ b/Documentation/netlink/specs/rt_link.yaml
@@ -1148,6 +1148,9 @@ attribute-sets:
         name: max-pacing-offload-horizon
         type: uint
         doc: EDT offload horizon supported by the device (in nsec).
+      -
+        name: netns-immutable
+        type: u8
   -
     name: af-spec-attrs
     attributes:
diff --git a/include/uapi/linux/if_link.h b/include/uapi/linux/if_link.h
index bfe880fbbb24..a2b6cfde7162 100644
--- a/include/uapi/linux/if_link.h
+++ b/include/uapi/linux/if_link.h
@@ -378,6 +378,7 @@ enum {
 	IFLA_GRO_IPV4_MAX_SIZE,
 	IFLA_DPLL_PIN,
 	IFLA_MAX_PACING_OFFLOAD_HORIZON,
+	IFLA_NETNS_IMMUTABLE,
 	__IFLA_MAX
 };
 
diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
index b52e610e157e..8b6bf5e9bb34 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -1292,6 +1292,7 @@ static noinline size_t if_nlmsg_size(const struct net_device *dev,
 	       + nla_total_size(4) /* IFLA_TSO_MAX_SEGS */
 	       + nla_total_size(1) /* IFLA_OPERSTATE */
 	       + nla_total_size(1) /* IFLA_LINKMODE */
+	       + nla_total_size(1) /* IFLA_NETNS_IMMUTABLE */
 	       + nla_total_size(4) /* IFLA_CARRIER_CHANGES */
 	       + nla_total_size(4) /* IFLA_LINK_NETNSID */
 	       + nla_total_size(4) /* IFLA_GROUP */
@@ -2046,6 +2047,7 @@ static int rtnl_fill_ifinfo(struct sk_buff *skb,
 		       netif_running(dev) ? READ_ONCE(dev->operstate) :
 					    IF_OPER_DOWN) ||
 	    nla_put_u8(skb, IFLA_LINKMODE, READ_ONCE(dev->link_mode)) ||
+	    nla_put_u8(skb, IFLA_NETNS_IMMUTABLE, dev->netns_immutable) ||
 	    nla_put_u32(skb, IFLA_MTU, READ_ONCE(dev->mtu)) ||
 	    nla_put_u32(skb, IFLA_MIN_MTU, READ_ONCE(dev->min_mtu)) ||
 	    nla_put_u32(skb, IFLA_MAX_MTU, READ_ONCE(dev->max_mtu)) ||
@@ -2234,6 +2236,7 @@ static const struct nla_policy ifla_policy[IFLA_MAX+1] = {
 	[IFLA_ALLMULTI]		= { .type = NLA_REJECT },
 	[IFLA_GSO_IPV4_MAX_SIZE]	= NLA_POLICY_MIN(NLA_U32, MAX_TCP_HEADER + 1),
 	[IFLA_GRO_IPV4_MAX_SIZE]	= { .type = NLA_U32 },
+	[IFLA_NETNS_IMMUTABLE]	= { .type = NLA_REJECT },
 };
 
 static const struct nla_policy ifla_info_policy[IFLA_INFO_MAX+1] = {
-- 
2.47.1


