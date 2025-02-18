Return-Path: <netdev+bounces-167427-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F135CA3A3E0
	for <lists+netdev@lfdr.de>; Tue, 18 Feb 2025 18:16:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5425C3B28A4
	for <lists+netdev@lfdr.de>; Tue, 18 Feb 2025 17:13:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 412C326FA6B;
	Tue, 18 Feb 2025 17:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b="LNHwCgYP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f99.google.com (mail-wm1-f99.google.com [209.85.128.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79A2D26FA4E
	for <netdev@vger.kernel.org>; Tue, 18 Feb 2025 17:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739898827; cv=none; b=YSoogRKctjB9doE9qmg2SwXOgpY8L3UHCS5U4xnb9oq7giZa0mwwVAKIz6L9+GZ2iJI4RTS1pzxP7EUWqy166Ms5kdbkwgfh9RY9o4xjd9ghhuaUQD+Q+eF+g3PSVp7+dTrYoLmo3jiR8+QyBtGMwIFza5c9//p7WIEW5jyEs38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739898827; c=relaxed/simple;
	bh=Qo0S1t6YIppK843HPI/H3rLHJ7+t4I4Hq9t1sU6dC3s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B2wLXQYjBopOgF8DvasDUmd/KCgWeNqQ69H1nGqIHHNPiXf2T6ouEb6fSMYP8cNglevLKP8oQ2jMaZ/9Cz5+YHag1YncBhdxckm0hvGv/55QfqLGm1MSBhIibSAeS5xE3i/XkUpvpSi1HCyLHZrf3AWNL/V4GR80dPK+n1zou2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com; spf=pass smtp.mailfrom=6wind.com; dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b=LNHwCgYP; arc=none smtp.client-ip=209.85.128.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=6wind.com
Received: by mail-wm1-f99.google.com with SMTP id 5b1f17b1804b1-439999d2bbfso223955e9.2
        for <netdev@vger.kernel.org>; Tue, 18 Feb 2025 09:13:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google; t=1739898823; x=1740503623; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yzn8I7zdwu9Nfuw3jXMjrxnmSQyAGZFeFVvTe44zzC0=;
        b=LNHwCgYPg+hchZsp2k7yH8HBHXXy1EqIg/13NJ7GHMof3Jw16bmqGLDKBt/UHxDhO+
         qRjqYRPAXS+PipfwsygE5WUGU45rxe3wur4OPkXsRfeDKGlnfm2Pwjg0U7s03al2QTSW
         Mc5/GQ37mHZwf4KEVlhjyy9aoLVSoC5sDaDwenrUlnLU5YKv3q8edfjWV5vOx73M12o8
         3hA0jARS0nfaswJDsl4dG9Dp+7kfHTH4goeUd5XbGzXTENwbF8c9ZkZXviHDCQ8UCQu8
         5SkG3qkTsEWC64fwkOIJf5KUt1XadMtXCgUOeQo+murteMzlgC4TkNM7Xa9xbws1D6Yc
         n3pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739898823; x=1740503623;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yzn8I7zdwu9Nfuw3jXMjrxnmSQyAGZFeFVvTe44zzC0=;
        b=q2zQGWzN2VyslEI+99Nw9q06pIfon7Y5iOnPdH/azzD02V8QMurqR4ziJ+w1eMGVS2
         zLGchvW/zoi+ajo/F3zfulCVRYbsGedGCuAH8SqNZgXuwPJ8ewMNc3hsPJFXpnlufWBC
         gAheyPcZk3El/S9B5OJLevbmk3hh9NDiw0snR6rk3ZGBFlLeE+GW8qD0u8l5CRs9mRVT
         umP3VUT35hITv5dGxpJEVZMnXw6dfBCTscKedxXKZTcKWsTnzx5HXy0BRYgSLpnfHZtM
         A+a5FTZBSsjPY16WQudFdJxSdIfuZCIuBd+XjYJ5AKWQ8JlJq332sAFiJxy8F/Ip2z83
         K4YA==
X-Forwarded-Encrypted: i=1; AJvYcCWBAQtVdlWQYqen/8XeaJyhD4E0MBtoQv7oW4i7N7xRN1h9O1Yq8xZ9kD0HwoK1ZJ2vFSLlguw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxiUo1AwoOu5UgB0EORsQoMla5szD6HR/GCn6pgiCneH0DbEXZp
	XK0mlXJ45Ih+bInMUZVqC7fOnsYm4eumDb2QzrenRUt672NDodtvDbrlheuaEw3tuF7bZ1x+gWC
	+mFwPXaFS7hl0fi+stO42PbqhdG4XvZn5
X-Gm-Gg: ASbGncuzrbfqBsKBkKgvgCq5b0kltUZUJXrdoV4jMR6e1Dsf8JGTQphPtTEA7rx8KBD
	biC5Gy4URNcvnQYAQ7mBA4osKULeiysA/L97Nb8jwf8stXrKiMcE77hGDX5tQ7JtQ55ekwEnOD1
	oU/UY5nu9wme12FrqUcEKf7n5T3IzgxIUpZRXRoc8FklRE2mwehDqGn8hvAi+g7B//fVHd0BgwF
	BT7DDuFiSHL4TeDVCpvIlwW3CGCp3VqV4gyph1a9j9nK1Vk3QFvzxrapwod+gnjQqCSRKssmhE8
	QIsEZ540ulpjz27gp2sYrzR2de3YeJ052F16PfIQlUv5vJj5PKS4/rsYop4r
X-Google-Smtp-Source: AGHT+IFNQqtGeAZNgxJpSvbJhpdKIJQbyW6N4hLVjLofuP7lseEyzf4l9BWUDL6hyrX4RsN9IVcRDOn08TR6
X-Received: by 2002:a05:600c:1ca4:b0:439:9595:c8f4 with SMTP id 5b1f17b1804b1-4399595cb7bmr11661635e9.0.1739898822483;
        Tue, 18 Feb 2025 09:13:42 -0800 (PST)
Received: from smtpservice.6wind.com ([185.13.181.2])
        by smtp-relay.gmail.com with ESMTP id 5b1f17b1804b1-43964eb6919sm9239635e9.45.2025.02.18.09.13.42;
        Tue, 18 Feb 2025 09:13:42 -0800 (PST)
X-Relaying-Domain: 6wind.com
Received: from bretzel (bretzel.dev.6wind.com [10.17.1.57])
	by smtpservice.6wind.com (Postfix) with ESMTPS id 4FA8A12516;
	Tue, 18 Feb 2025 18:13:42 +0100 (CET)
Received: from dichtel by bretzel with local (Exim 4.94.2)
	(envelope-from <nicolas.dichtel@6wind.com>)
	id 1tkRAE-00F4xJ-2J; Tue, 18 Feb 2025 18:13:42 +0100
From: Nicolas Dichtel <nicolas.dichtel@6wind.com>
To: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: Ido Schimmel <idosch@idosch.org>,
	Andrew Lunn <andrew@lunn.ch>,
	netdev@vger.kernel.org,
	Nicolas Dichtel <nicolas.dichtel@6wind.com>,
	stable@vger.kernel.org
Subject: [PATCH net-next v2 1/2] net: advertise 'netns local' property via netlink
Date: Tue, 18 Feb 2025 18:12:35 +0100
Message-ID: <20250218171334.3593873-2-nicolas.dichtel@6wind.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250218171334.3593873-1-nicolas.dichtel@6wind.com>
References: <20250218171334.3593873-1-nicolas.dichtel@6wind.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since the below commit, there is no way to see if the netns_local property
is set on a device. Let's add a netlink attribute to advertise it.

CC: stable@vger.kernel.org
Fixes: 05c1280a2bcf ("netdev_features: convert NETIF_F_NETNS_LOCAL to dev->netns_local")
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


