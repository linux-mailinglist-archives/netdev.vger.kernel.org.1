Return-Path: <netdev+bounces-70337-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A01384E6BB
	for <lists+netdev@lfdr.de>; Thu,  8 Feb 2024 18:28:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B16271F215C2
	for <lists+netdev@lfdr.de>; Thu,  8 Feb 2024 17:28:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7709682D71;
	Thu,  8 Feb 2024 17:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="uAnoltDl"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B5A682D9A
	for <netdev@vger.kernel.org>; Thu,  8 Feb 2024 17:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707413221; cv=none; b=h4Zodz68yPLtohJxnK2WUPZRFG5WWTk8W6RzRQ5XGPSHgSnbOS7FOLrmVVgNjPj6sgg1oK7thCjdqyEOwCAERRCIqHE1I6HK5pRT5ZMXgQKt1YGLiaEE2dJKojss5wc1Oba8DOaTK6lUns9QdI6zhYSzqshD5XP22zJMW7jmTTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707413221; c=relaxed/simple;
	bh=sAUcYMJMyzFIiyiV+W23YViwmOLGkJIxgCN9P9C4P7g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gfejkfZJFYMa+EosClhgm72skF/LAY3JBlMTJy4QuHZbK44dTcHcw6H6HE2BFQrTXz3SHFa0gK2+1rKwUuNA3uT7q0HbSp5FG561ezPaFyqpmLNUmqbAoOSo91Q7rVzrT4pf71S76nLvMx+JZzyVjaIBU0yzD/jdtc5fXNTIvjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=uAnoltDl; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1d71cb97937so76705ad.3
        for <netdev@vger.kernel.org>; Thu, 08 Feb 2024 09:26:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1707413217; x=1708018017; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sDMUhkhn6m1E5wpu6uGtdgKk5XvzlhzIOpvLeEmDVgI=;
        b=uAnoltDlZHJHRvArCSm3VUyS4UqVEYYAsGs5sELtiFPQe+9yzC1VB40BwyGzLfqqb+
         LC35Y7CNPO/sSp+71hApPQWAA2YQH0JHF3mbowWpi1MYJ7LA+o1lfpBh88r+FPTMyj57
         GDItKNPnbSvSWO6JJjdaiXgDEVgqnKk0NcAo0NcT0WT77i+HPABXdGu2M1FgI2ctBw5q
         5FYDRJpx7ZhKjgMsBpF+2Cw6h5ok1P0IoEp0XI2FJd5W7jWpCFVzzamwW8KP3ZOmD+G/
         qTNRTPBKf2xnEB5x6B6pGq2XVkXg0ho/UZPvQTAJ0C4nd6rQRJO9B3c3qi7zxsPhVgVN
         zlyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707413217; x=1708018017;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sDMUhkhn6m1E5wpu6uGtdgKk5XvzlhzIOpvLeEmDVgI=;
        b=fx0jHW841MxDWlxJwFhCT3CBRVWDLae567G7CjA1C+ZO+M4GemCrTpOoVBejvFZQLV
         RAknFIo6b+UoiQHF7b1tfMxUELLPAEsuGcZKqUXbZgSFene/fK51RwfDJsbgkuD9Brjt
         os/5JvAgrSZ5b6mUl4x5bc6eGo4o0ykVoFtejsfMJEGJXi6fz5MpjuIm3C/O432FAmqe
         NUWJ/NwOaIQ4MR6l1wcxabJzFTGram/U6WurewK751uCZ3nM/dc3sq75Re6L0YRzWe7J
         GIQ8AZyzhD6VEUMWvwru0BoP2ljnFSdkFHB2M+RpVq4/MqcDckCoEsj3viguBHcLjq4G
         BE6w==
X-Gm-Message-State: AOJu0Yw2On3Cwnc36X8GZ3dUuBSVV480LRgwhPTkrSUAvC59ZxQVlPif
	OkfWOTwC8R2K7QtFkiFWTcUUHcDybBFCtNB7XwETqwzn1btSAbe3n4k5udkvp1AHxB4fU3diRV3
	BIis=
X-Google-Smtp-Source: AGHT+IHfcwupqHhTPu8cr0mqIpBdXCrNvQ/CQpYmcmLCyqFGNtHhjmDFeZx1/vmBRuyckznHQg3D/w==
X-Received: by 2002:a17:902:e751:b0:1d9:727d:e84f with SMTP id p17-20020a170902e75100b001d9727de84fmr11371126plf.47.1707413217677;
        Thu, 08 Feb 2024 09:26:57 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWfMR6h+KCM6J91q/bWGUjmeqHK//gZ+xUWN02uKxXZDia76tVjJcmvH/HiRp3pHzzUm/mTlkVwvwpMMQKSqxwl368rww5oVMAczA==
Received: from hermes.local (204-195-123-141.wavecable.com. [204.195.123.141])
        by smtp.gmail.com with ESMTPSA id g14-20020a170902f74e00b001d9d4375149sm42265plw.215.2024.02.08.09.26.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Feb 2024 09:26:57 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: netdev@vger.kernel.org
Cc: Maks Mishin <maks.mishinfz@gmail.com>,
	Maks Mishin <maks.mishinFZ@gmail.com>,
	Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH iproute2 1/3] ctrl: Fix fd leak in ctrl_listen()
Date: Thu,  8 Feb 2024 09:26:27 -0800
Message-ID: <20240208172647.324168-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Maks Mishin <maks.mishinfz@gmail.com>

Use the same pattern for handling rtnl_listen() errors that
is used across other iproute2 commands. All other commands
exit with status of 2 if rtnl_listen fails.

Reported-off-by: Maks Mishin <maks.mishinFZ@gmail.com>
Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 genl/ctrl.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/genl/ctrl.c b/genl/ctrl.c
index bae73a54bc37..72a9b01302cf 100644
--- a/genl/ctrl.c
+++ b/genl/ctrl.c
@@ -334,8 +334,9 @@ static int ctrl_listen(int argc, char **argv)
 	}
 
 	if (rtnl_listen(&rth, print_ctrl, (void *) stdout) < 0)
-		return -1;
-
+		exit(2);
+	
+	rtnl_close(&rth);	
 	return 0;
 }
 
-- 
2.43.0


