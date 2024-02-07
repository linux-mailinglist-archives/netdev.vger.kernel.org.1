Return-Path: <netdev+bounces-69743-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C07784C767
	for <lists+netdev@lfdr.de>; Wed,  7 Feb 2024 10:33:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 110932831CA
	for <lists+netdev@lfdr.de>; Wed,  7 Feb 2024 09:33:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA1FC23741;
	Wed,  7 Feb 2024 09:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="TdrbNqjo"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E11C3219FD
	for <netdev@vger.kernel.org>; Wed,  7 Feb 2024 09:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707298360; cv=none; b=KLxRNC1Bu2bsPNLwGViLu+vrigWVn3raKlZOGEbhbdhgRXrAZUHnPbJhtHAOXCWhl/eMZ9CWNuvItMfejgTbGDUHE0yrYvTEuGJ6Q3r2AbDfidqKcIMPwm9yE9J7cpvmkaWbf12Z6Qrrd/9aNCmBJMgKbhapuGdF34TqtKWHsKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707298360; c=relaxed/simple;
	bh=xKm31x/RdzKjtmNCaQqPULxnB/TjUDs1QrTh8HGx5EY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UKredWALZEIVf6C7P2QH2okkeKiWIu4EAGqbvpy8W098YJiJtYmVD+OFCjojG4+x4sLv9kyQmKLAS/OZKA0zuHfVWvPzK88zPn76Ycp9d0xqB9/jKUmsVflAevKaCUkoFp1qe9C0SV+HsKRVLmZODJDWdudeYVt3TlzhBj9Zkes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=TdrbNqjo; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a37878ac4f4so50992366b.2
        for <netdev@vger.kernel.org>; Wed, 07 Feb 2024 01:32:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1707298357; x=1707903157; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9LasvPwar56cmUGpfIKyPUkfrzO6sViDcJ1By12B3aI=;
        b=TdrbNqjoU8Yir8KxBgsArNv812ClYWoEpIDK23B/C1otESJlUk0xFXAiHoo9jq8tpE
         nwSgYICUqETyzL9Qba3+f0golCnAm4JN4zKzmOAj3SOTgfJ7iH7x93r6phKs+UmcSzlL
         pWWC4Pz/S1Hnmmqm319Rv9sbydx0/U0Zp15xparAUcBiOqX2r+cb6sF9TRYsvIxQPEjU
         wg1838KOI9oDdl+KqxQdE3uaDmb74D98L4NkLCIora6b2Bv1zVXksaeL29yFRhZVnEYm
         w02PAtF6y7mumpdbPW5WbwVjo5QcO6TW3znapHb/fNnKjJC9JzFF6hlmjpZrR5zWSJNK
         l1RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707298357; x=1707903157;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9LasvPwar56cmUGpfIKyPUkfrzO6sViDcJ1By12B3aI=;
        b=WzHWMvp4ENe8XkCU7IxZ5cqbdWza+eAkK6BeLfJjUIHXcQ3IPw6LEuwIRlovKDxElu
         KC7NO5cfJH+4qnBvvHtOQusjmcXQdGma/IjKoA5DtlKQKU67oshd6e+E6pemoCjsnNTQ
         n/JW2bpIb0a0eJNPdIenDPxaH8PQ27YTcFYXnAZmQlmBXqIGqWFDKruxd/bhMAWbwAzc
         +DIzobV6kBdwU3jowXtOV1INwTLCu6ofz5xblq39Bv/RTXk6lK9ZtNkd0Al8jDJ2pR61
         51eLVc1RgwJ1DNJjKBdDzuD96JR2mpBLsUxLltd4uzUGduFYRyUFB6typYgcZD2IwX+J
         Ux4g==
X-Forwarded-Encrypted: i=1; AJvYcCXQS2pVsNRYyYi0/iXc5F4Dl60i57IJSZJxEhkkN94QWVCKzh0iO3YrTNZBA9iRKsR0+x1LEskTFMyp7UP52TAcitHEMzYY
X-Gm-Message-State: AOJu0YwtPLutkU2YauKgSM45GWZ14njmjw9aeT+1ESFRQmTT50WPBkDF
	xkKcPvfA7iWdDtzoagBu1tYnXxQBIC2V4L+SZv8TgekGwLJ5Fpe0sROuPs51YoU=
X-Google-Smtp-Source: AGHT+IG55kdXvi0Z3Md9f2xm4G+MpDcJ9YEr11th4GSz59Inm4lWKUV4obYPl13NUgY9aDhqLtE71Q==
X-Received: by 2002:a17:906:acd:b0:a37:adee:509f with SMTP id z13-20020a1709060acd00b00a37adee509fmr4053526ejf.12.1707298357175;
        Wed, 07 Feb 2024 01:32:37 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVV6M49yfwmeZao0z9NZWCWgW1TbgNa9mmQo6YeMWH9S0oRB9l+W1LMKezrhQ/zib0uQlUqM+EJvPKLgwl62uSN0iQv1PIOSm+FeRGbIl7byM379mIHHy257MhqVjBVCBWSjLFYK+PBQK0NuxSLnJOHeur/CoWcQgOJ/04UB70kG8RnIW/Lp5XA06XAquEt/vTR4LUClb178PP0kmttpBvAQ59veDHJcvyUMZR7BIv5esU3HyGrT93W/UjaTvMvhVZjklUirn8GVjraVcRZNUVFapW+K1z7s5+8YdOd5uU1yxgZx8OIL2kn7wPRA9tIWyozB3xeXuN5QG7Rfg+71oxuNimp1e+y/ZzGQBqK0iW5QwfQcfcUxaNv9ZLxuanTum/C1w6ZD9vbiqz66rFdVxkbGXFUuvzqXIi7jujxutIXsghjXnzNc7T2w8IK
Received: from blmsp.fritz.box ([2001:4091:a246:821e:6f3b:6b50:4762:8343])
        by smtp.gmail.com with ESMTPSA id qo9-20020a170907874900b00a388e24f533sm122336ejc.148.2024.02.07.01.32.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Feb 2024 01:32:36 -0800 (PST)
From: Markus Schneider-Pargmann <msp@baylibre.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>,
	Chandrasekar Ramakrishnan <rcsekar@samsung.com>,
	Wolfgang Grandegger <wg@grandegger.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Tony Lindgren <tony@atomide.com>,
	Judith Mendez <jm@ti.com>
Cc: Vincent MAILHOL <mailhol.vincent@wanadoo.fr>,
	Simon Horman <horms@kernel.org>,
	linux-can@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Julien Panis <jpanis@baylibre.com>,
	Markus Schneider-Pargmann <msp@baylibre.com>
Subject: [PATCH 02/14] can: m_can: Move hrtimer init to m_can_class_register
Date: Wed,  7 Feb 2024 10:32:08 +0100
Message-ID: <20240207093220.2681425-3-msp@baylibre.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240207093220.2681425-1-msp@baylibre.com>
References: <20240207093220.2681425-1-msp@baylibre.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The hrtimer_init() is called in m_can_plat_probe() and the hrtimer
function is set in m_can_class_register(). For readability it is better
to keep these two together in m_can_class_register().

Cc: Judith Mendez <jm@ti.com>
Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
---
 drivers/net/can/m_can/m_can.c          | 6 +++++-
 drivers/net/can/m_can/m_can_platform.c | 4 ----
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
index 2395b1225cc8..45391492339e 100644
--- a/drivers/net/can/m_can/m_can.c
+++ b/drivers/net/can/m_can/m_can.c
@@ -2070,8 +2070,12 @@ int m_can_class_register(struct m_can_classdev *cdev)
 			goto clk_disable;
 	}
 
-	if (!cdev->net->irq)
+	if (!cdev->net->irq) {
+		dev_dbg(cdev->dev, "Polling enabled, initialize hrtimer");
+		hrtimer_init(&cdev->hrtimer, CLOCK_MONOTONIC,
+			     HRTIMER_MODE_REL_PINNED);
 		cdev->hrtimer.function = &hrtimer_callback;
+	}
 
 	ret = m_can_dev_setup(cdev);
 	if (ret)
diff --git a/drivers/net/can/m_can/m_can_platform.c b/drivers/net/can/m_can/m_can_platform.c
index cdb28d6a092c..ab1b8211a61c 100644
--- a/drivers/net/can/m_can/m_can_platform.c
+++ b/drivers/net/can/m_can/m_can_platform.c
@@ -109,10 +109,6 @@ static int m_can_plat_probe(struct platform_device *pdev)
 			ret = irq;
 			goto probe_fail;
 		}
-	} else {
-		dev_dbg(mcan_class->dev, "Polling enabled, initialize hrtimer");
-		hrtimer_init(&mcan_class->hrtimer, CLOCK_MONOTONIC,
-			     HRTIMER_MODE_REL_PINNED);
 	}
 
 	/* message ram could be shared */
-- 
2.43.0


