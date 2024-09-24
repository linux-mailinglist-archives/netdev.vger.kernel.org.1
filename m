Return-Path: <netdev+bounces-129631-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 91EEB984F25
	for <lists+netdev@lfdr.de>; Wed, 25 Sep 2024 01:54:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF8091C2311E
	for <lists+netdev@lfdr.de>; Tue, 24 Sep 2024 23:54:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3715188A06;
	Tue, 24 Sep 2024 23:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EjD+JZbj"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F26880C04;
	Tue, 24 Sep 2024 23:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727222037; cv=none; b=F+8A5bSugt5M9+Pz+L9+rNggdJJtONPSXowwCE66cu+Oe6o6/7LCtsN0hmHMefftrIzes/dwtKj3tKCMkmd/S6W42FKVez8kQdeyj2ZiXlbokyFc2+LoBrdqqVcatAj9P+fO8RugMs+sjdlw1UodiRieOkWi3D0v6ABS/0gy9BY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727222037; c=relaxed/simple;
	bh=ioXQba4GXAbNLNUCL1H1LSF5SCjlINxCoJ0c++sczwE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=srcyveaar/dUzPru+nJRxwd8NMvvIO/4ZALgH0ALNgtjLFtC3BjPcs5Yk+SVwGlXqZp66CFQ5D3cLG8gCrSTKIdmXtAF3k3nanN1qC161HvTbk2J6ALP64FYlQgITG8D3HihIHGzU6NVIEPPoGU9omeujAmn5k33Dr/NqJn+Zc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EjD+JZbj; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2f75c205e4aso62287051fa.0;
        Tue, 24 Sep 2024 16:53:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727222033; x=1727826833; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sJMon77dDufEnoUS5VuyUWRJ/WzBSutK0jQD7Rp3ECQ=;
        b=EjD+JZbjVDoJFCszYpEh7CUoEvxKZ79ldWzVM8eAHeqnTnMCWTI+4NCuOvRXVuW1EH
         eHREt7hvLL9Vke2WAqleqx1EpDX8fp+DuJB5HJQLEH5mNF8zTUnONEg86w9gi90iucH0
         06BT+2PxSgjaqsijgmMvjfvqKGf1Od3SJBjo4qk2EhYxWqSBtMfxlONkMEkHRAG6DgY1
         gXLtHzqKmUEgHPEMiZYczB9STaiZoVk68cHSCZfNEi9SxBvXreMNxdHGs+6u4x5b2E2d
         RVPNuaBIFXq3A/a8qANQ7G2ZopHshPBguBFYKD0cs3CO6r0Oysmw5q8MaN1R72TMeKqJ
         W0UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727222033; x=1727826833;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sJMon77dDufEnoUS5VuyUWRJ/WzBSutK0jQD7Rp3ECQ=;
        b=Y18yw0dZCKQtu7SRz8aUHbs14mpCuNMYYOm4Z6Q3NP9y4xVoyC3cLRLmPZGAJpRMUN
         qNtqCknijQQtaT7Qz5hq/BDhx+c5REnxPePtElhrdccls1dqFtZpKbjKAuGRf+5uBT3A
         D3ZgLs907nyQrKa09eKRCUBBSYAY/OBpUuDE91v7q27iSyfYAkCUJJWQkxv9Vk7NQyd3
         cNQggMqUfGXSU+MyTipzK6BHgwyx5EURdCA13DjUFqMJtkMEQQp/2LFMBtUTkJ2hvbnL
         5oc9ZUDqDjt2rVzGBzXRnObt34c1CSRoWdA7YzoGPlCXKdhFY8XE1kiaWbFmtX3Yt8ld
         nUBw==
X-Forwarded-Encrypted: i=1; AJvYcCX9h1GU2R2tZ72x13kZ55dyZl04kdz0IV6pvyPwk61tceR5vbD2W2C31jg+VeHya55PfKBZXpNxrYMtmYk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6BrR1R75bHxd0eOtIMYnZZ+l8fdTh4/We85YsdZZZHzUcSRmt
	ld3NE2k3hXgILy+KrdTsk/DKP5fxPFEitnM3PoVpKFhoABRN0DB+ozkiStYaME4=
X-Google-Smtp-Source: AGHT+IHyJZboCu/YgJ4RHKXNQDZUxEnV9BPMK7Wh1iSRITXTTVWzaxLma7KdhnbIuFbh8f8GoEjn0Q==
X-Received: by 2002:a2e:bc22:0:b0:2f7:4bf7:e046 with SMTP id 38308e7fff4ca-2f91ca422admr5359201fa.34.1727222032603;
        Tue, 24 Sep 2024 16:53:52 -0700 (PDT)
Received: from dau-work-pc.zonatelecom.ru ([185.149.163.197])
        by smtp.googlemail.com with ESMTPSA id 38308e7fff4ca-2f8d28b5a65sm3583011fa.136.2024.09.24.16.53.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Sep 2024 16:53:51 -0700 (PDT)
From: Anton Danilov <littlesmilingcloud@gmail.com>
To: netdev@vger.kernel.org
Cc: Anton Danilov <littlesmilingcloud@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Shigeru Yoshida <syoshida@redhat.com>,
	Suman Ghosh <sumang@marvell.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net v3] ipv4: ip_gre: Fix drops of small packets in ipgre_xmit
Date: Wed, 25 Sep 2024 02:51:59 +0300
Message-Id: <20240924235158.106062-1-littlesmilingcloud@gmail.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Regression Description:

Depending on the options specified for the GRE tunnel device, small
packets may be dropped. This occurs because the pskb_network_may_pull
function fails due to the packet's insufficient length.

For example, if only the okey option is specified for the tunnel device,
original (before encapsulation) packets smaller than 28 bytes (including
the IPv4 header) will be dropped. This happens because the required
length is calculated relative to the network header, not the skb->head.

Here is how the required length is computed and checked:

* The pull_len variable is set to 28 bytes, consisting of:
  * IPv4 header: 20 bytes
  * GRE header with Key field: 8 bytes

* The pskb_network_may_pull function adds the network offset, shifting
the checkable space further to the beginning of the network header and
extending it to the beginning of the packet. As a result, the end of
the checkable space occurs beyond the actual end of the packet.

Instead of ensuring that 28 bytes are present in skb->head, the function
is requesting these 28 bytes starting from the network header. For small
packets, this requested length exceeds the actual packet size, causing
the check to fail and the packets to be dropped.

This issue affects both locally originated and forwarded packets in
DMVPN-like setups.

How to reproduce (for local originated packets):

  ip link add dev gre1 type gre ikey 1.9.8.4 okey 1.9.8.4 \
          local <your-ip> remote 0.0.0.0

  ip link set mtu 1400 dev gre1
  ip link set up dev gre1
  ip address add 192.168.13.1/24 dev gre1
  ip neighbor add 192.168.13.2 lladdr <remote-ip> dev gre1
  ping -s 1374 -c 10 192.168.13.2
  tcpdump -vni gre1
  tcpdump -vni <your-ext-iface> 'ip proto 47'
  ip -s -s -d link show dev gre1

Solution:

Use the pskb_may_pull function instead the pskb_network_may_pull.

Fixes: 80d875cfc9d3 ("ipv4: ip_gre: Avoid skb_pull() failure in ipgre_xmit()")

Signed-off-by: Anton Danilov <littlesmilingcloud@gmail.com>

---
v2 -> v3 :
- More accurate and detailed explanation
v1 -> v2 :
- Fix the reproduce commands
- Mov out the 'tnl_params' assignment line to the more suitable place
with Eric's suggestion
https://lore.kernel.org/netdev/CANn89iJoMcxe6xAOE=QGfqmOa1p+_ssSr_2y4KUJr-Qap3xk0Q@mail.gmail.com/
---
 net/ipv4/ip_gre.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/ipv4/ip_gre.c b/net/ipv4/ip_gre.c
index 5f6fd382af38..f1f31ebfc793 100644
--- a/net/ipv4/ip_gre.c
+++ b/net/ipv4/ip_gre.c
@@ -662,11 +662,11 @@ static netdev_tx_t ipgre_xmit(struct sk_buff *skb,
 		if (skb_cow_head(skb, 0))
 			goto free_skb;
 
-		tnl_params = (const struct iphdr *)skb->data;
-
-		if (!pskb_network_may_pull(skb, pull_len))
+		if (!pskb_may_pull(skb, pull_len))
 			goto free_skb;
 
+		tnl_params = (const struct iphdr *)skb->data;
+
 		/* ip_tunnel_xmit() needs skb->data pointing to gre header. */
 		skb_pull(skb, pull_len);
 		skb_reset_mac_header(skb);
-- 
2.39.2


