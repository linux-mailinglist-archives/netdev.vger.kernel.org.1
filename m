Return-Path: <netdev+bounces-92945-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 901EA8B96A3
	for <lists+netdev@lfdr.de>; Thu,  2 May 2024 10:45:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F509284F3D
	for <lists+netdev@lfdr.de>; Thu,  2 May 2024 08:45:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4E6246B9F;
	Thu,  2 May 2024 08:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b="B6b/eFiL"
X-Original-To: netdev@vger.kernel.org
Received: from nbd.name (nbd.name [46.4.11.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A75246447
	for <netdev@vger.kernel.org>; Thu,  2 May 2024 08:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.4.11.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714639502; cv=none; b=KlPN2eEg0BLYOqdaXzmObBO2+TAAqRwx4I7aRnkbH7vBLXEVexzRmdtAnHa5CG5Wqz2jEAqV3goUYQgz3aUrhs8Xue+owFAfwY7Zfc6hT2CG4hhdmOWgCUjlF4gUZcTi6oW1kF3kpLw0n8YKzxZPIGPY5bokj8QpuWYXjVDB5vY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714639502; c=relaxed/simple;
	bh=4VZ/aOGNh0Hkn9N25xpqC2CPeHoheJyXXN4LMLQJeTQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mPDA6Qy0+XxQEE4t0fAWej1c7y7jFLhkEXBmM7FCBnxZ7lhhWICd3IxLXrrFx0tvCvm82FHzYHbl6tN8zMq8BycLeHNEDhLEtbZDsHAO4ceGDMKUJP4LQbeLGGRNuAvdvmzzGgM/u9eG42EVhuYxOqRAmJ/ZIgaLnr4g1eWTBGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name; spf=none smtp.mailfrom=nbd.name; dkim=pass (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b=B6b/eFiL; arc=none smtp.client-ip=46.4.11.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=nbd.name
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
	s=20160729; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
	Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=Mojp+hqtZATgScj553MrVs2JOuJtgeE2EFEmeNBLr64=; b=B6b/eFiL1svP0RZe9Yn5+PRlos
	Ow6d01NGoC9W3aWT/LIzLetuEfy+LKwh4aBab0JOy8skGM4SGa+K5V0VM/ljNTLvBjqneVwLYfGTL
	Y7MHB8zJtASKB6xa5NcEcj42OBlYnUPSeSJ+Y05/CaZxn+posz6Mb5KWTRnJyeE8xSj0=;
Received: from p54ae9c93.dip0.t-ipconnect.de ([84.174.156.147] helo=localhost.localdomain)
	by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_CHACHA20_POLY1305_SHA256
	(Exim 4.96)
	(envelope-from <nbd@nbd.name>)
	id 1s2S3f-00BKKn-1C;
	Thu, 02 May 2024 10:44:51 +0200
From: Felix Fietkau <nbd@nbd.name>
To: netdev@vger.kernel.org
Cc: willemdebruijn.kernel@gmail.com,
	pabeni@redhat.com,
	edumazet@google.com
Subject: [PATCH v5 net-next v5 0/6] Add TCP fraglist GRO support
Date: Thu,  2 May 2024 10:44:41 +0200
Message-ID: <20240502084450.44009-1-nbd@nbd.name>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When forwarding TCP after GRO, software segmentation is very expensive,
especially when the checksum needs to be recalculated.
One case where that's currently unavoidable is when routing packets over
PPPoE. Performance improves significantly when using fraglist GRO
implemented in the same way as for UDP.

When NETIF_F_GRO_FRAGLIST is enabled, perform a lookup for an established
socket in the same netns as the receiving device. While this may not
cover all relevant use cases in multi-netns configurations, it should be
good enough for most configurations that need this.

Here's a measurement of running 2 TCP streams through a MediaTek MT7622
device (2-core Cortex-A53), which runs NAT with flow offload enabled from
one ethernet port to PPPoE on another ethernet port + cake qdisc set to
1Gbps.

rx-gro-list off: 630 Mbit/s, CPU 35% idle
rx-gro-list on:  770 Mbit/s, CPU 40% idle

Changes since v4:
 - add likely() to prefer the non-fraglist path in check

Changes since v3:
 - optimize __tcpv4_gso_segment_csum
 - add unlikely()
 - reorder dev_net/skb_gro_network_header calls after NETIF_F_GRO_FRAGLIST
   check
 - add support for ipv6 nat
 - drop redundant pskb_may_pull check

Changes since v2:
 - create tcp_gro_header_pull helper function to pull tcp header only once
 - optimize __tcpv4_gso_segment_list_csum, drop obsolete flags check

Changes since v1:
 - revert bogus tcp flags overwrite on segmentation
 - fix kbuild issue with !CONFIG_IPV6
 - only perform socket lookup for the first skb in the GRO train

Changes since RFC:
 - split up patches
 - handle TCP flags mutations

Felix Fietkau (6):
  net: move skb_gro_receive_list from udp to core
  net: add support for segmenting TCP fraglist GSO packets
  net: add code for TCP fraglist GRO
  net: create tcp_gro_lookup helper function
  net: create tcp_gro_header_pull helper function
  net: add heuristic for enabling TCP fraglist GRO

 include/net/gro.h        |   1 +
 include/net/tcp.h        |   5 +-
 net/core/gro.c           |  27 +++++
 net/ipv4/tcp_offload.c   | 214 ++++++++++++++++++++++++++++++++-------
 net/ipv4/udp_offload.c   |  27 -----
 net/ipv6/tcpv6_offload.c | 120 +++++++++++++++++++++-
 6 files changed, 325 insertions(+), 69 deletions(-)

-- 
2.44.0


