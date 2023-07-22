Return-Path: <netdev+bounces-20124-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48D1B75DB81
	for <lists+netdev@lfdr.de>; Sat, 22 Jul 2023 11:44:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A70A92823CC
	for <lists+netdev@lfdr.de>; Sat, 22 Jul 2023 09:44:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5E941D311;
	Sat, 22 Jul 2023 09:42:58 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA7E11D2E3
	for <netdev@vger.kernel.org>; Sat, 22 Jul 2023 09:42:58 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C94679B
	for <netdev@vger.kernel.org>; Sat, 22 Jul 2023 02:42:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1690018976;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=caJgHcchUuhxeORbYIpzVnQyY1Huy+Q0At/lvugXypY=;
	b=fsH7GR1ipKH2n9y6QRHzb/2S1qoBYEoGo38IsC4oWLLqWtfS/LL9ixmGOvR1+dYhNRKlhH
	JGF5nfLfl9PWTZO/aO5lhRG3Q7CtioF2g2vwYZMoqgE0AdPn9fbEIq91n37FC6L0+Ll05W
	cf9zoD79nAJPAQDR7izax02HbbECcNE=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-533-x1Wu1ogaNTCMZ1IV3Fu4SA-1; Sat, 22 Jul 2023 05:42:50 -0400
X-MC-Unique: x1Wu1ogaNTCMZ1IV3Fu4SA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 97AF83806709;
	Sat, 22 Jul 2023 09:42:49 +0000 (UTC)
Received: from antares.redhat.com (unknown [10.39.192.19])
	by smtp.corp.redhat.com (Postfix) with ESMTP id ECC3D40C6CCC;
	Sat, 22 Jul 2023 09:42:47 +0000 (UTC)
From: Adrian Moreno <amorenoz@redhat.com>
To: netdev@vger.kernel.org
Cc: Adrian Moreno <amorenoz@redhat.com>,
	dev@openvswitch.org,
	aconole@redhat.com,
	i.maximets@ovn.org,
	eric@garver.life
Subject: [PATCH net-next 3/7] net: openvswitch: add meter drop reason
Date: Sat, 22 Jul 2023 11:42:33 +0200
Message-ID: <20230722094238.2520044-4-amorenoz@redhat.com>
In-Reply-To: <20230722094238.2520044-1-amorenoz@redhat.com>
References: <20230722094238.2520044-1-amorenoz@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
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
index 194379d58b62..9279bb186e9f 100644
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
index f9e9c1610f6b..2440c836727f 100644
--- a/net/openvswitch/drop.h
+++ b/net/openvswitch/drop.h
@@ -11,6 +11,7 @@
 	R(OVS_DROP_FLOW)		        \
 	R(OVS_DROP_EXPLICIT_ACTION)		\
 	R(OVS_DROP_EXPLICIT_ACTION_ERROR)	\
+	R(OVS_DROP_METER)			\
 	/* deliberate comment for trailing \ */
 
 enum ovs_drop_reason {
-- 
2.41.0


