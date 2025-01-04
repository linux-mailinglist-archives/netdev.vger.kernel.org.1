Return-Path: <netdev+bounces-155188-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 48B92A0163B
	for <lists+netdev@lfdr.de>; Sat,  4 Jan 2025 19:16:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4C66118839CC
	for <lists+netdev@lfdr.de>; Sat,  4 Jan 2025 18:16:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 692D51D47C8;
	Sat,  4 Jan 2025 18:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XZ9hmgEq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 855081D14E2;
	Sat,  4 Jan 2025 18:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736014563; cv=none; b=pEhUBwwlzUitv+OVT/4NQxrRvB9QddUJ7U0SDB6n70aB1wuTrgosOlIzy5rbnKM48Kr3dBr3b/V7jHHfBviWcYs+2KfaNmgHOiq5B6J3MM4TD/Eq1lUjiN72RCAcmsxrE7/gwTzmIpVLvCc5m+KVS0oJWAPV09YAzi471L0sSXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736014563; c=relaxed/simple;
	bh=IaYQ8kBRc8cobYhYenjyrdb4XBqNtJy91DFbpAjEA7w=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ro7HVMZopGcv53QPAtL60+o12h3kJXmRON0VMUGTzEzzL8iBlgzyvV+VFZ28RPELmq982u+LetxfJWtIpcrwTPTNkYqBo+EoGV8SWMaTxiHE/XUVNslRwoCw7nyCXpf0hMZcqDlu6uPgce3CxXsTr0FDi7Bav2wnZB2bExSCt/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XZ9hmgEq; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-216406238f9so18573375ad.2;
        Sat, 04 Jan 2025 10:16:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736014561; x=1736619361; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yb7Y/h4+Pv1aSZ2oOWSJWY/zE0yr/7HB8w3rZsmM5a4=;
        b=XZ9hmgEqQjycPvn9+ID9Jf4EF0TjPoxRHFMZW2mBVt7IihMYh3/lHJcYv4hJErZ8kT
         /MMG6NqrHcqcQ5jLvCsOAVyKAuyCTJj7r1Mvr6LgprBaWubOWjv52HfmmivrydfWuHix
         tgjaKfiid7G3d3HNYS9bp8pnzRFAluTXu0oiHtLRzRo7qMUn6zvaHjGDcFbSGcvseWeo
         xwuJxL9UVDgcxp42G8Ab8pfBfRLFMtqrqBeR2hGNDwMWBKww3rh10zGqNhFi7sjiDaNK
         8Fe0Khv83yVYgalnlMIerMPlahNHE+D1LOYTtseQOPDCFyKIfFBTW9g18qW/kacjOyQg
         WPgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736014561; x=1736619361;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yb7Y/h4+Pv1aSZ2oOWSJWY/zE0yr/7HB8w3rZsmM5a4=;
        b=sxULhgvjnT9FeenNNgnZcIZcoZk0s4yZoh6UoGekp9O9bp/XVjXyNrhH2SeUX4oXmr
         a2IeT66KgNlM9nCZu2TAsBJfJ2KIkB1weWRu0PhTKgdIzh7ZAms9d5/L2l5oo4Zo40Pi
         t2GKNqD+MdceYHO1smAn0BrAiWe2SwnENGvnSnEBitpQVVH/Kq8ciGB9tR0rEzJDRmy8
         /Bxuwfoh1WUyBC+qvdv95pM2BqM1iK4wVEZ0KXNBLAaUBBFo1tHvhVR2+NCZSURsmB8g
         plYeJZ195GvrBYqiHmopICfFQ5VWckKp4U+CCVI4Bhxwl7PYC2FFEymYjPPcYhRoOvYi
         /ZFg==
X-Forwarded-Encrypted: i=1; AJvYcCUgAIgiXLwxYMHj8gFfUNcBFRJfMW6kGU+orkk3xG5nLRzYJtKVnwZSWOJK1zO0CKiJteSIc+MSyqdCpmg=@vger.kernel.org, AJvYcCXIDcBEIbJ+6jvlgYMizQZvYwiSGmR/Ht9xQNwDPVd8CWp0VvXZiAN29f9RYLpKsWWaPxn5ZG3o@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6lPV6L33McC2B1VoMwtJHGY7RxPZShE1DVNZi3NrvUaRw3bgZ
	9blaGEX1RsTdz+T7U9lSwiVzl5W0a/amxt8+5+VeVzJ02Kh2qKYf
X-Gm-Gg: ASbGnctXZGtckyICDcm0nKKI81GkUMAwqpAkLOzdvg2HOVvamUCyQdchdVDS+ha8F8/
	na2f155cYfLITVjrPimLJsyCofeyrjDSQP7Fd9ADQ/UD/rX1K73uTtCWAMm1r3sYwN8dllzZMaB
	LcuOF2Q5NS0+V1XAvl3YF1MdiRErFK1avY51apDfCgpxFYigB9AByqqp38TXtwfe39Dm7PwnhRj
	V7+rSVHJ6U4ZlHDxdyCwlvESNDoZK3Xao12J1oBrXANE4oy8hfyJg==
X-Google-Smtp-Source: AGHT+IFvVe0mf4OGrlNYR6QCLDhXWb8EBKluNhJCqX2m4cFckUFbrHdTYUTkcu8al6s/7rbN4ui8nA==
X-Received: by 2002:a05:6a21:78a5:b0:1e1:a434:296a with SMTP id adf61e73a8af0-1e5e045855amr32191891637.3.1736014560498;
        Sat, 04 Jan 2025 10:16:00 -0800 (PST)
Received: from ice.. ([171.76.87.83])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72aad8fb0dcsm29114106b3a.147.2025.01.04.10.15.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Jan 2025 10:16:00 -0800 (PST)
From: Nihar Chaithanya <niharchaithanya@gmail.com>
To: sgoutham@marvell.com,
	gakula@marvell.com,
	sbhatta@marvell.com,
	hkelam@marvell.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	sd@queasysnail.net,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: skhan@linuxfoundation.org,
	Nihar Chaithanya <niharchaithanya@gmail.com>
Subject: [PATCH v2] octeontx2-pf: mcs: Remove dead code and semi-colon from rsrc_name()
Date: Sat,  4 Jan 2025 22:49:15 +0530
Message-Id: <20250104171905.13293-1-niharchaithanya@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Every case in the switch-block ends with return statement, and the 
default: branch handles the cases where rsrc_type is invalid and 
returns "Unknown", this makes the return statement at the end of the 
function unreachable and redundant.
The semi-colon is not required after the switch-block's curly braces.

Remove the semi-colon after the switch-block's curly braces and the 
return statement at the end of the function.

This issue was reported by Coverity Scan.
Report:
CID 1516236: (#1 of 1): Structurally dead code (UNREACHABLE)
unreachable: This code cannot be reached: return "Unknown";.

Fixes: c54ffc73601c ("octeontx2-pf: mcs: Introduce MACSEC hardware offloading")
Signed-off-by: Nihar Chaithanya <niharchaithanya@gmail.com>
---
v2:
  - Changed the commit message to better explain why the code is not
    reachable.
v1: https://lore.kernel.org/all/20250103155824.131285-1-niharchaithanya@gmail.com/

 drivers/net/ethernet/marvell/octeontx2/nic/cn10k_macsec.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/cn10k_macsec.c b/drivers/net/ethernet/marvell/octeontx2/nic/cn10k_macsec.c
index 6cc7a78968fc..f3b9daffaec3 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/cn10k_macsec.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/cn10k_macsec.c
@@ -133,9 +133,7 @@ static const char *rsrc_name(enum mcs_rsrc_type rsrc_type)
 		return "SA";
 	default:
 		return "Unknown";
-	};
-
-	return "Unknown";
+	}
 }
 
 static int cn10k_mcs_alloc_rsrc(struct otx2_nic *pfvf, enum mcs_direction dir,
-- 
2.34.1


