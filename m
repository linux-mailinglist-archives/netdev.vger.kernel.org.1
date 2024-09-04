Return-Path: <netdev+bounces-125034-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1E1296BACF
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 13:33:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B14F4B24158
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 11:33:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D91B01D097A;
	Wed,  4 Sep 2024 11:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="dYw58Eyw"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 435361D0DD2
	for <netdev@vger.kernel.org>; Wed,  4 Sep 2024 11:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725449560; cv=none; b=YAaMJp6+ky/JAwiKS/iTAyQLskigt7jO/lzs/JiBm5Lgyb3mihkS6oVRDzTVHAi9CwdUPFcFIAXTgdm4iR51vY+t2LDpYmDhyjK4IHmLLbhRHXom86YkrL9SRTalNVNHCi9pqGmXXYq1JP+EOc4ln1DRtTJLojH1yUrIAWmKeiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725449560; c=relaxed/simple;
	bh=wNYK6QH7zSD+J5G5OKo1k7Kf2Jkt8fliFsjSVsP1GEg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kt5XdGC6treMrUogQn51QW/JKIuc6EMWhi1W3ad0SW/6oEWe9m+aE18vAIYFC+o1j0AMLtC0y0WMDkJ1JjftaAyXP+UG2yk+QMK246t/l3g3v+SH50VpjrvL1JmpiArfQjb6oHU7iSDpuLHT6qng7YuKtvsbgXbFTy7OPsUVmEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=dYw58Eyw; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 483NmIQA001461;
	Wed, 4 Sep 2024 04:32:23 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from
	:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	s2048-2021-q4; bh=aVDiHZV6S8MY1wUATCCMWMq391FSlOAHS7UpIyVNqqk=; b=
	dYw58EywSPgOcKL4OZUWWWH3iIOD5AH0gUIQP7pLowFcC9bNXz+eu6AOWZaXjHOG
	5BwY4t/jsjrL5mQISZaYSGfJNCXoYPnXEGDrOiASNYz7Ct6t9Tfg0+TdQEVtZqkl
	FHLq56E/+bdquVJU+0WeERXhKjCqnAY7roRZ6FFwYbLyz+WywoOzrz8Yd0w/zbtA
	lxOoOlU77uHRejWzgp1Th3zf158IikB85D2sVOY9TXDord5I9NKKE5l8Tni85PNW
	MSNrl/JQeGL0b+yN9nzhwKdVwNqrj8a3GnMQ1cVyEvGFEEIQx6EUfKtK9Sq+cKeD
	yDi0EaM3X2lmI9l/nHdV1A==
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 41dgyf2uqx-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Wed, 04 Sep 2024 04:32:23 -0700 (PDT)
Received: from devvm4158.cln0.facebook.com (2620:10d:c085:208::7cb7) by
 mail.thefacebook.com (2620:10d:c08b:78::2ac9) with Microsoft SMTP Server id
 15.2.1544.11; Wed, 4 Sep 2024 11:32:20 +0000
From: Vadim Fedorenko <vadfed@meta.com>
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>,
        Willem de Bruijn
	<willemb@google.com>,
        Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>,
        David Ahern <dsahern@kernel.org>,
        Jason Xing
	<kerneljasonxing@gmail.com>,
        Simon Horman <horms@kernel.org>
CC: Vadim Fedorenko <vadfed@meta.com>, <netdev@vger.kernel.org>
Subject: [PATCH net-next v3 2/4] net_tstamp: add SCM_TS_OPT_ID for TCP sockets
Date: Wed, 4 Sep 2024 04:31:49 -0700
Message-ID: <20240904113153.2196238-3-vadfed@meta.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20240904113153.2196238-1-vadfed@meta.com>
References: <20240904113153.2196238-1-vadfed@meta.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: 9i7zP0X6pVwdJ2ZjbUMVmh7BYgxc5ZKw
X-Proofpoint-ORIG-GUID: 9i7zP0X6pVwdJ2ZjbUMVmh7BYgxc5ZKw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-04_09,2024-09-04_01,2024-09-02_01

TCP sockets have different flow for providing timestamp OPT_ID value.
Adjust the code to support SCM_TS_OPT_ID option for TCP sockets.

Signed-off-by: Vadim Fedorenko <vadfed@meta.com>
---
 net/ipv4/tcp.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 8a5680b4e786..5553a8aeee80 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -474,9 +474,10 @@ void tcp_init_sock(struct sock *sk)
 }
 EXPORT_SYMBOL(tcp_init_sock);
 
-static void tcp_tx_timestamp(struct sock *sk, u16 tsflags)
+static void tcp_tx_timestamp(struct sock *sk, struct sockcm_cookie *sockc)
 {
 	struct sk_buff *skb = tcp_write_queue_tail(sk);
+	u32 tsflags = sockc->tsflags;
 
 	if (tsflags && skb) {
 		struct skb_shared_info *shinfo = skb_shinfo(skb);
@@ -485,8 +486,12 @@ static void tcp_tx_timestamp(struct sock *sk, u16 tsflags)
 		sock_tx_timestamp(sk, tsflags, &shinfo->tx_flags);
 		if (tsflags & SOF_TIMESTAMPING_TX_ACK)
 			tcb->txstamp_ack = 1;
-		if (tsflags & SOF_TIMESTAMPING_TX_RECORD_MASK)
-			shinfo->tskey = TCP_SKB_CB(skb)->seq + skb->len - 1;
+		if (tsflags & SOF_TIMESTAMPING_TX_RECORD_MASK) {
+			if (tsflags & SOCKCM_FLAG_TS_OPT_ID)
+				shinfo->tskey = sockc->ts_opt_id;
+			else
+				shinfo->tskey = TCP_SKB_CB(skb)->seq + skb->len - 1;
+		}
 	}
 }
 
@@ -1318,7 +1323,7 @@ int tcp_sendmsg_locked(struct sock *sk, struct msghdr *msg, size_t size)
 
 out:
 	if (copied) {
-		tcp_tx_timestamp(sk, sockc.tsflags);
+		tcp_tx_timestamp(sk, &sockc);
 		tcp_push(sk, flags, mss_now, tp->nonagle, size_goal);
 	}
 out_nopush:
-- 
2.43.5


