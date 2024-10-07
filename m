Return-Path: <netdev+bounces-132913-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E74C6993B76
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 01:57:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8516EB20BD1
	for <lists+netdev@lfdr.de>; Mon,  7 Oct 2024 23:57:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0916B1925B2;
	Mon,  7 Oct 2024 23:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E/HIgxjM"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89C9C18DF65;
	Mon,  7 Oct 2024 23:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728345435; cv=none; b=UpcvKZ+/cm1tY6YWv9URuBvl8SreHuzXKia5x9w4ne06M31VB9ZCR5glUC4P12vGZ6cTiETuBb9X5BTRpmIfKdsRBMYJruo1DwCdUrjDFLrDkCZ2f399phLN+jspLc+vfsgzTyWedp/3ftmeR0wgwRUnLF3E3iCxUy7zVvroIS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728345435; c=relaxed/simple;
	bh=VJU7qbY8J3u9xtC6EQR+mx6gjjmrdTSW58NPLG7vkX4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BxlcXVzEeCuhl7eZ2zaNIEtCrnNUqV8LBydmXn35O8ATWgBPh8KlcYwz/aEQQvXgmuCfy/cBpm/ORUMs8qeA9WxjzdBI/F6fvKDZpWO2XPsHePQRq0DWm2EcoZXPxbguZJSPidfMXUELErUxvCZmLs/QXrJ/IavjKMf9YehoW7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E/HIgxjM; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-20b7a4336easo36691705ad.3;
        Mon, 07 Oct 2024 16:57:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728345434; x=1728950234; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wiNpm1dKLWSbBugNxf2eNO5rcY6QQ31sW76RgkYbIeI=;
        b=E/HIgxjMjcWSTEKFpaWDJtwdzIe/5VPLZkYFtN1x7zIGf+mY8qRN4sitI3IOv2zt/I
         3KOHKnkKZzy3OtArbcYK2JbZmP5/Nu1JVs/SIpdIpfHSoSRIaDoJSfSbpU4tZhCWia6E
         +0GDIR3qNfhPq2Qtr+3S6nzYd/PDIg5pPwIe1vf1HH9ppHHd8CpV0bAMGepDKuAwIfWa
         2xH0SnHeqrH22/JRxCKmscU8obH1bYQIqSXvl6arySgpdajQVRftSXtOKBhF6xtwgCPh
         lvyGQDDmfwW7qtZvpwx2NnKmZ9Ezcm0Z7IU1rQOpT4T5UtfF6Myuwgnmru1rOCgBAFMr
         x5Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728345434; x=1728950234;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wiNpm1dKLWSbBugNxf2eNO5rcY6QQ31sW76RgkYbIeI=;
        b=OqPWv1RjsUC8fEzGXD2HsHFWuTlbysV4XPxqorx4he9zO//nJch8tXZXJwzzX1wXWs
         urAN7IJcoDkpwmz3SmLG0iJpMpi2KAmb2wvlZ9RNwstjd7pIcPgIH7QLvJzUcd5mXNKV
         3hwNK1VmBOl5WlPi4eAQVBwbEXhnH5gygWSkaK9tJSpNKxrHL0jiHyQfun/BLZkF1KfM
         GYdHNWXnd1agZ/OazvZGpS96lch63aErDugTH/Xbsq16b0yhJwumUcTR56CmBbQOl3As
         vj2TP7rpcpzkoZ1jNH40R3qdw2hk6/tFOzhXsZZ3uwjOmA7q4LFVj4fxEuVyf5KD8KZ6
         ckLg==
X-Forwarded-Encrypted: i=1; AJvYcCXga8Ib0Qr4BlqSOjcfjnwIiSkRENHWgRKfEQO2DqYf8duA/48EXZAqH7LrW0mnqsL6tE29ZafzXsCtWD8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxvEhy4SVTIGwdRotRI7ceOUoJ6b2KYVqgIMlr39zDUEuPoGp+F
	ejZvd72LsnQDY9HZKhYjfw/qoZdr6HcDhzBuUPtDM98V2T69G1prD79Z9w==
X-Google-Smtp-Source: AGHT+IG2WQBalVXy3d58R2M47Rps8Dc2IedLBnATqVk0ogRG/4byALYOK3lFjfDgMDUvtAvbqLCJIA==
X-Received: by 2002:a17:903:234c:b0:20b:7e0d:9b with SMTP id d9443c01a7336-20bfdfafec1mr195240965ad.18.1728345433585;
        Mon, 07 Oct 2024 16:57:13 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8200:dab8::a86])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20c139316e8sm44787205ad.181.2024.10.07.16.57.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2024 16:57:13 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: netdev@vger.kernel.org
Cc: andrew@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-kernel@vger.kernel.org,
	jacob.e.keller@intel.com,
	horms@kernel.org,
	sd@queasysnail.net,
	chunkeey@gmail.com
Subject: [PATCH net] net: ibm: emac: mal: fix wrong goto
Date: Mon,  7 Oct 2024 16:57:11 -0700
Message-ID: <20241007235711.5714-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.46.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

dcr_map is called in the previous if and therefore needs to be unmapped.

Fixes: 1ff0fcfcb1a6 ("ibm_newemac: Fix new MAL feature handling")

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/net/ethernet/ibm/emac/mal.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/ibm/emac/mal.c b/drivers/net/ethernet/ibm/emac/mal.c
index d92dd9c83031..0c5e22d14372 100644
--- a/drivers/net/ethernet/ibm/emac/mal.c
+++ b/drivers/net/ethernet/ibm/emac/mal.c
@@ -578,7 +578,7 @@ static int mal_probe(struct platform_device *ofdev)
 		printk(KERN_ERR "%pOF: Support for 405EZ not enabled!\n",
 				ofdev->dev.of_node);
 		err = -ENODEV;
-		goto fail;
+		goto fail_unmap;
 #endif
 	}
 
-- 
2.46.2


