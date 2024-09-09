Return-Path: <netdev+bounces-126515-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7340F971A6A
	for <lists+netdev@lfdr.de>; Mon,  9 Sep 2024 15:10:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C8C2286F89
	for <lists+netdev@lfdr.de>; Mon,  9 Sep 2024 13:10:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8913C1BB680;
	Mon,  9 Sep 2024 13:08:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA9991BAEE6;
	Mon,  9 Sep 2024 13:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725887303; cv=none; b=SPciF8uCziXthzQkgDAvizA9/xya+ZF/3z7aCDeM9jcXxJY8oQsdFgZKcoDzs+4xiV4VgNL66AzY0sjSzl3AGOppoON9CL0fsAzuG1x9oycD/Dwc1OyIXqNcC3bhCnaLahjAitNuPowHboIrUuPM7Y3n+hz8YOSPUgVylo/oR24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725887303; c=relaxed/simple;
	bh=mr7ozxLYNIKSDK28c1JS/rg+dGy/5mHfdcu4ZO66wkk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z69q+bqlI4Wro7HizOzF2vAfZZY0YtalYapfX5w/c2Dha+a4arLKh+1texggCJt9Y0EFvUcJ+TiXINaLiuqg4bOUy3EAilmEa/AiJPtcDCL3BZuI9OtxyEebxRF7ryQ+E53jInkw9kkqNb+tuAaMc5lmLxRDn5v7cB7k4kvJRUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5c245c62362so5754439a12.0;
        Mon, 09 Sep 2024 06:08:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725887300; x=1726492100;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7YPaA0LtjHQmgp6W5R5O8D3n6pkkJ4FmCPhF61F3u3U=;
        b=aMlmVi1HV0bOjoIC9XC2+oYfNTvQo9Vk3W7upUYsQ7iPyFZpOw79X+GYpA/NiNm2I9
         ki2q1XOMCkBniDgn0emeY1qHN/eC4+YOr06nKh30Gc0JTH8UEfZ2oYgS/vIL1l2d7nTN
         9qmgx0VUvrSpUUBjQpvpAlPHf2t7XPNurcWdD6WeDkRje0bUiZ7GHwYjk9RrKizaV+75
         KvUCfC23myHpzPfMwGHIgFqZ0t9FEogdia4W83LPlYfEehOZ8vCOUseQYPGh6xTzsM89
         hed3sfV1U0yElC0XfIsOezWio1J4cLeQMPu3iJHSvg1miKCecmZzCEuz/XrKf+ce2okl
         wv7w==
X-Forwarded-Encrypted: i=1; AJvYcCU+aJc6/SHKMPsNSZyJWn45wyGZF3AT8Ehv9der85eeNoP3PQx4r165UUNF2Yy0/u+2Ba4AaD3R82FyiPs=@vger.kernel.org, AJvYcCU6EvxlipODvy/tkOqwplO8vameV+8eI7rm1R76Hj0ZTc6pW/PvBY2CYo6Va9KLcKpP1HR7LnD7@vger.kernel.org
X-Gm-Message-State: AOJu0YwUHLgqKY2/adSI5UTaoYvIWE9i+8sBauvgxH0EsOGh0h4ZhLCl
	17ex5xYU4XxEP0jJsUZVGOYnS5rFfDHtXOsNEA+RH/RbvuV+VCwE
X-Google-Smtp-Source: AGHT+IFFQpCHV3UeZu1w4ZrH470XJDbitPgmrxubQcj3nXOXVMpTzyGjFdGSEBxuxm+sXR9zm1TaAA==
X-Received: by 2002:a05:6402:518b:b0:5bf:f1:908 with SMTP id 4fb4d7f45d1cf-5c3dc7bd6e3mr8490789a12.24.1725887299888;
        Mon, 09 Sep 2024 06:08:19 -0700 (PDT)
Received: from localhost (fwdproxy-lla-112.fbsv.net. [2a03:2880:30ff:70::face:b00c])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c3ebd467f5sm2992854a12.36.2024.09.09.06.08.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2024 06:08:19 -0700 (PDT)
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
Subject: [PATCH net-next v2 07/10] net: netconsole: extract release appending into separate function
Date: Mon,  9 Sep 2024 06:07:48 -0700
Message-ID: <20240909130756.2722126-8-leitao@debian.org>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20240909130756.2722126-1-leitao@debian.org>
References: <20240909130756.2722126-1-leitao@debian.org>
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


