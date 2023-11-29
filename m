Return-Path: <netdev+bounces-51969-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CF9137FCCE4
	for <lists+netdev@lfdr.de>; Wed, 29 Nov 2023 03:31:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0CCEB1C20FDA
	for <lists+netdev@lfdr.de>; Wed, 29 Nov 2023 02:31:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 540081FDC;
	Wed, 29 Nov 2023 02:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="I4OIN6Wy"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80008.amazon.com (smtp-fw-80008.amazon.com [99.78.197.219])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A34ED1988
	for <netdev@vger.kernel.org>; Tue, 28 Nov 2023 18:30:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1701225059; x=1732761059;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=S0V7UY4umsXnW0jC2QO0vstnVRmxLJ3lYn0stDsSQGk=;
  b=I4OIN6WyW0r5S8VZw0Q4/LahTw37OOREJ9c0YOqopHDg3SEiNI9OrCTK
   KgEhQTVRRa2D6eF+4eE0AYacv5lb2SsePDnN5auLgH8W0nx9Ewo9H4Des
   N4cEb3oPQpawyj/l++fUkjyJBa1fRzFSFquH9FeYdNMwCtmprEti/t1Fe
   0=;
X-IronPort-AV: E=Sophos;i="6.04,234,1695686400"; 
   d="scan'208";a="47016998"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO email-inbound-relay-pdx-2b-m6i4x-32fb4f1a.us-west-2.amazon.com) ([10.25.36.214])
  by smtp-border-fw-80008.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2023 02:30:59 +0000
Received: from smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev (pdx2-ws-svc-p26-lb5-vlan2.pdx.amazon.com [10.39.38.66])
	by email-inbound-relay-pdx-2b-m6i4x-32fb4f1a.us-west-2.amazon.com (Postfix) with ESMTPS id C2A91C0142;
	Wed, 29 Nov 2023 02:30:58 +0000 (UTC)
Received: from EX19MTAUWA002.ant.amazon.com [10.0.38.20:13342]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.31.8:2525] with esmtp (Farcaster)
 id b611c4fa-d6d4-4a57-8157-539f8e9f1944; Wed, 29 Nov 2023 02:30:58 +0000 (UTC)
X-Farcaster-Flow-ID: b611c4fa-d6d4-4a57-8157-539f8e9f1944
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.39; Wed, 29 Nov 2023 02:30:58 +0000
Received: from 88665a182662.ant.amazon.com (10.37.244.8) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Wed, 29 Nov 2023 02:30:54 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@amazon.com>,
	Kuniyuki Iwashima <kuni1840@gmail.com>, <netdev@vger.kernel.org>, "Eric
 Dumazet" <edumazert@google.com>
Subject: [PATCH v3 net-next 3/8] tcp: Clean up goto labels in cookie_v[46]_check().
Date: Tue, 28 Nov 2023 18:29:19 -0800
Message-ID: <20231129022924.96156-4-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20231129022924.96156-1-kuniyu@amazon.com>
References: <20231129022924.96156-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D040UWB004.ant.amazon.com (10.13.138.91) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)
Precedence: Bulk

We will support arbitrary SYN Cookie with BPF, and then reqsk
will be preallocated before cookie_v[46]_check().

Depending on how validation fails, we send RST or just drop skb.

To make the error handling easier, let's clean up goto labels.

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Reviewed-by: Eric Dumazet <edumazert@google.com>
---
 net/ipv4/syncookies.c | 22 +++++++++++-----------
 net/ipv6/syncookies.c |  4 ++--
 2 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/net/ipv4/syncookies.c b/net/ipv4/syncookies.c
index fb41bb18fe6b..8b7d7d7788af 100644
--- a/net/ipv4/syncookies.c
+++ b/net/ipv4/syncookies.c
@@ -376,11 +376,10 @@ struct sock *cookie_v4_check(struct sock *sk, struct sk_buff *skb)
 	if (!cookie_timestamp_decode(net, &tcp_opt))
 		goto out;
 
-	ret = NULL;
 	req = cookie_tcp_reqsk_alloc(&tcp_request_sock_ops,
 				     &tcp_request_sock_ipv4_ops, sk, skb);
 	if (!req)
-		goto out;
+		goto out_drop;
 
 	ireq = inet_rsk(req);
 	treq = tcp_rsk(req);
@@ -415,10 +414,8 @@ struct sock *cookie_v4_check(struct sock *sk, struct sk_buff *skb)
 	 */
 	RCU_INIT_POINTER(ireq->ireq_opt, tcp_v4_save_options(net, skb));
 
-	if (security_inet_conn_request(sk, skb, req)) {
-		reqsk_free(req);
-		goto out;
-	}
+	if (security_inet_conn_request(sk, skb, req))
+		goto out_free;
 
 	req->num_retrans = 0;
 
@@ -435,10 +432,8 @@ struct sock *cookie_v4_check(struct sock *sk, struct sk_buff *skb)
 			   ireq->ir_loc_addr, th->source, th->dest, sk->sk_uid);
 	security_req_classify_flow(req, flowi4_to_flowi_common(&fl4));
 	rt = ip_route_output_key(net, &fl4);
-	if (IS_ERR(rt)) {
-		reqsk_free(req);
-		goto out;
-	}
+	if (IS_ERR(rt))
+		goto out_free;
 
 	/* Try to redo what tcp_v4_send_synack did. */
 	req->rsk_window_clamp = tp->window_clamp ? :dst_metric(&rt->dst, RTAX_WINDOW);
@@ -462,5 +457,10 @@ struct sock *cookie_v4_check(struct sock *sk, struct sk_buff *skb)
 	 */
 	if (ret)
 		inet_sk(ret)->cork.fl.u.ip4 = fl4;
-out:	return ret;
+out:
+	return ret;
+out_free:
+	reqsk_free(req);
+out_drop:
+	return NULL;
 }
diff --git a/net/ipv6/syncookies.c b/net/ipv6/syncookies.c
index ba394fa73f41..106376cbc9de 100644
--- a/net/ipv6/syncookies.c
+++ b/net/ipv6/syncookies.c
@@ -172,11 +172,10 @@ struct sock *cookie_v6_check(struct sock *sk, struct sk_buff *skb)
 	if (!cookie_timestamp_decode(net, &tcp_opt))
 		goto out;
 
-	ret = NULL;
 	req = cookie_tcp_reqsk_alloc(&tcp6_request_sock_ops,
 				     &tcp_request_sock_ipv6_ops, sk, skb);
 	if (!req)
-		goto out;
+		goto out_drop;
 
 	ireq = inet_rsk(req);
 	treq = tcp_rsk(req);
@@ -269,5 +268,6 @@ struct sock *cookie_v6_check(struct sock *sk, struct sk_buff *skb)
 	return ret;
 out_free:
 	reqsk_free(req);
+out_drop:
 	return NULL;
 }
-- 
2.30.2


