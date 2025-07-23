Return-Path: <netdev+bounces-209545-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35292B0FD13
	for <lists+netdev@lfdr.de>; Thu, 24 Jul 2025 00:46:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 191993B8567
	for <lists+netdev@lfdr.de>; Wed, 23 Jul 2025 22:46:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70695221F03;
	Wed, 23 Jul 2025 22:46:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8193E1ADC93;
	Wed, 23 Jul 2025 22:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753310789; cv=none; b=Oerh7HchkETIDDA/n7aVPbi4GJbXhg/gZbIcs9VxvGsREQaNJVaUSg+JmtpB1Kv/p7Kdi9KtZ7D3fgbErZGOC+bFhozCADa6/kgid0OZ7EvmS0HFXDLXJhP/8JsqbbGFE536IG+VPj8qWyXdROXjuTm4pz14BaObQqFbeYYRhoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753310789; c=relaxed/simple;
	bh=2jcrmsUMhIjnStACZd80+gw+3X1rP7B4ZqR92ZrO0Ow=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pEV5+7bVsgPdLvWSS7L+zFXexpW2Uyy2GOGWR0qaI+IHNfNYtKhjoTVwhalbtI+/knL1D4fw/yyt/UzrwcmuM6zNbekLFBjgeGh7rxF/RqfjqOTYRrLovrXgxnWs4sx49i/fIAAZ+8NLI716nuREcQFXBr72ZdSlTfYxqLQxbpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-311bd8ce7e4so289553a91.3;
        Wed, 23 Jul 2025 15:46:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753310787; x=1753915587;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Doz7Qgy4SbD2PQgFZBfn1elNOBFUCyhJJzrXMqMsArI=;
        b=gNTKfZl8+IPaCXULK8R1YBYO6PjV21UE+BTigvGh1JhjMYOepZc98NxsZ4qgyQ8CAn
         g+T7BmOI9gQAmkkix6bl1aLwZonJbBwQcALXebz5qoSZmXvPsiTt1KJTe4y9kqyVPQDs
         sAcnerYZBd6/DD23/eVYLMxp+ngflesljFynAHeRj2qPcJqx3+OKSPYPto/THYdSyTma
         eIuzqg3GRWWZhMCDPYAgZ1GwMIBNFV3gUyO6W3pQFeZgM+8bwuO0zJXvOu75jscE1aOe
         NPPgfmR2UprJcMG5oGW6rFy+ZLHUHTH9tmBjvG0HP7Gas8qORcwMQr7m7RtDWnvbctIr
         O8fg==
X-Forwarded-Encrypted: i=1; AJvYcCXtrHhLV7OUeNMlbu7tkEyZe4x1ZwN+0R9ouOiNe/BFwKhIk/Uydsl9wRaYukVTjT9sdOpVdwckMw53Png=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMUmQsSNwzEdMwstHWMDg97EFn2uju2kJsLh32JRlqkxxdy029
	Ezn9BOJ6c47zMpickdE4sW+dsUcupKZPfcSlTXtauJTNjnRJ32EIig1/Yo8L
X-Gm-Gg: ASbGncuNVz48Z7oS4cvusoCF5Ndtf5Jb4KsWwQT48JPJtXv+7oJYsuUo7O0o9+1bHt8
	CLWzA8/786FPuQcgA8rsvV30GBdUkhj6WGjzAz0PDyhI5YZSiNaCi/6p6wBpHUZTsTGQphIJrcx
	QpwM2b9/JtbmyYuTlJJKwQGyG5MbXvbk4HriaKg+lVjW3QfuE3WHkSg6CIlQ94vnlb9suQnnO06
	rBC1Ifm0AbwN1fXoyBc212eLfJqOvSdbQQSNSe9B7SaDsNPlv5z2odcl69hUIfVAI1SC+p9KQlS
	I5vxR/+uJdFziJCChHP/Y27RPQs7zTQz/2i98tVbgHiy/vklv7hrLuYF7MzYiV9uU5vZZ3v2FUQ
	JOe8jxnEH17TyNsRO07gznsbvkJSoidvfGUh1F+H7PRWch4azpWtUDDP2MXI=
X-Google-Smtp-Source: AGHT+IGo1KRNJBNeJX90xQJQCmbmpdOhCxtmsnLyJTQqjWshKf9eRJAmiaIVnoXFX22QLyIm1ssupQ==
X-Received: by 2002:a17:90b:5448:b0:312:25dd:1c86 with SMTP id 98e67ed59e1d1-31e507c38f0mr7244156a91.18.1753310786506;
        Wed, 23 Jul 2025 15:46:26 -0700 (PDT)
Received: from localhost (c-73-158-218-242.hsd1.ca.comcast.net. [73.158.218.242])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-31e51b9329csm2464562a91.32.2025.07.23.15.46.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jul 2025 15:46:25 -0700 (PDT)
From: Stanislav Fomichev <sdf@fomichev.me>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	dsahern@kernel.org,
	andrew+netdev@lunn.ch,
	linux-kernel@vger.kernel.org
Subject: [PATCH net v2] vrf: Drop existing dst reference in vrf_ip6_input_dst
Date: Wed, 23 Jul 2025 15:46:25 -0700
Message-ID: <20250723224625.1340224-1-sdf@fomichev.me>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 8fba0fc7b3de ("selftests: tc: Add generic erspan_opts matching support
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
Fixes: 9ff74384600a ("net: vrf: Handle ipv6 multicast and link-local addresses")
Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
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


