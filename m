Return-Path: <netdev+bounces-165695-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 47578A3319B
	for <lists+netdev@lfdr.de>; Wed, 12 Feb 2025 22:35:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC28616756E
	for <lists+netdev@lfdr.de>; Wed, 12 Feb 2025 21:35:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D2632036E2;
	Wed, 12 Feb 2025 21:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ChGwc1tA"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D94BA202F71;
	Wed, 12 Feb 2025 21:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739396124; cv=none; b=hFhPWmSJonZIuQqU2wEogMFpMWl0lIDiDgFzq9ZALROCZsigTn8BL1ODJ8a1/Z6Wij6ht6aZGqfOotDlmy7EQlVyxPINmw7N0PWsGlLB69Effisi85oYc1+5TBn8NvqoUP189o+ZxOL53jcW9zLJvKeCIYaP0hW3QOKA0XZwO84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739396124; c=relaxed/simple;
	bh=n7vwAk+mGDnptXQYHkJZGBl0excGHMrDOseNSwoLavE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=YtJxAaka6XTh+EsoEyPMJhP6ENNBmP96yXfDyy1XLA/HNqVG6D0jisaXiQ9KaMZ4QCnv/HwJETU3+jKZ2FWCgfbdr095RTklfRVCCVnK2Tk6LrJOvnSUdlhw0MmRUX4y20IcJr30qXHVX3rdtkmk9xoCOjPz8U7pqUINrAsGM4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ChGwc1tA; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-7c05cce598dso3032185a.3;
        Wed, 12 Feb 2025 13:35:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739396121; x=1740000921; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Pc0F/lVzkzvL4J3GzIJyy7MBw6sqmJhjXpSaIwLTkG0=;
        b=ChGwc1tAySyYtxkkx1EZ1EBxevRfaGzahwJf+TvfYN714abqo0u6gLHzdCkpI2hLgA
         j6EUKZ1xA2Ei5A0Mg8JbJaWtHmaNMaQn/oPCg5hG/8YS37Z3xjlQkBrgOyfeMq2PLY2U
         Bmjlo/vM+b/I8dMdkgPE2iKjV4m2kseTjdHLAZ5dWKXtzdLdadk1ONolCqZPrPz5dS9L
         cZ6XML6IfmaRxY0Yp49pOnciCP+AgBZoU/YSH+tyoT9UTiiec4CH8FXDkxQEgso5m42e
         FRuqIASZ++sfnagFcBfSX22IfpoXnQ6Yy1DM+nZpLlxAZSjLCP3uxImg0arB1+52/BzX
         vE4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739396121; x=1740000921;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Pc0F/lVzkzvL4J3GzIJyy7MBw6sqmJhjXpSaIwLTkG0=;
        b=hNorXCT6cC8hko6TBhsgVRpexVEqnAGNNvTZ1WVCKBGF1cG+y4u3+xs1SiZyv+V23g
         q6KwCkkNXtq1Ll74FSdJAxPcv6oetPS/Hu25Tu6QWm4wq+8bQL5pjzAwWgtWJrmwjDdS
         V42J8oJ8KIQQfpCVCPkQK9aVGd0ojAB4vof/Rtw6XT563CDRT2aTI5s11yQs1Ad/nriJ
         zehZeizxsOA82SoQL8TMgIn6hIg0JAig/tIfd1Yedp6gl1ksWg+gckdVnDWBZFyiMvs8
         hqZgrYGKzKWbshcl+A0VY4qm6gXEejZO121euVFfDcn5FA/SnsBuwIwnkeCnWZpx+AI5
         x+7A==
X-Forwarded-Encrypted: i=1; AJvYcCVPNo0CxmHZao1+tReDofI9G7oN77v2eweQTkJBaVqmn6lFHdeIag56OngBTVCkvFKkza8TLnET@vger.kernel.org, AJvYcCWJB4qjaMbgwQqhNZrdzwq2Fn6H9Rj05P6v+OGTS4XsS0YxVSVggA02SEjW+WvQiWP/OHki10Pz38kagHeWsr2a+Dw=@vger.kernel.org, AJvYcCXvgEEnD3BJMG1ATPw8+6Xm6PTYC1WKbNFIBPqgA2rc0RFX9ONlmxm0i0eN1aDVYnxVaJZ9Z2Rj/N4AZm8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3kSUaAgI0dUbQbbSoiAqeabR/NLEuOrGMe3qUHUiUDSFU75Nt
	LaoCKyyTZ+PC8nPgl/keSdI7rIPlaikk8p0rvG7G/8TpqvQyuiXckvCF
X-Gm-Gg: ASbGncvEKbet69wq8k15UcX7JMbsa51MTnFZ3iDwmH5Fce4e1jpdeRlq/Grv6dRqEi2
	tlqDJUGFQm4v31jj4Qo0/wbFVolBU9O31dHLsu492h8o0z0qcGQfcaabsdN6ZJlH11COQFl7c7v
	LPeK4xtuNCA46UVCPrnaUvMDLyzSAl8g+ahwUDtxCv1X5VO8ViQ9kZ8sKXVGnfVlrwGpRUK9Pu+
	AOeKH9fO+IccPtPUfCvfujIuKo0S2ClOKCy363lm2vEV2bE9SyjRT4JlHShFd3BWL3dow0FiL09
	Z0uPpWwlMIEl
X-Google-Smtp-Source: AGHT+IHMYVT7cXF1vDiX/RjUDK6KvUjj0T8L9QgUzk2mdCPDRHq6yQlf9pMqq1wIwsyxD4WnU7kb2Q==
X-Received: by 2002:a05:622a:1aa2:b0:46e:12fc:6c83 with SMTP id d75a77b69052e-471afc434f9mr26501551cf.0.1739396121510;
        Wed, 12 Feb 2025 13:35:21 -0800 (PST)
Received: from ise-alpha.. ([2620:0:e00:550a:642:1aff:fee8:511b])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4718911f3e6sm52249671cf.37.2025.02.12.13.35.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2025 13:35:21 -0800 (PST)
From: Chenyuan Yang <chenyuan0y@gmail.com>
To: krzk@kernel.org,
	alim.akhtar@samsung.com,
	richardcochran@gmail.com
Cc: linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	Chenyuan Yang <chenyuan0y@gmail.com>
Subject: [PATCH] soc: samsung: exynos-chipid: Add NULL pointer check in exynos_chipid_probe()
Date: Wed, 12 Feb 2025 15:35:18 -0600
Message-Id: <20250212213518.69432-1-chenyuan0y@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

soc_dev_attr->revision could be NULL, thus,
a pointer check is added to prevent potential NULL pointer dereference.
This is similar to the fix in commit 3027e7b15b02
("ice: Fix some null pointer dereference issues in ice_ptp.c").

This issue is found by our static analysis tool.

Signed-off-by: Chenyuan Yang <chenyuan0y@gmail.com>
---
 drivers/soc/samsung/exynos-chipid.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/soc/samsung/exynos-chipid.c b/drivers/soc/samsung/exynos-chipid.c
index e37dde1fb588..95294462ff21 100644
--- a/drivers/soc/samsung/exynos-chipid.c
+++ b/drivers/soc/samsung/exynos-chipid.c
@@ -134,6 +134,8 @@ static int exynos_chipid_probe(struct platform_device *pdev)
 
 	soc_dev_attr->revision = devm_kasprintf(&pdev->dev, GFP_KERNEL,
 						"%x", soc_info.revision);
+	if (!soc_dev_attr->revision)
+		return -ENOMEM;
 	soc_dev_attr->soc_id = product_id_to_soc_id(soc_info.product_id);
 	if (!soc_dev_attr->soc_id) {
 		pr_err("Unknown SoC\n");
-- 
2.34.1


