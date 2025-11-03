Return-Path: <netdev+bounces-234919-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 43D8CC29D1F
	for <lists+netdev@lfdr.de>; Mon, 03 Nov 2025 02:51:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id BDB3C34803B
	for <lists+netdev@lfdr.de>; Mon,  3 Nov 2025 01:51:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D5FC285074;
	Mon,  3 Nov 2025 01:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JnDUNd6B"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6094A281357
	for <netdev@vger.kernel.org>; Mon,  3 Nov 2025 01:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762134670; cv=none; b=o2V6/hRegox1u1XMxPZJZ3kpVbgRuBFX+EIBiKlLiZV+V/KqoWDUrhWV1iOr/6K5p34BDKnmjWpWaXxVYEcxIYiahrM5PUpJUpJpyCQME0WqmBgHHFIhVgFoyO2ECTuTsQE8mcXZfa7iRuPq9R71lpkRWevpJF1yWWqXMNla3Wg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762134670; c=relaxed/simple;
	bh=scKBOtDHVqKDIQ1wnHzvccmWbCFHaFUh0A9SeEEBF5o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uHpHQuDwkQ8FDRgOJfiJFkJF1sl9o9dP0HPCPF0d0CQDET67SkQGV1Gvw7/sxH5juthhYt/qJ9cR7M0xhaXWcdg+BMFjbcWQhREA9d/rn2kyN4u1fsTPiye7+cWyQnP/ckHmh343qcu0pC5u/gnl/sZcjbteM0ncQT1vm98Aq0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JnDUNd6B; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-339d7c4039aso3816571a91.0
        for <netdev@vger.kernel.org>; Sun, 02 Nov 2025 17:51:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762134668; x=1762739468; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FlhKMqWLH6Ttx9Tu79F/62Lvn4ZGhBAbvbXeziFMbEs=;
        b=JnDUNd6BbiaUDEi1M+EQeMLIU8SIzUV2IGLnWyvX4cQ/2kNpz8ZoDhQRl2HS12GhAc
         AY4k925TlMNzCW5qnKHG/sbxl/hyXSUd4IPFwAqW1dveq3AenA5gjhRyiJElYyuqbdxJ
         bj0Wj/OUIGVSmjaRIYhPVUNDanRAEq6d5xWkJioSGnMxs+HyGkKtsRdr+AeZoLf0FOG/
         NNuaW9q8fH5EeqUEx6AfPaDg2s1jad/alo5UAL8R42pHaVShrZvnJMeS7eaXyMzOoXxO
         GKc4jrE1SVEvxSxdGM6AIO13WE7v6QHMjT/2kHo//pF67w3SKUi0mENtf8IcTAlHkVLK
         vaBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762134668; x=1762739468;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FlhKMqWLH6Ttx9Tu79F/62Lvn4ZGhBAbvbXeziFMbEs=;
        b=sXNd3XDOFn/GwIlKkD2CSqgXDlWhO1a9ThylOAHDE7qsPTKIB+nd/bkKGXl5LY/ZMg
         r4gGlg4cC5TI2z1dOJxp0Wa+flPRThX1Rd/FYX78tI/pWVAecVTw9oyjObDiK1A5Ebl3
         arOkvD5m93JMEBFq16FX2v8myPdXZvpMsf15iNmL0AQcQAqdLIuaiG6IMtvHiTVDdrBR
         7QQxbTwwa53I9P/Ju5dCL0IBWwiZiyDfLMoiUM3GI5rlBHIAJt0+sCmYlY/pTo1EGUNl
         nc0TCAzJdeZikw1NmqhNPbZtWmOG+VUqmKgqDA6QzCbbcABf7IbCi8x0V8DWnpseKgNL
         OZ6Q==
X-Forwarded-Encrypted: i=1; AJvYcCVQEmeJZAhQXRGPy/KdSl1xmoucz2OWAIKKVviY2VJHvWWFgBWt7C0tuEzwD6rJeGw2WSFhzvs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7YJmGYeYZx1zVv4KFN5ZSvLz3DgePsR5WbpEY2FliNjqbqMXU
	+qz/SG6n1jU9cPDFxJS2WIwKZt6CYXUGPTHqIs41pxQ1fG32vARY6V+U
X-Gm-Gg: ASbGncuK80jBF+etQ/UMVkRijbohkScZUV/LK/ojZ4W1bXkWYmQ/gAuWXpBhs+go5Em
	REYkNL7If8WlLfsEPsslYZvnODh+tCkzed1CpNzkiclKA6Z2/2guEFa7f+8L3YXR380YWTm5mrw
	aTdBZoyvh3dP9SX522R4FpN9MxQkugqRJFbltGTlzYiNjtgQbDa2jrTwXWNoimNQ8V2GAI31p/J
	FjdLIuJXnTZBVNPluuAtDTSyTxTZFvpKAFssvG/MW17cA70+FjTnsbNHOqMZTq66XkIg/IqYpAx
	xkqk3EdbWMdXZfkCwovalbX3c0yqe5BOw5IVlNwMAfjCzzNPV1Pu9m+J0xfqFvbsFwYRWTGy6h1
	CI5OtJxZv9MMiQSGyeww1vnMi9mTWP9PA8ileeacisQFU+7U8uGUsTPqohBIWLuwXKJiZKsDAFK
	MvFALglJHmj9w=
X-Google-Smtp-Source: AGHT+IFg8qhnYS+/VCHi4aItW8Iz1eBgf+OnDK39pb/AwlReuqEHtNS0V/i19WjXGq79bAGE7CzXNw==
X-Received: by 2002:a17:90b:350c:b0:340:d578:f298 with SMTP id 98e67ed59e1d1-340d578f568mr5305116a91.8.1762134667617;
        Sun, 02 Nov 2025 17:51:07 -0800 (PST)
Received: from archie.me ([210.87.74.117])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7ab3e48d1dasm1238109b3a.34.2025.11.02.17.51.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Nov 2025 17:51:05 -0800 (PST)
Received: by archie.me (Postfix, from userid 1000)
	id 5E4BF426D9DF; Mon, 03 Nov 2025 08:50:59 +0700 (WIB)
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
Subject: [PATCH net-next v3 8/9] net: Move XFRM documentation into its own subdirectory
Date: Mon,  3 Nov 2025 08:50:29 +0700
Message-ID: <20251103015029.17018-10-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20251103015029.17018-2-bagasdotme@gmail.com>
References: <20251103015029.17018-2-bagasdotme@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3293; i=bagasdotme@gmail.com; h=from:subject; bh=scKBOtDHVqKDIQ1wnHzvccmWbCFHaFUh0A9SeEEBF5o=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDJkcnJUpSTw9Zxc0LFPyWXT/yvmfocf0+rudtaZF5zErP 5LPX2LXUcrCIMbFICumyDIpka/p9C4jkQvtax1h5rAygQxh4OIUgImETmb4Z/I0wbAmo0mv+zr/ JA3Dz69+tGo7ejjIuhzubHow9Z6CJyPD3887QlSuJphqrReQklSXeLF9RUjOz2TbFO4PizmnZzx jBgA=
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


