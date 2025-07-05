Return-Path: <netdev+bounces-204309-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E48EAFA089
	for <lists+netdev@lfdr.de>; Sat,  5 Jul 2025 16:50:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 78E0917E116
	for <lists+netdev@lfdr.de>; Sat,  5 Jul 2025 14:50:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EEE11E0DD8;
	Sat,  5 Jul 2025 14:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EV0XFksa"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25A0814F9FB;
	Sat,  5 Jul 2025 14:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751727043; cv=none; b=SmvP6540Or668GQgGFiijdQbY9U/QTIahO9nHokGdUW7iwbkkUX9McF7sVKWfCSVJ9ni26T9Se0g0MFBhLqDGyXHPPOvEf5+CYTVnBSmR5nXe6GBoROZHvK91x8r/+/IunyTmWrp+yX7Szm8w138nGGnr3tv4vCic8WK8CcUetM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751727043; c=relaxed/simple;
	bh=VNrbBwqm1/43mVvgHdyCXrjAkPHvz/X7v8AvboKMajo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=W++UapMgfY+WoHzwVJZxzPEV6uiQBUeccevRaTtT/oXuTB1T8/qWEZJ+5vwyoRO1RHA8z0I54iZLvqUKbSU0vHr6kV50Aith8RNShouWIhkpkLb9h9YjOFtD86TT5L73KLNkgP1Kdr+Oka2k2G0S0CKWyvytFiqxBMACoQ++VbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EV0XFksa; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-74ce477af25so959608b3a.3;
        Sat, 05 Jul 2025 07:50:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751727041; x=1752331841; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=e8pSX2dE7HUbGX2qtP2ExLxJQJpQ+y89OCidZcpPV4Q=;
        b=EV0XFksacpfV9OQYvrQzhkfEjRKvs+/wBhLB/EmR/xD9DoB9xdGe0w/n9SJ8LCvZy5
         ysXWpXCd+VRbc0+sQEonfKrkr6L7EF3tex/keKA1Sgf4Rz1eXJ6yVjBlYO5VDrEq6QR4
         tahfWaqlxIYBRWoGHdYMdDhvD9KS0U3I95Yq+ztZB5nLZCE1dgs1OkNEDonvh3eCoVvG
         3iBruOODEBc9In45rJhCE3k1D2oOJI7FtTjdsXfpVaHZDxqoxaZZ8ytJyTcQF/r+c+YD
         cadDcbyNCMXNetUpwzdmsmcofBpNzUcGfMBmu1WI2zW8revwOjhPIeVGdMS6dcwA3MZC
         5GOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751727041; x=1752331841;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=e8pSX2dE7HUbGX2qtP2ExLxJQJpQ+y89OCidZcpPV4Q=;
        b=cMrgzAtvXKqyEjQ6P/aZnnWl/BdTIxSZUjf318VJkEqODP0W5E/X9eT9LT4ow3PzAs
         +Idl/bhs3WvI0MztMXjJA4B937w9h4oiXepfyk+aq7m4vec6bF0Wf4p4RXXc7iy/FOPp
         K3c3QUFoWwboXdzUWylsTPlnFSe/YqmzUP8Hye8BKCyQRFVuHFYJa0awTEBMSYYSSYrJ
         xx1yMs1KpGO1ETaoow9LvITiKjtwlnmeo1EI/XLWgDeALD3VKtp0jpWv8zo7n4MdlkCy
         5mfH3u9kIvwXtKyPkO82nQ9jyv+sSVupLudKnk4+QnHBbx1RoDYN1m0aL/VksXaTayKX
         6Qug==
X-Forwarded-Encrypted: i=1; AJvYcCUuLj/U21JTb9qRkZUOLMZVRbzkwyjh+T5dDsdPfTRWnfKR5bB9yia4xk9yavkCjf5XDJyfYt/d@vger.kernel.org, AJvYcCVxfUs+mLHAWbM5Mi00DjMph6Ay7vFfvMDeZPAQnoF/4thxxBEtfy9RwS2+kwGus4ibe0QZgQPOUHawQ2w=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOgX3G3LjUgCgd32QA9/aV4Tx0xpBSvbO4+s12/lWHPyFv+CJy
	PMxcEdGG0Rg0J9ZDc7Lvrm/MzZajHsOeWfhR3u6FUGU+Yd2zyBPK1vbx
X-Gm-Gg: ASbGncvoX+rgDObmdyxwSPCNRYfAwFr7YbUhDBrmgWgkZ+xWxk2aSwa+44rrRa8uYp3
	Uexm+xi7l7jL4BI+kUXa4Nr1Ou6Jy0wybZQWQ5Cc+wZDZVQOboI+kMRdRKsk8apGrqEOS1TzuCf
	LqboQUFM/yisIo5EeHC6rWUfLEdCg4Rvn4z/cvXHbX4a5vE70LUJLbYhDzzYMfJQ7rgdo5QYh1t
	OVE7J7a1kpyLaaIwv8I02IeeBFjoOKa69c/WO2LKWJDvkwObb9rbAMwA7mWa+f/ss5rZMvRz95g
	eCNUASlMxDUfMSTyzfjNsXw6WuDG4ZPztxmtA0+O3tH49v6K9XuLONd6ROfn1j3qMJ36agNzV3C
	u/MQJqmSPatPE5OU=
X-Google-Smtp-Source: AGHT+IHWzck6wI2NIMUulug49eFSbkQNtWifhf7LcrXsIil/8ND/dU180sJae9vQvyflbC+N4C50dA==
X-Received: by 2002:a05:6a00:2e9e:b0:742:a111:ee6f with SMTP id d2e1a72fcca58-74ce650ecc9mr7177111b3a.10.1751727041391;
        Sat, 05 Jul 2025 07:50:41 -0700 (PDT)
Received: from localhost.localdomain ([121.185.186.233])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74ce359eeddsm4642499b3a.7.2025.07.05.07.50.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Jul 2025 07:50:40 -0700 (PDT)
From: Jeongjun Park <aha310510@gmail.com>
To: richardcochran@gmail.com
Cc: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	yangbo.lu@nxp.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzbot+7cfb66a237c4a5fb22ad@syzkaller.appspotmail.com,
	Jeongjun Park <aha310510@gmail.com>
Subject: [PATCH net] ptp: prevent possible ABBA deadlock in ptp_clock_freerun()
Date: Sat,  5 Jul 2025 23:50:31 +0900
Message-ID: <20250705145031.140571-1-aha310510@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ABBA deadlock occurs in the following scenario:

       CPU0                           CPU1
       ----                           ----
  n_vclocks_store()
    lock(&ptp->n_vclocks_mux) [1]
                                     pc_clock_adjtime()
                                       lock(&clk->rwsem) [2]
                                       ...
                                       ptp_clock_freerun()
                                         ptp_vclock_in_use()
                                           lock(&ptp->n_vclocks_mux) [3]
    ptp_clock_unregister()
      posix_clock_unregister()
        lock(&clk->rwsem) [4]

To solve this with minimal patches, we should change ptp_clock_freerun()
to briefly release the read lock before calling ptp_vclock_in_use() and
then re-lock it when we're done.

Reported-by: syzbot+7cfb66a237c4a5fb22ad@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=7cfb66a237c4a5fb22ad
Fixes: 73f37068d540 ("ptp: support ptp physical/virtual clocks conversion")
Signed-off-by: Jeongjun Park <aha310510@gmail.com>
---
 drivers/ptp/ptp_private.h | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/ptp/ptp_private.h b/drivers/ptp/ptp_private.h
index a6aad743c282..e2c37e968c88 100644
--- a/drivers/ptp/ptp_private.h
+++ b/drivers/ptp/ptp_private.h
@@ -124,10 +124,16 @@ static inline bool ptp_vclock_in_use(struct ptp_clock *ptp)
 /* Check if ptp clock shall be free running */
 static inline bool ptp_clock_freerun(struct ptp_clock *ptp)
 {
+	bool ret = false;
+
 	if (ptp->has_cycles)
-		return false;
+		return ret;
+
+	up_read(&ptp->clock.rwsem);
+	ret = ptp_vclock_in_use(ptp);
+	down_read(&ptp->clock.rwsem);
 
-	return ptp_vclock_in_use(ptp);
+	return ret;
 }
 
 extern const struct class ptp_class;
--

