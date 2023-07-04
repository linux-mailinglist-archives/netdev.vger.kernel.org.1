Return-Path: <netdev+bounces-15408-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ABB8D7476F0
	for <lists+netdev@lfdr.de>; Tue,  4 Jul 2023 18:41:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 051071C20A8B
	for <lists+netdev@lfdr.de>; Tue,  4 Jul 2023 16:41:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EFF5613F;
	Tue,  4 Jul 2023 16:40:58 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DA2A2CA4
	for <netdev@vger.kernel.org>; Tue,  4 Jul 2023 16:40:58 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C1D110C8
	for <netdev@vger.kernel.org>; Tue,  4 Jul 2023 09:40:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1688488855;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=hsGJKlN84iS87uycG5CF0XVpQDM2M+LhZ2wWSTw/Kvs=;
	b=JE9Rkq7cGJ3BLnIOEkNJyRf3TDFqjoySAWm9WjqIA5CTkYzP3Ini6QHLnFlgrgvz5CHOdL
	Z93qlnBeO81OXsA/P+k05oVDvLVnx42y0eAk4/JT8MYqpFdGQ0sJwCYouXBfY1jKUFbViM
	UI9lHmwgG0Q+Rj5Nprz1KYt24S1s8Dk=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-159-fDHB3uUIPGW5sea3w8il6A-1; Tue, 04 Jul 2023 12:40:51 -0400
X-MC-Unique: fDHB3uUIPGW5sea3w8il6A-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 88AA329AA39A;
	Tue,  4 Jul 2023 16:40:51 +0000 (UTC)
Received: from max-t490s.redhat.com (unknown [10.39.208.32])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 6D830492B02;
	Tue,  4 Jul 2023 16:40:49 +0000 (UTC)
From: Maxime Coquelin <maxime.coquelin@redhat.com>
To: xieyongji@bytedance.com,
	jasowang@redhat.com,
	mst@redhat.com,
	david.marchand@redhat.com,
	lulu@redhat.com
Cc: linux-kernel@vger.kernel.org,
	virtualization@lists.linux-foundation.org,
	netdev@vger.kernel.org,
	xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com,
	Maxime Coquelin <maxime.coquelin@redhat.com>
Subject: [PATCH v2 0/3] vduse: add support for networking devices
Date: Tue,  4 Jul 2023 18:40:42 +0200
Message-ID: <20230704164045.39119-1-maxime.coquelin@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

This small series enables virtio-net device type in VDUSE.
With it, basic operation have been tested, both with
virtio-vdpa and vhost-vdpa using DPDK Vhost library series
adding VDUSE support using split rings layout (merged in
DPDK v23.07-rc1).

Control queue support (and so multiqueue) has also been
tested, but requires a Kernel series from Jason Wang
relaxing control queue polling [1] to function reliably,
so while Jason rework is done, a patch is added to disable
CVQ and features that depend on it (tested also with DPDK
v23.07-rc1).

[1]: https://lore.kernel.org/lkml/CACGkMEtgrxN3PPwsDo4oOsnsSLJfEmBEZ0WvjGRr3whU+QasUg@mail.gmail.com/T/

v1 -> v2 changes:
=================
- Add a patch to disable CVQ (Michael)

RFC -> v1 changes:
==================
- Fail device init if it does not support VERSION_1 (Jason)

Maxime Coquelin (3):
  vduse: validate block features only with block devices
  vduse: enable Virtio-net device type
  vduse: Temporarily disable control queue features

 drivers/vdpa/vdpa_user/vduse_dev.c | 36 ++++++++++++++++++++++++++----
 1 file changed, 32 insertions(+), 4 deletions(-)

-- 
2.41.0


