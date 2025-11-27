Return-Path: <netdev+bounces-242399-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 11019C90243
	for <lists+netdev@lfdr.de>; Thu, 27 Nov 2025 21:44:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A60433A9DF6
	for <lists+netdev@lfdr.de>; Thu, 27 Nov 2025 20:44:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E349F3164AB;
	Thu, 27 Nov 2025 20:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aUPfxoq0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C99E9314D03
	for <netdev@vger.kernel.org>; Thu, 27 Nov 2025 20:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764276274; cv=none; b=MUThsuZRKGA+9DzsStJhGprwxw45M5RGmz5VE9wcjRLaKtFl0L6csxAZImifg7yISDI/LYfcludxZL61qBQ+Z/I2Ra3C3NDjLjc7ikItmyWyUWs8Yy4KMK1PtDRn6PIFj7qFGlKC/HLR9Lx+GZbKNRjTUZwqA9+lJEZK8oIGGD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764276274; c=relaxed/simple;
	bh=wKLX50upMBXTkaYsn5OUPjFxWSff+rFLBPN8t4x3gXA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YzKQcr51NO+jVoEOHsezmtodOqv8TnbmEBIKjZnfz63tMR57NXGFPF/EcpY3S+abOPFwRpFOibcTSySJ55FRCON7mLuiwcu0hiGyMLfoNh7Yv0kccilECBLTSXXRL0XIcRnuNc/7HfcS/NKlFM+hRygz+rCKIfvUgoc1dOkRJpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aUPfxoq0; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-42b566859ecso1157049f8f.2
        for <netdev@vger.kernel.org>; Thu, 27 Nov 2025 12:44:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764276271; x=1764881071; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QqckiZGHf3bNG1zTutRGSVS8PaQ4OMxeAJnwQy2/Q0I=;
        b=aUPfxoq0Hio5ZQS2G2fSjo0D2AbYa5RAD/3sviTaZmeuhfDe4kUhhkqG2F9uicqq0T
         8NM/Iw5A++YZYbDOWzRar66j0C11LjMgtJQF7Dr5fk1sihqoS+x+sa3pvL9OeooNkjq7
         KrYdJIji7Lnlis05CvAHPwGc33gcPaQFQmFnwH5+zLPNn5KYaumjEHhuj4TqR6GZeilF
         a2i7co6DnN73ELuYq1t1Tdl9td/uKBKv3Ggw3Oe6Cfv+n5nxpVI/CpOmzwBx9XMxr2O9
         V0o5xHOiytQhzFticuvKM+PxRrxyhK1ykMRjt0+y7fkSOZcr6gq1zdHtYoW0onuSX8wI
         iyWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764276271; x=1764881071;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QqckiZGHf3bNG1zTutRGSVS8PaQ4OMxeAJnwQy2/Q0I=;
        b=FS49JNArRHexEE+b1lgz7TPn26ZgoEDMzzCkFS5jySQ0G9FHHnSFSHFz0mCQRcAsNm
         ZUXbBJe4dxgTuWQbZGK4Uvwka0uyfBtlBXP+J9QzF+2Z/ENkdp1NC02JPsaMVrHdTfS8
         /H8iw73egFK466qDYzckp+f/9vZeyECrm1kcx7l85fWCoVGWyLBKwsluurYIrUSLNowx
         Q86pGTDzs6FxmTbWKOQ9ERxSO9Cy8AvRCIkEq6HZAZE3VcgP5H8HQbr1HnM/BOSXFeZc
         +z37GlyDOo/j+iGOJ8lKL0ZJP5NtmTn/YphsSgTzKKQAY/aEEFS6p7AvGUpDnIUjYC0v
         FwcQ==
X-Gm-Message-State: AOJu0YxfhBYPNZjPB7+g7aaL0hl5OKdYyGd+ght4kn21CyJaEdYhiqBM
	DCFAmdimzQ4aCLmx8Pcgqh9386Vn2Tn3m0ivy0wxVIrEFMzVIBvIlnnYjfAhrQ==
X-Gm-Gg: ASbGncvtmXgh82iFAytKVfLiJHA64Hct8LpQnIXljoK6Wo/TCkv3SDzdadTcfnj8P+S
	hM71Km34/IWOFwsqLASOsPqaF9n8n4mCaHmR7NzmGT2PybF/UjEZirQNmZFGkUOTVJG082WpW1z
	kZXyPRQ+D7UQEdCWvblovT6O8a2oPs1dYTYH2h8A4eSo49xGv1PVioaVvW3h0okrHekN1v18MGx
	vHQ58xtiVBTXFk+b1NQvbXi2jZCmupVXqtEAK+dQTXkHyCPsvVFEa9m/pzjlbYIHYSpQdx9qr5J
	9ra88sNdYaoidxRENoInoLpDvSILmSQQ+doL/i34Qo591pCOm0vbwHEQVwVSq1/h3nCwDRFgbpd
	2xCXe3hLnOuuZnvMHpRz7DbXY5YXEs8smgC+Ee84j01x4u8j7MjHp7D6teWHCaUW80WS8bx56pP
	q1rq+u/ZS2ufTYxmAOpIxUmjQI
X-Google-Smtp-Source: AGHT+IG8xP4HJO4DnqjJPYdufQcB54g2uija30UcXEQTiQoRe6u8ZY63WY3zQ9RB9/Vh8e5LOItojw==
X-Received: by 2002:a05:6000:2c0c:b0:42b:2c61:86f1 with SMTP id ffacd0b85a97d-42e0f34a082mr13136672f8f.35.1764276270574;
        Thu, 27 Nov 2025 12:44:30 -0800 (PST)
Received: from 127.mynet ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42e1c5d614asm5346105f8f.12.2025.11.27.12.44.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Nov 2025 12:44:29 -0800 (PST)
From: Pavel Begunkov <asml.silence@gmail.com>
To: netdev@vger.kernel.org
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Michael Chan <michael.chan@broadcom.com>,
	Pavan Chebbi <pavan.chebbi@broadcom.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Ilias Apalodimas <ilias.apalodimas@linaro.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Pavel Begunkov <asml.silence@gmail.com>,
	Jens Axboe <axboe@kernel.dk>,
	Simon Horman <horms@kernel.org>,
	linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	io-uring@vger.kernel.org,
	dtatulea@nvidia.com,
	Stanislav Fomichev <stfomichev@gmail.com>,
	Mina Almasry <almasrymina@google.com>
Subject: [PATCH net-next v6 1/8] net: page_pool: sanitise allocation order
Date: Thu, 27 Nov 2025 20:44:14 +0000
Message-ID: <337ee90a6464e9b9ab09d1850fd9aedcb0e13679.1764264798.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1764264798.git.asml.silence@gmail.com>
References: <cover.1764264798.git.asml.silence@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We're going to give more control over rx buffer sizes to user space, and
since we can't always rely on driver validation, let's sanitise it in
page_pool_init() as well. Note that we only need to reject over
MAX_PAGE_ORDER allocations for normal page pools, as current memory
providers don't need to use the buddy allocator and must check the order
on init.i

Suggested-by: Stanislav Fomichev <stfomichev@gmail.com>
Reviewed-by: Mina Almasry <almasrymina@google.com>
Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 net/core/page_pool.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/core/page_pool.c b/net/core/page_pool.c
index 1a5edec485f1..635c77e8050b 100644
--- a/net/core/page_pool.c
+++ b/net/core/page_pool.c
@@ -301,6 +301,9 @@ static int page_pool_init(struct page_pool *pool,
 		}
 
 		static_branch_inc(&page_pool_mem_providers);
+	} else if (pool->p.order > MAX_PAGE_ORDER) {
+		err = -EINVAL;
+		goto free_ptr_ring;
 	}
 
 	return 0;
-- 
2.52.0


