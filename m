Return-Path: <netdev+bounces-168829-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E9E4A40F7F
	for <lists+netdev@lfdr.de>; Sun, 23 Feb 2025 16:41:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5735C3B81BC
	for <lists+netdev@lfdr.de>; Sun, 23 Feb 2025 15:40:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9B332080C8;
	Sun, 23 Feb 2025 15:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GV+95Us8"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6AA82066D4
	for <netdev@vger.kernel.org>; Sun, 23 Feb 2025 15:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740325258; cv=none; b=hQvmFt3EVpQfCgjFuzRep0gDWBUXpXaWkTCTmHPTuDsNpp0LzPCX8KRT1oIMtpT4lYhISRfxafnMiUnN7hcz+o95GhAAv4h440uxGQbblmMGRjQKUdQLZxxQnLEopa6NJlgNxbT13Kd58azeg6Dk2OPt55LzMtG5BgFJiRRI8bM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740325258; c=relaxed/simple;
	bh=X/aFGH9RNj7a4Xf79GRWoIawpV/GLtHte90w95RS2zM=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=LaA7mlNLlCV/odoS+h1guo7jg8oacdF/Igx7LxyjVvfCTTpqslyi1LY8ZiA9p+Q9Ty86ZkDX5P+1vNckzBIUE0TqvU8eXYsJSNk/cpFvKZ1x7XYv/gRCyPE6Gw1cu6SNMyDQDeWpm1CnqysxF3J+inEhVR7e+g2s91msMulCpHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GV+95Us8; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740325255;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=3daOfx/UUkuCI2mXipJDEp+cn8WpyrHXA0jn2fBJVSA=;
	b=GV+95Us8m4EF2mxdCwNj3Q+f5J39KPCT/RHcJeCRRrlYiYSKz+LCu6N6gT5qNWkcFdj3LJ
	z151GGuDls1ENw4xGRv91ifWVH10Y1YUNa93JwxYsnn/nvhz/x8SVMp5axTeDMZyciqtkm
	EG3yT/fZ5HziWnvBE86DKtJhlcQ5Gv4=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-662-sSW-6prXOQa4dHd0PI2KkA-1; Sun,
 23 Feb 2025 10:40:52 -0500
X-MC-Unique: sSW-6prXOQa4dHd0PI2KkA-1
X-Mimecast-MFC-AGG-ID: sSW-6prXOQa4dHd0PI2KkA_1740325251
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id EB6C81800374;
	Sun, 23 Feb 2025 15:40:50 +0000 (UTC)
Received: from server.redhat.com (unknown [10.72.112.28])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 3C81419412A3;
	Sun, 23 Feb 2025 15:40:45 +0000 (UTC)
From: Cindy Lu <lulu@redhat.com>
To: lulu@redhat.com,
	jasowang@redhat.com,
	mst@redhat.com,
	michael.christie@oracle.com,
	sgarzare@redhat.com,
	linux-kernel@vger.kernel.org,
	virtualization@lists.linux-foundation.org,
	netdev@vger.kernel.org
Subject: [PATCH v6 0/6] vhost: Add support of kthread API
Date: Sun, 23 Feb 2025 23:36:15 +0800
Message-ID: <20250223154042.556001-1-lulu@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

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
 5. reset the value of inherit_owner in vhost_dev_reset_owner  
 
Tested with QEMU with kthread mode/task mode/kthread+task mode

Cindy Lu (6):
  vhost: Add a new parameter in vhost_dev to allow user select kthread
  vhost: Reintroduce vhost_worker to support kthread
  vhost: Add the cgroup related function
  vhost: introduce worker ops to support multiple thread models
  vhost: Add new UAPI to support change to task mode
  vhost: Add check for inherit_owner status

 drivers/vhost/vhost.c      | 227 +++++++++++++++++++++++++++++++++----
 drivers/vhost/vhost.h      |  13 +++
 include/uapi/linux/vhost.h |  18 +++
 3 files changed, 234 insertions(+), 24 deletions(-)

-- 
2.45.0


