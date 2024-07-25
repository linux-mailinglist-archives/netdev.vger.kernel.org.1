Return-Path: <netdev+bounces-112890-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E5C0B93BA27
	for <lists+netdev@lfdr.de>; Thu, 25 Jul 2024 03:32:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 749FB1F21EB5
	for <lists+netdev@lfdr.de>; Thu, 25 Jul 2024 01:32:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FC653D8E;
	Thu, 25 Jul 2024 01:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RMXtIkNw"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E90DD6112
	for <netdev@vger.kernel.org>; Thu, 25 Jul 2024 01:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721871152; cv=none; b=JF367qOoCzZ3T6AkvNPCqgzs5b4xGhCZne9Q5yR2xRk9CmHLb8tgkMCOcN6gXaONjS+xXJCAX6h7H5IUcF3Feq/q/HlqTSVIgi3NhLYxp1PxWMx0vR1cl51+huKzyMrbZcTQzngOTRfdlobnnGTrocFxwrNqVXRvDcxj7KRD4Cs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721871152; c=relaxed/simple;
	bh=f5IcGXYse95pgYaA+PA4U920JSA5b88X1Xog3re2538=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=SFf/MF0MKwc9sh3JkjOuW8WsdQJ0oqv0DFb5qp273gvGW7UGGfFlHnq79NdfwwkJFl5Z8xCjBC0MU4RRHM9ZcZt4fDZ2E1/nLCq2iIVWC232fJzBbQYWTduk3Kp+wLWsW9PKL3LN7TwCnE6gfztAfYN2+QM7uuuHhuzZAW5nb/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RMXtIkNw; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721871148;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=3AFvrky8PX7geVy4VOlD+26UP7h3zv3ayB+/222jDiQ=;
	b=RMXtIkNwx4m+IRpDLFB1sQ1G0Pm4Y1qY4OYEP++BwqcVOeJ7Jt4PLueEM+ELbDsKIlVKpN
	dzdLe9eXiV8MXDJPG167NsdNLtAY4oyMhSMfeAKB+3GGF+Utkt2yBYs7xFb17j3NySVq6H
	arOKX3yHTjCF+ZYhUpQma1o5q0DbvHU=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-445-Cxb1LMW5NW-3XnmWQtYOiA-1; Wed,
 24 Jul 2024 21:32:27 -0400
X-MC-Unique: Cxb1LMW5NW-3XnmWQtYOiA-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2C7701955D45;
	Thu, 25 Jul 2024 01:32:26 +0000 (UTC)
Received: from server.redhat.com (unknown [10.72.112.141])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id E54031955D42;
	Thu, 25 Jul 2024 01:32:20 +0000 (UTC)
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
Subject: [PATH v6 0/3] vdpa: support set mac address from vdpa tool
Date: Thu, 25 Jul 2024 09:31:01 +0800
Message-ID: <20240725013217.1124704-1-lulu@redhat.com>
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

Cindy Lu (3):
  vdpa: support set mac address from vdpa tool
  vdpa_sim_net: Add the support of set mac address
  vdpa/mlx5: Add the support of set mac address

 drivers/vdpa/mlx5/net/mlx5_vnet.c    | 28 ++++++++++
 drivers/vdpa/vdpa.c                  | 80 ++++++++++++++++++++++++++++
 drivers/vdpa/vdpa_sim/vdpa_sim_net.c | 22 +++++++-
 include/linux/vdpa.h                 |  9 ++++
 include/uapi/linux/vdpa.h            |  1 +
 5 files changed, 139 insertions(+), 1 deletion(-)

-- 
2.45.0


