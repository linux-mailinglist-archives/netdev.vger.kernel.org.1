Return-Path: <netdev+bounces-250837-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 06131D394DC
	for <lists+netdev@lfdr.de>; Sun, 18 Jan 2026 13:14:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 38E5F305CABB
	for <lists+netdev@lfdr.de>; Sun, 18 Jan 2026 12:09:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16C6B32ABEC;
	Sun, 18 Jan 2026 12:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aJNBcfU8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f67.google.com (mail-wm1-f67.google.com [209.85.128.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BCBC32AAB8
	for <netdev@vger.kernel.org>; Sun, 18 Jan 2026 12:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768738198; cv=none; b=TsEiEjf2ya6XCExRJUOky+NmhlKH/4RYX4CZxE/x9GX508I+CFcMQ3JLggXnHxxYKVv/jzZaPhFf224TT/9P1Css70q5R8IuNpfpo5mLZaejjoQl9iTQEv6TNgIO7wjztU4Oksboiyna3yMqW8Of4VH7kxbte1xbp+vytpalzkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768738198; c=relaxed/simple;
	bh=MW+N51v5WgRbDBiGoWVdusM1RQlch5ALs7Q29Ez16fE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i87uk6G0q2oR3jhQBGdTUE4Qm88xvNhSx19SIH3ncYMJ9aoPwcRtO9uTQMGTrC+LvHTViZ7fb6smS5jvPGocD+psgRxUEsIIoJGoDhV/qFegmLgxkDi8g7AdkLZSK5//RNFIuLo26jKhwinsZZDVIYG1dt0xjn3V+BdMzYmFREU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aJNBcfU8; arc=none smtp.client-ip=209.85.128.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f67.google.com with SMTP id 5b1f17b1804b1-47ee3a63300so31923805e9.2
        for <netdev@vger.kernel.org>; Sun, 18 Jan 2026 04:09:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768738193; x=1769342993; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GZM51dbvVuRPfudKUOjkv/I+szqU4KPnDbRK7ZQAV0I=;
        b=aJNBcfU8C3acq7NIw0b1X2BP5dwBcGzOdcjq6N7Z3nX8lFzLH25hC5azYZMyklwsE+
         YC/YdZ8Z/zJxieD1lh77GwPOOaEH9n6soKgRFdoDU/tOdK3DshkxLoLMJv03B6EfuNBH
         3kLsvcdffO6Y1iQ7UkDE8ydsbEPUg0X/OWU8oTdqlmga8m/cy5MBGtR3c2ELZgiYmVOP
         vY3Gv0G2/Ld/nOiISn75sSQZdMXV+Z+JjTvGWSiYyOv9C2ELp/hHbkJgrldN2kgQCmGn
         IZcLr0X1Zp/N4MuocML2wwHQzcJgpxa3L/fzARxzfr+67Eet8s/OHvHJZ/T1JnrXb4R7
         zsQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768738193; x=1769342993;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GZM51dbvVuRPfudKUOjkv/I+szqU4KPnDbRK7ZQAV0I=;
        b=I9HK24dyiA89o1kiYCJgsLFLEVqidjcYa9L0JpdhbR2iVNOTAIoQWTqovajUiV0J1Q
         k3CJgl9nmC2s/m982pW9OkHPdrQppgj7Doy1cm3mBbhvx8oPg1xnuSF+cuZ5Q31kOtmR
         lfDX8XyXYRj9YVa1+2oXMQJ78OL1lGrdZUToKqmcVC1HpUdzTAfEEDAXwRfzSq9Lt8+f
         3fUOnnVE+xNGOAzLWG2vArkwhXLp0+wR04a6cuUeR9xJ4wkVtwDPjfMQEXjd+Qvr3bPd
         x0Mxy/CXMnp/ZwRwhwoq2SMt+xCtEViRAOIKgeNs00Ue4N1VP+XereDH35fMd7Uiq0Nd
         HmsQ==
X-Gm-Message-State: AOJu0YwPYuTtW7Ec4vHH6eP3Qd66R8i1i72UevYqpwtyy009MBVSjrIu
	cCRKBRkH57fJF9wCf+z4oF9kOUXlQFGMip7T8xBiGj0B5YNv2Gi+gaCi
X-Gm-Gg: AY/fxX5X6xRSxcvvfat8cK+JNHnkJHJOPPE+7p2scbyXzg3BGuj1/YqCc82c1QUy78L
	Y0RMa0M02URbYkopnYLQxyPZAdmiDDbwvu9rFaJejuPYfHQS554mHxyGQTZoP93SvFZ7absxBSc
	dXLghkkdrCSHD2EJg/HJAkYlvw3CM3xb1TYwlxOeJgjgUGXND2NUCuhlZKt3qWX0HrJY6+i+ee9
	rZ0M2o7FQYaPN1LChftdPqCOhNJ809iWoGMC49ZkArHenRa1o/tdhyjFTARP8ah2gXLQlWjTiYu
	7yyB2UfVW9t+htljVIiU6zKBDH8/b6laH8IumRHLNjzBRxjYF7S5f0ymHaTZ5AWTl6TRldTYgyy
	xHyGmqARUiEmse/i8FwM1I97cQGZIkRPlLUFLN2+sjk0NOm0I5GcBL2RQ7wPGI9/AFm9PH45JDE
	7L5IwuR0d76I9KDWT1WxFgykUkCWUvVnTy93Y=
X-Received: by 2002:a05:600c:4e50:b0:47d:18b0:bb9a with SMTP id 5b1f17b1804b1-4801e34dafbmr99734575e9.33.1768738192676;
        Sun, 18 Jan 2026 04:09:52 -0800 (PST)
Received: from Arch-Spectre.dur.ac.uk ([129.234.0.168])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4801e886829sm138661265e9.8.2026.01.18.04.09.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Jan 2026 04:09:52 -0800 (PST)
From: Yicong Hui <yiconghui@gmail.com>
To: davem@davemloft.net,
	kuba@kernel.org
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	skhan@linuxfoundation.org,
	david.hunter.linux@gmail.com,
	Yicong Hui <yiconghui@gmail.com>
Subject: [PATCH net-next v2 3/3] net/xen-netback: Fix mispelling of "Software" as "Softare"
Date: Sun, 18 Jan 2026 12:10:01 +0000
Message-ID: <20260118121001.136806-4-yiconghui@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260118121001.136806-1-yiconghui@gmail.com>
References: <20260118121001.136806-1-yiconghui@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix misspelling of "software" as "softare" in xen-netback code comment.

Signed-off-by: Yicong Hui <yiconghui@gmail.com>
---
 drivers/net/xen-netback/hash.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/xen-netback/hash.c b/drivers/net/xen-netback/hash.c
index 45ddce35f6d2..c6b2eba3511b 100644
--- a/drivers/net/xen-netback/hash.c
+++ b/drivers/net/xen-netback/hash.c
@@ -3,7 +3,7 @@
  *
  * This program is free software; you can redistribute it and/or
  * modify it under the terms of the GNU General Public License version 2
- * as published by the Free Softare Foundation; or, when distributed
+ * as published by the Free Software Foundation; or, when distributed
  * separately from the Linux kernel or incorporated into other
  * software packages, subject to the following license:
  *
-- 
2.52.0


