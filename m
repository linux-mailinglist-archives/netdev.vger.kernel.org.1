Return-Path: <netdev+bounces-23312-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 821D976B864
	for <lists+netdev@lfdr.de>; Tue,  1 Aug 2023 17:19:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B14961C20842
	for <lists+netdev@lfdr.de>; Tue,  1 Aug 2023 15:19:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A05431ADEE;
	Tue,  1 Aug 2023 15:17:16 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95F811ADC8
	for <netdev@vger.kernel.org>; Tue,  1 Aug 2023 15:17:16 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ABD9116
	for <netdev@vger.kernel.org>; Tue,  1 Aug 2023 08:17:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1690903034;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LpudfQAuEnvzWmIl1wvLbnd9d4Wfbrpzjm1EAORRCpg=;
	b=ie3KnypOXq6a+U/8PN4Imsg8Axk2qND3obioWEtF0ihuE7WcCiOA5mrXTQwBMJy2/BG6/J
	V2e1rttKb/A3qjQxH5F6O/+rE4EfCJ7KkxAO6dKBrxWjd8xhUp549vql0AN8RGXR3Yq2VS
	CYr1yQ5g969JRhc4TS4EbqxDwpE/liY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-17-j4AZYM1sNEu4hV3J3yFTYw-1; Tue, 01 Aug 2023 11:17:07 -0400
X-MC-Unique: j4AZYM1sNEu4hV3J3yFTYw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6AFF7856F67;
	Tue,  1 Aug 2023 15:17:04 +0000 (UTC)
Received: from antares.redhat.com (unknown [10.39.193.90])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 544B3C57966;
	Tue,  1 Aug 2023 15:17:03 +0000 (UTC)
From: Adrian Moreno <amorenoz@redhat.com>
To: netdev@vger.kernel.org
Cc: Adrian Moreno <amorenoz@redhat.com>,
	aconole@redhat.com,
	i.maximets@ovn.org,
	eric@garver.life,
	dev@openvswitch.org
Subject: [RFC net-next v2 4/7] net: openvswitch: add meter drop reason
Date: Tue,  1 Aug 2023 17:16:45 +0200
Message-ID: <20230801151649.744695-5-amorenoz@redhat.com>
In-Reply-To: <20230801151649.744695-1-amorenoz@redhat.com>
References: <20230801151649.744695-1-amorenoz@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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


