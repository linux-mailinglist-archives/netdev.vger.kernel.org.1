Return-Path: <netdev+bounces-223926-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0954DB7D611
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 14:26:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 807603B4240
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 09:56:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C985343214;
	Wed, 17 Sep 2025 09:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=mcwilliam.dev header.i=@mcwilliam.dev header.b="czVtvfjh"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59CE22F2618
	for <netdev@vger.kernel.org>; Wed, 17 Sep 2025 09:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758102962; cv=none; b=DsngCYXxmH11ksg7VfM5NjjGO8lujBfsL5vbAVxGZs/r9OdNKDLT+Kqz1818S+KWX7VaatsZpVHa5pj27BYlyKc9mG5N4QWRrzscDRvaPMOzrThOklEyUPifvbr85hnNsXdcKgCnQZJrTKcJa/pBhUZZFvRahBNqN7wq2Kfmm3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758102962; c=relaxed/simple;
	bh=JWnlxK4Y9Uda4JEiMBpuQlWtduG1iGtSP68GbP/Zml0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Cy3F7NSlxze+JlyRSR2x8BlhO5oOyCS22cPbR8LSDm02QpCT3tK97QEmFPOs1o9rHKrvO0ygfQ36WuHBFMD81DqGNxuJxH2Hj7y9iqLo/3zl8047+V0Xi8TYq5z5fr/F8Xj//xAoOEdRw7TpNozCHAW92qshxHLJboYazpUuyAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mcwilliam.dev; spf=none smtp.mailfrom=mcwilliam.dev; dkim=fail (0-bit key) header.d=mcwilliam.dev header.i=@mcwilliam.dev header.b=czVtvfjh reason="key not found in DNS"; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mcwilliam.dev
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mcwilliam.dev
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3eb0a50a60aso2260223f8f.3
        for <netdev@vger.kernel.org>; Wed, 17 Sep 2025 02:56:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mcwilliam.dev; s=google; t=1758102958; x=1758707758; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+QDJCwpoWMqkRJDsr148t2NA2bFr9+vK29jXAwBtyaA=;
        b=czVtvfjh/woARsFQWzT47ElaZ53w3oU88jC0Yhc5E+cVAeA5nEzFEe3AEBR9pAx7wd
         H8uzXvbS+gLV7EjdOWwHZVAqEcVVIAl9G+FKVLuMFX2cCqlFjNAXxdaAtscKBa6wKibl
         2r+YFYJbxiBqfLLCOEvZEuz86Mjri9oXWOGqUEemTujbwhva6OFb4V7cJgvrL+ZAwpgQ
         //YVcz75jkYdqhlqL5rtFcO9NIbJ9ufyc0Il4bJIEGxPYzURo4nD1bI1ybU+Y55GIRVG
         3aF8X9rkn+1eNBvTnr4nT5y4D0y8pN8UzCOIcaiSQHIc0NrZFvc171++m/Yat5wwBZA6
         vvyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758102958; x=1758707758;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+QDJCwpoWMqkRJDsr148t2NA2bFr9+vK29jXAwBtyaA=;
        b=jQKMua9RhmXXNNCrvLdFqjWGgad99fTnmrRx+DGu9vPLVxlVCrSk8zLItIuzGk4d9M
         EuAL+52hDf03NPSsv2GP/dMmh3HNJeUPgZ6zhFEsIQVqNLBot60xjgdCz5W0ZCHhAXyT
         4SbU9JUqySS9yMvQMQoKFVqxmz9p4guWBeHAdPGPnvIJszPcwWf2fhLna2TV/ZqpGFgS
         Gzw7vLZ5MDC4Kntje7azz1izt/bcAtgL2B6KfhhkdZJmsMIGPPzLyv07FJNdgpt6YADp
         0dGbDVF0nxEuKP0A2bCX2I/W8aFSsVK9Fj5Mz7AgP5plwIXiyNJgB/OGX+1EOB8104QX
         NNog==
X-Gm-Message-State: AOJu0Yz7nv/YTwEq8sdSh3n0dfv0mUFfX02wmnp4cgsW9zQ2NasYWSll
	yjpPK4IdO6JP3PN7twbF8vHLNn3XMAMIdODVVZlvymsVoD3nFsAUMkLwtCDv3YPK1qY=
X-Gm-Gg: ASbGnctgTzAkS9PliKXK/S2L7S96xh3hpabreUJD68HndC095nYO8bT69UtUkqI9jXr
	jT57jyMgIdg8jXIvaa1R05yUGwJ/J9rjeqAunRYylVsQnnmHjc1XY2nWTOura5EL3IYhSc1gnGj
	5lmoe/pI/RzXCKD4akWBWT3xzSP7FsypQwE0INxBCLBnoSqmIGzIolc3XM0w8aRTWvhuil3umdt
	G36nTCWTXlhXp4/T02DVh7br0v1MiPK8BjYhZCWgkfRrafESLshB6pmYjjNSRlmT5O25Uk2IrjE
	6Yj6hX0wzTasKJqLy0rv4ZFNouTtAIHtEwcOCI9X1NbM/etTlzoTgtGp5RLq5NWEb6+/KDQh+MK
	7iGYyzgBPCst74nmHZxz4/WBpqk69
X-Google-Smtp-Source: AGHT+IH/Dxs5NAork1VD8wVxITDNmqi3V9a6KpKLYt0Zk5/H+rdABtR4GQXWMljUOdKtSb/+MdeNHg==
X-Received: by 2002:a05:6000:3107:b0:3e9:2fea:6795 with SMTP id ffacd0b85a97d-3ecdfa505c4mr1587036f8f.53.1758102958347;
        Wed, 17 Sep 2025 02:55:58 -0700 (PDT)
Received: from el9-dev.local ([146.255.105.3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e91b2519d9sm15951140f8f.22.2025.09.17.02.55.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Sep 2025 02:55:58 -0700 (PDT)
From: Alasdair McWilliam <alasdair@mcwilliam.dev>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	Alasdair McWilliam <alasdair@mcwilliam.dev>,
	Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH net-next v2 1/2] rtnetlink: add needed_{head,tail}room attributes
Date: Wed, 17 Sep 2025 10:55:42 +0100
Message-ID: <20250917095543.14039-1-alasdair@mcwilliam.dev>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Various network interface types make use of needed_{head,tail}room values
to efficiently reserve buffer space for additional encapsulation headers,
such as VXLAN, Geneve, IPSec, etc. However, it is not currently possible
to query these values in a generic way.

Introduce ability to query the needed_{head,tail}room values of a network
device via rtnetlink, such that applications that may wish to use these
values can do so.

For example, Cilium agent iterates over present devices based on user config
(direct routing, vxlan, geneve, wireguard etc.) and in future will configure
netkit in order to expose the needed_{head,tail}room into K8s pods. See
b9ed315d3c4c ("netkit: Allow for configuring needed_{head,tail}room").

Suggested-by: Daniel Borkmann <daniel@iogearbox.net>
Signed-off-by: Alasdair McWilliam <alasdair@mcwilliam.dev>
Reviewed-by: Daniel Borkmann <daniel@iogearbox.net>
---
 v1 -> v2:
 - Corrected attribute types to IFA_REJECT in validation policy.
 - Added additional context in commit log.

 include/uapi/linux/if_link.h |  2 ++
 net/core/rtnetlink.c         | 10 +++++++++-
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/include/uapi/linux/if_link.h b/include/uapi/linux/if_link.h
index 45f56c9f95d9..3b491d96e52e 100644
--- a/include/uapi/linux/if_link.h
+++ b/include/uapi/linux/if_link.h
@@ -379,6 +379,8 @@ enum {
 	IFLA_DPLL_PIN,
 	IFLA_MAX_PACING_OFFLOAD_HORIZON,
 	IFLA_NETNS_IMMUTABLE,
+	IFLA_HEADROOM,
+	IFLA_TAILROOM,
 	__IFLA_MAX
 };
 
diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
index 094b085cff20..d9e68ca84926 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -1326,6 +1326,8 @@ static noinline size_t if_nlmsg_size(const struct net_device *dev,
 	       + rtnl_devlink_port_size(dev)
 	       + rtnl_dpll_pin_size(dev)
 	       + nla_total_size(8)  /* IFLA_MAX_PACING_OFFLOAD_HORIZON */
+	       + nla_total_size(2)  /* IFLA_HEADROOM */
+	       + nla_total_size(2)  /* IFLA_TAILROOM */
 	       + 0;
 }
 
@@ -2091,7 +2093,11 @@ static int rtnl_fill_ifinfo(struct sk_buff *skb,
 	    nla_put_u32(skb, IFLA_CARRIER_UP_COUNT,
 			atomic_read(&dev->carrier_up_count)) ||
 	    nla_put_u32(skb, IFLA_CARRIER_DOWN_COUNT,
-			atomic_read(&dev->carrier_down_count)))
+			atomic_read(&dev->carrier_down_count)) ||
+	    nla_put_u16(skb, IFLA_HEADROOM,
+			READ_ONCE(dev->needed_headroom)) ||
+	    nla_put_u16(skb, IFLA_TAILROOM,
+			READ_ONCE(dev->needed_tailroom)))
 		goto nla_put_failure;
 
 	if (rtnl_fill_proto_down(skb, dev))
@@ -2243,6 +2249,8 @@ static const struct nla_policy ifla_policy[IFLA_MAX+1] = {
 	[IFLA_GSO_IPV4_MAX_SIZE]	= NLA_POLICY_MIN(NLA_U32, MAX_TCP_HEADER + 1),
 	[IFLA_GRO_IPV4_MAX_SIZE]	= { .type = NLA_U32 },
 	[IFLA_NETNS_IMMUTABLE]	= { .type = NLA_REJECT },
+	[IFLA_HEADROOM]		= { .type = NLA_REJECT },
+	[IFLA_TAILROOM]		= { .type = NLA_REJECT },
 };
 
 static const struct nla_policy ifla_info_policy[IFLA_INFO_MAX+1] = {
-- 
2.47.3


