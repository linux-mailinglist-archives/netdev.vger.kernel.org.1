Return-Path: <netdev+bounces-26407-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F156777B7F
	for <lists+netdev@lfdr.de>; Thu, 10 Aug 2023 17:02:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C7971C2156C
	for <lists+netdev@lfdr.de>; Thu, 10 Aug 2023 15:02:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2959B200C0;
	Thu, 10 Aug 2023 15:02:03 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A15C1E1A2
	for <netdev@vger.kernel.org>; Thu, 10 Aug 2023 15:02:03 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 484492694
	for <netdev@vger.kernel.org>; Thu, 10 Aug 2023 08:02:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1691679721;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nNinQaEK05nRW/H4D5frUYnlbT/gevMiz2VDE2Rr9fY=;
	b=UGd+Zd0MyzL0qmjr9zHdftYz2MT60kTBpd7p6oRyEmiPdzbb0CgSn0ARsYqpvbVoR+tXtr
	fuZ5zrgpqtYpjN6GgLgmzbzXkHV2vtWs5BcZj8ubUxaw6DQwujcDvcc326K/MCmM9+8gZL
	tMgzMi6jSopiNC4MLYUoFtdTU6Nf8fg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-187-ex--7yFePu6r84EicxabLw-1; Thu, 10 Aug 2023 11:01:56 -0400
X-MC-Unique: ex--7yFePu6r84EicxabLw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 895D61991C42;
	Thu, 10 Aug 2023 15:01:55 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.45.226.68])
	by smtp.corp.redhat.com (Postfix) with ESMTP id D3CB640C6F4E;
	Thu, 10 Aug 2023 15:01:53 +0000 (UTC)
From: Michal Schmidt <mschmidt@redhat.com>
To: netdev@vger.kernel.org
Cc: Veerasenareddy Burru <vburru@marvell.com>,
	Sathesh Edara <sedara@marvell.com>,
	"David S. Miller" <davem@davemloft.net>,
	Abhijit Ayarekar <aayarekar@marvell.com>,
	Satananda Burla <sburla@marvell.com>,
	Vimlesh Kumar <vimleshk@marvell.com>
Subject: [PATCH net 1/4] octeon_ep: fix timeout value for waiting on mbox response
Date: Thu, 10 Aug 2023 17:01:11 +0200
Message-ID: <20230810150114.107765-2-mschmidt@redhat.com>
In-Reply-To: <20230810150114.107765-1-mschmidt@redhat.com>
References: <20230810150114.107765-1-mschmidt@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

The intention was to wait up to 500 ms for the mbox response.
The third argument to wait_event_interruptible_timeout() is supposed to
be the timeout duration. The driver mistakenly passed absolute time
instead.

Fixes: 577f0d1b1c5f ("octeon_ep: add separate mailbox command and response queues")
Signed-off-by: Michal Schmidt <mschmidt@redhat.com>
---
 drivers/net/ethernet/marvell/octeon_ep/octep_ctrl_net.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/marvell/octeon_ep/octep_ctrl_net.c b/drivers/net/ethernet/marvell/octeon_ep/octep_ctrl_net.c
index 1cc6af2feb38..565320ec24f8 100644
--- a/drivers/net/ethernet/marvell/octeon_ep/octep_ctrl_net.c
+++ b/drivers/net/ethernet/marvell/octeon_ep/octep_ctrl_net.c
@@ -55,7 +55,7 @@ static int octep_send_mbox_req(struct octep_device *oct,
 	list_add_tail(&d->list, &oct->ctrl_req_wait_list);
 	ret = wait_event_interruptible_timeout(oct->ctrl_req_wait_q,
 					       (d->done != 0),
-					       jiffies + msecs_to_jiffies(500));
+					       msecs_to_jiffies(500));
 	list_del(&d->list);
 	if (ret == 0 || ret == 1)
 		return -EAGAIN;
-- 
2.41.0


