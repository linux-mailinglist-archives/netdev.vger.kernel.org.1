Return-Path: <netdev+bounces-121510-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 59E4E95D7BC
	for <lists+netdev@lfdr.de>; Fri, 23 Aug 2024 22:24:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 10F5E2820E8
	for <lists+netdev@lfdr.de>; Fri, 23 Aug 2024 20:24:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85245195381;
	Fri, 23 Aug 2024 20:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=herbertland.com header.i=@herbertland.com header.b="O5+/ug4e"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C4B01940B5
	for <netdev@vger.kernel.org>; Fri, 23 Aug 2024 20:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724444179; cv=none; b=mDFaLQrV3al5KkWe5VyglNmYt71F/4+Kywp4CnuRUUNueltvcG0TrU1/PzmChBFCfc+RSntCrEVM3BuaMv9JZhCPbwandqSoqUjb/y84+KCcKBUqdcAxsIrRTYWqmtKvMxKfzmhZt1B65486QNTkEtLtBTTjrcM4Ab0cj9+fj2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724444179; c=relaxed/simple;
	bh=F6OllGcU6yuYlZOEbg/dfHvFSpbltkoo+4zTmYf1kRA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=aqqyCGrhGtvtAuG7Dyo4EORNCvSLWeE92sERx1Hsc+lYHQ4oYONC6yc+sOppXlbhs/gix/rE7QQIbVrD5uIBA7rUSx04oGV25tfA9OW8/dpkaqEvau03V7UnWj+3dYZ1v0fsWjG7IZephMVS1Xq7SP9nHqu0hY7BT/QZ7Jfgk00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=herbertland.com; spf=pass smtp.mailfrom=herbertland.com; dkim=pass (2048-bit key) header.d=herbertland.com header.i=@herbertland.com header.b=O5+/ug4e; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=herbertland.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=herbertland.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-7141feed424so2183020b3a.2
        for <netdev@vger.kernel.org>; Fri, 23 Aug 2024 13:16:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=herbertland.com; s=google; t=1724444177; x=1725048977; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HWXbPxeYHeGajvaLgNvKzNYOpsN47QGTGqJHcAwu8Dk=;
        b=O5+/ug4eCBzK8qBaC6rfhdDjAxE0S17MXmqtiV4t5mTdhqj2Zjhdeyv+NG80Ogar/a
         Xx8LjuhL9nkC39jZoQk5yoVjoEPzbqawV6t6TbBQ7WTXO1S8bow4lT7x7j+thVw/66w1
         3S86E2Uvv2p+onCgrxX+feOVNMY+4S33dNhBKIN11j4F2sGLtNWGqacwOIJQeJnRqr2h
         HoUOvsS/uSqJk8NE/e3CFsSAe16YzQtapMEMkySLl41oiuKUMiNAnvWnUAvhRL35UFoQ
         wq74LbKk1EIBVGDwlWsS0a2B83mRqxHMDq1Mx7aC8TqOeTZRX1QGE6tj2mO+PciNpXFx
         dnvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724444177; x=1725048977;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HWXbPxeYHeGajvaLgNvKzNYOpsN47QGTGqJHcAwu8Dk=;
        b=nV1mItjcYeK3Af0qay8ItmbrNOTolVXP14kUP0kjje+Yi24UvC8pN2GDUL/BpXHmUd
         aTG5qBt0ge31bs3YxdioG0PP4Rfhp0F4pvgg7F44H/yIxabxvE2/Ja2+Er4RE2loy+qb
         QNqPMlM7AQy5WNphnhxM5ceUJ7QCvdbKFfmM5ZQ32PLAJLZnF0P90TBPjqgRsdHTikEl
         BW0N/U1yMHHQWJOUiUKRgt51C8PfGl0bUOrXNxwiRpujjx2PcyKq1Dg8O5wOeNQ0Imul
         gsw1kJfxJ0Il6Cp0U6lNaDx5cl2xUEvD8xuKScKcbHoo1ViF9OcwuytOnr5Sz7LUqn/T
         EXwQ==
X-Forwarded-Encrypted: i=1; AJvYcCU6yxQzkyUW1m6TWlZvlYJ6hGmH3MEYXDLoE3PvVfl4h25RyshNF9/F+FfaUIrXQ0O7fYSrAzs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTCa8TSRFdv/tYwSLZX4ZhImVsXogBzL236/wY+AHaRLVyjTvB
	41Y7uPKItS8dBNqeM7ElfXCFVrtMv7N2ia/q1D7HOICIbHAdOUmmaNYgDQCg/w==
X-Google-Smtp-Source: AGHT+IGpc/wS9dPsrNyYf8JqoIj76FyNgWP2n1I8Tj+k0jz7XGj54fPdDoeOGNqVHUZJD46bStyn2Q==
X-Received: by 2002:a05:6a00:3ccc:b0:714:1bd8:35f7 with SMTP id d2e1a72fcca58-71445d5a9a7mr3459014b3a.15.1724444177253;
        Fri, 23 Aug 2024 13:16:17 -0700 (PDT)
Received: from TomsPC.home ([2601:646:8300:55f0:9169:3766:b678:8be3])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7143422ec1csm3428525b3a.39.2024.08.23.13.16.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Aug 2024 13:16:16 -0700 (PDT)
From: Tom Herbert <tom@herbertland.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	edumazet@google.com,
	netdev@vger.kernel.org,
	felipe@sipanda.io,
	willemdebruijn.kernel@gmail.com,
	pablo@netfilter.org,
	laforge@gnumonks.org,
	xeb@mail.ru
Cc: Tom Herbert <tom@herbertland.com>,
	Willem de Bruijn <willemb@google.com>
Subject: [PATCH net-next v4 07/13] flow_dissector: Parse foo-over-udp (FOU)
Date: Fri, 23 Aug 2024 13:15:51 -0700
Message-Id: <20240823201557.1794985-8-tom@herbertland.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240823201557.1794985-1-tom@herbertland.com>
References: <20240823201557.1794985-1-tom@herbertland.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Parse FOU by getting the FOU protocol from the matching socket.
This includes moving "struct fou" and "fou_from_sock" to fou.h

Reviewed-by: Willem de Bruijn <willemb@google.com>
Signed-off-by: Tom Herbert <tom@herbertland.com>
---
 include/net/fou.h         | 16 ++++++++++++++++
 net/core/flow_dissector.c | 12 ++++++++++++
 net/ipv4/fou_core.c       | 16 ----------------
 3 files changed, 28 insertions(+), 16 deletions(-)

diff --git a/include/net/fou.h b/include/net/fou.h
index 824eb4b231fd..8574767b91b6 100644
--- a/include/net/fou.h
+++ b/include/net/fou.h
@@ -17,6 +17,22 @@ int __fou_build_header(struct sk_buff *skb, struct ip_tunnel_encap *e,
 int __gue_build_header(struct sk_buff *skb, struct ip_tunnel_encap *e,
 		       u8 *protocol, __be16 *sport, int type);
 
+struct fou {
+	struct socket *sock;
+	u8 protocol;
+	u8 flags;
+	__be16 port;
+	u8 family;
+	u16 type;
+	struct list_head list;
+	struct rcu_head rcu;
+};
+
+static inline struct fou *fou_from_sock(struct sock *sk)
+{
+	return sk->sk_user_data;
+}
+
 int register_fou_bpf(void);
 
 #endif
diff --git a/net/core/flow_dissector.c b/net/core/flow_dissector.c
index 49feea3fec56..e8760c1182b1 100644
--- a/net/core/flow_dissector.c
+++ b/net/core/flow_dissector.c
@@ -8,6 +8,7 @@
 #include <linux/filter.h>
 #include <net/dsa.h>
 #include <net/dst_metadata.h>
+#include <net/fou.h>
 #include <net/ip.h>
 #include <net/ipv6.h>
 #include <net/gre.h>
@@ -855,6 +856,7 @@ __skb_flow_dissect_udp(const struct sk_buff *skb, const struct net *net,
 		       u8 *p_ip_proto, int base_nhoff, unsigned int flags,
 		       unsigned int num_hdrs)
 {
+	__u8 encap_type, fou_protocol;
 	enum flow_dissect_ret ret;
 	struct udphdr _udph;
 	int nhoff;
@@ -905,6 +907,9 @@ __skb_flow_dissect_udp(const struct sk_buff *skb, const struct net *net,
 		}
 
 		encap_type = udp_sk(sk)->encap_type;
+		if (encap_type == UDP_ENCAP_FOU)
+			fou_protocol = fou_from_sock(sk)->protocol;
+
 		rcu_read_unlock();
 
 		break;
@@ -943,6 +948,9 @@ __skb_flow_dissect_udp(const struct sk_buff *skb, const struct net *net,
 		}
 
 		encap_type = udp_sk(sk)->encap_type;
+		if (encap_type == UDP_ENCAP_FOU)
+			fou_protocol = fou_from_sock(sk)->protocol;
+
 		rcu_read_unlock();
 
 		break;
@@ -957,6 +965,10 @@ __skb_flow_dissect_udp(const struct sk_buff *skb, const struct net *net,
 	ret = FLOW_DISSECT_RET_OUT_GOOD;
 
 	switch (encap_type) {
+	case UDP_ENCAP_FOU:
+		*p_ip_proto = fou_protocol;
+		ret = FLOW_DISSECT_RET_IPPROTO_AGAIN;
+		break;
 	case UDP_ENCAP_VXLAN:
 	case UDP_ENCAP_VXLAN_GPE:
 		ret = __skb_flow_dissect_vxlan(skb, flow_dissector,
diff --git a/net/ipv4/fou_core.c b/net/ipv4/fou_core.c
index 8241f762e45b..137eb80c56a2 100644
--- a/net/ipv4/fou_core.c
+++ b/net/ipv4/fou_core.c
@@ -21,17 +21,6 @@
 
 #include "fou_nl.h"
 
-struct fou {
-	struct socket *sock;
-	u8 protocol;
-	u8 flags;
-	__be16 port;
-	u8 family;
-	u16 type;
-	struct list_head list;
-	struct rcu_head rcu;
-};
-
 #define FOU_F_REMCSUM_NOPARTIAL BIT(0)
 
 struct fou_cfg {
@@ -48,11 +37,6 @@ struct fou_net {
 	struct mutex fou_lock;
 };
 
-static inline struct fou *fou_from_sock(struct sock *sk)
-{
-	return sk->sk_user_data;
-}
-
 static int fou_recv_pull(struct sk_buff *skb, struct fou *fou, size_t len)
 {
 	/* Remove 'len' bytes from the packet (UDP header and
-- 
2.34.1


