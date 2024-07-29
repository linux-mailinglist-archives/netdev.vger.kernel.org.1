Return-Path: <netdev+bounces-113493-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6962393ECEE
	for <lists+netdev@lfdr.de>; Mon, 29 Jul 2024 07:22:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E9C8281425
	for <lists+netdev@lfdr.de>; Mon, 29 Jul 2024 05:22:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21E788288C;
	Mon, 29 Jul 2024 05:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N2FWZFA0"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D481B80BF8
	for <netdev@vger.kernel.org>; Mon, 29 Jul 2024 05:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722230527; cv=none; b=ffww8z7QOa6/GgN3PSXXZNZwuiYysP7UrfwswojFj1dq9qZn7lfp8mwkZrExzytLFptf/DToQ6KDEPLDKHHR6eL8gm7xkNkrnwvX8f7tm2Jk4kWBafPn/X3l2FXSG9fA0yyTQjYmNo/C2kXqcwWvD5dzllAU7yj41nkAz5xeETA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722230527; c=relaxed/simple;
	bh=GPN0jjFfT/BA6h8jFrFebf2Sdt919SK6NeB4CTedbn8=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=AObyMaaobo/rDnva/nnFT/PkhzTXOOthf3+wQRdZpK7g6Srg0VK8kUoIGevjTlauiDbBbhIWbjRxYnGxGE62Rwu52Xr4sju9rhbz2DVTmx99KJqKeIZhnrv/tZrJPuNYSZr15uvxhcc8Mw7R/LKq0VR16ONCMjhjVMqVx855/0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=N2FWZFA0; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722230523;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=vQfZN7k4ZxQj4iZl6k75EO3jnmshySL3thsmTEvOARc=;
	b=N2FWZFA0JJDFpDuGEljeNZmPmrGq3/WUUk+i++feL/6Gj/3hq4cm2F8sTWpr44FAxPQo2+
	WJj7Fs95js5EfMoABFuQpkpQaVoPJy3Ld9J+I4WCf6MEjG/kkrj6UqpB70Vck85tiaXgYO
	itI0vnK7qrj84ulJC3PgxwO//kemwwE=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-615-4mKCWyYdO3--p_2ma8hYYw-1; Mon,
 29 Jul 2024 01:21:59 -0400
X-MC-Unique: 4mKCWyYdO3--p_2ma8hYYw-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CA5001955D4F;
	Mon, 29 Jul 2024 05:21:57 +0000 (UTC)
Received: from server.redhat.com (unknown [10.72.112.168])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id B9ADB195605F;
	Mon, 29 Jul 2024 05:21:50 +0000 (UTC)
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
Subject: [PATCH v7 0/3] vdpa: support set mac address from vdpa tool
Date: Mon, 29 Jul 2024 13:20:44 +0800
Message-ID: <20240729052146.621924-1-lulu@redhat.com>
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

Cindy Lu (3):
  vdpa: support set mac address from vdpa tool
  vdpa_sim_net: Add the support of set mac address
  vdpa/mlx5: Add the support of set mac address

 drivers/vdpa/mlx5/net/mlx5_vnet.c    | 28 ++++++++++
 drivers/vdpa/vdpa.c                  | 80 ++++++++++++++++++++++++++++
 drivers/vdpa/vdpa_sim/vdpa_sim_net.c | 21 +++++++-
 include/linux/vdpa.h                 |  9 ++++
 include/uapi/linux/vdpa.h            |  1 +
 5 files changed, 138 insertions(+), 1 deletion(-)

-- 
2.45.0


