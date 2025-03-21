Return-Path: <netdev+bounces-176772-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 573D2A6C12E
	for <lists+netdev@lfdr.de>; Fri, 21 Mar 2025 18:21:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C889B3B6F42
	for <lists+netdev@lfdr.de>; Fri, 21 Mar 2025 17:20:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67A9622D7AD;
	Fri, 21 Mar 2025 17:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UoXv7emo"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04D651DE884;
	Fri, 21 Mar 2025 17:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742577633; cv=none; b=cxv7dDaJ9D9WUYpM3A/T+epWvfsIQdAkgsolx3SA5co5ckuQU/qkh3I7YaaWNGuM+dpXF/wdCdOvrR9/yYK4cP4ie+xe0XRmye+lOYE1LG+JLJP/uBQt6q5LWzMA/aU3gTs1LPYVHfqb9YWwzsmUUMRXaXNWvhM3YZkGsdkW7AI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742577633; c=relaxed/simple;
	bh=mIxJaqmOR+kvQbNj8S+rNM/60khnudU+oWn6NP2WmTY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Dn4/M+0YyPPH0K3ebRyBQcSoysWUgZd6WSk9VoaZEP2irPVTxnBZzuIkSLyC5Y5gl1M1I9X88oH+cIRQmFtQfm/5Mtk+LcrBUyizcjBTNf9/g0OKe6QaPBfUeWGMcJCoLEZuJthDCN32VB9r9Dd4akv8YhRm+7KlwdvPqXRsVjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UoXv7emo; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-2ff4a4f901fso4359803a91.2;
        Fri, 21 Mar 2025 10:20:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742577631; x=1743182431; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=U6sGvFbK1Wc/EUWtg/RnjOTHdLN0W4J3E0B7yPMrFOo=;
        b=UoXv7emoWO1t48vCZoxF9bV16sErBB79qX8n67IgSQz2uoFbPBY13kGiNcbpeazvIJ
         uVBIh6Z2bXrLWctuVlR2Jc6Stn17aKr79fIHf+yE9IlMJNYYQZ3AzNQNwW/5yMO9cIvD
         74y33fE/aRS3S5oDdFSaolkK6XFNkD6PzH3xihGerAOxW5NMl8ClZxBTHkSvnTuXNEeh
         Kj/9MUWHGx96MBgVYmDhgOhQyPhYDhPJ3pNIjNYaavgIZXmUAqmPUdhbQyrp3nRgbJID
         /WKZGJ7exiWdpB1jEEEQdujyMLCO//qxXDqpOpb95882nQbOpKKGBuGEE+917jEbjlZQ
         PycA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742577631; x=1743182431;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=U6sGvFbK1Wc/EUWtg/RnjOTHdLN0W4J3E0B7yPMrFOo=;
        b=H7lUV1mILY0//M/fO1DC7CiZMhSSr8Pi+PZSHIdaWPnU/X2OomsVOTogdZEuQq2YxO
         2mCo/46s3Tj1oLsWsTKzJb0gs4IiNdS4q2UPJ7H14//zFyz1O5GQS7UhXUrKXLmzvNiZ
         EGzw4DkG0U0lL1qOwFz7y9vlNM0ebXrabszJhuEQsqz7GbXO2kRZ/ywDpAAVGItayOmO
         jCFxH9bTu7B0aICpTwnPrqlzHtfx6XOTPP1CYErOlFJ5vbPNyZvOEwvjAqIhfTpzEL4K
         i0+gWLTB8D+fDM73bFpPiiDg9zPuXT4+WFLZGXx0gnRCwcmDM5aLRKnQ8S3eDp/De3b3
         5+wQ==
X-Forwarded-Encrypted: i=1; AJvYcCW37UMRWNEBuvg4JNkG2uvp+f2L8vRsDFXlxn+m97xsG0c3UlbLTuRjqUF3cMgASyHxdT0Kq/koV+JT8Ak=@vger.kernel.org
X-Gm-Message-State: AOJu0YxaCm99+stDWno1CjQL4FMkyYfBV6td5wRt+6hk1oMymmX3Yygo
	3oyR4+aLDFdkTlzDf7BS7OfWUktSEKIheHxmSMHpQQbxlyRydfxox9lqcw==
X-Gm-Gg: ASbGncuSSJY0JWcNTvzbxcwqPodUeUKt+qYYqcihuXE6rYwne6umKaZorf+whON/9yW
	kW5tkz/w+7lupC822QS8KNUBKU3dNgyecLci8sPhHmcM4lASdN5nI9gfC4l2ZkDF4jVdi+qL7bJ
	jb0I2c4BA8FpaQrW6a2TbMNH78dbQCwE3Y/P6B2vSDJ1LI0kou1YCXcI8Nvziwk0qtWG4P0dNer
	5i3qcG7Tg/VXwz+auZCoZb6CqWeCwSsrMjBVolcgtE0t2cmWCO4ff+cFQBLhsWmoTIH+oTk0YF3
	goEt1KxVy2i0pbFzWcNz0qnloFQxW9oJkQ/gaH38Emz+leBgEac2VOa4VdcZ
X-Google-Smtp-Source: AGHT+IEFoHtY8whCwD8ov2pZYVbRxPBYqbB5FwbQkXbJh2Uh/UX3wd6GfQEQy7mf2C8qigqpso+HKg==
X-Received: by 2002:a17:90b:2743:b0:2ff:4a8d:74f8 with SMTP id 98e67ed59e1d1-3030fe721dfmr5686899a91.6.1742577630955;
        Fri, 21 Mar 2025 10:20:30 -0700 (PDT)
Received: from eleanor-wkdl.. ([140.116.96.205])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3030f7e9e3asm2272875a91.35.2025.03.21.10.20.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Mar 2025 10:20:30 -0700 (PDT)
From: Yu-Chun Lin <eleanor15x@gmail.com>
To: isdn@linux-pingi.de,
	kuba@kernel.org
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	jserv@ccns.ncku.edu.tw,
	visitorckw@gmail.com,
	Yu-Chun Lin <eleanor15x@gmail.com>
Subject: [PATCH] mISDN: hfcsusb: Optimize performance by replacing rw_lock with spinlock
Date: Sat, 22 Mar 2025 01:20:24 +0800
Message-ID: <20250321172024.3372381-1-eleanor15x@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The 'HFClock', an rwlock, is only used by writers, making it functionally
equivalent to a spinlock.

According to Documentation/locking/spinlocks.rst:

"Reader-writer locks require more atomic memory operations than simple
spinlocks. Unless the reader critical section is long, you are better
off just using spinlocks."

Since read_lock() is never called, switching to a spinlock reduces
overhead and improves efficiency.

Signed-off-by: Yu-Chun Lin <eleanor15x@gmail.com>
---
Build tested only, as I don't have the hardware. 
Ensured all rw_lock -> spinlock conversions are complete, and replacing
rw_lock with spinlock should always be safe.

 drivers/isdn/hardware/mISDN/hfcsusb.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/isdn/hardware/mISDN/hfcsusb.c b/drivers/isdn/hardware/mISDN/hfcsusb.c
index e54419a4e731..5041d635ef7f 100644
--- a/drivers/isdn/hardware/mISDN/hfcsusb.c
+++ b/drivers/isdn/hardware/mISDN/hfcsusb.c
@@ -27,7 +27,7 @@ static unsigned int debug;
 static int poll = DEFAULT_TRANSP_BURST_SZ;
 
 static LIST_HEAD(HFClist);
-static DEFINE_RWLOCK(HFClock);
+static DEFINE_SPINLOCK(HFClock);
 
 
 MODULE_AUTHOR("Martin Bachem");
@@ -1895,9 +1895,9 @@ setup_instance(struct hfcsusb *hw, struct device *parent)
 		goto out;
 
 	hfcsusb_cnt++;
-	write_lock_irqsave(&HFClock, flags);
+	spin_lock_irqsave(&HFClock, flags);
 	list_add_tail(&hw->list, &HFClist);
-	write_unlock_irqrestore(&HFClock, flags);
+	spin_unlock_irqrestore(&HFClock, flags);
 	return 0;
 
 out:
-- 
2.43.0


