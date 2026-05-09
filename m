Return-Path: <netdev+bounces-286134-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UA87EMQE/2kU1QAAu9opvQ
	(envelope-from <netdev+bounces-286134-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 09 May 2026 11:56:20 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 744D14FF0F4
	for <lists+netdev@lfdr.de>; Sat, 09 May 2026 11:56:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 785D430179C5
	for <lists+netdev@lfdr.de>; Sat,  9 May 2026 09:56:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B387F39C64C;
	Sat,  9 May 2026 09:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T8nWp/jX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7310038F64F
	for <netdev@vger.kernel.org>; Sat,  9 May 2026 09:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778320569; cv=none; b=byTU2MlhwSYndRqlbz69p0/Hov4vIUQy1lGlgYYS5M2CXUeQeIVe4oJIHJfp7Mb5S4nMoQS2ycFkOCe+KXm/XUNzBB7zHir42qdWk0tH/2QZcGMe49vJm96afHnPe5HbBfdlctjecy2BTp3rB2LTrTaCFiLJ1pi1u0obEAXgydg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778320569; c=relaxed/simple;
	bh=BKQpBYpbdlRPMoavHmhYs8byFtP2vgGBQl3nAxIAiiA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BogiJFtyT7DDafwgLqn1yg1NtSEVslRm3XzRPpntCt2LSfHuSm3RfexKJl6Yi+iwzW3wd2NePT8RwkbTvKjVKFZVgoKhoqvU7L8sHwUwxnr8vgK12QzjbY1bu4a7LPEq/WNJJtPwoSFmmeY30CmY+iPVi2voZz8JA2IJ7OTx0gw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T8nWp/jX; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-c80167f5716so1185078a12.2
        for <netdev@vger.kernel.org>; Sat, 09 May 2026 02:56:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778320568; x=1778925368; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5F59HTLBnwz0/GR5Td1Do25Vw59YKJu/Lja+nEVeSFQ=;
        b=T8nWp/jXbQ+AGx84znhw7YiIDwhGcwWwUfk/P7r5QTcYEYOEWAG3oSTDO1EhdnHX4N
         OkCgz8qAkz/905ud9lb+jjPtbByqbIV6Azna5LdBkMNg0ygGAy8kYly1kp5H8UJHPdsN
         ddzXHNliuCKmPd3grcmqImyuWqhqxzUxkQCHA8RpHl7J4rZnKxfmlYVNbHWqdWC5EEvz
         hSBEiZqJsovyP4+LyFK43hCdiMAWHAR5O8TuiwbyRIV55+y8+rH7AliTXdsMcvEMez4n
         HtdjJW90qVARTHUKneps6iljKxx6lDVzMLuwrZ8dCETcPOt5yRhxzpVb1dooLI8wnWyT
         YDyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778320568; x=1778925368;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5F59HTLBnwz0/GR5Td1Do25Vw59YKJu/Lja+nEVeSFQ=;
        b=tOwcuPNvuqpclZsLUKVLjSCmF86DR8e9cDn5luj1jsHKyopA9Z8voawhjGPIqHR9MH
         +nBRhzvOtxeHbRgNkCfuFdfsZFBC1sluiYhGdiUbPm6wy94PhkU4D3AQ2qNYhHcL0ou2
         eLNxTdKbTzfabIXeeSzux/KQwyihB8f9gs9CeMtaBwm0TXd1GTeE7zoQWnR+RHadZgc3
         CYVx0mOVax4oCZn2Mwd8+/+trAym2VAUe738tAK1+GTbLrwnPE+WSv+QQuRlukIMSHfX
         XDxsGRrgJLUu0O71CqVLJK8JL5CT4cNVKRFeaYo84Mixps25K3q1s86Y7l2rAVD2yY4f
         vX9g==
X-Forwarded-Encrypted: i=1; AFNElJ/knFFDd3v9Rk/pXrUpriuuaxSs6OfivxUh6qXVtmDqeuUJGlAb5cxlJVzKTsbOQF0GPikQQBQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQJ6Q5O/artLy+ECvIK0tCrZfaIrjSD8nW8YDnEth7P2oJxls/
	WyAyCwMPLNixejOiuYr7oM6vr3UMSdP9Syh/R6Yy9dkW4bsEi5dkLhEX
X-Gm-Gg: Acq92OFAjpWr0ldX5D79kwclYLLY6HI9SGuwV8EImiJ7wFED4z9C6x8rOHXJIDeWgly
	JYb6YBxAxpTd7/Leuvo9GMcCXOZhAzJqWSjv4rxmXdtOeYwyMj3unRMHpbU8byt8AQuK9bh6BcH
	KNtoAFWB85NJaqxaTiyU6bApkJA0zMpWY+0azdXVkYTWQz7knPNr+qm+vJLTWrB4lJyjb6a/9pD
	aoKMR5EPP5h9UqaDNnLf2vbsIjvjHxNOAYXvgW3qRhU7HxFApOeoxLkSf3+oK9mYJQDG/kWYqTU
	mmV4oYiaa9hXYR0Vewt2mJqN10VorPD9HABoAdZMC3cvMKfWdcp8yKlm/LSvpDTiz6zyUExmcKc
	KJNTf6JiWcZCGRInz/wbPisNj2go3lWLPf2G+lARuooVQbxmU9HGJ/g3T878c/UEwh4tMTbHu3U
	hI/ITVu5MMf93HaAA0nl/zzYq4B/3y2Um8fsl4o9LOmDQ5FeOJtZ1UZHnnvJoDQQ==
X-Received: by 2002:a17:903:3884:b0:2ae:6092:8d93 with SMTP id d9443c01a7336-2bc7aa398c4mr17738045ad.28.1778320567560;
        Sat, 09 May 2026 02:56:07 -0700 (PDT)
Received: from localhost.localdomain ([106.0.59.249])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2baf1d3fed8sm48819345ad.27.2026.05.09.02.56.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 May 2026 02:56:07 -0700 (PDT)
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
Subject: [PATCH net-next v2] net: usb: pegasus: replace simple_strtoul with kstrtouint
Date: Sat,  9 May 2026 15:21:48 +0530
Message-ID: <20260509095518.2640-1-sajal2005gupta@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 744D14FF0F4
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-286134-lists,netdev=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sajal2005gupta@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-0.976];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

simple_strtoul() is deprecated as it has no error checking. Replace it
with kstrtouint() which returns an error code on invalid input, and add
appropriate error handling.

Also add a NULL check before parsing flags, since strsep() can set id
to NULL if the input has fewer tokens than expected.

Preserve the original behavior for a trailing colon by checking *id
before parsing flags, so an empty string results in flags = 0 rather
than an error.

Signed-off-by: Sajal Gupta <sajal2005gupta@gmail.com>
---
Changes in v2:
 - Drop err variable
 - Preserve original behavior for trailing colon by checking *id
   before parsing flags
v1: https://lore.kernel.org/netdev/20260506152653.52329-1-sajal2005gupta@gmail.com/

 drivers/net/usb/pegasus.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/drivers/net/usb/pegasus.c b/drivers/net/usb/pegasus.c
index db85f40734d7..8700eeb8e22d 100644
--- a/drivers/net/usb/pegasus.c
+++ b/drivers/net/usb/pegasus.c
@@ -1328,14 +1328,18 @@ static void __init parse_id(char *id)
 	unsigned int vendor_id = 0, device_id = 0, flags = 0, i = 0;
 	char *token, *name = NULL;
 
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
+	if (token && kstrtouint(token, 16, &vendor_id))
+		return;
+	token = strsep(&id, ":");
+	if (token && kstrtouint(token, 16, &device_id))
+		return;
+	if (id && *id && kstrtouint(id, 16, &flags))
+		return;
 	pr_info("%s: new device %s, vendor ID 0x%04x, device ID 0x%04x, flags: 0x%x\n",
 		driver_name, name, vendor_id, device_id, flags);
 
-- 
2.54.0


