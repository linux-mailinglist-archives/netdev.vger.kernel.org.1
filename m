Return-Path: <netdev+bounces-178656-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07DB8A780A3
	for <lists+netdev@lfdr.de>; Tue,  1 Apr 2025 18:38:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A5B9C3AF79B
	for <lists+netdev@lfdr.de>; Tue,  1 Apr 2025 16:35:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 886A720D4F4;
	Tue,  1 Apr 2025 16:35:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 144EB20E313
	for <netdev@vger.kernel.org>; Tue,  1 Apr 2025 16:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743525306; cv=none; b=b1vIuUMWHJVT6HDgoHaWCwMxo/Ri8gdotYPAZ8YwdQfqBO7w9oqeq4O+hxleVRXNh8kH1ZJCFd8hoCSeHxOuBTD9S+fAsaO6ZnAUi8SbwWBvJQvS0L1gHU6+RVlH74mJf6jMkjYdqe1WYdgy4IoMblGO4iByxpHdRbnUiscU/vI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743525306; c=relaxed/simple;
	bh=brNcDKtIpW55d45qQoDg2xLCrtCFSoB36qUcpPmbkBc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Yzr710LcjuPsIqR0ClG1p52IzWGHxfWO5iK/Dd34MUj+wYX4MxfxOpSPnizlqlOB0YQW5Jpdvg1BPgmuGM9M6er7uYxQZlOz9Hd4NK8lRij8hck1FoETgtLXrazr1TpJvYJQeQ0dW5KY0NkNz9YAVsHj+QCbooXZnUD4tnI5Hvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2254e0b4b79so149100405ad.2
        for <netdev@vger.kernel.org>; Tue, 01 Apr 2025 09:35:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743525304; x=1744130104;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hV36hiRVRFzZxgV3bV0iMgv0RNkvHa9U+49mMjCNugs=;
        b=ROIr1bSkTEXFvI9YOI3WuXa++fd7El7TVxNI0kK8wnJmXAQEJ0K6Hg19+5dmhBe1r7
         LA1K8wNYm+oMHJlOSdtbL4Huc/vB+u7/MG+Hu9d6PJepiSwjec3bFO3D0GO3BwUvdV4u
         S8SlGxL1toe0FPmZpgpF+wIYsqaowUoAeqzdZNbziZNvcm4k7IT/ixFi3dXQiOyM7xcl
         Po+nGZa9wu3vA573+ELvyuqfWAv9hKpoJHav1d+shvF3Sp1Q9U3TnnV9XLS1XRvWNAgl
         KNXk64L4rtUGBGxdLvzjtBKd7XC45B10Kwoy3ktbaVeyw8rYNdGr+AcQsMPt1UfoLxHQ
         u1Lw==
X-Gm-Message-State: AOJu0Yw3nCxc87KM9x24EApfC89qv6rw6lU3bD0qS/yl8OHix1dFbA+D
	cYrcjhPojUGPCq4v+Q+YoitMm0RPGzxi/RmxH+A771HdBVihN6kY/17NW8CN3A==
X-Gm-Gg: ASbGncv6mH8GlqkuEbRLDMYN95G6ClubcRxizLMJvlyZBQjrSZBYTqjnKzT3+rmT45M
	QDCaQkTkIkD0TZYOOl0JweVfsw5xYH2U+ponDbJxKtYX3XUh0gvA6SdRWKGqNYj9/DV4lxP6oVm
	BrW3prVLS5AT4IKqzMTnDPshi8CwS8igfd019OmwypG/VsM42py/uJpRnKHwy7aln72b58Nlyup
	oUIZasml4+y6MGW+2ILEZE3PMWikB4GiE9CMbMyxU49/OAAM32hAbzAecjme+g4zo5eoWgtl1xd
	h8Nyv41rwYjtdjsW/9QRPzplm9kV4L1d7lEKWuFDkHs0
X-Google-Smtp-Source: AGHT+IHaNwjfE4BiooRO5RnZVihY9wkl7m5eA/Z9iDsnLl7cFIPdfIwFpOCtzDMH0cs1yNd2KapSmg==
X-Received: by 2002:a05:6a00:180b:b0:736:baa0:2acd with SMTP id d2e1a72fcca58-73980487652mr23308076b3a.20.1743525303969;
        Tue, 01 Apr 2025 09:35:03 -0700 (PDT)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-73970def69dsm9391964b3a.14.2025.04.01.09.35.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Apr 2025 09:35:03 -0700 (PDT)
From: Stanislav Fomichev <sdf@fomichev.me>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Subject: [PATCH net v5 07/11] docs: net: document netdev notifier expectations
Date: Tue,  1 Apr 2025 09:34:48 -0700
Message-ID: <20250401163452.622454-8-sdf@fomichev.me>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250401163452.622454-1-sdf@fomichev.me>
References: <20250401163452.622454-1-sdf@fomichev.me>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We don't have a consistent state yet, but document where we think
we are and where we wanna be.

Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
---
 Documentation/networking/netdevices.rst | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/Documentation/networking/netdevices.rst b/Documentation/networking/netdevices.rst
index ebb868f50ac2..6c2d8945f597 100644
--- a/Documentation/networking/netdevices.rst
+++ b/Documentation/networking/netdevices.rst
@@ -343,6 +343,29 @@ there are two sets of interfaces: ``dev_xxx`` and ``netif_xxx`` (e.g.,
 acquiring the instance lock themselves, while the ``netif_xxx`` functions
 assume that the driver has already acquired the instance lock.
 
+Notifiers and netdev instance lock
+==================================
+
+For device drivers that implement shaping or queue management APIs,
+some of the notifiers (``enum netdev_cmd``) are running under the netdev
+instance lock.
+
+For devices with locked ops, currently only the following notifiers are
+running under the lock:
+* ``NETDEV_REGISTER``
+* ``NETDEV_UP``
+
+The following notifiers are running without the lock:
+* ``NETDEV_UNREGISTER``
+
+There are no clear expectations for the remaining notifiers. Notifiers not on
+the list may run with or without the instance lock, potentially even invoking
+the same notifier type with and without the lock from different code paths.
+The goal is to eventually ensure that all (or most, with a few documented
+exceptions) notifiers run under the instance lock. Please extend this
+documentation whenever you make explicit assumption about lock being held
+from a notifier.
+
 NETDEV_INTERNAL symbol namespace
 ================================
 
-- 
2.49.0


