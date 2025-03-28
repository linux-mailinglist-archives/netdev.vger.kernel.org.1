Return-Path: <netdev+bounces-178080-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25342A74707
	for <lists+netdev@lfdr.de>; Fri, 28 Mar 2025 11:04:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CDD073AF2BB
	for <lists+netdev@lfdr.de>; Fri, 28 Mar 2025 10:04:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8B7021423B;
	Fri, 28 Mar 2025 10:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QjfBWmOK"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B21B62914
	for <netdev@vger.kernel.org>; Fri, 28 Mar 2025 10:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743156255; cv=none; b=RgMmhqAGtXvf8gGxW5YO/6yK/sxj2fWW0sqOrNrPa0zy6BRLfM72DPI/6EFem+Q9zT0i6hOV590L6rFTdXj0LG0+RAeJR85AXUdtDWLmVUt2z/hxYTgXskF01EzisMJsxBNoLVHWgMeJ8NOO52nC5jYsAPybLnZa5/Qw6IRvZj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743156255; c=relaxed/simple;
	bh=BxJyqfjqFFWb7rQZBzkcHbcIzZRMsG2X38T6Q0EPsMg=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=b1ycP4ahuQ6WDhNFYiUU4AQEsQVMqbyk/rU4jCnf/WlQV57VYDf17V8lph4Ksyv11tBhd2V8X2/TZZhrL8P0/G31HNzMVje9k0PO4f43+v8YeVNhobQAdjyXRGp5I6ryc8yYV9giCwlhIDYbPxlBMzwMHwGnN1yJ3ot2ZuKltZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QjfBWmOK; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1743156252;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=yfBi3j6rR33aofiDW5F1wW7fpF1R8tZfVl3qCFGPgFc=;
	b=QjfBWmOKK79f6car33/b0Pf9+PtlE8ySc+LivQ/wiMvuzMwZ+uy5X21GYTYdby6Zk/Hj3V
	sSj+jbQTh6Ti0H7XAVuT28Ti/kSPocGFAreZEA/haR4nkSL8gj7d7G6HBErBfV1Ts0CXha
	tUBV+ZbOAVMgqWdtBSbVhQIjsyJtXCc=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-663-qHMZhdlUNCSu37dT0GmKzw-1; Fri,
 28 Mar 2025 06:04:11 -0400
X-MC-Unique: qHMZhdlUNCSu37dT0GmKzw-1
X-Mimecast-MFC-AGG-ID: qHMZhdlUNCSu37dT0GmKzw_1743156249
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id ABAC0180025B;
	Fri, 28 Mar 2025 10:04:09 +0000 (UTC)
Received: from server.redhat.com (unknown [10.72.112.11])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 3D70730001A1;
	Fri, 28 Mar 2025 10:04:03 +0000 (UTC)
From: Cindy Lu <lulu@redhat.com>
To: lulu@redhat.com,
	jasowang@redhat.com,
	mst@redhat.com,
	michael.christie@oracle.com,
	sgarzare@redhat.com,
	linux-kernel@vger.kernel.org,
	virtualization@lists.linux-foundation.org,
	netdev@vger.kernel.org
Subject: [PATCH v8 0/8] vhost: Add support of kthread API
Date: Fri, 28 Mar 2025 18:02:44 +0800
Message-ID: <20250328100359.1306072-1-lulu@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

In commit 6e890c5d5021 ("vhost: use vhost_tasks for worker threads"),
the vhost now uses vhost_task and operates as a child of the
owner thread. This aligns with containerization principles.
However, this change has caused confusion for some legacy
userspace applications. Therefore, we are reintroducing
support for the kthread API.

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

Tested with QEMU with kthread mode/task mode/kthread+task mode

Cindy Lu (8):
  vhost: Add a new parameter in vhost_dev to allow user select kthread
  vhost: Reintroduce vhost_worker to support kthread
  vhost: Add the cgroup related function
  vhost: Introduce vhost_worker_ops in vhost_worker
  vhost: Reintroduce kthread mode support in vhost
  vhost: uapi to control task mode (owner vs kthread)
  vhost: Add check for inherit_owner status
  vhost: Add a KConfig knob to enable IOCTL VHOST_FORK_FROM_OWNER

 drivers/vhost/Kconfig      |  15 +++
 drivers/vhost/vhost.c      | 219 +++++++++++++++++++++++++++++++++----
 drivers/vhost/vhost.h      |  21 ++++
 include/uapi/linux/vhost.h |  16 +++
 4 files changed, 252 insertions(+), 19 deletions(-)

-- 
2.45.0


