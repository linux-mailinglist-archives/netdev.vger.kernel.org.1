Return-Path: <netdev+bounces-89440-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AF6D8AA44D
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 22:49:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 16CDB280F2A
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 20:49:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95C1E1A0B04;
	Thu, 18 Apr 2024 20:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZZPLlPP+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f42.google.com (mail-io1-f42.google.com [209.85.166.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16CD019DF70
	for <netdev@vger.kernel.org>; Thu, 18 Apr 2024 20:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713473265; cv=none; b=BMULODTP4v7Qd3g1XAxEokDZJrubnu5ZL0TbR47IHk48+xzY+k83aH0ThqFAhqBfpeZdAfoPwXCBC71NrFdkqRfuQrLAMsi4e8MhRkJjepXAB0LQU2qqPV7rtrdL0Jo/MyNJxtYXMOuXVvkhHOiQamLkBSJrVaPaCOK+eUpGh9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713473265; c=relaxed/simple;
	bh=XyYpi71wJ0gs3n01rlT/IbyAJXkfH9+nq2GSfnQ1k/w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IEJev0sPzX5GuU3Dk/YJm7Qn/6DS60Ii3PzVims0yYOMSh8q572oL4is4bw4MLhNn0QVq9WlXGbt2NXguMgL9Y69zajWzQ378xjB1R2d/fPNDcnGAzvaYpsyWvESrxk7mEpqkyGZQan55vcWpWQEhkozpG4Zfppq3MgMNY34LC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ZZPLlPP+; arc=none smtp.client-ip=209.85.166.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-io1-f42.google.com with SMTP id ca18e2360f4ac-7d6a772af5bso45223939f.1
        for <netdev@vger.kernel.org>; Thu, 18 Apr 2024 13:47:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713473263; x=1714078063; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fi0Ji6XcxTq7nWZptSfD6FmyaTvUSY/Oz6qXD8maVXs=;
        b=ZZPLlPP+4XDZ7PF63LsFgJPul7de2gSxgeQkiiEHeEcL5yRoY+BERT55BVILhV2In9
         IpXomHHSleFX90PDxkK/L9hOD8CuR9OhUhCfs8c8oLk1yCcjLPJR1P4xiUTavlICFe7y
         nRsk/wpWEw8HrrB0hNEFiKo2SF8o6WMAOovfG2dGBUNxSrtLIGN7CcG8bX17nkc7YYLa
         0c3cFr6J3ImAVT+t1Q1N164q8SGIqfKa/LlyxASKIijsvuC6shtmJYQo6eYMgKxdKrHU
         clLABJ8NAdQ0NmkZzmUErd/B1B+FQzKmbaYowY/8N2dkpDbIr8AkMsSx/w65N0KUxZnj
         3d5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713473263; x=1714078063;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fi0Ji6XcxTq7nWZptSfD6FmyaTvUSY/Oz6qXD8maVXs=;
        b=oUtOQlSMwzGbqDqoudQ+tWJzmcJ/y8G/9f8IWW4VN9gpCahf1mpJ7GqV/SivX6pFof
         S58NB/yJOlLYyW+mxyecMtZlU4EgHub68gn8xuRFjwWnKcHRI2SuUlIY2WQDaNYGUx5G
         FivxJRqrAJJ0+os74/etHo3zWkeLOhps3qClO7arOZzUCTRXGBhWAbRxJFeyOx+yePdk
         LpH+4tQttp6NElKZFm1SXfmXyCE2g0ttvAv7acmhYVguj1F4kC/aqsrZICH6DLcZnoQO
         LIkXojx91t45O4eA+FHI/WW8bMqiCbo/ovki2xtsJR2yoeAbY7NcBEgcICTz3PdvC93e
         geqA==
X-Forwarded-Encrypted: i=1; AJvYcCUqk0gdmKxLZf7e4dKFctkHllkxVIhaeFxQ/wNCu628z6wi121RIi0AjjGZrqOonJWP0DR+nS9G0ltRtkDeoYa1NNFYbO/y
X-Gm-Message-State: AOJu0YwYCrN7dhvqbS8ME1eaxsRXkPRrQ+MLAbas0dOVPZbb9puOWQY0
	2js6JQeHO7Dy0WEklyPwpIbo6tfGKDfdSW8Fmu8RnChEM0fxLur+OcbejuHmdLA=
X-Google-Smtp-Source: AGHT+IETNjFLF3X+Ku5v+Xs/f3tk1jQTaxypjSebgt5O2xuGJvzOB8jqRXYV5pbnShahTZbeDUMiWA==
X-Received: by 2002:a05:6602:4a86:b0:7da:1885:50b5 with SMTP id ej6-20020a0566024a8600b007da188550b5mr378319iob.9.1713473263316;
        Thu, 18 Apr 2024 13:47:43 -0700 (PDT)
Received: from localhost.localdomain (c-73-228-159-35.hsd1.mn.comcast.net. [73.228.159.35])
        by smtp.gmail.com with ESMTPSA id r6-20020a056638300600b00484948cb8f5sm626998jak.91.2024.04.18.13.47.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Apr 2024 13:47:42 -0700 (PDT)
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
Subject: [PATCH net-next 6/8] net: ipa: fix two bogus argument names
Date: Thu, 18 Apr 2024 15:47:27 -0500
Message-Id: <20240418204729.1952353-7-elder@linaro.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240418204729.1952353-1-elder@linaro.org>
References: <20240418204729.1952353-1-elder@linaro.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In "ipa_endpoint.h", two function declarations have bogus argument
names.  Fix these.

Signed-off-by: Alex Elder <elder@linaro.org>
---
 drivers/net/ipa/ipa_endpoint.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ipa/ipa_endpoint.h b/drivers/net/ipa/ipa_endpoint.h
index 3ad2e802040aa..b431e4e462114 100644
--- a/drivers/net/ipa/ipa_endpoint.h
+++ b/drivers/net/ipa/ipa_endpoint.h
@@ -1,7 +1,7 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 
 /* Copyright (c) 2012-2018, The Linux Foundation. All rights reserved.
- * Copyright (C) 2019-2023 Linaro Ltd.
+ * Copyright (C) 2019-2024 Linaro Ltd.
  */
 #ifndef _IPA_ENDPOINT_H_
 #define _IPA_ENDPOINT_H_
@@ -199,9 +199,9 @@ int ipa_endpoint_init(struct ipa *ipa, u32 count,
 		      const struct ipa_gsi_endpoint_data *data);
 void ipa_endpoint_exit(struct ipa *ipa);
 
-void ipa_endpoint_trans_complete(struct ipa_endpoint *ipa,
+void ipa_endpoint_trans_complete(struct ipa_endpoint *endpoint,
 				 struct gsi_trans *trans);
-void ipa_endpoint_trans_release(struct ipa_endpoint *ipa,
+void ipa_endpoint_trans_release(struct ipa_endpoint *endpoint,
 				struct gsi_trans *trans);
 
 #endif /* _IPA_ENDPOINT_H_ */
-- 
2.40.1


