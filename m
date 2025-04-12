Return-Path: <netdev+bounces-181934-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CA97CA8702C
	for <lists+netdev@lfdr.de>; Sun, 13 Apr 2025 00:57:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E21491895EA2
	for <lists+netdev@lfdr.de>; Sat, 12 Apr 2025 22:57:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34F251F03FE;
	Sat, 12 Apr 2025 22:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YzYlrWTU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D9CD1A704B;
	Sat, 12 Apr 2025 22:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744498621; cv=none; b=IQ7UkgxLBhoJbDwi5QCcjXP0ySQhNPRj0tEGYM0ugKZO1za+wTQzYMcurNLh6vyshvGpdsp3rqcyW3NHbel4kMeSxNlP3Pus3aAic5DODIz7kTyGSlpWTMfkWwDHTODsoXRRheHcX659Kv62bB5gWhABFnDGPVrj1eDU/4BI8Ts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744498621; c=relaxed/simple;
	bh=9pDHgv7nJtMSUTe9O4UyGj8m21ecrpQbo7Jc0tHte2M=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Lx84i4XODNglNHmFaajFxcYn7va/Ze00BtaiWsoSPSbAgOaFsWdzqmAGZBK/wtrcEGksl7loWm2Ct/RzMRfJyJWVaIhN104ls0msc/3mlpjRsnLkjxmxBw0Rg09EG+kzu7h3S4XDO3Z9kWvNoz1bP0zQFvklnrEAcKvMV1kJPwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YzYlrWTU; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-43d0782d787so21828125e9.0;
        Sat, 12 Apr 2025 15:56:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744498618; x=1745103418; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8Mo2hsF+dWoI+z5fgTL79Rclp6w33rtBVboi85Kh1AM=;
        b=YzYlrWTUbCBbhCMayHXSESC3J8KMsqjT5Vxbp6bW+i67WwpR3Nu+3n9yuFyLFtp7nj
         odgpB92vWCdFpQ9Ym8DAKJB5Ta4UdmO8O9QE2eBifJXcx/whk6Fu45vfaTizI+5QRZuy
         v0bGdAXIAKJEtYmgVCIB1vmT7M58UjJwkFAV0Y98FbZ+Nocwe1xKf+Y7VckZrEfhgURr
         MuIUNWXmgxZa0gLGLNUfqx8RySRLSRVjKwj5NrianQTFZUUUsvofiqI/SMmQZgWGI+on
         +xgQRZCxwxV6Mk7JN+XxndMSqUwitrgi+hp+B6vQk3bnNZoPBRlUiGCOhRYt23IqC42h
         tUGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744498618; x=1745103418;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8Mo2hsF+dWoI+z5fgTL79Rclp6w33rtBVboi85Kh1AM=;
        b=D6TepeuWokiqNmgwDJSEgRNESEVKYEehK7WWTpMMn77dJfXTBOJlacYFzoHGlMk0tL
         8VkohGavMILly2MbNz2+QAF/iUSqLntwV+FXYes10YWKvcE11vl1l0hOaXRdlPuHz1P9
         t80NlnLq61mUh3/NkOb+uaECyK6K9PHzKVEZEr3RFbQbP/83RnDZ6xhc7JBARp9vvci/
         pcTWVYoQ5iqFau86S6mtTlqpnAnr5zNx1vMKSGtGAxm86U4tjGLBr5RCzesT751sOwup
         Jxxl1wR9DXqoApbdh/gdQ3zr3jwHMnDdHqp7gtpGCI8ZL0w2Nw091hQlJtNfVSNAKlUk
         x73Q==
X-Forwarded-Encrypted: i=1; AJvYcCVBuuqgn8b76N0fnIglCGtW218U45S2ac2v5sxcgSD2fx6mp819OltS/m9dXwsdENRK+6xWVaAdoDE+wpM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUFuJB5Gv3HLo668EqCTGK0m4r9Nir44NOOlWeh/EHJJNwht6M
	c9Y0u33qxhhHX4CCneIj8LPS3o4PSr5gTeq8tPJyhIfwfeOK1JEcuRkNlQ==
X-Gm-Gg: ASbGnctd0P7Xz9JqYfQwHMaGD66iqFpwH/XCCpRHY1UFvmm7jCVYWyKlIKL+ic7K0Jh
	NVS5aUkG6Rb7F9jJM0dYltw3VDXNEEFi+tARwMRTymdHPtvZzEYlDX6Mi9EyV6XLEd34Jj+UzVY
	9rG/2prOdN72zwGtBRUUN0m9FZlVzJ9WVhiaogr2HMmAO/Slm/YFgOb0HuLsVa4/StFyUZBiwiE
	l6bLpGglQ36Z+ZodoKZOCC18ykLxaOD1z4LVTB6OX5YPA43xhClfIu0NW3i7xTgAMrAMIttdqBe
	MUNJrIzY0swqkte8Oaawr6OtwJV7HsX/uHTAwP4=
X-Google-Smtp-Source: AGHT+IE6R8SgsC3jWPDGY2M7qgNcT8f9iI9JCKzr5b6Y1NYsO1vN5/rRL/qQrS07G7lwcGLVTcL5iA==
X-Received: by 2002:a05:600c:3c89:b0:43c:f44c:72a6 with SMTP id 5b1f17b1804b1-43f3a929372mr66157665e9.2.1744498617289;
        Sat, 12 Apr 2025 15:56:57 -0700 (PDT)
Received: from qasdev.Home ([2a02:c7c:6696:8300:2ee:4c6:5dc7:f715])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43f207aeaccsm128428385e9.33.2025.04.12.15.56.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Apr 2025 15:56:56 -0700 (PDT)
From: Qasim Ijaz <qasdev00@gmail.com>
To: jlayton@kernel.org
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] net: use %ld format specifier for PTR_ERR in pr_warn
Date: Sat, 12 Apr 2025 23:55:28 +0100
Message-Id: <20250412225528.12667-1-qasdev00@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

PTR_ERR yields type long, so use %ld format specifier in pr_warn.

Fixes: 193510c95215 ("net: add debugfs files for showing netns refcount tracking info")
Signed-off-by: Qasim Ijaz <qasdev00@gmail.com> 
---
 net/core/net_namespace.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/core/net_namespace.c b/net/core/net_namespace.c
index f47b9f10af24..a419a3aa57a6 100644
--- a/net/core/net_namespace.c
+++ b/net/core/net_namespace.c
@@ -1652,7 +1652,7 @@ static int __init ns_debug_init(void)
 	if (ref_tracker_debug_dir) {
 		ns_ref_tracker_dir = debugfs_create_dir("net_ns", ref_tracker_debug_dir);
 		if (IS_ERR(ns_ref_tracker_dir)) {
-			pr_warn("net: unable to create ref_tracker/net_ns directory: %d\n",
+			pr_warn("net: unable to create ref_tracker/net_ns directory: %ld\n",
 				PTR_ERR(ns_ref_tracker_dir));
 			goto out;
 		}
-- 
2.39.5


