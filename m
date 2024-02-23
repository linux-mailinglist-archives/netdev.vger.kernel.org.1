Return-Path: <netdev+bounces-74412-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BFCD18612F3
	for <lists+netdev@lfdr.de>; Fri, 23 Feb 2024 14:41:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 705412865C5
	for <lists+netdev@lfdr.de>; Fri, 23 Feb 2024 13:41:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4FBF82C60;
	Fri, 23 Feb 2024 13:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fy8UyQ56"
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f48.google.com (mail-io1-f48.google.com [209.85.166.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF43281AB1
	for <netdev@vger.kernel.org>; Fri, 23 Feb 2024 13:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708695582; cv=none; b=TfQC8fLiXeXBftIjtNAKCE5kVguG7iBPRNRT1IiYzjXKp78TE8HO5Yfs9syiqaXMO2SaYh95OhrSKQF++yWLsQSno7jYgxsaYsTJjJzaPJ+8j6f+HLzDAiZQqrk5HQ8OVmjRjqmlb7WPVGsD0NJP2DI8Oo7IXlEdy3WcrzaD8iE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708695582; c=relaxed/simple;
	bh=46OEvxCUZOG0ruOPXMwETLi+p6CGJ5C1qF9K+H3PvbY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gBlV5nQUIju4hQGpVwYBNAPX/ZswuZzRW0mELgqG1RTQBZT4hjPE7C2A8fEYT3Q6QmcSw9X84fGVAjSmHGUQhmAkTWiqiOm9Zu0XXHpe151FY8vx1x7+UgDXclZRerJsKiMLIj2/Es/YGi7iH8nbrfeCmVd0WyGsAStiyPNizZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=fy8UyQ56; arc=none smtp.client-ip=209.85.166.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-io1-f48.google.com with SMTP id ca18e2360f4ac-7c784a9ff80so11041439f.0
        for <netdev@vger.kernel.org>; Fri, 23 Feb 2024 05:39:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708695580; x=1709300380; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BNgvh3MFbGff8zkaafQFr7XhBPRC4e9c/AqOz6KeXsg=;
        b=fy8UyQ56ZSKhdxF6HxdkERCDoUoESlk/Vpc5+e7gT85ga3AJsWgj/nHTf47Pv2FMHT
         onMN/aUe7P4/pUS3IMo5nfUYJwINwhfqOC/YqJCt7Gm7VqzXZuIb+s8T1coHETuPgVx8
         IGm4kTTFf8vbHuRp+7cll4H9S0Zs/1cxnqvdnRCo5Bl99MRl3O0EbD0aA8+TV0ktGXjb
         TW4Cx6zYj8ZgboBdNVRWuOcv94i4Su//ederFIAmA50opVHkyfbUq+cWpqE5mUbi6uFe
         kAoZftsUZPIl5PjG0GGJ/OmJMtfkM1QNFcQoDPqYZg6RetI7Pm7DrV7N4fHEsLgX54kJ
         7Txw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708695580; x=1709300380;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BNgvh3MFbGff8zkaafQFr7XhBPRC4e9c/AqOz6KeXsg=;
        b=KAuo22V88Nzh/Fw9+U0bCLENzvJYWWtjmAcSBjC2hkyiupeq/5GM9ixXCojZT5Rn4P
         wEGxrJc7FOFSPkKHIt4DAkGHc9i9fZh7DPQLWNj4uv0FNV5fLofJ1CVK3JAKAue+lfTJ
         5M7u6PkboJkg84V2Mywen302JYFxoJmIcYh6pHKw3JcCLnwgILw6zjnRo+NNDJkMlq0y
         a9DCfGHe/GeOySKw8RZNk55FmcuyR87v0BphI8FgQzGp3kJpfbjefElmWe1utREbVo8B
         FQG1iy+lKHKDz9EZAdKoTJvpuZySZL7W4kS/KdBkw+Y9dcT+yWI4RK2FoReff7ZR1ca6
         nxFg==
X-Forwarded-Encrypted: i=1; AJvYcCXQ0dL7q0kRjk2s2XHBF+8mmN/9xCa0UcHbKF3I6nHhUCKMOrM7JcjTynYVTmW+0jqK6elV5OeNHFMjVqnBoJa2GYqVkwAG
X-Gm-Message-State: AOJu0YwaRQ/2nwTs3jzuJfi/eelSL1SvDA62gX8rAIoq0J6MrLfs4hW3
	JAJHdp6Xhk4kOIiamq3DZYyPiwtwBkubBh9eCP9SHUQq7mNZn9kUfxQ9sPOE45I=
X-Google-Smtp-Source: AGHT+IG9LWtZiZctodKf3c6/8tnMA+P+/9qmimvMxAU8H3yJNcXRsCx5CtJ9MtjwKxyLhZiHcWpWPA==
X-Received: by 2002:a6b:c9d7:0:b0:7c4:9cb9:dac with SMTP id z206-20020a6bc9d7000000b007c49cb90dacmr1796068iof.19.1708695580130;
        Fri, 23 Feb 2024 05:39:40 -0800 (PST)
Received: from localhost.localdomain (c-73-228-159-35.hsd1.mn.comcast.net. [73.228.159.35])
        by smtp.gmail.com with ESMTPSA id p11-20020a6b630b000000b007c76a2d6a98sm1836838iog.53.2024.02.23.05.39.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Feb 2024 05:39:39 -0800 (PST)
From: Alex Elder <elder@linaro.org>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: mka@chromium.org,
	andersson@kernel.org,
	quic_cpratapa@quicinc.com,
	quic_avuyyuru@quicinc.com,
	quic_jponduru@quicinc.com,
	quic_subashab@quicinc.com,
	elder@kernel.org,
	netdev@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next 4/6] net: ipa: move ipa_interrupt_suspend_clear_all() up
Date: Fri, 23 Feb 2024 07:39:28 -0600
Message-Id: <20240223133930.582041-5-elder@linaro.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240223133930.582041-1-elder@linaro.org>
References: <20240223133930.582041-1-elder@linaro.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The next patch makes ipa_interrupt_suspend_clear_all() static,
calling it only within "ipa_interrupt.c".  Move its definition
higher in the file so no declaration is needed.

Signed-off-by: Alex Elder <elder@linaro.org>
---
 drivers/net/ipa/ipa_interrupt.c | 48 ++++++++++++++++-----------------
 1 file changed, 24 insertions(+), 24 deletions(-)

diff --git a/drivers/net/ipa/ipa_interrupt.c b/drivers/net/ipa/ipa_interrupt.c
index a78c692f2d3c5..e5e01655e8c28 100644
--- a/drivers/net/ipa/ipa_interrupt.c
+++ b/drivers/net/ipa/ipa_interrupt.c
@@ -43,6 +43,30 @@ struct ipa_interrupt {
 	u32 enabled;
 };
 
+/* Clear the suspend interrupt for all endpoints that signaled it */
+void ipa_interrupt_suspend_clear_all(struct ipa_interrupt *interrupt)
+{
+	struct ipa *ipa = interrupt->ipa;
+	u32 unit_count;
+	u32 unit;
+
+	unit_count = DIV_ROUND_UP(ipa->endpoint_count, 32);
+	for (unit = 0; unit < unit_count; unit++) {
+		const struct reg *reg;
+		u32 val;
+
+		reg = ipa_reg(ipa, IRQ_SUSPEND_INFO);
+		val = ioread32(ipa->reg_virt + reg_n_offset(reg, unit));
+
+		/* SUSPEND interrupt status isn't cleared on IPA version 3.0 */
+		if (ipa->version == IPA_VERSION_3_0)
+			continue;
+
+		reg = ipa_reg(ipa, IRQ_SUSPEND_CLR);
+		iowrite32(val, ipa->reg_virt + reg_n_offset(reg, unit));
+	}
+}
+
 /* Process a particular interrupt type that has been received */
 static void ipa_interrupt_process(struct ipa_interrupt *interrupt, u32 irq_id)
 {
@@ -205,30 +229,6 @@ ipa_interrupt_suspend_disable(struct ipa_interrupt *interrupt, u32 endpoint_id)
 	ipa_interrupt_suspend_control(interrupt, endpoint_id, false);
 }
 
-/* Clear the suspend interrupt for all endpoints that signaled it */
-void ipa_interrupt_suspend_clear_all(struct ipa_interrupt *interrupt)
-{
-	struct ipa *ipa = interrupt->ipa;
-	u32 unit_count;
-	u32 unit;
-
-	unit_count = DIV_ROUND_UP(ipa->endpoint_count, 32);
-	for (unit = 0; unit < unit_count; unit++) {
-		const struct reg *reg;
-		u32 val;
-
-		reg = ipa_reg(ipa, IRQ_SUSPEND_INFO);
-		val = ioread32(ipa->reg_virt + reg_n_offset(reg, unit));
-
-		/* SUSPEND interrupt status isn't cleared on IPA version 3.0 */
-		if (ipa->version == IPA_VERSION_3_0)
-			continue;
-
-		reg = ipa_reg(ipa, IRQ_SUSPEND_CLR);
-		iowrite32(val, ipa->reg_virt + reg_n_offset(reg, unit));
-	}
-}
-
 /* Simulate arrival of an IPA TX_SUSPEND interrupt */
 void ipa_interrupt_simulate_suspend(struct ipa_interrupt *interrupt)
 {
-- 
2.40.1


