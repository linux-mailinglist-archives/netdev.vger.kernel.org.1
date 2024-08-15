Return-Path: <netdev+bounces-118830-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 568F1952E77
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 14:46:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D5BA8B24541
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 12:46:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FFF11993AE;
	Thu, 15 Aug 2024 12:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TeMM8esl"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f193.google.com (mail-pg1-f193.google.com [209.85.215.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9821C60B96;
	Thu, 15 Aug 2024 12:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723725959; cv=none; b=mQpSeVo1L4MB8IBIPQ5FdHLDAjnRrO5NVscqEtJSd0bFi/ZYn9JFFUgGLNjiS1nXcrSCQi0hF4W+gnHRtKdpdDg+rONHKxEuspd9/BfUJfHOQ1zeh0HxkI+qE3KeiU46bHex+WfVPSk7iOWk5hwJKQl771X+wb9W2i6mPw0dyEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723725959; c=relaxed/simple;
	bh=8LAOWEJKivormVDWhY8ctyx3bdfsXrYENOdStCSlCMo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=o5d2J4pG8jBKysWCCmha80eZy9frRykUiJOq83L6v9LiP+cD/WtC/RIHT8Snwd/uTf77ivaX0uSCjUxf1jrO3H7HAdfxFi2phK4r+KdVxf5HEG7rN1dVvz3akS2+mU6EnaidWYUyGz5wxmqQRI5cweGgJTMICVCsuLIkdfQQY5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TeMM8esl; arc=none smtp.client-ip=209.85.215.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f193.google.com with SMTP id 41be03b00d2f7-7a103ac7be3so678239a12.3;
        Thu, 15 Aug 2024 05:45:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723725957; x=1724330757; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xj+qWSDyX4FBhZM05vM8itqjIPEXstrdTgRr1ZL+rkA=;
        b=TeMM8eslShkatQhJPmMyqxozDfKPUz0XGeIeAy4RhoNxm0PHbBBWeYlHIXIJEeYzHU
         1jmmRpQIV4BntE9+SGDDB05adQp6rPFQ5igBPXYdEk73K1Tlqdu82CE8A9wSjlgoXAEM
         W/fMk0W9/M+wZg41xJR+EcBOfiqVxjmJbRJTM9/bzLFS2n053550sCW5XFJ91hISWKuU
         yPkCo7A8HJ+5UajAVk8nevgacJ00gTdXXn6SaS2HLD9yO1VWFzwTkRIgPve6XfH8df6N
         q+DNOgDIK99NI5x2mNGNIvDLilpNejq+HzadsPPhaq0PpFQmRboSkSJ7MxINLKn4MRYR
         W5Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723725957; x=1724330757;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Xj+qWSDyX4FBhZM05vM8itqjIPEXstrdTgRr1ZL+rkA=;
        b=oW6uB3Gx5CVVhsdtRdftI/pCbf3+vWek3zSZjIeywfPm6VIxvSUlytw6fB4ZtItNd/
         P9b47rr5MSg+viaLECDkVc6GqsOVdO5sN6o+ojGeDoWjcHTVjIFBIce57uhphfvUaZgz
         4BvBFz9oOFOE2LtvHMkVP3AWXdhw3jbWJpFITBe/dumUM5Ev2Nw8QkE6RmbQystniUM4
         nUQ3HDQAvRCRQJpvE224lYFx2+gKLv2+pytUNjpnUOZIwh5UMF0GTvxBw1o29/GTAbkE
         Yx5Dox9rx0pcSYbexZvEFDJiJnwVsitxH7tHheNG3QS7HBMXFfZ/133a58TlGk/w6Doz
         MlyQ==
X-Forwarded-Encrypted: i=1; AJvYcCXdRG+wPcBKCCJo1bLp+0JQZ6GV/S1xaOSE7xygUX2AQhFieMy2W5MThGkmQyNKhOkYOUN4qcI2f+9Yq15KhljVvy2DAUJg1OUIdUjrNJO7BC/HumEA4nQGJGb6ljCw0YZOQZMr
X-Gm-Message-State: AOJu0YwhLRNfZqL7oA6pgFMsDBlGtsEj2S8IW7wV7tDudr6LQ9wzjUbR
	4ipS4USM1rlVQCICndKPrR3V/A2MgduEpMW/31gsirM5IRQ8gK7c
X-Google-Smtp-Source: AGHT+IEcciK8oBshBV27dKgjADfcnngiRpIshadKUClsh24EnLpmUHM4kwEBkRoADhZa4q09ZKfgDw==
X-Received: by 2002:a05:6a20:6f89:b0:1c4:b843:fa25 with SMTP id adf61e73a8af0-1c8eae900d5mr8335640637.26.1723725956738;
        Thu, 15 Aug 2024 05:45:56 -0700 (PDT)
Received: from localhost.localdomain ([43.129.25.208])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7127af2b942sm923605b3a.183.2024.08.15.05.45.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2024 05:45:56 -0700 (PDT)
From: Menglong Dong <menglong8.dong@gmail.com>
X-Google-Original-From: Menglong Dong <dongml2@chinatelecom.cn>
To: kuba@kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	dsahern@kernel.org,
	dongml2@chinatelecom.cn,
	idosch@nvidia.com,
	amcohen@nvidia.com,
	gnault@redhat.com,
	bpoirier@nvidia.com,
	b.galvani@gmail.com,
	razor@blackwall.org,
	petrm@nvidia.com,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH net-next 03/10] net: skb: introduce pskb_network_may_pull_reason()
Date: Thu, 15 Aug 2024 20:42:55 +0800
Message-Id: <20240815124302.982711-4-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240815124302.982711-1-dongml2@chinatelecom.cn>
References: <20240815124302.982711-1-dongml2@chinatelecom.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce the function pskb_network_may_pull_reason() and make
pskb_network_may_pull() a simple inline call to it.

Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
---
 include/linux/skbuff.h | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index cf8f6ce06742..fe6f97b550fc 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -3114,9 +3114,15 @@ static inline int skb_inner_network_offset(const struct sk_buff *skb)
 	return skb_inner_network_header(skb) - skb->data;
 }
 
+static inline enum skb_drop_reason
+pskb_network_may_pull_reason(struct sk_buff *skb, unsigned int len)
+{
+	return pskb_may_pull_reason(skb, skb_network_offset(skb) + len);
+}
+
 static inline int pskb_network_may_pull(struct sk_buff *skb, unsigned int len)
 {
-	return pskb_may_pull(skb, skb_network_offset(skb) + len);
+	return pskb_network_may_pull_reason(skb, len) == SKB_NOT_DROPPED_YET;
 }
 
 /*
-- 
2.39.2


