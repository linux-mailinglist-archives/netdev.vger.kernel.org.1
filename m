Return-Path: <netdev+bounces-129993-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E174E98776A
	for <lists+netdev@lfdr.de>; Thu, 26 Sep 2024 18:17:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E14461C245C0
	for <lists+netdev@lfdr.de>; Thu, 26 Sep 2024 16:17:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9574B2B9AA;
	Thu, 26 Sep 2024 16:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="kgYzXLx7"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CDCB522A
	for <netdev@vger.kernel.org>; Thu, 26 Sep 2024 16:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727367446; cv=none; b=YxoKgwQhlXtyEeXnWyD4THRKUkmXK2DFzZjdr2iyTCL2kpbN3cuORUwGdK7csxHHEiKgQYmeIJciZ1bZF1Kmaa+oV2h60FsSwOon5OZHnr7pKU/pKjyZtgKKkymeEgbosjPdaRfSpa+VrQ2RU4sivr8SUp0i/SQju5vRPht317E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727367446; c=relaxed/simple;
	bh=7gDjgu4wElEbQxuDgDh35dLOIRlB1xp7/51JxMwantQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=YarjBFpGt0L1nRa9TJX2GEL5FLvG0Ni8BAZCX2ViLQZQyx9WxxqVNuJr4QkB1D0X5F4FBwj+sYz1bnQAQVIAFxSi3pPtpsEzvQ8RY2hou78rb/sLmryhGESyLgW0g0AI8S9TQI3S426hzbKGTm5NzLlZPDiWHix2NlIMFv49PCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=kgYzXLx7; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com [209.85.128.71])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 926D03F282
	for <netdev@vger.kernel.org>; Thu, 26 Sep 2024 16:17:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1727367440;
	bh=b1Yy5Y+O/8SNdOfIY1NdJ3kg1DxrF1aZEa29oc+RxsM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
	b=kgYzXLx7xPU3jO16+dByVml3IjOfBwbklD9+YQs0oS99RMCohU4IjZLc9Y9RPjU+b
	 0k+p1S50pp7MrNq4ca5Dr6KFTE4Z+5n+N/8j/yAfqIfoZKlo7mt16t/ECJludUKWZf
	 e7UEjq9gCsc9oTWcF7erlp0At8RBJIcCNGnnkFJcdO5Gzct4xfS7CvrRNWBVA35ql1
	 qnDkH9Sw5qzmIyuEJsshPc/cLdY/6B/Hx0eUHfzUfEajULdhRtWDo/FDsrNY+cAbxH
	 5Sum87k1Ksre12WgRikIAQFuQqm0he7rj4XeD/0mnOHhctkteES/z9SyAfO02eXcKC
	 M4jORwUS+6/iA==
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-42f310f0ed2so11063455e9.1
        for <netdev@vger.kernel.org>; Thu, 26 Sep 2024 09:17:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727367438; x=1727972238;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=b1Yy5Y+O/8SNdOfIY1NdJ3kg1DxrF1aZEa29oc+RxsM=;
        b=JxswtYQNV0av8YK3Jgp4Yo66fYaH7c9VwaNaJoYbwXSLdqGIVsrRCyITFYFC412f18
         loeLpDEbJUd/tyqaVhdL9FtTM2SP/irOFBk1XbDd1MpegxNjX31KduStL3X10/SO+PME
         2CbjIqpSc7XMgql9dldPLWRMkEzediqScqIBCSDhmaCgw7d6GnU4pEaFV/TuQ1IBya9p
         Ngl19zQvjL0PavjBaFbRmqvY9+2hhCHQ/psmqiHUfLgNM/NzqBbDFe0j/h5G4kuiPxNR
         JsC3Jl5hEWHLIFf8+WNhm1uM6CY/j2+zQBuwA55Ronn9u9uy6zuZMmK1WizDQFF5MOht
         DQZQ==
X-Forwarded-Encrypted: i=1; AJvYcCXD5qySUc4oJbEEkwc3wBboDLpxAbNO+6yZFsDa0+F2axgRUMN93X3hRmjgifvqPp4feh76UmU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRSeBlggxFFpRE2WyI87h1zShcCV96kOyi5No75BBy3XmGQLhO
	9QRG1WMmoavm1MzPPu1hSCcKEEJ6XlXgnwC8521PZGPqcOiB76vpsB++l6sEFhOwpK1FscTDRMS
	X0fnD18PbYUa/nD6qPfMDGKQHpB2tUKQ2fHngH0s0XiuCqzfByGw/awk4aRQ3NVsM7dCl2w==
X-Received: by 2002:a05:600c:1d88:b0:426:5e1c:1ac2 with SMTP id 5b1f17b1804b1-42f58433478mr169625e9.8.1727367437788;
        Thu, 26 Sep 2024 09:17:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHzaX27OdIk12RXul9FuGgRDD+iCxKpGs0uDOQekLQVHE70zEjsFFHKV6Qz72FM1jylL5Re6g==
X-Received: by 2002:a05:600c:1d88:b0:426:5e1c:1ac2 with SMTP id 5b1f17b1804b1-42f58433478mr169345e9.8.1727367437454;
        Thu, 26 Sep 2024 09:17:17 -0700 (PDT)
Received: from amikhalitsyn.lan ([188.192.113.77])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a93c2948231sm14104266b.99.2024.09.26.09.17.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Sep 2024 09:17:17 -0700 (PDT)
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
Subject: [PATCH] vhost/vsock: specify module version
Date: Thu, 26 Sep 2024 18:16:40 +0200
Message-Id: <20240926161641.189193-1-aleksandr.mikhalitsyn@canonical.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add an explicit MODULE_VERSION("0.0.1") specification
for a vhost_vsock module. It is useful because it allows
userspace to check if vhost_vsock is there when it is
configured as a built-in.

Without this change, there is no /sys/module/vhost_vsock directory.

With this change:
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


