Return-Path: <netdev+bounces-130250-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 17E0D9896BD
	for <lists+netdev@lfdr.de>; Sun, 29 Sep 2024 20:21:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D283D2844AC
	for <lists+netdev@lfdr.de>; Sun, 29 Sep 2024 18:21:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 368F34207A;
	Sun, 29 Sep 2024 18:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="JTkHnp8s"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A51F536AEC
	for <netdev@vger.kernel.org>; Sun, 29 Sep 2024 18:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727634085; cv=none; b=TMD2JSbDRyrEam0WZ3EbSYNy6Z72aMITUnTXIbn9LSDa9jPG88ZsZWgpbu9TjoS0JZCYA5x4xbTSw75LpFBBBojCx9rZJK/Y/UznpNy8V2qGpd2OTQRaoPqeQh/dOfOMQm8zgKL3BWtuX4ZiHH2IcQpdGDC2JCQZpd7JCDP6HIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727634085; c=relaxed/simple;
	bh=IiI7k5eKIv3t3egjU4Ltp6qafG9X3D4ad7adQ1hTsrs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=K4JY5nbJH0UeAT1+0iuQnu2SLp2ReW7YvLweYLxBCHbEu/FJnC9s392VomoY2CWr47GJ1nfiGQ2zVDIRMXmHMsj98eOBot7DXNbBA+UYLHkSYR74tRIwnjFF+21hOFP2lHlk8nVo0GTmTzLuK9DovzHCYbqmnRou+1MacINoj3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=JTkHnp8s; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com [209.85.218.71])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id CA1253F20D
	for <netdev@vger.kernel.org>; Sun, 29 Sep 2024 18:21:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1727634080;
	bh=NcSFbsIXgiNSIJxntSXwkK9zAY/t+TLdWZ5xLvbV6u8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
	b=JTkHnp8s6k+gJbbZgFS4BB1kLdAjjM7ktdb/5StUZ3B7Fepl9qIC/ssnTA5BFFEst
	 QHn/NCi5ePPNTn3LJenRjuyn7j1YykP0buURCX03+ehUIdA2E9KMDXoQRcgf/Dgr6i
	 pl53t4ao+RO4FOiCLBzPfp+/q4BPII3a97MwBYrCmtvetum7WMnr320xKQC1H7v9Sc
	 VdNdA63dh9mPfMA/GkWU85BhpiKGxqK6jKI3wAEFdXh+kWg3yBvmFmaGKJ8oJJksB2
	 AktGuBlSmXEHnvJDSr3o80XnK1B7oWC6I8Rk+DpJRx3mHKrZl3eLOFmY1RlFerFlMI
	 tIlZagQO0gBeg==
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-a8a84b60255so355608566b.1
        for <netdev@vger.kernel.org>; Sun, 29 Sep 2024 11:21:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727634080; x=1728238880;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NcSFbsIXgiNSIJxntSXwkK9zAY/t+TLdWZ5xLvbV6u8=;
        b=uAELb1FEGHrUxP04i2BK0Cd8sB8B3UFuXaY7Oki/ZG+LXvfbL613lMci/OZnP9+ASi
         aYTtqEaQhqGnNFVI6g+QerO5iNAKP4BIgXJ6yyEF9eSlZ4LYy8xv/RVdX3JJCXkxFVFM
         H/fMjb4XMUVJh68a8HMypFW7P/gh2SIGGI7RuPATYNs6rfBkbb5uF/En0G76jmlliZpj
         x2qeGpS1ETJlkELw9iiHAL8KzFhgg2ELNKZTkLEL+gZ2qF0E6XBiy7MQp3HtBGdvW3TE
         Pu5o78xJnTR00tikolG4ggQiPYlqxmTRCXFr9BKLjE/hC1yPLQcxDOJCZq2ZLeNcWbkj
         Yb4g==
X-Forwarded-Encrypted: i=1; AJvYcCWWcecXERHtzsmd/xhQiR2LyhKpcjrPt9eAcxHtVjetrcQXHgxWG+7IDOJA4Vl+SjwVIuSuP54=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPmVpLMJc1bT0Ws1+EKVsbZXr28u8fpl9Tn9/Myvedpd2+QMIJ
	rcSMMEmj5apRTRzRgFoCWZtwlm4W29qoLg1s6i8i4UDt4ZMWXJkFfu0S6Xb74af8IKdhiYXtCcL
	vi5ZqCTGPoaR+a4BNOsbzwUwXqUAcgIkek2aMWcqwBKZCjCevFYYW2hFg1aPIEKEBs+JUBg==
X-Received: by 2002:a17:906:6a02:b0:a8d:2c00:949a with SMTP id a640c23a62f3a-a93c48f2108mr1109687966b.9.1727634080071;
        Sun, 29 Sep 2024 11:21:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH/dwfX8CpFC/wMaqb9ON9AqBmf3Q6FpW0kLVPD+7epq6zvyosEb7pk9U9oZmP8xLkgLxMtPw==
X-Received: by 2002:a17:906:6a02:b0:a8d:2c00:949a with SMTP id a640c23a62f3a-a93c48f2108mr1109685266b.9.1727634079417;
        Sun, 29 Sep 2024 11:21:19 -0700 (PDT)
Received: from amikhalitsyn.lan (ipbcc0714d.dynamic.kabel-deutschland.de. [188.192.113.77])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c88248af1bsm3420056a12.75.2024.09.29.11.21.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Sep 2024 11:21:18 -0700 (PDT)
From: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
To: stefanha@redhat.com
Cc: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>,
	Stefano Garzarella <sgarzare@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	kvm@vger.kernel.org,
	virtualization@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] vhost/vsock: specify module version
Date: Sun, 29 Sep 2024 20:21:03 +0200
Message-Id: <20240929182103.21882-1-aleksandr.mikhalitsyn@canonical.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add an explicit MODULE_VERSION("0.0.1") specification for the vhost_vsock module.

It is useful because it allows userspace to check if vhost_vsock is there when it is
configured as a built-in.

This is what we have *without* this change and when vhost_vsock is configured
as a module and loaded:

$ ls -la /sys/module/vhost_vsock
total 0
drwxr-xr-x   5 root root    0 Sep 29 19:00 .
drwxr-xr-x 337 root root    0 Sep 29 18:59 ..
-r--r--r--   1 root root 4096 Sep 29 20:05 coresize
drwxr-xr-x   2 root root    0 Sep 29 20:05 holders
-r--r--r--   1 root root 4096 Sep 29 20:05 initsize
-r--r--r--   1 root root 4096 Sep 29 20:05 initstate
drwxr-xr-x   2 root root    0 Sep 29 20:05 notes
-r--r--r--   1 root root 4096 Sep 29 20:05 refcnt
drwxr-xr-x   2 root root    0 Sep 29 20:05 sections
-r--r--r--   1 root root 4096 Sep 29 20:05 srcversion
-r--r--r--   1 root root 4096 Sep 29 20:05 taint
--w-------   1 root root 4096 Sep 29 19:00 uevent

When vhost_vsock is configured as a built-in there is *no* /sys/module/vhost_vsock directory at all.
And this looks like an inconsistency.

With this change, when vhost_vsock is configured as a built-in we get:
$ ls -la /sys/module/vhost_vsock/
total 0
drwxr-xr-x   2 root root    0 Sep 26 15:59 .
drwxr-xr-x 100 root root    0 Sep 26 15:59 ..
--w-------   1 root root 4096 Sep 26 15:59 uevent
-r--r--r--   1 root root 4096 Sep 26 15:59 version

Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
---
 drivers/vhost/vsock.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
index 802153e23073..287ea8e480b5 100644
--- a/drivers/vhost/vsock.c
+++ b/drivers/vhost/vsock.c
@@ -956,6 +956,7 @@ static void __exit vhost_vsock_exit(void)
 
 module_init(vhost_vsock_init);
 module_exit(vhost_vsock_exit);
+MODULE_VERSION("0.0.1");
 MODULE_LICENSE("GPL v2");
 MODULE_AUTHOR("Asias He");
 MODULE_DESCRIPTION("vhost transport for vsock ");
-- 
2.34.1


