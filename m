Return-Path: <netdev+bounces-85758-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A556389BFB3
	for <lists+netdev@lfdr.de>; Mon,  8 Apr 2024 15:00:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6100A285CCA
	for <lists+netdev@lfdr.de>; Mon,  8 Apr 2024 13:00:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 125FA7D08A;
	Mon,  8 Apr 2024 12:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FdzsYkEK"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69BA57BAFD
	for <netdev@vger.kernel.org>; Mon,  8 Apr 2024 12:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712581113; cv=none; b=kivSEXuwDjxno2n2Mf+azw8glCGXuv8sExtprMEFkFxCAFPoOqEAbMe79Cai5ce0ejVOecXpG878waH3MFPjNTsp/A/KfhtQwQdh/ltNGwogzM4DB/r6ibzWLx7V9rPtvyDlfkULNgaalYmxCXYUGwFHmsnRNBQJ450zYH0d2vo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712581113; c=relaxed/simple;
	bh=n+RkZRic6ie2G6KEet41avGQwCdtOj5Z3lDU2WqxhVM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ni6uV5WTPWrNwxE+CmdH10Cayw/el+v8riEnCi/0XnL6bc6xtt7XaNJVjDEY0iFFI5JsWNKqJoEgmjylWrVpXePwHliKCEuZFpBThvk8ZAxXBUM1tEz64iKbQYRWpsp0UrLOtmeIWuxI1mgFKnumVeMp3LSO4Sh/QKKjSj6FmFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FdzsYkEK; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712581110;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LGEwg3DBg8RjmiswLmLzz0YVtT2CJ7TbhBWyCbgcMoQ=;
	b=FdzsYkEK0hfQAJgZoPurXk3V+UOQS3dw8YS60f69XPWsEArApM6VVF8DFldRAzuMd8zPPN
	VqZQgeDKOEZj9jsIxX2KsPT6XwhSteUDvMebPkKcec7l6urhrXCkgjhpT0p9otUIGkm1Mn
	yBQatGaHXo4UI8IaSBDeZTpyB1W4k6k=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-150-FvLOH6nXOeGOr91xDZIF-Q-1; Mon, 08 Apr 2024 08:58:27 -0400
X-MC-Unique: FvLOH6nXOeGOr91xDZIF-Q-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id ABBE980D0F7;
	Mon,  8 Apr 2024 12:58:26 +0000 (UTC)
Received: from antares.redhat.com (unknown [10.39.193.170])
	by smtp.corp.redhat.com (Postfix) with ESMTP id D988E47E;
	Mon,  8 Apr 2024 12:58:24 +0000 (UTC)
From: Adrian Moreno <amorenoz@redhat.com>
To: netdev@vger.kernel.org
Cc: Adrian Moreno <amorenoz@redhat.com>,
	jiri@resnulli.us,
	xiyou.wangcong@gmail.com,
	cmi@nvidia.com,
	yotam.gi@gmail.com,
	i.maximets@ovn.org,
	aconole@redhat.com,
	echaudro@redhat.com,
	horms@kernel.org
Subject: [RFC net-next v2 4/5] net:sched:act_sample: add action cookie to sample
Date: Mon,  8 Apr 2024 14:57:43 +0200
Message-ID: <20240408125753.470419-5-amorenoz@redhat.com>
In-Reply-To: <20240408125753.470419-1-amorenoz@redhat.com>
References: <20240408125753.470419-1-amorenoz@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1

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


