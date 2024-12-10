Return-Path: <netdev+bounces-150753-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 245FC9EB6D0
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 17:45:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC392281BE5
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 16:45:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63E23233D96;
	Tue, 10 Dec 2024 16:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dZaGV9eI"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D94F22FE18
	for <netdev@vger.kernel.org>; Tue, 10 Dec 2024 16:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733849113; cv=none; b=FErPTrOvdiCCo3NmVVRuD7cYtDDthxgmd9XZpTBFLpLSXPh2Kh4Pv4gNxALdIZRbYrO41yfvpDADTxFdQ4PMgBSgObSIDblIxv4M5xzX8SL/DSZgwBsKKDPamad+r7aT/H1PyqVOjhoJ6BFuq8oHu9fGlpWXnoGhR7XT9tuZEsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733849113; c=relaxed/simple;
	bh=JdLNXbXLVVNZXlqcZZ5mTL4fFReWTKrSXq/RNIRxekk=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=Y16tYbosKc934jlTbxYHKtZHlQkqLtEadL+czyGqDQrYCXqirQDDT7kLykd8u2k16PxZUkJSVpzzKyVA7q+dbEI0UGCtfv47lc9BBJy0dCiP4hXQG9VOMs6g9XpKVm7M+GSAV8EYiFcrC56uPofLlIrR+Ojdl1S+DtN5t/9TiZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dZaGV9eI; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733849110;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=7Kp+7Z3nNLIcj1z6tn9P0/hb1TnLvUena0MeRSjLsfA=;
	b=dZaGV9eItz7KHv2d8AAdqxem1BjmIj9gnOMM2dsNIoGb791NHhX7D6nhDoQoVXQYyzb7yJ
	nBveaNUv2ELErvDyCSv4FFe0+bd9ZK6tz0nHoSdqOha7nuGMXbf0aNHl5L8PmJ+qrKFplM
	tmt+mJANL2Btdv6K7CDo6hpBLqhaC38=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-553-uNW6YTPAOPybW7l6F610Jw-1; Tue,
 10 Dec 2024 11:45:05 -0500
X-MC-Unique: uNW6YTPAOPybW7l6F610Jw-1
X-Mimecast-MFC-AGG-ID: uNW6YTPAOPybW7l6F610Jw
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 964831955F42;
	Tue, 10 Dec 2024 16:45:04 +0000 (UTC)
Received: from server.redhat.com (unknown [10.72.112.152])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id DA98E19560AA;
	Tue, 10 Dec 2024 16:44:59 +0000 (UTC)
From: Cindy Lu <lulu@redhat.com>
To: lulu@redhat.com,
	jasowang@redhat.com,
	mst@redhat.com,
	michael.christie@oracle.com,
	sgarzare@redhat.com,
	linux-kernel@vger.kernel.org,
	virtualization@lists.linux-foundation.org,
	netdev@vger.kernel.org
Subject: [PATCH v4 0/8] vhost: Add support of kthread API
Date: Wed, 11 Dec 2024 00:41:39 +0800
Message-ID: <20241210164456.925060-1-lulu@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

In commit 6e890c5d5021 ("vhost: use vhost_tasks for worker threads"),

The vhost now uses vhost_task and operates as a child of the owner thread.
This aligns with containerization principles, But it has confused some legacy
userspace applications. Therefore, we are reintroducing support
for the kthread API.

In commit 6e890c5d5021 ("vhost: use vhost_tasks for worker threads"),
The vhost now use vhost_task and workers working as a child of the owner thread,
which aligns with containerization principles. However, this change has caused
confusion for some legacy userspace applications. 
Therefore, we are reintroducing support for the kthread API.

In this patch, a new User API is implemented to allow userspace applications to
configure their request mode.

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
 
Tested with QEMU with kthread mode/task mode/kthread+task mode

Cindy Lu (8):
  vhost: Add a new parameter in vhost_dev to allow user select kthread
  vhost: Add the vhost_worker to support kthread
  vhost: Add the cgroup related function
  vhost: Add kthread support in function vhost_worker_create
  vhost: Add kthread support in function vhost_worker_queue()
  vhost: Add kthread support in function vhost_worker_destroy()
  vhost: Add new UAPI to support change to task mode
  vhost_scsi: Add check for inherit_owner status

 drivers/vhost/scsi.c       |   8 ++
 drivers/vhost/vhost.c      | 185 +++++++++++++++++++++++++++++++++----
 drivers/vhost/vhost.h      |   4 +
 include/uapi/linux/vhost.h |  18 ++++
 4 files changed, 198 insertions(+), 17 deletions(-)

-- 
2.45.0


