Return-Path: <netdev+bounces-23306-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91E6D76B854
	for <lists+netdev@lfdr.de>; Tue,  1 Aug 2023 17:17:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C35F71C20F69
	for <lists+netdev@lfdr.de>; Tue,  1 Aug 2023 15:17:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A3434DC96;
	Tue,  1 Aug 2023 15:17:10 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 200081ADC0
	for <netdev@vger.kernel.org>; Tue,  1 Aug 2023 15:17:09 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 718131B1
	for <netdev@vger.kernel.org>; Tue,  1 Aug 2023 08:17:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1690903025;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0JEusbIbmSQ5jAXzRRSRSX9wfb+/Nt1rvkTbvcodHlA=;
	b=WIY0U3T1kzjxsYz+AydhNb+Ejp2z6e5jy67oDq9cNbbWx988OTmms2GLZdST5NFrUQ/0E7
	b6dWEno3q3+OMM2WDRy68F1frsG7J+zJKC4YL6IU0tmurUEjzaRPlDMEt+ytKX7Eyw9n1D
	yW34TNdf9Rtk+hGoLsUG609+H2IiguU=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-266-c2dzz3BON2uNijo_uPCySQ-1; Tue, 01 Aug 2023 11:17:02 -0400
X-MC-Unique: c2dzz3BON2uNijo_uPCySQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A9AFE2815E2E;
	Tue,  1 Aug 2023 15:17:01 +0000 (UTC)
Received: from antares.redhat.com (unknown [10.39.193.90])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 91E3BC57964;
	Tue,  1 Aug 2023 15:17:00 +0000 (UTC)
From: Adrian Moreno <amorenoz@redhat.com>
To: netdev@vger.kernel.org
Cc: Adrian Moreno <amorenoz@redhat.com>,
	aconole@redhat.com,
	i.maximets@ovn.org,
	eric@garver.life,
	dev@openvswitch.org
Subject: [RFC net-next v2 2/7] net: openvswitch: add action error drop reason
Date: Tue,  1 Aug 2023 17:16:43 +0200
Message-ID: <20230801151649.744695-3-amorenoz@redhat.com>
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
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Add a drop reason for packets that are dropped because an action
returns a non-zero error code.

Signed-off-by: Adrian Moreno <amorenoz@redhat.com>
---
 net/openvswitch/actions.c | 2 +-
 net/openvswitch/drop.h    | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/openvswitch/actions.c b/net/openvswitch/actions.c
index af676dcac2b4..9b66a3334aaa 100644
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
index cdd10629c6be..3cd6489a5a2b 100644
--- a/net/openvswitch/drop.h
+++ b/net/openvswitch/drop.h
@@ -9,6 +9,7 @@
 
 #define OVS_DROP_REASONS(R)			\
 	R(OVS_DROP_FLOW)		        \
+	R(OVS_DROP_ACTION_ERROR)		\
 	/* deliberate comment for trailing \ */
 
 enum ovs_drop_reason {
-- 
2.41.0


