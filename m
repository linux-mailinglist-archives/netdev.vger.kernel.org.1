Return-Path: <netdev+bounces-25623-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DD3A774EFB
	for <lists+netdev@lfdr.de>; Wed,  9 Aug 2023 01:09:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4672A281838
	for <lists+netdev@lfdr.de>; Tue,  8 Aug 2023 23:09:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FB9D198A9;
	Tue,  8 Aug 2023 23:09:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54ABE171AD
	for <netdev@vger.kernel.org>; Tue,  8 Aug 2023 23:09:28 +0000 (UTC)
Received: from smtp-fw-6001.amazon.com (smtp-fw-6001.amazon.com [52.95.48.154])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6344D101;
	Tue,  8 Aug 2023 16:09:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1691536168; x=1723072168;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=CxwShjiY+qcUUzYsoIsbNHrtfeKMUk7hbr/kxYUQ0M4=;
  b=GUCH/gI/UWUzftRoaawMfL/5qJ9txNNLRnOpjbpIdFkzN4RpypBk4YjI
   y0XK3A8u1QLJ6RbR7Mf5aRqiXT/550Fmwx/V6rw2TNDHF/vLRjykcRsCz
   3aft9eydh+1vHzZXlPzpsyoTMqNk4YGXrcAVbGc75mt64HW3YnTeBGZgz
   M=;
X-IronPort-AV: E=Sophos;i="6.01,157,1684800000"; 
   d="scan'208";a="351487948"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-pdx-2b-m6i4x-32fb4f1a.us-west-2.amazon.com) ([10.43.8.2])
  by smtp-border-fw-6001.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2023 23:09:26 +0000
Received: from EX19MTAUWC002.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan3.pdx.amazon.com [10.236.137.198])
	by email-inbound-relay-pdx-2b-m6i4x-32fb4f1a.us-west-2.amazon.com (Postfix) with ESMTPS id C9AF9C04A2;
	Tue,  8 Aug 2023 23:09:24 +0000 (UTC)
Received: from EX19D019UWB002.ant.amazon.com (10.13.139.149) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Tue, 8 Aug 2023 23:09:23 +0000
Received: from EX19MTAUEC001.ant.amazon.com (10.252.135.222) by
 EX19D019UWB002.ant.amazon.com (10.13.139.149) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Tue, 8 Aug 2023 23:09:23 +0000
Received: from u7187ce7291cc57.ant.amazon.com (10.187.170.38) by
 mail-relay.amazon.com (10.252.135.200) with Microsoft SMTP Server id
 15.2.1118.30 via Frontend Transport; Tue, 8 Aug 2023 23:09:21 +0000
From: Tahsin Erdogan <trdgn@amazon.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Jason Wang
	<jasowang@redhat.com>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Herbert Xu <herbert@gondor.apana.org.au>
CC: Tahsin Erdogan <trdgn@amazon.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v3] tun: avoid high-order page allocation for packet header
Date: Tue, 8 Aug 2023 16:09:19 -0700
Message-ID: <20230808230920.1944738-1-trdgn@amazon.com>
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
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
	RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
	autolearn=ham autolearn_force=no version=3.4.6
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
v3: rebase to latest net-next
v2: replace linear == 0 with !linear
v1: https://lore.kernel.org/all/20230726030936.1587269-1-trdgn@amazon.com/
 drivers/net/tun.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/tun.c b/drivers/net/tun.c
index 5beb6b5dd7e5..53d19c958a20 100644
--- a/drivers/net/tun.c
+++ b/drivers/net/tun.c
@@ -1523,7 +1523,7 @@ static struct sk_buff *tun_alloc_skb(struct tun_file *tfile,
 	int err;
 
 	/* Under a page?  Don't bother with paged skb. */
-	if (prepad + len < PAGE_SIZE || !linear)
+	if (prepad + len < PAGE_SIZE)
 		linear = len;
 
 	if (len - linear > MAX_SKB_FRAGS * (PAGE_SIZE << PAGE_ALLOC_COSTLY_ORDER))
@@ -1913,6 +1913,9 @@ static ssize_t tun_get_user(struct tun_struct *tun, struct tun_file *tfile,
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


