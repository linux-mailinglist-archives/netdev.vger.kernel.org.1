Return-Path: <netdev+bounces-194488-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B082BAC9A5A
	for <lists+netdev@lfdr.de>; Sat, 31 May 2025 11:58:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 823CD7AD588
	for <lists+netdev@lfdr.de>; Sat, 31 May 2025 09:57:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D84D4238C3F;
	Sat, 31 May 2025 09:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gLsVnDHf"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1AD6F9CB
	for <netdev@vger.kernel.org>; Sat, 31 May 2025 09:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748685497; cv=none; b=sBa9ZXLrd+7T6I4sgfYexnrEhPDcD3ITrFc8WtUVMoIr+5sdZizOaTzqeJGOUS3YDQBnDUqajr9XywL+rqfhrEJbPxN0r54PHCLavZtJbtcMpCse3uSm3hXaEr7ue50N5bHXwJlBHijfKCujaXSdDWIj+YtJA4aGUY5/Ko7i+8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748685497; c=relaxed/simple;
	bh=htcIGQT/ssGQoVXxIOhF1ldkMjyiJzTn3btvkIt0uRw=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=u/JwwvYVv1Jep9W+lgQC1ng/jP3WtUcGo/UwQmXnUB8CLzrAaLprKTdj2thuVV+fEV+Vy3yandtbT1sUnbVYk6grDgP9mfBR87sOOgMbNQFeVFgXZ4mN46gSFw8bIo8Zb4mC9N4e0L0vL9SCB+6wHHRmqBVFxXRzd9OmDE3XX+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gLsVnDHf; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1748685494;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=jJyUMglAGJzwPtxv28dkdLEq4lYUgcqEQo++4faeYEU=;
	b=gLsVnDHf0OfmQs0A3hsVI2HIbYhZWzU4ajo4RnwFaR1BXOPMbshL5lntExkoX734YcQkmo
	Xd9nPAQQmlESrsWyV0LvzEsTkARYLj8Ultn/Gio7izuQd36qaFANGOXTW5V3YNef9rowJN
	tqy+XI4HSjqyMhJ8EFvs9/tpwSl8iIw=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-601-iXhbsLNPMBWemOHshKwxdw-1; Sat,
 31 May 2025 05:58:11 -0400
X-MC-Unique: iXhbsLNPMBWemOHshKwxdw-1
X-Mimecast-MFC-AGG-ID: iXhbsLNPMBWemOHshKwxdw_1748685490
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5C66C1800360;
	Sat, 31 May 2025 09:58:10 +0000 (UTC)
Received: from server.redhat.com (unknown [10.72.112.30])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 03D22180049D;
	Sat, 31 May 2025 09:58:05 +0000 (UTC)
From: Cindy Lu <lulu@redhat.com>
To: lulu@redhat.com,
	jasowang@redhat.com,
	mst@redhat.com,
	michael.christie@oracle.com,
	sgarzare@redhat.com,
	linux-kernel@vger.kernel.org,
	virtualization@lists.linux-foundation.org,
	netdev@vger.kernel.org
Subject: [PATCH RESEND v10 0/3] vhost: Add support of kthread API
Date: Sat, 31 May 2025 17:57:25 +0800
Message-ID: <20250531095800.160043-1-lulu@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

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
 
 
Changelog v10:
 1.Add support for the module_param.
 2.Squash patches 3 and 4.
 3.Make minor fixes in the commit log.
 4.Fix the mismatched tabs in Kconfig.
 5.Rebase on the latest kernel.
    
Tested with QEMU with kthread mode/task mode/kthread+task mode

Cindy Lu (3):
  vhost: Add a new modparam to allow userspace select kthread
  vhost: Reintroduce kthread mode support in vhost
  vhost: Add new UAPI to select kthread mode and KConfig to enable this
    IOCTL

 drivers/vhost/Kconfig      |  13 +++
 drivers/vhost/vhost.c      | 223 +++++++++++++++++++++++++++++++++----
 drivers/vhost/vhost.h      |  22 ++++
 include/uapi/linux/vhost.h |  16 +++
 4 files changed, 255 insertions(+), 19 deletions(-)

-- 
2.45.0


