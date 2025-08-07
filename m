Return-Path: <netdev+bounces-212057-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE17CB1D93E
	for <lists+netdev@lfdr.de>; Thu,  7 Aug 2025 15:42:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B89AC16EF1B
	for <lists+netdev@lfdr.de>; Thu,  7 Aug 2025 13:42:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 082CD25C81F;
	Thu,  7 Aug 2025 13:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CzHm3B9K"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F815191F84
	for <netdev@vger.kernel.org>; Thu,  7 Aug 2025 13:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754574154; cv=none; b=AoRuD/pbSIeED5fgy+L+r6QxvpoaZRi4Whvx1f6HVBcXtzz9dGdkK9dN+/ax6MpZ+fB6QmFWLUQEKo69+x93GFoDVwt9CFsJ4qITeIC4o7O6wmVbKYECsuxaRE/OT6fkx4YPC+/gOFyWgaB1YAonCdODDwz4jZ3Ie5e9mEH9bMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754574154; c=relaxed/simple;
	bh=GvJfhzlulC+BDBGj8y0s9+f+ajpo1xlnxsxPSHrv2vY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Vlbj3a5vvaC2skVeTKv5JyT1+DRiHiJbCbcGxGpFLrn5rxTGS1wOO3z0oROpIMoR296o5dTsCg4Qa6CMo9TZA2Fwj/6ddc8xmnbZnHE1MUC61M7ExhqjZU9C6CjIWGvIlcjyzf/ruDMhCkDBm2tHexfmiJDBz9oGLLakTSq1Sus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CzHm3B9K; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754574151;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ritNS/LACz5zZTDC9OonsqyxQ/9g3SvnETW1YwGikxE=;
	b=CzHm3B9KzctQpriV/pO5zXrO2Xda+UTu1TAFZO7xX80E6H/te1SrsuPF46J99ck8pBKsHg
	/FCDSj3oIN+t6eDKa9b4QUVnculZJiH5CBydmDEoUYBHFDgTd1jGSRheQ8oW/WLUCv8rmF
	VVz3TRrMXMFwiD2vOV0dRQj2sWh9ztY=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-34-KwNfLP1TMgSPsJW3m9-2OA-1; Thu,
 07 Aug 2025 09:42:28 -0400
X-MC-Unique: KwNfLP1TMgSPsJW3m9-2OA-1
X-Mimecast-MFC-AGG-ID: KwNfLP1TMgSPsJW3m9-2OA_1754574147
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C1B4318004D4;
	Thu,  7 Aug 2025 13:42:27 +0000 (UTC)
Received: from jramaseu-thinkpadt14gen5.tpbc.com (unknown [10.44.32.77])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id E95B119560AD;
	Thu,  7 Aug 2025 13:42:24 +0000 (UTC)
From: Jakub Ramaseuski <jramaseu@redhat.com>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org,
	horms@kernel.org,
	pabeni@redhat.com,
	Jakub Ramaseuski <jramaseu@redhat.com>,
	Tianhao Zhao <tizhao@redhat.com>,
	Michal Schmidt <mschmidt@redhat.com>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Subject: [PATCH net v2] net: mask NETIF_F_IPV6_CSUM flag on irregular packet header size
Date: Thu,  7 Aug 2025 15:41:50 +0200
Message-ID: <20250807134150.497553-1-jramaseu@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On any driver that advertises NETIF_F_IP_CSUM and NETIF_F_IPV6_CSUM but
not the superseding NETIF_F_HW_CSUM (e.g., ice/bnxt_en), the kernel
incorrectly attempts GSO on IPv6 packets with extension headers.
Because the NETIF_F_IPV6_CSUM feature is incompatible with these
headers, the failure results in a `skb_warn_bad_offload` warning and
a collapse of throughput, as observed with GREoIPv6 traffic.

Mask NETIF_F_IPV6_CSUM, NETIF_F_TSO6 and NETIF_F_GSO_UDP_L4
in gso_features_check if the IPv6 header contains extension headers.

The exception is a BIG TCP extension, which, as stated in commit
68e068cabd2c6c53 (net: reenable NETIF_F_IPV6_CSUM offload for BIG TCP packets):
"The feature is only enabled on devices that support BIG TCP TSO.
The header is only present for PF_PACKET taps like tcpdump,
and not transmitted by physical devices."

kernel log output (truncated):
WARNING: CPU: 1 PID: 5273 at net/core/dev.c:3535 skb_warn_bad_offload+0x81/0x140
...
Call Trace:
 <TASK>
 skb_checksum_help+0x12a/0x1f0
 ? netif_skb_features+0xc1/0x2e0
 validate_xmit_skb+0x1a3/0x2d0
 validate_xmit_skb_list+0x4f/0x80
 sch_direct_xmit+0x1a2/0x380
 __dev_xmit_skb+0x242/0x670
 __dev_queue_xmit+0x3fc/0x7f0
 ? srso_alias_return_thunk+0x5/0xfbef5
 ? ip6_rt_copy_init+0xf0/0x290
 ? srso_alias_return_thunk+0x5/0xfbef5
 ? selinux_ip_postroute+0x1c5/0x420
 ? srso_alias_return_thunk+0x5/0xfbef5
 ip6_finish_output2+0x25e/0x5d0
 ? srso_alias_return_thunk+0x5/0xfbef5
 ? nf_hook_slow+0x47/0xf0
 ? srso_alias_return_thunk+0x5/0xfbef5
 ip6_finish_output+0x1fc/0x3f0
 ip6_tnl_xmit+0x608/0xc00 [ip6_tunnel]
 ? srso_alias_return_thunk+0x5/0xfbef5
 ip6gre_tunnel_xmit+0x1c0/0x390 [ip6_gre]
 dev_hard_start_xmit+0x63/0x1c0
 __dev_queue_xmit+0x6d0/0x7f0
 ? srso_alias_return_thunk+0x5/0xfbef5
 ? chacha_block_generic+0x72/0xd0
 ? srso_alias_return_thunk+0x5/0xfbef5
 ? selinux_ip_postroute+0x1c5/0x420
 ip6_finish_output2+0x214/0x5d0
 ? srso_alias_return_thunk+0x5/0xfbef5
 ? nf_hook_slow+0x47/0xf0
 ip6_finish_output+0x1fc/0x3f0
 ip6_xmit+0x2ca/0x6f0
 ? __pfx_dst_output+0x10/0x10
 ? srso_alias_return_thunk+0x5/0xfbef5
 ? nf_hook_slow+0x47/0xf0
 ip6_finish_output+0x1fc/0x3f0
 ip6_xmit+0x2ca/0x6f0
 ? __pfx_dst_output+0x10/0x10
 ? srso_alias_return_thunk+0x5/0xfbef5
 ? __sk_dst_check+0x41/0xc0
 ? srso_alias_return_thunk+0x5/0xfbef5
 ? inet6_csk_route_socket+0x12e/0x200
 inet6_csk_xmit+0xeb/0x150
 __tcp_transmit_skb+0x555/0xa80
 tcp_write_xmit+0x32a/0xe90
 ? srso_alias_return_thunk+0x5/0xfbef5
 ? skb_do_copy_data_nocache+0xc9/0x150
 tcp_sendmsg_locked+0x437/0x1110
 ? srso_alias_return_thunk+0x5/0xfbef5
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
+		(skb_shinfo(skb)->gso_type & SKB_GSO_TCPV6 ||
+		(skb_shinfo(skb)->gso_type & SKB_GSO_UDP_L4 &&
+		vlan_get_protocol(skb) == htons(ETH_P_IPV6))) &&
+		skb_transport_header_was_set(skb) &&
+		skb_network_header_len(skb) != sizeof(struct ipv6hdr) &&
+		!ipv6_has_hopopt_jumbo(skb))
+			features &= ~(NETIF_F_IPV6_CSUM | NETIF_F_TSO6 | NETIF_F_GSO_UDP_L4);
 
 	return features;
 }
-- 
2.50.1


