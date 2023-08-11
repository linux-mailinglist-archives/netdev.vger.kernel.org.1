Return-Path: <netdev+bounces-26820-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CCAE779185
	for <lists+netdev@lfdr.de>; Fri, 11 Aug 2023 16:13:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D25E1C214F5
	for <lists+netdev@lfdr.de>; Fri, 11 Aug 2023 14:13:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D98A029E07;
	Fri, 11 Aug 2023 14:13:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEB4E63B1
	for <netdev@vger.kernel.org>; Fri, 11 Aug 2023 14:13:27 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 035DFDC
	for <netdev@vger.kernel.org>; Fri, 11 Aug 2023 07:13:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1691763206;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WX4XjRkqQ1bUzl8g4+LqlfjCpOE0tN25F3GOwufO+Rg=;
	b=YTHgFvFAYg7bcB6d68woGMdGniNih6gXf8KxfJfEggIuLKFFUZkIFQL/TvkBLYgCuOeY2K
	6scC84T/byALQIMdcK3GgTDGbhV0HUqJMI0/Z302r+2W+VRHCav3BONjCDFqUrYNAIWF+i
	BAma4MzITToQJkLiV3+jpTagTl1Iu2E=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-553-J6sU7-e_OfyWxncOHQb7Hg-1; Fri, 11 Aug 2023 10:13:24 -0400
X-MC-Unique: J6sU7-e_OfyWxncOHQb7Hg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 88C7C856F67;
	Fri, 11 Aug 2023 14:13:24 +0000 (UTC)
Received: from antares.redhat.com (unknown [10.39.192.142])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 2C3DC1121315;
	Fri, 11 Aug 2023 14:13:01 +0000 (UTC)
From: Adrian Moreno <amorenoz@redhat.com>
To: netdev@vger.kernel.org
Cc: Adrian Moreno <amorenoz@redhat.com>,
	aconole@redhat.com,
	i.maximets@ovn.org,
	eric@garver.life,
	dev@openvswitch.org
Subject: [net-next v5 2/7] net: openvswitch: add action error drop reason
Date: Fri, 11 Aug 2023 16:12:49 +0200
Message-ID: <20230811141255.4103827-3-amorenoz@redhat.com>
In-Reply-To: <20230811141255.4103827-1-amorenoz@redhat.com>
References: <20230811141255.4103827-1-amorenoz@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
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
index 8c8a7a82f76f..bb7aa181da30 100644
--- a/net/openvswitch/actions.c
+++ b/net/openvswitch/actions.c
@@ -1488,7 +1488,7 @@ static int do_execute_actions(struct datapath *dp, struct sk_buff *skb,
 		}
 
 		if (unlikely(err)) {
-			kfree_skb(skb);
+			ovs_kfree_skb_reason(skb, OVS_DROP_ACTION_ERROR);
 			return err;
 		}
 	}
diff --git a/net/openvswitch/drop.h b/net/openvswitch/drop.h
index a5b2b901249b..b87613ced713 100644
--- a/net/openvswitch/drop.h
+++ b/net/openvswitch/drop.h
@@ -10,6 +10,7 @@
 
 #define OVS_DROP_REASONS(R)			\
 	R(OVS_DROP_LAST_ACTION)		        \
+	R(OVS_DROP_ACTION_ERROR)		\
 	/* deliberate comment for trailing \ */
 
 enum ovs_drop_reason {
-- 
2.41.0


