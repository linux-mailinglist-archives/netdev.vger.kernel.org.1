Return-Path: <netdev+bounces-25948-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2792077642A
	for <lists+netdev@lfdr.de>; Wed,  9 Aug 2023 17:40:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 58D431C2118F
	for <lists+netdev@lfdr.de>; Wed,  9 Aug 2023 15:40:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADF391BB55;
	Wed,  9 Aug 2023 15:39:01 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A33F41BB4D
	for <netdev@vger.kernel.org>; Wed,  9 Aug 2023 15:39:01 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7279230F3
	for <netdev@vger.kernel.org>; Wed,  9 Aug 2023 08:38:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1691595526;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=a1BQhMgqgPp3+nYh9aEFWK0auNBBnQPFdlZFjZNHyi0=;
	b=GGVFbVBevXw1OBzNwippeNiGR3Oq4Ful7f05Aqor3BrftkmIPGob/v9DqLNWKd3/tuwEjF
	jEsEjhYLdlEO7IqB2ujftRkE7WhgAZJWr0KymrDknWHCQ1dDtYQ+F1kiQrgVnxaLLDqVTP
	boNaND4C1Vf1wNI94ObjkcHDF2Braeo=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-600-BtVQlXQtMMSiEVTqpwDnEg-1; Wed, 09 Aug 2023 11:38:45 -0400
X-MC-Unique: BtVQlXQtMMSiEVTqpwDnEg-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E64A538149B0;
	Wed,  9 Aug 2023 15:38:44 +0000 (UTC)
Received: from antares.redhat.com (unknown [10.39.193.45])
	by smtp.corp.redhat.com (Postfix) with ESMTP id C886C492C13;
	Wed,  9 Aug 2023 15:38:43 +0000 (UTC)
From: Adrian Moreno <amorenoz@redhat.com>
To: netdev@vger.kernel.org
Cc: Adrian Moreno <amorenoz@redhat.com>,
	aconole@redhat.com,
	i.maximets@ovn.org,
	eric@garver.life,
	dev@openvswitch.org
Subject: [net-next v4 4/7] net: openvswitch: add meter drop reason
Date: Wed,  9 Aug 2023 17:38:24 +0200
Message-ID: <20230809153833.2363265-5-amorenoz@redhat.com>
In-Reply-To: <20230809153833.2363265-1-amorenoz@redhat.com>
References: <20230809153833.2363265-1-amorenoz@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

By using an independent drop reason it makes it easy to distinguish
between QoS-triggered or flow-triggered drop.

Acked-by: Aaron Conole <aconole@redhat.com>
Signed-off-by: Adrian Moreno <amorenoz@redhat.com>
---
 net/openvswitch/actions.c | 2 +-
 net/openvswitch/drop.h    | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/openvswitch/actions.c b/net/openvswitch/actions.c
index b8b077769cdc..5c2007e77ace 100644
--- a/net/openvswitch/actions.c
+++ b/net/openvswitch/actions.c
@@ -1454,7 +1454,7 @@ static int do_execute_actions(struct datapath *dp, struct sk_buff *skb,
 
 		case OVS_ACTION_ATTR_METER:
 			if (ovs_meter_execute(dp, skb, key, nla_get_u32(a))) {
-				consume_skb(skb);
+				kfree_skb_reason(skb, OVS_DROP_METER);
 				return 0;
 			}
 			break;
diff --git a/net/openvswitch/drop.h b/net/openvswitch/drop.h
index e47f3479a643..9b52600a2038 100644
--- a/net/openvswitch/drop.h
+++ b/net/openvswitch/drop.h
@@ -12,6 +12,7 @@
 	R(OVS_DROP_ACTION_ERROR)		\
 	R(OVS_DROP_EXPLICIT)			\
 	R(OVS_DROP_EXPLICIT_WITH_ERROR)		\
+	R(OVS_DROP_METER)			\
 	/* deliberate comment for trailing \ */
 
 enum ovs_drop_reason {
-- 
2.41.0


