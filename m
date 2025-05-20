Return-Path: <netdev+bounces-191935-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BEAF6ABDFFE
	for <lists+netdev@lfdr.de>; Tue, 20 May 2025 18:07:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC1033A6B53
	for <lists+netdev@lfdr.de>; Tue, 20 May 2025 16:07:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93D1B269CFA;
	Tue, 20 May 2025 16:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TGkLMI+f"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06755241696;
	Tue, 20 May 2025 16:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747757263; cv=none; b=JTSoUY+TKBflwxal+TYKAGsGqF4zKnZ/drpZT2tOlRIzxCO3OQaLPDEf9YiKTn24b/rRu4Gx2W3za5qqjOCvevk689rnyrsbjwXV45OWFTJshiWPq7LrEFtGp0XHkZycjBcuDsOUqxIpPk5u6EGAwZlYLwxZ7npIZH+HYfICYyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747757263; c=relaxed/simple;
	bh=sOzjotnO4jDD0opsHU7773NR8s7oyPcDu4CT5dafdK8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=r+bQneJNDumZbXF6Up9KM0wlEtRjS1NQWuFFnc/TbLX3ojebCyO0/IzPhVn6WFiMj8P01HBq3HlmXOuO5aFO+ru+RhcHzuB+5UQGTwwU+wMgutBzC3l3wnPdfyrbSyd1O6jlS/QqZtDaNCMLaEQ8jaWEgNh10/e7j4nQiLvzKgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TGkLMI+f; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2320d06b728so26532405ad.1;
        Tue, 20 May 2025 09:07:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747757261; x=1748362061; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=f+e4tDb9ZmYBKg9MrFn8FNPWvTvXxngCCXTAK6EIg70=;
        b=TGkLMI+fBT0FFYACt9VrvVZTmoqkcLFRG666DYNSUexnJ/bGWZae0PoeVTfpRxRTz3
         SBdbY8X2xdqT4IBJYPdszW9hX9hgQ5SgpROYzRntl0PhXsQfgI5PYfog8gZEs+Jn67WZ
         9NWaUeBOnQg1OSaerjOS8bFnVYUygW9u5p+up7b5mTkLi1UXDQ3fH8b3kYJe84tKFKa8
         RvwSS+34zuXgnrCWNI9V2QQYSLzBYCvtYyiEeK+voGwPLWp0tXaPdBN8NbFQ99j6WpJC
         8s2D7IYV3N853M/KwD1VlJfoOUbNJtMMpP8Do4IUsdsrMCXWOEItb/tugue86YzLzDBy
         9rxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747757261; x=1748362061;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=f+e4tDb9ZmYBKg9MrFn8FNPWvTvXxngCCXTAK6EIg70=;
        b=j0rB8UTAkyIuSI60Q+i3J2ya0yRu1g/rRb9tBy4Oo0x52udR3vOsx+wmPbePbcxam1
         LAgqi8m4JZp8BhJXGoEaM+ryiL3T0evooKCCDBjOLw3pXCgietz32IhYgX+w006Zcw2L
         po5AwGz1BtZUUMg9ZlRFnSJBN0i0KgjhSsoCKEqpSUCp4aluY9NxCifzbelEjr6kR0m5
         Pq3VlE/tnLPOcXFDKVM8VIw3peeX4UlGwqaIHcf3/aGxVhXvNLBTeIvAzgOVuvqH+xg+
         tHF9W8DmSHM4VrucbwKoCYris02gU/WS3GgQ1vSgDDe4/NwPlDtbovawnXRXjWLeUcU2
         hgOQ==
X-Forwarded-Encrypted: i=1; AJvYcCUZQ+vGUKgiy1fi4ZamahxyDY4hMtVYbcNgvktq/kSxUGpWu3cBV/h6Ku61eUVq1Ct1bSHfE/HJIOfvlQo=@vger.kernel.org, AJvYcCVSA7FeelJmg78s8t4dtYHuHJf54JS1OgsAbdZSyKrJVQpkDNfmBsqXF4bGUS8r4t2s3BUKVDw+@vger.kernel.org
X-Gm-Message-State: AOJu0YwJzDEOMPqPhQufbbCLqBYo5NmqXCRIetvFzDzbsEOXuHwI82Ux
	YdcW0MGt34i3cmLJ25DkIPXAj1kTuz3nAQRj7ORa8ol1iRtKHIrzRVfV8rb/45nk
X-Gm-Gg: ASbGncuSJ9EC7Lf7KjToHkTuCziBX92nZvOcFK3WIi8L54D1MvyOHIWaOgNWLY/6pa0
	+23DPeog7yk6tuWUmsUbA18pYdegesN1TnJOG39C2iERpauu8feL6TlelokrFwKpvCHSJfVPe5V
	EJYjtYjI4SyWVGxSnOKiOMQpGLNSGRUVb/Qesj3jmPC9Q7NBsG8gCeuroSERHABWmgB2QVVA4sY
	gZYycHm0uwI5Xu48W9tjmSXwZ6Y1MPMG5ZIEyPQkYT+oBx8oDYqnUd/BsIudrxlpqdCWUD9pAiG
	ce+CJZLcImnQoHzK768YhKmyTaOnxO7RxvqvDZ+aaClBIzFo7x7Mbb04K8R2ww7kjF7XZYd90e4
	7uIXN
X-Google-Smtp-Source: AGHT+IFf3tN7oijoQgx+fn/tyZ59P4T81j705hb5/J9qCMNqj3PXl7fndl3gCph+ZwZSZRjLMhwkdA==
X-Received: by 2002:a17:903:1acf:b0:224:255b:c934 with SMTP id d9443c01a7336-231d4583e46mr225839065ad.51.1747757260890;
        Tue, 20 May 2025 09:07:40 -0700 (PDT)
Received: from localhost.localdomain ([121.185.186.233])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-231d4adb73esm78383735ad.59.2025.05.20.09.07.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 May 2025 09:07:40 -0700 (PDT)
From: Jeongjun Park <aha310510@gmail.com>
To: richardcochran@gmail.com,
	andrew+netdev@lunn.ch
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	yangbo.lu@nxp.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jeongjun Park <aha310510@gmail.com>
Subject: [PATCH v2] ptp: remove ptp->n_vclocks check logic in ptp_vclock_in_use()
Date: Wed, 21 May 2025 01:07:17 +0900
Message-ID: <20250520160717.7350-1-aha310510@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There is no disagreement that we should check both ptp->is_virtual_clock
and ptp->n_vclocks to check if the ptp virtual clock is in use.

However, when we acquire ptp->n_vclocks_mux to read ptp->n_vclocks in
ptp_vclock_in_use(), we observe a recursive lock in the call trace
starting from n_vclocks_store().

============================================
WARNING: possible recursive locking detected
6.15.0-rc6 #1 Not tainted
--------------------------------------------
syz.0.1540/13807 is trying to acquire lock:
ffff888035a24868 (&ptp->n_vclocks_mux){+.+.}-{4:4}, at:
 ptp_vclock_in_use drivers/ptp/ptp_private.h:103 [inline]
ffff888035a24868 (&ptp->n_vclocks_mux){+.+.}-{4:4}, at:
 ptp_clock_unregister+0x21/0x250 drivers/ptp/ptp_clock.c:415

but task is already holding lock:
ffff888030704868 (&ptp->n_vclocks_mux){+.+.}-{4:4}, at:
 n_vclocks_store+0xf1/0x6d0 drivers/ptp/ptp_sysfs.c:215

other info that might help us debug this:
 Possible unsafe locking scenario:

       CPU0
       ----
  lock(&ptp->n_vclocks_mux);
  lock(&ptp->n_vclocks_mux);

 *** DEADLOCK ***
....
============================================

The best way to solve this is to remove the logic that checks
ptp->n_vclocks in ptp_vclock_in_use().

The reason why this is appropriate is that any path that uses
ptp->n_vclocks must unconditionally check if ptp->n_vclocks is greater
than 0 before unregistering vclocks, and all functions are already
written this way. And in the function that uses ptp->n_vclocks, we
already get ptp->n_vclocks_mux before unregistering vclocks.

Therefore, we need to remove the redundant check for ptp->n_vclocks in
ptp_vclock_in_use() to prevent recursive locking.

Fixes: 73f37068d540 ("ptp: support ptp physical/virtual clocks conversion")
Signed-off-by: Jeongjun Park <aha310510@gmail.com>
---
v2: Remove changes unrelated to the patch subject
- Link to v1: https://lore.kernel.org/all/20250519153735.66940-1-aha310510@gmail.com/
---
 drivers/ptp/ptp_private.h | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/drivers/ptp/ptp_private.h b/drivers/ptp/ptp_private.h
index 18934e28469e..528d86a33f37 100644
--- a/drivers/ptp/ptp_private.h
+++ b/drivers/ptp/ptp_private.h
@@ -98,17 +98,7 @@ static inline int queue_cnt(const struct timestamp_event_queue *q)
 /* Check if ptp virtual clock is in use */
 static inline bool ptp_vclock_in_use(struct ptp_clock *ptp)
 {
-	bool in_use = false;
-
-	if (mutex_lock_interruptible(&ptp->n_vclocks_mux))
-		return true;
-
-	if (!ptp->is_virtual_clock && ptp->n_vclocks)
-		in_use = true;
-
-	mutex_unlock(&ptp->n_vclocks_mux);
-
-	return in_use;
+	return !ptp->is_virtual_clock;
 }
 
 /* Check if ptp clock shall be free running */
--

