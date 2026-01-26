Return-Path: <netdev+bounces-253346-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id xqEaE3gSd2k5bwEAu9opvQ
	(envelope-from <netdev+bounces-253346-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 08:06:32 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 995AA84ADB
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 08:06:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 52F793003EB3
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 07:06:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13F0F288C08;
	Mon, 26 Jan 2026 07:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ObDE7EkE"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f195.google.com (mail-dy1-f195.google.com [74.125.82.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0A922882D6
	for <netdev@vger.kernel.org>; Mon, 26 Jan 2026 07:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769411189; cv=none; b=QmFX9x+zloL0WitSoeFXmJmpYQW+bMvlXP/fBGqtwqM+Ig2GiVWfKlBBESCZAsTVi7C5uwtpy4Y6eMCy5+cymw8ijuJiqe0pNGoOEkCTdOLqkP6+2FukJQC91uOKvGNwMbNON2jAdKpRd48+cUylCLqD5XmFl62dPfG0ud0363M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769411189; c=relaxed/simple;
	bh=BrGYfbKjFcWVBNtR1VCrwZ1sP+nBA2htFvw/QqIZpRI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZA8K0yWQATEmZ5+wGCFEg0PziLvRahNdI+r6/QlRIsa5v8xBA60n16AinSUVgV5CALUSEvtMDx/lM2lALcpjhGay/5qPWM63zgrzeXdcX0/HaBUCPHKsZ/bYrd8vGA6jZASB/QFko6FJ8SRhZw/CuVLpBjsHdJdpRoNzXPMH5z4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ObDE7EkE; arc=none smtp.client-ip=74.125.82.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f195.google.com with SMTP id 5a478bee46e88-2b74f839bdfso970147eec.1
        for <netdev@vger.kernel.org>; Sun, 25 Jan 2026 23:06:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769411187; x=1770015987; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZnNSYAsSgZZKBbd6EX4AMUvPpqA2jWI9KkqGPjFXPC0=;
        b=ObDE7EkEzZCzM4l2WEmjfE/rIA9vOK9qUHkbpah/DiS7vwQ2W5ngVeG8SeLhGUwJBK
         C4xPHzWCNmgo9mU6KT9Ulkrsri/k2vqZq2SXI6BReyZba43OvSuSU5PHZmJ6g4z4b3+d
         zY+/JJfWYw+SrRnyDXiCkjswXIZDD+IR0clEjddTHWGqynUX1TEB81abhhQJuSdwFxBg
         /Zlr5H9MQa9ehv8hlMLP2rUHYWupuMnepV8KSF4G2YNpEoWOCz1M7a8ysZvYW0hs/u7w
         U8LXv6gpKHyM2FEUFwBNOOkvwpftyfb+5GxhJFXcL4yWqc7NHyaU0quhW71fyD9Es+nk
         hD3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769411187; x=1770015987;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZnNSYAsSgZZKBbd6EX4AMUvPpqA2jWI9KkqGPjFXPC0=;
        b=EwSMIqH64H7scANXBoJN8l95NoBWXiFKFl6lHRumDTyYIZN3qY85hmIIQX34nDk7ER
         iB6Ka6U8iCE+CS4gJVGIGoAejYVy+K6jGc9+tudEEsYtAIT4Tpl0Epf7Ck1YML2uLANK
         vV7Yuh2tYzToiMAnL4iYm0GY0WkTesIiZQQGqLXLkSOZnr3RccQgbycTzg1hAVtb4wHe
         zU17hOf2eKakRAfp/MUSUAWozxYnuftfKzbjmAq1sPasFwGDjm6XfnUx9LCKUsaKISOv
         KhGQFx06rcqgDePW6onM4ThWpLqkFmA6CmrgASaP9nPJsM6l/6ZTi2jNLolOdFHNXJUm
         Z0fQ==
X-Gm-Message-State: AOJu0YzOgiqwAWlfBxF0ZwnvYXsKWXtSfNtA+f7stQ5UtusRqEPZrDTX
	knmeVWyTmn3CuXMZJ1b6JHO0qcHYmYp+JrOcnA1Z735VD+C3Ty0pL349QAmoM0wy
X-Gm-Gg: AZuq6aKW1fmlADFb5TNQWeOPvPxkBx1q+0JrCk4AYWL9Sf7B+RD0QXi7mfuBtLoB7F6
	k+r9rVrvQC1lk0A5iHaSgrcsHlFZF1cMTzLdPTpX7W8obGHl9877pWDU8FWYRoQBPYyEHTXhdEc
	vxuPm+L+ayc0EXwa3hMj8Rk1HkYN1X+8HdMC4JF/0qz1lA869AUebSYy9exvIAcaTDQcaMEDoAq
	YO9YZepdVvBXOosZvTI+peyJyuCW9YKIgGVpa7z+ThkJ1B888JJaPgcno/1a207BjltCK0Ew+Vg
	22beTa0PGgPcinCY3tvphA6xDA37ymXQ54OuxZbiE8fgCTaBWp8ypKm/7QXJGrimvT9mI810T2b
	5QNxCYQDsV5HnI7uTo82PAh65TfCySgmx0uGWPQ8yGki4qN72EGRFj5IhzNyTFuGAgO+X/zMAoi
	r86eniZDZNhT/c8yjC+Uw2WgDbpQG85755epEk0+SmUpPFWaROSEQU1NvSYCarWsc8NyrJ4oy1Z
	XgE0iAkO3FpaSt3lWcuh62NXA9AtZfnkK2grr2RwKiFJK6shcvU56lcIFjUAMErSS/fuZ/F4eko
	CAjkbGpX
X-Received: by 2002:a05:7300:d511:b0:2ae:556b:76f2 with SMTP id 5a478bee46e88-2b7638a7f04mr1772945eec.6.1769411186616;
        Sun, 25 Jan 2026 23:06:26 -0800 (PST)
Received: from ethan-latitude5420.. (host-127-24.cafrjco.fresno.ca.us.clients.pavlovmedia.net. [68.180.127.24])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1247d91c52bsm18021503c88.6.2026.01.25.23.06.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Jan 2026 23:06:26 -0800 (PST)
From: Ethan Nelson-Moore <enelsonmoore@gmail.com>
To: netdev@vger.kernel.org,
	linux-usb@vger.kernel.org
Cc: Ethan Nelson-Moore <enelsonmoore@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net-next] net: usb: int51x1: remove unused includes
Date: Sun, 25 Jan 2026 23:06:13 -0800
Message-ID: <20260126070618.53758-1-enelsonmoore@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-253346-lists,netdev=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[enelsonmoore@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 995AA84ADB
X-Rspamd-Action: no action

Most of the headers the int51x1 driver includes are not actually used.
Remove these unused includes.

Signed-off-by: Ethan Nelson-Moore <enelsonmoore@gmail.com>
---
 drivers/net/usb/int51x1.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/net/usb/int51x1.c b/drivers/net/usb/int51x1.c
index 6fde41550de1..317ae365277f 100644
--- a/drivers/net/usb/int51x1.c
+++ b/drivers/net/usb/int51x1.c
@@ -13,13 +13,8 @@
  */
 
 #include <linux/module.h>
-#include <linux/ctype.h>
 #include <linux/netdevice.h>
 #include <linux/etherdevice.h>
-#include <linux/ethtool.h>
-#include <linux/slab.h>
-#include <linux/mii.h>
-#include <linux/usb.h>
 #include <linux/usb/usbnet.h>
 
 #define INT51X1_VENDOR_ID	0x09e1
-- 
2.43.0


