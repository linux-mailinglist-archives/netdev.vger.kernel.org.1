Return-Path: <netdev+bounces-202583-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79BA7AEE4E2
	for <lists+netdev@lfdr.de>; Mon, 30 Jun 2025 18:44:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B5891626EB
	for <lists+netdev@lfdr.de>; Mon, 30 Jun 2025 16:44:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D318828F94E;
	Mon, 30 Jun 2025 16:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="mheUaYgd"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EB9C28DF2F
	for <netdev@vger.kernel.org>; Mon, 30 Jun 2025 16:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751301862; cv=none; b=uQxQwFYN4OsIxzB1uNsO0GNzGMz82udyqCXxAkNlHflBmmKBicc63QI+vIC5WRxpogZuoK+VB3RthBgOdgajsxRbXRhmmoJeCF+7elwgwVgo8hzr1l1igp0RrI9F0mmTyNsR2LabEdVQe4Vh4l+TbqEndwVkMk+UaDaheVIdTdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751301862; c=relaxed/simple;
	bh=4s/OucA4OmbaiWVDuMtZfKSgCSlDqRwGpugk4zkaB2U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Ug8oqX1n+oNQirUnzUoJvJDlqNOV0Ok3ONxUwW/OryiDS8R+ezpqjc7C3VZrvWd7iKgpbH19iis0WGf3VD0hObWjCZXbWIviBYblThufZlN29Z4OWjus2zKxVQfRGdEjfB1a9Q2SMAWMM0zkCahVAAKmi0+APrYecNf8gw9U6hc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=mheUaYgd; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-60c3aafae23so12441178a12.1
        for <netdev@vger.kernel.org>; Mon, 30 Jun 2025 09:44:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1751301858; x=1751906658; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3ywrE9DBS0pVgl/itvOmgC+RGP7k9gexljJW9W+1yKo=;
        b=mheUaYgdHgoD4liTLS4Ztwxu7KsswnHmvOS1S1SAA6ZX+QhTzBJBjc3QP0Wr790u/i
         HTgKm+J74JzFlVEbiIRlDQp0fLi1d71v5EdcUzkioC9kTjyqgA/t9QndPAMRDnMAGdcO
         Li51ykbVwX2HPO1CX2K/WT+3ksOT19XUDxWEtqHxu1ubntmKRroI3RI89plPAcFMa6rt
         0GoE4/tgfC3TURNylhcfP/5m8WSGzRrSsnxqAB55FkbKzlgFK2OuPSs2vd2VyYDtRb7C
         B6qCSVUs7uGBUfqBsnFSV+ht78erItK1Ip4YN5CGqfkkgpE8QPFpTpFhn5gclpXriiUc
         LCJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751301858; x=1751906658;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3ywrE9DBS0pVgl/itvOmgC+RGP7k9gexljJW9W+1yKo=;
        b=IDBdKqmbwQBKKbR5lNglsgV9fc13M1fQLVy4UNK+qlmIFmtkiyG/6RpE7VtQozfEAn
         40muRKoR+fGobIyyrVqVCARU20+eq3sCPajeXicyRKtivplEmlbB15KR+tgAmsCEaBSO
         cbN5riqt8zPfORAK2Rr+ZS2oTGbFOtJdMElZNO+BLzBrtAFT5FyYQoYIwjq86s1C41vM
         aWXcy6WMpDgGFbTtpnsZpDNQlmPCr6ygP5PmfkDltHhRWtyW4IfLeVM8cTXDa3magYLQ
         oYwreTkMmb0WNLA7ToMk7HjjhOT1KQB6P/9K8aWq/tCSnBg/UxU8s8ix1jfnyYtZgp0L
         giFg==
X-Gm-Message-State: AOJu0YxbuIwaSCbrxJpptt+bHo2Y5Qq1/2dWM4UcXwiHLRf9uAtB7gJp
	xy2E7XUV5c6Syi530mkl/zGyMQpFhMYDaGJb7gKc/ECvfgUOWXlQfLTHmM4DoJhdEV0=
X-Gm-Gg: ASbGnct9xCMFEbRucuulrsDYUjB4dGGvXYywuybPm/ZPsiyl/+O1X9gxvPBFDr24azN
	MuTPxVkY0tqIuWytYzldLCl3oJ5D6VOHwKJQ/swrUVyNr/JkmIuR74JoVozBNzlEnjRLUQXu/PZ
	F3px6Uw9ts8ePnDgvEEtNCgo/hjWWLgo1GcqB0by7PhHb4opy/w6sBsDjD5b8b/kLdwHhyQavJ/
	k2po4AqWqLZConqqYVhOI27V8UkT51Fz2VB9+IJ6wfLaZIR3SWLTZFOdOhm6MHNuR9mGi5u/iKX
	Ycbhu5crTL0sgQI/jf0zp6RJtYfGyUfkbzdNA6Ho5wTFub+0vko6w/9FlzOBbYBealXL0tjh7si
	Z9YhJeSE+VfOd4/fJmezcUIxTP+6y
X-Google-Smtp-Source: AGHT+IGLwzuIaHWi4U+Whd9hiPFFEYzIbcMPIkJphdO+3Q2SWUHEIWxk+X4yDKQz3KbuivHJEWIr+w==
X-Received: by 2002:a17:906:903:b0:ad8:91e4:a931 with SMTP id a640c23a62f3a-ae3aa2a6204mr20575266b.26.1751301857595;
        Mon, 30 Jun 2025 09:44:17 -0700 (PDT)
Received: from localhost (p200300f65f06ab0400000000000001b9.dip0.t-ipconnect.de. [2003:f6:5f06:ab04::1b9])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-ae353ca371csm706404666b.179.2025.06.30.09.44.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jun 2025 09:44:17 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Igor Russkikh <irusskikh@marvell.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Alexander Loktionov <Alexander.Loktionov@aquantia.com>,
	David VomLehn <vomlehn@texas.net>,
	Dmitry Bezrukov <Dmitry.Bezrukov@aquantia.com>,
	Pavel Belous <Pavel.Belous@aquantia.com>,
	Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org
Subject: [PATCH v2 net-next] net: atlantic: Rename PCI driver struct to end in _driver
Date: Mon, 30 Jun 2025 18:44:07 +0200
Message-ID: <20250630164406.57589-2-u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1920; i=u.kleine-koenig@baylibre.com; h=from:subject; bh=4s/OucA4OmbaiWVDuMtZfKSgCSlDqRwGpugk4zkaB2U=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBoYr7WQ8QDh7/2LSJLjpz+oxQcz2RX06ZFWqrpw +eYGojiafqJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCaGK+1gAKCRCPgPtYfRL+ TolWCAC6GPZtoUlXIBye92GNsIgnr0fIfFI7kTtnPWmpAEL560kSpPJErzaAM5XB557SSMXPS1q kP/FGVDPHrVivSRaehn+DapvoUDTHE+qQqJrkAnqFL9wV7sqXepGq/TZJVbUQ3Yp1gCKg6FuqQ5 7ACGhBDqh/MG+hRyUHOCsMfEKjP19yXfe9Ox9vmh6ULla5j6i+EF4UmIgbXysp0sAdvg+9t2SJP o1thk5Ntv7zLkufwCSzs+KS8WytEUFyrh0qB5fbvMoOwW2XJ+bcgA9KPjmYwrS7XkQRSe5BPA7u SaNBR8CkPiKax31soqgj7Wb7pR7MSzBQFRqdNwTI29jAwVKp
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

This is not only a cosmetic change because the section mismatch checks
(implemented in scripts/mod/modpost.c) also depend on the object's name
and for drivers the checks are stricter than for ops.

However aq_pci_driver also passes the stricter checks just fine, so no
further changes needed.

The cheating^Wmisleading name was introduced in commit 97bde5c4f909
("net: ethernet: aquantia: Support for NIC-specific code")

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
---
Changes since implicit v1 (available at
https://lore.kernel.org/netdev/20250627094642.1923993-2-u.kleine-koenig@baylibre.com):

 - Improve commit log to explain in more detail the check
 - Mention the introducing commit in prose and not in a Fixes: line
 - trivially rebase to a newer next tag
 - explicitly mark for net-next in the Subject line

 drivers/net/ethernet/aquantia/atlantic/aq_pci_func.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/aquantia/atlantic/aq_pci_func.c b/drivers/net/ethernet/aquantia/atlantic/aq_pci_func.c
index 08630ee94251..ed5231dece3f 100644
--- a/drivers/net/ethernet/aquantia/atlantic/aq_pci_func.c
+++ b/drivers/net/ethernet/aquantia/atlantic/aq_pci_func.c
@@ -463,7 +463,7 @@ static const struct dev_pm_ops aq_pm_ops = {
 };
 #endif
 
-static struct pci_driver aq_pci_ops = {
+static struct pci_driver aq_pci_driver = {
 	.name = AQ_CFG_DRV_NAME,
 	.id_table = aq_pci_tbl,
 	.probe = aq_pci_probe,
@@ -476,11 +476,11 @@ static struct pci_driver aq_pci_ops = {
 
 int aq_pci_func_register_driver(void)
 {
-	return pci_register_driver(&aq_pci_ops);
+	return pci_register_driver(&aq_pci_driver);
 }
 
 void aq_pci_func_unregister_driver(void)
 {
-	pci_unregister_driver(&aq_pci_ops);
+	pci_unregister_driver(&aq_pci_driver);
 }
 
base-commit: 1343433ed38923a21425c602e92120a1f1db5f7a
-- 
2.49.0


