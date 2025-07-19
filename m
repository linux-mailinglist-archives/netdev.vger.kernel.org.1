Return-Path: <netdev+bounces-208332-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6758CB0B0C8
	for <lists+netdev@lfdr.de>; Sat, 19 Jul 2025 17:57:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A6F418960EE
	for <lists+netdev@lfdr.de>; Sat, 19 Jul 2025 15:57:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CA3E1E0DCB;
	Sat, 19 Jul 2025 15:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DA59yGsc"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D77A1862A
	for <netdev@vger.kernel.org>; Sat, 19 Jul 2025 15:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752940634; cv=none; b=fdFjPArlZZhUccuWT6ylmYdRcWPLstq9gdllG/9kyA9OhKsWIgkFedXHtnDRLlpgPzALDSdWUozU1RN1E3WoOzsRyZZxg+2W77fbORAeehByHkclzZYs+6XEKyQhsWjWLcMt78a5uKoo2PLIDb29F1t6LYl4UNEmD9YTrJCrw/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752940634; c=relaxed/simple;
	bh=8ZmHTMzdzJWW8l//MP5bYP5ZTsGv0sKZSp0fif8BxYE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=GlXYoBg541YVYeTc6IlheusR5Qbk0KII60FqlEhIJuA4k4vPUrpy9SQErrgjI7dxhZmGgW/jyy+oc0seQx8H84gigzLJnesLi18/YdP16Mr3koNTwzfz0PhHz3hcllJA8AXoxIbHQg0JQzv94/EpBDI/B7B3bAbthF/cAUg8CTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DA59yGsc; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-553b16a0e38so2730566e87.1
        for <netdev@vger.kernel.org>; Sat, 19 Jul 2025 08:57:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752940630; x=1753545430; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YabWw2GQsU48bBEwQ0juEK8dQ1heIt75lW1SGo1qck0=;
        b=DA59yGscbA41hIDyGi9eXzuUTv1lFtU4LM7YslJokgrShrqhFDIFHSEtWBJByOgrYr
         rQ1ZlDWFOW/0z14oc6SfmXcPLBovegh4B3Mrmg/M88s28QK7vupikETvMpywEdfZz7c0
         Dmvp37r3qpeOZ2C4WQNq9bFcLqKJa0liB6rku0pGPEKbJR7BB24X+FLpILsYvCpnCUyW
         zmX+IC1wSbe/pyy2/ykKKTZqrMNQ3JMhKVJfZmeYkvOJG4eHWET4kAlbStXm3xnWEw2P
         AYke9Ax0cOY14KtqwrXRSAIPYJxgIXEjC0K6D678vRAgmJDGB5Bf8QYHvgTtopT6tGXW
         xTnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752940630; x=1753545430;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YabWw2GQsU48bBEwQ0juEK8dQ1heIt75lW1SGo1qck0=;
        b=SunlTG5ayt5FLLIhVFkawdNLy6n1pOUWyLgeMwbcdKz4tS5Mrj2Bvxz9mq70Z4oU/0
         XXDcBZxCyIYv6JgRdqYcSI6chSbQqum+fbW1g4AJtCeZNugJfcxzjNbo8Ia0D2e7kuWn
         p0kYRRP7mL1FR0mKHfWA2b6dhF2SWuE4C2Fg1E3kv7mCM4GePaeeh3Cxexytv6qvlifQ
         fIY28wsnrmKNvaQatOzcmkrNp0l8MbGynod0zriGsEz8riYvZK7eFLOFWKrfZWttKHYi
         R/OUBXjpuI5FZYMU7pJq167xRV5KxbfiWn/ojdWpHwCiS+PuhHHQCeOMasHiBgP452We
         8+aQ==
X-Gm-Message-State: AOJu0Yz4nlQvBgqEPOY5pxAaYzdB/vNY5gCA5LB//cak8QBjw5IZnR+r
	S7a34K5pkm/kQg8ygEOPRMEgVaS+x3b9yw3czsUO1PYm9atd66wjVgHfq6h0PkCYGpA=
X-Gm-Gg: ASbGnctRSyxr2JNCFUTOvE/ZCz959TKC4/C5uhxWkNi9Lb98YsCvO/NPytH8rP0Cuo0
	kQPYD38zigQdW86TJUMz36Ewb1/qflm6M5agXAm84K8JFcNi/r7acx9BFKDwZj9H6fY2HSm5a3F
	f0s5GzwKc88uTfDpBTS42HDM9uHTETfGor7VwyZIGt/4lqy0tm79dIFqdN0fpK66Yt5wq4udY8L
	ka6dPUr3OvKR6MfMPhF6pyZJ+5rwwo8Y7iQdLspKGauHs4z/pW8OBiR1w8ZXRRdVwIoYpbcPpdq
	VRYgAhov5cT4nQngfrBoUsS7Qa8tuzBKQ3ETDV3N8lLqZXIPR17rr5PqxskIBI9tSt+yw/eKDpn
	MNjKvuWlyMwqE4YEHtwECdVIM9cYjwsppShvZKg6THqFI+2VeNr22MO8CQ+Tm2DOmq/HKkh1H
X-Google-Smtp-Source: AGHT+IFXiefnqbtNzFHbvAQFYU7+F0PJVMZMLWD26EFFDuzsR9eohOdAab1iIOY+suuIcWSKSipAJg==
X-Received: by 2002:a05:6512:68a:b0:553:390a:e1e3 with SMTP id 2adb3069b0e04-55a31897a91mr1590445e87.44.1752940629933;
        Sat, 19 Jul 2025 08:57:09 -0700 (PDT)
Received: from lnb0tqzjk.rasu.local (109-252-120-31.nat.spd-mgts.ru. [109.252.120.31])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55a31da2c8csm756348e87.184.2025.07.19.08.57.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Jul 2025 08:57:09 -0700 (PDT)
From: Anton Moryakov <ant.v.moryakov@gmail.com>
To: netdev@vger.kernel.org
Cc: Anton Moryakov <ant.v.moryakov@gmail.com>
Subject: [PATCH iproute2-next] ip: ipmaddr.c: Fix possible integer underflow in read_igmp()
Date: Sat, 19 Jul 2025 18:57:05 +0300
Message-Id: <20250719155705.44929-1-ant.v.moryakov@gmail.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Static analyzer pointed out a potential error:

	Possible integer underflow: left operand is tainted. An integer underflow 
	may occur due to arithmetic operation (unsigned subtraction) between variable 
	'len' and value '1', when 'len' is tainted { [0, 18446744073709551615] }

The fix adds a check for 'len == 0' before accessing the last character of
the name, and skips the current line in such cases to avoid the underflow.

Reported-by: SVACE static analyzer
Signed-off-by: Anton Moryakov <ant.v.moryakov@gmail.com>
---
 ip/ipmaddr.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/ip/ipmaddr.c b/ip/ipmaddr.c
index 2418b303..2feb916a 100644
--- a/ip/ipmaddr.c
+++ b/ip/ipmaddr.c
@@ -150,6 +150,8 @@ static void read_igmp(struct ma_info **result_p)
 
 			sscanf(buf, "%d%s", &m.index, m.name);
 			len = strlen(m.name);
+			if(len == 0)
+				continue;
 			if (m.name[len - 1] == ':')
 				m.name[len - 1] = '\0';
 			continue;
-- 
2.39.2


