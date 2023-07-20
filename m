Return-Path: <netdev+bounces-19418-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E95C275A98F
	for <lists+netdev@lfdr.de>; Thu, 20 Jul 2023 10:45:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A356B281DE0
	for <lists+netdev@lfdr.de>; Thu, 20 Jul 2023 08:45:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 151A0361;
	Thu, 20 Jul 2023 08:39:00 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AA52171AF
	for <netdev@vger.kernel.org>; Thu, 20 Jul 2023 08:38:59 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DED1D26B0
	for <netdev@vger.kernel.org>; Thu, 20 Jul 2023 01:38:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1689842338;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2if8GUFmC1eD4optUaWK9NefEn7X4sNBFHPPoUxvNAg=;
	b=OPKkakVEwj/ZE+mKCy8AYAThVtP4jvyWC5WKCD7vHkpMRey+jOIRfig1rHn/xAa96O20Tp
	qVADvoDUv+vQDPNITA0E/J7mFmuLKw220o05frHytMlOfBRW90uAxvjvqZsYuDUO/sOuCM
	oDhywIWzE+YWPvQX1t8a8sbSozrft00=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-127-0nX04BiMMru-iCGC6jqJJQ-1; Thu, 20 Jul 2023 04:38:56 -0400
X-MC-Unique: 0nX04BiMMru-iCGC6jqJJQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1FACB3803926;
	Thu, 20 Jul 2023 08:38:56 +0000 (UTC)
Received: from dell-per430-12.lab.eng.pek2.redhat.com (dell-per430-12.lab.eng.pek2.redhat.com [10.73.196.55])
	by smtp.corp.redhat.com (Postfix) with ESMTP id D0D5EF6CD8;
	Thu, 20 Jul 2023 08:38:51 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: mst@redhat.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	virtualization@lists.linux-foundation.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	alvaro.karsz@solid-run.com,
	maxime.coquelin@redhat.com
Subject: [PATCH net-next v4 2/2] virtio-net: add cond_resched() to the command waiting loop
Date: Thu, 20 Jul 2023 04:38:39 -0400
Message-Id: <20230720083839.481487-3-jasowang@redhat.com>
In-Reply-To: <20230720083839.481487-1-jasowang@redhat.com>
References: <20230720083839.481487-1-jasowang@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Adding cond_resched() to the command waiting loop for a better
co-operation with the scheduler. This allows to give CPU a breath to
run other task(workqueue) instead of busy looping when preemption is
not allowed on a device whose CVQ might be slow.

Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 drivers/net/virtio_net.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 9f3b1d6ac33d..e7533f29b219 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -2314,8 +2314,10 @@ static bool virtnet_send_command(struct virtnet_info *vi, u8 class, u8 cmd,
 	 * into the hypervisor, so the request should be handled immediately.
 	 */
 	while (!virtqueue_get_buf(vi->cvq, &tmp) &&
-	       !virtqueue_is_broken(vi->cvq))
+	       !virtqueue_is_broken(vi->cvq)) {
+		cond_resched();
 		cpu_relax();
+	}
 
 	return vi->ctrl->status == VIRTIO_NET_OK;
 }
-- 
2.39.3


