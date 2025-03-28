Return-Path: <netdev+bounces-178088-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FB69A74755
	for <lists+netdev@lfdr.de>; Fri, 28 Mar 2025 11:08:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C44ED17E19B
	for <lists+netdev@lfdr.de>; Fri, 28 Mar 2025 10:06:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D1D1218AA5;
	Fri, 28 Mar 2025 10:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hrMEmCZm"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47E0F217651
	for <netdev@vger.kernel.org>; Fri, 28 Mar 2025 10:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743156344; cv=none; b=VY2rU8ZLG6WW5NFTStYjk3bo34CrVo43RUNASmtYMGJvzRg8VHLmirD+vedbCFa5UkSz5jBu4aZs/506Qty6/LlLZOZkgMa9vadBusFuNISk3jv6fCqCwm4qg7IQzxXWpiK3pw9NM5+7FEZI5UHYfXIb27fNio5wlecxdqqmBcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743156344; c=relaxed/simple;
	bh=RTPbHCVapqKPZx4VaunVDXOxrE1fYfc0fOVp1DVbsyo=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jPEt0qaJT73ughpbg2JaaNUzUokuOcdUBpj3nEYuCww5xjA4yoRcpDRn9eltIRPUkEdn3tLvC0hSH18KkUJTak2ioL7oHgVRFNP0sSn8SXBfHZHpWqUo4fZnBeRa15rIvxJKSo460JDVcAMMvKUScr7fYnEmruRvhVNRG83lUks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hrMEmCZm; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1743156342;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=836m3uQYIHpi/fFuQCoe/tuePm2X78qNcz7/OMmLryw=;
	b=hrMEmCZmEZJpE3+RUDfyqh2Xin1ARgg6DfJ9kza9IChLTj3iGINivrF1supuT6PHkOW4PQ
	H9poo516dy4eKTtTrg0QorV1BCvG0D8XVSft/fK8aeu+A/3F3PjZC/1rpEHrckA+cMywQ/
	IPvTYve+Sqs0kH0Vo0jK8McJmNzon+s=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-413-fcIvq0cSM9-O4wVFIAQJSg-1; Fri,
 28 Mar 2025 06:05:38 -0400
X-MC-Unique: fcIvq0cSM9-O4wVFIAQJSg-1
X-Mimecast-MFC-AGG-ID: fcIvq0cSM9-O4wVFIAQJSg_1743156337
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D0B52180025C;
	Fri, 28 Mar 2025 10:05:36 +0000 (UTC)
Received: from server.redhat.com (unknown [10.72.112.11])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 43D913001D0F;
	Fri, 28 Mar 2025 10:05:31 +0000 (UTC)
From: Cindy Lu <lulu@redhat.com>
To: lulu@redhat.com,
	jasowang@redhat.com,
	mst@redhat.com,
	michael.christie@oracle.com,
	sgarzare@redhat.com,
	linux-kernel@vger.kernel.org,
	virtualization@lists.linux-foundation.org,
	netdev@vger.kernel.org
Subject: [PATCH v8 8/8] vhost: Add a KConfig knob to enable IOCTL VHOST_FORK_FROM_OWNER
Date: Fri, 28 Mar 2025 18:02:52 +0800
Message-ID: <20250328100359.1306072-9-lulu@redhat.com>
In-Reply-To: <20250328100359.1306072-1-lulu@redhat.com>
References: <20250328100359.1306072-1-lulu@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Introduce a new config knob `CONFIG_VHOST_ENABLE_FORK_OWNER_IOCTL`,
to control the availability of the `VHOST_FORK_FROM_OWNER` ioctl.
When CONFIG_VHOST_ENABLE_FORK_OWNER_IOCTL is set to n, the ioctl
is disabled, and any attempt to use it will result in failure.

Signed-off-by: Cindy Lu <lulu@redhat.com>
---
 drivers/vhost/Kconfig | 15 +++++++++++++++
 drivers/vhost/vhost.c |  3 +++
 2 files changed, 18 insertions(+)

diff --git a/drivers/vhost/Kconfig b/drivers/vhost/Kconfig
index b455d9ab6f3d..e5b9dcbf31b6 100644
--- a/drivers/vhost/Kconfig
+++ b/drivers/vhost/Kconfig
@@ -95,3 +95,18 @@ config VHOST_CROSS_ENDIAN_LEGACY
 	  If unsure, say "N".
 
 endif
+
+config VHOST_ENABLE_FORK_OWNER_IOCTL
+	bool "Enable IOCTL VHOST_FORK_FROM_OWNER"
+	default n
+	help
+	  This option enables the IOCTL VHOST_FORK_FROM_OWNER, which allows
+	  userspace applications to modify the thread mode for vhost devices.
+
+          By default, `CONFIG_VHOST_ENABLE_FORK_OWNER_IOCTL` is set to `n`,
+          meaning the ioctl is disabled and any operation using this ioctl
+          will fail.
+          When the configuration is enabled (y), the ioctl becomes
+          available, allowing users to set the mode if needed.
+
+	  If unsure, say "N".
diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
index fb0c7fb43f78..568e43cb54a9 100644
--- a/drivers/vhost/vhost.c
+++ b/drivers/vhost/vhost.c
@@ -2294,6 +2294,8 @@ long vhost_dev_ioctl(struct vhost_dev *d, unsigned int ioctl, void __user *argp)
 		r = vhost_dev_set_owner(d);
 		goto done;
 	}
+
+#ifdef CONFIG_VHOST_ENABLE_FORK_OWNER_IOCTL
 	if (ioctl == VHOST_FORK_FROM_OWNER) {
 		u8 inherit_owner;
 		/*inherit_owner can only be modified before owner is set*/
@@ -2313,6 +2315,7 @@ long vhost_dev_ioctl(struct vhost_dev *d, unsigned int ioctl, void __user *argp)
 		r = 0;
 		goto done;
 	}
+#endif
 	/* You must be the owner to do anything else */
 	r = vhost_dev_check_owner(d);
 	if (r)
-- 
2.45.0


