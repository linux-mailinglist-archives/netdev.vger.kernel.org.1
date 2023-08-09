Return-Path: <netdev+bounces-25944-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 107D3776413
	for <lists+netdev@lfdr.de>; Wed,  9 Aug 2023 17:39:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 139DF1C212AC
	for <lists+netdev@lfdr.de>; Wed,  9 Aug 2023 15:39:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 839BD1AA9D;
	Wed,  9 Aug 2023 15:38:59 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78C4619BCB
	for <netdev@vger.kernel.org>; Wed,  9 Aug 2023 15:38:59 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 258FA2708
	for <netdev@vger.kernel.org>; Wed,  9 Aug 2023 08:38:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1691595524;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JZaQ/HNg00Gxx8Fqmq94iGrKTktU8S4PKoeU6ZUjECk=;
	b=CRmtADvCVpvsrn1khmZRtxFozNWq0GDtypejTbIi4ktqhkboKLF33HnRUNBxTtqI0bQb3L
	W5mR3OCJ+NRS8h084Yc1ehQx/x81PHpQWSj9XwTzPwCHDn4YlFlvTmMjJVtL8vVd/xrWak
	eXWorRXu8TKeujgLdYnqSUvw9jx3Jw8=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-534-cMLmVKj0PlKm_cfiW4Pi8A-1; Wed, 09 Aug 2023 11:38:42 -0400
X-MC-Unique: cMLmVKj0PlKm_cfiW4Pi8A-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2C9041C051AE;
	Wed,  9 Aug 2023 15:38:42 +0000 (UTC)
Received: from antares.redhat.com (unknown [10.39.193.45])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 0873D492C13;
	Wed,  9 Aug 2023 15:38:40 +0000 (UTC)
From: Adrian Moreno <amorenoz@redhat.com>
To: netdev@vger.kernel.org
Cc: Adrian Moreno <amorenoz@redhat.com>,
	aconole@redhat.com,
	i.maximets@ovn.org,
	eric@garver.life,
	dev@openvswitch.org
Subject: [net-next v4 2/7] net: openvswitch: add action error drop reason
Date: Wed,  9 Aug 2023 17:38:22 +0200
Message-ID: <20230809153833.2363265-3-amorenoz@redhat.com>
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

Add a drop reason for packets that are dropped because an action
returns a non-zero error code.

Acked-by: Aaron Conole <aconole@redhat.com>
Signed-off-by: Adrian Moreno <amorenoz@redhat.com>
---
 net/openvswitch/actions.c | 2 +-
 net/openvswitch/drop.h    | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/openvswitch/actions.c b/net/openvswitch/actions.c
index 1234e95a9ce8..b4859629bfc6 100644
--- a/net/openvswitch/actions.c
+++ b/net/openvswitch/actions.c
@@ -1488,7 +1488,7 @@ static int do_execute_actions(struct datapath *dp, struct sk_buff *skb,
 		}
 
 		if (unlikely(err)) {
-			kfree_skb(skb);
+			kfree_skb_reason(skb, OVS_DROP_ACTION_ERROR);
 			return err;
 		}
 	}
diff --git a/net/openvswitch/drop.h b/net/openvswitch/drop.h
index ffdb8ab045bd..513c7f941ffc 100644
--- a/net/openvswitch/drop.h
+++ b/net/openvswitch/drop.h
@@ -9,6 +9,7 @@
 
 #define OVS_DROP_REASONS(R)			\
 	R(OVS_DROP_LAST_ACTION)		        \
+	R(OVS_DROP_ACTION_ERROR)		\
 	/* deliberate comment for trailing \ */
 
 enum ovs_drop_reason {
-- 
2.41.0


