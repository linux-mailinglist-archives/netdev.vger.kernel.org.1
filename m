Return-Path: <netdev+bounces-91465-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 565298B2AA4
	for <lists+netdev@lfdr.de>; Thu, 25 Apr 2024 23:26:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 892C51C20FB4
	for <lists+netdev@lfdr.de>; Thu, 25 Apr 2024 21:26:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E3271553B9;
	Thu, 25 Apr 2024 21:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="f+3lXJq6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBAFF153812
	for <netdev@vger.kernel.org>; Thu, 25 Apr 2024 21:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714080389; cv=none; b=j3b7kOkLL7Gz4URaTs4QKJXxaTokX/7Mxp51NudiPzQE7UD5gTycHXI09xjy+e/CxHA3er5Cw+nXo1y+i++a6dQqxkcFmyHcp2CEmvaITUP02/YPyaCKL1aLzV9wrFqLQNE084Q/NV2H0jaq2mBnG1hbVMHyZ8As2PzRwPh6RKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714080389; c=relaxed/simple;
	bh=p9dKe6PGi+JyhXbK6BGLsXbSJ30ygRk9pgeR5iqV+G8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=X7TfhPFxJ4by13QhsOYNm3aZ69ytilU0+vHkGOgmdJZk9bjHEdSgPfYvp3k/M3v0+6ypbQDqV8JgD78sItWKY4dM7l80ZvLuIZ7m/8hVzqs94wYWQfpv4tkpiBs+Pp5LZXDR88piwss2o4rCYNfpffdwfmXLhvXFUAmHNs7MW1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=f+3lXJq6; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-5c6bd3100fcso998861a12.3
        for <netdev@vger.kernel.org>; Thu, 25 Apr 2024 14:26:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1714080387; x=1714685187; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KBSosczOPmeZ+rUL7ilccZarqFMd/yU4chc0Xq7jKIU=;
        b=f+3lXJq6btOv9GR9py6nET8F50Efv+iITLql70SNV/QvqAw5dtP6JOsoAlQw5bVlfK
         INcckZXlKWToV5n1MBgQi1K4d84Aew3ojIEiwi8JwY8VECH7F51h5Fl2JzblNkkhGS0k
         w3sgjQhODD1PzRKgCr2ut3jMe48ArD0JP0lIIaTFrirtFnPocufqNIJ3uDjOcvqoj+dp
         eylQ8xsSggpHKppKhlTct4Ed+34Tf7cIBbWYulvTZEV5IHnK7Ks7nxamorlTW5+P35UI
         kvdO0R9q3/DDTDTMSywzuRAJ9BWbTLdqIV35LtgV8pAX88BH2x3YhPOvajQNil6uDHO4
         gb/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714080387; x=1714685187;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KBSosczOPmeZ+rUL7ilccZarqFMd/yU4chc0Xq7jKIU=;
        b=p9eFC+S20sEOZfT0cDTqvGfCjLH7paq3lcv1B7EI9wUQtMgPve2Pj8MYvhLLr8/cQa
         i40SY0sqYZ+z/giEHyWKbcYC0VrVEtMAtmr9N2pDYuL78OPKaeRfoUIAv6nCedcJw7bP
         OmbNun2bdnmGrehribIsfgEFs0x4GGKQ53px9LOe2NJ0VnRvm0HC2zylwTrjeJz519ui
         9XycBn528+fL9xvw/9rXfVIB/Z2pVIhePg4xvtjFG8tQGZBvcUPxwcjqAwUoo5mNIm9F
         TOKzSJMS1H4LXZG/qhNQBnf3qDw3FNkwndfumAfk+a6c6Z3yqodS5CkyWqDXeh03wqT/
         RMtw==
X-Gm-Message-State: AOJu0Yy5ipm1OmCXhW+TSu0YhsdUkHw+hQXUWppfSdRKCzAj9xQyrUsc
	OPPFRoFtUunvwWjLfvmE2+bL+2xq/wODOZJSckQ18jevtS2CeyI6d2EAxVez88wr9QxILmzRvtc
	u
X-Google-Smtp-Source: AGHT+IHZOiSPc/XG/0am2gEf8VfElx4yfkyTO15BwsU2//CsLxUwU/cbxIZ938/3DfPi41MUFJtsrw==
X-Received: by 2002:a17:90b:3d86:b0:2ac:40c8:1ed3 with SMTP id pq6-20020a17090b3d8600b002ac40c81ed3mr937099pjb.5.1714080386695;
        Thu, 25 Apr 2024 14:26:26 -0700 (PDT)
Received: from localhost (fwdproxy-prn-011.fbsv.net. [2a03:2880:ff:b::face:b00c])
        by smtp.gmail.com with ESMTPSA id e7-20020a17090a7c4700b002ad6b1e5b6fsm8610969pjl.56.2024.04.25.14.26.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Apr 2024 14:26:26 -0700 (PDT)
From: David Wei <dw@davidwei.uk>
To: netdev@vger.kernel.org,
	Michael Chan <michael.chan@broadcom.com>,
	Pavan Chebbi <pavan.chebbi@broadcom.com>,
	Andy Gospodarek <andrew.gospodarek@broadcom.com>
Cc: Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net-next v1] bnxt: fix bnxt_get_avail_msix() returning negative values
Date: Thu, 25 Apr 2024 14:26:24 -0700
Message-ID: <20240425212624.2703397-1-dw@davidwei.uk>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Current net-next/main does not boot for older chipsets e.g. Stratus.

Sample dmesg:
[   11.368315] bnxt_en 0000:02:00.0 (unnamed net_device) (uninitialized): Able to reserve only 0 out of 9 requested RX rings
[   11.390181] bnxt_en 0000:02:00.0 (unnamed net_device) (uninitialized): Unable to reserve tx rings
[   11.438780] bnxt_en 0000:02:00.0 (unnamed net_device) (uninitialized): 2nd rings reservation failed.
[   11.487559] bnxt_en 0000:02:00.0 (unnamed net_device) (uninitialized): Not enough rings available.
[   11.506012] bnxt_en 0000:02:00.0: probe with driver bnxt_en failed with error -12

This is caused by bnxt_get_avail_msix() returning a negative value for
these chipsets not using the new resource manager i.e. !BNXT_NEW_RM.
This in turn causes hwr.cp in __bnxt_reserve_rings() to be set to 0.

In the current call stack, __bnxt_reserve_rings() is called from
bnxt_set_dflt_rings() before bnxt_init_int_mode(). Therefore,
bp->total_irqs is always 0 and for !BNXT_NEW_RM bnxt_get_avail_msix()
always returns a negative number.

Comparing with a newer chipset e.g. Thor and the codepath for
BNXT_NEW_RM, I believe the intent is for bnxt_get_avail_msix() to always
return >= 0. Fix the issue by using max().

Alternatively, perhaps __bnxt_reserve_rings() should be reverted back.
But there may be paths calling into it where bnxt_get_avail_msix()
returns a positive integer.

Fixes: d630624ebd70 ("bnxt_en: Utilize ulp client resources if RoCE is not registered")
Signed-off-by: David Wei <dw@davidwei.uk>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index be96bb494ae6..06b7a963bbbd 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -10486,14 +10486,11 @@ int bnxt_get_avail_msix(struct bnxt *bp, int num)
 		max_idx = min_t(int, bp->total_irqs, max_cp);
 	avail_msix = max_idx - bp->cp_nr_rings;
 	if (!BNXT_NEW_RM(bp) || avail_msix >= num)
-		return avail_msix;
+		return max(avail_msix, 0);
 
-	if (max_irq < total_req) {
+	if (max_irq < total_req)
 		num = max_irq - bp->cp_nr_rings;
-		if (num <= 0)
-			return 0;
-	}
-	return num;
+	return max(num, 0);
 }
 
 static int bnxt_get_num_msix(struct bnxt *bp)
-- 
2.43.0


