Return-Path: <netdev+bounces-168137-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0436A3DAB4
	for <lists+netdev@lfdr.de>; Thu, 20 Feb 2025 14:04:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3659116C4D1
	for <lists+netdev@lfdr.de>; Thu, 20 Feb 2025 13:03:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D447F1F561B;
	Thu, 20 Feb 2025 13:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b="eTtKstKr"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f97.google.com (mail-lf1-f97.google.com [209.85.167.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB1921EEA3E
	for <netdev@vger.kernel.org>; Thu, 20 Feb 2025 13:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740056620; cv=none; b=IVL2zq5ThvLbNEWBBxzw7n/Xfv8I3OHAndnlcOjUoWf9ZGvzLd6BwMwpNPIqikwW8DbdJ6JSpxTfNtguYU1OS+KVPQ4ktzkDI4y24B4Gqsg/+A9BNbtrhTRL8XnzzhMkY4yP82GjLl6VqG2E7RRmal2Z8aMZOX7SxRWH2lcVBpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740056620; c=relaxed/simple;
	bh=LD99jXMO0pDEEfxglMi2fxX3QbZbmtOJyC8mGCRjaZA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EBjyMYV7Lrar/GKnNqU5vBpEJxK2zbs7i2qQO9MmpyXQg6VyLOKve1fNiRCromMrei3pFE063mo+tVpdQlzYkQ+5qeqPp1+YzgDfEgh6ojX+WmWSomsicF5gaHh+MENld/L3/dLhIa1gBSkWpzFbSiIQYGAZMmGw1XRTTN1U8qc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com; spf=pass smtp.mailfrom=6wind.com; dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b=eTtKstKr; arc=none smtp.client-ip=209.85.167.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=6wind.com
Received: by mail-lf1-f97.google.com with SMTP id 2adb3069b0e04-5462eb4c13fso145228e87.2
        for <netdev@vger.kernel.org>; Thu, 20 Feb 2025 05:03:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google; t=1740056617; x=1740661417; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gd6Dwcx/Q3w2MNQqv3fEs/rhH+5PexgvT7rFZEFJuI8=;
        b=eTtKstKrzRg/qyOyCowSQIGbymn8yJtB7TWx1DaWAkZ5F3q+ABth64NrutKM+bqSUl
         JSYWYXvdi2TKSM8KuRgbL4dKqC3/QAU8rosn/ZiIkjO+NxGuW0LZVPbFa9Wh55wbwa4z
         DSnTL6FuyDQzy1hxXSkwqMYtbf8uVJ7RUsCeNVd9uZtipIajGVtsBv7JZYxj5hIC0IEC
         4gK1s+fCaNV59OLnJg46/bgqHo55TYfmo3wxNR5cauJcjFM4N6w4zYJFflu3YFp42ivw
         +quMWxRU3trHUE7Gr2G9IqG2AfotfV4cD9VlvhHsTJ4YUOD0eWqitj/DqL+eQdIM3TWw
         sOYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740056617; x=1740661417;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Gd6Dwcx/Q3w2MNQqv3fEs/rhH+5PexgvT7rFZEFJuI8=;
        b=jEZ3gIFm7TU6fWQlkVrWWf6mrUHgetZoikNyQV+FSfbXheSKtef3MBIfqkCf6JQHZP
         IezJcgCFYtks5fb7m/FwPeH0gCnEl8aRlWenC+zIgE6pNXBqU+3LNeEZ7VlITak6ju9k
         DJnxqpgjlwhLsANT2FQdTrGDYn/VDO5UaKrB4rGCI798zTijJJat87SCyOBUuuTvg1VG
         AMCHSj6bxHV8xuXOxuVWyeYfIeOzRw3WYtOxpuHGYFol6SnQMqoYS7vfIFIF0UUEKds6
         ETGHr6D5ENgbvQgDIl48+HHgH8RHKKuxpFYMl4Bro/REPxSoHFr0EGAPu/z/MZMVRoxB
         6qvg==
X-Forwarded-Encrypted: i=1; AJvYcCUFkojfXvVx4Tz1FtDwqvOH4et1gGVNoGH3qWt/UfST816NpxOBIr+ukGd+m4WzTfm8g23E59o=@vger.kernel.org
X-Gm-Message-State: AOJu0YzIRSB0EQGATu5oJdhq14avxXcXc3oCKbIr8P+1N8jwhGrpFhPx
	RpRga88gD3e3uvW4EB092aKk4EY33/8bxa30Xms/qCDvQIAtifbvCSuo1N3rNfLHlX1WEEsodHC
	UNT2admJnHBaiOk6t66Zk2xboYQHz6j+0
X-Gm-Gg: ASbGncue7ruSvI8b/iPvYzI3AaNQkFsp/gewzYUaPzvzTonaxnUZGGNvkniv9k4SL7h
	n9BWAM5kLemX938gAgeErM/I/LQqnYhLmXY0JrikBYFwS5KWgvhdI0Dv6tAqa2+GS3hhhgDO9Tr
	kt3PQSAKT1XRw9c8Io/J5qobl2A0ehCW4a37V0Zdla0T0bze/MRatPg8sK+TPstikrXsPhXVMvh
	ZhwNWasRrUvzhL8RWKVQ/75l0L9aC1XNLFj768KGJvixKDAtHEIsu07E6cXE9ZLiiEPY9CbjjUf
	xhCWgMmDQrwXbQrsKr8IJaX0EqjgdX27BhsEnR1R8vBRVyT8freoyfBpixEF
X-Google-Smtp-Source: AGHT+IGFqjnDSoGp8BxR6ZQ7RMjeKTMg01yrQNMM6XH6aCEJEGc6D2azIZN9ObFa5iiSba1ly21CXBfz5ZqU
X-Received: by 2002:a05:6512:ba6:b0:545:1d80:1ef0 with SMTP id 2adb3069b0e04-5452fe56da1mr2393346e87.7.1740056616691;
        Thu, 20 Feb 2025 05:03:36 -0800 (PST)
Received: from smtpservice.6wind.com ([185.13.181.2])
        by smtp-relay.gmail.com with ESMTP id 2adb3069b0e04-546202506fbsm339757e87.62.2025.02.20.05.03.36;
        Thu, 20 Feb 2025 05:03:36 -0800 (PST)
X-Relaying-Domain: 6wind.com
Received: from bretzel (bretzel.dev.6wind.com [10.17.1.57])
	by smtpservice.6wind.com (Postfix) with ESMTPS id 4B16C1352E;
	Thu, 20 Feb 2025 14:03:36 +0100 (CET)
Received: from dichtel by bretzel with local (Exim 4.94.2)
	(envelope-from <nicolas.dichtel@6wind.com>)
	id 1tl6DI-00F2Dj-1U; Thu, 20 Feb 2025 14:03:36 +0100
From: Nicolas Dichtel <nicolas.dichtel@6wind.com>
To: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: Ido Schimmel <idosch@idosch.org>,
	Andrew Lunn <andrew@lunn.ch>,
	netdev@vger.kernel.org,
	Nicolas Dichtel <nicolas.dichtel@6wind.com>
Subject: [PATCH net-next v3 1/2] net: advertise 'netns local' property via netlink
Date: Thu, 20 Feb 2025 14:02:35 +0100
Message-ID: <20250220130334.3583331-2-nicolas.dichtel@6wind.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250220130334.3583331-1-nicolas.dichtel@6wind.com>
References: <20250220130334.3583331-1-nicolas.dichtel@6wind.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since commit 05c1280a2bcf ("netdev_features: convert NETIF_F_NETNS_LOCAL to
dev->netns_local"), there is no way to see if the netns_local property is
set on a device. Let's add a netlink attribute to advertise it.

Signed-off-by: Nicolas Dichtel <nicolas.dichtel@6wind.com>
---
 Documentation/netlink/specs/rt_link.yaml | 3 +++
 include/uapi/linux/if_link.h             | 1 +
 net/core/rtnetlink.c                     | 3 +++
 3 files changed, 7 insertions(+)

diff --git a/Documentation/netlink/specs/rt_link.yaml b/Documentation/netlink/specs/rt_link.yaml
index 0d492500c7e5..a646d8a6bf9d 100644
--- a/Documentation/netlink/specs/rt_link.yaml
+++ b/Documentation/netlink/specs/rt_link.yaml
@@ -1148,6 +1148,9 @@ attribute-sets:
         name: max-pacing-offload-horizon
         type: uint
         doc: EDT offload horizon supported by the device (in nsec).
+      -
+        name: netns-local
+        type: u8
   -
     name: af-spec-attrs
     attributes:
diff --git a/include/uapi/linux/if_link.h b/include/uapi/linux/if_link.h
index bfe880fbbb24..ed4a64e1c8f1 100644
--- a/include/uapi/linux/if_link.h
+++ b/include/uapi/linux/if_link.h
@@ -378,6 +378,7 @@ enum {
 	IFLA_GRO_IPV4_MAX_SIZE,
 	IFLA_DPLL_PIN,
 	IFLA_MAX_PACING_OFFLOAD_HORIZON,
+	IFLA_NETNS_LOCAL,
 	__IFLA_MAX
 };
 
diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
index abe1a461ea67..acf787e4d22d 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -1292,6 +1292,7 @@ static noinline size_t if_nlmsg_size(const struct net_device *dev,
 	       + nla_total_size(4) /* IFLA_TSO_MAX_SEGS */
 	       + nla_total_size(1) /* IFLA_OPERSTATE */
 	       + nla_total_size(1) /* IFLA_LINKMODE */
+	       + nla_total_size(1) /* IFLA_NETNS_LOCAL */
 	       + nla_total_size(4) /* IFLA_CARRIER_CHANGES */
 	       + nla_total_size(4) /* IFLA_LINK_NETNSID */
 	       + nla_total_size(4) /* IFLA_GROUP */
@@ -2046,6 +2047,7 @@ static int rtnl_fill_ifinfo(struct sk_buff *skb,
 		       netif_running(dev) ? READ_ONCE(dev->operstate) :
 					    IF_OPER_DOWN) ||
 	    nla_put_u8(skb, IFLA_LINKMODE, READ_ONCE(dev->link_mode)) ||
+	    nla_put_u8(skb, IFLA_NETNS_LOCAL, dev->netns_local) ||
 	    nla_put_u32(skb, IFLA_MTU, READ_ONCE(dev->mtu)) ||
 	    nla_put_u32(skb, IFLA_MIN_MTU, READ_ONCE(dev->min_mtu)) ||
 	    nla_put_u32(skb, IFLA_MAX_MTU, READ_ONCE(dev->max_mtu)) ||
@@ -2234,6 +2236,7 @@ static const struct nla_policy ifla_policy[IFLA_MAX+1] = {
 	[IFLA_ALLMULTI]		= { .type = NLA_REJECT },
 	[IFLA_GSO_IPV4_MAX_SIZE]	= NLA_POLICY_MIN(NLA_U32, MAX_TCP_HEADER + 1),
 	[IFLA_GRO_IPV4_MAX_SIZE]	= { .type = NLA_U32 },
+	[IFLA_NETNS_LOCAL]	= { .type = NLA_REJECT },
 };
 
 static const struct nla_policy ifla_info_policy[IFLA_INFO_MAX+1] = {
-- 
2.47.1


