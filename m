Return-Path: <netdev+bounces-247646-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 85BE7CFCB79
	for <lists+netdev@lfdr.de>; Wed, 07 Jan 2026 10:04:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 88C4C3015942
	for <lists+netdev@lfdr.de>; Wed,  7 Jan 2026 09:04:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50B912F5A10;
	Wed,  7 Jan 2026 09:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gjp+63yE"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB7CB238D52
	for <netdev@vger.kernel.org>; Wed,  7 Jan 2026 09:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767776680; cv=none; b=MoN6bbjuaDdqwKrVv0CSajmIerJTDfj6gTTxoNzCJsSnqky9urBrvIqc3z+B3yux6/+nqkSwe2r1UG+lOUaLkZFlUb50x0pkzRnY4rCg6FAIugURya8S3WdXPnmWjjU766eIqfgLzTTZc8iWlkHhWFiAsSdjlHQ8dJ/wITGb5j0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767776680; c=relaxed/simple;
	bh=DXXeHFHCRT6ALQ4aZTBR//uNRSxmmt2W+5GojkTCBeg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Xzv4WHehnk8P8VeDq5OuhFoVT+r5Z8cJiXz8BhWcmSSwWN5gwRXrMQf+k0jZBXSuA/6b6nc+RAwznDMgwrKvdeBcY+DB/hIe8GGHMrJnuEkgIv56jAB43pv8QBY3fHpIB7mi21+U3HAR8owyBurbiPu0sjJErGwkPMPP/tTgunw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gjp+63yE; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-43297b2888fso35317f8f.1
        for <netdev@vger.kernel.org>; Wed, 07 Jan 2026 01:04:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767776677; x=1768381477; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XYA5NHCJuY3jjgYMFrcIZ25L1R5u6oP/KcQWduVcKq8=;
        b=Gjp+63yE532MJqGWE/UcHIKdfaMeQGJlamF5HdUXiutJ8bZzAMOYEaO4v2bama+fQO
         8PXCotPp9rQGIJnJLsUv9Hh4EN3zq0GTFpsyKwXc1NhnDksQfOI+r3Ub2fNMwxS58mcX
         sq5TNec4sbRhHJ9/1anGpAwtcR098Ww3HBBJ7c8DEkUx535aWcrIlKT9Ki/hZkU9mw1R
         R+VFhSOnNSfZXXyePAf2hQUjqDQCGuNq/rNPKrMkRTrFJKx7EU7t24PDscDln9u++iND
         OtzXcjx17M5/q6Jk7tRxC2AFBVWWdH31TXZqIsl24mE+nfFdsgXWul7K5DZTQXaDQmip
         HyNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767776677; x=1768381477;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XYA5NHCJuY3jjgYMFrcIZ25L1R5u6oP/KcQWduVcKq8=;
        b=Vg1opteU42onWJc9sIAK/EqPIYSTM4JNzpN6OsaWafid4myB2J2ah93yDSTm4w2uX1
         k1zhxCi1AbT6wTkejjMLGyHi3WI/Wn0EqbB2qYn8p14JaMCZxa9kQ1Q0gkp4IxivKL0U
         sIu6skzeUtljgDCltL45IU/Wo2Fe2+ZWdtPncZl7zqj0GiEjuwj+SlQ4FLn2tX0lolPt
         Q9BB23YljeII3VTmb5h7LA/Hf+icJ5sfPKGVffBjZdCEGS43cYlpgY0P9nJjZyKEMehq
         gvHp5R5xXaAiHDJttUR3K3zT/n3gl2DJDnjMja+/0LjABVBg7PTf2Cbqfhb+YAtPdKjS
         CWrw==
X-Forwarded-Encrypted: i=1; AJvYcCVl24vabUOkOEXPpSrA4uGZ1s0DMMX6lFnJvA2yOypjUKTkqtulOd90Rg+ITBcev1I6IlTE0g8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyxkyc2nZRyhp2V2551rzA/tVNoRuNsGNyC+pBTkgVtYPMXUfWc
	1Oh5ASlIzNNvhFOJJSYjj78Gk1Y7zeqg2RnRDhgw0JYPqG2kcadEH/i+
X-Gm-Gg: AY/fxX4gJPKnvvj3/LzD9CspyEwCk+b6EQa2aYOfhnID8AUU5ySMewT6OCz8GWi2g+C
	IFb0ancUGvJf/NcZQKWkEVInyELEpoheCmNE5YR49rA6Wzyxho0OBsLS5+cEId9OdKByTLGdjsj
	QJb3Pt9rZ3xkdzGwJoMR0gP5feOVwXcdIo10DZzHsmCM7y1R+VRhsz4uu2JyWLVMHhmpCUxpjuF
	AygEC2edqzzO925+KUuzyRPMGE2+iBAPYyN8gktboNCvTxQ8Gw2amV4ENQqlz4XBCnmIMR1cKub
	ivXgf3RDzT36acKP1I0PKmuDZtxYrQ0FugonqBTYaaKOzxPquN/hOuCC4jvy28Qu1qV2wYn1mHt
	Z5eELu256MH+0Xx+O7LT/h/QWaVNgrc2kxTIGEXl9uEq5D6hPujd7g6hSL+toqQAUaPOT9ke4QS
	qXVoQq11jn+NP0cjfZZ/gFZpjIKVwPSY+VzKShl1gkkK+F7g==
X-Google-Smtp-Source: AGHT+IG74BQ+GmUBoQHHt8YRVhqA4eCcYpl43fd7bFTmvsailB9SELKZEsXAQgjdjVqKB/ovrcPmZg==
X-Received: by 2002:a05:6000:240e:b0:432:c0e8:4a4a with SMTP id ffacd0b85a97d-432c3776f42mr1250136f8f.8.1767776676625;
        Wed, 07 Jan 2026 01:04:36 -0800 (PST)
Received: from thomas-precision3591.. ([2a0d:e487:219f:3dc7:a574:8d6f:e649:bd82])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-432bd0e16d2sm9514457f8f.13.2026.01.07.01.04.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jan 2026 01:04:36 -0800 (PST)
From: Thomas Fourier <fourier.thomas@gmail.com>
To: 
Cc: Thomas Fourier <fourier.thomas@gmail.com>,
	stable@vger.kernel.org,
	Chas Williams <3chas3@gmail.com>,
	linux-atm-general@lists.sourceforge.net,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] atm: Fix dma_free_coherent() size
Date: Wed,  7 Jan 2026 10:01:36 +0100
Message-ID: <20260107090141.80900-2-fourier.thomas@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The size of the buffer is not the same when alloc'd with
dma_alloc_coherent() in he_init_tpdrq() and freed.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: <stable@vger.kernel.org>
Signed-off-by: Thomas Fourier <fourier.thomas@gmail.com>
---
v1->v2:
  - change Fixes: tag to before the change from pci-consistent to dma-coherent.
 drivers/atm/he.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/atm/he.c b/drivers/atm/he.c
index ad91cc6a34fc..92a041d5387b 100644
--- a/drivers/atm/he.c
+++ b/drivers/atm/he.c
@@ -1587,7 +1587,8 @@ he_stop(struct he_dev *he_dev)
 				  he_dev->tbrq_base, he_dev->tbrq_phys);
 
 	if (he_dev->tpdrq_base)
-		dma_free_coherent(&he_dev->pci_dev->dev, CONFIG_TBRQ_SIZE * sizeof(struct he_tbrq),
+		dma_free_coherent(&he_dev->pci_dev->dev,
+				  CONFIG_TPDRQ_SIZE * sizeof(struct he_tpdrq),
 				  he_dev->tpdrq_base, he_dev->tpdrq_phys);
 
 	dma_pool_destroy(he_dev->tpd_pool);
-- 
2.43.0


