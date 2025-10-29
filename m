Return-Path: <netdev+bounces-233852-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 68304C1933A
	for <lists+netdev@lfdr.de>; Wed, 29 Oct 2025 09:52:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE860560E6A
	for <lists+netdev@lfdr.de>; Wed, 29 Oct 2025 08:33:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C8CF3328E2;
	Wed, 29 Oct 2025 08:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y00a+Lut"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04F1F322A3F
	for <netdev@vger.kernel.org>; Wed, 29 Oct 2025 08:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761726401; cv=none; b=fh5J+f2amVsh6PZvHtL/gxa+kPculH/bqfziVd2a8ITUHTYL+H8FpVPH+Y7cARZWuaZb3d7gWg5px34AD9hjW5wSNn4AaXFa6kgHWeMt9q841YynXpYhT0ZhCy3umM46+CaEoJccrzHymD5vfE5w/f2GtmFiu6Shh/dAF1OlU7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761726401; c=relaxed/simple;
	bh=msTipho8IapyKvYc4ZCZhrcjYAYQP0E8B7eT922sMuE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=taMx1XjkDjA23M4CN5etf8q8t4DQ/g59jTEQgOUTuFyFyBUb+e662yCkLw7rNVNq9MnuVmbV5J6g1wp/a9YbPIIsVJJuCfp63kxUh21mUnlzYLW/XPVN+fUvfFaRTmom+qGuFZu07w3jtUADl1YRYkS50r9F6BUQjwv6eIAoomI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y00a+Lut; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-339d7c403b6so6764582a91.2
        for <netdev@vger.kernel.org>; Wed, 29 Oct 2025 01:26:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761726399; x=1762331199; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=724md1U4WT0JWoYomELwngfgSd1J1DSSQs97O/mGLwo=;
        b=Y00a+LutSyVoPWdp1R/Vv3gkpFFVz34UsLKQDSbqfc3/KxkgKsdYssnsvHEtIFU0oC
         eNQ8aQhcAQ5lHY8Kndc+lgwq9XNhXR8uJ3ZSsW2NOd/x0vVFL/GOkKqTWt4E7Esal44c
         549rsSaLt7AsNObkwzchOZxCex47nV99MqvfyJNHRUwiPG/+23tiFpTrDVlqxhuJ+zIz
         Wnn7Vtkbsp+Jj9ZwYZXrs4Bw/6EBXebSN7hNKwFgJb0X9fUdwjUbH1kdKOl29QQEy8PV
         gyTYQA3AgfCO62IS1u9OH+kYIz+4LvI+a77csgQX8wI+YDzx7yoqcLBuK/pE9sfqv49V
         lnfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761726399; x=1762331199;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=724md1U4WT0JWoYomELwngfgSd1J1DSSQs97O/mGLwo=;
        b=h7N83DYeGGEOY6NP4476LkZa+jELG1El8wArPwJfLu/g8zBd4J5+aY+bL8MjiGr74o
         V+JNY7LQSzc4jIF8qjbDDyFnotPBM4YPfvvwGHQ4D4aG7nLu0JVGSKviJlgnoOjZDUMb
         69xD65IIrvgR+xVkk5uMqVCaDpJagOfgYBwymIqv5iCIMmp9ledcOUEWu16tZx8Bzvd8
         Bo7J/4OYU39B5FbilFr52tVJicF6eWWVebcgZenxQrViz30S71rrqWNmfjiE6dzLRJXr
         L09bnedPlVQxUs77Ic4tyOGDz/g1M1JIk7j9VQnL6uWF8lR5rAxcMr1IpWFKNMmya4/2
         QpuQ==
X-Forwarded-Encrypted: i=1; AJvYcCXBrI2us4rXICbU4AR2HmZxhw+O6TbNqwoBg4whqygICr8Tl94aPMM8K43IIEk5F0g4iXa4bz4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXd1RfPmMqUTEu5zBKyN0yZVzqROToiRkXVw18IC2i9Ot1wGJq
	m9XSbjsNuK3Qy1c1gz4VDwY9wDCoqkF+pNIS9n/BtlFO6UXxi7DHMrKe
X-Gm-Gg: ASbGncsp+nF/5NbKUL+BBycN5Ty2cEoecnu+TccmFtxU/QpuehJ9W4h+Gpr+xWQ7ABT
	Pe3AXOipiDhy6rjxTZ6efzeD8gl/3HyTgDWqFmmKQbGK5nMWdmPPaZoXpAWUunm0D0VbEHucpEm
	73Z1D2KV1QvYbdkyG9I15cMvkXbbgE0utso0gDSTn3IC2sV7+IEO+I9+IM9OCeoQ2sLbAPriQCM
	A9GKtXPvIJBGviR96lPUqtjmL3kxIdrTKlTDbnUcepWqsVpuA0H1FsYFNfL+bt2kEaprm+Z+5yi
	ubGSzurUCBsaoVTbKddFy2Goif0H/qjzKSF/6r3rlPPzX0cOa3E/Yk4wyNB9bd7uzw9hYINKGpX
	/PG57TfDxS0t5D8SiLF2mk14REf/ssaLKyb9pmHPttvT4xistlZzvJAtonQG0zXF0GOgy1RhnBs
	uW7oLkpx3+k80=
X-Google-Smtp-Source: AGHT+IGvp+cwrgt8OMCZqzHHFM6ZOoUpiPkKrvXKUyf4rpA+sgc4jr/n7s7EXCqnyDL4anB2BFkZSg==
X-Received: by 2002:a17:90b:5843:b0:32b:bac7:5a41 with SMTP id 98e67ed59e1d1-3403a2a60aamr2565260a91.37.1761726399021;
        Wed, 29 Oct 2025 01:26:39 -0700 (PDT)
Received: from archie.me ([210.87.74.117])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33fed73a7b7sm14544045a91.5.2025.10.29.01.26.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 01:26:38 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id AEF1D41FA3A7; Wed, 29 Oct 2025 15:26:19 +0700 (WIB)
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Documentation <linux-doc@vger.kernel.org>,
	Linux Networking <netdev@vger.kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Bagas Sanjaya <bagasdotme@gmail.com>
Subject: [PATCH net-next 5/6] net: Move XFRM documentation into its own subdirectory
Date: Wed, 29 Oct 2025 15:26:13 +0700
Message-ID: <20251029082615.39518-6-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251029082615.39518-1-bagasdotme@gmail.com>
References: <20251029082615.39518-1-bagasdotme@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3193; i=bagasdotme@gmail.com; h=from:subject; bh=msTipho8IapyKvYc4ZCZhrcjYAYQP0E8B7eT922sMuE=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDJmM5zVcJOp3MnLNbqt5UhuSKa6ufSh7pnr5yoW/2Paw3 dzX4jqxo5SFQYyLQVZMkWVSIl/T6V1GIhfa1zrCzGFlAhnCwMUpABORmsnIsEBLZ1X6i/93pIr7 1kxfPSP0Q+Kq2v2nX8nJes+vrs/4PZuRoSNrS7nuq8pV+jttQwWrBFdqPlw2Yb7+4lcZnvkRuwo OMQEA
X-Developer-Key: i=bagasdotme@gmail.com; a=openpgp; fpr=701B806FDCA5D3A58FFB8F7D7C276C64A5E44A1D
Content-Transfer-Encoding: 8bit

XFRM docs are currently reside in Documentation/networking directory,
yet these are distinctive as a group of their own. Move them into xfrm
subdirectory.

Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 Documentation/networking/index.rst                  |  5 +----
 Documentation/networking/xfrm/index.rst             | 13 +++++++++++++
 Documentation/networking/{ => xfrm}/xfrm_device.rst |  0
 Documentation/networking/{ => xfrm}/xfrm_proc.rst   |  0
 Documentation/networking/{ => xfrm}/xfrm_sync.rst   |  6 +++---
 Documentation/networking/{ => xfrm}/xfrm_sysctl.rst |  0
 6 files changed, 17 insertions(+), 7 deletions(-)
 create mode 100644 Documentation/networking/xfrm/index.rst
 rename Documentation/networking/{ => xfrm}/xfrm_device.rst (100%)
 rename Documentation/networking/{ => xfrm}/xfrm_proc.rst (100%)
 rename Documentation/networking/{ => xfrm}/xfrm_sync.rst (99%)
 rename Documentation/networking/{ => xfrm}/xfrm_sysctl.rst (100%)

diff --git a/Documentation/networking/index.rst b/Documentation/networking/index.rst
index c775cababc8c17..75db2251649b85 100644
--- a/Documentation/networking/index.rst
+++ b/Documentation/networking/index.rst
@@ -131,10 +131,7 @@ Contents:
    vxlan
    x25
    x25-iface
-   xfrm_device
-   xfrm_proc
-   xfrm_sync
-   xfrm_sysctl
+   xfrm/index
    xdp-rx-metadata
    xsk-tx-metadata
 
diff --git a/Documentation/networking/xfrm/index.rst b/Documentation/networking/xfrm/index.rst
new file mode 100644
index 00000000000000..7d866da836fe76
--- /dev/null
+++ b/Documentation/networking/xfrm/index.rst
@@ -0,0 +1,13 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+==============
+XFRM Framework
+==============
+
+.. toctree::
+   :maxdepth: 2
+
+   xfrm_device
+   xfrm_proc
+   xfrm_sync
+   xfrm_sysctl
diff --git a/Documentation/networking/xfrm_device.rst b/Documentation/networking/xfrm/xfrm_device.rst
similarity index 100%
rename from Documentation/networking/xfrm_device.rst
rename to Documentation/networking/xfrm/xfrm_device.rst
diff --git a/Documentation/networking/xfrm_proc.rst b/Documentation/networking/xfrm/xfrm_proc.rst
similarity index 100%
rename from Documentation/networking/xfrm_proc.rst
rename to Documentation/networking/xfrm/xfrm_proc.rst
diff --git a/Documentation/networking/xfrm_sync.rst b/Documentation/networking/xfrm/xfrm_sync.rst
similarity index 99%
rename from Documentation/networking/xfrm_sync.rst
rename to Documentation/networking/xfrm/xfrm_sync.rst
index c811c3edfa571a..41a336e0e7345d 100644
--- a/Documentation/networking/xfrm_sync.rst
+++ b/Documentation/networking/xfrm/xfrm_sync.rst
@@ -1,8 +1,8 @@
 .. SPDX-License-Identifier: GPL-2.0
 
-====
-XFRM
-====
+=========
+XFRM sync
+=========
 
 The sync patches work is based on initial patches from
 Krisztian <hidden@balabit.hu> and others and additional patches
diff --git a/Documentation/networking/xfrm_sysctl.rst b/Documentation/networking/xfrm/xfrm_sysctl.rst
similarity index 100%
rename from Documentation/networking/xfrm_sysctl.rst
rename to Documentation/networking/xfrm/xfrm_sysctl.rst
-- 
An old man doll... just what I always wanted! - Clara


