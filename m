Return-Path: <netdev+bounces-250658-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CC4BD38880
	for <lists+netdev@lfdr.de>; Fri, 16 Jan 2026 22:39:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3C47630A10E1
	for <lists+netdev@lfdr.de>; Fri, 16 Jan 2026 21:29:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83A55314A84;
	Fri, 16 Jan 2026 21:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N6ZuMxt9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A68D43FFD
	for <netdev@vger.kernel.org>; Fri, 16 Jan 2026 21:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768598952; cv=none; b=i/jVVw3gCXoTavUMMfunzDneb8Ipd9aScKubk6umU6sO2Bh19JIDJNw8HuylJyMR2zia45zeMmv/Y7XIL4Jk8BUxN3JKhSimVR1/IIY36CZoJw2qTgDoWVShBOulRvXljhBUjO3KrRACAeN49d9VayazjWVam6KF/2eZhhWI2sw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768598952; c=relaxed/simple;
	bh=QFGTndIZnCvd5tocHyARHg0OdzlZifxdeujSy28wwJs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cpAAOszMIfT6KmbC1rSOuJQtWWGYpt0MPh91zxJXbWQ4TdUSkEhMYWMIlFXhIAcW4BRC2Mpgev/hEdFubkl3GeLP/Pg+3zIqKOsuKJRi7GB+Q957gRnRr2FOxkFgfzecHIoAJdBWXst4xf5tn5B+4LrhYocIYTf4CuthvhwSY/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N6ZuMxt9; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-78fb5764382so26919577b3.0
        for <netdev@vger.kernel.org>; Fri, 16 Jan 2026 13:29:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768598946; x=1769203746; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mqm0dBa6mjJHml1X9kPKSm15M0oyticD3F9JJwXOMvg=;
        b=N6ZuMxt97tRHsctEEofq6oCk4HrU+Bc4QwXdsJmotoTXAOmHwj31WOS8aazpc/8MmR
         ie6rVcjI4jO5c2YBazRZC6Jysgi1HYSF+nKRUQ+ANXgmo3xmlJgIsIx3xI7ssB9UTNGG
         An9nQhkeL9c7ftpUxYfA7cyz4PG8msfg75fyWelol/Iir3k/WYNZHKz2VWbyBrUPlOWI
         G0EBl9XgKRIDxsTIMA83B6PcMvJNvpKBlIWZJ32KYNtmZRkSb4XpB/3gBj4WP2QpxMh8
         R2z9Qgi3gU+Ns+2ZE2+9DxM6wvJfOtdSjDLIGM55lfKLwxqlN97GHOSRt+QSzNSNYxDK
         C+Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768598946; x=1769203746;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=mqm0dBa6mjJHml1X9kPKSm15M0oyticD3F9JJwXOMvg=;
        b=EVSct/FBPGR/BQcOm8nzdyYSlhyH9GdAO+38cduKBymVXdNPts6Gc5jNqHmeMq5Emj
         mP3vEsr8ZV7MesbRii93MkvOSqTp9esAtTLBesEBJgTS7McNXmytxuQsgmbPL4h08cVJ
         j7je46iHM6RgY4Qo/anBc5fZeYk0Tn7M9X0YYuoLo36ZasrMi8HUYr8shQaSoZQTQnTV
         Ujx9c3a+mvRsZAnAuGdhUme17/t6qpeXTMEWkBRlc+0uhp6NhDOJ37keyLepyjaOYCeI
         dnvadI3cDFZl4oB1DRGbBmt/WjKf8AVlV/rRhN+8+I2UfeIr2M4Y1vR+XBMpPxgTq0+0
         s9kw==
X-Forwarded-Encrypted: i=1; AJvYcCWh4xmVnS0bxej4gdgktkTPvejajNh4fs78iq41CkMzuCubgeJ3J5FEwoSW75z18E8ZLdshVJ8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxbkYAbmRrRC3N1bNWow29LObEzfLUy4BWw2gEkHEB5vzvEtzX5
	RLrs8FWBG0IjG9rH1vA6Opx2AXe8DmaI7f+LoOhMNgC77lkq99DRz9cv
X-Gm-Gg: AY/fxX5f30SPuSXxFj9Z/JJwbJaW7WSCJWVohSRfvPEvN/pYClE5zEtj9nnfhXYI2Ql
	MKyOPSZyrP0xRgG3CWPffk1AiB1j5eu4jWXhIqJ2wrhVRPH6xjky5WTxJU+l3dLYexzm9b7JcCA
	HvX3uuTxu0aeONfGNM+Zk6h4nv9rzsJ+A8fZrtY9CkRJ3p/GtbT/gtt9r3lmiDBIPur7VW+lAmd
	g20CJRRlW6iTI1YIzAWdu6paoqc1Km7ckHk/gDVAzdvjaVWqXZ9oTxFwhFPr+EeY1xBbpbIWnRw
	2/SLHTjIH3zAPLwrL8iwbcB8uG6jfJ5cOWSocGPur2Kd45MWW3r03VuFNMSmp21uQb3FHVD/w32
	ouCNnPXDJvT/dzzlIPnfse7Bmppgnfz66jdtEgYync03bYoaIrFnNymDfMSgdqrJzU4mMB9KgQ6
	iWMxQJ7yJN
X-Received: by 2002:a05:690c:e3ea:b0:793:ad61:b5d3 with SMTP id 00721157ae682-793c52e44e4mr31233967b3.31.1768598946238;
        Fri, 16 Jan 2026 13:29:06 -0800 (PST)
Received: from localhost ([2a03:2880:25ff:a::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-793c6882ea7sm13097717b3.44.2026.01.16.13.29.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jan 2026 13:29:05 -0800 (PST)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Fri, 16 Jan 2026 13:28:44 -0800
Subject: [PATCH net-next v15 04/12] selftests/vsock: increase timeout to
 1200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260116-vsock-vmtest-v15-4-bbfd1a668548@meta.com>
References: <20260116-vsock-vmtest-v15-0-bbfd1a668548@meta.com>
In-Reply-To: <20260116-vsock-vmtest-v15-0-bbfd1a668548@meta.com>
To: Stefano Garzarella <sgarzare@redhat.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Stefan Hajnoczi <stefanha@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
 =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
 "K. Y. Srinivasan" <kys@microsoft.com>, 
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
 Dexuan Cui <decui@microsoft.com>, Bryan Tan <bryan-bt.tan@broadcom.com>, 
 Vishnu Dasa <vishnu.dasa@broadcom.com>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 Shuah Khan <shuah@kernel.org>, Long Li <longli@microsoft.com>, 
 Jonathan Corbet <corbet@lwn.net>
Cc: linux-kernel@vger.kernel.org, virtualization@lists.linux.dev, 
 netdev@vger.kernel.org, kvm@vger.kernel.org, linux-hyperv@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, berrange@redhat.com, 
 Sargun Dhillon <sargun@sargun.me>, linux-doc@vger.kernel.org, 
 Bobby Eshleman <bobbyeshleman@gmail.com>, 
 Bobby Eshleman <bobbyeshleman@meta.com>
X-Mailer: b4 0.14.3

From: Bobby Eshleman <bobbyeshleman@meta.com>

Increase the timeout from 300s to 1200s. On a modern bare metal server
my last run showed the new set of tests taking ~400s. Multiply by an
(arbitrary) factor of three to account for slower/nested runners.

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
 tools/testing/selftests/vsock/settings | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/vsock/settings b/tools/testing/selftests/vsock/settings
index 694d70710ff0..79b65bdf05db 100644
--- a/tools/testing/selftests/vsock/settings
+++ b/tools/testing/selftests/vsock/settings
@@ -1 +1 @@
-timeout=300
+timeout=1200

-- 
2.47.3


