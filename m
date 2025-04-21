Return-Path: <netdev+bounces-184320-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 195AFA94B21
	for <lists+netdev@lfdr.de>; Mon, 21 Apr 2025 04:45:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F3BA16CC77
	for <lists+netdev@lfdr.de>; Mon, 21 Apr 2025 02:45:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 776CD4964E;
	Mon, 21 Apr 2025 02:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eg2SNGqt"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0620E5C96
	for <netdev@vger.kernel.org>; Mon, 21 Apr 2025 02:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745203513; cv=none; b=DCW3wVed4sY5aoo86vOk12rb3i9z4p6p/8Wvc8z3qN0ecOlId1pnhwOBv82957d2FPjSr8xyRZOga8p+gYKlzUPMHeb9egAk98MiajWRw96AwtUAcsrxcInuBcgLAqsOH3sIG1XQLx35JVDs5xjWv99sQwrrl4mbTSagCpF61QY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745203513; c=relaxed/simple;
	bh=ChmpkBWAcBUZ0isTg/2/kwH0+i+db/Z7zSyRokRGl4o=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=S92oYWIKPM6c6caPj10YQK/X4UyFgFvcZjzqdnWfYTbhXVKRwBShfej6BDpqLVrXrYc9ubF87hX2k0mQ0ynHFnkAX+kNOYyq5B9CIp9p7o7/co5JIc3gOJZGxkwYEVX3M8s1etsgbw4+EhXu+Ak4nxEv1XIGT7+fj7028agk76I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eg2SNGqt; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745203509;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=1rywFvr1FoN+KZUd9Jmk/NHuAzpjaZybpU9faUuHgMw=;
	b=eg2SNGqtFhSQOjcXvxNGwajHCNnj29alLs5CGq0Gspn3t1rvhWV7PSDZ3k6nai6xHbWwNe
	CxDoehOD1fZQ8XbkLLZtoaWKnaOMIl5pMp9cnI0bhXJkjB1+VTlEvAEHbs0qnm3WaWLQKa
	UHnbJihR9NM3l3E0+mwYx/nQkcbv6bE=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-329-XCJievbiMWCnaGosBWBuGw-1; Sun,
 20 Apr 2025 22:45:06 -0400
X-MC-Unique: XCJievbiMWCnaGosBWBuGw-1
X-Mimecast-MFC-AGG-ID: XCJievbiMWCnaGosBWBuGw_1745203505
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 74A3E19560AB;
	Mon, 21 Apr 2025 02:45:05 +0000 (UTC)
Received: from server.redhat.com (unknown [10.72.112.29])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id F27D71801778;
	Mon, 21 Apr 2025 02:45:00 +0000 (UTC)
From: Cindy Lu <lulu@redhat.com>
To: lulu@redhat.com,
	jasowang@redhat.com,
	mst@redhat.com,
	michael.christie@oracle.com,
	sgarzare@redhat.com,
	linux-kernel@vger.kernel.org,
	virtualization@lists.linux-foundation.org,
	netdev@vger.kernel.org
Subject: [PATCH v9 0/4] vhost: Add support of kthread API
Date: Mon, 21 Apr 2025 10:44:06 +0800
Message-ID: <20250421024457.112163-1-lulu@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

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
 
Changelog v9:
 1. Rebased on the latest kernel. 
 2. Squashed patches 6‑7. 
 3. Squashed patches 2‑4. 
 4. Minor fixes in commit log
   
Tested with QEMU with kthread mode/task mode/kthread+task mode

Cindy Lu (4):
  vhost: Add a new parameter in vhost_dev to allow user select kthread
  vhost: Reintroduce kthread mode support in vhost
  vhost: add VHOST_FORK_FROM_OWNER ioctl and validate inherit_owner
  vhost: Add a KConfig knob to enable IOCTL VHOST_FORK_FROM_OWNER

 drivers/vhost/Kconfig      |  15 +++
 drivers/vhost/vhost.c      | 219 +++++++++++++++++++++++++++++++++----
 drivers/vhost/vhost.h      |  21 ++++
 include/uapi/linux/vhost.h |  16 +++
 4 files changed, 252 insertions(+), 19 deletions(-)

-- 
2.45.0


