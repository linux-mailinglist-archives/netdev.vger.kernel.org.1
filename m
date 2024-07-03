Return-Path: <netdev+bounces-108807-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 24B52925F3C
	for <lists+netdev@lfdr.de>; Wed,  3 Jul 2024 13:53:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 36DCEB314B2
	for <lists+netdev@lfdr.de>; Wed,  3 Jul 2024 10:56:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D8ED1891DD;
	Wed,  3 Jul 2024 10:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b="N55ptznV"
X-Original-To: netdev@vger.kernel.org
Received: from mail1.fiberby.net (mail1.fiberby.net [193.104.135.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F03D186E5A;
	Wed,  3 Jul 2024 10:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.104.135.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720003648; cv=none; b=el4ItL3cIhDscWSgU/xC7rd+p5x1JZeKWEpH9LoW3WM9Kc9iF9CGGGCCpBIey4p6h+JrsZ1yd9H+wEnnwoSGr88s0OKE+l/5coXc2YXsgdpQXbo1bbuZ08jHTpcqjTCmugxWv6KXPYmFPJay8Yy+IHdhWqFijG5HtHuW8N2zyaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720003648; c=relaxed/simple;
	bh=z6CU+hempZ5xYvk+G+kTKKpEJcoRr3AqdbLe57dcww8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mUKO22ADIe5U4YVL7dDkvCOgwFhNKk6zD9tuLVE+eeraqq0YEam6sF7LZ9Nd/KsIhQY48S7lYnNdCik5j3aUJSucxLQoU13D+74PVqXKUCjjIOusF9hblbLxAwZq9g08CBQY20COnzJnGh4GqT2z0T/pGFJ29C2IN+hBqaPjdzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net; spf=pass smtp.mailfrom=fiberby.net; dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b=N55ptznV; arc=none smtp.client-ip=193.104.135.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fiberby.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fiberby.net;
	s=202008; t=1720003635;
	bh=z6CU+hempZ5xYvk+G+kTKKpEJcoRr3AqdbLe57dcww8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=N55ptznV6NMf8dsS9lPo4ylqBG0iMjE+exkEQn+mTqEvjlwGLrIAx9tMrZUBQnVjc
	 mKpfkPS+zaLzWJlCMbJaC88DBrW/RZHfYXJ6WUpct/ckmCtskz9ouHglnhcPM1nL1z
	 EeZG36f8oPy0cTEEcwSCCfrrA8H7qM+uLt8JJWYEbWhucad6ACGj2pKNgb/pknCx9S
	 N+5tHIGq1qvzBJyyfYdEq7CzAZpYd5mQs1/9oeP80UzZsHnm5PFbJgWfE7VoY37hot
	 QNWYCF/xRhIqejHV9ze13ku56PPj8/xF5IUuqOX2y57H5RjudgfP61f0CRUbKaoT7i
	 b6LxXsGo7B4fA==
Received: from x201s (193-104-135-243.ip4.fiberby.net [193.104.135.243])
	by mail1.fiberby.net (Postfix) with ESMTPSA id 149C160078;
	Wed,  3 Jul 2024 10:46:59 +0000 (UTC)
Received: by x201s (Postfix, from userid 1000)
	id 7416D20474A; Wed, 03 Jul 2024 10:46:33 +0000 (UTC)
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
Subject: [PATCH net-next 9/9] flow_dissector: set encapsulation control flags for non-IP
Date: Wed,  3 Jul 2024 10:45:58 +0000
Message-ID: <20240703104600.455125-10-ast@fiberby.net>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240703104600.455125-1-ast@fiberby.net>
References: <20240703104600.455125-1-ast@fiberby.net>
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
---
 net/core/flow_dissector.c | 4 ++++
 net/sched/cls_flower.c    | 3 ++-
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/net/core/flow_dissector.c b/net/core/flow_dissector.c
index 1a9ca129fddd..ada1e39b557e 100644
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
index 897d6b683cc6..38b2df387c1e 100644
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


