Return-Path: <netdev+bounces-184324-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DE606A94B2C
	for <lists+netdev@lfdr.de>; Mon, 21 Apr 2025 04:46:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A64FE3B0080
	for <lists+netdev@lfdr.de>; Mon, 21 Apr 2025 02:46:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E4602AF14;
	Mon, 21 Apr 2025 02:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MrePApQZ"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C79F115E90
	for <netdev@vger.kernel.org>; Mon, 21 Apr 2025 02:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745203551; cv=none; b=OPzUyTkl/iukBGdy/I3oSqw9MN6+a0ZrQd6DFPNL7MTk4LTJj1sprJweIIN0htQdA2WPukhem4TCs8oL8F4AZgttGuvh++YGjJWUoSVcdQwfW+c4/F+bsSfKbXs/GAcouaGmIgy/0DGY6fbzhrvzWqBVTUJPBw+eUye9zzR9LmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745203551; c=relaxed/simple;
	bh=xai17yd0Iw0cyri+aEzpllkp4/1VDyGHCbJLE5ukZJM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XwxRZaLwuJw8m8INKK8iJHfxQombPr69QXfmacKak0tegb5nzGZsg7NrPlrM9p6JIA6KnQxKqoPxN9RxLkFhdQOukylfpqvyxhkf288NMMTvdAcunGalHhdJ3+cATou5bc+/rbzc7cLhbcUBuBlKJG3Kt0hIDNKItWlVLuKBnew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MrePApQZ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745203548;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tksn/BeIa6XB+jednamafWrUiiXuAgrox86wRoZ3XDE=;
	b=MrePApQZuGevuFK7ImvPW6AZ2oPUwivOKLFDSlW6bM3BXI5rnzl9GamHY+tUySsrx2+/d5
	vubt3FZkNBGvZwDfLOuAdyNH8USVtDogwQZfk+YQ9lybG4KlpXVAwAB1w5Houlx0dMwiuY
	hhaUlMF9oI/+jaZBc5NxiwdRY6B8frQ=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-665-1w1C6q7mN6-inSOiYaE9XQ-1; Sun,
 20 Apr 2025 22:45:47 -0400
X-MC-Unique: 1w1C6q7mN6-inSOiYaE9XQ-1
X-Mimecast-MFC-AGG-ID: 1w1C6q7mN6-inSOiYaE9XQ_1745203546
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9350219560AA;
	Mon, 21 Apr 2025 02:45:46 +0000 (UTC)
Received: from server.redhat.com (unknown [10.72.112.29])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 8F8CE180138B;
	Mon, 21 Apr 2025 02:45:42 +0000 (UTC)
From: Cindy Lu <lulu@redhat.com>
To: lulu@redhat.com,
	jasowang@redhat.com,
	mst@redhat.com,
	michael.christie@oracle.com,
	sgarzare@redhat.com,
	linux-kernel@vger.kernel.org,
	virtualization@lists.linux-foundation.org,
	netdev@vger.kernel.org
Subject: [PATCH v9 4/4] vhost: Add a KConfig knob to enable IOCTL VHOST_FORK_FROM_OWNER
Date: Mon, 21 Apr 2025 10:44:10 +0800
Message-ID: <20250421024457.112163-5-lulu@redhat.com>
In-Reply-To: <20250421024457.112163-1-lulu@redhat.com>
References: <20250421024457.112163-1-lulu@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

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
index 020d4fbb947c..bc8fadb06f98 100644
--- a/drivers/vhost/Kconfig
+++ b/drivers/vhost/Kconfig
@@ -96,3 +96,18 @@ config VHOST_CROSS_ENDIAN_LEGACY
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


