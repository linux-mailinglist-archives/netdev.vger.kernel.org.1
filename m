Return-Path: <netdev+bounces-173914-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D21DBA5C373
	for <lists+netdev@lfdr.de>; Tue, 11 Mar 2025 15:14:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BC9AD7A9F7E
	for <lists+netdev@lfdr.de>; Tue, 11 Mar 2025 14:12:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 026FB25C6E8;
	Tue, 11 Mar 2025 14:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=uliege.be header.i=@uliege.be header.b="jYvXYsIc"
X-Original-To: netdev@vger.kernel.org
Received: from serv108.segi.ulg.ac.be (serv108.segi.ulg.ac.be [139.165.32.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5441F25BAD5
	for <netdev@vger.kernel.org>; Tue, 11 Mar 2025 14:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=139.165.32.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741702398; cv=none; b=A7mny4f5OUHdqBYhL172AOzsqPzRs63oJV7ziVixpYIq5J5pBvj5VaOIo/457++dbhGOcDBEcVN59E5GA/3BXVzmTgjkfW/p/kzyc6stp/6GOVlLwgdTE1Id3Lq6w3MPvD81WIc44HKf6ZmZwjaNNLwFPIo5RqpeAl9MuBZQN0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741702398; c=relaxed/simple;
	bh=MQpJJTgSJvXpqyx1M/U7NzUJVeHnEvia5NsabQqfeYg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XFxzIHmdXyh51FZnbR3QNJj5ULFeBAKnS1zVW1QeW/UX6COfjFqbf8AP18PRDR0J0eOhxZFI1F3phujqHCkLsHyG6YcWYMy9LWXG3Gq4qWiCRDwVZYfULiOBGp1GTt6zPAZ8l/1kCiCad4rQLn9qMGsW28skm1cJXU+tPbixaVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uliege.be; spf=pass smtp.mailfrom=uliege.be; dkim=pass (2048-bit key) header.d=uliege.be header.i=@uliege.be header.b=jYvXYsIc; arc=none smtp.client-ip=139.165.32.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uliege.be
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uliege.be
Received: from localhost.localdomain (unknown [195.29.54.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by serv108.segi.ulg.ac.be (Postfix) with ESMTPSA id B26C0200E1C8;
	Tue, 11 Mar 2025 15:13:09 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 serv108.segi.ulg.ac.be B26C0200E1C8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uliege.be;
	s=ulg20190529; t=1741702393;
	bh=FyWFmc81CaeAzhNKQ0gHsVb7UU0CVPtxWqPJTaGYRio=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jYvXYsIccCsYGoDR9J9ErAWFctztZyLp3QOaJI2/2Dxjdh9E2tCpSYPbCsQfgT5K/
	 HTpda+idhZegQL/HR3xIrUmQKg51381GMEoVLeXoN52IvuB9lBt/mfPYHu7EWvwLaU
	 2JCAwWTc1efnhjxQwJBAoWhaK0en5l/6a1HgNhX87hN2Sdw+P+VyKy58nuvvGQ1Ta4
	 wtKPNnv4XDGLm99ta6VYeCAWFvfmolGfEfMJGHnU46QjCTFUKBdkXLf99Rrwjbb1o1
	 5ISz5WCp4AW96I2DtDBL0anm17gezg9sBZLjjY+kzl4GAXjBhB2ohcDUvYkL62PrDD
	 W0MW/gBvpMa7Q==
From: Justin Iurman <justin.iurman@uliege.be>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	dsahern@kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	justin.iurman@uliege.be,
	Alexander Aring <alex.aring@gmail.com>,
	Ido Schimmel <idosch@nvidia.com>
Subject: [PATCH net 2/7] net: ipv6: rpl: fix lwtunnel_input/output loop
Date: Tue, 11 Mar 2025 15:12:33 +0100
Message-Id: <20250311141238.19862-3-justin.iurman@uliege.be>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250311141238.19862-1-justin.iurman@uliege.be>
References: <20250311141238.19862-1-justin.iurman@uliege.be>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix the lwtunnel_input() and lwtunnel_output() reentry loop in
rpl_iptunnel when the destination is the same after transformation. Some
configurations leading to this may be considered pathological, but we
don't want the kernel to crash even for these ones.

Fixes: a7a29f9c361f ("net: ipv6: add rpl sr tunnel")
Cc: Alexander Aring <alex.aring@gmail.com>
Cc: Ido Schimmel <idosch@nvidia.com>
Signed-off-by: Justin Iurman <justin.iurman@uliege.be>
---
 net/ipv6/rpl_iptunnel.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/net/ipv6/rpl_iptunnel.c b/net/ipv6/rpl_iptunnel.c
index 7c05ac846646..dfcc1a79a4ee 100644
--- a/net/ipv6/rpl_iptunnel.c
+++ b/net/ipv6/rpl_iptunnel.c
@@ -247,6 +247,14 @@ static int rpl_output(struct net *net, struct sock *sk, struct sk_buff *skb)
 			goto drop;
 	}
 
+	/* avoid lwtunnel_output() reentry loop when destination is the same
+	 * after transformation
+	 */
+	if (orig_dst->lwtstate == dst->lwtstate) {
+		dst_release(dst);
+		return orig_dst->lwtstate->orig_output(net, sk, skb);
+	}
+
 	skb_dst_drop(skb);
 	skb_dst_set(skb, dst);
 
@@ -305,6 +313,12 @@ static int rpl_input(struct sk_buff *skb)
 		skb_dst_set(skb, dst);
 	}
 
+	/* avoid lwtunnel_input() reentry loop when destination is the same
+	 * after transformation
+	 */
+	if (lwtst == dst->lwtstate)
+		return dst->lwtstate->orig_input(skb);
+
 	return dst_input(skb);
 
 drop:
-- 
2.34.1


