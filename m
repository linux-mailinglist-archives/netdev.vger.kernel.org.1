Return-Path: <netdev+bounces-176975-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E6326A6D0AB
	for <lists+netdev@lfdr.de>; Sun, 23 Mar 2025 20:05:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 69287188EE2B
	for <lists+netdev@lfdr.de>; Sun, 23 Mar 2025 19:05:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77D6C78C9C;
	Sun, 23 Mar 2025 19:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mJXbX+hN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7D0DAD27
	for <netdev@vger.kernel.org>; Sun, 23 Mar 2025 19:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742756709; cv=none; b=StOYzeiGwkf8FKC5QQgd5jec5OiGOxeoddWmUaogs+C5Nl/mJQy/a8ngKtl4o8srSjLQ91he4MHGUe1/yOgNmhxjj9RCwjbJQt0yYtv7VrUMR/CYfUFbbnZTYmk0cw59BKHRLPLtJrcUYIjIodej8lM4csxCf7QIbA+/2g2EEr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742756709; c=relaxed/simple;
	bh=XWxdEIwi5NA8uzDyn3XME7B3pjQZbHaHJtCJFeaohiE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=A+QKvCzozJEdDh2ixJdgirSGhs3xc24JDz44ytr/V+vPKsexZPZfa99bohT56xo0DtnCgCxhAtPhe47EdNeVZA+TFsVzDQwbuLPDAhnmAPcd4sAKA8INNDgF7zD4UhKY4dycP9o/hYdj1n1FmzWeR7W3NpXFiY6F6ABDmdqecSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mJXbX+hN; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-54298ec925bso5235781e87.3
        for <netdev@vger.kernel.org>; Sun, 23 Mar 2025 12:05:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742756705; x=1743361505; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=v8HH47/a267d6Axp4efg1VKfbT+jA8suvaUKxXGsO54=;
        b=mJXbX+hNn24Tg+dNQwwvjxciYzXJdN4DxjPZ8WNsizBL3LL/W5xtn5RPXmbNMkY/2H
         AobXJnJtp3vxUX26GeSlL7+c/WQr4i5kRYBrFsu0k2SweT6LOenZku8Lm21V0w/tL2GE
         rFtwcqKaL2YoEgHeOyj1GP08jhO6ljI6y8reyGPaSHRjzcPNcxSDrP07meLfNJsW44Q9
         n2Zxfer/ek/wa8VdteIdf8Ob3gQyX6iV5FegUDSHT/KyxStNa8FyPbaEsrSeOOuiVqFP
         rVKjdbNfBGFPsFp0YFGVqBvhjL99x0amnwY3WiJPq92M0IT5IbeLOAa337fPgXaEpehN
         s7Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742756705; x=1743361505;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=v8HH47/a267d6Axp4efg1VKfbT+jA8suvaUKxXGsO54=;
        b=almCkpz7oA2aflhBLW6mVKHzAgzjKSYTaaEpIRUUTRA/2Mc5awMYwXPFE8RfQ/vVVf
         F5Qnz9IW82mZ6QfZn1RzqiN22LZQFXePwEMHGq6XReiH75af0CkHRy7hZKzp9qBT1OdF
         M8c29m1th56rLOmZOu+sCRpUFN+HSEZTI14lUR2wGiFk/T+cpTaapxhuXcF4RW7vNhjw
         3bSJT63IrKPSV30WjOPv6phXWxAXAE5hB0m0Dx5zOcqDS6cknKJriF0AsTrT7haWAqoq
         VayhTMb6d6KYKNTKjSnEMhqE72stGflxtZUr3a4bIAwWAWCx3/fCrHe9oxxtrE/pzKCA
         1Iiw==
X-Gm-Message-State: AOJu0YwNxvuli/I108fk5eVut1o+kj63VZP2+KsMYi7K1e9mxKOTuIq7
	iSs3HMdca2if4QslDts+OnhUEDwfiwnLKjThMd3f04+Q54dG/UiHhMvdbJwOaZI=
X-Gm-Gg: ASbGnct5f9DLKCrzBtB/PQnSVXVnNhk7dJ9MDOAsHLNI+0qGzl3dA9OIf853+bPrt8S
	znxyJ/2QlBhOHWM5meLUv8sNNChPJniLNd/kzF3Y+NaU0emo0inokuJCEZd9DITBOTxkYsM9Atx
	fzlWkR3OR5qZcKwPFCdF7j5tFP/n/mapfP3C/OIkHRkvkPfrb+gLOg1iSAMqTMeZm6Ef4bhCQCv
	MqvC/A9OWc3nQKCEfGqO/jDMJXoq2ZkFphOaTjf6ogdUznBIRLGLZg0I1YLVdC8g9UpGkUp7Mjh
	vS0wT9sS5ym7zFpLgQ3uU2UJylRDWQb2CInjN4ZqykTqkZ5JCaAlVgQXi3c83sRrJcBmPp24Xrn
	WivLWa1wAbvfHd2oyM7jD04U0C/ehpxOCDQfq+TYNtQeA35lvOmnE+NJMQYnzToUZ/A==
X-Google-Smtp-Source: AGHT+IEYTX3cpKY5nW6qa+1XbonXQ0Hzs/SBxtGUZApH4lu2tp4LmMp/73N1+cAoRxap+ztxZX3V1Q==
X-Received: by 2002:a05:6512:6c7:b0:54a:cc11:b55f with SMTP id 2adb3069b0e04-54ad649cb0bmr3051958e87.22.1742756704909;
        Sun, 23 Mar 2025 12:05:04 -0700 (PDT)
Received: from yocto-build-johan.c.remarkable-codex-builds.internal (122.96.88.34.bc.googleusercontent.com. [34.88.96.122])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-54ad64fbe48sm859283e87.109.2025.03.23.12.05.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Mar 2025 12:05:04 -0700 (PDT)
From: Johan Korsnes <johan.korsnes@gmail.com>
To: netdev@vger.kernel.org
Cc: Johan Korsnes <johan.korsnes@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH] net: au1000_eth: Mark au1000_ReleaseDB() static
Date: Sun, 23 Mar 2025 20:04:50 +0100
Message-ID: <20250323190450.111241-1-johan.korsnes@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This fixes the following build warning:
```
drivers/net/ethernet/amd/au1000_eth.c:574:6: warning: no previous prototype for 'au1000_ReleaseDB' [-Wmissing-prototypes]
  574 | void au1000_ReleaseDB(struct au1000_private *aup, struct db_dest *pDB)
      |      ^~~~~~~~~~~~~~~~
```

Signed-off-by: Johan Korsnes <johan.korsnes@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
---
 drivers/net/ethernet/amd/au1000_eth.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/amd/au1000_eth.c b/drivers/net/ethernet/amd/au1000_eth.c
index 0671a066913b..9d35ac348ebe 100644
--- a/drivers/net/ethernet/amd/au1000_eth.c
+++ b/drivers/net/ethernet/amd/au1000_eth.c
@@ -571,7 +571,7 @@ static struct db_dest *au1000_GetFreeDB(struct au1000_private *aup)
 	return pDB;
 }
 
-void au1000_ReleaseDB(struct au1000_private *aup, struct db_dest *pDB)
+static void au1000_ReleaseDB(struct au1000_private *aup, struct db_dest *pDB)
 {
 	struct db_dest *pDBfree = aup->pDBfree;
 	if (pDBfree)
-- 
2.49.0


