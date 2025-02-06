Return-Path: <netdev+bounces-163600-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E391A2AE30
	for <lists+netdev@lfdr.de>; Thu,  6 Feb 2025 17:52:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8489F188BCD8
	for <lists+netdev@lfdr.de>; Thu,  6 Feb 2025 16:52:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E6F71A5B9F;
	Thu,  6 Feb 2025 16:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b="EE4+oooB"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f100.google.com (mail-ej1-f100.google.com [209.85.218.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FDB023537C
	for <netdev@vger.kernel.org>; Thu,  6 Feb 2025 16:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738860702; cv=none; b=OFudQjtAHbFXlh9EjuanG8Y5b7RKk7wlPut1cvfIpuINi9rq1GsQObnBjBW6IQQ6HTAiCwtX17toD27nkNZYMK7dwcuNykVi3U2le+0SoWanl2FYlq91MYHxC91LB5VAP0Ihwz6fxx2BXZ/rlEnTE4mQEYLlgJJuHQBe39hSbsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738860702; c=relaxed/simple;
	bh=qhfrF8rOfWi9BMPzEW1K1lhSoKZWMdMKypOVywawQxA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cWW7Gemp/5hvBJf3d2gbraK2dmTQpkY2AEGch0ON83CdKnpA2R7V9w6Cg60tKt+rfDjd6r/XJvTSjbnvL6k7pwMkf3WXVazzCpKDbwD1ihdKt1gx8bxWjXujEosTT+sdG8YG186lj32sPw/tyl0iLVos3F3+XcetOTH933RdyDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com; spf=pass smtp.mailfrom=6wind.com; dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b=EE4+oooB; arc=none smtp.client-ip=209.85.218.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=6wind.com
Received: by mail-ej1-f100.google.com with SMTP id a640c23a62f3a-ab785b76f0aso2676166b.3
        for <netdev@vger.kernel.org>; Thu, 06 Feb 2025 08:51:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google; t=1738860698; x=1739465498; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8uTxvJx8XP29oBONkH9ilUZCu0gHXNxSpo7+j7SmAsw=;
        b=EE4+oooBS1/xZ4kM6ROhRdy8yyl4D4A9HA7OyKwZCn98r4+ga9PCu060nbnq2IMB+P
         oQxa3/EZN5335daf1U9sUi1weHi7ZvyLHy07FpHwMN4DwNMDXgFIYjJl2prV3/LqxXSV
         Kj8tLFLDvbUGSUBWEVQp3HR/vgx/B22z0a1RS2A81my5PnQqBQdfeh3Eg04rSRIsgPUR
         Tcvz2NF4JrM4pzVbxXxfy1IetFUK8llbXSFlRqfYTgD3921xpEmEm6k8A7ZXSLHHZl2b
         04kw2LKb6fAVLg71XSW+9zbHIYGmVrOrdY/9w5nRILIopEzNLmi6exMFoW4zjonrpPIo
         82iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738860698; x=1739465498;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8uTxvJx8XP29oBONkH9ilUZCu0gHXNxSpo7+j7SmAsw=;
        b=SX0qdHYcEZdnFx8gl2Ox5pa8DyDrAWOM7/nXDWuQ3oqFrONo6cnGiH+U7pAuwofmdy
         SJEcD6YwGXIx+Rye2xzSb2dp8sYDZPEph+6dZnzyVyz2LqFAjYeQX8vlTU3fYc9uzV1/
         5JgYqghqbP+ffnNnekkLkJ0Nr5MZhikFhKeoMDBR/fGhWoyg0RP0Ji971qrbJuvxo9Wv
         hCpZL2cLqmEJdaGbHqJt4fzAYRMA21nORAsUnZMOR0FypG4Cn7otqcHDCh84Mhz7BOcS
         KYJJEaGJGe0qrjeLDERMH0w4fwR2pdFTHhb6vwC+ufZZS91aqsNG6K8CoNyxy42GAa/E
         IPmQ==
X-Gm-Message-State: AOJu0YwDAMOW+8YIMsYjHeAPLQQAJeRkLMYPPw8dvtngRciB8BgWFMhC
	0pYSI43rlQNUxbkHpWPHgG4Kq38BerXDkU5YOghBZSqzg5n692B/EjN2cRfEmamqQ//+EDpNSVe
	YKkp3sJsLndyt0HN/7LtMvmB0lTKc7A+j
X-Gm-Gg: ASbGnct1vQBdiDkoCHLBni0NvVmfn/KF5npB/UmDLSHnmomUdogxjt7uF6yfikieHWE
	AA3Znf3juwr5h9DQfXwUdmjX4x9EBfscZ0f6u8xVBwdkDMyreP+tQqNBDsY9UD5gzKEJhqyAeJH
	O/XilA9TmNZrrvS55rx9Xjv7KxzXjfH6kn0ZSoQQmui5k+vBWyBB0ObcUSVLBVZlCL2p4khHQUL
	wQkzSlImvGZB8kvfrdOcJnh3BNOq5QbXtfALZnEgXXvPCp4FY4TK7BGGAuAHOI0bW75AusYrfJZ
	qHJe2/gMhcpYit0h8oVVgPmKVDja9GUUM6rxptjGCNTwHKaqMT/cysn4uN0+
X-Google-Smtp-Source: AGHT+IGAx0Q/H2eQHoYeawfbxSgrNNhWSWM7mPVrJrWkJiQzRfOQKr8QsT0MnRmkOORHMt0dDZNv2kJwAjCq
X-Received: by 2002:a17:907:d9f:b0:a9e:80ed:5cc6 with SMTP id a640c23a62f3a-ab75e35d3femr321004666b.13.1738860698137;
        Thu, 06 Feb 2025 08:51:38 -0800 (PST)
Received: from smtpservice.6wind.com ([185.13.181.2])
        by smtp-relay.gmail.com with ESMTP id a640c23a62f3a-ab77332cb11sm5164966b.172.2025.02.06.08.51.38;
        Thu, 06 Feb 2025 08:51:38 -0800 (PST)
X-Relaying-Domain: 6wind.com
Received: from bretzel (bretzel.dev.6wind.com [10.17.1.57])
	by smtpservice.6wind.com (Postfix) with ESMTPS id D26731CD32;
	Thu,  6 Feb 2025 17:51:37 +0100 (CET)
Received: from dichtel by bretzel with local (Exim 4.94.2)
	(envelope-from <nicolas.dichtel@6wind.com>)
	id 1tg56H-00CA04-JR; Thu, 06 Feb 2025 17:51:37 +0100
From: Nicolas Dichtel <nicolas.dichtel@6wind.com>
To: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: netdev@vger.kernel.org,
	Nicolas Dichtel <nicolas.dichtel@6wind.com>,
	stable@vger.kernel.org
Subject: [PATCH net 1/2] net: advertise 'netns local' property via netlink
Date: Thu,  6 Feb 2025 17:50:26 +0100
Message-ID: <20250206165132.2898347-2-nicolas.dichtel@6wind.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250206165132.2898347-1-nicolas.dichtel@6wind.com>
References: <20250206165132.2898347-1-nicolas.dichtel@6wind.com>
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
 include/uapi/linux/if_link.h | 1 +
 net/core/rtnetlink.c         | 3 +++
 2 files changed, 4 insertions(+)

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
index d1e559fce918..5032e65b8faa 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -1287,6 +1287,7 @@ static noinline size_t if_nlmsg_size(const struct net_device *dev,
 	       + nla_total_size(4) /* IFLA_TSO_MAX_SEGS */
 	       + nla_total_size(1) /* IFLA_OPERSTATE */
 	       + nla_total_size(1) /* IFLA_LINKMODE */
+	       + nla_total_size(1) /* IFLA_NETNS_LOCAL */
 	       + nla_total_size(4) /* IFLA_CARRIER_CHANGES */
 	       + nla_total_size(4) /* IFLA_LINK_NETNSID */
 	       + nla_total_size(4) /* IFLA_GROUP */
@@ -2041,6 +2042,7 @@ static int rtnl_fill_ifinfo(struct sk_buff *skb,
 		       netif_running(dev) ? READ_ONCE(dev->operstate) :
 					    IF_OPER_DOWN) ||
 	    nla_put_u8(skb, IFLA_LINKMODE, READ_ONCE(dev->link_mode)) ||
+	    nla_put_u8(skb, IFLA_NETNS_LOCAL, dev->netns_local) ||
 	    nla_put_u32(skb, IFLA_MTU, READ_ONCE(dev->mtu)) ||
 	    nla_put_u32(skb, IFLA_MIN_MTU, READ_ONCE(dev->min_mtu)) ||
 	    nla_put_u32(skb, IFLA_MAX_MTU, READ_ONCE(dev->max_mtu)) ||
@@ -2229,6 +2231,7 @@ static const struct nla_policy ifla_policy[IFLA_MAX+1] = {
 	[IFLA_ALLMULTI]		= { .type = NLA_REJECT },
 	[IFLA_GSO_IPV4_MAX_SIZE]	= NLA_POLICY_MIN(NLA_U32, MAX_TCP_HEADER + 1),
 	[IFLA_GRO_IPV4_MAX_SIZE]	= { .type = NLA_U32 },
+	[IFLA_NETNS_LOCAL]	= { .type = NLA_U8 },
 };
 
 static const struct nla_policy ifla_info_policy[IFLA_INFO_MAX+1] = {
-- 
2.47.1


