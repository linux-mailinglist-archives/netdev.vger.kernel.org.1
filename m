Return-Path: <netdev+bounces-70015-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 86EDB84D585
	for <lists+netdev@lfdr.de>; Wed,  7 Feb 2024 23:11:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9978D1C22A78
	for <lists+netdev@lfdr.de>; Wed,  7 Feb 2024 22:11:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FA711386B2;
	Wed,  7 Feb 2024 21:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UCSJZz96"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C9D113249C
	for <netdev@vger.kernel.org>; Wed,  7 Feb 2024 21:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707342219; cv=none; b=ss41+j75h/2I89S+UlpyFPG/4/qYuMgr2hV2ciBPaxYcXyQxIlVpl1uQbeFQ5KF59fQIhCFgp2E2PSrp7FV3Tap41eRpzaW+UImd19LSatrOuqbAcGbbKvrgpq0it3DyjiDXDyY1tEAh6Fqt8vx2qAoCBH3K8QKJxKtyTVVzTP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707342219; c=relaxed/simple;
	bh=LXCrV8R8F12v25xCfLwncrlB/GGLsdPZCFgyQMUizEI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=p4gySh8NntKhxRpWtSgqHmc5o8G0snyLp4Aq9w+dttKjeiD9MKqK7stxijUdxLCvquWlvnwIk5eOjzTzHB6EoanRUQYlpkljswgNda7bCXTHpethvkqxx4Mcxa9Yddk5815zJlt4SCMpm1zFrSXrZjcSolrAUUnmMtONDwa6/dw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UCSJZz96; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5114cd44f6aso1589776e87.1
        for <netdev@vger.kernel.org>; Wed, 07 Feb 2024 13:43:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707342215; x=1707947015; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oN7g+8eFMHO9eUVxyv62uqiHcggXFRhcNdsT/xU1v8I=;
        b=UCSJZz96Kqjgi9x8MjIHzpWyvqjhfHU2YPzmIHt5PdAVZ3ywqaCklkDdXgEIv9ugRR
         wWBNvV3ivGP7SM78I6QlFE9FoRoABGwv6/f0u9VQjwNRQ9lZ78WFT19mZ7IcC+M3FOik
         lKCk5/r1Ecr5lFkWZUZ0YJD0wtfByKRAYCYOSXcnlRsDeTblMm246coApSK+PXw0/ZMN
         KSjEqEsh2/5mkFNHclkGFvGdF/TFFCmMssXAngNcjdUbHbsH53hyUQf/oOFV+IQG9fum
         lRBfBVfg5VlcqK+iRXexrnDujNgQAPMUqs7EJlqswqoptEBG7OBmAXHvMz1uxPj+bHXp
         +/fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707342215; x=1707947015;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oN7g+8eFMHO9eUVxyv62uqiHcggXFRhcNdsT/xU1v8I=;
        b=PZrdYQ4zESyeNFXxpBvYpluKCq5pJ7T6PMDsOT0DnjN37kb1kcGyy5iwTUg9UeUn0x
         oEiiBqim+zx0sTHGKRTZ7lBWUBp5mvqrESU3bd2DrxA16Ra9RZWsBSKaZO4b1KME+Sq6
         pTD7TPn4ZH0SH+EZVcllshxIIMS9aRF2tT3adebE+bgK6BxVGTiYj9qJJTzlS9OSacpL
         utLgaADPVUc4FgUqk/g+h51u5oYCoPsmXcf6KmGLi1JQnHS+29uMpWMHb4VdN7xM15Q7
         3wLtlBG4UxD7I4b/6yVp84DXAlv+D24KMfy4ew0EqiJyym/mVVdx6Wz4tXR3HG7fBtFa
         Fu6A==
X-Gm-Message-State: AOJu0YyA1GnJoqBwhFrVUumu1FIZ7Xrgw93kIckCRRcJ5khsQ14Stgt1
	tFpdC5DiQGupDU+8YluhhtPpC0gfV0gclsb0M3dOTFLJCj+d59e7yIhFllE1
X-Google-Smtp-Source: AGHT+IFWvCcoSwtDel10WGcXWOCHIoB0ceM1kKF43Eo9/4Jybc6JMutMH2laOcNxWrk6OQfcIVEaDA==
X-Received: by 2002:a05:6512:469:b0:511:486d:454a with SMTP id x9-20020a056512046900b00511486d454amr4390925lfd.39.1707342215442;
        Wed, 07 Feb 2024 13:43:35 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCV+W2El3VkQvfEVo030OxWwxg2+8MZvZyXqFeYeEcn+qsU3+DPo/+0zMgevsnvn902XFkMmH4QELVwtWIQLUn4LwMMm3ojW
Received: from mishin.sarov.local (95-37-3-243.dynamic.mts-nn.ru. [95.37.3.243])
        by smtp.gmail.com with ESMTPSA id e18-20020ac25472000000b005116cbe5b7dsm45236lfn.121.2024.02.07.13.43.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Feb 2024 13:43:35 -0800 (PST)
From: Maks Mishin <maks.mishinfz@gmail.com>
X-Google-Original-From: Maks Mishin <maks.mishinFZ@gmail.com>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: Maks Mishin <maks.mishinFZ@gmail.com>,
	netdev@vger.kernel.org
Subject: [PATCH] tc_exec: Fix descriptor leak in get_exec_kind()
Date: Thu,  8 Feb 2024 00:42:42 +0300
Message-Id: <20240207214242.19291-1-maks.mishinFZ@gmail.com>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Found by RASU JSC

Signed-off-by: Maks Mishin <maks.mishinFZ@gmail.com>
---
 tc/tc_exec.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tc/tc_exec.c b/tc/tc_exec.c
index 182fbb4c..ae9e1f94 100644
--- a/tc/tc_exec.c
+++ b/tc/tc_exec.c
@@ -60,6 +60,9 @@ static struct exec_util *get_exec_kind(const char *name)
 
 	snprintf(buf, sizeof(buf), "%s_exec_util", name);
 	eu = dlsym(dlh, buf);
+	if (dlh != NULL)
+		dlclose(dlh);
+
 	if (eu == NULL)
 		goto noexist;
 reg:
-- 
2.30.2


