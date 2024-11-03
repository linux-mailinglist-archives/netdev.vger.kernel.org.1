Return-Path: <netdev+bounces-141361-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 10FE59BA94F
	for <lists+netdev@lfdr.de>; Sun,  3 Nov 2024 23:40:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BCFCE1F21407
	for <lists+netdev@lfdr.de>; Sun,  3 Nov 2024 22:40:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 950BA18C932;
	Sun,  3 Nov 2024 22:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Na20sGK3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C25EE18C926
	for <netdev@vger.kernel.org>; Sun,  3 Nov 2024 22:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730673599; cv=none; b=mibjwrKnKSoilVrudKIH0+B/E+lVfol3yIxcNiMFlqgyY5xhHZI5aPsYyrzOJUFpkp3vy3muXgYQlCLjrjoq7tksBiBbh7yY/7+5Vjq2Jf84Iv6xcxaT/ivchhmItNdL/xstVIRWXAiZlW3p+1ji5Z5nUJTDMWg5gQwnIBrQcg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730673599; c=relaxed/simple;
	bh=OAxrLdyojVi5p39H76yKLSxrZDin8hkSxLWNAgmySss=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Z/EeFmA2yxcXz59DYEbinHiRa6vWX3RvBnIhrtnSceEeVtAUZelyd+PGW7qN1IhZKA5aEirV9KmS6v03WwJCp8Fhokfcnyt8r88cLVvnxoQHMaMXM6MnlYvBJDThMcnn4tOnWUSXjPFJ4dMV7VyKJRr2KN2zsfo2BR30EKMYu38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Na20sGK3; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-37d70df0b1aso2303407f8f.3
        for <netdev@vger.kernel.org>; Sun, 03 Nov 2024 14:39:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730673596; x=1731278396; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=L41euSJfIiAD8utyJ2Npiw+ZFCUzQcCksbd4ew9cGbE=;
        b=Na20sGK3jDu/9t4bSEZ/NI/lH03t1ZoK+L5/MltsgKrzTL36XS7Ow3cDYHyhsDzYcP
         WG1W5X5r1DlePGuFeQal/OWrLp3BjYDmwXNSi/AMiI2qNWMtf61+t/Ec1QlWVavg1QN9
         C0X/UdAAZ5k5gHAdif8VrPHWkff8rs86Zcg4yYAa3Xq++guECe4M4eC0LTs9bSPImWmn
         YvHXBwMKllrw6sgxI4L+O2WbzeQcQIkJAqZlGjLPYH3iJOMPGhnn05LhOGMAmF9Flwyt
         dshVTiy19XSVepaUm/X9FFyr6CG7CsoQXRKk4AuCE10G6OlHPd1fXqUJtkrpPPE3IZa2
         aokg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730673596; x=1731278396;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=L41euSJfIiAD8utyJ2Npiw+ZFCUzQcCksbd4ew9cGbE=;
        b=dOXRO+OKPki71XSILkVxvT1zEwq6kiFUi0TPfSxqsuD67zc1WoJVWniIj+brItwv4g
         SPdfwhCPDoXZzzgKCL6wlNhQ1XAjAj/AKK5YxyUyqbf3F6BlAxInQKpWWthYaCl9rNrA
         Wk2mXJC80Sh9isIV+iz5W9Ik+e/KOXUvIX1M/jaeXuhPTN727nt9rusd0psdAxXjPUfU
         Q5RJI+t7N6ylP9hXXEiAmWApiaIBRWe4cNTitwA+GxrO+Unw+nGtZ5uEZa4w73zf1mWN
         vTxAbgs7USd+h0TKFGtL6K38RG0AF4w/Z7eA5Lw9mUBqI4LgKepTUD3shmBZEoldRH+S
         C6BA==
X-Gm-Message-State: AOJu0Ywzk9JzYZUcrh8lWhjQZnxu31eAvGmrvLPF+RYF3vhFgcuowRCX
	V+2lc/Sf3zSrqkeK8rJfuYmqWGrNsbQDopBbKlpytYaJBQKOBUEuaJgf3g==
X-Google-Smtp-Source: AGHT+IER/kpIxdJ6miKHbYcwsCbVUgUtlezCn/y3w1wmGD9BuY7jZIsHgp6aAel2xzGyqOM8FEHmfg==
X-Received: by 2002:a05:6000:86:b0:378:fe6e:50ef with SMTP id ffacd0b85a97d-380610f16f7mr19053631f8f.5.1730673595837;
        Sun, 03 Nov 2024 14:39:55 -0800 (PST)
Received: from localhost.localdomain (91-171-187-56.subs.proxad.net. [91.171.187.56])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4327d685308sm133173695e9.33.2024.11.03.14.39.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Nov 2024 14:39:55 -0800 (PST)
From: Maurice Lambert <mauricelambert434@gmail.com>
To: netdev@vger.kernel.org
Cc: Maurice Lambert <mauricelambert434@gmail.com>
Subject: [PATCH] netlink: typographical error in nlmsg_type constants definition
Date: Sun,  3 Nov 2024 23:39:50 +0100
Message-ID: <20241103223950.230300-1-mauricelambert434@gmail.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This commit fix a typographical error in netlink nlmsg_type constants definition in the include/uapi/linux/rtnetlink.h at line 177. The definition is RTM_NEWNVLAN RTM_NEWVLAN instead of RTM_NEWVLAN RTM_NEWVLAN.

Signed-off-by: Maurice Lambert <mauricelambert434@gmail.com>
---
 include/uapi/linux/rtnetlink.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/uapi/linux/rtnetlink.h b/include/uapi/linux/rtnetlink.h
index 3b687d20c9ed..db7254d52d93 100644
--- a/include/uapi/linux/rtnetlink.h
+++ b/include/uapi/linux/rtnetlink.h
@@ -174,7 +174,7 @@ enum {
 #define RTM_GETLINKPROP	RTM_GETLINKPROP
 
 	RTM_NEWVLAN = 112,
-#define RTM_NEWNVLAN	RTM_NEWVLAN
+#define RTM_NEWVLAN	RTM_NEWVLAN
 	RTM_DELVLAN,
 #define RTM_DELVLAN	RTM_DELVLAN
 	RTM_GETVLAN,
-- 
2.45.2


