Return-Path: <netdev+bounces-141558-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EC529BB602
	for <lists+netdev@lfdr.de>; Mon,  4 Nov 2024 14:27:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3420E282F15
	for <lists+netdev@lfdr.de>; Mon,  4 Nov 2024 13:27:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D586A1B6D02;
	Mon,  4 Nov 2024 13:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kM1FCfAs"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BBB7175A5;
	Mon,  4 Nov 2024 13:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730726738; cv=none; b=W+nLWi+zk1L1epyCrRZnl/q4QyHdZOFxuXYLjAxavPtg6PN3AUP2cTzoTxozqMIwNpd0gdYTjNyoXH+0FtbYKSVz5Gr8qmtjs9IgCgKoebgSamTtJYQVlTV7MHlwoeHsTNuGsECpfWcDMRMnhb5IxPtVqAn7Kqwvki6lg22L7e4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730726738; c=relaxed/simple;
	bh=kp0D3cC5IuIrCirrgAAdTM/KE21oTlBj0JPcIY4Pg0s=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=emDPiC1bn0eCokcYj8U4c6oMQmXUM98fq7yoNELs9MVquKxyEbRTpYpsVoSS+HWMbjPRXBEfRso7I4TCcyIU1dh1XZ1HQYfCAX1RZ99WmkfdJJRq+yhmS5U/cDBAYPhL64Voq5wOI5NRF8C2Wlr8XrW+MQlMkQj/oXLmZ7V4gQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kM1FCfAs; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-210e5369b7dso41038035ad.3;
        Mon, 04 Nov 2024 05:25:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730726736; x=1731331536; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FVoMIWzf360C25U37OtMANuTeybK9pp+v3EWwBRps7U=;
        b=kM1FCfAsNgMAppli4TJwof0oQjYE4RtP4qMQkCBzrCA7+bsRa/Yv91N6aVxIjIGBg7
         xwyx5UeZlWswW5zWFn/bog7XjnQBKUI2Xj/2og85o/g4aXKCcyKgvTRMhGYEh9N9Nz59
         gpq7mxYWwPlBOINexm0nuQjHx/LWsyNixpbcL4ag3uve5wjpYFhCOFyvNxpW+k5C4Syk
         IDD1J1XHIG8CFy4p7pNcWf/rAmL7t3AgVzsoxfLXNy/r5krNxpQ84FF/IWcdM4Km8kdR
         g8nfSlXIDFXxTBNyij6nN2taLxLnRooY4PbIU4Sv7/ulgqFT2u+PCTQwNiJZIaHcSW7j
         HBmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730726736; x=1731331536;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FVoMIWzf360C25U37OtMANuTeybK9pp+v3EWwBRps7U=;
        b=uE+VXDnNIWex3flaPDSUr7GrO38tih6r4yKiklHiFJjb9ZdBBKou+KS7qkBxz3xjaA
         8sPLCQ1DrRzQr7lRmIwbo76LGEChvTXs2jccdYpfMojHsf+h+jBd0+yrT/7nKyFcF6Qr
         aSm3sOshcyrZZ73w0G03deeVsF2V6FiptyovLn9c1doM/vfEETkGGVVBQq7MJFhjnFYf
         lw+ubm8JP2ZCJyg7+JhphvVRCHie7CUUTK+MorcjCY1LuGV4s8FQJvv0roKNKPAuSrIa
         pkHKhBnMcFuxGBQsmw430xCsb3+Acp5ma67Yj7VuqGPHULpAPtmc+E/rTh4MyO1zmpMF
         3vBg==
X-Forwarded-Encrypted: i=1; AJvYcCV7dl98Ch89E/iDVJpcGfd74eZ2WFm4eNt9cRj8gJZuttn+t/7JzHLbdo5ZJqcMN8ID2XG4fyZAUbiOGrc=@vger.kernel.org, AJvYcCVr9isw7ziqqJ++r3QKETxQGW3SVQ1vKNJAw101+jMATOvTTmyZrWjwwlV5P4+Wb2YBoLkAcXIx@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8Hbdd1e1VmBEdIurU0rutplDA4k4QI808qZy+Nflp5XXiP2sY
	1vBuDI3oMR7yKxMpS0Gal3e4ymyAePKYZp18oIY+yBxl5mh7uKsw
X-Google-Smtp-Source: AGHT+IFsICy/x7rYkuKy2qztiOq6RCLLEIBJUWxqtuE0iI2m5Lp8TdQo+oc2WacYGLVyapeEON025Q==
X-Received: by 2002:a17:903:32cc:b0:20c:b485:eda3 with SMTP id d9443c01a7336-2111af3d1demr182980355ad.20.1730726736456;
        Mon, 04 Nov 2024 05:25:36 -0800 (PST)
Received: from localhost.localdomain ([202.119.23.198])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-211057bf377sm60191125ad.184.2024.11.04.05.25.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2024 05:25:36 -0800 (PST)
From: Zilin Guan <zilinguan811@gmail.com>
To: davem@davemloft.net
Cc: dsahern@kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Zilin Guan <zilinguan811@gmail.com>
Subject: [PATCH] ipv6: Use local variable for ifa->flags in inet6_fill_ifaddr
Date: Mon,  4 Nov 2024 13:24:34 +0000
Message-Id: <20241104132434.3101812-1-zilinguan811@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, the inet6_fill_ifaddr() function reads the value of ifa->flags
using READ_ONCE() and stores it in the local variable flags. However,
the subsequent call to put_ifaddrmsg() uses ifa->flags again instead of
the already read local variable. This re-read is unnecessary because
no other thread can modify ifa->flags between the initial READ_ONCE()
and the subsequent use in put_ifaddrmsg().

Signed-off-by: Zilin Guan <zilinguan811@gmail.com>
---
 net/ipv6/addrconf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
index 94dceac52884..c4b080471b39 100644
--- a/net/ipv6/addrconf.c
+++ b/net/ipv6/addrconf.c
@@ -5143,7 +5143,7 @@ static int inet6_fill_ifaddr(struct sk_buff *skb,
 		return -EMSGSIZE;
 
 	flags = READ_ONCE(ifa->flags);
-	put_ifaddrmsg(nlh, ifa->prefix_len, ifa->flags, rt_scope(ifa->scope),
+	put_ifaddrmsg(nlh, ifa->prefix_len, flags, rt_scope(ifa->scope),
 		      ifa->idev->dev->ifindex);
 
 	if (args->netnsid >= 0 &&
-- 
2.34.1


