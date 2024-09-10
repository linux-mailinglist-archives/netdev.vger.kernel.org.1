Return-Path: <netdev+bounces-126930-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DB8A97311B
	for <lists+netdev@lfdr.de>; Tue, 10 Sep 2024 12:08:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E764B2893A5
	for <lists+netdev@lfdr.de>; Tue, 10 Sep 2024 10:08:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0790C197A99;
	Tue, 10 Sep 2024 10:04:38 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36535198A32;
	Tue, 10 Sep 2024 10:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725962677; cv=none; b=hVtCuM7LurSjyZtkgt2+qQrJxTYWkjqSB/1C++UPVxB2BUHcZ4wDKJ3i12zHGnb57WpVQZ5yaN11xI8meVJkwvBxvNeVqVeS99YHMk2V9Pt22a5oGU5Cf7OOgwUXhn4gbheyc2CiR1qp9CI1WoCfBK2fZfVZr+awsMtsNApx/Yw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725962677; c=relaxed/simple;
	bh=mr7ozxLYNIKSDK28c1JS/rg+dGy/5mHfdcu4ZO66wkk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OnRm5fu2YRXmC/oDMTCmn7I6wyYsr+JLuUdbrSBeQqi/4mVx3FTas88+FoxpFp/RxpAcoAtEF20drYWarljTzE+nyr2N8CBizLfJc2kcdgQ1AXIXMYfotE0CjGP/t2w9o+pk1mHGOwVE9bAO9ZAvaLTJakQsaJUo+o3Ws1Q+wUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-5356aa9a0afso9241678e87.2;
        Tue, 10 Sep 2024 03:04:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725962674; x=1726567474;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7YPaA0LtjHQmgp6W5R5O8D3n6pkkJ4FmCPhF61F3u3U=;
        b=vcLs0KzUoejPuklVALqjquVrKQY59uIR0hHHYS7VbvYsOpyeXVKQVxVcrYYFwUc9re
         c5KkTn4nbps/V18ObnTeUokqbYO1f0qnLpEFJgXlel4In3eTpgLVRJQn8E4opb9+/6D8
         EpFWQ6BB+sa/hUDwy+DX6tG2ZkYzyWFtMIiwbH8ejZ0hcsGsAsLa6LpUaGlhstyhNK0e
         Uqay0e2xde5hfJiwkL0YZl4tC0qI3w/4QjHVKeUU1XB5IR6w2xoZH/Iad5unEYr2tEKG
         oPdKxV5eNWNQc28Bl+rzztCR/8V5+nIUmgupxiWcoDLzYrlqhY5dPhxAKlNRwcLGtXuZ
         97FQ==
X-Forwarded-Encrypted: i=1; AJvYcCVaqogqAC8V/APmvqD4Cod+FP/Mgg65eHkSXfHmG6r8VFutptqLRSd/zVGHmCz8AcoWimYMsUGu@vger.kernel.org, AJvYcCXp3YV8DwxP92cKZMF/NaFg1vfm3vjijoMtDfs5hpRsMaFTmoLRPV4yvijpRB6MsBVZHVbEqLbWmbolIjI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0Pvy9qgjxyVDaBPI3sXayOpU3ZhRHMc/ylw8xHyTfnFAyKaZy
	KsHIqCpQk1lJE806tOfR5dOtohObzxZPoNPKImtJBgMBUjTDvw3S
X-Google-Smtp-Source: AGHT+IEhejx+G4yTvW5DvEUXUkfw9eLFs1/+vlLl+MqIm3iMXRw35/iBTH7WV91UbQiFrDGi41qZNw==
X-Received: by 2002:a05:6512:1245:b0:536:54bd:8374 with SMTP id 2adb3069b0e04-53658818949mr7594604e87.60.1725962674110;
        Tue, 10 Sep 2024 03:04:34 -0700 (PDT)
Received: from localhost (fwdproxy-lla-116.fbsv.net. [2a03:2880:30ff:74::face:b00c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8d25ce86e0sm462696166b.143.2024.09.10.03.04.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Sep 2024 03:04:33 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
To: kuba@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com
Cc: thepacketgeek@gmail.com,
	horms@kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	davej@codemonkey.org.uk,
	vlad.wing@gmail.com,
	max@kutsevol.com
Subject: [PATCH net-next v3 07/10] net: netconsole: extract release appending into separate function
Date: Tue, 10 Sep 2024 03:04:02 -0700
Message-ID: <20240910100410.2690012-8-leitao@debian.org>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20240910100410.2690012-1-leitao@debian.org>
References: <20240910100410.2690012-1-leitao@debian.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Refactor the code by extracting the logic for appending the
release into the buffer into a separate function.

The goal is to reduce the size of send_msg_fragmented() and improve
code readability.

Signed-off-by: Breno Leitao <leitao@debian.org>
Reviewed-by: Simon Horman <horms@kernel.org>
---
 drivers/net/netconsole.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
index 1366b948bcbf..2cdd2d6a2a18 100644
--- a/drivers/net/netconsole.c
+++ b/drivers/net/netconsole.c
@@ -1084,6 +1084,14 @@ static void send_msg_no_fragmentation(struct netconsole_target *nt,
 	netpoll_send_udp(&nt->np, buf, msg_len);
 }
 
+static void append_release(char *buf)
+{
+	const char *release;
+
+	release = init_utsname()->release;
+	scnprintf(buf, MAX_PRINT_CHUNK, "%s,", release);
+}
+
 static void send_msg_fragmented(struct netconsole_target *nt,
 				const char *msg,
 				const char *userdata,
@@ -1094,7 +1102,6 @@ static void send_msg_fragmented(struct netconsole_target *nt,
 	static char buf[MAX_PRINT_CHUNK]; /* protected by target_list_lock */
 	int offset = 0, userdata_len = 0;
 	const char *header, *msgbody;
-	const char *release;
 
 	if (userdata)
 		userdata_len = nt->userdata_length;
@@ -1113,10 +1120,8 @@ static void send_msg_fragmented(struct netconsole_target *nt,
 	 * Transfer multiple chunks with the following extra header.
 	 * "ncfrag=<byte-offset>/<total-bytes>"
 	 */
-	if (release_len) {
-		release = init_utsname()->release;
-		scnprintf(buf, MAX_PRINT_CHUNK, "%s,", release);
-	}
+	if (release_len)
+		append_release(buf);
 
 	/* Copy the header into the buffer */
 	memcpy(buf + release_len, header, header_len);
-- 
2.43.5


