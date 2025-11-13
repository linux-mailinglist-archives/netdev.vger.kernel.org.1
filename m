Return-Path: <netdev+bounces-238249-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id EEB7FC56475
	for <lists+netdev@lfdr.de>; Thu, 13 Nov 2025 09:32:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 15715343A87
	for <lists+netdev@lfdr.de>; Thu, 13 Nov 2025 08:28:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB1B4330D32;
	Thu, 13 Nov 2025 08:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Op6k3Daf"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A17E3271EB
	for <netdev@vger.kernel.org>; Thu, 13 Nov 2025 08:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763022455; cv=none; b=UkSM3ycHz8XUbWFUhTkGHkSCiId1ToxIEj74Al7nF2Uey4O3NFeY3vtV4OY/9L06UAJtAs3SGWh7dteQlZFhhPQACYP5PRJ58Ug1jZYGa5xrUZVn27HBjg8YyyeSaj4d6nj4D6yE9X2Gkwo+SZy9NSFAVvkPn7VDNO2XD6P4cs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763022455; c=relaxed/simple;
	bh=JI2Nw2U1io7LxFEzI62xeKFVhPvOgTls3v43JWhtl2o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XX99RwTmq1tA5BB+Ei2eZ9rm11GZl5Oy0jMfcBydrZ7WbK14CSCkU3ntT37pVZJaOwPlUFNrcj8vLIdCIqPwoW4boR0X2ramWCNVIlFnuRGqXkqgG5hZc/XY/YZmfkZnVg0nuHFRfmIb1WLYDjBForSe19kDAcl4n0JiJKdJCWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Op6k3Daf; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-3418ac74bffso418274a91.1
        for <netdev@vger.kernel.org>; Thu, 13 Nov 2025 00:27:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763022454; x=1763627254; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WIHZKyxwa/urElRg62y72qxHZQlPQI5xwm0/ajzgPLM=;
        b=Op6k3DafH9tN5j9eQZYIPJRGi+zRU3OO4rRfhcrU9AiqNPvp9u7dnBcHwU/ymDbFS5
         ZqrFNlaBzXdPv6q/nMjFq+bqy8Epv97TBxim6lTT8HtnfmUJjpc0cJ5osQi3yrQozjYL
         0InCiVZGpoacithbg6d5G8sCHchcHoNVAA7t6tsorYPIrhBDfvm71h/kAq4D7/V/uMB5
         CLX1kqssR52PaspreCwJg6X7zzd9a1ipQ/1NzpOKOUnwiay6Qn2FzsjVQiUi0D8JKhCQ
         JqqNq+CO/cxe6gtkYC1zekznzD5T8On5tNBas8uo0FWrfEdIErE2zq5VSlZ0PLjrQjOh
         0i1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763022454; x=1763627254;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WIHZKyxwa/urElRg62y72qxHZQlPQI5xwm0/ajzgPLM=;
        b=A+VVYNnB18dsY6/Gxe/4WW7PS4b601R58GXbaktEzXNxar6EApILJQDLI+zlKrzRK7
         G3+d/tnxDLctQHvkVK5vcxbsx8OZFDxSnYYrFnW0+kb26ibdvJNsCINB0hyhom0iOGl7
         QIAO0KaWCo62AcVvCrlg3aijY31gpl8R004rhGjE8r4ER7izN0JeLbPWZ+cq15JC3db6
         bmQudHvp8MNTwSRYMDzc2qoAyKLJEOdBUFHzrn9ZkS6OYlw5MH9GKQPSzYNZ6K2U/g0K
         4/QgXZYMS2KDB5rv1gJxdXCjtJ5VHBEC1jSzrz17d8tu1k7mALWyfhyqFi+7Nug7Il+/
         dlQw==
X-Forwarded-Encrypted: i=1; AJvYcCUEXdYswHM4Ybn+rpeOIrBOFYWLFC2RUnIy/nTbhfJ4T2r914RUt0l7jkS1b1fkqZWCaIBAKHY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVWgvhWb3Mn3Ihmvpb8OghJ9q6QLWCVt7sFWRw9hAWOssbJWfk
	8FbQVkjl+cuQYbK7Q5KYucvXY9bjXoLRmNz36IrMGxz4Omd6heGHp4pS
X-Gm-Gg: ASbGnctfFPLFa+qT3Gwe+17CGtBM9l+WZB4GzVtObesrRbIG88yJt7HaVohYq+MCaCD
	HIIaEOdDPkSRP36UjgJ3O2dD1KoeIuUZ5daB3P/s6KB57kiIrX3UcbP+C5Kmw9eKWhh/DRtwMZG
	RgQQS210jDVkEMOtAq0sWpZ6IJlGRnkZxv+xXInRiA/YMJILrZQkWEhvmylFILMNYAaZOhImEv6
	41xmdAGBOgb457s1arEe/R+I6xzRiREd+AYs5LXTTsz2xKXDgS/rhE6PZUchGx2xQ13C+ZeyQRY
	Y4vSza88GjhC8ExOmRYPciKP3IRLrSJJvAKT12KQy4X99fPYoEmu8fZV/yDoVkbObBjlYiSYjcV
	34PaKQsxvL1tej5rVTJL6f9OdZv0wXyHWrnaqVborLHWlahXQWfLSgCwitsR5/a/5i8blGsbC/r
	sPj9azqeyW
X-Google-Smtp-Source: AGHT+IFXpQQ0+bUU3A9uboO7BvmpbLL9RfF+fgrtY9XoLFZB4M1S1oJKkKAQS3HKnnEUYtSzSImYUw==
X-Received: by 2002:a17:90b:5644:b0:32b:9774:d340 with SMTP id 98e67ed59e1d1-343ddeebfd6mr7407155a91.33.1763022453747;
        Thu, 13 Nov 2025 00:27:33 -0800 (PST)
Received: from fedora ([122.173.26.211])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-343eace9074sm1004793a91.5.2025.11.13.00.27.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Nov 2025 00:27:33 -0800 (PST)
From: Shi Hao <i.shihao.999@gmail.com>
To: pavan.chebbi@broadcom.com
Cc: mchan@broadcom.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Shi Hao <i.shihao.999@gmail.com>
Subject: [PATCH] net: ethernet: broadcom: replace strcpy with strscpy
Date: Thu, 13 Nov 2025 13:55:17 +0530
Message-ID: <20251113082517.49007-1-i.shihao.999@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace strcpy function calls with strscpy to ensure bounds checking
in the destination buffer, preventing buffer overflows and improving
security. This change aligns with current kernel coding guidelines
and best practices.

Signed-off-by: Shi Hao <i.shihao.999@gmail.com>
---
 drivers/net/ethernet/broadcom/tg3.c | 36 ++++++++++++++---------------
 1 file changed, 18 insertions(+), 18 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/tg3.c b/drivers/net/ethernet/broadcom/tg3.c
index d78cafdb2094..1a1673842a35 100644
--- a/drivers/net/ethernet/broadcom/tg3.c
+++ b/drivers/net/ethernet/broadcom/tg3.c
@@ -15765,53 +15765,53 @@ static void tg3_read_vpd(struct tg3 *tp)
 	if (tg3_asic_rev(tp) == ASIC_REV_5717) {
 		if (tp->pdev->device == TG3PCI_DEVICE_TIGON3_5717 ||
 		    tp->pdev->device == TG3PCI_DEVICE_TIGON3_5717_C)
-			strcpy(tp->board_part_number, "BCM5717");
+			strscpy(tp->board_part_number, "BCM5717", TG3_BPN_SIZE);
 		else if (tp->pdev->device == TG3PCI_DEVICE_TIGON3_5718)
-			strcpy(tp->board_part_number, "BCM5718");
+			strscpy(tp->board_part_number, "BCM5718", TG3_BPN_SIZE);
 		else
 			goto nomatch;
 	} else if (tg3_asic_rev(tp) == ASIC_REV_57780) {
 		if (tp->pdev->device == TG3PCI_DEVICE_TIGON3_57780)
-			strcpy(tp->board_part_number, "BCM57780");
+			strscpy(tp->board_part_number, "BCM57780", TG3_BPN_SIZE);
 		else if (tp->pdev->device == TG3PCI_DEVICE_TIGON3_57760)
-			strcpy(tp->board_part_number, "BCM57760");
+			strscpy(tp->board_part_number, "BCM57760", TG3_BPN_SIZE);
 		else if (tp->pdev->device == TG3PCI_DEVICE_TIGON3_57790)
-			strcpy(tp->board_part_number, "BCM57790");
+			strscpy(tp->board_part_number, "BCM57790", TG3_BPN_SIZE);
 		else if (tp->pdev->device == TG3PCI_DEVICE_TIGON3_57788)
-			strcpy(tp->board_part_number, "BCM57788");
+			strscpy(tp->board_part_number, "BCM57788", TG3_BPN_SIZE);
 		else
 			goto nomatch;
 	} else if (tg3_asic_rev(tp) == ASIC_REV_57765) {
 		if (tp->pdev->device == TG3PCI_DEVICE_TIGON3_57761)
-			strcpy(tp->board_part_number, "BCM57761");
+			strscpy(tp->board_part_number, "BCM57761", TG3_BPN_SIZE);
 		else if (tp->pdev->device == TG3PCI_DEVICE_TIGON3_57765)
-			strcpy(tp->board_part_number, "BCM57765");
+			strscpy(tp->board_part_number, "BCM57765", TG3_BPN_SIZE);
 		else if (tp->pdev->device == TG3PCI_DEVICE_TIGON3_57781)
-			strcpy(tp->board_part_number, "BCM57781");
+			strscpy(tp->board_part_number, "BCM57781", TG3_BPN_SIZE);
 		else if (tp->pdev->device == TG3PCI_DEVICE_TIGON3_57785)
-			strcpy(tp->board_part_number, "BCM57785");
+			strscpy(tp->board_part_number, "BCM57785", TG3_BPN_SIZE);
 		else if (tp->pdev->device == TG3PCI_DEVICE_TIGON3_57791)
-			strcpy(tp->board_part_number, "BCM57791");
+			strscpy(tp->board_part_number, "BCM57791", TG3_BPN_SIZE);
 		else if (tp->pdev->device == TG3PCI_DEVICE_TIGON3_57795)
-			strcpy(tp->board_part_number, "BCM57795");
+			strscpy(tp->board_part_number, "BCM57795", TG3_BPN_SIZE);
 		else
 			goto nomatch;
 	} else if (tg3_asic_rev(tp) == ASIC_REV_57766) {
 		if (tp->pdev->device == TG3PCI_DEVICE_TIGON3_57762)
-			strcpy(tp->board_part_number, "BCM57762");
+			strscpy(tp->board_part_number, "BCM57762", TG3_BPN_SIZE);
 		else if (tp->pdev->device == TG3PCI_DEVICE_TIGON3_57766)
-			strcpy(tp->board_part_number, "BCM57766");
+			strscpy(tp->board_part_number, "BCM57766", TG3_BPN_SIZE);
 		else if (tp->pdev->device == TG3PCI_DEVICE_TIGON3_57782)
-			strcpy(tp->board_part_number, "BCM57782");
+			strscpy(tp->board_part_number, "BCM57782", TG3_BPN_SIZE);
 		else if (tp->pdev->device == TG3PCI_DEVICE_TIGON3_57786)
-			strcpy(tp->board_part_number, "BCM57786");
+			strscpy(tp->board_part_number, "BCM57786", TG3_BPN_SIZE);
 		else
 			goto nomatch;
 	} else if (tg3_asic_rev(tp) == ASIC_REV_5906) {
-		strcpy(tp->board_part_number, "BCM95906");
+		strscpy(tp->board_part_number, "BCM95906", TG3_BPN_SIZE);
 	} else {
 nomatch:
-		strcpy(tp->board_part_number, "none");
+		strscpy(tp->board_part_number, "none", TG3_BPN_SIZE);
 	}
 }

--
2.51.0


