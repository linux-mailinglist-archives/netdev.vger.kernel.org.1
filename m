Return-Path: <netdev+bounces-115865-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 838279481A3
	for <lists+netdev@lfdr.de>; Mon,  5 Aug 2024 20:33:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B46821C21DDC
	for <lists+netdev@lfdr.de>; Mon,  5 Aug 2024 18:33:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EB5816C692;
	Mon,  5 Aug 2024 18:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="jdVMrfqB"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f176.google.com (mail-il1-f176.google.com [209.85.166.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4C8A16C426
	for <netdev@vger.kernel.org>; Mon,  5 Aug 2024 18:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722882691; cv=none; b=LmxJB5jnAA21yHc99EvE4VwBe8a7aRcJ8EDphc5z87Lh8YZWLD3oUI+8Uw/OUZek7G9VMKgcLlFvEhtX93/cxf7rEUgykNvsVEeHRA3fuHQH2TNdVzwnKR8wLXMOYjiyDMm/yp9fUHLkigtR3XKKj+0s4ILK+sRojug1AF/cbDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722882691; c=relaxed/simple;
	bh=J1n8p9ZiV4NPzCCG4igoxgIPW/lPHOV2bvu8WbY9M3Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eqJSNuLjitGFwwRLnCjPdAwYQqXkzxutXIFNy682uz3mAtGiyZwzJ6qN72Wn74G9vF5vRlf/jsihheCnX8WojTpg5H4VC4f8ua9TMDl3Gc3QpdJzFS2kK5Dbzxi6fAF/EdR92ajuJO1p7JzruGjyPFQNsLIqjzHFgIWHiwwrOUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=jdVMrfqB; arc=none smtp.client-ip=209.85.166.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-il1-f176.google.com with SMTP id e9e14a558f8ab-3737dc4a669so47362375ab.0
        for <netdev@vger.kernel.org>; Mon, 05 Aug 2024 11:31:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1722882689; x=1723487489; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f+HPjuz5W8Yx1DVIjzCZ4+iLii+dpzxtWHgPSNE/Bhk=;
        b=jdVMrfqBh500qkvXX/UaWRDgiM6YyHIoH32SOabGtu+JLyRa7+eocaSpSb8pddaMvq
         nBLjwVZkzqebwaUjylZA+nKCy6E3xA3/JmOY+yI/Mky9vbTh0jFUalpMXrlJ7UrWOwr2
         CDQ/7cntU+SD9lRAsi7bz9CxtcFYpKgfd3/J+Y+MIeHF0StI+bb7mdAVVO0MCukdcIEZ
         SYuUaTaeT/86+s+fD8mxyDmZDp6Q615EjDU/rxPR2VITH0miHlSjD39UR4oktExVgWxb
         jaSVTyVD0SpikPotCYlFZwBeP4WezB14RxRAK18+rPreb2mfjFHJhCnCUhnFtOCM2REF
         HOhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722882689; x=1723487489;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f+HPjuz5W8Yx1DVIjzCZ4+iLii+dpzxtWHgPSNE/Bhk=;
        b=QpT/ZYtK9Ma2HTpuqblAjWcx33K1RcMVySD9BIix2uO4MKO/OxzHvs2nAVQpHylst9
         pJCJl1mEacUVm7kV0hX6eNC19CS1xrgusre800ckkwln1WV7PVokYXoZJYcac2lRQ2BG
         uUrradQwmlJm1fyJ7DuEt3j/cTkO9I1kcXZIJHkB6ejyN50y4U44HxDTNEMzDCOWAT6j
         W0zxt+T2O28mXGhqxzfzrhuFQo7nutDRKn5Q4tRANakY2XBApqDMXl37ykXaMe8cm++t
         Hh+PwQv9Bai8P5wL4OJjcSOrIpZgBiq3FN6RVxsgEzwulCeD+AFJyDmZXksZ+GIvwMeM
         65fQ==
X-Forwarded-Encrypted: i=1; AJvYcCWrIoRsof9A/CKPi9vkUtaX2zgSkunbkUm1m3CBH7Tx5FsnEh5aTkdUQMOawqT67bQ0tYSIH469Qj31Wv5ez97wAVvsHDOE
X-Gm-Message-State: AOJu0YyBt3BO2LyCJS3IHBku7z41z91Z410nedA/L0L80cGgTJ91s1wE
	ob0Qi+UHyyFcfHY39Ttmw75nBtuEdzSANzkuH9AnykR39kI6T8k2GJLtr++7X/E=
X-Google-Smtp-Source: AGHT+IEq6598CGYDXwUJlEvoWxu+/g6kFoPjvVucBrR7owowbQb3f7jYWmpb4FTOuABE7Ovcpsxrdw==
X-Received: by 2002:a92:c988:0:b0:39b:393e:28ca with SMTP id e9e14a558f8ab-39b393e29c4mr71466915ab.12.1722882688825;
        Mon, 05 Aug 2024 11:31:28 -0700 (PDT)
Received: from blmsp.fritz.box ([2001:4091:a245:8609:c1c4:a4f8:94c8:31f2])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-39b20a9af29sm30867925ab.13.2024.08.05.11.31.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Aug 2024 11:31:28 -0700 (PDT)
From: Markus Schneider-Pargmann <msp@baylibre.com>
To: Chandrasekar Ramakrishnan <rcsekar@samsung.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	=?UTF-8?q?Martin=20Hundeb=C3=B8ll?= <martin@geanix.com>,
	Markus Schneider-Pargmann <msp@baylibre.com>,
	Judith Mendez <jm@ti.com>,
	Tony Lindgren <tony@atomide.com>,
	Simon Horman <horms@kernel.org>
Cc: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
	Linux regression tracking <regressions@leemhuis.info>,
	linux-can@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 6/7] can: m_can: Reset cached active_interrupts on start
Date: Mon,  5 Aug 2024 20:30:46 +0200
Message-ID: <20240805183047.305630-7-msp@baylibre.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240805183047.305630-1-msp@baylibre.com>
References: <20240805183047.305630-1-msp@baylibre.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

To force writing the enabled interrupts, reset the active_interrupts
cache.

Fixes: 07f25091ca02 ("can: m_can: Implement receive coalescing")
Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
---
 drivers/net/can/m_can/m_can.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
index 7910ee5c5797..69a7cbce19b4 100644
--- a/drivers/net/can/m_can/m_can.c
+++ b/drivers/net/can/m_can/m_can.c
@@ -1541,6 +1541,7 @@ static int m_can_chip_config(struct net_device *dev)
 		else
 			interrupts &= ~(IR_ERR_LEC_31X);
 	}
+	cdev->active_interrupts = 0;
 	m_can_interrupt_enable(cdev, interrupts);
 
 	/* route all interrupts to INT0 */
-- 
2.45.2


