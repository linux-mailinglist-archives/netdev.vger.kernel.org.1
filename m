Return-Path: <netdev+bounces-179476-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D6092A7CFEA
	for <lists+netdev@lfdr.de>; Sun,  6 Apr 2025 21:24:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C48607A37BF
	for <lists+netdev@lfdr.de>; Sun,  6 Apr 2025 19:22:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21CF417BB21;
	Sun,  6 Apr 2025 19:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GxftgXb9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 893CB15382E
	for <netdev@vger.kernel.org>; Sun,  6 Apr 2025 19:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743967438; cv=none; b=oN15dQE/qug1B9SIdIvDorAQKiwmi/YgbNvIlB8o2sl1ynon+aGIgjCkpmPrOuoy9iThs1sdala5CxdPhPwF666xpmwo9nEREpGxo767xXHi9sHf5xNM9NKViF9lwa86rUqElyDZ67f/rmtI4/vErUw/vsIjvPlNDT3Drcdv93E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743967438; c=relaxed/simple;
	bh=EieGFLQLJ0v+rZg1k/Oij5Iu8uTnsEz+dTdr4WnVYkw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=uoPh4HHTrMT5l+FN6Fg0H9hcnbdObQLT0gjq0OM9Vt3nWQBTJ2/KdOH/SjQoZWh6jXFvZRiJolT3owjN8y3a5QLbwxWoMNdPeOQA329PHiU4C27vJp5wDZIHDdHrMwIYF0G+EDlKGeS79aTpN9wWn3K/e1dVuF4Nb3tQHCFoDAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GxftgXb9; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-476a2b5dffcso6559021cf.3
        for <netdev@vger.kernel.org>; Sun, 06 Apr 2025 12:23:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743967435; x=1744572235; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ivHbY1bhZo8RIYNDZ9kZqf6sW0sD98v+UBb5+Q8a1tk=;
        b=GxftgXb9wlIhYKDCyq9KfWXHEcv42aqT9n5EglR0y05L8d9F0gXp3+emfDA8aCxIEI
         N+/Sq5SoX0z1gOYfzHu0Hq1h1Uqlj8QRX62pIRWiKlHEp7HCP1bCpuw2yxlp79oYvtij
         Lq0VQwcJ2c9PrkcApzv7ForvMZQfSgmbIgPFoBOkQa3KPtuh2oYfiZys66sbaNKilgvm
         NrPo0MTMq7xzKAdEvvVEJtNKOiNWIr230G2a4nO4PoiFaufZP5ZHIEWOgxaON1ZXa9Q3
         5jkOojGuM413ET6BhON4JnxCNn31usSZxBeWUDiempp/Xc+b7IHu9ewI9OZHS3VGPzhH
         Odyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743967435; x=1744572235;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ivHbY1bhZo8RIYNDZ9kZqf6sW0sD98v+UBb5+Q8a1tk=;
        b=J6K0CecgRTXjH9ZxfQ72qmCC4go9gbsNP4IV8q+6mWH1QiO5pyauB+NnnIDZzbn/AN
         w+aKW0AiAZkk65wohJRjpTfHwtH46F9TSZsjx/3ehDMUlE53etTMHEIGgL1/hR5y1gj2
         FKotpyPw/XdAS0Y44F7a6kPTG3dIvFuA9CG56vboBgorbeF98zGjjCtZwAmCKrU5AOZB
         BLbT7II42tHijQSMrM7+BV8ipprHiLU6l5vWa6g/hFAwwVSg+5dFG54L4UU1Xkj0Lymx
         dUiFXSRRim67lLiCgkIv1nINlmbzvYo8a4wlqVGWt5n+1Oihpp9tDrOBz3vn5zZrR76a
         cSyQ==
X-Gm-Message-State: AOJu0Yw3YrrLPCm3Dg9rOEzJrCPKUbuE7fQX7DXLIddn59Rizy+9Khsg
	h8IUi8tq/qxmjzlkEYb12CEQwThOzzQ2k6duZW4NY6Guy3VkWM4=
X-Gm-Gg: ASbGncuMALhc9AHMDO/SZTiR4UyUEKxp6/8ymsFogYPyzBbJ9Q+nbex7a8yuCxmVXVs
	87RlQ0+1DDgWZ5GkeXzRDEWWU78BvKVr00EkyZBOcTSPslqcah2SWgmSj5d+fXf6k7jwJfyLgmS
	yFcIkuGMW57BBinHpBi7BE62Sq9HagrGpz/KqrMknS3UGWZJbDETabwKvfU+k0fZTHRBd6qTt19
	1yx8Go8k6TlVpWWroyat1LuTJTNemeljE6BWKy/wU4DhUqXc9tRBmSKHWExFXbyDgP2WDijdt6H
	242eIsy47SLs2sGxjsLltXghZ4RwViTlNWs6k9GNXQ==
X-Google-Smtp-Source: AGHT+IG4677evPYvJZWNaNSvgaGVsg9PA6jWFJ7h/HsMFAc19WRJ1GyUB9DaSp/AvspyOmjzks2CcA==
X-Received: by 2002:a05:6214:5005:b0:6d9:2fe3:bf0c with SMTP id 6a1803df08f44-6f00de9c06emr50351546d6.4.1743967435181;
        Sun, 06 Apr 2025 12:23:55 -0700 (PDT)
Received: from ise-alpha.. ([2620:0:e00:550a:642:1aff:fee8:511b])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6ef0efc0d23sm48960846d6.18.2025.04.06.12.23.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Apr 2025 12:23:54 -0700 (PDT)
From: Chenyuan Yang <chenyuan0y@gmail.com>
To: jiawenwu@trustnetic.com,
	mengyuanlou@net-swift.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	jdamato@fastly.com,
	duanqiangwen@net-swift.com,
	dlemoal@kernel.org
Cc: netdev@vger.kernel.org,
	Chenyuan Yang <chenyuan0y@gmail.com>
Subject: [PATCH] net: libwx: handle page_pool_dev_alloc_pages error
Date: Sun,  6 Apr 2025 14:23:51 -0500
Message-Id: <20250406192351.3850007-1-chenyuan0y@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

page_pool_dev_alloc_pages could return NULL. There was a WARN_ON(!page)
but it would still proceed to use the NULL pointer and then crash.

This is similar to commit 001ba0902046
("net: fec: handle page_pool_dev_alloc_pages error").

Signed-off-by: Chenyuan Yang <chenyuan0y@gmail.com>
---
 drivers/net/ethernet/wangxun/libwx/wx_lib.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/wangxun/libwx/wx_lib.c b/drivers/net/ethernet/wangxun/libwx/wx_lib.c
index 00b0b318df27..d567443b1b20 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_lib.c
+++ b/drivers/net/ethernet/wangxun/libwx/wx_lib.c
@@ -310,7 +310,8 @@ static bool wx_alloc_mapped_page(struct wx_ring *rx_ring,
 		return true;
 
 	page = page_pool_dev_alloc_pages(rx_ring->page_pool);
-	WARN_ON(!page);
+	if (unlikely(!page))
+		return false;
 	dma = page_pool_get_dma_addr(page);
 
 	bi->page_dma = dma;
-- 
2.34.1


