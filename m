Return-Path: <netdev+bounces-154533-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 882219FE5FA
	for <lists+netdev@lfdr.de>; Mon, 30 Dec 2024 13:46:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B2AF188269C
	for <lists+netdev@lfdr.de>; Mon, 30 Dec 2024 12:46:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48D511A8407;
	Mon, 30 Dec 2024 12:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="W8RIpFjv"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4553C1A840C
	for <netdev@vger.kernel.org>; Mon, 30 Dec 2024 12:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735562706; cv=none; b=DDf0X55A0xs/7fg7AmjVp57l7o+bDs1TO5EBraqkR3aPHXYgJyagokyfiQwLJOc2mEQvieZkgHrvJrcLEUMOhti1vbuE1wjlQwhWKvAgwDIw5z4kY8oP7/lrf+FFOgGes+s9aFEwwIvlFR29hZftKUKT+4GsHoOB6nJ8Ud7hK/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735562706; c=relaxed/simple;
	bh=a7sVd14sFIboiPaOed84M5XAf96K9FVe2o7eezLkoTg=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=oNTQYgEtEVIzJiljuogVqfD4zmg9pMrhxnjRypGHgKhEokMtFnzFYhNUMuhaVSJyIg+AJAX/7qXODtEtqPzO1Fra5ZQfisEbEbiM3mBO5eKPNti3zxcFDZUiQNxYmjvqAx1V8BEHG+kLWzrLdrf1+5ygiGcRM/6fWyW1L3KZJDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=W8RIpFjv; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1735562703;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=M6pCcu1i8voqrxUyXfYF8ApIPPT+9gE7r48bo7wHwWg=;
	b=W8RIpFjvHdUHLWgMXtlEcE6x5SnbQK6EaFxLn+qZZ/BGZ/8lZPKppO9F+WtdJ4n7GRf4d0
	6U3kaDuJrKsLLbO1AhqEtFy8qR2PDB1d7H4hh+TxjLOpVBcq+Y9HXHFZdDnp9eKUrtlfRt
	n6h/R/4+NpvaebVgopxOh9I82ssNy+U=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-478-BYQFNTWUN5KuddgKNFkdFA-1; Mon,
 30 Dec 2024 07:45:00 -0500
X-MC-Unique: BYQFNTWUN5KuddgKNFkdFA-1
X-Mimecast-MFC-AGG-ID: BYQFNTWUN5KuddgKNFkdFA
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E5B64195608E;
	Mon, 30 Dec 2024 12:44:58 +0000 (UTC)
Received: from server.redhat.com (unknown [10.72.112.25])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 6A9371956053;
	Mon, 30 Dec 2024 12:44:54 +0000 (UTC)
From: Cindy Lu <lulu@redhat.com>
To: lulu@redhat.com,
	jasowang@redhat.com,
	mst@redhat.com,
	michael.christie@oracle.com,
	sgarzare@redhat.com,
	linux-kernel@vger.kernel.org,
	virtualization@lists.linux-foundation.org,
	netdev@vger.kernel.org
Subject: [PATCH v5 0/6] vhost: Add support of kthread API
Date: Mon, 30 Dec 2024 20:43:47 +0800
Message-ID: <20241230124445.1850997-1-lulu@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

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
 
Tested with QEMU with kthread mode/task mode/kthread+task mode

Cindy Lu (6):
  vhost: Add a new parameter in vhost_dev to allow user select kthread
  vhost: Add the vhost_worker to support kthread
  vhost: Add the cgroup related function
  vhost: Add worker related functions to support kthread
  vhost: Add new UAPI to support change to task mode
  vhost_scsi: Add check for inherit_owner status

 drivers/vhost/scsi.c       |   8 ++
 drivers/vhost/vhost.c      | 178 +++++++++++++++++++++++++++++++++----
 drivers/vhost/vhost.h      |   4 +
 include/uapi/linux/vhost.h |  19 ++++
 4 files changed, 192 insertions(+), 17 deletions(-)

-- 
2.45.0


