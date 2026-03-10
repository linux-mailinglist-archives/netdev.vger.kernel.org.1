Return-Path: <netdev+bounces-266212-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gJvzCXo+sGmohQIAu9opvQ
	(envelope-from <netdev+bounces-266212-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 16:53:30 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D91BF254051
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 16:53:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CF38832808F5
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 15:06:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FCF530BF77;
	Tue, 10 Mar 2026 15:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZYPKjhUH"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CE26305047
	for <netdev@vger.kernel.org>; Tue, 10 Mar 2026 15:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773155191; cv=none; b=tn+R5rcqu62mGOnC8fzSVrY6IxTqqmKEhAFgNe/DUOfQYyqZjZjuR4Q4OTV06bnRD7waPVio52kVk8+A4fkUJcsMXjjpOfexmkR0hAnLTMUEGw7qzL2PrMz1dKlZlk032LGoye5WDCC7XnbZwGQAPOFdaSw4OhQ9PsJIueK3kzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773155191; c=relaxed/simple;
	bh=aOe0pzNNvDThTshLaZsIlinJQobAqMTlKl2gtIcpNJs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QmGIbaPO4h9p6OZdmF4pXadM+0mLEA3n70vK+njCFcauYVcSsg+WN6nLZjMHCq5vtQlG07PbxeQt0du0nSWSCwnITj27OYddkWi9w+Qg97U4DscTGRah4m2dSC38W0mtJC0bqSpf2E9sBBNzueZTgZjzF0m3B38cqBbRC6sBCDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZYPKjhUH; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773155189;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=+ylnD5+3z30iOCEMiABhC1oFqELC5abezo7oEw1t5mI=;
	b=ZYPKjhUH6rA6BHyBw6qsWo8NnXQSvJ+L2ql0X5SPAGbNV6Ik59DoZJmcb188hjIlfcIK3s
	Sj1JtwYG8lP/gYk3p8iPv31QDuFTADAjIr6zha5YQHnlMPAKVvyse3w8crNHqa1IldrOtW
	VqZg8NCONravIQ1W/pH6NhPA6LI9jjI=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-164-rHKfhB85Pay9xB7YopzXhA-1; Tue,
 10 Mar 2026 11:06:23 -0400
X-MC-Unique: rHKfhB85Pay9xB7YopzXhA-1
X-Mimecast-MFC-AGG-ID: rHKfhB85Pay9xB7YopzXhA_1773155182
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7BA521955E98;
	Tue, 10 Mar 2026 15:06:22 +0000 (UTC)
Received: from jramaseu-thinkpadt14gen5.tpbc.csb (unknown [10.43.3.226])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 92B4219560B7;
	Tue, 10 Mar 2026 15:06:20 +0000 (UTC)
From: Jakub Ramaseuski <jramaseu@redhat.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	przemyslaw.korba@intel.com,
	Jakub Ramaseuski <jramaseu@redhat.com>
Subject: [Intel-wired-lan] [PATCH iwl-net v2] ice: enable NETIF_F_HW_CSUM for GSO packets
Date: Tue, 10 Mar 2026 16:05:57 +0100
Message-ID: <20260310150557.1138437-1-jramaseu@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Rspamd-Queue-Id: D91BF254051
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-266212-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jramaseu@redhat.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action

IPv4 over IPv6 GRE currently fails on E810 with skb_warn_bad_offload,
while IPv6 over IPv6 GRE falls back to software segmentation.
This happens because the kernel's GSO engine requires the generic HW_CSUM
flag to trust the hardware with complex encapsulation offloads.

Add NETIF_F_HW_CSUM to the device's csumo_features to satisfy the network
stack and unlock full hardware segmentation for GRE tunnels.
To prevent checksum corruption on standard traffic, evaluate the packet
in ice_features_check() and dynamically clear the NETIF_F_HW_CSUM bit
if it is not a GSO frame. This forces the driver to fall back to safe,
protocol-specific checksum features for non-GSO packets
while preserving the generic offload for tunnels.

Steps to reproduce:

Server Side (Receiver):
```
  #!/bin/bash
  DEV="enp65s0f0np0"

  # 1. Configure underlay device
  ip addr add 2011::11/64 dev $DEV
  ip addr add 192.168.42.11/24 dev $DEV
  ip link set $DEV up

  # 2. Create and configure IPv6 GRE tunnel
  ip link add gre1 type ip6gre local 2011::11 remote 2011::12 dev $DEV
  ip addr add 2023::11/64 dev gre1
  ip addr add 192.168.44.11/24 dev gre1
  ip link set gre1 up

  iperf3 -s
```

Client Side (Sender):
```
  #!/bin/bash
  DEV="enp65s0f0np0"

  # 1. Configure underlay device
  ip addr add 2011::12/64 dev $DEV
  ip addr add 192.168.42.12/24 dev $DEV
  ip link set $DEV up

  # 2. Create and configure IPv6 GRE tunnel
  ip link add gre1 type ip6gre local 2011::12 remote 2011::11 dev $DEV
  ip addr add 2023::12/64 dev gre1
  ip addr add 192.168.44.12/24 dev gre1
  ip link set gre1 up

  # 3. Execute Tests
  iperf3 -c 192.168.44.11 -t 20   # IPv4 over IPv6 GRE (Triggers bad_offload)
  iperf3 -c 2023::11 -t 20        # IPv6 over IPv6 GRE (Triggers SW fallback)
  iperf3 -c 192.168.42.11 -t 20   # Native IPv4 Baseline
  iperf3 -c 2011::11 -t 20        # Native IPv6 Baseline
```

Signed-off-by: Jakub Ramaseuski <jramaseu@redhat.com>
---
 drivers/net/ethernet/intel/ice/ice_main.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index e7308e381e2f..9b4ad03e1a32 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -3565,6 +3565,7 @@ void ice_set_netdev_features(struct net_device *netdev)
 
 	csumo_features = NETIF_F_RXCSUM	  |
 			 NETIF_F_IP_CSUM  |
+			 NETIF_F_HW_CSUM  |
 			 NETIF_F_SCTP_CRC |
 			 NETIF_F_IPV6_CSUM;
 
@@ -9789,6 +9790,14 @@ ice_features_check(struct sk_buff *skb,
 	if (skb->ip_summed != CHECKSUM_PARTIAL)
 		return features;
 
+	/* Hardware requires strictly-typed Tx descriptors for non-GSO frames.
+	 * Leaving generic NETIF_F_HW_CSUM enabled corrupts checksums,
+	 * causing TCP drops. We strip it here to force safe,
+	 * protocol-specific IPv4/IPv6 offloads instead.
+	 */
+	if (!gso)
+		features &= ~NETIF_F_HW_CSUM;
+
 	/* We cannot support GSO if the MSS is going to be less than
 	 * 64 bytes. If it is then we need to drop support for GSO.
 	 */
-- 
2.52.0


