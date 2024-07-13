Return-Path: <netdev+bounces-111190-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C53C5930342
	for <lists+netdev@lfdr.de>; Sat, 13 Jul 2024 04:20:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 85C082835F0
	for <lists+netdev@lfdr.de>; Sat, 13 Jul 2024 02:20:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8480244C8C;
	Sat, 13 Jul 2024 02:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b="LjukFLWa"
X-Original-To: netdev@vger.kernel.org
Received: from mail1.fiberby.net (mail1.fiberby.net [193.104.135.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B84CF1DFF8;
	Sat, 13 Jul 2024 02:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.104.135.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720837167; cv=none; b=iknChQK9KaBW4no8itpLgoFofRaZ5PqupglrMFgNJJfCPfTxSzw8ihCvMTJLcL549Kp2sLm+BCJJFVNvIgi7OEsoWgUbpbP+E8F2jMzw9c4+A0+GBwk4bc496FyZ65nN6nKtL3+YznuV6Xp1rLl8tyNI852P9qnd+6iM33dM0q8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720837167; c=relaxed/simple;
	bh=6lkLYLizZcXhs67Bu7jME18WSkTmSOvmrJxYv+QlZZQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AGFZoFKyq7SSpetaIk6DDie5OpOWOJ5XYNAvI6CviOEc8IZC18g1S54ReEzI0HfwaJKfD1l1WvN1mEkE+vGmJqTyAdd1p3PDEknBkF9iY3PHNULq3zkEz+Mssb1AlxeT4pDslHPnWN0rAqizcmboEjyxksitcT1Fd4DYHQsp3VQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net; spf=pass smtp.mailfrom=fiberby.net; dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b=LjukFLWa; arc=none smtp.client-ip=193.104.135.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fiberby.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fiberby.net;
	s=202008; t=1720837159;
	bh=6lkLYLizZcXhs67Bu7jME18WSkTmSOvmrJxYv+QlZZQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LjukFLWa4gI8+pclGQSorMtfK+OobDGxkkN3B5p68hj/jSybh/REIRw9Vu9CNYheB
	 skViogemUR/KK8QE6nA0AkezZiIESxHVozt+068UZFTYTIEWl84PcvMcSbp1IC/Pwb
	 w9ohVuPxW14chdF4S/ONBhcC2B3HEt1yoCOfpJm+ccVn/6Y+qpIphkGWXnviFh1z4g
	 jGODdxSaDF9oc4QkJoqWTNrubN9vnz1A+KurNCVEPJEfMI2xgx8LsWcKvCETqwnXlu
	 Q+DaAbmacg8qz7dlmPvZDPKcl6GBue9nclM7VAe7qvUwdvw4uTGS/H8Xa/rTxKtbkM
	 peX1uVlRoJi0g==
Received: from x201s (193-104-135-243.ip4.fiberby.net [193.104.135.243])
	by mail1.fiberby.net (Postfix) with ESMTPSA id 79C3B6007E;
	Sat, 13 Jul 2024 02:19:19 +0000 (UTC)
Received: by x201s (Postfix, from userid 1000)
	id CF671204DC1; Sat, 13 Jul 2024 02:19:12 +0000 (UTC)
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
	Donald Hunter <donald.hunter@gmail.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v4 12/13] flow_dissector: set encapsulation control flags for non-IP
Date: Sat, 13 Jul 2024 02:19:09 +0000
Message-ID: <20240713021911.1631517-13-ast@fiberby.net>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240713021911.1631517-1-ast@fiberby.net>
References: <20240713021911.1631517-1-ast@fiberby.net>
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
Reviewed-by: Davide Caratti <dcaratti@redhat.com>
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


