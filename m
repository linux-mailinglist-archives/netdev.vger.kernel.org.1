Return-Path: <netdev+bounces-94622-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 63BD88C001A
	for <lists+netdev@lfdr.de>; Wed,  8 May 2024 16:35:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 046301F26F9A
	for <lists+netdev@lfdr.de>; Wed,  8 May 2024 14:35:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CD91127E0E;
	Wed,  8 May 2024 14:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b="k5Qtz+RQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail1.fiberby.net (mail1.fiberby.net [193.104.135.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84D628625D;
	Wed,  8 May 2024 14:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.104.135.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715178879; cv=none; b=lI3mR8XlRE6bFhQ83rIXnX39a1MSK9tohsn9Qx+VQU3Czn7cMmE6FvTFlKyRdnAOM/i4M9jhCbUBR6tmmREVeMaZ0+laYHrVXtk3qTNbHTb7zrcdYobuHMzjtl5uyTSBW8gd/S9nQW6YkCFTO3GiHzdOgeJj/710s8Ul7Un7b10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715178879; c=relaxed/simple;
	bh=aMvLMv604BjIOtpjuNmzesCsS0tjefV5UKuS0i/vJVk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Tc9Bbi1lRm31VU07VNPI2k/XpQYf/7GYVz6UVjzXqXd2Ki5aSfQpQmQFoHH8HdltWKHUkDGwihsvZ8pGc5IECF0KuitME+NNsBTEhxhQYqsnn15peQff3qeWecnrcAauEOghv59bYm2dR6TTwjYDEzEBX6e7qPsGwVOowu35BWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net; spf=pass smtp.mailfrom=fiberby.net; dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b=k5Qtz+RQ; arc=none smtp.client-ip=193.104.135.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fiberby.net
Received: from x201s (193-104-135-243.ip4.fiberby.net [193.104.135.243])
	by mail1.fiberby.net (Postfix) with ESMTPSA id A65FF6016A;
	Wed,  8 May 2024 14:34:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fiberby.net;
	s=202008; t=1715178869;
	bh=aMvLMv604BjIOtpjuNmzesCsS0tjefV5UKuS0i/vJVk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=k5Qtz+RQFS11QPHCQd+usHXryIouu86sXAqfwQvgxnboODn6kOM7Nsen3/ryxOdEQ
	 TKAhxnnDbSUmu/wYJTx2dXsEBXapnz9YtrwbJILt1nvk8bVvB8SEAUKfjesqOw/HiT
	 IPI6mHrqBFfx/whMXyCTtYabvjTc/XbSN61lCI8HWoPhv7TaUpuyPNHino4NxP6hUT
	 Cg7C9hhFmSnkgyLwCMwXHw6ioVKNeqgVZY9BsQlTnfFUstChzisdy/F4aBT+e1+NPF
	 KFQwLOt2F5hV9298OEE4wXGaHR1s7ESLchow5WgirXuZcoG2vEVeKd5si7QlWq6ki/
	 PRkpreuuvjwUg==
Received: by x201s (Postfix, from userid 1000)
	id 620B5206CC6; Wed, 08 May 2024 14:34:06 +0000 (UTC)
From: =?UTF-8?q?Asbj=C3=B8rn=20Sloth=20T=C3=B8nnesen?= <ast@fiberby.net>
To: netdev@vger.kernel.org
Cc: =?UTF-8?q?Asbj=C3=B8rn=20Sloth=20T=C3=B8nnesen?= <ast@fiberby.net>,
	linux-kernel@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Manish Chopra <manishc@marvell.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>
Subject: [PATCH net-next v2 07/14] net: qede: use extack in qede_flow_parse_tcp_v4()
Date: Wed,  8 May 2024 14:33:55 +0000
Message-ID: <20240508143404.95901-8-ast@fiberby.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240508143404.95901-1-ast@fiberby.net>
References: <20240508143404.95901-1-ast@fiberby.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Convert qede_flow_parse_tcp_v4() to take extack,
and drop the edev argument.

Pass extack in call to qede_flow_parse_v4_common().

In call to qede_flow_parse_tcp_v4(), use NULL as extack
for now, until a subsequent patch makes extack available.

Only compile tested.

Signed-off-by: Asbjørn Sloth Tønnesen <ast@fiberby.net>
---
 drivers/net/ethernet/qlogic/qede/qede_filter.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/qlogic/qede/qede_filter.c b/drivers/net/ethernet/qlogic/qede/qede_filter.c
index ddf1d6b0fc83..9fd08ee252ae 100644
--- a/drivers/net/ethernet/qlogic/qede/qede_filter.c
+++ b/drivers/net/ethernet/qlogic/qede/qede_filter.c
@@ -1796,13 +1796,13 @@ qede_flow_parse_tcp_v6(struct flow_rule *rule, struct qede_arfs_tuple *tuple,
 }
 
 static int
-qede_flow_parse_tcp_v4(struct qede_dev *edev, struct flow_rule *rule,
-		     struct qede_arfs_tuple *tuple)
+qede_flow_parse_tcp_v4(struct flow_rule *rule, struct qede_arfs_tuple *tuple,
+		       struct netlink_ext_ack *extack)
 {
 	tuple->ip_proto = IPPROTO_TCP;
 	tuple->eth_proto = htons(ETH_P_IP);
 
-	return qede_flow_parse_v4_common(rule, tuple, NULL);
+	return qede_flow_parse_v4_common(rule, tuple, extack);
 }
 
 static int
@@ -1860,7 +1860,7 @@ qede_parse_flow_attr(struct qede_dev *edev, __be16 proto,
 	}
 
 	if (ip_proto == IPPROTO_TCP && proto == htons(ETH_P_IP))
-		rc = qede_flow_parse_tcp_v4(edev, rule, tuple);
+		rc = qede_flow_parse_tcp_v4(rule, tuple, NULL);
 	else if (ip_proto == IPPROTO_TCP && proto == htons(ETH_P_IPV6))
 		rc = qede_flow_parse_tcp_v6(rule, tuple, NULL);
 	else if (ip_proto == IPPROTO_UDP && proto == htons(ETH_P_IP))
-- 
2.43.0


