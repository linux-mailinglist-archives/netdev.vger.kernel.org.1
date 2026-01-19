Return-Path: <netdev+bounces-250974-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 05CA9D39E0D
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 06:55:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7E790301FF48
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 05:55:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DD002550D5;
	Mon, 19 Jan 2026 05:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aH3S2v/P"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A21E91B424F
	for <netdev@vger.kernel.org>; Mon, 19 Jan 2026 05:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768802102; cv=none; b=dJ+ezwa7Ml0fbV75Sq1YTEfT9vE5+tzx2N6J9Np1l5IH9/mdYMGXvGFsShThhxoQvi3FWbh5RBmrYc/jpFNby0kZL7V8n2V9ydao7Nu8UiHKTg63NRLvtYrjjgaIxleH5hY/dVFMFzNHvq3Hj12cLEIgGtdGz5ddCCI5B80Xyj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768802102; c=relaxed/simple;
	bh=sqVR2dGfB8AsTvrFk2bd/LSHTkZLOCUOCj8Nf2wCU3U=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=kmSK+cDecmgkkSjjr9b+srIzicJWXcdY7OcdJPQiCueWeYdU/SW4HCllP8ufXmtQjow7T+HGmLpXCaJ0Pvxo+z1ib7sdojUHQG5gEq+3zUyGzRdq+90huHZOn3BhRYisR5MwT8VcwejS2F5omMEaanafAKP/gMN0Tkw6NdoQB3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aH3S2v/P; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768802100;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=7NrHNjIO6r2ncmuZFs2yE/r5qZ284i8+lIxvX/ZcLyQ=;
	b=aH3S2v/PDCABwCLgzvA1ch2WE8aN6KZBfsLUwy62JqyWfAZb6+w3hpchaZ7w7DCTTMJ215
	wW4rGNgarPVgJ5AQtMM6DngQsKF+/ktl7JW0Ly/4cSoatDut47tLU8/Rjtkr7aRUx/dlQF
	qhyxhQf9WeEZLQzAjHjBdEbFGT7IofA=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-495-PpZG_mg1NYyEk_GpKbYbFw-1; Mon,
 19 Jan 2026 00:54:55 -0500
X-MC-Unique: PpZG_mg1NYyEk_GpKbYbFw-1
X-Mimecast-MFC-AGG-ID: PpZG_mg1NYyEk_GpKbYbFw_1768802094
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id BAC6F1956095;
	Mon, 19 Jan 2026 05:54:54 +0000 (UTC)
Received: from S2.redhat.com (unknown [10.72.112.143])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id AC78719560A7;
	Mon, 19 Jan 2026 05:54:50 +0000 (UTC)
From: Cindy Lu <lulu@redhat.com>
To: lulu@redhat.com,
	dtatulea@nvidia.com,
	mst@redhat.com,
	jasowang@redhat.com,
	netdev@vger.kernel.org,
	virtualization@lists.linux-foundation.org,
	linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Subject: [PATCH v3 0/3] vdpa/mlx5: Fix MAC address update via vdpa-tool
Date: Mon, 19 Jan 2026 13:53:50 +0800
Message-ID: <20260119055447.229772-1-lulu@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

This series hardens the mlx5 vDPA MAC plumbing by ensuring new addresses replace old
entries cleanly, reusing shared update logic to keep flow tables consistent, and only
advertising the MAC feature when the device is not yet DRIVER_OK

Changes in v2
 Factor out the MAC address update logic and reuse it from handle_ctrl_mac().
 Address review comments.
Changes in v3
 rename mlx5_vdpa_change_new_mac to mlx5_vdpa_change_mac
 Address review comments.

Cindy Lu (3):
  vdpa/mlx5: update mlx_features with driver state check
  vdpa/mlx5: reuse common function for MAC address updates
  vdpa/mlx5: update MAC address handling in mlx5_vdpa_set_attr()

 drivers/vdpa/mlx5/net/mlx5_vnet.c | 149 +++++++++++++++++-------------
 1 file changed, 83 insertions(+), 66 deletions(-)

-- 
2.51.0


