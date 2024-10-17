Return-Path: <netdev+bounces-136498-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FFE89A1EFE
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 11:52:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CBDB428228B
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 09:52:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 897771DC07D;
	Thu, 17 Oct 2024 09:50:56 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABF261DA614;
	Thu, 17 Oct 2024 09:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729158656; cv=none; b=EJ3Ziwoi32IxWcvWpQluO0b/w5JXTRBSVEyMQscy1kUHieDXlPJLUPIDEOuzgkmLLwJtRbdQReKm9AQIjcHeEmJc1fU7Dsb090oTDaVQEZGY2whNx77x6W2bYcDBaU1m1WOHdVv20hv7xJ7fQopmfA2Uq2pOx37NCjWPuftEgBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729158656; c=relaxed/simple;
	bh=Ln7Wzjg1uZeOz10ZJbtx8j92rBQDislaLmxEWlAnTww=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=L33EulgY7LuKzVkUv3ppU2Zjne3UQyi6DQiWI9ddpJgBxBFH5uLT31v174Qe6tloQZLNAi2p6JwbQOpeQM06dR05ZlPUj2DFxWAxR1upi5m4UyOIAsEEEhe18lG9tINHr2GvdQ5jUVYHdds0GjTw9YLOAJoHqGYtKEWHZGnxXzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a99cc265e0aso90624966b.3;
        Thu, 17 Oct 2024 02:50:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729158653; x=1729763453;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CgYUhnRG0TgPDVVw4Pl1Mc0WqgFJv0JtFsCOdF+IG2w=;
        b=RwxgV3TGxz5Vk8iCslx4G0lbM3THxFLw2NrKW2R2QATcEc3411mCF3Ql0ajfhK7u1s
         St9sEQUKFov8tAP7EWlkyzVG7pb3iImsFRpsbuuDo/K+clSQozdf25UCqoBByPrgdPY/
         9CbFjumB9ssW5ZxF8Z9lbnXtU5azhagJxsSaa8QwI0LPYLo6a2sHIuhpFe8ej46kuTJW
         vcz/f8Ao3SLKi6+/L4708e2qv2FoljcGHP/2gLrHT8veBSRIf1pi2YTcFfTWXFI4gpJq
         Gp2bqcxheixYdhZKr4wsSoQvFKto6J0tKQwgfxXzH/+uLN6MabwC3a7NPM4fuusJEGYW
         BVoA==
X-Forwarded-Encrypted: i=1; AJvYcCVWNALpEtCekBMQfpOFFzWiVzFP+cXgsnJVNR+oTAKyHSAvo+Lygb+onLB73jBlc1pLDTpLPOjzj5TLy98=@vger.kernel.org, AJvYcCX/5RWWF6OCm4ktZifWeN34ZKnjCvWEsH6EsDo4JgQ1WH0EHMXVwlZgguGJT6bdeZ9KDCsCY0OA@vger.kernel.org
X-Gm-Message-State: AOJu0Yxcs0iIL9h2sX/meBsytBuKgsNFB7e2FB1oh5vHvSFEyv16PvVc
	1WHwZB4Q/7Z6b5t4DhW0xeL8SMTu42v6zGFKlgVpG7wykdNPpE1y
X-Google-Smtp-Source: AGHT+IGKH13023E6QgXZHE+TX7zssFbvqD7qM/AU7CagTRDkoQjMeK/p9OvSYx8zcOjCL/OjDcWdXg==
X-Received: by 2002:a17:907:d591:b0:a9a:296:b501 with SMTP id a640c23a62f3a-a9a34cfeb7bmr535226766b.26.1729158652858;
        Thu, 17 Oct 2024 02:50:52 -0700 (PDT)
Received: from localhost (fwdproxy-lla-004.fbsv.net. [2a03:2880:30ff:4::face:b00c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9a2981828bsm275419966b.127.2024.10.17.02.50.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Oct 2024 02:50:52 -0700 (PDT)
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
	max@kutsevol.com,
	kernel-team@meta.com
Subject: [PATCH net-next v5 2/9] net: netconsole: split send_ext_msg_udp() function
Date: Thu, 17 Oct 2024 02:50:17 -0700
Message-ID: <20241017095028.3131508-3-leitao@debian.org>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241017095028.3131508-1-leitao@debian.org>
References: <20241017095028.3131508-1-leitao@debian.org>
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
index a006507c92c6..23fe9edff26e 100644
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


