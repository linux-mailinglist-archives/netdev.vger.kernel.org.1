Return-Path: <netdev+bounces-200793-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0543BAE6EA7
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 20:33:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F46A174A9E
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 18:33:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A34CE233704;
	Tue, 24 Jun 2025 18:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WQIGXiqS"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F9B1566A
	for <netdev@vger.kernel.org>; Tue, 24 Jun 2025 18:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750789981; cv=none; b=nf3movz/XhOKoyOIGgmuEwOhlb3Icb7w1H643/HqU7Us5qr8UlV6V60j9rtbjoKdTdRyNf18zoa8pwbyLolpyJK2sN8YBY49nLc1NR3DIfFgz6qjYol0Tj5zE04z6tJQzgSFUUhLaT5xdJOI/PG7xSBY0g3GDWQy0UwRSpPLGec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750789981; c=relaxed/simple;
	bh=URq9dqf98pGOCwMJStnW5xCQE8T9d9yRwGluqMmOa18=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qcxhq0Wq0B0tqLxZkVqBPtJYAj99j/ffZUaniSN80818j5CQpjMp6RwYR6xquBocRMseJQeiVREYuhuoORgd0ZCE/XL6vz6YNMpccAxWM533LV3cBAExjaUufWKE1yViGKcPVugh3ZRNv0VfZFJFtkGik2LQaNxTIceSCS1VK6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WQIGXiqS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6907C4CEE3;
	Tue, 24 Jun 2025 18:33:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750789981;
	bh=URq9dqf98pGOCwMJStnW5xCQE8T9d9yRwGluqMmOa18=;
	h=From:To:Cc:Subject:Date:From;
	b=WQIGXiqSIJvXZixTVpYhJFR8oDArGRemc2Ds9T5ijcw+CxdWHOSbFzMA0WMTXYZeG
	 AoZ0KTk3yuGuh9glqEamriS99Dv4lzb6FqL4MxspNPPPMiBU1ORQDf97LTBlLgetkx
	 nGWiQiH0MD5G7Vm4OE38C0m17PmpRCOGnbP/KdE2OWXoHoTvnFbYZHORDE05QR1879
	 Uo034wDLsla7TUAwyKy6S2et5Isltu4G+W/kW+ACcqoSfcS2Xly6h2//4QSbD2X6Qq
	 x9HyVX5u4YbDEZ9aOHwpRjxUVsrBrwfMAeYiW5oicojCDhhwoWLj3igozz8rYKklhf
	 IwR7+kJsll61A==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	o.rempel@pengutronix.de,
	gerhard@engleder-embedded.com
Subject: [PATCH net] net: selftests: fix TCP packet checksum
Date: Tue, 24 Jun 2025 11:32:58 -0700
Message-ID: <20250624183258.3377740-1-kuba@kernel.org>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The length in the pseudo header should be the length of the L3 payload
AKA the L4 header+payload. The selftest code builds the packet from
the lower layers up, so all the headers are pushed already when it
constructs L4. We need to subtract the lower layer headers from skb->len.

Fixes: 3e1e58d64c3d ("net: add generic selftest support")
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: o.rempel@pengutronix.de
CC: gerhard@engleder-embedded.com

I changed the math from the pointers to the offsets (which is what
udp4_hwcsum() does). Oleksij, would you be willing to retest and send
your Reported-and-tested-by: tag?
---
 net/core/selftests.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/net/core/selftests.c b/net/core/selftests.c
index 35f807ea9952..406faf8e5f3f 100644
--- a/net/core/selftests.c
+++ b/net/core/selftests.c
@@ -160,8 +160,9 @@ static struct sk_buff *net_test_get_skb(struct net_device *ndev,
 	skb->csum = 0;
 	skb->ip_summed = CHECKSUM_PARTIAL;
 	if (attr->tcp) {
-		thdr->check = ~tcp_v4_check(skb->len, ihdr->saddr,
-					    ihdr->daddr, 0);
+		int l4len = skb->len - skb_transport_offset(skb);
+
+		thdr->check = ~tcp_v4_check(l4len, ihdr->saddr, ihdr->daddr, 0);
 		skb->csum_start = skb_transport_header(skb) - skb->head;
 		skb->csum_offset = offsetof(struct tcphdr, check);
 	} else {
-- 
2.49.0


