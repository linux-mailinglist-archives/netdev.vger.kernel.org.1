Return-Path: <netdev+bounces-22981-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 30F4076A47C
	for <lists+netdev@lfdr.de>; Tue,  1 Aug 2023 01:07:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B26228143F
	for <lists+netdev@lfdr.de>; Mon, 31 Jul 2023 23:07:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 683C11E537;
	Mon, 31 Jul 2023 23:07:45 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59B091E502
	for <netdev@vger.kernel.org>; Mon, 31 Jul 2023 23:07:45 +0000 (UTC)
Received: from smtp-fw-52004.amazon.com (smtp-fw-52004.amazon.com [52.119.213.154])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DAE890;
	Mon, 31 Jul 2023 16:07:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1690844864; x=1722380864;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Hvq4RYu5fhQ7cGStiaKnrborJd2JOYXuphbhyORtozM=;
  b=qYZR+yFl/mm/1m1xOoa8mlNhVIySk77TvqRcGFNMzUWSdOEkhv1mBI/L
   AvKuV8nanLzV85kn5bcYNATyddM8v+70kj2J7v36kI6RqINwwXPpxOKqW
   hdlEwjo2x5GhjNYzceG8cDcpeNfvrZCEX1ZGtfc/sUE10SrRFy3/srfg3
   Y=;
X-IronPort-AV: E=Sophos;i="6.01,245,1684800000"; 
   d="scan'208";a="145844873"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-pdx-2c-m6i4x-5eae960a.us-west-2.amazon.com) ([10.43.8.2])
  by smtp-border-fw-52004.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2023 23:07:43 +0000
Received: from EX19MTAUWB002.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan3.pdx.amazon.com [10.236.137.198])
	by email-inbound-relay-pdx-2c-m6i4x-5eae960a.us-west-2.amazon.com (Postfix) with ESMTPS id 08A1540DA6;
	Mon, 31 Jul 2023 23:07:40 +0000 (UTC)
Received: from EX19D019UWB001.ant.amazon.com (10.13.139.189) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Mon, 31 Jul 2023 23:07:40 +0000
Received: from EX19MTAUEA001.ant.amazon.com (10.252.134.203) by
 EX19D019UWB001.ant.amazon.com (10.13.139.189) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Mon, 31 Jul 2023 23:07:40 +0000
Received: from u7187ce7291cc57.ant.amazon.com (10.187.170.39) by
 mail-relay.amazon.com (10.252.134.102) with Microsoft SMTP Server id
 15.2.1118.30 via Frontend Transport; Mon, 31 Jul 2023 23:07:39 +0000
From: Tahsin Erdogan <trdgn@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Herbert Xu <herbert@gondor.apana.org.au>
CC: Tahsin Erdogan <trdgn@amazon.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v2] tun: avoid high-order page allocation for packet header
Date: Mon, 31 Jul 2023 16:07:36 -0700
Message-ID: <20230731230736.109216-1-trdgn@amazon.com>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: Bulk
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

When GSO is not enabled and a packet is transmitted via writev(), all
payload is treated as header which requires a contiguous memory allocation.
This allocation request is harder to satisfy, and may even fail if there is
enough fragmentation.

Note that sendmsg() code path limits the linear copy length, so this change
makes writev() and sendmsg() more consistent.

Signed-off-by: Tahsin Erdogan <trdgn@amazon.com>
---
v2: replace linear == 0 with !linear
v1: https://lore.kernel.org/all/20230726030936.1587269-1-trdgn@amazon.com/
 drivers/net/tun.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/tun.c b/drivers/net/tun.c
index d75456adc62a..4c57804f4cbd 100644
--- a/drivers/net/tun.c
+++ b/drivers/net/tun.c
@@ -1523,7 +1523,7 @@ static struct sk_buff *tun_alloc_skb(struct tun_file *tfile,
 	int err;
 
 	/* Under a page?  Don't bother with paged skb. */
-	if (prepad + len < PAGE_SIZE || !linear)
+	if (prepad + len < PAGE_SIZE)
 		linear = len;
 
 	skb = sock_alloc_send_pskb(sk, prepad + linear, len - linear, noblock,
@@ -1838,6 +1838,9 @@ static ssize_t tun_get_user(struct tun_struct *tun, struct tun_file *tfile,
 			 */
 			zerocopy = false;
 		} else {
+			if (!linear)
+				linear = min_t(size_t, good_linear, copylen);
+
 			skb = tun_alloc_skb(tfile, align, copylen, linear,
 					    noblock);
 		}
-- 
2.41.0


