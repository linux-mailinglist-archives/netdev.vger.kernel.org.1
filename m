Return-Path: <netdev+bounces-95792-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E2348C374A
	for <lists+netdev@lfdr.de>; Sun, 12 May 2024 18:15:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF9932814B9
	for <lists+netdev@lfdr.de>; Sun, 12 May 2024 16:14:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19F4146B9F;
	Sun, 12 May 2024 16:14:51 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 742C345BE6;
	Sun, 12 May 2024 16:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.188.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715530491; cv=none; b=qqieaQ0MNcAOzITXPJpfcMq5SRbvP7lKK5IfMp+4AejstCj1WKGDiQceUmJ3vuALlS+GuzpqNmrQYtzojKkPdOtAmmp2GDXCR0kg1urhsXNAGmeBJX+6BR5ip4Vq16eGtl17u3uitnGloKsKoZPFpUSfgZ17dFsxJx9u5Xk8HNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715530491; c=relaxed/simple;
	bh=t+Zbcio1bHYFNcLROzN1cupuMSiXkyewbo1ytJUON0Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=R+IF5mX8MRcFz3ZyzovMdTXWJqkOCURuOfaeG6CwVJYcKaF/b7eKDdIdIHtgTfwzeZAFgzrdvIxo77Rabu0eGFAVBU7D1Iq/jZRKoDNGzZ/YlkeIn6vthtC7v27tHUMq+HmEXJl3rD/58DCrKAbhK13vEzWHjeTOIHr4S1Cn8yk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org; spf=pass smtp.mailfrom=netfilter.org; arc=none smtp.client-ip=217.70.188.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=netfilter.org
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: netfilter-devel@vger.kernel.org
Cc: davem@davemloft.net,
	netdev@vger.kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	fw@strlen.de
Subject: [PATCH net-next 03/17] netfilter: conntrack: fix ct-state for ICMPv6 Multicast Router Discovery
Date: Sun, 12 May 2024 18:14:22 +0200
Message-Id: <20240512161436.168973-4-pablo@netfilter.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240512161436.168973-1-pablo@netfilter.org>
References: <20240512161436.168973-1-pablo@netfilter.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Linus Lüssing <linus.luessing@c0d3.blue>

So far Multicast Router Advertisements and Multicast Router
Solicitations from the Multicast Router Discovery protocol (RFC4286)
would be marked as INVALID for IPv6, even if they are in fact intact
and adhering to RFC4286.

This broke MRA reception and by that multicast reception on
IPv6 multicast routers in a Proxmox managed setup, where Proxmox
would install a rule like "-m conntrack --ctstate INVALID -j DROP"
at the top of the FORWARD chain with br-nf-call-ip6tables enabled
by default.

Similar to as it's done for MLDv1, MLDv2 and IPv6 Neighbor Discovery
already, fix this issue by excluding MRD from connection tracking
handling as MRD always uses predefined multicast destinations
for its messages, too. This changes the ct-state for ICMPv6 MRD messages
from INVALID to UNTRACKED.

This issue was found and fixed with the help of the mrdisc tool
(https://github.com/troglobit/mrdisc).

Signed-off-by: Linus Lüssing <linus.luessing@c0d3.blue>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 include/uapi/linux/icmpv6.h               | 1 +
 net/netfilter/nf_conntrack_proto_icmpv6.c | 4 +++-
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/include/uapi/linux/icmpv6.h b/include/uapi/linux/icmpv6.h
index ecaece3af38d..4eaab89e2856 100644
--- a/include/uapi/linux/icmpv6.h
+++ b/include/uapi/linux/icmpv6.h
@@ -112,6 +112,7 @@ struct icmp6hdr {
 #define ICMPV6_MOBILE_PREFIX_ADV	147
 
 #define ICMPV6_MRDISC_ADV		151
+#define ICMPV6_MRDISC_SOL		152
 
 #define ICMPV6_MSG_MAX          255
 
diff --git a/net/netfilter/nf_conntrack_proto_icmpv6.c b/net/netfilter/nf_conntrack_proto_icmpv6.c
index 1020d67600a9..327b8059025d 100644
--- a/net/netfilter/nf_conntrack_proto_icmpv6.c
+++ b/net/netfilter/nf_conntrack_proto_icmpv6.c
@@ -62,7 +62,9 @@ static const u_int8_t noct_valid_new[] = {
 	[NDISC_ROUTER_ADVERTISEMENT - 130] = 1,
 	[NDISC_NEIGHBOUR_SOLICITATION - 130] = 1,
 	[NDISC_NEIGHBOUR_ADVERTISEMENT - 130] = 1,
-	[ICMPV6_MLD2_REPORT - 130] = 1
+	[ICMPV6_MLD2_REPORT - 130] = 1,
+	[ICMPV6_MRDISC_ADV - 130] = 1,
+	[ICMPV6_MRDISC_SOL - 130] = 1
 };
 
 bool nf_conntrack_invert_icmpv6_tuple(struct nf_conntrack_tuple *tuple,
-- 
2.30.2


