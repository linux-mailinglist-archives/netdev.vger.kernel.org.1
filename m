Return-Path: <netdev+bounces-114373-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 49E0A9424D0
	for <lists+netdev@lfdr.de>; Wed, 31 Jul 2024 05:17:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A32D1C20F99
	for <lists+netdev@lfdr.de>; Wed, 31 Jul 2024 03:17:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 963FE179A8;
	Wed, 31 Jul 2024 03:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X3+kKteA"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B49D125D6
	for <netdev@vger.kernel.org>; Wed, 31 Jul 2024 03:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722395831; cv=none; b=nXnAYTQqnxNSjv3sXz84qlyBEFjhJezo84Hq5FqJC9cX/k+OI9u9VJGMbG8Kv7juRR/rM/ZF6CGPbakQ90D5cbREnpsdB4nR4Sd3lpNZE+XqZ0TMulfO6uoADISj6AajY+xi2LhmpDMEMlB1xCFV8YjIn/2QJfNIECRQqzlNXc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722395831; c=relaxed/simple;
	bh=JkBRTB0ebER9e6F0wnfv+1oao0kqLVhNaXL7YIZG5VY=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=PSL5BcyW/g5JwkMCQi8lqeuCAFGwMR9HAVH5f58GyzfXbcajpQmtRx3AV9AtRVIwUYa1myaY6le+xMGpicsywfg6ZS7d3UybYfysIqTnBjP6SD+rt5Obl3G45FKI1b+NI+avCL7qpEw9tln40GOUScqIWyp94xW92RkGobR6iD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=X3+kKteA; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722395828;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=KK/99rFb/OJa+qbI6cUHEnX47Fd/3MtoZJKyHfCgvOE=;
	b=X3+kKteAKCUa9VMKIwj6mIuEmyJqVifcBRVttcj4eM49EOgS/WHvwhjMHNzSLHIjNhotGF
	5CZhrkqYbF50IO3M+6X3uzU/djPwo2k9+yak9nUD18PHXfAqXNTpUFQd5hB00qiagukltI
	4WYtA9g9g8zoYccI/GpeEFw/HJ7D+T4=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-436-nVVNNzlmNjm10iqHNzMEoQ-1; Tue,
 30 Jul 2024 23:17:07 -0400
X-MC-Unique: nVVNNzlmNjm10iqHNzMEoQ-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9E2221955D44;
	Wed, 31 Jul 2024 03:17:05 +0000 (UTC)
Received: from server.redhat.com (unknown [10.72.112.168])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id A610C1955F3B;
	Wed, 31 Jul 2024 03:16:59 +0000 (UTC)
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
Subject: [PATCH v8 0/3] vdpa: support set mac address from vdpa tool
Date: Wed, 31 Jul 2024 11:16:00 +0800
Message-ID: <20240731031653.1047692-1-lulu@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

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
 - Add a lock for the vdap_sim?_net device's dev_set_attr operation
Changelog v5
 - Address the comments
Changelog v6 
- Replace all the memcpy of mac address with ether_addr_copy()
- Remove the check for VIRTIO_NET_F_MAC in vdpa_dev_net_device_attr_set
- Remove unnecessary check
- Enhance the error log
Changelog v7
 - change the code to reverse-xmas tree style
 - make all patches pass the check of ./scripts/checkpatch.pl --strict 
 - Address other comments
Changelog v8
- Change the fail return value to -EOPNOTSUPP
- Improve the error log
- remove the  unnecessary memcpy
  
Cindy Lu (3):
  vdpa: support set mac address from vdpa tool
  vdpa_sim_net: Add the support of set mac address
  vdpa/mlx5: Add the support of set mac address

 drivers/vdpa/mlx5/net/mlx5_vnet.c    | 28 ++++++++++
 drivers/vdpa/vdpa.c                  | 79 ++++++++++++++++++++++++++++
 drivers/vdpa/vdpa_sim/vdpa_sim_net.c | 21 +++++++-
 include/linux/vdpa.h                 |  9 ++++
 include/uapi/linux/vdpa.h            |  1 +
 5 files changed, 137 insertions(+), 1 deletion(-)

-- 
2.45.0


