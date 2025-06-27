Return-Path: <netdev+bounces-201969-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FE6DAEBA52
	for <lists+netdev@lfdr.de>; Fri, 27 Jun 2025 16:49:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF3EE1892F11
	for <lists+netdev@lfdr.de>; Fri, 27 Jun 2025 14:49:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 163022E54D7;
	Fri, 27 Jun 2025 14:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ag8mP7me"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54D57155A25;
	Fri, 27 Jun 2025 14:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751035739; cv=none; b=mC2CJdnU1SEnZm3D4Beq5ZePiJiO0OYZMroIY712B2ax+HumL6rshpvlm7CJR86vzZNYe7Ni35PmGt4s5rkxqD1AGczxdi53tap7HpJo/z2IN0h3Y6mt0caGJq5a7BRiRE18jEchUT1ymztvMlHPKNWu9KyzLPL+JZvjj9SjRQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751035739; c=relaxed/simple;
	bh=PgDtvezvfN0apwSm79eeYMe3MeebVFqQvrb335ZXcR8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jIjpEROzkOk9RxsoMLGG3j0mER3YMQ8P2BCgyu2wATqlE/O9CSmjGFcE8jVc1tDpjiW/WkCIut0AcnuMLv2G5lSP5wgifl64wF8t1XL2FrHYL7E2+SEVSZI3XhfVuu5K6hE+HM5u5yIub4+es2mWo5j94jjV8E6QIv11eGZGgtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ag8mP7me; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3a4eb4acf29so88494f8f.0;
        Fri, 27 Jun 2025 07:48:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751035735; x=1751640535; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lB9dIABr2HIiSIeqI5qonkgIr53VeG5KIlhHVmx25VU=;
        b=ag8mP7meDq+jbNSDO0Kg+TgskPlkDFTUDfTQHkeEZtkAMYje3Bm7TqTI/OP1kxXXU2
         K3/OFQQ3Dft/xxkZTc3OYQ9aQ/1Vadr+N+IuR2O9LUrkrrwJmMxctbcd2uVpWCQefm4s
         JtxuG5yv2FKMqYB9txFdsLVPI1s5bvKTdmqEXyCjwdK1YyPbfxu1j/Rl1nHSJjcAL2lh
         gQR1DSedOm84n/r+GQ0o23hGOA0w2ZhCB1qOsd8Xc4w1xuAX/cJfaPwJn5ATczoo9++j
         0lj60iysdjDhLtIc/D6eL0Cc9ej6BCtu6LD7IqFPlZnmI2anSuL5hOX/Q8bsh/tWWxOI
         6GMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751035735; x=1751640535;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lB9dIABr2HIiSIeqI5qonkgIr53VeG5KIlhHVmx25VU=;
        b=hZiKsne8f5vrLzHiqPC1h3jG4PIZVV8tNwR4WFCljRYm5uq10K01CVByYJFBUDxK4P
         wC4PWWE9xsRsoCPMKfNpV0MOBdtKlI2UDhN7t8z/ljCm5GhBj6LvjugU6mv9VesIzflA
         6TopLTCcC/yWdjHQ1g3yXChT4B61pzZDnxaLVG6mMg8pnZ14WCxaQ0vC0Q3uj63poLpn
         P3aPw7L+4NyQ6F7R7CGANZDA8qWyFqY/L/ngitAitRLLz+zEjsB4QmZaqTqhKI5JDB7Q
         Jrv8lM9jZ+AnQQzCF4JCVfg+hxWThOv3mTymjPEh6q4kvqmee1y0KKrj9aX6QaAUkqv0
         bXcw==
X-Forwarded-Encrypted: i=1; AJvYcCUjRbqtTOHL27uGF+R9bezrqNhKl4pFC6iSxF0XXEtyGBIhcjWda2bC/GbJWDmtiIBsjnqmVm0+@vger.kernel.org, AJvYcCXhCVWl8vEyirHV9tATU5c3yquPKamS0d2vQdAqz/YqRQw+q2MNDlBKnvn68jDiWg/p+6cQ9vbJ0O8coBM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzhaQ9BD1AnKbDYD/HnG5VNNVmx+Z/DhNYP/IwxozEiQbPv4pw8
	OEpZtjpT1ZpfPRP9pIs4xHpy29+DW9KGx0/JXOodsONjD+68XAg3jO0E9SBBNkKB
X-Gm-Gg: ASbGncuZegkoDzTWV2rwXie4DP28QhubmyThgssFyYxHmYHq4RBgt5k+o1PTgOral19
	7XQRz0lt9cItX5vCSLWxxS+kJUsBapXIRP/ARGcNgUJDpNNusmSSvFJemYM/fIUGlRTml3Gk7AG
	30K937Ieg9PVYdT9w+YmeWds1TAw4VkX142f16fClYcu3jFbGhw8C/6qx20sM/q5gTbXviDKK8b
	h8fvEA5qFuZU9MNbJk0fxNSR3BI9/FYqX5atFIs2np6a2TnS10N+ZfoN5E9TSFqGJZyISFHmqeq
	mOxyASHikXf/pQOFLQ5eUMP/DmJ43igH0UWCZlSR7SwFm2JAuY3tRbojd6BP9f+y4SNsYCXg+Ow
	Ue5uLnRCCl7s2DUg=
X-Google-Smtp-Source: AGHT+IHE7j0XYqd8NhvGkoCQuiEczwClOpaqT9Q076nqbwGdrqLZpGelga0HVy4OB1FFIpIeBhmLDQ==
X-Received: by 2002:a05:6000:178b:b0:3a4:f035:7804 with SMTP id ffacd0b85a97d-3a900575e2dmr1447579f8f.16.1751035735465;
        Fri, 27 Jun 2025 07:48:55 -0700 (PDT)
Received: from thomas-precision3591.imag.fr ([2001:660:5301:24:fade:13b1:a534:8568])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-3a88c7ec69dsm2868626f8f.6.2025.06.27.07.48.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jun 2025 07:48:55 -0700 (PDT)
From: Thomas Fourier <fourier.thomas@gmail.com>
To: 
Cc: Thomas Fourier <fourier.thomas@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@kernel.org>,
	Jonathan Currier <dullfire@yahoo.com>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
	Shuah Khan <shuah@kernel.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net] nui: Fix dma_mapping_error() check
Date: Fri, 27 Jun 2025 16:48:19 +0200
Message-ID: <20250627144823.250224-2-fourier.thomas@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

dma_map_XXX() functions return as error values DMA_MAPPING_ERROR which
is often ~0. The error value should be tested with dma_mapping_error().

Fixes: ec2deec1f352 ("niu: Fix to check for dma mapping errors.")
Signed-off-by: Thomas Fourier <fourier.thomas@gmail.com>
---
 drivers/net/ethernet/sun/niu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/sun/niu.c b/drivers/net/ethernet/sun/niu.c
index ddca8fc7883e..11ff08373de4 100644
--- a/drivers/net/ethernet/sun/niu.c
+++ b/drivers/net/ethernet/sun/niu.c
@@ -3336,7 +3336,7 @@ static int niu_rbr_add_page(struct niu *np, struct rx_ring_info *rp,
 
 	addr = np->ops->map_page(np->device, page, 0,
 				 PAGE_SIZE, DMA_FROM_DEVICE);
-	if (!addr) {
+	if (dma_mapping_error(np->device, addr)) {
 		__free_page(page);
 		return -ENOMEM;
 	}
-- 
2.43.0


