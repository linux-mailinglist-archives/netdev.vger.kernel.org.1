Return-Path: <netdev+bounces-177294-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B5D3A6EB22
	for <lists+netdev@lfdr.de>; Tue, 25 Mar 2025 09:11:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B99631890D41
	for <lists+netdev@lfdr.de>; Tue, 25 Mar 2025 08:11:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C89F11A5BA6;
	Tue, 25 Mar 2025 08:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TbMsKg7+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6702E19E98A;
	Tue, 25 Mar 2025 08:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742890271; cv=none; b=ZJrTZLGQH4CkaZRR/oPu66dg3IGsXjICOXQXXJ/83Tn8CHE2WVtUdWrgs7wlogdWvhvpbvSNI8HO/kw3DzFVec56Tk8u8Qk//QwiG0XSX2uk/mPHqPxwln2Ca/N7px016ZjFwjTGHuxBJe8XuHY5SlPPzbAZG/uMeJZdKn473Y8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742890271; c=relaxed/simple;
	bh=XdvV9lTKalQ/MN6RLxbFVsr52vq2mOjL+T0ABaNCys4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=WNfpROpHrwoN+ZsLlC2Sj/zJgEkCVB2wwhKjo+sD1CjS/6BTuq4woihK7r1eETHKynG0o6Rn2M37gvUAaWi0yBDdmHLKk9QH0CRz26QAIsIUjtiIIXz7MNHI5g4p3cLjoFyPALa55F7NLJp9MaHbyCW4sp3SMNpj3I3BXSO6WIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TbMsKg7+; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-223a7065ff8so34305095ad.0;
        Tue, 25 Mar 2025 01:11:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742890268; x=1743495068; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8EJXAz1GLPl9e3L3417MLNSET1/+5vfTeUSz68+Ai0k=;
        b=TbMsKg7+sOWRHmcAv5kukHMlKcIT7yB+ea374ZImNycGw1q1cHOlSFNZo+VRmjAIm7
         yBzzd+w5wMczZ5ZZfo5GTLknDc8EdGUzLq1khas9zHoKRFkzVlDkN4jp69lsCWHC7Xah
         fRYdVurMrDgfcztcMDamjqtHLaLd7chpwd09ppmnOGOR1IV06u/WRbZWjNIrx6zezZQk
         47mymhnoBfW8p+rxb/okchgnN5CG0CP+6PT7FPECw855i5tfMlD7p8NKQChZNMLFCAU4
         74Fwu7jBnM7Qv4P4B1n5ystoow7zsIvzbf56TSZXq1Rgbbbk/zpw5Cht4ELdk1Q1rst9
         uTxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742890268; x=1743495068;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8EJXAz1GLPl9e3L3417MLNSET1/+5vfTeUSz68+Ai0k=;
        b=ph8QVfaFX/aQl+si9IZCJ1JzQliopBFfLzweIq3VfDVwz29Umy8LO8gU8oPbqIDuVj
         O6xbbX5cVlJGvRinhiUFefEUAu9End7/ft324RV1+/E5tIZ+2MGOM/CDV9gMK2QGW8og
         MD1zYmtSpvwcW6fUxvw09ooAHKd6lOicBqRLzwuvX9BbnPsGOuA2Q0BI/eTYeVCFJtIv
         NlfidGVFiT+aTX15sC1SDodsJXCiHMMpl2JJaI/g7bRNV3SlrGox8nClMI1bFAwxxNrZ
         wIK104g2zEqVTdlj1ES3x/hJvxTgX6XqksWubCW9S8g23VPsKH5CjBFPYSCzXqtvjKVO
         UoDA==
X-Forwarded-Encrypted: i=1; AJvYcCWF9ebIvxFL9udow130o/9vU/gQyinijXZp9rkg9ZX5YRd/CiigQz5ag0UW25zhUa5z68Eg2HOY@vger.kernel.org, AJvYcCXBni0zXbjdPOGP+P29Rb8bgIoNbnpBST9SLPUKXD8MtDAuEy3DmUgfqD1D2FWJlwnnrlqsrBNoVUch5Kk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyvmV3MHDpJjMC7MVNr+oZtmcqINpUR6C+ohF2Z4KO9rr45ApDz
	aNFx7ues53b4E8Ia2jCBft3M0eNuuuObqkOQz2xqjLY07VQEd0FD
X-Gm-Gg: ASbGncvkpfI7xc1aJ5MNNmA9eSiiCDhnw0v8h1Wg1v0qqBJrOMP41sDuyIJAJQ5sftL
	yGgd4IJJ5yTv4k3QFUBRBU7a3Pt/+oGRgcoJalJmK2+DTKERU9jzSSr1we5+kLeWgfpmoFtOqEl
	bVgE9bMFbEaiFmGyvoagreukvysebpzn6nzMkajVFV9ujShLQr/K0z5QIYMJtopdcggL41Fcvw5
	l2f7amjIxIAD0cFoWiUPfiYyGvhKg1Q8vKbagi0RzNo+9O4oJ/i9KPd49htrl8j0tLxZ611YePQ
	o0CqmBZ2s3Mf8KSYIcqvigezS2NNYWvu3NObr18gEEt9rIQzAGHEehvSc7GDZIEZfts4a44H0Ml
	2J3bKsqRk/omU/7LbWTNeIqQ24QMRiZBGiRsU9Dt1RX6lEXgU1qaECj8aFI0x0G09vU71GC7dDU
	kNTYs=
X-Google-Smtp-Source: AGHT+IHJizhf0y3pfXmrbvOIcfN6DwwlgtT71R3QsohrGK18ne60hKpj5CKjX4+kaDnpMFehBZjy3A==
X-Received: by 2002:a17:902:cec4:b0:220:c143:90a0 with SMTP id d9443c01a7336-22780d96ac7mr262843405ad.24.1742890268445;
        Tue, 25 Mar 2025 01:11:08 -0700 (PDT)
Received: from bu9-daniel.dhcpserver.bu9bmc.local (2001-b400-e308-c6d8-50cc-86f4-63a9-3bcd.emome-ip6.hinet.net. [2001:b400:e308:c6d8:50cc:86f4:63a9:3bcd])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-301bf59e2desm13677993a91.23.2025.03.25.01.11.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Mar 2025 01:11:08 -0700 (PDT)
From: Daniel Hsu <d486250@gmail.com>
X-Google-Original-From: Daniel Hsu <Daniel-Hsu@quantatw.com>
To: jk@codeconstruct.com.au
Cc: matt@codeconstruct.com.au,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Daniel Hsu <Daniel-Hsu@quantatw.com>
Subject: [PATCH] mctp: Fix incorrect tx flow invalidation condition in mctp-i2c
Date: Tue, 25 Mar 2025 16:10:08 +0800
Message-Id: <20250325081008.3372960-1-Daniel-Hsu@quantatw.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Previously, the condition for invalidating the tx flow in
mctp_i2c_invalidate_tx_flow() checked if `rc` was nonzero.
However, this could incorrectly trigger the invalidation
even when `rc > 0` was returned as a success status.

This patch updates the condition to explicitly check for `rc < 0`,
ensuring that only error cases trigger the invalidation.

Signed-off-by: Daniel Hsu <Daniel-Hsu@quantatw.com>
---
 drivers/net/mctp/mctp-i2c.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/mctp/mctp-i2c.c b/drivers/net/mctp/mctp-i2c.c
index d74d47dd6e04..f782d93f826e 100644
--- a/drivers/net/mctp/mctp-i2c.c
+++ b/drivers/net/mctp/mctp-i2c.c
@@ -537,7 +537,7 @@ static void mctp_i2c_xmit(struct mctp_i2c_dev *midev, struct sk_buff *skb)
 		rc = __i2c_transfer(midev->adapter, &msg, 1);
 
 		/* on tx errors, the flow can no longer be considered valid */
-		if (rc)
+		if (rc < 0)
 			mctp_i2c_invalidate_tx_flow(midev, skb);
 
 		break;
-- 
2.25.1


