Return-Path: <netdev+bounces-245036-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 47B10CC5B67
	for <lists+netdev@lfdr.de>; Wed, 17 Dec 2025 02:41:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E8C29300D494
	for <lists+netdev@lfdr.de>; Wed, 17 Dec 2025 01:41:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBDFE251791;
	Wed, 17 Dec 2025 01:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zctc0A7l"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47D8222F76F
	for <netdev@vger.kernel.org>; Wed, 17 Dec 2025 01:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765935663; cv=none; b=ARGKKFxbfFEVCnutDAiEcVnwrWB9j+s1aIs3/0+CAmVz8KBcZ7asreIybHu84yhAM3jafpwfrm23h42jeH5if16gNqXq1VJ2vpLi3R3YDg9DJf+X7hRUM7p8J0WI7kYImdwg3B5/mYC/javu9dG31zOZLGQYKSj9YwvG6qrYgw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765935663; c=relaxed/simple;
	bh=8TyVSvKXYxR05iL0+NnYb0R4ktZ+w5a/caOd/UaYwpk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Xza7BOziv0qxYQLN3A35ZzAjy0Of04BS8YpcuLWgEu8Lnnd6egJS4d5uWNbhqKrVEEsx17tYeMZCQ8w9aLF5kYtdU54I9RlNsvw2OoxmLJHnehV5aE4SdUffiurbY+McQUAaNqtTM1hhVB8BAkkr1B1SiyrpyIsLcqj7bj5Rm/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zctc0A7l; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2a0abca9769so6524425ad.1
        for <netdev@vger.kernel.org>; Tue, 16 Dec 2025 17:41:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765935662; x=1766540462; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mDxHcZkTjmjUFpD0nPdaDh+C7TB+4JYFvDaSUk+afn4=;
        b=Zctc0A7lyZ3TvRozNmzCOk6Ut3H6lHvT7WTfVdYkv6TGiHwfd3tajEnlHG9VFxhTmr
         19LjuylpMNb7JsxsxnwMDyXNUIN1m/fwh7zf/I46bguaADrn6CHiiOxlmBnC8e5VLLjj
         m1AlUQJpLZCdrSGEYvNzGBOQ6t/U26yFpcUsWS2+Eqj0cdX5y8cB8ivewjI1PNX5UsDR
         4FGm3NyNG0rN+vNOOpdepTGofVngIrc12F+VD0XfIH1GQCvXj6/Z9MSCUgoG+Y7/zhDW
         inaojLFQcoNpiPog5C+tPj9WmCAEb5djsEyodoN4akEwN6BnOmuoHAdk3OZZIhI5mOLX
         yR/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765935662; x=1766540462;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mDxHcZkTjmjUFpD0nPdaDh+C7TB+4JYFvDaSUk+afn4=;
        b=eMFflHg69pMmCtgeSy4bCmpui0r4807xUxXdqEYE6teVjrL+HjVh1bFMCmWIcvNfak
         uNyAH9bG4MqIO9cr9pSVr++7Fwh3gJ2xdowrYGa7KNx7Elqme93ESjW+sEZd4DuAP9l+
         QFWbQx5CmbbfS5esThtUEVLT5XJK0Ad4MpP350y3nutNyhfrPCaclaQ1nMkwX4n7fasz
         va/VVcPGb3OKVLC+hsQqz3khP1TKV0ZxCKb4kctw/xN/mSga9wwm4w60iLIxcXwI5gX/
         ROXE1kHH9an7d9Zb1L0rD5OYUXW0gbCb3TiW4kMuncx1PV5qfK8qloYyUbI8hAPB1imv
         qmeg==
X-Forwarded-Encrypted: i=1; AJvYcCWc54vJluPi7D4laK2j/RrM/L3arEwbBhnFgEXQb1/6Ke/xCxseujdkFlTvkJ5TrD2mx7fg6xo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOZbqPW82dDaGPAb4DDdNem9AMmRHqQ4+49N4EkDc44ubnFM6b
	eSubwfrmwPm03arIYlkG1dzZnvDGryTfxCwAUsZucD38C5aE168er3Tc
X-Gm-Gg: AY/fxX5dLoNJ/K0poY380b799En09qdHsV45tCuLxDHhFLNTSR07T91Wqo8Fbh7YOBm
	1rvIKB1WyA8uXLh2DIJJhi5+00qTJggE8f9v9fGEAL57cEgg8BrdvoaSJzXkE26g3z+SByENg2/
	9q5WpFl4onuqLKEXpuVc9uLT/TUBrbRJ3CEM5qC5NRJg9npDfEgRlqmPRGr8BC3aEBldNSqQSff
	4Azkwk9AtFXeJJ8ISjeHYEX7Q98yt4W3zsxOcj1vq8hXkteXnFTee6wr2/wlqnw5wTVH4sttv3u
	Z5s6ugilUmwK2ify4pBbPHYqsRN94ZONWOrjYROT6vqj3Hr5Hb/XpoKH0YTwaP5bssN7PWN8JN3
	dRZ5eDfHkeP3ypoO/NE9QKrq4QNNrlEhQvZFSJ5e1lFex11nNgpGlR1yFJJ4sYJKbATnC0BSsV6
	8LPd1zYvmKgv96Si0kMz+NKZplhEeZEqpEYpr1dABlxZdm0WE1nZF/ufFOn1fnL3tjO6tldnDdm
	m30O3OYxSc=
X-Google-Smtp-Source: AGHT+IF/SEOxDOKcFv5IqFKvN9ywf362IPWc8RJF/t4t5MrZbneoibmeTII8xwlbnor44Kr5k43j5Q==
X-Received: by 2002:a17:902:ce8b:b0:2a0:ccee:b356 with SMTP id d9443c01a7336-2a0cceebcddmr72318115ad.1.1765935661607;
        Tue, 16 Dec 2025 17:41:01 -0800 (PST)
Received: from poi.localdomain (KD118158218050.ppp-bb.dion.ne.jp. [118.158.218.50])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29eea016f80sm179600095ad.60.2025.12.16.17.40.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Dec 2025 17:41:01 -0800 (PST)
From: Qianchang Zhao <pioooooooooip@gmail.com>
To: Krzysztof Kozlowski <krzk@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Zhitong Liu <liuzhitong1993@gmail.com>,
	Qianchang Zhao <pioooooooooip@gmail.com>
Subject: [PATCH] nfc: llcp: avoid double release/put on LLCP_CLOSED in nfc_llcp_recv_disc()
Date: Wed, 17 Dec 2025 10:40:48 +0900
Message-Id: <20251217014048.16889-1-pioooooooooip@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

nfc_llcp_sock_get() takes a reference on the LLCP socket via sock_hold().

In nfc_llcp_recv_disc(), when the socket is already in LLCP_CLOSED state, the
code used to perform release_sock() and nfc_llcp_sock_put() in the CLOSED branch
but then continued execution and later performed the same cleanup again on the
common exit path. This results in refcount imbalance (double put) and unbalanced
lock release.

Remove the redundant CLOSED-branch cleanup so that release_sock() and
nfc_llcp_sock_put() are performed exactly once via the common exit path, while
keeping the existing DM_DISC reply behavior.

Reported-by: Qianchang Zhao <pioooooooooip@gmail.com>
Reported-by: Zhitong Liu <liuzhitong1993@gmail.com>
Cc: stable@vger.kernel.org
Signed-off-by: Qianchang Zhao <pioooooooooip@gmail.com>
---
 net/nfc/llcp_core.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/net/nfc/llcp_core.c b/net/nfc/llcp_core.c
index beeb3b4d2..ed37604ed 100644
--- a/net/nfc/llcp_core.c
+++ b/net/nfc/llcp_core.c
@@ -1177,11 +1177,6 @@ static void nfc_llcp_recv_disc(struct nfc_llcp_local *local,
 
 	nfc_llcp_socket_purge(llcp_sock);
 
-	if (sk->sk_state == LLCP_CLOSED) {
-		release_sock(sk);
-		nfc_llcp_sock_put(llcp_sock);
-	}
-
 	if (sk->sk_state == LLCP_CONNECTED) {
 		nfc_put_device(local->dev);
 		sk->sk_state = LLCP_CLOSED;
-- 
2.34.1


