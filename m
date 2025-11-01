Return-Path: <netdev+bounces-234829-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E34FC27B4E
	for <lists+netdev@lfdr.de>; Sat, 01 Nov 2025 10:51:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 90EB23B8CDD
	for <lists+netdev@lfdr.de>; Sat,  1 Nov 2025 09:50:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 258252D8DD3;
	Sat,  1 Nov 2025 09:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DDnb9KjM"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CB622C11C6
	for <netdev@vger.kernel.org>; Sat,  1 Nov 2025 09:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761990491; cv=none; b=S78k2Wg3Lm2JB2JnrWPsr4e4mcnjAVUcSXHnTHTEZd2kbxuo1OOfanxv7p+7Eht02ihQ7QedNQcsHnidOUnAJIBkg+ObJHwBdUkhTlag52uUC+7vWFyQMXQSw7igBDMu851PYhhdjp9b5tsndv6oWVrnAlFm8HociSopQ4hxXTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761990491; c=relaxed/simple;
	bh=scKBOtDHVqKDIQ1wnHzvccmWbCFHaFUh0A9SeEEBF5o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LGVT+ra/bg6pDZnbZFQzL38fcOmupq784zoGpkGLsmni0ewv1oxYmvbpcRpuKCeyiFw99P8tx8+VKdX6JeIH9t/b9DeR/zGeryypeYz8xeflHfhf4ikaLhgGsNVi9yJb4cHTETt/cIw5bv8VbZXLbcllyQ0NdtlWeG0vSRtwOL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DDnb9KjM; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-7a76584ea6cso2296389b3a.3
        for <netdev@vger.kernel.org>; Sat, 01 Nov 2025 02:48:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761990487; x=1762595287; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FlhKMqWLH6Ttx9Tu79F/62Lvn4ZGhBAbvbXeziFMbEs=;
        b=DDnb9KjM1YHI1mBpiMqrKD0cvFxzifXJvRB6JhZBPbGUy55vUph+n1JP8wYa5hyX1i
         3xxmcblTOENIMF1dgfkRAzShTlerm5liklOiuOCtd3DxO81OaQ8k9mCPk5h+0UsuUL+E
         uIXFDHFiaZI8UY9lcEcALcWVa417dT4ZsIOir/X9ngk0o7GFE7QPljtnWMfAXesS59g9
         ByREjh9uwu8r9Ac2156iO8dqjWyJGQmMwJknXq/L6PrXUR/dyKnLFZPE1flzGiBv8jEY
         P96FmGWUTr9Lofpq0zHLnIeOWxXtCmRVEviwWkw+Ecx5AMklf2Qv3BrXv+aoIh0I9VJe
         PJXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761990487; x=1762595287;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FlhKMqWLH6Ttx9Tu79F/62Lvn4ZGhBAbvbXeziFMbEs=;
        b=dTTqKizP0kLTfpHCgyjhAuBjvwKLmKvnSEae1lUWr5cTwpGSxLkURH1ZtPR564OrbV
         oeIKP1stxhjxKw/BRzynxQvpL3uTOnmpDPwSzCBE+KKqXYZgiuaPtw0cvBbamTM25Luv
         uX6LaMyH+Uqupwrz/ZXB1rk1pL2XYiZI2xojX/Mv/kp4gOGS5O43ZWSotjB4alYSLZKb
         USFJirCER6A68P1qJwFH0KO4HCyjlXPs5Szpq9GwXPD9Iy8+KmuyNA5oN9y1s/XDu2gS
         rw2ielLR3w6LU1hHWvYO77tBnpTMQw2H1Espz9mSLhxHKeGrf5ayyKOnBpc7oaljqx9X
         C1GA==
X-Forwarded-Encrypted: i=1; AJvYcCXiDKCZHG50wk96jQ847omtgGhjkTflAcXVERFsXmrR8vVymAi2/s2hM/4MrXf8/p+GkLNRaq8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/EJ8prp9ByxaZ585aTZv7/JJAr1DXPQgktEuNKaVZKQXFl9YZ
	fqpjZn3614vMoVRHJmE9bJH2vMszzQjN/E5zifz7VESxf9S3ORxRPUqN
X-Gm-Gg: ASbGnctfc1k/r9dOqVlVsilcWtS7rvs3lHMHvCuHozfSj4qxDqmD/Oy10kKeBPfRxFF
	szQrfiB4PV+D+6sb8H+66jxKAoa1kW3ywcx+kr+b6t6ubtoiWTLg/jMSwzd2/XLUNYzUHXEYPhm
	0jG744yW0edpoMESpEC4Ip2GLLijdTs+IP0RGa62aZDdXVFMVendPp5PLOfbuFSkGwWrzagfZ6P
	yCMQAVpXED5/W0Tbs549ytcClm8BWr5qdUa/M91t5rSK0R4utjhLp/7moR26e/Hh26P9jufYIMK
	nKwGqhFCFEC+0GPz82VKazc68Lq+q6KZlaKRVoGGA0FjCvRyiU5mr3ZRp3lkP2ZKZX2D8hMwSUu
	dII8o/U+05/+Wiu39bDkfp10psRrStBAGQ4D/ZIh98Kf/8JRVYT9XucuWsKUO5V450nLAvoNTPg
	YSZC+cxgZ9GI0=
X-Google-Smtp-Source: AGHT+IFkBjadAlRvhWq+7eM46hxZBHaQSQ5gXKI08Y3+aBwkshix92V65FN8ebBWTu8xjYudEyFEDA==
X-Received: by 2002:a05:6a20:3947:b0:2e6:b58a:ddec with SMTP id adf61e73a8af0-348cc2c2872mr9266465637.36.1761990486624;
        Sat, 01 Nov 2025 02:48:06 -0700 (PDT)
Received: from archie.me ([210.87.74.117])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b93be4f8cccsm4550093a12.30.2025.11.01.02.48.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Nov 2025 02:48:03 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id E65EB4218354; Sat, 01 Nov 2025 16:47:56 +0700 (WIB)
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
Subject: [PATCH net-next v2 7/8] net: Move XFRM documentation into its own subdirectory
Date: Sat,  1 Nov 2025 16:47:43 +0700
Message-ID: <20251101094744.46932-8-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251101094744.46932-1-bagasdotme@gmail.com>
References: <20251101094744.46932-1-bagasdotme@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3293; i=bagasdotme@gmail.com; h=from:subject; bh=scKBOtDHVqKDIQ1wnHzvccmWbCFHaFUh0A9SeEEBF5o=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDJms1/JSknh6zi5oWKbks+j+lfM/Q4/p9Xc7a02LzmNWf iSfv8Suo5SFQYyLQVZMkWVSIl/T6V1GIhfa1zrCzGFlAhnCwMUpABPpyGdkWCBUkaK565PuO8fk s4fP1BtpNEskrn5p0R7kFj3DMHKKM8P/PEZFXSeBhNwzZauOF+Wsl+rdIL/65nz1xfpLP9QYbqv iBQA=
X-Developer-Key: i=bagasdotme@gmail.com; a=openpgp; fpr=701B806FDCA5D3A58FFB8F7D7C276C64A5E44A1D
Content-Transfer-Encoding: 8bit

XFRM docs are currently reside in Documentation/networking directory,
yet these are distinctive as a group of their own. Move them into xfrm
subdirectory.

Reviewed-by: Randy Dunlap <rdunlap@infradead.org>
Tested-by: Randy Dunlap <rdunlap@infradead.org>
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
index 112f7c102ad043..dfc2ec0df380c4 100644
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


