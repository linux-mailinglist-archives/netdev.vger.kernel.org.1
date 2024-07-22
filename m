Return-Path: <netdev+bounces-112351-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47083938715
	for <lists+netdev@lfdr.de>; Mon, 22 Jul 2024 03:06:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 71F031C209DD
	for <lists+netdev@lfdr.de>; Mon, 22 Jul 2024 01:06:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABDB54C92;
	Mon, 22 Jul 2024 01:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XDbgq54z"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2567B2581
	for <netdev@vger.kernel.org>; Mon, 22 Jul 2024 01:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721610404; cv=none; b=JLYVoKeCV2X9eYCw2IBLpAL3YIYzhEm5POrFRywDK6CVG3v7ifZumnN9vO958q3znKLUc0alI+bbOWBiVFd9X6ONVGLuCnK6ZRkNwhP545gYTFS3v7RiWH2bPa/zsP4hJPNHfSeK8cP7NHNMhnvq/tPiYh9iuXdpkEAsOSwe71A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721610404; c=relaxed/simple;
	bh=diILvCZinSjzgPrFQoxOVtRera4h862XU+rAcYS/Nvk=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=TUyRHQ8nbZDXlWYSwFD6T32CpeorIFRkHOGpQT3NP5MIWj8FqIowYgWmaRVehUcLO9/AdRJaOnExILnAmGzu1Z7uUTNZGaf007bN4FAYUfErhsoGIHhqWGPcUqWl403mGihWeAX46AO1LU0gRFh1Dv5Jnr5tbfAdLKJPdGKvdhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XDbgq54z; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721610401;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=8+7BYv0y9Snk+G9iQOgMHiR8iidKZj6hsfK238F04TA=;
	b=XDbgq54zten/WKnGzwzwXJsl9aXBoZnT3b8UAt29bRzdPU/cyW3t6FtYWiqPovdSWFpQuD
	MMM1HmFV32Lk/jom6SEq8Eg0Z4RsKxnbDttsCB/vnmEDwUVs2EKAumaAKhL4ZcAuUivx62
	8frMaExqvHvLjnWtZpmMlFInBcvtDCM=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-135-nl83Et2YM92NMpfjfyVP9g-1; Sun,
 21 Jul 2024 21:06:37 -0400
X-MC-Unique: nl83Et2YM92NMpfjfyVP9g-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 360A919560A1;
	Mon, 22 Jul 2024 01:06:36 +0000 (UTC)
Received: from server.redhat.com (unknown [10.72.112.22])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id E3F7F195605A;
	Mon, 22 Jul 2024 01:06:30 +0000 (UTC)
From: Cindy Lu <lulu@redhat.com>
To: lulu@redhat.com,
	dtatulea@nvidia.com,
	mst@redhat.com,
	jasowang@redhat.com,
	parav@nvidia.com,
	sgarzare@redhat.com,
	netdev@vger.kernel.org,
	virtualization@lists.linux-foundation.org,
	linux-kernel@vger.kernel.org
Subject: [PATH v4 0/3] vdpa: support set mac address from vdpa tool
Date: Mon, 22 Jul 2024 09:05:17 +0800
Message-ID: <20240722010625.1016854-1-lulu@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

Add support for setting the MAC address using the VDPA tool.
This feature will allow setting the MAC address using the VDPA tool.
For example, in vdpa_sim_net, the implementation sets the MAC address
to the config space. However, for other drivers, they can implement their
own function, not limited to the config space.

Changelog v2
 - Changed the function name to prevent misunderstanding
 - Added check for blk device
 - Addressed the comments
Changelog v3
 - Split the function of the net device from vdpa_nl_cmd_dev_attr_set_doit
 - Add a lock for the network device's dev_set_attr operation
 - Address the comments
Changelog v4
 - Address the comments
 - Add a lock for the vdap_sim_net device's dev_set_attr operation


Cindy Lu (3):
  vdpa: support set mac address from vdpa tool
  vdpa_sim_net: Add the support of set mac address
  vdpa/mlx5: Add the support of set mac address

 drivers/vdpa/mlx5/net/mlx5_vnet.c    | 25 +++++++++
 drivers/vdpa/vdpa.c                  | 84 ++++++++++++++++++++++++++++
 drivers/vdpa/vdpa_sim/vdpa_sim_net.c | 22 +++++++-
 include/linux/vdpa.h                 |  9 +++
 include/uapi/linux/vdpa.h            |  1 +
 5 files changed, 140 insertions(+), 1 deletion(-)

-- 
2.45.0


