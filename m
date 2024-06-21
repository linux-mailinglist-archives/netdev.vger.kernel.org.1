Return-Path: <netdev+bounces-105629-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DC8439121DA
	for <lists+netdev@lfdr.de>; Fri, 21 Jun 2024 12:13:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8BD041F28A6F
	for <lists+netdev@lfdr.de>; Fri, 21 Jun 2024 10:13:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F625174EE4;
	Fri, 21 Jun 2024 10:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LC+VMVId"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEA00172BB9
	for <netdev@vger.kernel.org>; Fri, 21 Jun 2024 10:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718964707; cv=none; b=g/26c8mmYwmJyWHGM+R5X8CliNHC+OVO2uhTuvhKenXZdXfewddvs/jytjbhdn9KNrzGI7y3i1LE6j4WXIdXRlHF41TYsq1nDMreORFfUHDVGPjwib6ZgQ7CDZDdLbDAzt/8fd1wXB5wNrkvcQMZcYAK1XZ+G+m0EXb1pd8XX3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718964707; c=relaxed/simple;
	bh=tQLqrrhieXejhc2zQDIr/lm/fO9IwZHD2PmckuwjCls=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s6/SeHGKW0nkSGsJTfgfW1eTvahitimKeGeyc/OFNF3hjydUJMfaPt2phM5T8Mrw6w6TGLEdGV8pkSCn5g+PlhyYdH/WH8rdx5b9RWu/S1hrdFZnhIptZcIwP1WihHoM4DczvFgLP48+xzRDeq73GYucATYubctlXJHRqfVAoQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LC+VMVId; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718964705;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=h0NOprsJcSaID2DYqd51khJk0uqLDdoFanepxFJiHOE=;
	b=LC+VMVIdfe5/+yzK9piAXMYXdUHvcHZ6mMI3TFoIjH8+0hktSA3qv7kslD7JMUn0iiV33t
	TVre4LGp8O684kHgKsY2pICtBYVkIku+5bViVOOtq4Y7UPsYMUnBE1Ap1JrA2jZsnH4nUV
	T2ERHjJbV92hs/hnSMvXofNazDTUTFY=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-458-lPzi7fEvNhuo6SFkukA20g-1; Fri,
 21 Jun 2024 06:11:39 -0400
X-MC-Unique: lPzi7fEvNhuo6SFkukA20g-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7815919560A0;
	Fri, 21 Jun 2024 10:11:37 +0000 (UTC)
Received: from antares.redhat.com (unknown [10.39.193.189])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 4834C1956048;
	Fri, 21 Jun 2024 10:11:32 +0000 (UTC)
From: Adrian Moreno <amorenoz@redhat.com>
To: netdev@vger.kernel.org
Cc: aconole@redhat.com,
	echaudro@redhat.com,
	horms@kernel.org,
	i.maximets@ovn.org,
	dev@openvswitch.org,
	Adrian Moreno <amorenoz@redhat.com>,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Cong Wang <xiyou.wangcong@gmail.com>,
	Jiri Pirko <jiri@resnulli.us>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v4 02/10] net: sched: act_sample: add action cookie to sample
Date: Fri, 21 Jun 2024 12:10:54 +0200
Message-ID: <20240621101113.2185308-3-amorenoz@redhat.com>
In-Reply-To: <20240621101113.2185308-1-amorenoz@redhat.com>
References: <20240621101113.2185308-1-amorenoz@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

If the action has a user_cookie, pass it along to the sample so it can
be easily identified.

Signed-off-by: Adrian Moreno <amorenoz@redhat.com>
---
 net/sched/act_sample.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/net/sched/act_sample.c b/net/sched/act_sample.c
index a69b53d54039..2ceb4d141b71 100644
--- a/net/sched/act_sample.c
+++ b/net/sched/act_sample.c
@@ -167,7 +167,9 @@ TC_INDIRECT_SCOPE int tcf_sample_act(struct sk_buff *skb,
 {
 	struct tcf_sample *s = to_sample(a);
 	struct psample_group *psample_group;
+	u8 cookie_data[TC_COOKIE_MAX_SIZE];
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
2.45.1


