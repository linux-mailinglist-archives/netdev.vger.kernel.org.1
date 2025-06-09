Return-Path: <netdev+bounces-195644-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3197AD1905
	for <lists+netdev@lfdr.de>; Mon,  9 Jun 2025 09:34:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8BF451668C8
	for <lists+netdev@lfdr.de>; Mon,  9 Jun 2025 07:34:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 385D827F160;
	Mon,  9 Jun 2025 07:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JTEZM4/v"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38E7D25C813
	for <netdev@vger.kernel.org>; Mon,  9 Jun 2025 07:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749454483; cv=none; b=sowSRUTA19JmtFHHes05LrQfULEgMkp3ifU+pw3AFF4KQv55MDsJfVFNbKKe5fWAFlI41gXf5CbIWD2wGn8ZqjzMuDmt1hfXrlwcg9uoCBI0ZdP5+0EOkso7K9IPb3ZR9Tj7eP6sJla970BxcwXgDDykk6zyudH+TZ0YMswglaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749454483; c=relaxed/simple;
	bh=Pk2IKlN944aLWRdOUSAy2DXbgVTz9MMRw1o6JvUdAXE=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ToOgElFhLWxPAsgH0s+uqmrEBB+dTLXNyC1JzzNqdpvwDABBVukDwtIzrZwhDPzAS/+p9z8miCHzrwBA2d8sz4OCbZMXnU8x4oX5HM99hNMIfczMd0hVwfJhRSQT7uUQPYHQMkZQUXeSvwDQ5uLa24HREOS/4qSSlsFpZpmnCtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JTEZM4/v; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749454480;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=lgIvOtbbVoeCdziN1/6LEAtUpp454oRAjXMdabFdZhE=;
	b=JTEZM4/vvnsSchyTysDJEC+hWkpzGZAsaXnHy1gFfb93MxaDEYbIdtHw6R29AWzMWWGzXd
	Z7fg99yDXQ9JWveEf4CZuUeQOop3uM+fXpEfwoxfu5cRvk/6biG6qZEHCb1Mic4Lnn3u9Q
	INtm0le5c7y8GAfqdCIvNBAPyn/+d2s=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-682-XO18P4WAPvuO8ZGsJPSbuQ-1; Mon,
 09 Jun 2025 03:34:38 -0400
X-MC-Unique: XO18P4WAPvuO8ZGsJPSbuQ-1
X-Mimecast-MFC-AGG-ID: XO18P4WAPvuO8ZGsJPSbuQ_1749454477
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 34B7B1800343;
	Mon,  9 Jun 2025 07:34:37 +0000 (UTC)
Received: from server.redhat.com (unknown [10.72.112.22])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 449DA19560AB;
	Mon,  9 Jun 2025 07:34:32 +0000 (UTC)
From: Cindy Lu <lulu@redhat.com>
To: lulu@redhat.com,
	jasowang@redhat.com,
	mst@redhat.com,
	michael.christie@oracle.com,
	sgarzare@redhat.com,
	linux-kernel@vger.kernel.org,
	virtualization@lists.linux-foundation.org,
	netdev@vger.kernel.org
Subject: [PATCH v11 0/3] vhost: Add support of kthread API
Date: Mon,  9 Jun 2025 15:33:06 +0800
Message-ID: <20250609073430.442159-1-lulu@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

In this series, a new UAPI is implemented to allow   
userspace applications to configure their thread mode.

Changelog v2:
 1. Change the module_param's name to enforce_inherit_owner, and the default value is true.
 2. Change the UAPI's name to VHOST_SET_INHERIT_FROM_OWNER.

Changelog v3:
 1. Change the module_param's name to inherit_owner_default, and the default value is true.
 2. Add a structure for task function; the worker will select a different mode based on the value inherit_owner.
 3. device will have their own inherit_owner in struct vhost_dev
 4. Address other comments

Changelog v4:
 1. remove the module_param, only keep the UAPI
 2. remove the structure for task function; change to use the function pointer in vhost_worker
 3. fix the issue in vhost_worker_create and vhost_dev_ioctl
 4. Address other comments

Changelog v5:
 1. Change wakeup and stop function pointers in struct vhost_worker to void.
 2. merging patches 4, 5, 6 in a single patch
 3. Fix spelling issues and address other comments.

Changelog v6:
 1. move the check of VHOST_NEW_WORKER from vhost_scsi to vhost
 2. Change the ioctl name VHOST_SET_INHERIT_FROM_OWNER to VHOST_FORK_FROM_OWNER
 3. reuse the function __vhost_worker_flush
 4. use a ops sturct to support worker relates function
 5. reset the value of inherit_owner in vhost_dev_reset_owner.
 
Changelog v7: 
 1. add a KConfig knob to disable legacy app support
 2. Split the changes into two patches to separately introduce the ops and add kthread support.
 3. Utilized INX_MAX to avoid modifications in __vhost_worker_flush
 4. Rebased on the latest kernel
 5. Address other comments
 
Changelog v8: 
 1. Rebased on the latest kernel
 2. Address some other comments 
 
Changelog v9:
 1. Rebased on the latest kernel. 
 2. Squashed patches 6‑7. 
 3. Squashed patches 2‑4. 
 4. Minor fixes in commit log
 
Changelog v10:
 1.Add support for the module_param.
 2.Squash patches 3 and 4.
 3.Make minor fixes in the commit log.
 4.Fix the mismatched tabs in Kconfig.
 5.Rebase on the latest kernel.

Changelog v11:
 1.make the module_param under Kconfig
 2.Make minor fixes in the commit log.
 3.change the name inherit_owner to fork_owner
 4.add NEW ioctl VHOST_GET_FORK_FROM_OWNER
 5.Rebase on the latest kernel
     
Tested with QEMU with kthread mode/task mode/kthread+task mode

Cindy Lu (3):
  vhost: Add a new parameter in vhost_dev to allow user select kthread
  vhost: Reintroduce kthread mode support in vhost
  vhost: Add configuration controls for vhost worker's mode

 drivers/vhost/Kconfig      |  17 +++
 drivers/vhost/vhost.c      | 234 ++++++++++++++++++++++++++++++++++---
 drivers/vhost/vhost.h      |  22 ++++
 include/uapi/linux/vhost.h |  25 ++++
 4 files changed, 280 insertions(+), 18 deletions(-)

-- 
2.45.0


