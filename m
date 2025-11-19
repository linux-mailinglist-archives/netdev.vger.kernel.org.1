Return-Path: <netdev+bounces-239885-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 263AAC6D954
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 10:06:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 787064E9485
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 08:59:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BAB332F741;
	Wed, 19 Nov 2025 08:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=aerlync.com header.i=@aerlync.com header.b="OuH49swb"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79B2A2F0690
	for <netdev@vger.kernel.org>; Wed, 19 Nov 2025 08:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763542768; cv=none; b=L+8O7bHas3ND/Fx6TndWi65NEB06Fr620iuGSD2iIwlmaZNPZ2M7G4v645v0+D5iKToNZJhINBkp0ca4G5XuKTd35hu5LcRrn7ecH7DxtyAd5umzlNT2m2o33XQCP5UGeUwJH9KNz5Si+uKnx0avYhShOLLlT7nfMVrAGmPeWW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763542768; c=relaxed/simple;
	bh=RKLxG41FnFXQIfi8o1s4opveJYqoL6GYWWf8XO/U/7s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KuKNlqyQjuAi3UJlzccg1na6emEXpSjTlRbtXM0riCCgFjzSBLm16TSMcax5WQNXTIs+Fr2Px+Pn8Fio7/6rQB/DVZDbUFv77CvsMk2hEht2tm4L1uXUPmGcyui0YzYoOTK97No3IQtCW4muNz3ADoZQmZxP16yKeBHwpeP+XNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=aerlync.com; spf=pass smtp.mailfrom=aerlync.com; dkim=fail (0-bit key) header.d=aerlync.com header.i=@aerlync.com header.b=OuH49swb reason="key not found in DNS"; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=aerlync.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aerlync.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-34101107cc8so5626425a91.0
        for <netdev@vger.kernel.org>; Wed, 19 Nov 2025 00:59:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=aerlync.com; s=google; t=1763542766; x=1764147566; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mox5WyuD4uLfefjWS7CS2rqtyuV+iYJhhA9qwxlBVzI=;
        b=OuH49swbAMXq2ckyL+ZeZGIpb+DN4fij4DBMjeL2j6IXHXJkspMJO0BmGEm79uMF9y
         vJBp8O/Y1EWE72V1E8jYcWPl4UJeAoTiPyxsWEnEeVwFvRvxhwV655B5l6DiDuJRnjYn
         mP1pITAvfDf9joV/gSBQJl1RNFAGCksVzEaNPDNUvgXvF2mQVXun/rRDmnWCuYQ22O8H
         /o3IZUXjkYAMDTUF6X4tSzC4RnV095pk3fMxt2K0652XL9RruaaVpE1NqQ8sLiOIhto2
         rCY5/BxE7V9ErNwPSgnTwioVkuxxEeDAG/6IDucjPO8A0uhdQyFY4n80YW8pqf/jAlmz
         1ZhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763542766; x=1764147566;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mox5WyuD4uLfefjWS7CS2rqtyuV+iYJhhA9qwxlBVzI=;
        b=AzghNQVvrBXYjPxts4pXouhX66nyObT2e3R+HyPimbMZRqR2gSrseSP3ji3ucFr8UY
         3LZrSvbwFQFj13N/NbcZZuBojk9E1p+L7VmuJhDeIvDNdnLkAVQo8VAAumh3qnxpo4ep
         WVrSUH/FpDwD3h9OBvBc0mwxzpzKm9rewZ54RSEvCCRTy6Bomn7W03RCC6NsumNWwKlt
         ZV4bBY3SkOGps9bHiw6iKf7ZiDoOxoMEIFfmYkqnt/hehhx1ulPQl1JmFj1FjGksBtEP
         wNaUozK52FHFQgu5aLs9GMX071Nk/5dqoknXeLGJRzBHm2AGwOOD0e5YAYjGlWYWar4q
         zHnA==
X-Forwarded-Encrypted: i=1; AJvYcCWCLIahVwiwH13fNjihtayy9avTfQL8dBvPoFo01DaiMrfFkRel+JoFtgte/Ga8s5/ZRDuf6Jc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3nZsackf37qx0khK4NWs5ERYmuKi4MHMs1XYsyc1nswDL6QhB
	bOdxS7WRQ1+s7iBiGnGI9urYiXtxtJtaNVKlL9TliEUtjm7xjMy5SzhV+2JaMdVnhpI=
X-Gm-Gg: ASbGncsd9RN0XagL7i2sC7mZ3L/0LY9af5WD6LZvcOk+cAeX8PR76B/N+SKo999Cem3
	+jvfUh/h8gCPWhWuj60XxBfl8mSQrHSGz1r5PirouxbRlQSPU9+5cDesgw4j847fNvIfeD9HkT3
	abFFHr4uuh8EKwF+hfC+XJUuLKJCjpCRk2Qx4QyV2aVJ8ztpfA3vyi2uAfJmLqj2snslNIEeTzU
	8hPadh4bpuqTxVt1fJM9Px15zLiVU+6NCBGkmMmbuUo0MUPISELktcAN2AgNrm2khDZtdXqXNJo
	4RYDVQ2qHk5g5HJ+4TLK+yEkVgitM2dAYxUObQuaKMrTAAKc8G8rfDhP6WIpmFp+tSzMw2RpBzS
	pnA/MdPockh8tcQdB1oYEgmELQvxhTkvo0j9ffVRH4P3Y7jgzPanH4k6hRwXZcU0l7YhCv0L9hp
	4dChmdNClWMNg7loi5U1PmHYkXa5JKNjmWAiJEwcRvnMlRvmS6xjX/
X-Google-Smtp-Source: AGHT+IHpf/cvIVYj+8zZr8hTZ+FrOoI5zW7ZMpL53W7VWVFV14N/Wk+FfGc2+kOiUFyMKQjkc5ih2Q==
X-Received: by 2002:a17:90b:4c4c:b0:341:133:e13d with SMTP id 98e67ed59e1d1-343f9d91d64mr19751848a91.5.1763542765852;
        Wed, 19 Nov 2025 00:59:25 -0800 (PST)
Received: from localhost.localdomain ([103.82.77.153])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2985c2348afsm197918535ad.3.2025.11.19.00.59.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Nov 2025 00:59:25 -0800 (PST)
From: Sayooj K Karun <sayooj@aerlync.com>
To: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Chas Williams <3chas3@gmail.com>
Cc: Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Sayooj K Karun <sayooj@aerlync.com>
Subject: [PATCH] net: atm: fix incorrect cleanup function call in error path
Date: Wed, 19 Nov 2025 14:27:47 +0530
Message-ID: <20251119085747.67139-1-sayooj@aerlync.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In atm_init(), if atmsvc_init() fails, the code jumps to out_atmpvc_exit
label which incorrectly calls atmsvc_exit() instead of atmpvc_exit().
This results in calling the wrong cleanup function and failing to properly
clean up atmpvc_init().

Fix this by calling atmpvc_exit() in the out_atmpvc_exit error path.

Signed-off-by: Sayooj K Karun <sayooj@aerlync.com>
---
 net/atm/common.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/atm/common.c b/net/atm/common.c
index 881c7f259..c4edc1111 100644
--- a/net/atm/common.c
+++ b/net/atm/common.c
@@ -881,7 +881,7 @@ static int __init atm_init(void)
 out_atmsvc_exit:
 	atmsvc_exit();
 out_atmpvc_exit:
-	atmsvc_exit();
+	atmpvc_exit();
 out_unregister_vcc_proto:
 	proto_unregister(&vcc_proto);
 	goto out;
-- 
2.43.0


