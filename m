Return-Path: <netdev+bounces-284915-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6PN+DuJg+2kuaQMAu9opvQ
	(envelope-from <netdev+bounces-284915-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 17:40:18 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 289864DD6D8
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 17:40:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5E0F5306E98C
	for <lists+netdev@lfdr.de>; Wed,  6 May 2026 15:27:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B7CB481A92;
	Wed,  6 May 2026 15:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UfeYdcQX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4984132A3C9
	for <netdev@vger.kernel.org>; Wed,  6 May 2026 15:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778081233; cv=none; b=pDY+AgAUEk7kyA9OhLWPUujCddU/5gRJCqz/uO2fFsJYH5N1qQ0sfoP4KEN6hc1/xYPrf3x8j+HPj3S02rwyPG97SW2AhLtVvjeKKwka9DqD5NuiyS6dPjZPE7AG0j5Awg+h3Vq+ExuBUOsO4LVlsJ5ddNbexRmOSQo0sopO6ZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778081233; c=relaxed/simple;
	bh=SkBOX6fDWuILt3NDIue2RThsK+F/RfZ0aMZvoLyOuwU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=V5neseK9WlOhwJ0LyPmyGXGWttH9Sxt8rAHQkKDVyTangx6L4SHi/QtKT6WrTMi/YQVo2eE9DXPybsM4VoEWiYmxLxmq6NGzXADSVXP+DcipGFTmJsfmQnaroG9G/1lSmHzgiPKXY88GXEArzBvNsDqJvPjSde0Zl+q6t4Qgk4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UfeYdcQX; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-36534668247so3879956a91.1
        for <netdev@vger.kernel.org>; Wed, 06 May 2026 08:27:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778081232; x=1778686032; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZC6Xht6xACWuhXxwl0DvhLfosR4WdiVXz/heDFGTozk=;
        b=UfeYdcQXldx8Jbc3SVMOcnl1Q4v4/tLKcsmlYXHXP6AtsFOeKZP+kweeSo904BC64I
         7jMoj9DC0HbddB7dH/tOmoLBr2VIfmCUxgB+Jopo08SKxCa68//XPhlgoTNdc044pq5p
         FGAR8nOidpMHWS9G7I7x7eOrL1fgUA/SNoKyLcBbe/u+zEaZ7/ShCJKO6pNHncoU+SQ8
         GmF6g6dH+bcmY5oE1VVB23AJLgwVtA8+AGtIH0l9toESPvS5oyAGxcWdwR0fiRA6Zb1P
         Ejqdb1n0qRuF1snk8f8BGnUMwtXBr4hZbLjHk4pjfWZ9oQlPoqsXrjYMkWLS9cYHQwNs
         +yxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778081232; x=1778686032;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZC6Xht6xACWuhXxwl0DvhLfosR4WdiVXz/heDFGTozk=;
        b=Y0Aei0sQ1Y+aa76INjxsRLfbN0mEWnTTE7v1urLqpPu+RJOfPCj4Y+BzjKB0stJc4J
         uPH8yBewiodY9DNfN5oxgiHHA4XawIahI56d9dVJtBYB4inL+7PYS4xMqSZN8qRGO/Ny
         drDPRWWvOBcNUPBO5go6Szp3LsUzlc8aGiy0DohL3RPTUKe7GLvBErIHWXW35tZoCNkN
         yraTVLFETReldIH5a5+AmCt4LVnG+m3wafrUhhe5/7WPSewlKGcjWiWaygO7wdJBgVSr
         4cqiyrhdxkSwzGglvxQCnSNuNKmiv3gA5uZLFPbro8yBw1NidYpkyRsMk4oDyaHZWMym
         seGw==
X-Forwarded-Encrypted: i=1; AFNElJ8P7vkiGdGvWRrrR56ZtBX9Rm0Dfd3VjdcA8kQUtU5U8T1JFYzfGk+7rrNWFlYeDHZ5F0eor3w=@vger.kernel.org
X-Gm-Message-State: AOJu0YzlhI/2UyAozg5jGVXCVy+bZPNH0skhvKGkI6LIuU+nEHhNgyha
	dSAeB4rLs5DnoYHWNq7rWx/5nFrnAd2nwhIfl4Ae2MTN5pLsCezSS+er
X-Gm-Gg: AeBDieuxy9rLFypBt0vTMBnkwx7VJYPX3yDtAmJC9E/5gGuwTU+L6RPSVJuTL2vkkNb
	O54nekQMdxutb5Tr1LqQYjaYgeL1P1gi4YB+dubzkQcbO+zYimh1lqMcoiFS8evbWpJJFXlELrF
	zhkspSrUYxBu6JZyfpWm4N6Ue3ESgxAmgPc+DcsjCevuvxoCByd4yojtldapxjnrPdI64FyZr/J
	fZu+VwcLHo4XAKAg7mZdL7Bt3sSAZEC/NTHFq7wjWnHYUhUDY7CqNx7L0y+VCwBRWHgdo0PGEc/
	lAUt4C+AxuJVmx8ePy75W1Dh6zdaptM32axHg7epVCal7+KSa7Bok1XjOcoHW1cufHpNEv8/RIh
	+336ZfHdQcnAP05WCZn5IcbTbYg/xzoF1dkaAYco7K/LjpWpenAcjF6AzVbEYt8c6Y6lHcDuEh/
	N9DoSjN/H2T8ftlJN6okFEkt7LsJEsZMUJtnfEDihlmzU/BqNY3sU=
X-Received: by 2002:a17:90b:4b87:b0:35c:1f29:712f with SMTP id 98e67ed59e1d1-365ac76bae1mr3949539a91.24.1778081231591;
        Wed, 06 May 2026 08:27:11 -0700 (PDT)
Received: from localhost.localdomain ([106.0.57.242])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c8242ab8bf4sm2484894a12.4.2026.05.06.08.27.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2026 08:27:10 -0700 (PDT)
From: Sajal Gupta <sajal2005gupta@gmail.com>
To: petkan@nucleusys.com
Cc: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-usb@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Sajal Gupta <sajal2005gupta@gmail.com>
Subject: [PATCH net-next] net: usb: pegasus: replace simple_strtoul with kstrtouint
Date: Wed,  6 May 2026 20:56:36 +0530
Message-ID: <20260506152653.52329-1-sajal2005gupta@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 289864DD6D8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-284915-lists,netdev=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sajal2005gupta@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]

simple_strtoul() is deprecated as it has no error checking. Replace it
with kstrtouint() which returns an error code on invalid input, and add
appropriate error handling.

Also add a NULL check before parsing flags, since strsep() can set id
to NULL if the input has fewer tokens than expected.

Signed-off-by: Sajal Gupta <sajal2005gupta@gmail.com>
---
 drivers/net/usb/pegasus.c | 26 ++++++++++++++++++++------
 1 file changed, 20 insertions(+), 6 deletions(-)

diff --git a/drivers/net/usb/pegasus.c b/drivers/net/usb/pegasus.c
index db85f40734d7..d45f08f8f22e 100644
--- a/drivers/net/usb/pegasus.c
+++ b/drivers/net/usb/pegasus.c
@@ -1327,15 +1327,29 @@ static void __init parse_id(char *id)
 {
 	unsigned int vendor_id = 0, device_id = 0, flags = 0, i = 0;
 	char *token, *name = NULL;
+	int err;
 
-	if ((token = strsep(&id, ":")) != NULL)
+	token = strsep(&id, ":");
+	if (token)
 		name = token;
 	/* name now points to a null terminated string*/
-	if ((token = strsep(&id, ":")) != NULL)
-		vendor_id = simple_strtoul(token, NULL, 16);
-	if ((token = strsep(&id, ":")) != NULL)
-		device_id = simple_strtoul(token, NULL, 16);
-	flags = simple_strtoul(id, NULL, 16);
+	token = strsep(&id, ":");
+	if (token) {
+		err = kstrtouint(token, 16, &vendor_id);
+		if (err)
+			return;
+	}
+	token = strsep(&id, ":");
+	if (token) {
+		err = kstrtouint(token, 16, &device_id);
+		if (err)
+			return;
+	}
+	if (id) {
+		err = kstrtouint(id, 16, &flags);
+		if (err)
+			return;
+	}
 	pr_info("%s: new device %s, vendor ID 0x%04x, device ID 0x%04x, flags: 0x%x\n",
 		driver_name, name, vendor_id, device_id, flags);
 
-- 
2.54.0


