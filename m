Return-Path: <netdev+bounces-114643-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 361399434F1
	for <lists+netdev@lfdr.de>; Wed, 31 Jul 2024 19:24:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF77B1F23257
	for <lists+netdev@lfdr.de>; Wed, 31 Jul 2024 17:24:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 947E71BE24F;
	Wed, 31 Jul 2024 17:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=herbertland.com header.i=@herbertland.com header.b="a9dUDKZU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C50441BBBC8
	for <netdev@vger.kernel.org>; Wed, 31 Jul 2024 17:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722446644; cv=none; b=hYrEXnlxD5ZyLDx8U/zhumAsB6e8yf67zGNFG29hMKvppo2evESSL1qRCJciK/wRpaM/odDgp4x9C6sOuLVD6qWSohqYmZIArcdY+idv/+/iPfSi5+q37G81M4Yd0Xnk3jx/FGwd6OKeu/DmVDU9G6J1cVa3A9YeXRiKAXtg+es=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722446644; c=relaxed/simple;
	bh=5oMCYIU9XJTq0+hsLqOXoAjN+GZqSaq42fdG5HmWJPI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ncBaXUW9veQYV+JZp52jOxXLNxjJMvPnWIF1kuT8qzKDYMpfxZnQCUxvJnG7fnTAXBfZm6cESQ6vBZqdolGv99WlRvEVQyjpWeDvdFRiZuxG0A1J7sDdJx08bgueJmmtsYdPWkqSt1E4tWomD3dI9JSqji96pn17WM1snmfdqis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=herbertland.com; spf=pass smtp.mailfrom=herbertland.com; dkim=pass (2048-bit key) header.d=herbertland.com header.i=@herbertland.com header.b=a9dUDKZU; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=herbertland.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=herbertland.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-70eae5896bcso5257013b3a.2
        for <netdev@vger.kernel.org>; Wed, 31 Jul 2024 10:24:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=herbertland.com; s=google; t=1722446642; x=1723051442; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m8FUT5Xp4+XwB5Y+5gBGNeICx/92cKno6YcckxURgOM=;
        b=a9dUDKZUiAmhS3MMdyMpua9TZgi64ebFzIxnubOAWuSDicJS9QLoZk2E8wH11iY5Wu
         me+zNXAYGIEFhVNwZlRFZpPn3cAXHfq6XbpluXdgCV3bM6v/YtsI72uMRo+twaV72BDC
         RM4QF0jfjKj/krVyngjBti1WwTbi7mTktQqEQRSJOjQ7bQevd2Kfd9V3Fn1HVc9FhkeT
         pYDftX73/iuoyrzN63NiLBvLHejDc4sHkBmyBD9ldWyi8D+xGsmYZ65z8DCcEN2Nk/7Z
         4qIOghOuTst7p5xhRehagc5x32fOufqwLbr4Gp5MvqH7sfwaI8SmhDR/gIkBUN+MddP6
         ukvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722446642; x=1723051442;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m8FUT5Xp4+XwB5Y+5gBGNeICx/92cKno6YcckxURgOM=;
        b=AKqTyvP4ALbg0oDr2SBqUc0QAQgccEuwZRZg+1QHF6eyxzlXvMXg7nKG90to/wNFMc
         ZFkdiltkJjeM5gwyu8cHng5826Rnb4O7VCHvcoRWYqeO1XxJaq1IK4wqpzPvSD+KyUfM
         AVOlRkV9XLdmOXLY6CrVgFDJAzigrW6IvLLGfvq7jewwnicBMn2BoUfwy1gKHvws3VWZ
         cyP+R/olgx5ewC9Ua02n2l0Bo2+xTwjvXObg61s391gxM5z+wJkK5TpUduPQZBukyqFt
         4IvvjISS647d0pQGudzphDYN1j2Qd4UoC5pESFFxm5lEP0b9QnVljlEHg4RRctK3Do+E
         FyNA==
X-Forwarded-Encrypted: i=1; AJvYcCXSjh/ZwTGuYo5kXYpXuiE21rJh3WLmgiJpXn2CGbPW3FSLsjbZRLVKcfreR5vnLdHzEax1eSRIZ+XWcOTL/hsJAXDLyEz2
X-Gm-Message-State: AOJu0Yx8iFP/VWVYc1klQHr1q2FQFga84BQdLsibBZAfZFVQwkGBT5Fj
	wDxvt5g1B4stdPsPaaS9jVP/Pm4mH8GzHdk0fXLuJiVJGs4GqYd+pdKR5AuoEg==
X-Google-Smtp-Source: AGHT+IGNBQ1halh5m9PUDBr7sefo5cIqvF4C7P67NCrvbkftDM7cGyMZyg+AkfQD3y9noOa6+qn7hA==
X-Received: by 2002:a05:6a20:394d:b0:1c4:c795:ee6a with SMTP id adf61e73a8af0-1c68cf8d06emr159626637.28.1722446642090;
        Wed, 31 Jul 2024 10:24:02 -0700 (PDT)
Received: from TomsPC.home ([2601:646:8300:55f0:be07:e41f:5184:de2f])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70ead72ab97sm10487203b3a.92.2024.07.31.10.24.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jul 2024 10:24:01 -0700 (PDT)
From: Tom Herbert <tom@herbertland.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	edumazet@google.com,
	netdev@vger.kernel.org,
	felipe@sipanda.io
Cc: Tom Herbert <tom@herbertland.com>
Subject: [PATCH 08/12] flow_dissector: Parse foo-over-udp (FOU)
Date: Wed, 31 Jul 2024 10:23:28 -0700
Message-Id: <20240731172332.683815-9-tom@herbertland.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240731172332.683815-1-tom@herbertland.com>
References: <20240731172332.683815-1-tom@herbertland.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Parse FOU by getting the FOU protocol from the matching socket.
This includes moving "struct fou" and "fou_from_sock" to fou.h

Signed-off-by: Tom Herbert <tom@herbertland.com>
---
 include/net/fou.h         | 16 ++++++++++++++++
 net/core/flow_dissector.c | 13 ++++++++++++-
 net/ipv4/fou_core.c       | 16 ----------------
 3 files changed, 28 insertions(+), 17 deletions(-)

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
index 6ad45b09dda4..68906c4bb474 100644
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
@@ -865,11 +866,11 @@ __skb_flow_dissect_udp(const struct sk_buff *skb, struct net *net,
 		       int *p_nhoff, int hlen, __be16 *p_proto,
 		       u8 *p_ip_proto, int bpoff, unsigned int flags)
 {
+	__u8 encap_type, fou_protocol;
 	enum flow_dissect_ret ret;
 	const struct udphdr *udph;
 	struct udphdr _udph;
 	struct sock *sk;
-	__u8 encap_type;
 	int nhoff;
 
 	if (!(flags & FLOW_DISSECTOR_F_PARSE_UDP_ENCAPS))
@@ -902,6 +903,9 @@ __skb_flow_dissect_udp(const struct sk_buff *skb, struct net *net,
 		}
 
 		encap_type = udp_sk(sk)->encap_type;
+		if (encap_type == UDP_ENCAP_FOU)
+			fou_protocol = fou_from_sock(sk)->protocol;
+
 		rcu_read_unlock();
 
 		break;
@@ -932,6 +936,9 @@ __skb_flow_dissect_udp(const struct sk_buff *skb, struct net *net,
 		}
 
 		encap_type = udp_sk(sk)->encap_type;
+		if (encap_type == UDP_ENCAP_FOU)
+			fou_protocol = fou_from_sock(sk)->protocol;
+
 		rcu_read_unlock();
 
 		break;
@@ -944,6 +951,10 @@ __skb_flow_dissect_udp(const struct sk_buff *skb, struct net *net,
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


