Return-Path: <netdev+bounces-81372-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B0D0F887782
	for <lists+netdev@lfdr.de>; Sat, 23 Mar 2024 09:12:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 51DB2B218E0
	for <lists+netdev@lfdr.de>; Sat, 23 Mar 2024 08:12:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F4B4BA50;
	Sat, 23 Mar 2024 08:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XasEWQne"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B812C9475;
	Sat, 23 Mar 2024 08:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711181521; cv=none; b=E0bZbZRwllaDcfXxT1tKrO4t+gx9AyDHHlKi6xAdaOKbpQURZmOHAEkhcrk3dby/SOyUP4HxwNrpvH14LWTErhuOhFsJwpjfbN4CkNIq8LDdbs7XGJ27CC62e5hm0c/Z7fOdixCA71g3Al6J6WQv1o7a/uSaOcoxLrmXkMAO4E4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711181521; c=relaxed/simple;
	bh=JMwKzzdKGu9tiwjUXIyxuCZpE3rZs/L8B0k/jGFBlRc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=grfEmH35vuXycuYLvFPNLmwBXjKX/kruX6b7CDmaHndGk5ps6ez+9XEMvwAa+L6fklcZMvIXdtcsvwixC9nzWC/NUge5+mle/jxEw2b5LSfD8OtjnhGT6deCncVI2aaKMhj7RywnYbP+IcYDQCN0pGqZ58lEZ+NXb8FyTlD4GWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XasEWQne; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-6e88e4c8500so2021649b3a.2;
        Sat, 23 Mar 2024 01:11:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711181519; x=1711786319; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jBwYZ0KKBPOHeG9usQo7hTvvne/fVMxf6Cxd7oHuSmg=;
        b=XasEWQnebBrbLIL53HfmNLANGxKnWywc5RcEMnHvbuNsB1Sk4MdhHb2SswFyrEhodR
         FQ0LthsrkuNsft4Xh1Ux5N2r8PeCCA0aATwG0cLSESMecKK1zv9F6zIem5aDmC409m3x
         zhcPCA2qlCCSef2RFf/KcXqhhtYUAKedcXXaPlWBW7WxbxA6x/t/+k2zrxEmhIhYK264
         HYEh1lQVLDfeQJ/vwsyKlBuiq0UA7NqINVd0Y96wS0Faa+HUJGUeKBxBh3XcA0yEOFLD
         FAdp1gmwMyWPbvHWfGJyB14qhUbpDY5/6FB4YpaN1f86EAN+eYvONy3Tx3f+BkW2sVAl
         +u6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711181519; x=1711786319;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jBwYZ0KKBPOHeG9usQo7hTvvne/fVMxf6Cxd7oHuSmg=;
        b=BvUWZpiv1eJbMRFEMBnaEUbWFw0DUvxytYhvUqsLymcZiLFE8Yo4BAzf0bUNSpvnmp
         oGlXbUjyoCw7oTyQpL7FRPUvxnw6IIewkbh0O/PtbdxNVwH36bxPAJlBAGVq3xd1/ceT
         +m6NGPrQ8u3a89h+xiMOK1v9R122mzDwaxpXa0GtcCcX9vIUpD0SawhPnatfVfcaEtsI
         a6DJ+of7QJAQm4VfLI2uU1HnRqUeOrpW+PtP3OqHbglBR2F+xQNw3LYMGpJtZafs58r4
         BUfwHrx7j61EO+RN/+5THM6qbYSH40jRkTvH6i+AafVEoY0CzrUZFrnicRU8lBiv3MPa
         0+/A==
X-Forwarded-Encrypted: i=1; AJvYcCXxDvCvo9xXAzGDwcGQMAXkwZ8UWQ/jvDero4ja2Zg4wTDv/p+RBK8eVEQQP7bEZbPNXzVKMzfMrQOhTQEUQDv5CC21KwOOosZ/8AlFwf6UDPLPmE9bPX3mToWjJzK3VmBT
X-Gm-Message-State: AOJu0Ywr7jMfdKrgh/7e/UHR2Wj+eZ2izkd8udnmeRENGVhZsYjZaIvX
	vpE9J2tVVP2whKu+6N6eiofDzh6A5Ur2XwFh2wbycTL3W4ANmizH
X-Google-Smtp-Source: AGHT+IEP+Fr0MNTTZdqJx3m+s+xZm/uW9BUfei/BUKpia/QAwq+U0bC1UvjPhIQ3sUINcpVE5aGcxw==
X-Received: by 2002:a05:6a00:3d06:b0:6e6:b155:b9a3 with SMTP id lo6-20020a056a003d0600b006e6b155b9a3mr1996721pfb.11.1711181518914;
        Sat, 23 Mar 2024 01:11:58 -0700 (PDT)
Received: from bharathsm-Virtual-Machine.. ([131.107.147.61])
        by smtp.googlemail.com with ESMTPSA id m5-20020a62f205000000b006ea810ceaf0sm912452pfh.217.2024.03.23.01.11.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Mar 2024 01:11:58 -0700 (PDT)
From: Bharath SM <bharathsm.hsk@gmail.com>
X-Google-Original-From: Bharath SM <bharathsm@microsoft.com>
To: davem@davemloft.net,
	dhowells@redhat.com,
	edumazet@google.com,
	kuba@kernel.org,
	linux-doc@vger.kernel.org,
	netdev@vger.kernel.org,
	corbet@lwn.net,
	pabeni@redhat.com
Cc: Bharath SM <bharathsm@microsoft.com>
Subject: [PATCH] dns_resolver: correct sysfs path name in dns resolver documentation
Date: Sat, 23 Mar 2024 13:41:40 +0530
Message-Id: <20240323081140.41558-1-bharathsm@microsoft.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix an incorrect sysfs path in dns resolver documentation

Signed-off-by: Bharath SM <bharathsm@microsoft.com>
---
 Documentation/networking/dns_resolver.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/networking/dns_resolver.rst b/Documentation/networking/dns_resolver.rst
index add4d59a99a5..99bf72a6ed45 100644
--- a/Documentation/networking/dns_resolver.rst
+++ b/Documentation/networking/dns_resolver.rst
@@ -152,4 +152,4 @@ Debugging
 Debugging messages can be turned on dynamically by writing a 1 into the
 following file::
 
-	/sys/module/dnsresolver/parameters/debug
+	/sys/module/dns_resolver/parameters/debug
-- 
2.34.1


