Return-Path: <netdev+bounces-126925-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 47AC497310E
	for <lists+netdev@lfdr.de>; Tue, 10 Sep 2024 12:06:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E84B91F2365F
	for <lists+netdev@lfdr.de>; Tue, 10 Sep 2024 10:06:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E90E19306A;
	Tue, 10 Sep 2024 10:04:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C528514D431;
	Tue, 10 Sep 2024 10:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725962667; cv=none; b=IHHG+FrEIlTesR1//d0MeFxWUY7RHSiL2l4mTGVNxdjpmPMEUKZnK9PMsOQB3WAKt4ZFeSyQXytr2l50YUQhgf5OPPpK+bfAWZYjzN3ooVL+bEPLw/wcP3+TJ+ajbb1LBj9x3W+VOb8POtjxIk8dncg02C6yqqJ76imIAI1/Dkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725962667; c=relaxed/simple;
	bh=oJIDy0qtaGw6j830beA+G8p0IPumns4yvWEkwTqum/Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qyVOhgJlw5KBZfPQ6dVsXw6hWgyzCprxqiTH7/R2yvbpz6Ztyx1xDyIE4vzUvybFSawxtX2EKiDqE8ZYp9HQenUNu45s/EBZJBjADLgnwE0SGNRRIiey6XeuUOY4OLfTE8NcimvAM5rx/tq4cNheeQAZrgr418u23ct3ldwQosU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5c3c3b63135so5734203a12.3;
        Tue, 10 Sep 2024 03:04:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725962664; x=1726567464;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R8arzrtSLiNViV6wdJz5xajd0j0cCB30Ei22v2izotk=;
        b=nhXaZ65NDmuV1AH9qU9bsU9QlODRUXIwmy4KHD3WpSXLYrOOPt5gNGyBwdZ2t1J0Yh
         vG9BXgJHAhLd/0xxWhJsl2s/jRfSrqFcxRaA+u4ETP8jnbbkcmjMqDN64O4sFZBzMXrU
         wP+Mov19Le729oJ5dUK2+ZuJJtBCBGVLJSh4t5wTaBPZcBBqlAfPs9AfBOVqxOd1XBjI
         qfysTa9CE0JJMhHadea7F/kEGZZXKxuFUO255nl0Nyy1wfjw5X4ra+jNry+CpozYAMQv
         gAJxAkUF1K9mTh+ASNDFFE1zfpwUN0l1iX7nqzkOKjhju5MiAQtqiixetHRLihWgIpXh
         PDmQ==
X-Forwarded-Encrypted: i=1; AJvYcCUPbyB1OhUyeGgNDt7E5DqTNwvkxkhu1eAHdXyR0datXh7KaIQPd4mj7bzShPy1m/hGzEJAusw2arWvm1M=@vger.kernel.org, AJvYcCV7sqFwpPOgQFssTlo9GRAYYNJjPn60Jz1N3+T6jBMGRpCSlsjHTK2UI3uBi7t2EflI4nRxjr4r@vger.kernel.org
X-Gm-Message-State: AOJu0YzaDD19r3mLT8uZA2QM+SRGNLvxieZx3RcLYmjRRO558AQyJh5U
	F0rbhBvwdgFI1BbAyYJFkmJOZrvwnfA0jxWb2uKT40JTybypj2yo
X-Google-Smtp-Source: AGHT+IG+lrIlOCOYXcbkAPUKdrM8ci2bHZWOhdirCmht9GkUYdj5nUxSLwDnkCKDue9xMB1/962THw==
X-Received: by 2002:a05:6402:13d3:b0:5c2:5141:8488 with SMTP id 4fb4d7f45d1cf-5c3dc78512bmr11949148a12.5.1725962663513;
        Tue, 10 Sep 2024 03:04:23 -0700 (PDT)
Received: from localhost (fwdproxy-lla-001.fbsv.net. [2a03:2880:30ff:1::face:b00c])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c3ebd5245dsm4108553a12.52.2024.09.10.03.04.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Sep 2024 03:04:22 -0700 (PDT)
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
Subject: [PATCH net-next v3 02/10] net: netconsole: split send_ext_msg_udp() function
Date: Tue, 10 Sep 2024 03:03:57 -0700
Message-ID: <20240910100410.2690012-3-leitao@debian.org>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20240910100410.2690012-1-leitao@debian.org>
References: <20240910100410.2690012-1-leitao@debian.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The send_ext_msg_udp() function has become quite large, currently
spanning 102 lines. Its complexity, along with extensive pointer and
offset manipulation, makes it difficult to read and error-prone.

The function has evolved over time, and it’s now due for a refactor.

To improve readability and maintainability, isolate the case where no
message fragmentation occurs into a separate function, into a new
send_msg_no_fragmentation() function. This scenario covers about 95% of
the messages.

Signed-off-by: Breno Leitao <leitao@debian.org>
Reviewed-by: Simon Horman <horms@kernel.org>
---
 drivers/net/netconsole.c | 46 +++++++++++++++++++++++++---------------
 1 file changed, 29 insertions(+), 17 deletions(-)

diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
index 03150e513cb2..d31ac47b496a 100644
--- a/drivers/net/netconsole.c
+++ b/drivers/net/netconsole.c
@@ -1058,6 +1058,32 @@ static struct notifier_block netconsole_netdev_notifier = {
 	.notifier_call  = netconsole_netdev_event,
 };
 
+static void send_msg_no_fragmentation(struct netconsole_target *nt,
+				      const char *msg,
+				      const char *userdata,
+				      int msg_len,
+				      int release_len)
+{
+	static char buf[MAX_PRINT_CHUNK]; /* protected by target_list_lock */
+	const char *release;
+
+	if (release_len) {
+		release = init_utsname()->release;
+
+		scnprintf(buf, MAX_PRINT_CHUNK, "%s,%s", release, msg);
+		msg_len += release_len;
+	} else {
+		memcpy(buf, msg, msg_len);
+	}
+
+	if (userdata)
+		msg_len += scnprintf(&buf[msg_len],
+				     MAX_PRINT_CHUNK - msg_len,
+				     "%s", userdata);
+
+	netpoll_send_udp(&nt->np, buf, msg_len);
+}
+
 /**
  * send_ext_msg_udp - send extended log message to target
  * @nt: target to send message to
@@ -1090,23 +1116,9 @@ static void send_ext_msg_udp(struct netconsole_target *nt, const char *msg,
 		release_len = strlen(release) + 1;
 	}
 
-	if (msg_len + release_len + userdata_len <= MAX_PRINT_CHUNK) {
-		/* No fragmentation needed */
-		if (nt->release) {
-			scnprintf(buf, MAX_PRINT_CHUNK, "%s,%s", release, msg);
-			msg_len += release_len;
-		} else {
-			memcpy(buf, msg, msg_len);
-		}
-
-		if (userdata)
-			msg_len += scnprintf(&buf[msg_len],
-					     MAX_PRINT_CHUNK - msg_len,
-					     "%s", userdata);
-
-		netpoll_send_udp(&nt->np, buf, msg_len);
-		return;
-	}
+	if (msg_len + release_len + userdata_len <= MAX_PRINT_CHUNK)
+		return send_msg_no_fragmentation(nt, msg, userdata, msg_len,
+						 release_len);
 
 	/* need to insert extra header fields, detect header and body */
 	header = msg;
-- 
2.43.5


