Return-Path: <netdev+bounces-91344-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FFB08B248F
	for <lists+netdev@lfdr.de>; Thu, 25 Apr 2024 17:04:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A4B461F22403
	for <lists+netdev@lfdr.de>; Thu, 25 Apr 2024 15:04:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E117814A62D;
	Thu, 25 Apr 2024 15:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b="KcZ5k8qB"
X-Original-To: netdev@vger.kernel.org
Received: from nbd.name (nbd.name [46.4.11.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2143514A633
	for <netdev@vger.kernel.org>; Thu, 25 Apr 2024 15:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.4.11.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714057485; cv=none; b=b5t5i0GLrPi1A8ZqIRYyJZNUHjDKiriTUnf1q9H4pIMC0cvn48UBx1OhkgW2TmNcBucPgny1r0Z4UHy08awyaDRGE79gmhob9e2QunZegpEg5HfD2w171jaBFHLf+tsMIG0YsyPncS5fIyySW642TirKPjmNIBCSD1uE8pyOPWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714057485; c=relaxed/simple;
	bh=cTu52Me6wRM2IAkkeIRqQRBbUTQff922qvNyBCr31dA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QfiQ7bbguMq8PM/afqcf1ytyWe3IZb506fMPTzfA7TlY/900k4gFjlkJL6PQn3wT6BzHtl5OPh2TGfsY1oSICl6+9b4X4qtdRi4tETtBYe5qyNJm8Dc+vRUzS6opfDGzD1u6X3qTSycotVWR6UwIxkBHtNBUc3g2jWSbBq0XPRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name; spf=none smtp.mailfrom=nbd.name; dkim=pass (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b=KcZ5k8qB; arc=none smtp.client-ip=46.4.11.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=nbd.name
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
	s=20160729; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
	Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=nFtwZtb2yySq5GOrBig0z2AZLjwf9d+Zi5i5jQVPw7Q=; b=KcZ5k8qBN2oONHDFF1UiUivaLF
	xGEbdciFBdRY4+AByNZolyBjVOBskkttA6fiutth9AL5ub3rO7oY/LnI5HXa2UAHXLMCQwDPhEpy1
	YIx/EzEQUh3GjJYG++LLfpUryTptXr6Q6+zot7x+9Ae5wJW86/FT67SK7KIASqinWwvo=;
Received: from p54ae9c93.dip0.t-ipconnect.de ([84.174.156.147] helo=localhost.localdomain)
	by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_CHACHA20_POLY1305_SHA256
	(Exim 4.96)
	(envelope-from <nbd@nbd.name>)
	id 1s00eH-007MWz-1Y;
	Thu, 25 Apr 2024 17:04:33 +0200
From: Felix Fietkau <nbd@nbd.name>
To: netdev@vger.kernel.org
Cc: willemdebruijn.kernel@gmail.com,
	pabeni@redhat.com,
	edumazet@google.com
Subject: [PATCH v2 net-next 0/5] Add TCP fraglist GRO support
Date: Thu, 25 Apr 2024 17:04:23 +0200
Message-ID: <20240425150432.44142-1-nbd@nbd.name>
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

Changes since v1:
 - revert bogus tcp flags overwrite on segmentation
 - fix kbuild issue with !CONFIG_IPV6
 - only perform socket lookup for the first skb in the GRO train

Changes since RFC:
 - split up patches
 - handle TCP flags mutations

Felix Fietkau (5):
  net: move skb_gro_receive_list from udp to core
  net: add support for segmenting TCP fraglist GSO packets
  net: add code for TCP fraglist GRO
  net: create tcp_gro_lookup helper function
  net: add heuristic for enabling TCP fraglist GRO

 include/net/gro.h        |   1 +
 include/net/tcp.h        |   1 +
 net/core/gro.c           |  27 ++++++
 net/ipv4/tcp_offload.c   | 180 +++++++++++++++++++++++++++++++++++----
 net/ipv4/udp_offload.c   |  27 ------
 net/ipv6/tcpv6_offload.c |  63 ++++++++++++++
 6 files changed, 256 insertions(+), 43 deletions(-)

-- 
2.44.0


