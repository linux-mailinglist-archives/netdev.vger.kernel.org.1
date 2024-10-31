Return-Path: <netdev+bounces-140659-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C71E9B775E
	for <lists+netdev@lfdr.de>; Thu, 31 Oct 2024 10:25:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D6CEAB223FB
	for <lists+netdev@lfdr.de>; Thu, 31 Oct 2024 09:25:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67580194C62;
	Thu, 31 Oct 2024 09:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="HNflYsID"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 903B016C6A7
	for <netdev@vger.kernel.org>; Thu, 31 Oct 2024 09:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730366717; cv=none; b=YFjlPiNjbJe0HNHsZqzj4V75uqR9LEEsU83ixW02ye1n5NK/kvVxMz0xaXfWXU+ROEyEKAUXJlW2qKJ1M5YMDhl0dvJMGIZ/B/Bn2PFZ1UJGKNKkpEtsAlNNqQbe+CfKg8ao50fNvzogPNd+2FTVL1Dbfsj42FOk9XX3u3mZz7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730366717; c=relaxed/simple;
	bh=+WsK1BD9gfEWK5iiHmaaVVdXGiXXmYvBJ8iHjcxRNPE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n02Nl7uEAEsQF/Lww6gVxLk0RZBjfIXFoDBmAarcp11YdbqtXefEXq9FKOyz6/MSrcNmOzMyLzYesOowGSFGxHxU0yOXcK/3sgSQv75+T+mZow06nXsQrBZhU4hV186tCnaiQAoEZyONUwVOrVySJJTiNRDz/gnJ8wQK5Ba7fz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=HNflYsID; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2e2bd0e2c4fso604565a91.3
        for <netdev@vger.kernel.org>; Thu, 31 Oct 2024 02:25:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1730366715; x=1730971515; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+Md4KxZLJD/EAg3l1Le9U3anL5Qatlf8vkF1zjg9BSU=;
        b=HNflYsID4YS4AEeuG46AU797+ytT7EBukKuy7KxRJuZ+5lzG0PlbpJZEkD3qNdNJHS
         Sb6kjliFeKiFkm2sXLVed+eZHbsHTkKvJjmm6ivk/6AMo7MdjdX5rcGV/Ibv8jflr2vj
         KQMyCRZWw2o6LxnLri56/VmZDxFlwHVxNQD0g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730366715; x=1730971515;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+Md4KxZLJD/EAg3l1Le9U3anL5Qatlf8vkF1zjg9BSU=;
        b=LgV0H0jp/iHAKx9WkD3WPVKd8ApL6wGex/h+OXQXibSHurgaWdSZ08cXEI9LWJNG2j
         cq0JxHOVDywA19cJw4D6SiKgcQ3+XE7m7LYFp2JUxMKd+rYAQgWmgb81xsmbyzWthV1g
         yAIkzv3oADGcCnqYmcQNPgGbCWOgLIPecK9sXHfd4mvQN7PdWAqduAr8QLBI4K65bZpJ
         s1ftZFbQK2Bq1vbmVX7GGEMBim/Tfx4v6JIkiXHYhBq78hjkzVjtJS76R+I9zkFPuVPY
         tmNn0z7xIUDpjVNJPZFbR5HRs0mGV6hYeVwdG4lBSydHZI3YenoQG+NYGDysSuQ+y0Qq
         4NQg==
X-Forwarded-Encrypted: i=1; AJvYcCXa/6MJNsWvagm635LOHQcwgpG3rPggZ3P9lQ4Emxk/XwmQWTZbHl4PZsA22plFzQ9+GX3wDbY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwfdQvzk2Ra+qnneSZ0dxn6Na2pPJ7GsUs0vEoSsZNLOWG6oyPI
	1S0W+iy6Ohxewkxjk771GUgi7xyO3b+tp9V2nvCaBDzvl4cRVsipo7z+xXRCEw==
X-Google-Smtp-Source: AGHT+IFb4emR2RGmSghvMEKrpfmEotCNBNDXXBsiqsAvdWxdvgKS3NIZkCEw3ngGWq1UMs/zX93bVg==
X-Received: by 2002:a17:90b:17c2:b0:2d8:a744:a820 with SMTP id 98e67ed59e1d1-2e93c2fd8b3mr3132802a91.36.1730366714920;
        Thu, 31 Oct 2024 02:25:14 -0700 (PDT)
Received: from li-cloudtop.c.googlers.com.com (51.193.125.34.bc.googleusercontent.com. [34.125.193.51])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e92fbe707fsm3074953a91.37.2024.10.31.02.25.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Oct 2024 02:25:14 -0700 (PDT)
From: Li Li <dualli@chromium.org>
To: dualli@google.com,
	corbet@lwn.net,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	donald.hunter@gmail.com,
	gregkh@linuxfoundation.org,
	arve@android.com,
	tkjos@android.com,
	maco@android.com,
	joel@joelfernandes.org,
	brauner@kernel.org,
	cmllamas@google.com,
	surenb@google.com,
	arnd@arndb.de,
	masahiroy@kernel.org,
	bagasdotme@gmail.com,
	horms@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	netdev@vger.kernel.org,
	hridya@google.com,
	smoreland@google.com
Cc: kernel-team@android.com
Subject: [PATCH net-next v7 1/2] tools: ynl-gen: allow uapi headers in sub-dirs
Date: Thu, 31 Oct 2024 02:25:03 -0700
Message-ID: <20241031092504.840708-2-dualli@chromium.org>
X-Mailer: git-send-email 2.47.0.163.g1226f6d8fa-goog
In-Reply-To: <20241031092504.840708-1-dualli@chromium.org>
References: <20241031092504.840708-1-dualli@chromium.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jakub Kicinski <kuba@kernel.org>

Binder places its headers under include/uapi/linux/android/
Make sure replace / with _ in the uAPI header guard, the c_upper()
is more strict and only converts - to _. This is likely a good
constraint to have, to enforce sane naming in enums etc.
But paths may include /.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Li Li <dualli@google.com>
---
 tools/net/ynl/ynl-gen-c.py | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/net/ynl/ynl-gen-c.py b/tools/net/ynl/ynl-gen-c.py
index 1a825b4081b2..ab48114229ee 100755
--- a/tools/net/ynl/ynl-gen-c.py
+++ b/tools/net/ynl/ynl-gen-c.py
@@ -2414,6 +2414,7 @@ def uapi_enum_start(family, cw, obj, ckey='', enum_name='enum-name'):
 
 def render_uapi(family, cw):
     hdr_prot = f"_UAPI_LINUX_{c_upper(family.uapi_header_name)}_H"
+    hdr_prot = hdr_prot.replace('/', '_')
     cw.p('#ifndef ' + hdr_prot)
     cw.p('#define ' + hdr_prot)
     cw.nl()
-- 
2.47.0.163.g1226f6d8fa-goog


