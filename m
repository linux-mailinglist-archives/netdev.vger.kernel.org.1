Return-Path: <netdev+bounces-196849-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1905FAD6B0E
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 10:40:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 858783A9E3D
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 08:40:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C93A239570;
	Thu, 12 Jun 2025 08:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D5KluM8k"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6632A235070;
	Thu, 12 Jun 2025 08:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749717487; cv=none; b=uFyTfLJhQJLGlUS6cp9f8VM6YCUYEHNGI5tCuZJuTPBnu0L/QSoSiMK8muhjoslE0Rxz1ZQFH7yTiJBqXQgjB1Q8CW36apCm0xRFPbya9UsGCi8Ie81ogYKbZP9JeXTzBLTYosjrPkZfbVkwZN8GGRFrITF0CTV0f4Y1i5CoNNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749717487; c=relaxed/simple;
	bh=NEP3F+vUUicYzuhgzptosUL/Xcq/QFfmF695lGtM0YE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rgVj6TP3Kknz+gdX1DiJiPOvZloo6NcSnaJQZ9cSQgrYhqlHEGN8FvRGkBWOIfpVBuPRFUinvdvSpSnb2IJg6YDknRAcwINPUDiupbNLUagSy8Oi/a9iz2KBZlT17yTcKWE+fnlv7i30NR3LiB/3WA4NFxlF7+/nBpbgFS1loUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D5KluM8k; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-451e2f0d9c2so5117745e9.1;
        Thu, 12 Jun 2025 01:38:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749717484; x=1750322284; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uK6r+2HTB3R8tDuUpgjuCKn/Vgifq8Kb0Spys3/XbcY=;
        b=D5KluM8kNa/80FNiUFMNg4x+zAOKZnnZXUiw/KkcLazCPQ+7eoNOB5QPx05ezpHsH7
         IzWzJykBFE6+wSTggEYwEVLKbFCiqmKYbQ5P/vxN8SIqQHBulm0ccx7k3eZ4p3Jt+uEt
         H0/8GdYZaFWA+RBjGM0PlnCVIGgrp0q9hFLjV9N2WZ1q1Na6ruygVJKHBo5vzwpE4HUb
         5kRFGs8zdkhNXb7hIzTrKktQsvAUNz6tgvr9dmRxVfBGlkNcx2VdqV74+wQ5E0N5Afaf
         hoJbGYUAlBDORuhUFd3UVdowjATCER+jKzhiI4xAwR1aDYKgNwogfi1wtOBG4eub2mKX
         pWeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749717484; x=1750322284;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uK6r+2HTB3R8tDuUpgjuCKn/Vgifq8Kb0Spys3/XbcY=;
        b=iyU5Mav3zPKZqBF/8JPOQ4YaWPeNtQUcYGm1iOHnFYiIHBEeKqAVL43jYxvkVIyq2i
         cS7WEOq4Mkaop/arRiL5zFspSEqeCw3nkHbs8GPc0W9dKNd6WJSxlzhH+6PO7aIZpnnO
         Lc2OTrBtyIxzDMc3Ik9D6DUgyUAwJ2E9uuDXcnmllO0vgb+LnmEyKCGOw9EXHh1jvDlN
         3vEbzGwi8KwVa42O4n9LhbkAssas+2eM1cL9wLuGcBVVMrhcSwRs87rd+8mjSnIyPWb9
         UsmH4OfRESLboYxL6hXRzWq/U2nzMBc2hkowKjJQacoA2uSxiz6qDk7eCXmfrHggUc/c
         Gd9A==
X-Forwarded-Encrypted: i=1; AJvYcCUKco+6deeHsvnXnsjCC5SgBXyCKrGHmQG0uuQcC0lSBUnUzXVa6L6xvEd6VR5IqNg/CglsWA+j@vger.kernel.org, AJvYcCXH/2sOM8HourOnrVEf7Rr7QS1I9Qs5XGgq2zsKnqEbF8tipMDcR8xqQqNvOIHIC67PEb7tM6eN4EMaV8I=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHq6HDA5jVQAJgPbZC1oFDjuVgFfsPkFD5cYHstgXA8BSKwoa7
	4EpVfHnvBsUexj73elrLKPIY0SqMgmhO2MxvtpEuFU5WC0FyWT6Qqmyg1NCt2Q==
X-Gm-Gg: ASbGncs10XmWKueRuaz0CClnri/ZLWweJGpxPA69fuOVff6qVODJcCh5mb5g58HuKGm
	E72ZLLdUilJ4kvYGsKEt4BUXfvSS5xoOmQa+KoXQdNGtWDNt+s+jK7koNOaqY+W6nRqSHWc5oBS
	OgGxl8fs/va+TWhKIybKRweKe5RBv4zD4D+ZOmOD6OAvMMsizMj4XxMFdiZ8xqC37wthWsmXsSA
	B+RnCYQSVJZn0LK4vjx6GWz1bOvf7Xaur3Mpdy3rl7may2MnMLSbODlkT0LOVPTvkvj+Lr518Yb
	Ay0brJUd0Q+x89FF3TuJqiOuQFnhuwdocFAy3uDrVYjhWMQdmTCao5EaTHYPcHT7B3LHEW3O77i
	V7rntlKqBsjtgkgnwKyG0LtVRGHhVobTM4gSdmaHAe9T7bUe1qDdZmXWKW38LBGxCkaxMiOIuVL
	iwMTV2tInrj1Rx
X-Google-Smtp-Source: AGHT+IErjM0t458OqBkklX7FTLPrnKm2zIjciup6Ea4jkaCN5vkL/tJViAszKZpnogVrBkE/FLYYgw==
X-Received: by 2002:a05:600c:630f:b0:450:c9e3:91fe with SMTP id 5b1f17b1804b1-4532c183f9bmr22774285e9.0.1749717483529;
        Thu, 12 Jun 2025 01:38:03 -0700 (PDT)
Received: from slimbook.localdomain (2a02-9142-4580-1900-0000-0000-0000-0011.red-2a02-914.customerbaf.ipv6.rima-tde.net. [2a02:9142:4580:1900::11])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4532e224956sm13350975e9.4.2025.06.12.01.38.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Jun 2025 01:38:02 -0700 (PDT)
From: =?UTF-8?q?=C3=81lvaro=20Fern=C3=A1ndez=20Rojas?= <noltari@gmail.com>
To: jonas.gorski@gmail.com,
	florian.fainelli@broadcom.com,
	andrew@lunn.ch,
	olteanv@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	vivien.didelot@gmail.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	dgcbueu@gmail.com
Cc: =?UTF-8?q?=C3=81lvaro=20Fern=C3=A1ndez=20Rojas?= <noltari@gmail.com>
Subject: [PATCH net-next v3 10/14] net: dsa: b53: prevent BRCM_HDR access on older devices
Date: Thu, 12 Jun 2025 10:37:43 +0200
Message-Id: <20250612083747.26531-11-noltari@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250612083747.26531-1-noltari@gmail.com>
References: <20250612083747.26531-1-noltari@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Older switches don't implement BRCM_HDR register so we should avoid
reading or writing it.

Fixes: b409a9efa183 ("net: dsa: b53: Move Broadcom header setup to b53")
Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
Signed-off-by: Álvaro Fernández Rojas <noltari@gmail.com>
---
 drivers/net/dsa/b53/b53_common.c | 5 +++++
 1 file changed, 5 insertions(+)

 v3: add changes requested by Jonas:
  - Check for legacy tag protocols instead of is5325().

 v2: no changes

diff --git a/drivers/net/dsa/b53/b53_common.c b/drivers/net/dsa/b53/b53_common.c
index 1ecadcd84a283..d082e5a851ab5 100644
--- a/drivers/net/dsa/b53/b53_common.c
+++ b/drivers/net/dsa/b53/b53_common.c
@@ -730,6 +730,11 @@ void b53_brcm_hdr_setup(struct dsa_switch *ds, int port)
 		hdr_ctl |= GC_FRM_MGMT_PORT_M;
 	b53_write8(dev, B53_MGMT_PAGE, B53_GLOBAL_CONFIG, hdr_ctl);
 
+	/* B53_BRCM_HDR not present on devices with legacy tags */
+	if (dev->tag_protocol == DSA_TAG_PROTO_BRCM_LEGACY ||
+	    dev->tag_protocol == DSA_TAG_PROTO_BRCM_LEGACY_FCS)
+		return;
+
 	/* Enable Broadcom tags for IMP port */
 	b53_read8(dev, B53_MGMT_PAGE, B53_BRCM_HDR, &hdr_ctl);
 	if (tag_en)
-- 
2.39.5


