Return-Path: <netdev+bounces-34883-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D349D7A5B93
	for <lists+netdev@lfdr.de>; Tue, 19 Sep 2023 09:49:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E72E51C20FDA
	for <lists+netdev@lfdr.de>; Tue, 19 Sep 2023 07:49:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B6F938BD2;
	Tue, 19 Sep 2023 07:49:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2151358A5
	for <netdev@vger.kernel.org>; Tue, 19 Sep 2023 07:49:21 +0000 (UTC)
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97F1211A
	for <netdev@vger.kernel.org>; Tue, 19 Sep 2023 00:49:19 -0700 (PDT)
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R221e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046056;MF=hengqi@linux.alibaba.com;NM=1;PH=DS;RN=13;SR=0;TI=SMTPD_---0VsQiZWz_1695109756;
Received: from localhost(mailfrom:hengqi@linux.alibaba.com fp:SMTPD_---0VsQiZWz_1695109756)
          by smtp.aliyun-inc.com;
          Tue, 19 Sep 2023 15:49:16 +0800
From: Heng Qi <hengqi@linux.alibaba.com>
To: netdev@vger.kernel.org,
	virtualization@lists.linux-foundation.org
Cc: "Michael S . Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Subject: [PATCH net 0/6] virtio-net: Fix and update interrupt moderation
Date: Tue, 19 Sep 2023 15:49:09 +0800
Message-Id: <20230919074915.103110-1-hengqi@linux.alibaba.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

The setting of virtio coalescing parameters involves all-queues and
per queue, so we must be careful to synchronize the two.

Regarding napi_tx switching, this patch set is not only
compatible with the previous way of using tx-frames to switch napi_tx,
but also improves the user experience when setting interrupt parameters.

This patch set has been tested and was part of the previous netdim patch
set[1] and is now being split to be rolled out in steps.

[1] https://lore.kernel.org/all/20230811065512.22190-1-hengqi@linux.alibaba.com/

Heng Qi (6):
  virtio-net: initially change the value of tx-frames
  virtio-net: fix mismatch of getting tx-frames
  virtio-net: consistently save parameters for per-queue
  virtio-net: fix per queue coalescing parameter setting
  virtio-net: fix the vq coalescing setting for vq resize
  virtio-net: a tiny comment update

 drivers/net/virtio_net.c | 118 +++++++++++++++++++++++++++++----------
 1 file changed, 89 insertions(+), 29 deletions(-)

-- 
2.19.1.6.gb485710b


