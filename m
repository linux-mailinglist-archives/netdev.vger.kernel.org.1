Return-Path: <netdev+bounces-254524-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +JMPBe7PemnU+gEAu9opvQ
	(envelope-from <netdev+bounces-254524-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 04:11:42 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FD5DAB5AB
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 04:11:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 34E8C30038D1
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 03:11:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ABBD3570AB;
	Thu, 29 Jan 2026 03:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="kNWAnEmJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4D242BD597
	for <netdev@vger.kernel.org>; Thu, 29 Jan 2026 03:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769656299; cv=none; b=AMwl5hU4aIAOury0SqFVkt0sOVq5YP0DEuK8+dzuwP0DivrlQoiKNBLWKOWvxLPU9F9zmT4m3DI3YlSLgFRYBi9kgRi37MhGpj1xTDuf1xvKm6HaGHlFgPtma9ZcJTY8cwcbvhmufYe4ex5qo7obZrHO+etBBd2RqmAdEUjOE6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769656299; c=relaxed/simple;
	bh=ji+mYPFRCqdMnMluhdPnzHWfS6NeTlfDWXmEfqSErag=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qGGDIlRzmCbXFKbCsz8C++2e0lJkspu9f0p7xwZSFvFKg0hh3bkFCl7VsOVqkpnqul+qBCBxU3IIO3W3TAE1hD+5f8uY91qf7/Egl0jxKEUOadmN+20RV2+Zxhw+yOyRa7jRViYaw13HY5QsVeSXhM3ZP9NMTbNz+D0rE4Tiefw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=kNWAnEmJ; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-81f4dfa82edso266265b3a.0
        for <netdev@vger.kernel.org>; Wed, 28 Jan 2026 19:11:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1769656297; x=1770261097; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JWJWtMvK3cJ/FZi3+gRtm63An6XKMQkwUbbJsEmUhfg=;
        b=kNWAnEmJ2ETKf3i+YJAeUn7dcr8mETIzYmD2Xdta2jCVAZdlhiVZhXrJsz3XolNGB0
         u6/MYaDDG5iOXupVPX7gBjVa52XTnnO+Mdrb4IkiuSXIR24lL8UNZQ7x7v8EruLDvbUH
         m0tYzEToULHFceaiw7ORoeAUN8q5YNLqeR8gw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769656297; x=1770261097;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JWJWtMvK3cJ/FZi3+gRtm63An6XKMQkwUbbJsEmUhfg=;
        b=n1t/Ezqkov7eD6rcut8i6jIck5PFSQTsJhef9zMlhxhGsZq74Mzrk30frFBN5Dr8PL
         TO3K/Y1XJEVMvuKNphTRX+VYKnm07B8j3cbc+InwCSJF/stdHYj37hbPWB6iJMgv9si4
         L7HPYPwbcV6+PbEQioZTHrOjvlGkYGftLjTC7n5qOqZxHSu3T3oxALBBJ+e1Gc1jRQ1h
         CWrUNoAF0MthFqnm74uVuAf8PLEr55BsNsSDKcXOWESkME075fUn4WoThQfgFjXNRFmQ
         Vy3O1vZrSKz7vDiE9cyvFEVX3GCRXYVC8BAHwsNfUmDPI1vEoDt6yf4gZIA74Q6xCHNX
         y4gg==
X-Forwarded-Encrypted: i=1; AJvYcCUPwyH9JaArs2Ydn7h5OUXNjYWqzJH4BFjAJ8VcN2mCme8YPq06ZcfTX5GY91MB9g3HbIckvYU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7FlvdeT3qVnFVTkaxCJ9R5qz4IYORgrZZqR+rXl9Y0E8OLM9L
	bVazWD6x/O/0O37mXp8wfqkVe6i/tZTsIb8/4MSY897YOMjRf/Q3sRnHfhhpKvQ5eg==
X-Gm-Gg: AZuq6aJzAAroEU0f1dgg3ZCGemHrgUwz/HMngURORuYkWgY5RQJ+CiregfnlrlMfCUG
	yyAvV6VxPK8d8/+ZPdrvcza8/IFG4jHM1gtqOGuQKsJFsFRxwBulKJ9MaoIldx7DUvtFZ4M4Gm8
	wKCh3ByxAjQphB+sxjGVhhTpXnn2ZWgldXTTmXUxBc6DJtiNiHWF1O/CAKLKU2Jkprrha+4IG3V
	UBnl40brSpZNKdTGI1qepNfK9JEU7IbCnEZSI3avRw3OKw8bCFUJA4hOzUfpoes5tZap2uulH7N
	igygEypZGryZ1cEPtE4sC/flBd54qJcVC4quWaVyddmTo7kIdIKExsrwGB/bXAzOXoUVM3w6vej
	GpJT1j1UzKMYDobSsJN+/W0727yB8/NSLKEXYfw12mVkzwvchGmcG6UTBUfiTrKg6SSMd21b6yj
	c/Ceo7j46Q3w1eSM3IFUTqPz7vhzlNu7xr2A8c10/X3D3A/kcHKCc2PK4PneA1RJ8eIQ9bBPdX
X-Received: by 2002:a05:6a00:244e:b0:81d:d666:72e1 with SMTP id d2e1a72fcca58-8236914777amr6825599b3a.10.1769656297157;
        Wed, 28 Jan 2026 19:11:37 -0800 (PST)
Received: from tigerii.tok.corp.google.com ([2a00:79e0:2031:6:356d:f98:467f:7e27])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82379b1ee89sm3898394b3a.14.2026.01.28.19.11.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jan 2026 19:11:36 -0800 (PST)
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Paolo Abeni <pabeni@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>
Cc: Douglas Anderson <dianders@chromium.org>,
	Tomasz Figa <tfiga@chromium.org>,
	George-Daniel Matei <danielgeorgem@chromium.org>,
	linux-usb@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCHv2] net: usb: r8152: fix resume reset deadlock
Date: Thu, 29 Jan 2026 12:10:30 +0900
Message-ID: <20260129031106.3805887-1-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.53.0.rc1.217.geba53bf80e-goog
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
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[chromium.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[chromium.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-254524-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[chromium.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[senozhatsky@chromium.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[chromium.org:email,chromium.org:dkim,chromium.org:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7FD5DAB5AB
X-Rspamd-Action: no action

rtl8152 can trigger device reset during reset which
potentially can result in a deadlock:

 **** DPM device timeout after 10 seconds; 15 seconds until panic ****
 Call Trace:
 <TASK>
 schedule+0x483/0x1370
 schedule_preempt_disabled+0x15/0x30
 __mutex_lock_common+0x1fd/0x470
 __rtl8152_set_mac_address+0x80/0x1f0
 dev_set_mac_address+0x7f/0x150
 rtl8152_post_reset+0x72/0x150
 usb_reset_device+0x1d0/0x220
 rtl8152_resume+0x99/0xc0
 usb_resume_interface+0x3e/0xc0
 usb_resume_both+0x104/0x150
 usb_resume+0x22/0x110

The problem is that rtl8152 resume calls reset under
tp->control mutex while reset basically re-enters rtl8152
and attempts to acquire the same tp->control lock once
again.

Reset INACCESSIBLE device outside of tp->control mutex
scope to avoid recursive mutex_lock() deadlock.

Fixes: 4933b066fefb ("r8152: If inaccessible at resume time, issue a reset")
Reviewed-by: Douglas Anderson <dianders@chromium.org>
Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---

v1 -> v2:
- incorporated review feedback from Doug

 drivers/net/usb/r8152.c | 29 +++++++++++++++--------------
 1 file changed, 15 insertions(+), 14 deletions(-)

diff --git a/drivers/net/usb/r8152.c b/drivers/net/usb/r8152.c
index 30f937527cd2..5e556e26c682 100644
--- a/drivers/net/usb/r8152.c
+++ b/drivers/net/usb/r8152.c
@@ -8538,19 +8538,6 @@ static int rtl8152_system_resume(struct r8152 *tp)
 		usb_submit_urb(tp->intr_urb, GFP_NOIO);
 	}
 
-	/* If the device is RTL8152_INACCESSIBLE here then we should do a
-	 * reset. This is important because the usb_lock_device_for_reset()
-	 * that happens as a result of usb_queue_reset_device() will silently
-	 * fail if the device was suspended or if too much time passed.
-	 *
-	 * NOTE: The device is locked here so we can directly do the reset.
-	 * We don't need usb_lock_device_for_reset() because that's just a
-	 * wrapper over device_lock() and device_resume() (which calls us)
-	 * does that for us.
-	 */
-	if (test_bit(RTL8152_INACCESSIBLE, &tp->flags))
-		usb_reset_device(tp->udev);
-
 	return 0;
 }
 
@@ -8661,19 +8648,33 @@ static int rtl8152_suspend(struct usb_interface *intf, pm_message_t message)
 static int rtl8152_resume(struct usb_interface *intf)
 {
 	struct r8152 *tp = usb_get_intfdata(intf);
+	bool runtime_resume = test_bit(SELECTIVE_SUSPEND, &tp->flags);
 	int ret;
 
 	mutex_lock(&tp->control);
 
 	rtl_reset_ocp_base(tp);
 
-	if (test_bit(SELECTIVE_SUSPEND, &tp->flags))
+	if (runtime_resume)
 		ret = rtl8152_runtime_resume(tp);
 	else
 		ret = rtl8152_system_resume(tp);
 
 	mutex_unlock(&tp->control);
 
+	/* If the device is RTL8152_INACCESSIBLE here then we should do a
+	 * reset. This is important because the usb_lock_device_for_reset()
+	 * that happens as a result of usb_queue_reset_device() will silently
+	 * fail if the device was suspended or if too much time passed.
+	 *
+	 * NOTE: The device is locked here so we can directly do the reset.
+	 * We don't need usb_lock_device_for_reset() because that's just a
+	 * wrapper over device_lock() and device_resume() (which calls us)
+	 * does that for us.
+	 */
+	if (!runtime_resume && test_bit(RTL8152_INACCESSIBLE, &tp->flags))
+		usb_reset_device(tp->udev);
+
 	return ret;
 }
 
-- 
2.53.0.rc1.217.geba53bf80e-goog


