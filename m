Return-Path: <netdev+bounces-107995-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04B7091D750
	for <lists+netdev@lfdr.de>; Mon,  1 Jul 2024 07:13:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 83525280BFC
	for <lists+netdev@lfdr.de>; Mon,  1 Jul 2024 05:13:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 402B722075;
	Mon,  1 Jul 2024 05:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L0Y9Hrnr"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 729263BBF0
	for <netdev@vger.kernel.org>; Mon,  1 Jul 2024 05:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719810778; cv=none; b=jp4FfyBOKj/cQtL06mnUlwMY8SgKD8aY7LvX30oVjQ4DqrP5qu4cSFA3fSxn2AlqJDAa414YrC15udZ4dofRDkR0FMmBX1CVh8HvfdQua0PzMYqRP/P/xVtkrx+mkdt/R5rKlYGSL+G4dazduB7DfpM6tTXVDkCFP+V47HjN7N0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719810778; c=relaxed/simple;
	bh=CwkO+kehONDrAszVhVtNIbQ9B0+JAOV85cCWvM0KpjI=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=bQi9ZqpfUh1vRiDNNanl6ealLp8nNKo44CEOjNTUyBL+5nJNsh+OXdeQjG6SXZ/st6lbCuYzsnQuyuV0PTF/tifsEwpDeo8ayq2sX2tDigiQTHJeKNSg48/dDcIZ4wipoAnhvrkgXpWOQmJPvxNhPM2db1hS+fpwEGHMfiIrhFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=L0Y9Hrnr; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719810775;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=CnhC207ZfIddoGqj9xeSDYU43y6J4VX38RQES5QZv4Q=;
	b=L0Y9Hrnr/upmUtVkW3zxIerS4JNluEM0RHLs6rDUkIZXssztRoQ8buuzoYy5naw6/h4XUK
	TMtCrzL5u8y0PxE6ul1+paQCg7TYm4gFg8MGjWLDJ6Uyg3xxYVUBBiWjkoTbzCdGKZvy0C
	Ea3ek3xUwUyUNedIAyHbJxKc8ahoGP8=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-631-p1RjKBioOYyGBQP_gn4kNw-1; Mon,
 01 Jul 2024 01:12:52 -0400
X-MC-Unique: p1RjKBioOYyGBQP_gn4kNw-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6ED3B19560B1;
	Mon,  1 Jul 2024 05:12:51 +0000 (UTC)
Received: from server.redhat.com (unknown [10.72.112.30])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 9FF361956089;
	Mon,  1 Jul 2024 05:12:47 +0000 (UTC)
From: Cindy Lu <lulu@redhat.com>
To: lulu@redhat.com,
	dtatulea@nvidia.com,
	mst@redhat.com,
	jasowang@redhat.com,
	parav@nvidia.com,
	netdev@vger.kernel.org
Subject: [PATCH v2 0/2] vdpa: support set mac address from vdpa tool
Date: Mon,  1 Jul 2024 13:12:01 +0800
Message-ID: <20240701051239.112447-1-lulu@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

Add support for setting the MAC address using the VDPA tool.
This feature will allow setting the MAC address using the VDPA tool.
For example, in vdpa_sim_net, the implementation sets the MAC address
to the config space. However, for other drivers, they can implement their
own function, not limited to the config space.

Changelog v2
 - Changed the function name to prevent misunderstanding
 - Added check for blk device
 - Addressed the comments

Cindy Lu (2):
  vdpa: support set mac address from vdpa tool
  vdpa_sim_net: Add the support of set mac address

 drivers/vdpa/vdpa.c                  | 73 ++++++++++++++++++++++++++++
 drivers/vdpa/vdpa_sim/vdpa_sim_net.c | 18 ++++++-
 include/linux/vdpa.h                 |  2 +
 include/uapi/linux/vdpa.h            |  1 +
 4 files changed, 93 insertions(+), 1 deletion(-)

-- 
2.45.0


