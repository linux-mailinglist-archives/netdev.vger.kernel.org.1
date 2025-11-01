Return-Path: <netdev+bounces-234824-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 79437C27B2D
	for <lists+netdev@lfdr.de>; Sat, 01 Nov 2025 10:49:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A40E3BD1D8
	for <lists+netdev@lfdr.de>; Sat,  1 Nov 2025 09:48:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 793D12D23B1;
	Sat,  1 Nov 2025 09:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lU2izvzU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0FA02C375E
	for <netdev@vger.kernel.org>; Sat,  1 Nov 2025 09:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761990485; cv=none; b=fWSmlxvStorjNXnU+eyP4A7T9as4kuAJcQCe9VB0agEfLWtYH1BpPZao0IhpND1hVt6F16imgdBhtqZ6XH2QLrtyiY1MhufsPH3lLO2NLEULA+HttX+m27VrygF097K2nCAr91fYygAZ7MrlnAzC/GP0pgkJQUflEYgU7sW5+wA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761990485; c=relaxed/simple;
	bh=0r/UGJ3UaHLl4TwoicvZX0eMMWSJJZ+kcuaobIcvNx8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YnQ2eyFmNLb1/bulcrK+kSOcx0swAepWtmuKX4c0zlIh/VCKZfLh92fqh2W6aLnsEvvvkZBacVJzDyDyj3jp+KhzYHkpvXxOAGnS7xb2LIKqKcn143AfDJR9JQoOciTrsULKqH+e1qWi360dnPoz2jmNvxXmoB/66yNN1K7+wRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lU2izvzU; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-340299fe579so3277645a91.2
        for <netdev@vger.kernel.org>; Sat, 01 Nov 2025 02:48:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761990483; x=1762595283; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1KN/frS9jg4jcQJc1DwfaOMBwxNMdwpEGRN00rohe3M=;
        b=lU2izvzUaCbol2zZGwLYF/TRdhnjXAZbWWTsInBfdVoWcaRE0aI3FprLoCSgj6E26f
         b3zV2UmSOoFeh11m54G2diji5oUmxUSqN02cszQiowxgSKE1UXW0QBX9SMidVlynYvz8
         98rK+arP9GF3ehUYW6bStoDX8ziNkaNIljQ0+Xm+4za98rrtzN3lW3Ftc6hEU96wSEmw
         m4X6QGCwRwm5wJ8N6h3trA14E140l5S9bxqAKR22bRBPYV65cXMB897dv1MA8Lqve7kO
         I9qTe18o1X/kGRKvynnHlMPV7sz+w1xhVOyD8+q1n5idwMF/WG0T1ypTlWdCgGkxugvh
         a2xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761990483; x=1762595283;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1KN/frS9jg4jcQJc1DwfaOMBwxNMdwpEGRN00rohe3M=;
        b=ciqqd+XGtds4/iXMsANEIeDHwHjsFUi9GOrmV+Yy8idVRUVSaIUDcUmcU/gm5KNr94
         CjIkjQa8fYUzKmIUkTq7ZBnbHH9j6OBdDSIUT1GVWX5D9NfxXPp4Ffr8YTIBwfHvjgk7
         w9emSmCRpR5zfshD7ufscTF5+Ibvc0+dHLTmne0bNLKFYqwv6iTWpYslrR1KF0pNptII
         XV8NLFWFAN6Mfxs0bGM03Q/iOR7wsM6BXR0i/y142nGRcI7M1acEuUI33jio1VL1uyCP
         fIH8owGEwM1pFFh74mJ+qDNuWWGohXfPFHRs5maAq1tm1+V3HCqkB9HDpIhQRp654416
         C7DA==
X-Forwarded-Encrypted: i=1; AJvYcCXf8OiQ53Kwy11IsMFgA9JgI6+rw+HNOSV+EZRfL/jvL4JjD9F7V1glYfbhd0T7nSRBsCT/lQU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTQI2WhlF46ApAPYuUBRTyE1X7otSV/qqeRx7Qf5zGS95WKhSw
	3Xxm3uHa82Vqt9FzfwCRQZ5L/0WiplvzCiik9UfbkdPYK/zEBxRxYrnz
X-Gm-Gg: ASbGncsprWcLwPA4suUMWgKJfhBdYVQX0A9eVQr6zJQpPOEuf5yqGY7F6yJaYwF4K93
	7o/6loLrjH5uMDh4u0Ak6R8oObh//AsbiYOxOIdVqiJGOXnLUc/8Q2NYcOrq0y8hQSjUqAmL8kB
	vVVjDP4Te6IT27LRiVocXRJvNUAaf2M4wvkPMgfB+NJIGIHb4nYtWJmO3x1GI+px4+ymidVWJlw
	BwjVn6NNkME4NPa5F9wn8OMO0QOQ/FJZ7utbBmefdpuahNPaeOLHXEcfucXzZenql+5cQCKfCVi
	HVnxJFYedBAs0qikiqVyMhHZR6CyhuKhBQKhXVSAk8VplKRWA8n2EBob+bDHwGysWJS/Qx0IFpt
	eYAeVBeP7YUF9JoNlCrlfepHnXamYsdlEh0vv0fYRF685Sbt/UjekwNdgqll/JfMQ/Zn+LmiULi
	XagdOHvB2QlQo=
X-Google-Smtp-Source: AGHT+IGsYXtd1T7KUQJwUmXpPfa8NKulKKA88l/h+qYrG9Wj+FnsHwCW+OhVIOHiRESe6quJKXaOlg==
X-Received: by 2002:a17:90b:3f4b:b0:327:9e88:7714 with SMTP id 98e67ed59e1d1-3408309dafdmr9468011a91.37.1761990483094;
        Sat, 01 Nov 2025 02:48:03 -0700 (PDT)
Received: from archie.me ([210.87.74.117])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34092d69b89sm4609672a91.20.2025.11.01.02.47.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Nov 2025 02:48:00 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id 9BBA041FA3A2; Sat, 01 Nov 2025 16:47:56 +0700 (WIB)
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
	Bagas Sanjaya <bagasdotme@gmail.com>,
	Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH net-next v2 3/8] Documentation: xfrm_device: Separate hardware offload sublists
Date: Sat,  1 Nov 2025 16:47:39 +0700
Message-ID: <20251101094744.46932-4-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251101094744.46932-1-bagasdotme@gmail.com>
References: <20251101094744.46932-1-bagasdotme@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1292; i=bagasdotme@gmail.com; h=from:subject; bh=0r/UGJ3UaHLl4TwoicvZX0eMMWSJJZ+kcuaobIcvNx8=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDJms13L/N23ty73Xvau/VKZ5goLNL6vkoKQL65l3/NLJ3 bXRkvVvRykLgxgXg6yYIsukRL6m07uMRC60r3WEmcPKBDKEgYtTACYSdZSRYcOHbU2fPJ7Jxb5o eSQb6JvpJK7hv5LR9lP/7XcGTkaq5owM+21jc5bXSz4//43dq53LPiuMTXjxwQXurTExz74HTZ3 KBAA=
X-Developer-Key: i=bagasdotme@gmail.com; a=openpgp; fpr=701B806FDCA5D3A58FFB8F7D7C276C64A5E44A1D
Content-Transfer-Encoding: 8bit

Sublists of hardware offload type lists are rendered in combined
paragraph due to lack of separator from their parent list. Add it.

Reviewed-by: Randy Dunlap <rdunlap@infradead.org>
Tested-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 Documentation/networking/xfrm_device.rst | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/Documentation/networking/xfrm_device.rst b/Documentation/networking/xfrm_device.rst
index 86db3f42552dd0..b0d85a5f57d1d5 100644
--- a/Documentation/networking/xfrm_device.rst
+++ b/Documentation/networking/xfrm_device.rst
@@ -20,11 +20,15 @@ can radically increase throughput and decrease CPU utilization.  The XFRM
 Device interface allows NIC drivers to offer to the stack access to the
 hardware offload.
 
-Right now, there are two types of hardware offload that kernel supports.
+Right now, there are two types of hardware offload that kernel supports:
+
  * IPsec crypto offload:
+
    * NIC performs encrypt/decrypt
    * Kernel does everything else
+
  * IPsec packet offload:
+
    * NIC performs encrypt/decrypt
    * NIC does encapsulation
    * Kernel and NIC have SA and policy in-sync
-- 
An old man doll... just what I always wanted! - Clara


