Return-Path: <netdev+bounces-91929-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AD588B475C
	for <lists+netdev@lfdr.de>; Sat, 27 Apr 2024 20:23:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 805392821EB
	for <lists+netdev@lfdr.de>; Sat, 27 Apr 2024 18:23:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BB35143C4B;
	Sat, 27 Apr 2024 18:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b="iS8CIHiE"
X-Original-To: netdev@vger.kernel.org
Received: from nbd.name (nbd.name [46.4.11.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED01CA938
	for <netdev@vger.kernel.org>; Sat, 27 Apr 2024 18:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.4.11.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714242196; cv=none; b=YLY40cEUnd9J+Ez7ZkrcdvT08F1Sz2HmfIYD8BoxVIPrZRM/rcNeg3/asM4d07HP/B8hfCbqgYRSULBCxU7OCptZbXx9GLVVbMcCB2hNOGKIVklACi0/Tsj9jRtnCczdA0U6N6GnNaGCckwnastX/59M3EU/igdZCtd5TR64KvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714242196; c=relaxed/simple;
	bh=i4cMB7/EO6Bw5sC3J0JtU5PuWn/n07qleFx47PP8JnM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uIZfyurt6gUcGz0QBQ/H6n6HSsNkOQZu8eOnovuxbBXEzh/70brrkVWYSXX8iPUQnFQAFMY07ZJ9dsmaPJGozjvJ+otYRAOKTE9149Leia7H/IRjOhiX5uz5h3Yi7dwY0VWp/RuZa5+RadnyVHBwdHXhRrhwBRYNMvjSuByLbwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name; spf=none smtp.mailfrom=nbd.name; dkim=pass (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b=iS8CIHiE; arc=none smtp.client-ip=46.4.11.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=nbd.name
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
	s=20160729; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
	Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=9LoCRGCy4BSIzXLI2OXRoDhtscCuZ4GVfLDFe+j9mTE=; b=iS8CIHiEYZmb85xZUM8b2lHOwk
	5nrhpi4y8fOHKvt7NG+Ryp15rmwwEPtluOvfRXgf1IeGXF3GyC1+2kAsDjKzXZuAuAsze3lb0fi2h
	Pl0neI3WGFwaM+Drsc0oonLvy6AwYtfXdIpG4Xla1YBXcz7A8LpBjqw4famSUftD+oFg=;
Received: from p54ae9c93.dip0.t-ipconnect.de ([84.174.156.147] helo=localhost.localdomain)
	by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_CHACHA20_POLY1305_SHA256
	(Exim 4.96)
	(envelope-from <nbd@nbd.name>)
	id 1s0mhW-008hH3-1J;
	Sat, 27 Apr 2024 20:23:06 +0200
From: Felix Fietkau <nbd@nbd.name>
To: netdev@vger.kernel.org
Cc: willemdebruijn.kernel@gmail.com,
	pabeni@redhat.com,
	edumazet@google.com
Subject: [PATCH v4 net-next v4 0/6] Add TCP fraglist GRO support
Date: Sat, 27 Apr 2024 20:22:56 +0200
Message-ID: <20240427182305.24461-1-nbd@nbd.name>
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
 net/ipv4/tcp_offload.c   | 215 ++++++++++++++++++++++++++++++++-------
 net/ipv4/udp_offload.c   |  27 -----
 net/ipv6/tcpv6_offload.c | 120 +++++++++++++++++++++-
 6 files changed, 326 insertions(+), 69 deletions(-)

-- 
2.44.0


