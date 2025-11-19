Return-Path: <netdev+bounces-240029-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 47C09C6F807
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 16:03:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B85464EFA3A
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 14:49:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A707C2FE045;
	Wed, 19 Nov 2025 14:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KgyrHhUU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23DCA2848BE
	for <netdev@vger.kernel.org>; Wed, 19 Nov 2025 14:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763563599; cv=none; b=QBFtVcaVQUVhgj/6jsV9AVSx1IjDN6SDxoCTsJEKoC+7gzTE6j3+1KSgciMgoSisPQNHtlvwLyodhZTJxTo9xmYrlRsCCjQd+5LeqkvK1IN5PYxbXIoYIlBLhOxdVvPNRWQWDnzj+/wmL51s1o8nbF3dygqv/3jaWnRQlA/s6kM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763563599; c=relaxed/simple;
	bh=dVUb+h86+CetBpU7sUv/ON54rwF6tzp0gCaIYMl6X9Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SlfyYrBKN9jRbww+VkKA+xwULW/Zt0NAtn+/e7AsVhzOWb8h4tv7k+93IFr2h3OxjsD2oN2aHQKzErrq2yhOareknT3dP/zWLvQGdG5hjiodHz0Fd5RAEoVctOBgjDO4a9pzSpWtAvhoMc15xaQyLgZlsTxoGVreNI8vE47lTpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KgyrHhUU; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-297d4ac44fbso6872685ad.0
        for <netdev@vger.kernel.org>; Wed, 19 Nov 2025 06:46:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763563597; x=1764168397; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rQA352dXJcZAKR6yJ6U8qnfyj40QR0CCGB8Vb/aE0V8=;
        b=KgyrHhUUWsGidI7t0Cbx5tMim7p0fKS5NhpubieGc0j7rpiDgl3IdmuC8ndgWFRiqK
         QSVas3Oky0bC8hTdagQhSkhrbcHijtPSj77OtmI3C1mGricfClpUdPVD3cpJhLjZRNAz
         wEGjJy1gBuf0Wg/+JeuxjGlknUqBiHOoYuanssuvDmmZt8Tk+bqRUM3HoKZTzmO7i/8I
         IvoasshX5cWAiBMIHLXl979o0Zhhw2jTU0hT6g3yi4x7YhgJbTgc7hRUOBRDGQTPOpG4
         ytGd/PJkMwcsWhsbs5mQuiA0Yxd6RVx0BimRM803P622gfXpvajaiIuDz2nZEGuV+QQG
         2UYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763563597; x=1764168397;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rQA352dXJcZAKR6yJ6U8qnfyj40QR0CCGB8Vb/aE0V8=;
        b=GIFQ2FzwvnbsuJTlKTjNw3hT44qVORGfkDROvvEFyqqhuSwJRM/ElJ8GwHRSVGEuKn
         Dz5HRZ67IZP+dJJRhBNzGRLwEEYncQ/ajpyEJg7IS/grQo/fCbQ2Buy6JHIduKxDopsk
         9KLYo1h18PIXphxSjmKxb4KpcbYQcBjp29OEHIW8SitZ5zxLCvLjcSbYW8YtMScdIanS
         FsBDtp1+DB32CkMNqqwQ2dQKP0NuKB27iXsLl4zRFCYjo3Y0SKyOGEhDMhKa8ZfmQJ/Q
         cK4dRbJh087vT4uRgzS/1d2knG3TqMAgVYp6a3AYol1jZr6fgxcFehYHzDt3sYPUEbkE
         QBIA==
X-Forwarded-Encrypted: i=1; AJvYcCUKiiNjv8IgXghRIGqzTHIYqF1p1FVv820n2CqUAt4IRTtqrqmjyZaSQ0wpDO0j1+IAauX/+nk=@vger.kernel.org
X-Gm-Message-State: AOJu0YylIB8wCm0ZlAgFaG+XfGO6pyM9euzrqTYsyaFq34vh4cTXT1tp
	i13BCOuEfmEMOTycTp0bqvAJ/+b4VrY1l1M5V7HmpeXeiQd7My18hiAI
X-Gm-Gg: ASbGncvkbIbOGQXiHBmOJ7lrXfWL2snxVdyQeiKTuN/gpfO1d/nqnMbHMQXZhm+Q1um
	c77cna1P9D1ajWTgIa+oWHrtXSQbAneJfRBQ0ZkpC1OxzCoefbdh1RKjKX84+QgxoXcWjpzfVOs
	R8w7fZLUQpprb/poHQhzC1eEN5Vqr2Ki6HhFiNDPZTdyuK/oaPtc4+kNlsHbkPrqpVEnk8uwXWn
	SuS6UCJHwJQvEQmPO1zLtymhGxJxQa2irvmLs2j3cCX88iIoJRaQ4238/dEHXH0D5iP1aZupzi4
	DWwisLP3GacSWA4qgHEsHBXSUQwSWxbzTk/8aQoHof6DyfFDjbmjPBYswcTuSdTe7/4xDIuYu2g
	CMQh2PlPTFZAS2SeRcAClG7ARzImJqoBd6BksrhPoQDCYdzbKgbfXka+Oy8D+s1a+WzFF4Yj8RM
	1MvkLxGi8=
X-Google-Smtp-Source: AGHT+IGpcGVpZRl1c35GOlHBj+kG5Sp++Bpj1FwdXDfVRMbITTp+GnbP5BkK0sgWjprikSCI+cKM4A==
X-Received: by 2002:a17:903:b0b:b0:295:82d0:9baa with SMTP id d9443c01a7336-29a0624f595mr32999145ad.17.1763563597199;
        Wed, 19 Nov 2025 06:46:37 -0800 (PST)
Received: from fedora ([122.173.30.56])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2985c1800ebsm208577035ad.0.2025.11.19.06.46.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Nov 2025 06:46:36 -0800 (PST)
From: Shi Hao <i.shihao.999@gmail.com>
To: davem@davemloft.net
Cc: pabeni@redhat.com,
	horms@kernel.org,
	kuba@kernel.org,
	dsahern@kernel.org,
	kuniyu@google.com,
	ncardwell@google.com,
	edumazet@google.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	i.shihao.999@gmail.com
Subject: [PATCH] net: ipv4: fix spelling typo in comment
Date: Wed, 19 Nov 2025 20:07:37 +0530
Message-ID: <20251119143737.22477-1-i.shihao.999@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert "Segement" to "Segment" in the code comment.

Signed-off-by: Shi Hao <i.shihao.999@gmail.com>
---
 net/ipv4/syncookies.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ipv4/syncookies.c b/net/ipv4/syncookies.c
index 569befcf021b..7d0d34329259 100644
--- a/net/ipv4/syncookies.c
+++ b/net/ipv4/syncookies.c
@@ -131,7 +131,7 @@ static __u32 check_tcp_syn_cookie(__u32 cookie, __be32 saddr, __be32 daddr,

 /*
  * MSS Values are chosen based on the 2011 paper
- * 'An Analysis of TCP Maximum Segement Sizes' by S. Alcock and R. Nelson.
+ * 'An Analysis of TCP Maximum Segment Sizes' by S. Alcock and R. Nelson.
  * Values ..
  *  .. lower than 536 are rare (< 0.2%)
  *  .. between 537 and 1299 account for less than < 1.5% of observed values
--
2.51.0


