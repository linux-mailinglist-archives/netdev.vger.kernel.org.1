Return-Path: <netdev+bounces-126510-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8723971A5E
	for <lists+netdev@lfdr.de>; Mon,  9 Sep 2024 15:08:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A41D92829E4
	for <lists+netdev@lfdr.de>; Mon,  9 Sep 2024 13:08:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 453F81B9B55;
	Mon,  9 Sep 2024 13:08:12 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79A231B81C7;
	Mon,  9 Sep 2024 13:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725887292; cv=none; b=nri87R3lRMSlhUyDaXzc6h0tYJsS5WcGFzy6lJU+YeWMb6BiD4S0uR0THOl2aHg6XNBVYtTK/o4F6nWDcg25VfMR0fV6TDysapuluLmfPgXYAhMO9mmRK+ULTG844ZZdLSvAhYSFlAfT5Vd+bcWVtKohgS2brlGXgT7/XXPJjm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725887292; c=relaxed/simple;
	bh=KlWvtgP776H3SGAl7+pUSjAVYPwx6ASIe7XSiqsaNgo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fyh7vKsidLxMudarowmejtXiR8mbxVu+fBhL5t0vtMfObmJqkoWXCdcXxB9h0+ROzx3R37BDjcgRS557HgOPe/dii3JHXM4ObdV8NiOXPjhnFMf4+/VU4GTgq9zC9aKHx5MskWzXcnzjrPn/qZ1wTFsAEmgh5kAth5DzCvwD93Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5c24ebaa427so8169825a12.1;
        Mon, 09 Sep 2024 06:08:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725887289; x=1726492089;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/vjwlQJTs89Ef/RIHRnwfyBxPAxdJWhwqwNkCraTk7k=;
        b=F1Va/vvk5K1kFIlIrZjX3Mwl8lfnRyNC/qSsdBJpVdifGbPbdAm0QYozr4cSqq4nmA
         lmdw5/3F360P7O7ZvwsFB8ZODlrbLE8f+M3QKMpwdUH3BfxrDI12dtyMvrIjBxqdBNYv
         GpQ2GBXoeviiDoD3+qptZJIZiSomqSHNUvJgsqAA3IATYMVT95MqgmUSE4R4RVw5Izbn
         LgGNcfgbLkXwv2CJwpdGdUr+cwWkOt7JjYcFB7TXLwVgYE+YabxGHqjDO7OtvXQKc9KL
         RnuQzC6FnHYFZlWiO59o0yvQOLptFvOb0m6EzNgu7GxGtme60CPQxBJz5gwVjvPvSRui
         X83g==
X-Forwarded-Encrypted: i=1; AJvYcCUuLbWyV09vWDAAmBmTQkfinixGgEwZam/BzKVELHObYyH3oh4zcUraZ2EavuhwvFE3y23Ltb3pWP4ytWw=@vger.kernel.org, AJvYcCW4tB7kWd/Sd9n2k0FSsZLLXs2Q8kp1hGs+AISojYZBgu60guBZZzAOTxwdOKyK+q/vBMVXTHBH@vger.kernel.org
X-Gm-Message-State: AOJu0YypJfFNyo9k3wXM0dER/0hDn5JoyvTSdtHLKgCkZc8cpbr7SVOc
	0+LrY3x2hmXfEh3mpo/N0NvG3whWdP8KDt3tq2LpPUQIxSH9AvCN
X-Google-Smtp-Source: AGHT+IFCaadGLqYBIQE/R8KwNLQ77x3OmVtlvpH++8pGBvWnu3ylQjUVO+wzkwhoWzahiAGlGni1HQ==
X-Received: by 2002:a17:907:c06:b0:a87:370:8dfc with SMTP id a640c23a62f3a-a8a8603e91fmr1225785466b.14.1725887288631;
        Mon, 09 Sep 2024 06:08:08 -0700 (PDT)
Received: from localhost (fwdproxy-lla-007.fbsv.net. [2a03:2880:30ff:7::face:b00c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8d2583392csm341059266b.40.2024.09.09.06.08.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2024 06:08:07 -0700 (PDT)
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
Subject: [PATCH net-next v2 02/10] net: netconsole: split send_ext_msg_udp() function
Date: Mon,  9 Sep 2024 06:07:43 -0700
Message-ID: <20240909130756.2722126-3-leitao@debian.org>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20240909130756.2722126-1-leitao@debian.org>
References: <20240909130756.2722126-1-leitao@debian.org>
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


