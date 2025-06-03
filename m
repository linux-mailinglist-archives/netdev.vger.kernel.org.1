Return-Path: <netdev+bounces-194837-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0587CACCE64
	for <lists+netdev@lfdr.de>; Tue,  3 Jun 2025 22:49:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7238B1896A54
	for <lists+netdev@lfdr.de>; Tue,  3 Jun 2025 20:49:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32376226CF8;
	Tue,  3 Jun 2025 20:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ED7Y8iyV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 608D9223DD4;
	Tue,  3 Jun 2025 20:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748983751; cv=none; b=sbcOFm2EEA58cshOfSs3U5A0bCIzkx69pHCht9vv3DOCeyqF3LjllnllCP1VcFmT63E1dIOz8tvL/p2Q9c7shpdlG+tnQY6jxYOTpMd0P1SLgFp/oXNYVWmIQ+rACZ27znqq0AZ2XWTw1DVwutrFfyFAuCVR+S8k2usGfkYpYgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748983751; c=relaxed/simple;
	bh=MFodoEnYJ3jsHW78dm4UjN625qdhntN0iqnJaIPCeUo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Q8sbLwQQiXjUgS+V7mMccWfZ8EYGMAw6z3eHO6yVyELYVfV4vls37xtkatc+K6ziLYfn4IZ4CjYS1VfBLC544DANoKatrpppCXdMxgdvqRkT0OqZnN2XiE+Jgvq8a1whpbu9THOzSUElNR+GweBXaLzPCrsUR80EKPZGPo1j2gE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ED7Y8iyV; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-451d41e1ad1so27164635e9.1;
        Tue, 03 Jun 2025 13:49:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748983747; x=1749588547; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WrLj8YDGR2svTUzDCmjGgEt/98uPt0lyYQe6XuCq2O0=;
        b=ED7Y8iyV1h+xddF7jrB+iBv7gF+XfdqTmdvxU8V38V0TNTNqDWcepVdHAQbeRxo/a3
         b05TD4HKzLl02Bdad53AmoLDwIWuz8m3qDqX6woV36qtOzCL0IRm9kNpIS5ME3wtkuEA
         +HQ2asjnO/H/GbL/jW2zEya/HPZUXeYTDQ5gZj4k7tg0sVn5lsZ/pXLB9ppxM8vnxUX/
         Q0RQODCH/nqf8HIzUtFZXCaL1IWRCRPoRpxdWp/TBWg8X5Y94PvSzEzP+Fm6wbmP9CSO
         JYtJSH9q7MIXk3/gZpR9IN7Snge/8v/hbM5apKH5IGYQxu7OFaHGS4kzupFIbcBJ7j85
         2VLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748983747; x=1749588547;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WrLj8YDGR2svTUzDCmjGgEt/98uPt0lyYQe6XuCq2O0=;
        b=PvXduJBZrDZ6GTLYi19hOemRb6hDEcB09y7LMGfAC9Du6SJv+21m0lthGwsZUBHSyA
         bsfuT9EqRe+nSG6O6nLZspdMG1Ve/VGecFdkKVlXJlqsAVm5TWHPIm6DKONSViqpVlUO
         cr+wL1ByckOyKp3pWwbeXHXhjK6e9cm9jfAZyodxtlqjP6dIxpRULholOxMRmUSFmSv3
         gbzR/Ke2az+1x/0ak1wle38gxVwTPjunfV+5imcnIK7p819wTJNSEtcNhiMGXeyFaVk1
         xhYyEUrf1MgIqVx+LEw3iIuJ2O0jFNydfkXApsOmuNaJ3pbbvE+Euv3RwnRkhnqmt6/S
         Djkw==
X-Forwarded-Encrypted: i=1; AJvYcCUAqw56nWeA5AMVfPTiBnCBrI+pKCkrJJQcXHg3JGT8ZyGZXr+3hw5uAOOyzkR34cVZmQBvhwLBodXg+bI=@vger.kernel.org, AJvYcCXsA7l1iMt6KADi5J6n/pcD6GFBpzNeZnZalBSChIn4rRt5ObcbaCTKYyap96GqWVeIg2QBVC3M@vger.kernel.org
X-Gm-Message-State: AOJu0YyYhM5gyTiN5ll1HM9Blg00tqWAN1wjYVfUebiXEP3od383oYFT
	kGu8ICxzwjKeGQjcOfZOc4MahRZVtTWKvaojjrcU5EGosp2+Z9unN7pi
X-Gm-Gg: ASbGncvHFfMqQl8D4mr9wxnFOalnHMkashhSF+WNwQEHPS9N25IfWDEa1fCW8L+08cE
	xyhxAF1s357//WzLn+JNyGGhC+txyrMbdH70hkW8qh0yVeC8Zmx2nsYNI2n8Rp1Emr/BboJ/bje
	6ZlYxM98aUmj9MNy+7ueCfqIohP+cuFaxbqdn2fAG2IXgkQkewLcFq6bnJ/7OQlIS59+bNDFJV1
	YlUQE7xsZT1sK0LlU+qundf3+SIF4q8DZkj2EHa9KxofEci5iHVAlY3pJL+9uUM1uxYRngqAW62
	P79x03KFt5vaa7qOnlhfTpS3k14Kma+m0pmpMuJiueryhr2Q3t1X22wC41MNT949ZtJOvV6XrNe
	PC7xiBJQTePly2q70zFa6mKr2O/q7OGW9JCT1wXyjskKT+IwCoxyPy0qfspki32U=
X-Google-Smtp-Source: AGHT+IE+YzNqDQmxaM5kVGpzjMXzHj0ewkdFsvWz+8rMWwHTJNfXS2gE70poYHDgO0qm/Lqo+NWjyQ==
X-Received: by 2002:a05:600c:3f14:b0:439:8c80:6af4 with SMTP id 5b1f17b1804b1-451f0f5285cmr740395e9.19.1748983747529;
        Tue, 03 Jun 2025 13:49:07 -0700 (PDT)
Received: from skynet.lan (2a02-9142-4580-1500-0000-0000-0000-0008.red-2a02-914.customerbaf.ipv6.rima-tde.net. [2a02:9142:4580:1500::8])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-451e58c348asm26258225e9.3.2025.06.03.13.49.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Jun 2025 13:49:07 -0700 (PDT)
From: =?UTF-8?q?=C3=81lvaro=20Fern=C3=A1ndez=20Rojas?= <noltari@gmail.com>
To: jonas.gorski@gmail.com,
	florian.fainelli@broadcom.com,
	andrew@lunn.ch,
	olteanv@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	vivien.didelot@gmail.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	dgcbueu@gmail.com
Cc: =?UTF-8?q?=C3=81lvaro=20Fern=C3=A1ndez=20Rojas?= <noltari@gmail.com>
Subject: [RFC PATCH net-next v2 03/10] net: dsa: b53: prevent SWITCH_CTRL access on BCM5325
Date: Tue,  3 Jun 2025 22:48:51 +0200
Message-Id: <20250603204858.72402-4-noltari@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250603204858.72402-1-noltari@gmail.com>
References: <20250603204858.72402-1-noltari@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

BCM5325 doesn't implement SWITCH_CTRL register so we should avoid reading
or writing it.

Fixes: a424f0de6163 ("net: dsa: b53: Include IMP/CPU port in dumb forwarding mode")
Signed-off-by: Álvaro Fernández Rojas <noltari@gmail.com>
Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
---
 drivers/net/dsa/b53/b53_common.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

 v2: no changes

diff --git a/drivers/net/dsa/b53/b53_common.c b/drivers/net/dsa/b53/b53_common.c
index 525306193f80e..1e47ef9f6fb88 100644
--- a/drivers/net/dsa/b53/b53_common.c
+++ b/drivers/net/dsa/b53/b53_common.c
@@ -360,11 +360,12 @@ static void b53_set_forwarding(struct b53_device *dev, int enable)
 
 	b53_write8(dev, B53_CTRL_PAGE, B53_SWITCH_MODE, mgmt);
 
-	/* Include IMP port in dumb forwarding mode
-	 */
-	b53_read8(dev, B53_CTRL_PAGE, B53_SWITCH_CTRL, &mgmt);
-	mgmt |= B53_MII_DUMB_FWDG_EN;
-	b53_write8(dev, B53_CTRL_PAGE, B53_SWITCH_CTRL, mgmt);
+	if (!is5325(dev)) {
+		/* Include IMP port in dumb forwarding mode */
+		b53_read8(dev, B53_CTRL_PAGE, B53_SWITCH_CTRL, &mgmt);
+		mgmt |= B53_MII_DUMB_FWDG_EN;
+		b53_write8(dev, B53_CTRL_PAGE, B53_SWITCH_CTRL, mgmt);
+	}
 
 	/* Look at B53_UC_FWD_EN and B53_MC_FWD_EN to decide whether
 	 * frames should be flooded or not.
-- 
2.39.5


