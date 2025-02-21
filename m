Return-Path: <netdev+bounces-168575-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EDB86A3F60D
	for <lists+netdev@lfdr.de>; Fri, 21 Feb 2025 14:33:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7768A189E5BD
	for <lists+netdev@lfdr.de>; Fri, 21 Feb 2025 13:33:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA6B8207A2E;
	Fri, 21 Feb 2025 13:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b="EpITq16N"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f100.google.com (mail-lf1-f100.google.com [209.85.167.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A970520AF86
	for <netdev@vger.kernel.org>; Fri, 21 Feb 2025 13:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740144707; cv=none; b=AUOOdysdKLMyqIsuzzSOcg1uWKDt9JPdSULvJDRBo+n3vWR1hW9moDurh4u4+cgN05NWzXZ6BMzZrABbXS0hZgTeYtZUWTz1gdB2iwyiGcplNmEJvNbONvEpYdrsH6EWzGi3YU4qSifxj3LV+Vv3IWOG5vVWgc5PteiKDIAY9DQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740144707; c=relaxed/simple;
	bh=Lrwg3dqiChUw2jCOTYm4KIye/W7dlhttaIbNpRzChLg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L/HJZgmpvWEr8g8d7g1ussHaOwOOhRKxNh+NYf2Jom/JWv2u37l+s+Kr9vcZFgM7ntVXLAITTEWAJydmN4AxpyIB7cb3GTNDml9sj83KI5q35okq71aPpI7H74jwKLAWZJTUCefdj5im8APPEXeCjSBGeUVG1CC+VgcWG/zfMKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com; spf=pass smtp.mailfrom=6wind.com; dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b=EpITq16N; arc=none smtp.client-ip=209.85.167.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=6wind.com
Received: by mail-lf1-f100.google.com with SMTP id 2adb3069b0e04-54692061fc0so253678e87.0
        for <netdev@vger.kernel.org>; Fri, 21 Feb 2025 05:31:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google; t=1740144704; x=1740749504; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dqaokd5Ov8Mlde9/JfrdceLq0+Q85Ciz/R3Zdo2flDk=;
        b=EpITq16NsRI3DPDnt5pv3HvWhS1zERfBy8Fg2iSY5zUfiC22x7iusHXmxuSoWWBNqw
         0wryOBs8wDTGmK0EWw1guDbZjYfKUF0tMnQelAqBWyxLyN3IkRS8Mn3H38Zpg0w+ZpJ9
         yR8EOU/C5KZk9NktUpnfvowsOVnNPKECTorXYCxPijFEtGAE+4YnPFXMTNjx2p2qtteT
         Y3tSufru5L5Y6M/WapOmi1TngjfgIm77HZ7uCvpGzpayjPIzanaHUU3HZa96fPEdQlP3
         /iFpAToISdZI3m2nyMm6L/Bpsji4Du9AaLw0qrKUEWocmbBLoBpOJGdBymMT4Xj6sX9O
         rhUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740144704; x=1740749504;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dqaokd5Ov8Mlde9/JfrdceLq0+Q85Ciz/R3Zdo2flDk=;
        b=VrsW5X4gWRDvk9byaLCEENrfexgrVkR2W1FW+mLEuptL0eOyJ6rQxjGNumRb27rUgt
         /QKkgyEZSOtY9LbHy7s4/EnO+FOC6AnM+4D7fzR1MgRpOwTG9PejgttsWAxScWYhRsxL
         LDsOyjZvHEQ1cIA5v7c9DOeyaWU/d6OxNiH5QujAFGHjIOOhduTwe6MCaHFoYQMl6QPy
         2E9fiAsn2AlFLWvm3ZO3OBZlABE+XIKYcvIKHEnp92rLwtbX2AzhTf741BJjuhp+LeVz
         lMgSnkz8kG7FVn/nEDSdZ0DSCapQlV4iP1Mx/C1L/6/nXSL5vRgXH9tzi7pCaqeEKQg/
         QNjw==
X-Forwarded-Encrypted: i=1; AJvYcCXneT/YIPBJpMdeyTkgexGwS6ZfEY9RNk5VsZVc/VcAMynaKZnFyKV7jnShwzAVZLRcbmHWhFQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyIbgPhQFa3U7Cnl8CzKGpjOjsFTju8nIAd8glgvW2/ak0jZElz
	JgkZPoplsYvBYQWwJIslRRC1hsT4NdMlyW6wgrS5Fkh9+BAq8hTUgizVBCNXgxyUytdKQVP3+sI
	eB4YCKq+2Y0U2PAwoz1t5q8Adigdcf6Q3
X-Gm-Gg: ASbGnctrQJid5AuixZxiI6uPZQD4qT2cs2EhcJ53x909whC0VIz3Ssn+no+y67TgUqL
	l3jCwti2kxKqKpoEwf61075gv9zYCOWOn5Qea3wPlwtp9IEgZ0O/BvzuvXf7bUdkwLeBRtdyUA5
	uxhsWcso8tFP8+yS+MItMTgktQ8/q27VHCLLh5HCKRa26lkr5XyC3WJSRuThKsRsxYT/nGHQW5X
	dDuZn+JChlBYbHew3IdYOQn+UTGzt1QObQAEAksAVe73pMarDNwvIEhYH6NYadJ7F9AprFND1Nf
	j/ll9zHFjcoKVez5c/CKKCVT10JHfE50b5LIlivqYEEUlXR3H0iTR3Fh4Sa6VEsg9YuZ9NM=
X-Google-Smtp-Source: AGHT+IHQGxZ0fmt+W/zgN5uNEXAqhlW4r4i6rMqrCCC3hJRiadAGnnkxr9wVbjZE6drxj5qi2UEVvj7wGzdo
X-Received: by 2002:a05:6512:138b:b0:545:3033:4373 with SMTP id 2adb3069b0e04-54838ee9327mr437163e87.6.1740144703675;
        Fri, 21 Feb 2025 05:31:43 -0800 (PST)
Received: from smtpservice.6wind.com ([185.13.181.2])
        by smtp-relay.gmail.com with ESMTP id 2adb3069b0e04-5452efc766asm566289e87.122.2025.02.21.05.31.43;
        Fri, 21 Feb 2025 05:31:43 -0800 (PST)
X-Relaying-Domain: 6wind.com
Received: from bretzel (bretzel.dev.6wind.com [10.17.1.57])
	by smtpservice.6wind.com (Postfix) with ESMTPS id 45DB413E9A;
	Fri, 21 Feb 2025 14:31:43 +0100 (CET)
Received: from dichtel by bretzel with local (Exim 4.94.2)
	(envelope-from <nicolas.dichtel@6wind.com>)
	id 1tlT83-008b6g-17; Fri, 21 Feb 2025 14:31:43 +0100
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
Subject: [PATCH net-next v4 2/3] net: advertise netns_immutable property via netlink
Date: Fri, 21 Feb 2025 14:30:27 +0100
Message-ID: <20250221133136.2049165-3-nicolas.dichtel@6wind.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250221133136.2049165-1-nicolas.dichtel@6wind.com>
References: <20250221133136.2049165-1-nicolas.dichtel@6wind.com>
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
index abe1a461ea67..a76f63b926df 100644
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


