Return-Path: <netdev+bounces-90940-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 559FF8B0BA2
	for <lists+netdev@lfdr.de>; Wed, 24 Apr 2024 15:56:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 78DA11C22898
	for <lists+netdev@lfdr.de>; Wed, 24 Apr 2024 13:56:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B85D15EFD4;
	Wed, 24 Apr 2024 13:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Q/gpswZ2"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B27EB15EFC6
	for <netdev@vger.kernel.org>; Wed, 24 Apr 2024 13:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713966890; cv=none; b=sFDvcR783hRbQs8PZ/arix6r5WbbtfYGELVAnJJVfsYUwrxkucRaWulcJXlMq/rczDQ+0+Di2fTGKQwdHXhiqAT1XjmbZd7ZIJPWGF/UQ8u+RtH8YjGj/OYRgDqSX44qlcg2lHciiOfHs8qEIA0zDO/BWrDPaN6xb1jBIztHDzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713966890; c=relaxed/simple;
	bh=n+RkZRic6ie2G6KEet41avGQwCdtOj5Z3lDU2WqxhVM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PeOs8Pq3ZLA6eTrXXF1iKywF7PruoJ53vdDz+iQ+Rtz3RZ7V+rMrj9aUCcWHcHpLAtUEbV41v1bs7BaETGiQBkDxg1yxSBWUNtsTqdrk1W99iPfZQXUXB71n8DPCkeRtRtFIF7SrTitPvu4MRlOQX9b/Vvk00mQUSX4A0CDH3Ys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Q/gpswZ2; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713966887;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LGEwg3DBg8RjmiswLmLzz0YVtT2CJ7TbhBWyCbgcMoQ=;
	b=Q/gpswZ2Hi26RIQK7BUY0cBciyxt04i7Pje/YxEi3Pw5sMQJlkosBlFZyVSG5/APVTIdcz
	FjL7NZPFqempxVBZG88bY0zmrz9nB5VVFmxd2z6O8EHagDn2ss7W84yKAsoYyOl10ZvOO9
	Jd46lw+2HxUjSYbEPHskvvHuPV/uPrY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-656-Vzx_EQ-XMa24eb4s9v5pQA-1; Wed, 24 Apr 2024 09:54:44 -0400
X-MC-Unique: Vzx_EQ-XMa24eb4s9v5pQA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id EC52A104D537;
	Wed, 24 Apr 2024 13:54:43 +0000 (UTC)
Received: from antares.redhat.com (unknown [10.39.193.98])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 902EC1C060D0;
	Wed, 24 Apr 2024 13:54:41 +0000 (UTC)
From: Adrian Moreno <amorenoz@redhat.com>
To: netdev@vger.kernel.org
Cc: aconole@redhat.com,
	echaudro@redhat.com,
	horms@kernel.org,
	i.maximets@ovn.org,
	Adrian Moreno <amorenoz@redhat.com>,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Cong Wang <xiyou.wangcong@gmail.com>,
	Jiri Pirko <jiri@resnulli.us>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next 5/8] net: sched: act_sample: add action cookie to sample
Date: Wed, 24 Apr 2024 15:50:52 +0200
Message-ID: <20240424135109.3524355-6-amorenoz@redhat.com>
In-Reply-To: <20240424135109.3524355-1-amorenoz@redhat.com>
References: <20240424135109.3524355-1-amorenoz@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7

If the action has a user_cookie, pass it along to the sample so it can
be easily identified.

Signed-off-by: Adrian Moreno <amorenoz@redhat.com>
---
 net/sched/act_sample.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/net/sched/act_sample.c b/net/sched/act_sample.c
index a69b53d54039..5c3f86ec964a 100644
--- a/net/sched/act_sample.c
+++ b/net/sched/act_sample.c
@@ -165,9 +165,11 @@ TC_INDIRECT_SCOPE int tcf_sample_act(struct sk_buff *skb,
 				     const struct tc_action *a,
 				     struct tcf_result *res)
 {
+	u8 cookie_data[TC_COOKIE_MAX_SIZE] = {};
 	struct tcf_sample *s = to_sample(a);
 	struct psample_group *psample_group;
 	struct psample_metadata md = {};
+	struct tc_cookie *user_cookie;
 	int retval;
 
 	tcf_lastuse_update(&s->tcf_tm);
@@ -189,6 +191,16 @@ TC_INDIRECT_SCOPE int tcf_sample_act(struct sk_buff *skb,
 		if (skb_at_tc_ingress(skb) && tcf_sample_dev_ok_push(skb->dev))
 			skb_push(skb, skb->mac_len);
 
+		rcu_read_lock();
+		user_cookie = rcu_dereference(a->user_cookie);
+		if (user_cookie) {
+			memcpy(cookie_data, user_cookie->data,
+			       user_cookie->len);
+			md.user_cookie = cookie_data;
+			md.user_cookie_len = user_cookie->len;
+		}
+		rcu_read_unlock();
+
 		md.trunc_size = s->truncate ? s->trunc_size : skb->len;
 		psample_sample_packet(psample_group, skb, s->rate, &md);
 
-- 
2.44.0


