Return-Path: <netdev+bounces-137970-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A6109AB4D9
	for <lists+netdev@lfdr.de>; Tue, 22 Oct 2024 19:19:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E9EC628550A
	for <lists+netdev@lfdr.de>; Tue, 22 Oct 2024 17:19:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75318129A78;
	Tue, 22 Oct 2024 17:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nF4ZeaJo"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f195.google.com (mail-qt1-f195.google.com [209.85.160.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E21324438B
	for <netdev@vger.kernel.org>; Tue, 22 Oct 2024 17:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729617571; cv=none; b=A8K7pfZlD+iKHOwJaxmrcfesXptyroxuv8CaFg9cTdLJ+d3jhe5wMQcmH0jmX8sQm3B+5AHcgo9W25JVvCFbT3EClnT0jPv5iEzsj1U1tZ6V2qoKWPaA0fcnX7o9WEImnIOnun2Aq7LV8rOnImopLqHN57bj+6P+c2+NF6RZQlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729617571; c=relaxed/simple;
	bh=nUryThz5o37dNI0mDWSblLuG0h+YU3nhLD7/5kIPKBY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=HjAGCDPuKSrs8r5qsdlwEkNtWVo9NF/zHuERwrNNxsiJkdAxZ2rvwUSRki4HbEOQoVNZl/kUgROrsEBYtY0TJBSX2/HHsJyE0zQpG08ixIotwRqfcwpf0M11bonGTwYkwPW8rxzq/6xahgKHJP3CCt6EtWRL2GY5Xelculkekok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nF4ZeaJo; arc=none smtp.client-ip=209.85.160.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f195.google.com with SMTP id d75a77b69052e-4609d8874b1so43903841cf.3
        for <netdev@vger.kernel.org>; Tue, 22 Oct 2024 10:19:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729617569; x=1730222369; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pmF6q3KhMVF4wyb5d1/kIlzZ6vp1c/Dl5xxvMWHbeOw=;
        b=nF4ZeaJo5BnCSPZIF0zRXD4I8XnmdJqtzk18XQMSwu6J0rY353hHJRzRNw4x8L0qNE
         cU+IoXNxKumNA+zWp7pMGEk4UJY/noepwOEFR0f9ibUCaar+YodeC+3e0/HXuZcsUyRl
         55I/8rqjUz8QXBUZqo8F3h9hrAXiDqpg7053mGrpWecqPl031JBRDh/R0Fuy6NwmG35O
         u7Bk8u0a9XwIQ0QAhmKhLCEttr7Ele+7pfm5PIqnpkq/vMRqUyrTiKJw9dIY6rte5EN3
         j2CBEWt/jC58P9XAHfOMP68jwKSqtXmyrE+QBEUz9O8DXlvZS8gFajmoGddWN1qPrbVB
         2Zuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729617569; x=1730222369;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pmF6q3KhMVF4wyb5d1/kIlzZ6vp1c/Dl5xxvMWHbeOw=;
        b=hrmR6fmai6MEbsYvz5gO48QwTMJoNqOuE6dNNsvBhebaEBxuw1xfB2uvbaYLlGCOvL
         gQLX1YAuNaCF+TEOLMp/9umSX9aOkQkVoF4TH4VrFOtk3731xn/dFBueLSbwR94zTBeL
         Wt7FRBqBqYNEajBW8xM5DmB6zvz0Vc+Qvj2Y3tpf+38LUFICjgro0ybg5g0Vl+iczE9o
         yaP6F0ILUAaXyR5onkbL0OLGipL3lNb99Hg7Dc5k0k0MpkAhC16DPvfE56idG8eYeCbK
         vAdT1iwzPARCKBMays+I2AEZBH7E34doNG64c80UgrHSl3RZ0TwLCEUg0rxJ6hYihgaG
         qbdw==
X-Gm-Message-State: AOJu0YyTpfCApellX+ix7D0iXRgNJU5sI0DxZsCnnK3QOgO8p46Urt9Z
	p5tbN5xuVHTYePNqgZJp+KViTTL6ybIqI+dv//Qcq6RBRta40Xio
X-Google-Smtp-Source: AGHT+IEjac2mmmrvJFYOylmCweZNGJmi3t0XboWJs1TTa0gpTi0b6Bje/3xFwyFkLIdH1tc2j4a+7g==
X-Received: by 2002:a05:622a:1348:b0:460:9bea:d74d with SMTP id d75a77b69052e-4610106abaamr38908881cf.59.1729617568815;
        Tue, 22 Oct 2024 10:19:28 -0700 (PDT)
Received: from localhost.localdomain (host-36-27.ilcul54.champaign.il.us.clients.pavlovmedia.net. [68.180.36.27])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-460d3d69480sm31419481cf.72.2024.10.22.10.19.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Oct 2024 10:19:27 -0700 (PDT)
From: Gax-c <zichenxie0106@gmail.com>
To: kuba@kernel.org,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	petrm@nvidia.com,
	idosch@nvidia.com
Cc: netdev@vger.kernel.org,
	zzjas98@gmail.com,
	chenyuan0y@gmail.com,
	Zichen Xie <zichenxie0106@gmail.com>
Subject: [PATCH v2] netdevsim: Add trailing zero to terminate the string in nsim_nexthop_bucket_activity_write()
Date: Tue, 22 Oct 2024 12:19:08 -0500
Message-Id: <20241022171907.8606-1-zichenxie0106@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Zichen Xie <zichenxie0106@gmail.com>

This was found by a static analyzer.
We should not forget the trailing zero after copy_from_user()
if we will further do some string operations, sscanf() in this
case. Adding a trailing zero will ensure that the function
performs properly.

Fixes: c6385c0b67c5 ("netdevsim: Allow reporting activity on nexthop buckets")
Signed-off-by: Zichen Xie <zichenxie0106@gmail.com>
---
v2: adjust code format.
---
 drivers/net/netdevsim/fib.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/netdevsim/fib.c b/drivers/net/netdevsim/fib.c
index 41e80f78b316..16c382c42227 100644
--- a/drivers/net/netdevsim/fib.c
+++ b/drivers/net/netdevsim/fib.c
@@ -1377,10 +1377,12 @@ static ssize_t nsim_nexthop_bucket_activity_write(struct file *file,
 
 	if (pos != 0)
 		return -EINVAL;
-	if (size > sizeof(buf))
+	if (size > sizeof(buf) - 1)
 		return -EINVAL;
 	if (copy_from_user(buf, user_buf, size))
 		return -EFAULT;
+	buf[size] = 0;
+
 	if (sscanf(buf, "%u %hu", &nhid, &bucket_index) != 2)
 		return -EINVAL;
 
-- 
2.34.1


