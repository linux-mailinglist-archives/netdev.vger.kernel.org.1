Return-Path: <netdev+bounces-108395-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A18D5923ACD
	for <lists+netdev@lfdr.de>; Tue,  2 Jul 2024 11:54:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1C039B246DB
	for <lists+netdev@lfdr.de>; Tue,  2 Jul 2024 09:54:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2F29158DBF;
	Tue,  2 Jul 2024 09:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J8pfE1FK"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40C1D157476
	for <netdev@vger.kernel.org>; Tue,  2 Jul 2024 09:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719914043; cv=none; b=B25kMx90OIB40V4XYCzgnIBicmRdxvS+4pDBdNqvG5MkK9wUwbHEz1dYNeSLy07ayCp2lEESLR9bjNzDn2Hz4ndAshy0PAKJ2d1Fv3e2l6bm4sGSYUAkdnHWI1EXl36y0wR6T8wANeJglibhJxzdvVb44D3m7KMBsMf2AKpYt6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719914043; c=relaxed/simple;
	bh=668DLLt2iCrNEA/gX4jKhVnzhKcv2VMABNF0u2ocQ8c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R7Mk3rUIATuUfYFJFp6xS4P89yhJ2c4gElFUx4Y2hYolN1GVd0wbYuPWno6BSVtgQx8xDIEQzp0Kc/Y9a+D3HjL4z4GvfeZzp8KwG1220CCB5Vnb/4FaKXWt/8P54gHLXdSi3vqQrDHuaglUs3YlM14tqZXulbDCMecd3JSQWQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=J8pfE1FK; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719914041;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dc9gehYXKMCZpGkeXyTZ1TC431RBkUDr4uz6wbMGuxk=;
	b=J8pfE1FKJSBuTDK8rXt01loiI9/Pg3ksTHIb/ejo3+JtAno6Sw0jG/jfeDtABpvMW8aVIb
	VWaCyiUihcpesaxF0+9VRvRCMEvD8gRifirmD/h1Lmj2H/fiyhFrY8eE2JbOvlABFaobKu
	ilYhjHEdV3J5NH0Lj8+EUxEmIE4nNZk=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-446-h17LZ06VPoagEFVfLuxSrg-1; Tue,
 02 Jul 2024 05:53:57 -0400
X-MC-Unique: h17LZ06VPoagEFVfLuxSrg-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id BAAA219373E5;
	Tue,  2 Jul 2024 09:53:54 +0000 (UTC)
Received: from antares.redhat.com (unknown [10.39.194.50])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 39A4319560AE;
	Tue,  2 Jul 2024 09:53:48 +0000 (UTC)
From: Adrian Moreno <amorenoz@redhat.com>
To: netdev@vger.kernel.org
Cc: aconole@redhat.com,
	echaudro@redhat.com,
	horms@kernel.org,
	i.maximets@ovn.org,
	dev@openvswitch.org,
	Adrian Moreno <amorenoz@redhat.com>,
	Ido Schimmel <idosch@nvidia.com>,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Cong Wang <xiyou.wangcong@gmail.com>,
	Jiri Pirko <jiri@resnulli.us>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v8 02/10] net: sched: act_sample: add action cookie to sample
Date: Tue,  2 Jul 2024 11:53:19 +0200
Message-ID: <20240702095336.596506-3-amorenoz@redhat.com>
In-Reply-To: <20240702095336.596506-1-amorenoz@redhat.com>
References: <20240702095336.596506-1-amorenoz@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

If the action has a user_cookie, pass it along to the sample so it can
be easily identified.

Reviewed-by: Aaron Conole <aconole@redhat.com>
Acked-by: Eelco Chaudron <echaudro@redhat.com>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
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
2.45.2


