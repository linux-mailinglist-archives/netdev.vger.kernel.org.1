Return-Path: <netdev+bounces-140633-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EDE39B74B7
	for <lists+netdev@lfdr.de>; Thu, 31 Oct 2024 07:51:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3A997B2401C
	for <lists+netdev@lfdr.de>; Thu, 31 Oct 2024 06:51:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40BFC14430E;
	Thu, 31 Oct 2024 06:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YOkQxazQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 661FD282F0;
	Thu, 31 Oct 2024 06:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730357497; cv=none; b=MXAQ7rm+ZMcoLwYwxym45OyBgZ6yATIVD+0yPmBVkVLOGZDGu6gLgJ/r0gAA6ExAqty/+Rfhx74ehcY60YoWoT0eE0X5GYT1FpkEHZxcSQnjvyBeHlqypzFhy3k3xEiGdJjS94EfxPY+2HQ1iiRByZMfNBKfYTk5vuoy8+hATCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730357497; c=relaxed/simple;
	bh=1KU0RTwAvUZiokGeeJPgZq+44cF0Y6z41yqw6rmZAFY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=gVUw5vNjByKgrNEUHhhwDsJ/G7uzKS2dqlvJk5T0I+jg8By5NwUAoAwEKCybr6Sn8j5uWkg53zJv0d56US5G3y2g4OurtqdzTtlNZ4tOqhgS13Nmghbtla1bGjgduPSG02DxdURVc+w6br+03gozpJJ6us/M1Ow/Fx/vQulEFlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YOkQxazQ; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-20c7edf2872so13188625ad.1;
        Wed, 30 Oct 2024 23:51:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730357495; x=1730962295; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mixF7vpLf4xPO/TJEqzW71juqB0qqrq4k/61RZiAI+E=;
        b=YOkQxazQJkQcnXbRJZTSgtWG9mo2M9C//YouoQsxrwEPIVauWaH/ABaTU4C3tvlle7
         fMjikrwrr+Lodtrgl7IGly+1z5itfW1gfOOTdQkRboqn8Do/M7IU+ETmgUxacNWwagdo
         I76A63dWsP8HlrUCd3eQ6EjtmODoPpvwnSXejLontTSIQN9wr8gOXXwxhURWr237gmS7
         S2HB8YoNW4HHjTkLKdsYeYvPjr6q8cmC1w3PqDECAs/tlaF1rxzcOdfyNijpd1UbOsny
         8mt0eDlS/hYwnlFtWhGdZ/gmqHmXMLqU4I9XvzZEzlFuXTIuGLYAJY9Z8xDBCbveZGBl
         fCmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730357495; x=1730962295;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mixF7vpLf4xPO/TJEqzW71juqB0qqrq4k/61RZiAI+E=;
        b=ueSUv7sZ1DGkkyBWuddlavGcL9jLdHc5/5EqRgUUFpF/YtfmdmKXjo7y5Bm4bxPtr9
         MKBemnLeyRzcPp0C3mF0fQ+rcFq9u6RMyOpPJr+KhZ8DtgK6JqGC2K174mQfhMS46GKv
         YJwBU4wVDBdS5tYkvQwZQD8nPNKGegvjPVdAa5MYd8AB+9THi+U6Kp8rccpn33QTKAyS
         CvrMaPvkzwA3FTmw5gN1ZqTSvIFB9IluttAYT+illJR9Wy0tIwnD7TCNXBKZBDDxQHtl
         F1lolbxE4Q+Ld+3O8jSSuJusrAZ0KEWl9EQmHKxFqXNGiemitdlUsUJ+Uh6x/o/Qvs64
         uk1Q==
X-Forwarded-Encrypted: i=1; AJvYcCV27SVd4aYWZ+wIsp1kLZej3l8aZedxuHbPApyhEKempI4HgpVTK9EBZycVLh+6jhbCDViSm4pN@vger.kernel.org, AJvYcCW1MNC53Km+no2BqgjpI5870EPs1eIqPZXjJHmFB9m4zux7RsBSJ4OmnA25hj22sCrNj5XwdvgSUDHNAvk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzqK2Ofa9ZYJ1BckdS8t21lFm5BKIMue9Iq+Ce+LOmhy4NxuqjF
	MUpYR9EZu5znSAEIu6dfaKclOmAGlhTiPdL1FzOajepODBZLRhuRo12tvoQXxV4=
X-Google-Smtp-Source: AGHT+IE4e7Hcho9hTpGO6CPaSuhsZhcHLcNa5wsaMmJ/AG/+Ll4TfRwI77tH1AADo+DYFnwq82Ro5A==
X-Received: by 2002:a17:903:32cc:b0:205:5d71:561e with SMTP id d9443c01a7336-211057a8f8amr19933085ad.26.1730357494565;
        Wed, 30 Oct 2024 23:51:34 -0700 (PDT)
Received: from purva-IdeaPad-Gaming-3-15IHU6.. ([2409:40f2:e:4b75:a7f4:68e1:fad8:f425])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-211057e7a69sm4807055ad.290.2024.10.30.23.51.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Oct 2024 23:51:34 -0700 (PDT)
From: Suraj Sonawane <surajsonawane0215@gmail.com>
To: davem@davemloft.net
Cc: dsahern@kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Suraj Sonawane <surajsonawane0215@gmail.com>
Subject: [PATCH] net: ipv6: fix inconsistent indentation in ipv6_gro_receive
Date: Thu, 31 Oct 2024 12:21:24 +0530
Message-Id: <20241031065124.4834-1-surajsonawane0215@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix the indentation to ensure consistent code style and improve
readability, and to fix this warning:

net/ipv6/ip6_offload.c:280 ipv6_gro_receive() warn: inconsistent indenting

Signed-off-by: Suraj Sonawane <surajsonawane0215@gmail.com>
---
 net/ipv6/ip6_offload.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/net/ipv6/ip6_offload.c b/net/ipv6/ip6_offload.c
index 982216342..e4c3ab837 100644
--- a/net/ipv6/ip6_offload.c
+++ b/net/ipv6/ip6_offload.c
@@ -277,10 +277,10 @@ INDIRECT_CALLABLE_SCOPE struct sk_buff *ipv6_gro_receive(struct list_head *head,
 		 * (nlen != (sizeof(*iph2) + ipv6_exthdrs_len(iph2, &ops)))
 		 * memcmp() alone below is sufficient, right?
 		 */
-		 if ((first_word & htonl(0xF00FFFFF)) ||
-		     !ipv6_addr_equal(&iph->saddr, &iph2->saddr) ||
-		     !ipv6_addr_equal(&iph->daddr, &iph2->daddr) ||
-		     iph->nexthdr != iph2->nexthdr) {
+		if ((first_word & htonl(0xF00FFFFF)) ||
+		    !ipv6_addr_equal(&iph->saddr, &iph2->saddr) ||
+		    !ipv6_addr_equal(&iph->daddr, &iph2->daddr) ||
+		    iph->nexthdr != iph2->nexthdr) {
 not_same_flow:
 			NAPI_GRO_CB(p)->same_flow = 0;
 			continue;
-- 
2.34.1


