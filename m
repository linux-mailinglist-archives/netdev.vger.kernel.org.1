Return-Path: <netdev+bounces-292211-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EP/4JIe1FmrFpgcAu9opvQ
	(envelope-from <netdev+bounces-292211-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 11:12:39 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CFC55E199E
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 11:12:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 72809302A7DB
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 09:08:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C1DE396573;
	Wed, 27 May 2026 09:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b5IFILxR"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 444EF3E5A37
	for <netdev@vger.kernel.org>; Wed, 27 May 2026 09:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779872900; cv=none; b=tipdirZ76uvfcI6DTK/a/KVlCJzELNd+p9dvNIa3sZpCA6PZqGNC52ep/Cf65qWGj1KlIc1h9eahUrUEYBccZfu6KUfI3q2wAzjRM2fAEmJ8izXIm2bmJNbSQXcHwQXoVkNJ448jxZivpmvP/JivkgAaaL6wqPtW1jwOEVXcgjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779872900; c=relaxed/simple;
	bh=NL5zz6TFFz1J+zzzYXCP00XF8j2Vn94QtKRSoPtjcs0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VnRTJQzIKpaM9WKhvwD9W85b9ULcVSTN5mlS7UBI+UqIK74vc2BMDM+mll/xiyL2OKKu5B+BodSXom/lWRtj5jvwpPDyTMub9LytRdF/4bl4nCNxf83X+3DHzXl0ndZmXOxum3oy1JrSxLvXMAV3/RCxV6e41SXZM216Xioxp6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b5IFILxR; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-49048f70faaso3667165e9.3
        for <netdev@vger.kernel.org>; Wed, 27 May 2026 02:08:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779872898; x=1780477698; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rvde6FtFOf0EYIyR46MKaWJ3tuuQPRR4ZTiztVWCj2w=;
        b=b5IFILxRseEz7Cjf9dX9/h7Nf1vjd9yuNxye/4suldv1HLWR2KFnXltd/oxhX2kTBE
         Bm3yVfpdVhvgFRAZYZqUgyLZvzVjItMcKf3QkIY1mtp9gdMxKmTrRUfYCocHeUA0ep43
         vzx7kYGKkB3FWw7kjQuylp28xeWt/YUWOFbIHUlUFZdpl8WwbiGNPQ4GIAKdXnoKndvb
         0/w+mOWNFYdbj2on4u3wtyMYW2PH+zDNUArWIKqZm3rExWz/9Gm01lpZwK0RklNtc+y9
         W0AGTpxC9nAD/ReY9gHFRXk8tfpErq3nRFRRvc5UBgp4hLQnynIe2ha/9ZvuVRgOxsB4
         Gd8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779872898; x=1780477698;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rvde6FtFOf0EYIyR46MKaWJ3tuuQPRR4ZTiztVWCj2w=;
        b=Mp499TPx/NA9C2t5Bi+/uYNr3ZkCqEB7W21JTujVIJ88Zsauxjl3yQolmBWg6jTcRa
         6bmD1bY8XOQC1LDJApfOH1TDyT+QLKEJPwy0PMC3Ny68yFE9lujq8njh1OYQHsLM4QAm
         3XYEp7K/neqHIpL9EzeSmbA71oE6gzj8JuyMzydIaCQFmYAfvCCpsVFjMR4sT9gP+3N5
         JoZbiUPiHVcR+ZbBAaPZrih/ScadLcN8g1oQJwzP5l+qYP0pq0UuZR5kk7jaOT+URUwc
         8GvjeE7j5wKq/E688dGSaiDh48Aw+QHrFw0ksj4aRtaPaPYJ6Bx0sdLWw6kfc/a54QF/
         UPEg==
X-Forwarded-Encrypted: i=1; AFNElJ/wg2JwnkcSuylUNwDN0VM8vdEdtpppfLUKbntngCoiwZwEEqt00fQEy9Goj0f98Bjlmdiv5yY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+rkGxnHUV4UZDpDMril/cbtEdNT/1cmYInA0OMaJKI/mIzjjB
	SqXUketq+MlwyHg78+m3z15CJH+HFVL6tDmtxDlV5RVfUScC9tLCmgE=
X-Gm-Gg: Acq92OHIFPNIUszgXD9/N3Q4VzyggFj0keyvJyV+L7qZTmRKYcZDxmBEHD3rjqiCbqt
	LHDAjncVxz8Fm1cnDr6jvSjmlvPdB8REmlt9vYUeTsyQOaP1+EoPsRER8pXPuICTJYc28jT4jvF
	cjtly7I109lW78Vgbo4HqoMcErrdyofj5FCSFRiIBQcal4zBJP9RXJNO1v4SqAGUAawYqX15iBk
	WbzhlXHdEgYUM7Jwwxfrdvevo6LHzjSzUrbH3xAtMYrFQBkgvXhC8khdSW3DRiL2dRo6ERH9m6E
	eBI6XmHXi02mTe/UDRggSfztNXi0ya+8GR8YBDCWf8ezkq+ivuhb9USwWHdY+A3f1GZU6AWnDV5
	s2PdR22EyMMGaWa5FG84P/pcQAt6rkhW3XSg67PJmEpZNhPoxYz6ZlkjF6rUYR4YO8Qa6Cd00cf
	akWW8/jf/ZdxRyb5XtkvyggGMpBkqWWr0nHCmzKWNCUjhz6cynKRVvQpUf71fF
X-Received: by 2002:a05:600c:4706:b0:490:3fdd:d344 with SMTP id 5b1f17b1804b1-490424851e1mr170501175e9.1.1779872897560;
        Wed, 27 May 2026 02:08:17 -0700 (PDT)
Received: from localhost (32.red-80-39-29.staticip.rima-tde.net. [80.39.29.32])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4904526c926sm685108205e9.1.2026.05.27.02.08.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2026 02:08:17 -0700 (PDT)
From: Xose Vazquez Perez <xose.vazquez@gmail.com>
To: 
Cc: Xose Vazquez Perez <xose.vazquez@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	USB-ML <linux-usb@vger.kernel.org>,
	NETDEV-ML <netdev@vger.kernel.org>
Subject: [PATCH] net: usb: asix: ax88772: identify 0x2001/0x1a02 correctly
Date: Wed, 27 May 2026 11:08:15 +0200
Message-ID: <20260527090816.100854-1-xose.vazquez@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_ALL(0.00)[];
	TAGGED_FROM(0.00)[bounces-292211-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[xosevazquez@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.980];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,grinkin.ru:url,davemloft.net:email,archive.org:url,lunn.ch:email]
X-Rspamd-Queue-Id: 0CFC55E199E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

It's 88772B, and s/spaces/tab.

Cc: Andrew Lunn <andrew+netdev@lunn.ch>
Cc: David S. Miller <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: USB-ML <linux-usb@vger.kernel.org>
Cc: NETDEV-ML <netdev@vger.kernel.org>
Signed-off-by: Xose Vazquez Perez <xose.vazquez@gmail.com>
---
Sources:
http://grinkin.ru/dlink-DUB-E100.html
https://web.archive.org/web/20221021183537/https://grokbase.com/t/centos/centos/13axyyat31/c6-4-d-link-usb-network-device-2001-1a02-not-work
https://support.dlink.com/resource/PRODUCTS/DUB-E100/REVC/DUB-E100_REVC_DRIVER_LINUX_v1.02_2.6.14.zip
---
 drivers/net/usb/asix_devices.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/usb/asix_devices.c b/drivers/net/usb/asix_devices.c
index 293ef80c4e30..af19c57c6216 100644
--- a/drivers/net/usb/asix_devices.c
+++ b/drivers/net/usb/asix_devices.c
@@ -1550,9 +1550,9 @@ static const struct usb_device_id	products [] = {
 	USB_DEVICE (0x2001, 0x3c05),
 	.driver_info = (unsigned long) &ax88772_info,
 }, {
-       // DLink DUB-E100 H/W Ver C1
-       USB_DEVICE (0x2001, 0x1a02),
-       .driver_info = (unsigned long) &ax88772_info,
+	// DLink DUB-E100 H/W Ver C1
+	USB_DEVICE (0x2001, 0x1a02),
+	.driver_info = (unsigned long) &ax88772b_info,
 }, {
 	// Linksys USB1000
 	USB_DEVICE (0x1737, 0x0039),
-- 
2.54.0


