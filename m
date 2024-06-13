Return-Path: <netdev+bounces-103113-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 57A74906542
	for <lists+netdev@lfdr.de>; Thu, 13 Jun 2024 09:35:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E1859B22FC0
	for <lists+netdev@lfdr.de>; Thu, 13 Jun 2024 07:35:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D269013C904;
	Thu, 13 Jun 2024 07:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A5Vvo0jz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E903713C8FF;
	Thu, 13 Jun 2024 07:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718264092; cv=none; b=N9nVR+TeVJZcZhguVZtYPzf8iZI52ErJ8V5BtIC1OJWc+zMx6957Zlfu7My6cnX69ZcBjXJiB1JAdXNeHgqFmUgLM4XqzuAUDtdmahUw3JHLzU0d75bFa00J3Q24vilvPfauvTvbpJu8LUL8O4ZpiZGa1/kG3FxaHwEnrgyMiII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718264092; c=relaxed/simple;
	bh=jgULLhu5IvBh4a9OytyFlWTFX5Otdlwllt0KSe8RJV8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=APOKUqQ+bxCaORHWFxURwJbR0EHqI/fhfOKEZ7nEVeKbd1afgwWNLh/wOx7fvRRVdVYFHP0XbV6zsHQXsHqUgMUr/K24ISDndenkbFxRN50X5u5t3QCoe4L/s1vAdxpJ1cfJBbHFKVZUn6hMLww/M785+oXv3n6fYiE0th2P8qw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A5Vvo0jz; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-7024d571d8eso563826b3a.0;
        Thu, 13 Jun 2024 00:34:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718264090; x=1718868890; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vEo7Qa1RSYsG3o+jOD/UVcH9RHS8MXsBnArA3BE9OsE=;
        b=A5Vvo0jzXm9v6JJr7OQf0fw0GXhKicnnPsBm0ale7iqHIN/HPz342WlDCpfocev89V
         q32r9WHzjobAchM4LwoGRkxH1BywY0V1sxPjboaBSgPr84rHSRZp3RLkBYKTPHX5ZE8w
         81tHopr8PyaxmUYuijNFZinw9A+P2+IbnQvj4uO2Q/0WJSv8xNYMNj21bk5e7Aq4aMDL
         lw0moTvyWHF1rSCTo9/+LmK4oBD1Sax7vLP5XWabv4X8GrYds+A71FMh9CUy++oT6k8b
         uRE5m+U82kcpJ2n3rZt399aD/crFpXvqPmm+nlh9J//yKlSXDcEYMAdLoyu9cdjtFck6
         exqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718264090; x=1718868890;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vEo7Qa1RSYsG3o+jOD/UVcH9RHS8MXsBnArA3BE9OsE=;
        b=Cwe0Cvi/0BvIe67JwVHQZVZ5a+Us/TkT6PvJxqMtoca2GmLx4xEDmJlmwAJz0ikqYk
         fmBaaCOcmlh+/k2FQijFZvw0Wkv4nnRwjvFitaKG+lfdKGoJ51Tl3JIPpk8aYx+0Sq7v
         y8ZX7TN9Kr9o3xdhlIbd9GKRsVwkGCqrikQjl6b1P6kqGrT/jSSA5+IXzzbfBrUifBKl
         c3kwdqHrVX02Z2lqS6crBcqsWobvT85UAySBsi7QrmVO0BIoPzauDHmXy3uwMvU4hN4+
         raNuyNWNkavsxMjbLKE+Z5Ze+JBwMYei7Wpgf4KaZuJNbHE3xdeFcoAjvPx5O6LKac+j
         OSvA==
X-Forwarded-Encrypted: i=1; AJvYcCV8lm/gnweiV/olHFCfTWCKbvc1zjRBA6rqlmaz5ppk5zv4yPJVx7kDUfMBhBAiyGUipQGoSNQ+awCrylKzudJTupnlVLJ0S6YPctrJF1H/29CrjjESJsu64m1K5PE3gtSCASKQ
X-Gm-Message-State: AOJu0YyY/dZ/YqySiJjsD91VwMZAN3MjmYe5BBSO/+moRjVFcFbZhpX7
	TGjc98A7xQigKxMVsW8k3lkBvPcCanxDjOzU6LzGcvy3lVXF11xa
X-Google-Smtp-Source: AGHT+IFiB1U1E5uL9h1zCG8GC9z83TgIRPvwD9xgOPuooCxmaMDIsE/QwJPXdpjQ/lewn55vZzz2yA==
X-Received: by 2002:a05:6a00:2d25:b0:704:3aca:7833 with SMTP id d2e1a72fcca58-705bcf09c2cmr4617248b3a.31.1718264090067;
        Thu, 13 Jun 2024 00:34:50 -0700 (PDT)
Received: from gmail.com ([2a09:bac5:80c9:183c::26a:4f])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-705ccb3d19esm715562b3a.122.2024.06.13.00.34.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jun 2024 00:34:49 -0700 (PDT)
From: Qingfang Deng <dqfext@gmail.com>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Joe Perches <joe@perches.com>,
	Qingfang Deng <qingfang.deng@siflower.com.cn>
Subject: [PATCH net-next] etherdevice: Optimize is_broadcast_ether_addr
Date: Thu, 13 Jun 2024 15:34:41 +0800
Message-Id: <20240613073441.781919-1-dqfext@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Qingfang Deng <qingfang.deng@siflower.com.cn>

Like is_zero_ether_addr, is_broadcast_ether_addr can also be optimized
by using a 32-bit load if CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS is set.
Sign extension is used to populate the upper 16-bit of the 16-bit load.

Signed-off-by: Qingfang Deng <qingfang.deng@siflower.com.cn>
---
 include/linux/etherdevice.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/linux/etherdevice.h b/include/linux/etherdevice.h
index 2ad1ffa4ccb9..23b9cc5e299d 100644
--- a/include/linux/etherdevice.h
+++ b/include/linux/etherdevice.h
@@ -174,9 +174,14 @@ static inline bool is_local_ether_addr(const u8 *addr)
  */
 static inline bool is_broadcast_ether_addr(const u8 *addr)
 {
+#if defined(CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS)
+	return (*(const s32 *)(addr + 0) &
+		*(const s16 *)(addr + 4)) == (s32)0xffffffff;
+#else
 	return (*(const u16 *)(addr + 0) &
 		*(const u16 *)(addr + 2) &
 		*(const u16 *)(addr + 4)) == 0xffff;
+#endif
 }
 
 /**
-- 
2.34.1


