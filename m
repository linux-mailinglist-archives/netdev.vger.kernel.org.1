Return-Path: <netdev+bounces-72777-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D1AD85991F
	for <lists+netdev@lfdr.de>; Sun, 18 Feb 2024 20:44:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B9AC1C209ED
	for <lists+netdev@lfdr.de>; Sun, 18 Feb 2024 19:44:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BA866F53E;
	Sun, 18 Feb 2024 19:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QLnKC2tu"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8FEE6F086
	for <netdev@vger.kernel.org>; Sun, 18 Feb 2024 19:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708285438; cv=none; b=Qy1VBNoVsRMne3TjrKk8R4Cv4Nqsrj2lr0vFtn0PRha6FOJ+q4wePhgm1Hn93WNtDTAJtmWFx497UKITmD7m/TPeD3XF9caR0MPkTyrmRImOBuvxku+ouRJMEXNU9JtboOlf/HHZRbpaQthg+uo1x0KP/cc4PqwJ+d8OJCx2l5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708285438; c=relaxed/simple;
	bh=ZSgg56MDDikMxD9lFICzp5aLOSYnhukufSJJ+LaxfFc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=jotdud7xVx0pdo4QItxMFP6rnJLD1EMqSyexNrfvzXmeiF3wuec1ygsp+ei//Xt1Q84D7XQdMyFA7P4iiZFEZF77iNdLZerxN0DecknFyhdGmMn5YS5W61pW9w5WHRjb5fP+QsYpTU35pl21L3tdyyA8GA5cgJIMW1Yq4GDcZL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QLnKC2tu; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2d23473a563so8216091fa.3
        for <netdev@vger.kernel.org>; Sun, 18 Feb 2024 11:43:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708285435; x=1708890235; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LneWVvxgKNr3a5cjbUb7k/3W5Ksd7fPA6MKpRdyePWk=;
        b=QLnKC2tuK7O5qBdNhkPJM0OiSdmNfRxp7aZSw2ZEDvJbOftx2zuUwSSxFgyoCzgdX4
         8bQ6SDNU0TP//HCIthI7eSfMSWqFKzpXXovnxqrRC+vc+jqp1PKiJyUd7hM5vNAPiutK
         NHVHhsJnWbiTSe9TL+C3zw6O3l3Gwuv4yNC5fpHKQy2whVURkMo5Qi4dbS/JbU/kMJEb
         Ho7tiuNeu5Zx/t4bv3LGaKqs3Acmfu7LiYzFXuvXCT4Zjf9tw87UaI9EWRAYe0sbIBd8
         QYTNx4p1O8S4mM5DK1TFem8f30dXDWOSRmqd/G+MpFtiL2tNbS2w1jKTV+sdcinAwtIy
         KbaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708285435; x=1708890235;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LneWVvxgKNr3a5cjbUb7k/3W5Ksd7fPA6MKpRdyePWk=;
        b=R5mPAhUc408wr4aWSA1U/t7q5NT9fi1GD797LXEK7rUuOO0NmAsmNVo68SpuqS0tzf
         f+gDKnddSWPvIwecbkL7/4onQKtpUlVBasNkgSawa548Eb9qIqYa6lZIg2LBJojq2gzu
         avdiFGs32mIaqWcY9uklLjG1ctEWAoKYVgOm6JiTjMnqlyKU4AG0GyPWZkVCAQ7vc0e8
         cEjCQAxKWqkSvf7bXV6187ybd38F/+yhtkIOZ7e2mfUNelWsbMFVUMgXiW5YnNZ+9E3y
         5ck5n7sRZO2xZjfv7ejP5w9gwVG31HDRYyEfhumLontHYABFwPlp1vCjvIrWiTDj+cxJ
         ImMg==
X-Forwarded-Encrypted: i=1; AJvYcCX+USjZRM9e1kPUDyk+n6rVDQkp/KyejFcBBSvG4SL1EoTNNgW7bxDRnBNpAJQXuCP/SpbyAhxvxpicPMcf5hSsdZDTYsSR
X-Gm-Message-State: AOJu0YzWdxSxh+tHRSyzmKyiYt+KYzrGmyPR0PBSUFwWjTF81hLKeg7l
	G1uCRyXd9qlsNFMg+LfPMyhOkGFRePezYQr1Noe7rF3vOlhT++f9
X-Google-Smtp-Source: AGHT+IFKba6EanrSgC1DrAUrNyGzmAlb1FQ6MBNqLof53YER2MOmrJIXvFvdKWA0o01RBzHHpGSHQA==
X-Received: by 2002:a05:6512:3a88:b0:512:a450:e1ee with SMTP id q8-20020a0565123a8800b00512a450e1eemr3349127lfu.1.1708285433945;
        Sun, 18 Feb 2024 11:43:53 -0800 (PST)
Received: from mishin.sarov.local (95-37-3-243.dynamic.mts-nn.ru. [95.37.3.243])
        by smtp.gmail.com with ESMTPSA id t18-20020a195f12000000b005114dc093desm660012lfb.259.2024.02.18.11.43.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Feb 2024 11:43:53 -0800 (PST)
From: Maks Mishin <maks.mishinfz@gmail.com>
X-Google-Original-From: Maks Mishin <maks.mishinFZ@gmail.com>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: Maks Mishin <maks.mishinFZ@gmail.com>,
	netdev@vger.kernel.org
Subject: [PATCH] ctrl: Add check for result rtnl_dump_filter()
Date: Sun, 18 Feb 2024 22:43:09 +0300
Message-Id: <20240218194309.31482-1-maks.mishinFZ@gmail.com>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Added check for result of rtnl_dump_filter() function
for catch errors linked with dump.
Found by RASU JSC.

Signed-off-by: Maks Mishin <maks.mishinFZ@gmail.com>
---
 genl/ctrl.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/genl/ctrl.c b/genl/ctrl.c
index aff922a4..467a2830 100644
--- a/genl/ctrl.c
+++ b/genl/ctrl.c
@@ -313,7 +313,10 @@ static int ctrl_list(int cmd, int argc, char **argv)
 			goto ctrl_done;
 		}
 
-		rtnl_dump_filter(&rth, print_ctrl2, stdout);
+		if (rtnl_dump_filter(&rth, print_ctrl2, stdout) < 0) {
+			fprintf(stderr, "Dump terminated\n");
+			exit(1);
+		}
 
 	}
 
-- 
2.30.2


