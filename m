Return-Path: <netdev+bounces-25032-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5090F772B65
	for <lists+netdev@lfdr.de>; Mon,  7 Aug 2023 18:46:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 09DFA281496
	for <lists+netdev@lfdr.de>; Mon,  7 Aug 2023 16:46:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFD2A125D3;
	Mon,  7 Aug 2023 16:46:03 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C22A8125CF
	for <netdev@vger.kernel.org>; Mon,  7 Aug 2023 16:46:03 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E8AE171E
	for <netdev@vger.kernel.org>; Mon,  7 Aug 2023 09:46:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1691426761;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LpudfQAuEnvzWmIl1wvLbnd9d4Wfbrpzjm1EAORRCpg=;
	b=amD/tAnsqwjFYppBgA+/5rqsHDP0Uh3XOR03ViNVDgYOL6uctGKHwjSEF7NqmhwjnZx29M
	zINqV3ksVP0bkOse2f005lRaFXvD0focyh5dxO753JMvn3S1NiJ605BfoLPSEV3mSI2HAB
	6jaz2oKaGingmCZlPQGAv6gJQSL+OyU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-644-lW31oRQaN26TX_GKI07aZQ-1; Mon, 07 Aug 2023 12:46:00 -0400
X-MC-Unique: lW31oRQaN26TX_GKI07aZQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E5023101A5B4;
	Mon,  7 Aug 2023 16:45:59 +0000 (UTC)
Received: from antares.redhat.com (unknown [10.39.194.141])
	by smtp.corp.redhat.com (Postfix) with ESMTP id BC0AF2166B25;
	Mon,  7 Aug 2023 16:45:58 +0000 (UTC)
From: Adrian Moreno <amorenoz@redhat.com>
To: netdev@vger.kernel.org
Cc: Adrian Moreno <amorenoz@redhat.com>,
	aconole@redhat.com,
	i.maximets@ovn.org,
	eric@garver.life,
	dev@openvswitch.org
Subject: [net-next v3 4/7] net: openvswitch: add meter drop reason
Date: Mon,  7 Aug 2023 18:45:45 +0200
Message-ID: <20230807164551.553365-5-amorenoz@redhat.com>
In-Reply-To: <20230807164551.553365-1-amorenoz@redhat.com>
References: <20230807164551.553365-1-amorenoz@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

By using an independent drop reason it makes it easy to ditinguish
between QoS-triggered or flow-triggered drop.

Signed-off-by: Adrian Moreno <amorenoz@redhat.com>
---
 net/openvswitch/actions.c | 2 +-
 net/openvswitch/drop.h    | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/openvswitch/actions.c b/net/openvswitch/actions.c
index 285b1243b94f..e204c7eee8ef 100644
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
index be51ff5039fb..1ba866c408e5 100644
--- a/net/openvswitch/drop.h
+++ b/net/openvswitch/drop.h
@@ -12,6 +12,7 @@
 	R(OVS_DROP_ACTION_ERROR)		\
 	R(OVS_DROP_EXPLICIT_ACTION)		\
 	R(OVS_DROP_EXPLICIT_ACTION_ERROR)	\
+	R(OVS_DROP_METER)			\
 	/* deliberate comment for trailing \ */
 
 enum ovs_drop_reason {
-- 
2.41.0


