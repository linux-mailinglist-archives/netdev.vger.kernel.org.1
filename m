Return-Path: <netdev+bounces-192217-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98756ABEF91
	for <lists+netdev@lfdr.de>; Wed, 21 May 2025 11:23:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 050397A7A14
	for <lists+netdev@lfdr.de>; Wed, 21 May 2025 09:22:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3443523D2B7;
	Wed, 21 May 2025 09:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iGyEMnsj"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AE8223D2B5
	for <netdev@vger.kernel.org>; Wed, 21 May 2025 09:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747819368; cv=none; b=BWDyqeL6+fkjPfPtbB5Rh/mC3YHtZpgPInoAgnEh7DSQeSDQRSKqb/HKKaHpg69nY7a3T1hEhLpRCyEI83KFGwnq5SamCWDDfPuG9SJB01iEj23Vp0mJKfsUpX5WM8dq2O9TRJZHCizdCR0NOwDCcA2aw3Ow+lKJFftXOlQihMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747819368; c=relaxed/simple;
	bh=wELH2J/IT6nUMcutWahGCkII6lye8Rt6V2YclprHGJ8=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=NywrkW8ay4gK1HFKfB5tQuDtn7c8ix8Ah0zWKxI7pVe2INqs2WR3nNbhwlwH0mY+eZ3lWQgRRNJlyGKOHbwsY6A3cdNzbcHCRw+Z11kOv9T3xLUc//mbb8vIdvEYVoIVOBb6KicHVNeFemXLwNbSTBaSlFI6UptyQS0uzapNjCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iGyEMnsj; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747819365;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=9kYvyHsBvtT7cFBXdw28B6joF6f1auo5bdzpPtbct48=;
	b=iGyEMnsjsHl3hfiingpGK9zssqyZPAs2dhJSdeHpbSI1rBrjBRNDKxKHHEfWdr7jAA+uOz
	CGa5vt2FBAPaOGUKQRgh79nTCe1ZHvoSI0vZPfKV0mQBUcqQpxHfCxlcWO3vzGK1sjNWjc
	bouRo2j3lyprcPj2rhp0OdV+dxzekdc=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-461-1ZkSnRYnNounJHSvDmB9mA-1; Wed,
 21 May 2025 05:22:41 -0400
X-MC-Unique: 1ZkSnRYnNounJHSvDmB9mA-1
X-Mimecast-MFC-AGG-ID: 1ZkSnRYnNounJHSvDmB9mA_1747819360
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 513CB18004AD;
	Wed, 21 May 2025 09:22:40 +0000 (UTC)
Received: from lenovo-t14s.redhat.com (unknown [10.44.33.64])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id ED802195608F;
	Wed, 21 May 2025 09:22:37 +0000 (UTC)
From: Laurent Vivier <lvivier@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
	netdev@vger.kernel.org,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Subject: [PATCH v2 0/3] virtio: Fixes for TX ring sizing and resize error reporting
Date: Wed, 21 May 2025 11:22:33 +0200
Message-ID: <20250521092236.661410-1-lvivier@redhat.com>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

This patch series contains two fixes and a cleanup for the virtio subsystem=
.=0D
=0D
The first patch fixes an error reporting bug in virtio_ring's=0D
virtqueue_resize() function. Previously, errors from internal resize=0D
helpers could be masked if the subsequent re-enabling of the virtqueue=0D
succeeded. This patch restores the correct error propagation, ensuring that=
=0D
callers of virtqueue_resize() are properly informed of underlying resize=0D
failures.=0D
=0D
The second patch does a cleanup of the use of '2+MAX_SKB_FRAGS'=0D
=0D
The third patch addresses a reliability issue in virtio_net where the TX=0D
ring size could be configured too small, potentially leading to=0D
persistently stopped queues and degraded performance. It enforces a=0D
minimum TX ring size to ensure there's always enough space for at least one=
=0D
maximally-fragmented packet plus an additional slot.=0D
=0D
v2: clenup '2+MAX_SKB_FRAGS'=0D
=0D
Laurent Vivier (3):=0D
  virtio_ring: Fix error reporting in virtqueue_resize=0D
  virtio_net: Cleanup '2+MAX_SKB_FRAGS'=0D
  virtio_net: Enforce minimum TX ring size for reliability=0D
=0D
 drivers/net/virtio_net.c     | 14 ++++++++++----=0D
 drivers/virtio/virtio_ring.c |  8 ++++++--=0D
 2 files changed, 16 insertions(+), 6 deletions(-)=0D
=0D
-- =0D
2.49.0=0D
=0D


