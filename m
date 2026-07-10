Return-Path: <netdev+bounces-306404-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id asQsOL1NUGqkwQIAu9opvQ
	(envelope-from <netdev+bounces-306404-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 03:41:17 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 537B6736880
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 03:41:17 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=asu.edu header.s=google header.b=j7JoLPrI;
	dmarc=pass (policy=none) header.from=asu.edu;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306404-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-306404-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5868830221F2
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 01:41:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58BBE34E744;
	Fri, 10 Jul 2026 01:41:14 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72D0F34A76F
	for <netdev@vger.kernel.org>; Fri, 10 Jul 2026 01:41:12 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783647674; cv=none; b=oswbCMutHxtZs7oTycsrehzRAGKKVVDGQk17Ij6NaeSLLzfIuplevPJcJ4t8V6NQeG1ADgOo7nTOIz2bNkd82qhEVMp6MS6lyJNK6XpSEx9q5N+fM8SBZMndvnyjMweAEAOYa9lYaGx3p/9bL3P5b3Ms+KgVm6ADzYIUEbAyz6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783647674; c=relaxed/simple;
	bh=rueb3mLRc8OyrFqOAhY7oDfe2V0dx6Ap1m+V5a3KYwE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Sr/rT8AFytUO60SYVI+976U7qSg41b0fVpJ0+70ps+YiMWYKGhtqhRHiF5Ok8Nz74qgF4oUFRmp7SMopnnU3Rn0mFd0HfSvcpqPviJ2pBpZc2Iavpjz0OLYzbv9b1HeczO2tBVO3jNUHZHGBa+I7V1dFTiG/Vcq6NMm3IX+pMt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu; spf=pass smtp.mailfrom=asu.edu; dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b=j7JoLPrI; arc=none smtp.client-ip=209.85.214.177
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2ca64c3ce5fso4980955ad.3
        for <netdev@vger.kernel.org>; Thu, 09 Jul 2026 18:41:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asu.edu; s=google; t=1783647672; x=1784252472; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=sH0oioGBZ6GXaO2NQPpwG0e7esu95aZWgdtrtZ7Ds68=;
        b=j7JoLPrIQpSkVOo6WvmZtRrYqExMu14Vi9dcSEa50eA6OVykyvPo9XBBQRQoS0m2z3
         rs0OPYWNvI+SOl+vyWG4zYcntg0WBMIrdQ5HXhng5Of+28b6mhA00CM82+t7Au5u87TY
         BZS50XDD2ShyxV6OcGjBQhbQ9ZgAxsNy7y73XdmhgkqI93XVAVDr6JwkOc/7tYxVRDFZ
         n07wMRI031vdCjsQYX0xMb65XjiuUBki1nnyQb2SzenP8zOM2HErkehKbGXyILNNesjJ
         TX1OZNdHtMHMSbW+l35Db9S/hPudfNN5DTBUktunyWby5rzSZGJrH5tBkAV+i3waGUYK
         ywyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783647672; x=1784252472;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=sH0oioGBZ6GXaO2NQPpwG0e7esu95aZWgdtrtZ7Ds68=;
        b=K/S/0gGz2RaX1DC7TnRU/3WHtA8Ug+EApM/1MYEUK9q3hw3hEfK5T9/3UGxTgvQwwz
         KuuCicIzqBadHggveuCSna3Es9hyd27P/VEUgLFPICUvI7mpM/QnzJDTL/7bk8OLfmOO
         JFhnEfbq3YRLoQqwaOsNk6m1fuhf4EkUUFLept97j/jdh5BU0gT/21sFKGJbsaOl7A/N
         XnlRHo7fdZ6kfufIPmqN73ZbuCIa2b5Dkf2R1qNl5waYcCUcmP8XOj9uW9upEr+J4cMP
         cMwBMqQ7IfPuZIZtnYxOyYejiSJPyQrQ1dMA/Dhwy6lf/oUZ/Sq6eEO/ixRfmqYlDnE3
         Zezw==
X-Gm-Message-State: AOJu0YzAh8UXNEm0vfqr5g7TsR1Vi3iqBxDGtR+ivsl9+iZw/m/uxZeY
	ovY/Wq4oAard4Wsf63jkycRTQ6ApkzMDS8FP6vg/o/qJbp1tbJqYF3E3WJnk/9jFwv6lmqxAqhA
	Z1LIunA==
X-Gm-Gg: AfdE7cnTN6N2u6H+AiaBLmUJfHax41GmPfgzvEJpX3Kbdqzci1gdy1fgtftyOZiindi
	BsJ8zMSG7Cub3M+jd2Bm4/xRUMgBvt0TV0gPVRG4iuLqDROLZPEB8v32oSUFNOqTOJHAK0WwN6W
	+caVtoLxRB5PbdNhJXsHyUTHc0Ojjq2UvdhW9dk4mMHGuRayFx3APdpZtH+cb367n0QlID5/5Yv
	sK3JjazH/g4gh4oAjCz9wcpccl6z8SRQWmt0KhqDyvL76LAU/vXVHLCz/ejOc2xPGQd4Kah2eh5
	XLK5LU3gB2152TA8SP3DGZj65J8lN97afOqaMBMG3oDWsiSWQQJwXYpSHq6xXMg3c+2EXDHnep9
	JIEJji6uIP6f34wHr6y+KMVMVNI56doO83xpQjJHjkkbKcKSIiXSXjJFQeIpdlq2vFR79I6JR+H
	XrkTKPVzhmRKi+2srvZQ==
X-Received: by 2002:a17:902:fc8d:b0:2ca:73aa:b48f with SMTP id d9443c01a7336-2ccea485246mr97809255ad.35.1783647671878;
        Thu, 09 Jul 2026 18:41:11 -0700 (PDT)
Received: from xiang.tailc0aff1.ts.net ([20.171.14.70])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13b84d6ce15sm1640698c88.5.2026.07.09.18.41.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 18:41:11 -0700 (PDT)
From: "Xiang Mei (Microsoft)" <xmei5@asu.edu>
To: Jakub Kicinski <kuba@kernel.org>,
	Taehee Yoo <ap420073@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	AutonomousCodeSecurity@microsoft.com,
	tgopinath@linux.microsoft.com,
	kys@microsoft.com,
	"Xiang Mei (Microsoft)" <xmei5@asu.edu>
Subject: [PATCH net] amt: refresh cached IP header pointers after MLD/IGMP checks
Date: Fri, 10 Jul 2026 01:41:09 +0000
Message-ID: <20260710014109.536177-1-xmei5@asu.edu>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[asu.edu,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[asu.edu:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:kuba@kernel.org,m:ap420073@gmail.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:AutonomousCodeSecurity@microsoft.com,m:tgopinath@linux.microsoft.com,m:kys@microsoft.com,m:xmei5@asu.edu,m:andrew@lunn.ch,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-306404-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[xmei5@asu.edu,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,gmail.com,lunn.ch,davemloft.net,google.com,redhat.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[xmei5@asu.edu,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[asu.edu:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 537B6736880

amt_dev_xmit() and amt_update_handler() cache iph/ip6h before calling
ip_mc_check_igmp() / ipv6_mc_check_mld(), which may pskb_may_pull() a
non-linear skb and reallocate skb->head. The stale pointers are then
read (amt_dev_xmit: group.ip{4,6} = iph/ip6h->daddr; amt_update_handler:
ip{,v6}_eth_mc_map()), a slab-use-after-free. tx is reachable by an
unprivileged user whose amt device has SG enabled; rx by a tunnel peer
sending a membership update fragmented across several IP fragments.

Reload iph/ip6h after the check returns, like commit f0e42f0c4337
("ipv6: sit: reload inner IPv6 header after GSO offloads").

tx path:
  BUG: KASAN: slab-use-after-free in amt_dev_xmit (drivers/net/amt.c:1238)
  Read of size 16 by task exploit
   amt_dev_xmit (drivers/net/amt.c:1238)
   dev_hard_start_xmit (net/core/dev.c:3905)
   __dev_queue_xmit (net/core/dev.c:4872)
   packet_sendmsg (net/packet/af_packet.c:3114)

rx path:
  BUG: KASAN: slab-use-after-free in amt_rcv (drivers/net/amt.c:2530)
  Read of size 4 by task exploit
   amt_rcv (drivers/net/amt.c:2530)
   udp_queue_rcv_one_skb (net/ipv4/udp.c:2388)
   ip_local_deliver (net/ipv4/ip_input.c:262)
   ip_rcv (net/ipv4/ip_input.c:612)

Fixes: cbc21dc1cfe9 ("amt: add data plane of amt interface")
Fixes: bc54e49c140b ("amt: add multicast(IGMP) report message handler")
Fixes: b75f7095d4d4 ("amt: add mld report message handler")
Reported-by: AutonomousCodeSecurity@microsoft.com
Signed-off-by: Xiang Mei (Microsoft) <xmei5@asu.edu>
---
 drivers/net/amt.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/amt.c b/drivers/net/amt.c
index 951dd10e192b..8bc61c539b0a 100644
--- a/drivers/net/amt.c
+++ b/drivers/net/amt.c
@@ -1210,6 +1210,7 @@ static netdev_tx_t amt_dev_xmit(struct sk_buff *skb, struct net_device *dev)
 		} else {
 			data = true;
 		}
+		iph = ip_hdr(skb);
 		v6 = false;
 		group.ip4 = iph->daddr;
 #if IS_ENABLED(CONFIG_IPV6)
@@ -1234,6 +1235,7 @@ static netdev_tx_t amt_dev_xmit(struct sk_buff *skb, struct net_device *dev)
 		} else {
 			data = true;
 		}
+		ip6h = ipv6_hdr(skb);
 		v6 = true;
 		group.ip6 = ip6h->daddr;
 #endif
@@ -2498,6 +2500,7 @@ static bool amt_update_handler(struct amt_dev *amt, struct sk_buff *skb)
 			netdev_dbg(amt->dev, "Invalid IGMP\n");
 			return true;
 		}
+		iph = ip_hdr(skb);
 
 		spin_lock_bh(&tunnel->lock);
 		amt_igmp_report_handler(amt, skb, tunnel);
@@ -2517,6 +2520,7 @@ static bool amt_update_handler(struct amt_dev *amt, struct sk_buff *skb)
 			netdev_dbg(amt->dev, "Invalid MLD\n");
 			return true;
 		}
+		ip6h = ipv6_hdr(skb);
 
 		spin_lock_bh(&tunnel->lock);
 		amt_mld_report_handler(amt, skb, tunnel);
-- 
2.43.0


