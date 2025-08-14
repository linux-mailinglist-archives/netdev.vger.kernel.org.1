Return-Path: <netdev+bounces-213678-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E4F44B2637F
	for <lists+netdev@lfdr.de>; Thu, 14 Aug 2025 12:57:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 518379E420B
	for <lists+netdev@lfdr.de>; Thu, 14 Aug 2025 10:53:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E2643019B2;
	Thu, 14 Aug 2025 10:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hh02dsvU"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58E2A2FAC13
	for <netdev@vger.kernel.org>; Thu, 14 Aug 2025 10:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755168701; cv=none; b=RYsGDm2gtg5hM8WDnJNHNk5s3wYuI3u8fopLsP3DNzoeaFQDe1zLyRjNxzzSHo818u1nG3sjd3JWdsl1HPvCtEG8OWCtGda7yRd7NakzvEo+xnPglMuZ/t8Z13C5JsrHIT/D9HncEWnvbH9qPYin1KXqautlDv44+DhCMw4HciY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755168701; c=relaxed/simple;
	bh=GaSMSf5BKNdgboVPsZjIelFK7wKUZSTPH/TUzxyfrCc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=m1XtDJxagZHg1mRwXDJTvaQLTi9zNG1EC7bao4WbgMpe61T48rZIEnJhlr6yGwkqIM4FEXuGz9KYIzDkxR+RyauJ3fwE6Iq/ocVoLXeRsmBhUgQCLXMr75fcsF+xrTQnVAhPURRToDWvN99+WijyJvyjRktpSHCPntwAQJgEboQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hh02dsvU; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755168698;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Hr+S+RdcUdCjY81TNbR8gBF/gV+0LEjT0MAWN+wcwQI=;
	b=hh02dsvUZqI/+F9Nc1WDPkPaEf3ki6lpQdsMk0S60D4wXbzycebj4mXUuy4LWqsUOiLGme
	JXhvX2PXvdJNm7kGhGwX6Utd2pJSu6+HWkpsExuwcNtikfntedEeeVT1fRBkX/JrkvV/hn
	2cA9X04RYFxYz0zUqdzFg00b2yPEfTY=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-688-fVGXHsMhMsWeXoROBWrzSQ-1; Thu,
 14 Aug 2025 06:51:33 -0400
X-MC-Unique: fVGXHsMhMsWeXoROBWrzSQ-1
X-Mimecast-MFC-AGG-ID: fVGXHsMhMsWeXoROBWrzSQ_1755168691
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 20C62180036E;
	Thu, 14 Aug 2025 10:51:31 +0000 (UTC)
Received: from jramaseu-thinkpadt14gen5.tpbc.csb (unknown [10.43.3.226])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id A8AC2180044F;
	Thu, 14 Aug 2025 10:51:26 +0000 (UTC)
From: Jakub Ramaseuski <jramaseu@redhat.com>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org,
	horms@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	sdf@fomichev.me,
	ahmed.zaki@intel.com,
	aleksander.lobakin@intel.com,
	benoit.monin@gmx.fr,
	willemb@google.com,
	Jakub Ramaseuski <jramaseu@redhat.com>,
	Tianhao Zhao <tizhao@redhat.com>,
	Michal Schmidt <mschmidt@redhat.com>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Subject: [PATCH net v3] net: gso: Forbid IPv6 TSO with extensions on devices with only IPV6_CSUM
Date: Thu, 14 Aug 2025 12:51:19 +0200
Message-ID: <20250814105119.1525687-1-jramaseu@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
net: mask NETIF_F_IPV6_CSUM flag on irregular packet header size
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

When performing Generic Segmentation Offload (GSO) on an IPv6 packet that
contains extension headers, the kernel incorrectly requests checksum offload
if the egress device only advertises NETIF_F_IPV6_CSUM feature, which has 
a strict contract: it supports checksum offload only for plain TCP or UDP 
over IPv6 and explicitly does not support packets with extension headers.
The current GSO logic violates this contract by failing to disable the feature
for packets with extension headers, such as those used in GREoIPv6 tunnels.

This violation results in the device being asked to perform an operation
it cannot support, leading to a `skb_warn_bad_offload` warning and a collapse
of network throughput. While device TSO/USO is correctly bypassed in favor
of software GSO for these packets, the GSO stack must be explicitly told not 
to request checksum offload.

Mask NETIF_F_IPV6_CSUM, NETIF_F_TSO6 and NETIF_F_GSO_UDP_L4
in gso_features_check if the IPv6 header contains extension headers to compute
checksum in software.

The exception is a BIG TCP extension, which, as stated in commit
68e068cabd2c6c53 ("net: reenable NETIF_F_IPV6_CSUM offload for BIG TCP packets"):
"The feature is only enabled on devices that support BIG TCP TSO.
The header is only present for PF_PACKET taps like tcpdump,
and not transmitted by physical devices."

kernel log output (truncated):
WARNING: CPU: 1 PID: 5273 at net/core/dev.c:3535 skb_warn_bad_offload+0x81/0x140
...
Call Trace:
 <TASK>
 skb_checksum_help+0x12a/0x1f0
 validate_xmit_skb+0x1a3/0x2d0
 validate_xmit_skb_list+0x4f/0x80
 sch_direct_xmit+0x1a2/0x380
 __dev_xmit_skb+0x242/0x670
 __dev_queue_xmit+0x3fc/0x7f0
 ip6_finish_output2+0x25e/0x5d0
 ip6_finish_output+0x1fc/0x3f0
 ip6_tnl_xmit+0x608/0xc00 [ip6_tunnel]
 ip6gre_tunnel_xmit+0x1c0/0x390 [ip6_gre]
 dev_hard_start_xmit+0x63/0x1c0
 __dev_queue_xmit+0x6d0/0x7f0
 ip6_finish_output2+0x214/0x5d0
 ip6_finish_output+0x1fc/0x3f0
 ip6_xmit+0x2ca/0x6f0
 ip6_finish_output+0x1fc/0x3f0
 ip6_xmit+0x2ca/0x6f0
 inet6_csk_xmit+0xeb/0x150
 __tcp_transmit_skb+0x555/0xa80
 tcp_write_xmit+0x32a/0xe90
 tcp_sendmsg_locked+0x437/0x1110
 tcp_sendmsg+0x2f/0x50
...
skb linear:   00000000: e4 3d 1a 7d ec 30 e4 3d 1a 7e 5d 90 86 dd 60 0e
skb linear:   00000010: 00 0a 1b 34 3c 40 20 11 00 00 00 00 00 00 00 00
skb linear:   00000020: 00 00 00 00 00 12 20 11 00 00 00 00 00 00 00 00
skb linear:   00000030: 00 00 00 00 00 11 2f 00 04 01 04 01 01 00 00 00
skb linear:   00000040: 86 dd 60 0e 00 0a 1b 00 06 40 20 23 00 00 00 00
skb linear:   00000050: 00 00 00 00 00 00 00 00 00 12 20 23 00 00 00 00
skb linear:   00000060: 00 00 00 00 00 00 00 00 00 11 bf 96 14 51 13 f9
skb linear:   00000070: ae 27 a0 a8 2b e3 80 18 00 40 5b 6f 00 00 01 01
skb linear:   00000080: 08 0a 42 d4 50 d5 4b 70 f8 1a

Fixes: 04c20a9356f283da ("net: skip offload for NETIF_F_IPV6_CSUM if ipv6 header contains extension")
Reported-by: Tianhao Zhao <tizhao@redhat.com>
Suggested-by: Michal Schmidt <mschmidt@redhat.com>
Suggested-by: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Signed-off-by: Jakub Ramaseuski <jramaseu@redhat.com>
---
---
 net/core/dev.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/net/core/dev.c b/net/core/dev.c
index b28ce68830b2b..1d8a4d1da911e 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -3778,6 +3778,18 @@ static netdev_features_t gso_features_check(const struct sk_buff *skb,
 		if (!(iph->frag_off & htons(IP_DF)))
 			features &= ~NETIF_F_TSO_MANGLEID;
 	}
+
+	/* NETIF_F_IPV6_CSUM does not support IPv6 extension headers,
+	 * so neither does TSO that depends on it.
+	 */
+	if (features & NETIF_F_IPV6_CSUM &&
+	    (skb_shinfo(skb)->gso_type & SKB_GSO_TCPV6 ||
+	     (skb_shinfo(skb)->gso_type & SKB_GSO_UDP_L4 &&
+	      vlan_get_protocol(skb) == htons(ETH_P_IPV6))) &&
+	    skb_transport_header_was_set(skb) &&
+	    skb_network_header_len(skb) != sizeof(struct ipv6hdr) &&
+	    !ipv6_has_hopopt_jumbo(skb))
+		features &= ~(NETIF_F_IPV6_CSUM | NETIF_F_TSO6 | NETIF_F_GSO_UDP_L4);
 
 	return features;
 }
-- 
2.50.1


