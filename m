Return-Path: <netdev+bounces-195153-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BE7FACE73B
	for <lists+netdev@lfdr.de>; Thu,  5 Jun 2025 01:37:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6404817350A
	for <lists+netdev@lfdr.de>; Wed,  4 Jun 2025 23:37:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B916272E7F;
	Wed,  4 Jun 2025 23:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JsG83wOb"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC3984C98;
	Wed,  4 Jun 2025 23:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749080221; cv=none; b=hTPg3rB/X1iOKZCdGM34Xji27ALDCY307U5tZzRY2q1VmIHQNQTQnKq4aNAqPZu6+YQR7zmPNU1NrPbrJDUdQk7F95Te2ejNHTEU5afgEqr1aCMir6B7KW0g14u0YRNMfA1CnHg9GNZHxyJCtyocgyfA5c0/lzVUtv1VDZynfFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749080221; c=relaxed/simple;
	bh=JjM2XMlc+zdtPl9efpk58oVX9710joZ/taNOZEqLTvw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pCgzDm+O9UOzIXm5ajjSoxk2QgTLsoKB4/dOR7yXCVsvPZTzuw1EEunlKRI3h3ApmsfmyefEqmI5+l9o/B9luzjiVMxJ6wtSVfab3UEf6IaEOuhmXhToSgWDvzJvmMVMs7kv8qLpvwGwpa5RSfMclglyVauhuHgdEbH5m1oOc8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JsG83wOb; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-70e5599b795so4655727b3.3;
        Wed, 04 Jun 2025 16:36:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749080218; x=1749685018; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gBRqa9U/2heZAUJZPXCb7LrXPxk4R2Wa7FOgeDBgosM=;
        b=JsG83wObbQd7kL3x44olog56TSSztjEF1Ijn4RHKx8g+mDjGO4J4tcgR44W35MeFv8
         hoHuGoLpAv9q6lXvi7y4y0uxo0WuWO1WUSwuPfU/kQLk5EohZ+7RNxTL/HvZT33A7e3F
         Gi+yOpZMOGWBzx/PCXlKIksnJ6kpVPnGNYIae48U4M2V7mNLHWCN5PGwb70tkfgOOIsB
         F/rawiLiBJCqSwRH4PFdP3unBx/Nuyu71WoT83syg6iHsY4kmBUsCj60Z/vtnsSO3yT+
         mPSbxrDXMBUE8ibRdD1E2OnRvF6G/DmLzzFBJ6ENcv/YWkGmJicpE+LV4jv3LF1kpQJL
         21Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749080218; x=1749685018;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gBRqa9U/2heZAUJZPXCb7LrXPxk4R2Wa7FOgeDBgosM=;
        b=P8xllGd9JCD7oDHnXs3aqhzUV6slOV682Pbt9by1ezTtiTb97ZVSz8uPHZfU/ssH+U
         21INezQThvmPOYOHji1s5/pD9u6Syn/05aIfgsJn47Jwqwc5a3mdyo2KRqUqsR/m6dUK
         aYM1g3ZKAfjB8sOuUjzx1wbCSHMXQF8R5s6X8ZjYtHqxMq94H7tFpGMLdp8/Xo+hF0su
         JL6IiJaqs3RfqQ1VMfbcaJRyiKFN7B7aE0bRljHa6X5wgBm7VOqIxOuTW14UB91ooRS/
         hVdo8UHXZfpDabBTzeCkdhyuQCguPWdR8S2SZXy5fs9l+peJIcRcFkHtTujrp88+iPjf
         9sYg==
X-Forwarded-Encrypted: i=1; AJvYcCW/U5wbHzoiN85A/EOaulBvQklyh+2KXmDdvCxTG7l4ApgFLzkqTCPJX8vykZkzCuSqS0npAkiFafi/8P4=@vger.kernel.org, AJvYcCWTPbTCx/qmT2tls3U5DpFAVQaYAgITQFQtgmKGbNd+bK+h//gcuSJL4xSaVbdEWv3aFa0Q7zYE@vger.kernel.org
X-Gm-Message-State: AOJu0YySLIYDiWKNufeFsLF8fbIVeS8oRh6i006CN1Sa764R14jQJzKw
	VfLHdJtqKSr32hpXSYLQ36k0CSwOHcSg+Xl5PCGBhtPXYdKjioqY6vWh
X-Gm-Gg: ASbGncuFWR3KQvhLwBl3NGHr4Ieu/lGyqO0Xm9FUj0QqI3uBt3BT9ElzNJOnRn1Y3DS
	/sxazQVyMajGydlebOAC1NLwk/xU1RBbDsWi0EROFK7TlfQj/eaZeDMViw9KAS4ZzC80WFscp4c
	0Ih4V3icSMewHNQt3LuiNxA2jRAJnPlz0UH/ZiZ+1Mitrn/dICoGzYxxQ6jnPFCdS5bb9TNRop0
	FokD+XtqJNi6g2JUCgZFFOnv3Q1wI8awI4Cz/gy+UudLj9eCMdS0TuwA5MyX2QWcVmsCc0dlOnm
	XRHdXCplyOXJIry4Zm3eB4Ouw2e+EVqC6NjOSxnPds/JYl6A+H/7XASuW8kGRjwPuRZHp5WiEGN
	EMTc7vbBZMKE=
X-Google-Smtp-Source: AGHT+IG84WFtztMkrKBWhzmHd8MsAsgBDrOouQY73izuVIVBEUYmm2gffzeGDeXrH0VDTDPQsmMGvg==
X-Received: by 2002:a05:690c:7092:b0:6fb:b37f:2072 with SMTP id 00721157ae682-710d9f3120cmr68548817b3.22.1749080218488;
        Wed, 04 Jun 2025 16:36:58 -0700 (PDT)
Received: from localhost (c-73-224-175-84.hsd1.fl.comcast.net. [73.224.175.84])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-70f8abed2basm32224477b3.36.2025.06.04.16.36.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Jun 2025 16:36:57 -0700 (PDT)
From: Yury Norov <yury.norov@gmail.com>
To: "Jason A. Donenfeld" <Jason@zx2c4.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	wireguard@lists.zx2c4.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Yury Norov <yury.norov@gmail.com>
Subject: [PATCH] wireguard/queueing: simplify wg_cpumask_next_online()
Date: Wed,  4 Jun 2025 19:36:55 -0400
Message-ID: <20250604233656.41896-1-yury.norov@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

wg_cpumask_choose_online() opencodes cpumask_nth(). Use it and make the
function significantly simpler. While there, fix opencoded cpu_online()
too. 

Signed-off-by: Yury Norov <yury.norov@gmail.com>
---
 drivers/net/wireguard/queueing.h | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/drivers/net/wireguard/queueing.h b/drivers/net/wireguard/queueing.h
index 7eb76724b3ed..3bfe16f71af0 100644
--- a/drivers/net/wireguard/queueing.h
+++ b/drivers/net/wireguard/queueing.h
@@ -104,17 +104,11 @@ static inline void wg_reset_packet(struct sk_buff *skb, bool encapsulating)
 
 static inline int wg_cpumask_choose_online(int *stored_cpu, unsigned int id)
 {
-	unsigned int cpu = *stored_cpu, cpu_index, i;
+	if (likely(*stored_cpu < nr_cpu_ids && cpu_online(*stored_cpu)))
+		return cpu;
 
-	if (unlikely(cpu >= nr_cpu_ids ||
-		     !cpumask_test_cpu(cpu, cpu_online_mask))) {
-		cpu_index = id % cpumask_weight(cpu_online_mask);
-		cpu = cpumask_first(cpu_online_mask);
-		for (i = 0; i < cpu_index; ++i)
-			cpu = cpumask_next(cpu, cpu_online_mask);
-		*stored_cpu = cpu;
-	}
-	return cpu;
+	*stored_cpu = cpumask_nth(id % num_online_cpus(), cpu_online_mask);
+	return *stored_cpu;
 }
 
 /* This function is racy, in the sense that it's called while last_cpu is
-- 
2.43.0


