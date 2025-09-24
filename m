Return-Path: <netdev+bounces-225987-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4516AB9A350
	for <lists+netdev@lfdr.de>; Wed, 24 Sep 2025 16:21:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 63FC67A7ED0
	for <lists+netdev@lfdr.de>; Wed, 24 Sep 2025 14:19:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 187583064A0;
	Wed, 24 Sep 2025 14:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Rk+uV1zo"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C9CA305946
	for <netdev@vger.kernel.org>; Wed, 24 Sep 2025 14:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758723686; cv=none; b=ZpWUNbqhAdObYVd6XyJOmgfPufVVaA2h90FhLv9FzpWQuaqU3EsMd8f9BmmSvKVJcqT9I1JKaOKYrnPaHHaWucaTnCgUaLXES4i3VvKi7iK3uaehAeQWx4e1oel3YDjWE/t7yJQkFS4fqinv8Tl2DZ9yOYLk2CdzF8FQnqbQC9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758723686; c=relaxed/simple;
	bh=8Bd9BNziqvvbY4+frkt1YLGnyHQ7qyi67mb9YIWosgk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=ufXGyzVMwHkC/IFUmXL+jtcWbGSvn8psyf5zv9bN1F2UHQ3/tCn6ynfh3fXHxqr+IF2HgWnifC+MYNcnjkBj0/pQdB2X6QUPRr8LvQX6bC1R8VyMKbiVbkSEsvW7B3mVWDgimsOC/Zg9SH2niUDK8lnaGfyTQ9YvT6okq8Mb3iM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Rk+uV1zo; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-45df0cde41bso48550565e9.3
        for <netdev@vger.kernel.org>; Wed, 24 Sep 2025 07:21:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1758723682; x=1759328482; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZUOwXMuTBpB5Fy7yoIxpDSUv9vUppjY8hnmiw8isNgs=;
        b=Rk+uV1zoCA9XTCXfPx3u63Nx+n5BmWFBDhdWMb2om6n6KkGt1VN8ZBoHTgaXGsMCGc
         L4JXBhHdtdqIPAXFjGOfmX8MCSw1uP/tQP0THTV9omNr29EIcnF2Dmeu7vHy+a79K8xy
         MRv9peIRpgTGXf1UC6txpfJnQ4tCHDdbzQdDDz3KGevQyGY4U7OB5BDVY5oohTEasyeQ
         PQvhDhkOtCDOzCe+usuEVcfHygWUC+0xfSQ1jMWsJ0xN9xKN1l6DMMr5GREdAhCVvWy6
         zFBb5t4CIUxGx1W7nS6dwy+YeAmDLVyz6yVrtD4EdlJX+Njdxfh1yA0m/L2wpIQOv1UY
         +oGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758723682; x=1759328482;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZUOwXMuTBpB5Fy7yoIxpDSUv9vUppjY8hnmiw8isNgs=;
        b=cgU+p13+TtGxQX8PwxjdpE6n6BQ+QT5s5aZn4BakzVAXl4IiaOUWqQmqDo7ITshlA6
         oR94VvEbUiGQpi3hGucWyfv+CJF7YopNh9unXiC9tOqZyil2pO4xCjD3+ZP3thd84LUc
         CqhLiQPgZe60UQ4eXRxMaKlX58m3H3fsm701bl4pnxRd+VROljIBXTIq3d6sJ9acL9jN
         jLD+tv9NmJFrZEd1H5B5sOjYqi9ahErjrQKDzr19svJ6W9STzHHzFo5Q17RWgbzzq3GS
         OS55wTnWlBYiE0HxfyK3uP3ZodcK74ZFo9925KKA5c2R6cVwQZi/hk1zm8txHR6D0i97
         /6hQ==
X-Forwarded-Encrypted: i=1; AJvYcCVq14pzbliiMAboP6Y3mFBU4NCW+faURRqbovL6TefkOezUyG8H1dWKA/4ifDcMCRJnuCVUO3c=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLbg4oWm6ng+She4oRieYFsFkIrRxlawapvHH01mZWdn6FCEX3
	PhzQiP44hvYKiGjWGcp4KtTV6BUxdUwChd/sL8hrd+aYCJecPJEeXhvlyCZFLtMcIlA=
X-Gm-Gg: ASbGncvUcWBnkDjqLImZFNXK/TaAahJrSI4YW1t39iA9KWlIqjwpB/J+ngd8ZLmY7hA
	avceoh7I+S2JZ9Sc3T77R87XU3S1gr3Cuv0nvOk3BiCoStItSwmLBxyiBKnFWes6ano++R+3Tm5
	bX9ZvuWk+fDRz/1d7RZk4EhHmFwjV7X7LfhojvCCNi/3ZixdJ8LEAGlA5f8TNjtNunqgThSj9XF
	NAcUGaDdsbwzacGny/uoPjEwZAc9GGeN3Ty/4BfSmRQRqoOIbQIFpFg9xlAPcpp0ye3l8aOClv4
	iZrCxK6uQqLCRuAnjUInwa+Hj/oEyzJOCOVzXrOXMkLp8bJRUEIW9nf/48nbUC/8vn6J1vcmkXA
	IInbQZg7Yg7kK6kHdlpVvg7WuJNq4
X-Google-Smtp-Source: AGHT+IG55pmdfKl6TOSmeMM1pq2EjePpFbf+bYc0kIwlIBb4cj5o/va5cZMOtuDRcr/jCbXXpn9noA==
X-Received: by 2002:a05:600c:19d0:b0:468:9e79:bee0 with SMTP id 5b1f17b1804b1-46e3292ea3emr1209375e9.0.1758723682187;
        Wed, 24 Sep 2025 07:21:22 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-46e2ab31f1dsm33992125e9.13.2025.09.24.07.21.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 07:21:21 -0700 (PDT)
Date: Wed, 24 Sep 2025 17:21:17 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Julian Ruess <julianr@linux.ibm.com>
Cc: Alexandra Winter <wintera@linux.ibm.com>,
	Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH net-next] dibs: Check correct variable in dibs_init()
Message-ID: <aNP-XcrjSUjZAu4a@stanley.mountain>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

There is a typo in this code.  It should check "dibs_class" instead of
"&dibs_class".  Remove the &.

Fixes: 804737349813 ("dibs: Create class dibs")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/dibs/dibs_main.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/dibs/dibs_main.c b/drivers/dibs/dibs_main.c
index 5425238d5a42..0374f8350ff7 100644
--- a/drivers/dibs/dibs_main.c
+++ b/drivers/dibs/dibs_main.c
@@ -258,8 +258,8 @@ static int __init dibs_init(void)
 	max_client = 0;
 
 	dibs_class = class_create("dibs");
-	if (IS_ERR(&dibs_class))
-		return PTR_ERR(&dibs_class);
+	if (IS_ERR(dibs_class))
+		return PTR_ERR(dibs_class);
 
 	rc = dibs_loopback_init();
 	if (rc)
-- 
2.51.0


