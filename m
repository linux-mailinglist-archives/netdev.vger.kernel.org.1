Return-Path: <netdev+bounces-209108-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B41FAB0E530
	for <lists+netdev@lfdr.de>; Tue, 22 Jul 2025 23:03:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E914458062B
	for <lists+netdev@lfdr.de>; Tue, 22 Jul 2025 21:03:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27E6F27E7E1;
	Tue, 22 Jul 2025 21:03:00 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30B1514F9D6;
	Tue, 22 Jul 2025 21:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753218180; cv=none; b=dySiy8ecqwBFfUkunD1Uw5WTBj6jo6RtTbXWBorlEhUTKja3+oEE55U5qH9jjOebdQde6US7mSTWL7D5uo/CEX5JTwS84ydsSCdEbsOeBOoucCSS9n3ziIO/5tDwQK2IgAjsikGvR6aru3Km4bZVof0cknKqblzgOTDzwr0341M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753218180; c=relaxed/simple;
	bh=2jcrmsUMhIjnStACZd80+gw+3X1rP7B4ZqR92ZrO0Ow=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QFgbtQwSOCu2GXUQzd6xtOWuX5R1PodydzYUHR8skggVr8JjyY17dymEMnTLmsmTPziuFSk4iRS3PJojfP518Z5xdVZFVfDBVVhQzhV1+rSVVQnLrPqckEssQL63vd5tWxPfzfsrS1Y/gld9H36R1Tyc97AG4hoZIIyAUjOzAXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-b31e0ead80eso4802343a12.0;
        Tue, 22 Jul 2025 14:02:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753218177; x=1753822977;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Doz7Qgy4SbD2PQgFZBfn1elNOBFUCyhJJzrXMqMsArI=;
        b=GkeYrA9fv8ldWvHHq7EA9YjVLOt+dlFAKElijmnBDe6Kqy36DqJWmDF6UCYZ+kkT0d
         fWGXGnDV8ucl0MHghqA/kd/9Mjb1yyI7f10CJ0N1iTWJC31gK1K1Hhf5pm2A0ctbKJzF
         3CVfe/KltzxB3REreaV7ChkgeJ4EtRW7Ni6HfJkRF8VtBi2QobYPURoIw8kNxX0qIUd2
         MqMyNL9RWJGjn5/6QV85iqgwK2nbfi15x74uG44k+L3xW9phzs18DOAUWpfMtcz9/E2y
         ALOkYbMFxK3JVQeT4mZzIYuvQLyVINVNTGwk6TwgJFhbxCqc8TBEDBXDBE9zbc+zgXmE
         ixZg==
X-Forwarded-Encrypted: i=1; AJvYcCVCJlwyMsbrwgLHBb/hURYeBdfxdT/jRHofUwqNXFPYs2zFQ36qg8FipaWdDYlSnV14U94BShe8Tt+gkl8=@vger.kernel.org
X-Gm-Message-State: AOJu0YygejkDMiWjWh2Tk4be1N2LWyfm9NrPVmy3YbZ3hsjXU2q3pZ86
	QNQ20Y2zaCnke/jBjwj9bLAtVs5ngN2A6KPNpholBNBOkJ/LD1L9t92Y6Ll0
X-Gm-Gg: ASbGnctP3e11STa1OAYnw/7LFr8/B361qjI//wc5WUM4q9oT+OdKCrMs0+qtMqP4VLX
	y+C9gCB5TKr+56AbPs8WczcLQz4koQQrc0uv9dDckQDipZUwZo/v61kyxeYfC7+wgPwI+GVaF1p
	lvDG63humyOwgfzpr6UaUzQ9DDwkn7C0VPfNZqFwGFvVcpmh2TQ1yOWhm2ows+6Eyex0q3mdNar
	xV9LA03omhsS8TbdR7EmEUU+TIIzB0f8kfsr8NQuSysxiOWHAjChAl4SuPig8D4XQHjONcgpUbX
	3Sp6e7KrqS4xE5rRc4pyBOqLaFqd54qM8y9Gax9s+u4E08kdlB7vS4SSl5+j3kYPUOZ50lf0HE3
	G/cYxU/cqTt69ScUM37p+T7D5WUFyeGsebXpeL9EUcedDy5bliqJDdLKvXQh+PUjkxYAQLQ==
X-Google-Smtp-Source: AGHT+IE0ih8kn5NJF5bvEqt5uhwMxuiyeGF+uBLjdJV1KKEvUppvCQZsUUaL4Ko05oVm343ep0Svog==
X-Received: by 2002:a17:903:2342:b0:234:f19a:eead with SMTP id d9443c01a7336-23f981e0aeamr6132715ad.43.1753218177199;
        Tue, 22 Jul 2025 14:02:57 -0700 (PDT)
Received: from localhost (c-73-158-218-242.hsd1.ca.comcast.net. [73.158.218.242])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-23e3b6b4c8esm82111645ad.94.2025.07.22.14.02.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jul 2025 14:02:56 -0700 (PDT)
From: Stanislav Fomichev <sdf@fomichev.me>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	dsahern@kernel.org,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net 1/2] vrf: Drop existing dst reference in vrf_ip6_input_dst
Date: Tue, 22 Jul 2025 14:02:55 -0700
Message-ID: <20250722210256.143208-1-sdf@fomichev.me>
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


