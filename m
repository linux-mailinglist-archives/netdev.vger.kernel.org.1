Return-Path: <netdev+bounces-38862-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D4B27BCCAE
	for <lists+netdev@lfdr.de>; Sun,  8 Oct 2023 08:27:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 022D6281AC9
	for <lists+netdev@lfdr.de>; Sun,  8 Oct 2023 06:27:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 558A153AA;
	Sun,  8 Oct 2023 06:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B40B8522F
	for <netdev@vger.kernel.org>; Sun,  8 Oct 2023 06:27:49 +0000 (UTC)
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABB31C5
	for <netdev@vger.kernel.org>; Sat,  7 Oct 2023 23:27:47 -0700 (PDT)
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R641e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046060;MF=hengqi@linux.alibaba.com;NM=1;PH=DS;RN=13;SR=0;TI=SMTPD_---0VtdEo50_1696746464;
Received: from localhost(mailfrom:hengqi@linux.alibaba.com fp:SMTPD_---0VtdEo50_1696746464)
          by smtp.aliyun-inc.com;
          Sun, 08 Oct 2023 14:27:45 +0800
From: Heng Qi <hengqi@linux.alibaba.com>
To: netdev@vger.kernel.org,
	virtualization@lists.linux-foundation.org
Cc: Jason Wang <jasowang@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>
Subject: [PATCH v3 0/6] virtio-net: Fix and update interrupt moderation
Date: Sun,  8 Oct 2023 14:27:38 +0800
Message-Id: <cover.1696745452.git.hengqi@linux.alibaba.com>
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

---
v2->v3:
    1. Fix a tiny comment.

v1->v2:
    1. Fix some minor comments and add ack tags.

Heng Qi (6):
  virtio-net: initially change the value of tx-frames
  virtio-net: fix mismatch of getting tx-frames
  virtio-net: consistently save parameters for per-queue
  virtio-net: fix per queue coalescing parameter setting
  virtio-net: fix the vq coalescing setting for vq resize
  virtio-net: a tiny comment update

 drivers/net/virtio_net.c | 104 ++++++++++++++++++++++++++++-----------
 1 file changed, 75 insertions(+), 29 deletions(-)

-- 
2.19.1.6.gb485710b


