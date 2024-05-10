Return-Path: <netdev+bounces-95526-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97CAF8C282F
	for <lists+netdev@lfdr.de>; Fri, 10 May 2024 17:49:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 53872281F3D
	for <lists+netdev@lfdr.de>; Fri, 10 May 2024 15:49:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0F0617164E;
	Fri, 10 May 2024 15:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fy/UZ7p5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3522612D219;
	Fri, 10 May 2024 15:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715356193; cv=none; b=kY7+aDkj2g1zl+Aa8fXRWnDc057GqHXurFcB0TSPaSQFFw4XUrDPvYQT3/VGweAux7rR5ZcU/R5yDOMcty4Cyye/qzrREc2rLyNojUX0TWYdJ6Y7OVqBK9rubxyFZqBo0r0318rsYNFwZ3S396fwAN2WpdQYySXgV+bccctD6Dk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715356193; c=relaxed/simple;
	bh=Od4nxU4X6xwqL+ebmwwfcWBckbUl2Q7ZO4pWAEmcNWg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=qx9XpcZuftjcSwquKHbnE80+/UEDpw/tVHa+BISIs9P//GvYX8KfhriqSpWYB2+Qs/9qx8YBVqCruowKgIei5n1Kh2mghYqkF1e60ZBao6sjJCFuSlDzciM9Q50xeDZv0tOfKzEXodJwZCY8qqgVJ8VSOGauY5DQubbNr0VTYYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fy/UZ7p5; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-69b5ece41dfso7476936d6.2;
        Fri, 10 May 2024 08:49:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715356191; x=1715960991; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pfeNlMB2/7cD5tCj3Uvt8PWM/rRJKtKvL0ijzXvDIZc=;
        b=Fy/UZ7p5nhOWsN6LZ5AkwtrBlZRxfEq+yXK9dZ93p1SRMFcdz9Y0QQJ2lQVIhvCl/h
         rDkmHqUKfp4UTfPGIOqvyNmCh9HRiTBC1XX34Mfzgi1BQnXLOndQd+C1LfAA5chRpl3Y
         b64L7OalITxifcyez3cM4PVDfQMiTY2EiAF81e3fs0JlsH1Qbeo9nnqYcEhsI8eG4Urt
         AbJ9Fby6CFzE579JJz6PAUWPaXbZa6vyI0yPS7FpRWIPOYlog4//A/SR40h2u03jChLy
         DWK1FjHLWgj1ie3EngNw7bFpUAWn6z/LR+mp4FYgUm7wJlFcUFXrRB6w+0b2Blf9vOhT
         0jjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715356191; x=1715960991;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pfeNlMB2/7cD5tCj3Uvt8PWM/rRJKtKvL0ijzXvDIZc=;
        b=EmFcJZzKoQAe8QpeZfEgA/VQD7HxSm03lZxW6HWZcOK16puJg5Maz0fO4yD8n5Hjcn
         d6qQas1Za5OKXwjRnZIokEGD9Li97YrdLEEClL0IhwL+rp6UKlrzQrb82rz12++7K6YY
         Wkqba4xYJGVTE1+nOyE5MzO/DtzxeAPXWvf+pQBEUHKqHW+Oc918P3rFkaGEEmdceTUk
         D+IUHgIL1227MYaFgeZkjUGRQGoxNay6i9WT9RdEzJopw6Eb0smf/j8CCmbtmDtXJiwZ
         kEkdJ2nj11y+oLACq7Bi3gWvCqD5QpRoEIM3mBvTCtE/9d93e4ErjOb7g8fuDbrGFhaB
         kejQ==
X-Forwarded-Encrypted: i=1; AJvYcCUMKb2W7DjMD1TI16OMu7zVQqDij3mDfTIcvtgsRtjARSc66S/PvF/NAezGUS5v/KXcmIvc05+4xRXy+OTUfVQwxVhiAgwQ
X-Gm-Message-State: AOJu0Ywz/IPTn7mvb4E4lbJI2Yw2Ues3d83xiWyacHbo13+V7ueN098Q
	fM4fkIG3vZ1p8LvG9xsCmurvme5H9QHfIElSDViOvZV+QBPmvapdq77MhuEH
X-Google-Smtp-Source: AGHT+IGSFmemxPc1q2ygxv9RTcMLNNR2iJMuortMNluLB1wMRFh5zLgiUFw/EOg98I26qOeI3yhVFA==
X-Received: by 2002:a05:6214:5b0a:b0:6a0:e2ca:1e69 with SMTP id 6a1803df08f44-6a16822ae19mr27305386d6.29.1715356191123;
        Fri, 10 May 2024 08:49:51 -0700 (PDT)
Received: from TW-MATTJAN1.client.tw.trendnet.org ([219.87.142.18])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6a161adc751sm16438226d6.21.2024.05.10.08.49.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 May 2024 08:49:50 -0700 (PDT)
From: Matt Jan <zoo868e@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Matt Jan <matt_jan@trendmicro.com>,
	Matt Jan <zoo868e@gmail.com>
Subject: [PATCH] connector: Fix invalid conversion in cn_proc.h
Date: Fri, 10 May 2024 23:49:19 +0800
Message-Id: <20240510154919.874-1-zoo868e@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Matt Jan <matt_jan@trendmicro.com>

The implicit conversion from unsigned int to enum
proc_cn_event is invalid, so explicitly cast it
for compilation in a C++ compiler.
/usr/include/linux/cn_proc.h: In function 'proc_cn_event valid_event(proc_cn_event)':
/usr/include/linux/cn_proc.h:72:17: error: invalid conversion from 'unsigned int' to 'proc_cn_event' [-fpermissive]
   72 |         ev_type &= PROC_EVENT_ALL;
      |                 ^
      |                 |
      |                 unsigned int

Signed-off-by: Matt Jan <zoo868e@gmail.com>
---
 include/uapi/linux/cn_proc.h | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/include/uapi/linux/cn_proc.h b/include/uapi/linux/cn_proc.h
index f2afb7cc4926..22f9419498ca 100644
--- a/include/uapi/linux/cn_proc.h
+++ b/include/uapi/linux/cn_proc.h
@@ -69,8 +69,7 @@ struct proc_input {
 
 static inline enum proc_cn_event valid_event(enum proc_cn_event ev_type)
 {
-	ev_type &= PROC_EVENT_ALL;
-	return ev_type;
+	return (enum proc_cn_event) (ev_type & PROC_EVENT_ALL);
 }
 
 /*
-- 
2.25.1


