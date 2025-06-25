Return-Path: <netdev+bounces-200996-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DBD40AE7B30
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 11:00:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E2EB5A1FF2
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 09:00:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76E8E2882C7;
	Wed, 25 Jun 2025 09:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PNQEjXd3"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 512C52882BD
	for <netdev@vger.kernel.org>; Wed, 25 Jun 2025 09:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750842039; cv=none; b=YIYrWbzOJFxf1DpC1kXETKT/CiDcQ/foKa3L/v4HZu0sEret4fj8DXPuGH+rUr1ANyQp+PNE1jn1xohQO0+/iYmiZ+s3DdHq/K5/KWO7IVJCML2PPxRwFEsK8QLQ1GmqyJkTEpZjcimyLJrl1Fp3+/6yU/qyKAB16rmmRXwtVfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750842039; c=relaxed/simple;
	bh=EqOQBZGIl8v57Asips7WSkEe+4xIy09GYhNNBk6Pq+Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ba25BjplF5UXlod07DzrsOQpM0EeWTls0wnnHfZN+wMH79j+BsW92BZAnWNIM0Ille3G44RkhkbzpIURoaAnB1kfJ1tM5NVqHEAat/7aikIUj6dmQknw6z0iKzyOFGC54+MHTVp4hfMp/xBeCGMdp9wy/kljO5wxUUC6nymLJ+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PNQEjXd3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CD5EC4CEF2;
	Wed, 25 Jun 2025 09:00:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750842038;
	bh=EqOQBZGIl8v57Asips7WSkEe+4xIy09GYhNNBk6Pq+Y=;
	h=From:To:Cc:Subject:Date:From;
	b=PNQEjXd3eoNwxsNIiE0fi1iqdxKtDwToLnt3bKNnRWob+SP2UEjt92E9Q7srdre8s
	 oPabYIKx2mbqiCWhEuXGRxB8P0DLYuAimVRwz1MRj9QF3AZQWivRNeCmqV9nAn9+Fh
	 cLjn4fkIQruI37iqISU9Che/Cb3in1Ppc+tROFHsgv9gninHwQPeeEuV5OttXBY483
	 1uHg6R9C52hJx6aakUnzuiueXdee4JLwOTxX3tmG8wZHx+B4G+NSWqv1LIp83sFe/N
	 VBk16l7olyJcMacXM9ygYIiB6QxVUmhz0MPVIrP5/JwMJBh0JMkw0qouJGNqktdyNe
	 W9eEW3Acws+mg==
From: Antoine Tenart <atenart@kernel.org>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com
Cc: Antoine Tenart <atenart@kernel.org>,
	netdev@vger.kernel.org,
	Menglong Dong <menglong8.dong@gmail.com>,
	Sabrina Dubroca <sd@queasysnail.net>
Subject: [PATCH net] net: ipv4: fix stat increase when udp early demux drops the packet
Date: Wed, 25 Jun 2025 11:00:34 +0200
Message-ID: <20250625090035.261653-1-atenart@kernel.org>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

udp_v4_early_demux now returns drop reasons as it either returns 0 or
ip_mc_validate_source, which returns itself a drop reason. However its
use was not converted in ip_rcv_finish_core and the drop reason is
ignored, leading to potentially skipping increasing LINUX_MIB_IPRPFILTER
if the drop reason is SKB_DROP_REASON_IP_RPFILTER.

This is a fix and we're not converting udp_v4_early_demux to explicitly
return a drop reason to ease backports; this can be done as a follow-up.

Fixes: d46f827016d8 ("net: ip: make ip_mc_validate_source() return drop reason")
Cc: Menglong Dong <menglong8.dong@gmail.com>
Reported-by: Sabrina Dubroca <sd@queasysnail.net>
Signed-off-by: Antoine Tenart <atenart@kernel.org>
---
 net/ipv4/ip_input.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/ipv4/ip_input.c b/net/ipv4/ip_input.c
index 30a5e9460d00..4bb15bb59993 100644
--- a/net/ipv4/ip_input.c
+++ b/net/ipv4/ip_input.c
@@ -319,8 +319,8 @@ static int ip_rcv_finish_core(struct net *net,
 			      const struct sk_buff *hint)
 {
 	const struct iphdr *iph = ip_hdr(skb);
-	int err, drop_reason;
 	struct rtable *rt;
+	int drop_reason;
 
 	if (ip_can_use_hint(skb, iph, hint)) {
 		drop_reason = ip_route_use_hint(skb, iph->daddr, iph->saddr,
@@ -345,8 +345,8 @@ static int ip_rcv_finish_core(struct net *net,
 			break;
 		case IPPROTO_UDP:
 			if (READ_ONCE(net->ipv4.sysctl_udp_early_demux)) {
-				err = udp_v4_early_demux(skb);
-				if (unlikely(err))
+				drop_reason = udp_v4_early_demux(skb);
+				if (unlikely(drop_reason))
 					goto drop_error;
 
 				/* must reload iph, skb->head might have changed */
-- 
2.49.0


