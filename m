Return-Path: <netdev+bounces-254119-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kMVSM5S0eWk0ygEAu9opvQ
	(envelope-from <netdev+bounces-254119-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 08:02:44 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E5229D8FA
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 08:02:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 82DB0300F9F5
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 07:02:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37812238D27;
	Wed, 28 Jan 2026 07:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Eu/btvwj"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C81041EBFE0
	for <netdev@vger.kernel.org>; Wed, 28 Jan 2026 07:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769583761; cv=none; b=HmnRdQ6ovT4tb4nvJVOv/+A497gfLUIsuoeAr2mzS0UVD0VSexz55HBN/ekVU30WaThKUE70P4KRNoRwwh9/hu/bL0DLYHJdNxsVfGZUwRaZXWimuylNRNAM7+oDnh/O/Cown1Pb5IdvWuI1OlYNpR+XeecWqeon8EPeAvecBgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769583761; c=relaxed/simple;
	bh=jNWVs3NoJCDLt3Uob6MZkTWfmT/4JmZ5ZegDFFtHMQ8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XSrlQ8AyEQiJSbmu1727DZuajn0fvaTWQ3T0bh1Mbj9QBru1bLVH1UybEsVcv+VcAwBt5YRtxmSgugQsiXvv4TTk+afMPUUKa8tH5aGDuZ8mF2X8iwFlCwZfLQ4K0hr2800WxsLfLJlKEfo//J759CwSFHl2AaRJOJQGfzbEoUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Eu/btvwj; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-29efd139227so45814415ad.1
        for <netdev@vger.kernel.org>; Tue, 27 Jan 2026 23:02:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1769583759; x=1770188559; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zpz1+E5bIfL6Vl+vGItOAAFJ78Sq/brE0PF9AQXfuD0=;
        b=Eu/btvwjDHWSVkM9sBMw1iYxgv4q/mCO7Cw+OEWWYn2R9r5ftSc8DJ4Zsx+LGvcBM9
         +nfPnxxJETpAAKIx6p2eYeI5qqEO/fgie7iWQwsITNKGv3DW1SUF8lmPFHc52nWdZ4ZS
         eLCJcB3xtHYc4uz9gNZQmv5pfyjMpXzC5cpBs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769583759; x=1770188559;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zpz1+E5bIfL6Vl+vGItOAAFJ78Sq/brE0PF9AQXfuD0=;
        b=nJhpbtSeAA2pelj6ByTu0Sbl9/k2AYwabJ+Xl9bcZpzc/2ZCXq5BEKKKRbo904KnJ9
         qkjxHOHJSlsrSWSAOfhgeqnFPydffI4ZK+9lM0nEh7oORxalKgMZ5BLfMtJkuMooA0jk
         VBjRY7BmlON04bOzsdWfL5LrpVQMgsIoSYUfN92bv4FD5T0sxADKHD1K8pH36J41xApL
         FRPK9Cq6kKgAtlurwYH+2yoW+K5XBzhAsHah9EVUomydcz5tsy7/tOZo89hAURLKOFlY
         DL+yXmnDpXaBP/jBB0Bx7BC8CQUREzkOEe4HTjHweM5gjPAPYfFuriUrglhSpkfUWS/t
         NjEQ==
X-Forwarded-Encrypted: i=1; AJvYcCXOra3+JBjpZlDIeplf/xYyVweVazEoHYkcG0YZRMCcRrRwFugwcsiWLYUgzy+Md2p2jTS24Y0=@vger.kernel.org
X-Gm-Message-State: AOJu0YynBVrTKBNWLS6/2sBdlCDUZ4uN2swsG01iLGQr5O/6td441JFw
	U+9ecNmh/sS0v+FfelOqC3Z4y3OEtUoIvT0ZrUOf3zCMINJ7pwbpyAtspfcI/ImTpw==
X-Gm-Gg: AZuq6aJx12H92Z1gw/quUrn8uS5y55tFYoKPnl6Xyv10Gwf3N143DJfoPkDdCpXuHqS
	MOLNyqgP+qV/2gDTyAoa9TSf790TJ7DmUseLJr09FjubLfsOdM551HU0bA7cGCgHOgd3oZmOxFc
	KvBlBZq17Xflp+ETFesPNX2YwV2zXwGqKTLy+SEq5cLTkvG4FQA7jY4Rhzz1CCQS9ChhPQvizlU
	FHx+v52/ZM8AYRBYUIXqQ3in7Y3/EQyUtFuWkqbwGRWSaVkOPiineA6tqyCEvL6ikMJENI/dLrJ
	9xRZ3sWHAzTIBrJlcJQeYvLdek6/uziztroN8Jg8HfMFy98bA1hwnO+tHPh1QMPJdf12woHJS1g
	D1+dJSApoqXbrplkjBJ9T5soaZcFHX5e5UgfOt8N952zDjr5JIslJi0AzmFaAVGbBK3XDwqWf1+
	yhEnIdLgBQbi4RdCT2ch0l43MCgSZpEAzd4cldO7RoslLoR45Oa9CzdhNl7cJtVhI3hbzULbzV
X-Received: by 2002:a17:903:40ca:b0:2a0:f0db:690e with SMTP id d9443c01a7336-2a870e8ac0bmr41142995ad.52.1769583758569;
        Tue, 27 Jan 2026 23:02:38 -0800 (PST)
Received: from tigerii.tok.corp.google.com ([2a00:79e0:2031:6:bf24:413d:1e8a:6aa])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a88b3eedd0sm12975735ad.3.2026.01.27.23.02.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jan 2026 23:02:37 -0800 (PST)
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Paolo Abeni <pabeni@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>
Cc: Douglas Anderson <dianders@chromium.org>,
	Tomasz Figa <tfiga@chromium.org>,
	linux-usb@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCH] net: usb: r8152: fix resume reset deadlock
Date: Wed, 28 Jan 2026 16:01:52 +0900
Message-ID: <20260128070222.3393746-1-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.53.0.rc1.225.gd81095ad13-goog
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[chromium.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-254119-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[chromium.org:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[senozhatsky@chromium.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[chromium.org:email,chromium.org:dkim,chromium.org:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0E5229D8FA
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
Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 drivers/net/usb/r8152.c | 27 ++++++++++++++-------------
 1 file changed, 14 insertions(+), 13 deletions(-)

diff --git a/drivers/net/usb/r8152.c b/drivers/net/usb/r8152.c
index 30f937527cd2..c4f4e6a35ff4 100644
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
 
@@ -8661,6 +8648,7 @@ static int rtl8152_suspend(struct usb_interface *intf, pm_message_t message)
 static int rtl8152_resume(struct usb_interface *intf)
 {
 	struct r8152 *tp = usb_get_intfdata(intf);
+	bool system_resume = !test_bit(SELECTIVE_SUSPEND, &tp->flags);
 	int ret;
 
 	mutex_lock(&tp->control);
@@ -8674,6 +8662,19 @@ static int rtl8152_resume(struct usb_interface *intf)
 
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
+	if (system_resume && test_bit(RTL8152_INACCESSIBLE, &tp->flags))
+		ret = usb_reset_device(tp->udev);
+
 	return ret;
 }
 
-- 
2.53.0.rc1.225.gd81095ad13-goog


