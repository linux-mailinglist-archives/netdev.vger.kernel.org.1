Return-Path: <netdev+bounces-109493-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E61F9289C2
	for <lists+netdev@lfdr.de>; Fri,  5 Jul 2024 15:34:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BDAA91F2198A
	for <lists+netdev@lfdr.de>; Fri,  5 Jul 2024 13:34:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE7EA14D2A8;
	Fri,  5 Jul 2024 13:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b="hgTWH+iJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail1.fiberby.net (mail1.fiberby.net [193.104.135.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77AC0148FFB;
	Fri,  5 Jul 2024 13:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.104.135.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720186456; cv=none; b=KqcMrZtjplI2ZVDcQv2CpdYldOLcL9RjQ8aRWElwqQ10CSfLzknB+1gMZcZRdog2t/FenT1A+sYC3mePShh3yxAok5Jg55drwHbuC42/C2bjBIX69ldAikeiqkHaoCVOig1Z49t77f5jETeaIZ50FFbDAcgQDj08tDiclUR4Bc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720186456; c=relaxed/simple;
	bh=SAPg0fozvoj3F2KG1fuguRG7wOIqoyJx/Pogexzx0HQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mnB4tfKIMtYjHLtqUhNwGb2AyE2edGDxoQSicSpJrhAZIbb5szfCuQxxjm8gm+moAmqDCDAWBFquasj0HqwIxB7lJOy7CaUFAwqUprq8cUvYCVEP5R7A3K/uVqY7Ml8A9skAKdyyx7T5xtp2zmtmHZbat/WXWfGrvoLEmnuRNpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net; spf=pass smtp.mailfrom=fiberby.net; dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b=hgTWH+iJ; arc=none smtp.client-ip=193.104.135.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fiberby.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fiberby.net;
	s=202008; t=1720186450;
	bh=SAPg0fozvoj3F2KG1fuguRG7wOIqoyJx/Pogexzx0HQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hgTWH+iJmgQ8QF3Plh56CdkhZ1encNeXV9yD2DPIyNgKaTizRuo0RxpZ3cZNqxNdu
	 6gbOBAwrrnonIT1Aam7qAkxZ/N3LG7KJTbvkZ0kz8xco0/vS+NKxC589aKsmoRSid0
	 5AlNGqXpCNNcwyaYBnrZc49X+hb30nK0oO2WLQhIIIXyQazy6ZXKus8h3YWyIuCbGn
	 zOjZXDKdlkB2JGxg2XtMnkvvbOh0sK6hPW6T88H3vK7msnm0Y5OsVfOGZ8cqU5jde5
	 z2kkA4TiVom7+au6mxjTlqU3XOZ3vAVhKV7j0pGJaIwWo9K5XyWWAmf+qMIcyfzV05
	 pb/uMGUei+ugQ==
Received: from x201s (193-104-135-243.ip4.fiberby.net [193.104.135.243])
	by mail1.fiberby.net (Postfix) with ESMTPSA id 8DEA16007D;
	Fri,  5 Jul 2024 13:34:10 +0000 (UTC)
Received: by x201s (Postfix, from userid 1000)
	id 9C6C720499A; Fri, 05 Jul 2024 13:33:51 +0000 (UTC)
From: =?UTF-8?q?Asbj=C3=B8rn=20Sloth=20T=C3=B8nnesen?= <ast@fiberby.net>
To: netdev@vger.kernel.org
Cc: =?UTF-8?q?Asbj=C3=B8rn=20Sloth=20T=C3=B8nnesen?= <ast@fiberby.net>,
	Davide Caratti <dcaratti@redhat.com>,
	Ilya Maximets <i.maximets@ovn.org>,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Cong Wang <xiyou.wangcong@gmail.com>,
	Jiri Pirko <jiri@resnulli.us>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	David Ahern <dsahern@kernel.org>,
	Simon Horman <horms@kernel.org>,
	Ratheesh Kannoth <rkannoth@marvell.com>,
	Florian Westphal <fw@strlen.de>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v2 10/10] flow_dissector: set encapsulation control flags for non-IP
Date: Fri,  5 Jul 2024 13:33:46 +0000
Message-ID: <20240705133348.728901-11-ast@fiberby.net>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240705133348.728901-1-ast@fiberby.net>
References: <20240705133348.728901-1-ast@fiberby.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Make sure to set encapsulated control flags also for non-IP
packets, such that it's possible to allow matching on e.g.
TUNNEL_OAM on a geneve packet carrying a non-IP packet.

Suggested-by: Davide Caratti <dcaratti@redhat.com>
Signed-off-by: Asbjørn Sloth Tønnesen <ast@fiberby.net>
Tested-by: Davide Caratti <dcaratti@redhat.com>
---
 net/core/flow_dissector.c | 4 ++++
 net/sched/cls_flower.c    | 3 ++-
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/net/core/flow_dissector.c b/net/core/flow_dissector.c
index 1a9ca129fddde..ada1e39b557e0 100644
--- a/net/core/flow_dissector.c
+++ b/net/core/flow_dissector.c
@@ -434,6 +434,10 @@ skb_flow_dissect_tunnel_info(const struct sk_buff *skb,
 			ipv6->dst = key->u.ipv6.dst;
 		}
 		break;
+	default:
+		skb_flow_dissect_set_enc_control(0, ctrl_flags, flow_dissector,
+						 target_container);
+		break;
 	}
 
 	if (dissector_uses_key(flow_dissector, FLOW_DISSECTOR_KEY_ENC_KEYID)) {
diff --git a/net/sched/cls_flower.c b/net/sched/cls_flower.c
index 897d6b683cc6f..38b2df387c1e1 100644
--- a/net/sched/cls_flower.c
+++ b/net/sched/cls_flower.c
@@ -2199,7 +2199,8 @@ static void fl_init_dissector(struct flow_dissector *dissector,
 	FL_KEY_SET_IF_MASKED(mask, keys, cnt,
 			     FLOW_DISSECTOR_KEY_ENC_IPV6_ADDRS, enc_ipv6);
 	if (FL_KEY_IS_MASKED(mask, enc_ipv4) ||
-	    FL_KEY_IS_MASKED(mask, enc_ipv6))
+	    FL_KEY_IS_MASKED(mask, enc_ipv6) ||
+	    FL_KEY_IS_MASKED(mask, enc_control))
 		FL_KEY_SET(keys, cnt, FLOW_DISSECTOR_KEY_ENC_CONTROL,
 			   enc_control);
 	FL_KEY_SET_IF_MASKED(mask, keys, cnt,
-- 
2.45.2


