Return-Path: <netdev+bounces-210079-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25E5BB1216B
	for <lists+netdev@lfdr.de>; Fri, 25 Jul 2025 18:00:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5DE3B56747E
	for <lists+netdev@lfdr.de>; Fri, 25 Jul 2025 16:00:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DC881B423C;
	Fri, 25 Jul 2025 16:00:47 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 658E43BBF2;
	Fri, 25 Jul 2025 16:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753459247; cv=none; b=RCojA2wZ6w75PAWpzfpvnEspj9ZCyQxPYuEBumo4BXb6xx5pVGya4wqEIxTZVD/KVC8R+dR81gg8H90e2y0iUecwZZZLDih8Cmp3G0NCvE2hIeImwNckhl8fx1lgljagquOxF9U5SWcnJpPfX41LdIhGRcI3MnQai3SfZWPsZ1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753459247; c=relaxed/simple;
	bh=prWjr9K00ZJsUjWTg+rkTJ++BeLBUFWBiznOta/T9qk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WJVYc7+JiFReP65BvpE3YeWoPWFb6tpvnvYNvbuNhaCXe4E9r9fEo26bfBQy5wNbS1sJZv8HFZ13F2MZJ7Lc3S3bKaO2rqoMfxmKoCgkcoQrtPBWDvw8RO6/ddpB9UITsMhqPa72uNf+1vfELjr6mOlnOvrfjzyQ6MMlq9xsNxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-23c703c471dso35004935ad.0;
        Fri, 25 Jul 2025 09:00:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753459244; x=1754064044;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lXTvfXdoxQ19/qhuhRtwnHTLCuTQzyU8uZOOVdFHHus=;
        b=aNOgpBLTS8ZJkdn5DMBucM4kihihM/EbqyP+LNd8nNtQeW0bJbH1Pw8sl9tVfMdErm
         YF480t0HY+1tQjHyfL5JJi+wyVz8d2l49yV8wPen4UmQGb/P+3o+BplGDezqT9BPxJYX
         5+WmQab2/9aGD0LStDu1HaW2+KYKJTtM65OHFRKR2+p/jzzjFsRaoEW+jgqz6KlRP347
         bUgwk6uiEOMr6yHbBK0cgnVNFuiUET/qwN1Ph1bg4nSWyROCMuxvXewo/esKw3YiW7wM
         G1UX0oQuXR5EX9XUf+C7wgjYxjrBsl8gqz1Lf4O0mr2xEr8LjzwzQ1FgDvV6e7IufsZt
         vWPg==
X-Forwarded-Encrypted: i=1; AJvYcCU2PFtfnEZnRmwznK71tZ4Tnsm2pO7pkYoypb7Vq9q5au2HtFiFeSPNwbJPknH4liL8UoH41uPReZmuoh8=@vger.kernel.org
X-Gm-Message-State: AOJu0YycqeW9/fb6W4B3h6ItHn1ZMzR86/2EwO0/k6aYyzo1jifOArmX
	yTrIJSlmcN4wHCl+kQyDDBM2NfzeLK5TZxcIbU8+qfBbljo1yCtcbSfHSP6H
X-Gm-Gg: ASbGncvBqZLmI67iTZ0lOsWgRxuqJIdZfLVhcyoYSS9AJX1JdQXsoiBKskI9kvVhMAM
	p/LRrGVR/QTVrHe0LpXCeUZtL5Pmtl7mZGP/UTm96Pp4p+4UGcXX16W4l1AQjJnmcV38HoW/Bbe
	7uIZsFJ//HSxFN9afgmBjqyBG8ia6YQ53cOn+vYJdIYUHm3sXim2IzBV8yk6LR/qFg8mdVquR7U
	mvOHRgxnDLrxVc9P3rYxfGQ2mVi33rkjmiTBdMMf0d4HSACDU+0s4INj7c+uOkksSs367c321Zs
	H516Qb1DieASBziUhCIPWgHFkyIFeTDHGFbYtMIyRHhDH5/BzE02TFyp18m8O8S5H1TE3zvxt/F
	//djP0ypoM8VV+q+fxCWJ5/Snbe4Dq/jzy4/BSKJguMo1vk69d03gevXqdpk=
X-Google-Smtp-Source: AGHT+IGOc/H3S/zpYhauczdcRY51PHmmK5Azhoc2BTLiyaUiDWayJtq7f2oFqLVsO2eBcCEHnURX0Q==
X-Received: by 2002:a17:902:ef51:b0:231:c89f:4e94 with SMTP id d9443c01a7336-23fa5dac07dmr104253075ad.21.1753459244097;
        Fri, 25 Jul 2025 09:00:44 -0700 (PDT)
Received: from localhost (c-73-158-218-242.hsd1.ca.comcast.net. [73.158.218.242])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-23fbe512eadsm417215ad.129.2025.07.25.09.00.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Jul 2025 09:00:43 -0700 (PDT)
From: Stanislav Fomichev <sdf@fomichev.me>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	dsahern@kernel.org,
	andrew+netdev@lunn.ch,
	linux-kernel@vger.kernel.org,
	Ido Schimmel <idosch@nvidia.com>
Subject: [PATCH net v3] vrf: Drop existing dst reference in vrf_ip6_input_dst
Date: Fri, 25 Jul 2025 09:00:43 -0700
Message-ID: <20250725160043.350725-1-sdf@fomichev.me>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit ff3fbcdd4724 ("selftests: tc: Add generic erspan_opts matching support
for tc-flower") started triggering the following kmemleak warning:

unreferenced object 0xffff888015fb0e00 (size 512):
  comm "softirq", pid 0, jiffies 4294679065
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 40 d2 85 9e ff ff ff ff  ........@.......
    41 69 59 9d ff ff ff ff 00 00 00 00 00 00 00 00  AiY.............
  backtrace (crc 30b71e8b):
    __kmalloc_noprof+0x359/0x460
    metadata_dst_alloc+0x28/0x490
    erspan_rcv+0x4f1/0x1160 [ip_gre]
    gre_rcv+0x217/0x240 [ip_gre]
    gre_rcv+0x1b8/0x400 [gre]
    ip_protocol_deliver_rcu+0x31d/0x3a0
    ip_local_deliver_finish+0x37d/0x620
    ip_local_deliver+0x174/0x460
    ip_rcv+0x52b/0x6b0
    __netif_receive_skb_one_core+0x149/0x1a0
    process_backlog+0x3c8/0x1390
    __napi_poll.constprop.0+0xa1/0x390
    net_rx_action+0x59b/0xe00
    handle_softirqs+0x22b/0x630
    do_softirq+0xb1/0xf0
    __local_bh_enable_ip+0x115/0x150

vrf_ip6_input_dst unconditionally sets skb dst entry, add a call to
skb_dst_drop to drop any existing entry.

Cc: David Ahern <dsahern@kernel.org>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
Fixes: 9ff74384600a ("net: vrf: Handle ipv6 multicast and link-local addresses")
Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
--
v3: fix commit id
v2: repost without the skb_dst_check
---
 drivers/net/vrf.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/vrf.c b/drivers/net/vrf.c
index 9a4beea6ee0c..3ccd649913b5 100644
--- a/drivers/net/vrf.c
+++ b/drivers/net/vrf.c
@@ -1302,6 +1302,8 @@ static void vrf_ip6_input_dst(struct sk_buff *skb, struct net_device *vrf_dev,
 	struct net *net = dev_net(vrf_dev);
 	struct rt6_info *rt6;
 
+	skb_dst_drop(skb);
+
 	rt6 = vrf_ip6_route_lookup(net, vrf_dev, &fl6, ifindex, skb,
 				   RT6_LOOKUP_F_HAS_SADDR | RT6_LOOKUP_F_IFACE);
 	if (unlikely(!rt6))
-- 
2.50.1


