Return-Path: <netdev+bounces-171798-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C030A4EB7F
	for <lists+netdev@lfdr.de>; Tue,  4 Mar 2025 19:27:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F26D7189443D
	for <lists+netdev@lfdr.de>; Tue,  4 Mar 2025 18:22:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F89E284B3D;
	Tue,  4 Mar 2025 18:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=uliege.be header.i=@uliege.be header.b="arpc7dBF"
X-Original-To: netdev@vger.kernel.org
Received: from serv108.segi.ulg.ac.be (serv108.segi.ulg.ac.be [139.165.32.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A386B25DD1C
	for <netdev@vger.kernel.org>; Tue,  4 Mar 2025 18:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=139.165.32.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741111870; cv=none; b=JVxoVGIMA/jeC3N8zTu9XlbofsFnvCXaz7eqKd89wU7ZCIgVLncKzvUzSW10bfvXa9D69m0cAAIfhoRKAMwOg+fDqQMs9ga0Oftv5EHRldjPMXF2/j6nqNXOqAa9TwoQdxCpzzccNjRcrAzLUw3Z6JKJOSAPCzqcILXWDheIz1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741111870; c=relaxed/simple;
	bh=y0GFLUvmbxQf1BFQE3mFqlimIr8vaymziBplCMgs3SI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=uLtntugZtOWDvLDptiRc9K5BeKtFZYSYPZqJdjiz6YkoUA2GW+1vvd/qxV2v5DuwzdpO3nmz3CO/cIwZDyGrlVvwxFgjkJbOguIrxHEShGPtCJWdmqNQi+GGfx6VPLx+hd0tdeQ13GskwUx9Fvt5XEVml7aOe/2wbhFLH4D47J0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uliege.be; spf=pass smtp.mailfrom=uliege.be; dkim=pass (2048-bit key) header.d=uliege.be header.i=@uliege.be header.b=arpc7dBF; arc=none smtp.client-ip=139.165.32.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uliege.be
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uliege.be
Received: from localhost.localdomain (220.24-245-81.adsl-dyn.isp.belgacom.be [81.245.24.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by serv108.segi.ulg.ac.be (Postfix) with ESMTPSA id B2440200DBA8;
	Tue,  4 Mar 2025 19:10:59 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 serv108.segi.ulg.ac.be B2440200DBA8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uliege.be;
	s=ulg20190529; t=1741111859;
	bh=10bdmBy7NDmePVUGJsOuwjZ57iVBrVsC6NRGfwO9qIA=;
	h=From:To:Cc:Subject:Date:From;
	b=arpc7dBFK7RoYWUMSZ0ww8NjA42vPHczfDEhushyCkOsIxwnNeoZWkOyFS1/q7G9+
	 RuaypIP2i4CCt3KeE+7S+q9KR4jV2KwWQkenlY39q9d/xlSi/pMVnDaAY9ChTfiNar
	 4FPTyz+yo3qHze2JU48u9Eb3A/svvxzataiwpKEC4oTJF5eLBrVJY0AoJV15XY3121
	 l/p3XUfZpLFfY5EexIvrCrPz4xakXILFBkHdZ9F++wAbWE1Ir82baGWcpVZrTrFtcV
	 f4EBQUJ4oNdzTfRopFDGmc1tl2Ej//cSJ8SIyrz24eKm9HN/2yatjnUiU1HmP97KX8
	 Kc1iU+V+a3Yyg==
From: Justin Iurman <justin.iurman@uliege.be>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	dsahern@kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	justin.iurman@uliege.be,
	Tom Herbert <tom@herbertland.com>
Subject: [PATCH net] net: ipv6: fix dst ref loop in ila lwtunnel
Date: Tue,  4 Mar 2025 19:10:39 +0100
Message-Id: <20250304181039.35951-1-justin.iurman@uliege.be>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch follows commit 92191dd10730 ("net: ipv6: fix dst ref loops in
rpl, seg6 and ioam6 lwtunnels") and, on a second thought, the same patch
is also needed for ila (even though the config that triggered the issue
was pathological, but still, we don't want that to happen).

Fixes: 79ff2fc31e0f ("ila: Cache a route to translated address")
Cc: Tom Herbert <tom@herbertland.com>
Signed-off-by: Justin Iurman <justin.iurman@uliege.be>
---
 net/ipv6/ila/ila_lwt.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/ipv6/ila/ila_lwt.c b/net/ipv6/ila/ila_lwt.c
index ff7e734e335b..ac4bcc623603 100644
--- a/net/ipv6/ila/ila_lwt.c
+++ b/net/ipv6/ila/ila_lwt.c
@@ -88,7 +88,8 @@ static int ila_output(struct net *net, struct sock *sk, struct sk_buff *skb)
 			goto drop;
 		}
 
-		if (ilwt->connected) {
+		/* cache only if we don't create a dst reference loop */
+		if (ilwt->connected && orig_dst->lwtstate != dst->lwtstate) {
 			local_bh_disable();
 			dst_cache_set_ip6(&ilwt->dst_cache, dst, &fl6.saddr);
 			local_bh_enable();
-- 
2.34.1


