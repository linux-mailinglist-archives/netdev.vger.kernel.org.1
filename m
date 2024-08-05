Return-Path: <netdev+bounces-115864-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9713C9481A0
	for <lists+netdev@lfdr.de>; Mon,  5 Aug 2024 20:32:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 513AF28F528
	for <lists+netdev@lfdr.de>; Mon,  5 Aug 2024 18:32:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CCDA16BE1A;
	Mon,  5 Aug 2024 18:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="KMWVr5d8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f181.google.com (mail-il1-f181.google.com [209.85.166.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3B9816BE06
	for <netdev@vger.kernel.org>; Mon,  5 Aug 2024 18:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722882688; cv=none; b=Wu2iFNJH3NOal0RMWS2YQ8QdurPL1O0w/VAo+/RjsFnEDCoGV28G/GtuwuMPo3nkmBdRJbk00k4jrJgxZoGLBGrba3uFreI7hQvgdnobz30kQl5Gats3Pz7//NFHvObR1TXwLPheNaXWFtedr1UZoN1yW+WzOQzaQh6xeXsr388=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722882688; c=relaxed/simple;
	bh=9IXfsH20XvSwQIie4Zhn+/T6EtzkHPcaklqjFILszaQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lb5zgBRJGcr5OSU5e5vwTUwILKXPoEtcCAiAl0aXPAqpJqPivprXtgz0glMUleU9bAK/Wara/xx6h6tukzQ6DO8ryOtkH4+S7qpw1U8cPlwSRl6euhx2OAowN1oTEmD2rn0ZUFCkVToDTBdbpNV/IkTAJxA8/3OlJHBl3PH7fCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=KMWVr5d8; arc=none smtp.client-ip=209.85.166.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-il1-f181.google.com with SMTP id e9e14a558f8ab-397ba4f7387so56571885ab.0
        for <netdev@vger.kernel.org>; Mon, 05 Aug 2024 11:31:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1722882686; x=1723487486; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GxGzwj10hbPoGUDFHjUigzECxz7Emr4gq2Vxs8apx1I=;
        b=KMWVr5d81ns6yMHyjRDRzC7XAfkhwW6RNwK3aFys4i0PYzoF2J83ubhqAyGUDIpqG3
         PVmjeYgSRQasIIWr4BkoR4KPL4Jstl952HDmY1oQqWjdw0nU1Bqk7pu7KBuiKv27PCuH
         LskDYJgnUXASids/YPfIAqIJ3sXzg3K1pPPm9hwC1ju4tCH6dCqSsYKO/uynJ/jaxvcs
         y+EZj0c9ScBL1NofsUypnFM8rrjYp3FIu9mXSikV5NJczi/qhlg8GNcKdlOL7wt8cDvG
         aOaKSDdLWs2R/YltMPEQ9DIM0Q/IeL2ah/Yt48zPo0LLw681Km2ImAuxkJgGT85tOjtV
         +kvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722882686; x=1723487486;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GxGzwj10hbPoGUDFHjUigzECxz7Emr4gq2Vxs8apx1I=;
        b=Irs5UNPtJ4dkFy1Etmem0C+QWWdVktaqzyPGOlIR2fHdFikr1Y8yyYyZeSuAGdsKyt
         XkeYVLpmV+vMX+V0Ok/QxbF9GVOKdeUydeMuQ/qDA/N3j5eX4gMJPSD4EQOrY2fxA0SJ
         LrJr8yWY7Jys2hWRXGTdGH53c22m1Ik2lYjEmABetSLUDoEOt0r7L4RVphj4C4/lehM5
         R1GIig0B4cn5PeDAmNnUaUaBIKzLLEBZ+seCv1lit0Bz1zSKCqx56Psf/FU7VcnHvw91
         8xm7GjGUwy7lhNwziwrclVPlxd4KD2JzixXXoRHqOlA/hNI8dqXqYyw0g9q2aR0tc21o
         K8zg==
X-Forwarded-Encrypted: i=1; AJvYcCUHLGk8lRU+gQSIEEZGN0aNWsvtk4TZXyue8oo6eMa3liYgtDZo2z69sOT3LotCe5KwCIwm2lsriayqIgseyM/F6A/nUm/v
X-Gm-Message-State: AOJu0YxNYS5OhlSXOqj3KfzVaRnL2mbzc7k+R9ziGKtB1SDyD8+NWwzG
	F9tGm10DPZH5z7mkvukCVFNH4qc/L6Ysk17+GezA8PaPL5mwfSCdzSgwNe9fbds=
X-Google-Smtp-Source: AGHT+IHbUX5iMkWxY0jz/xH/juQai5lNjO2y87fBuXrzbN7VDYTkNYag15NCr2K+gsamtX8MhFXyAw==
X-Received: by 2002:a05:6e02:218f:b0:39b:2ca4:e391 with SMTP id e9e14a558f8ab-39b2ca4e898mr107173745ab.1.1722882685753;
        Mon, 05 Aug 2024 11:31:25 -0700 (PDT)
Received: from blmsp.fritz.box ([2001:4091:a245:8609:c1c4:a4f8:94c8:31f2])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-39b20a9af29sm30867925ab.13.2024.08.05.11.31.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Aug 2024 11:31:25 -0700 (PDT)
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
Subject: [PATCH v2 5/7] can: m_can: disable_all_interrupts, not clear active_interrupts
Date: Mon,  5 Aug 2024 20:30:45 +0200
Message-ID: <20240805183047.305630-6-msp@baylibre.com>
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

active_interrupts is a cache for the enabled interrupts and not the
global masking of interrupts. Do not clear this variable otherwise we
may loose the state of the interrupts.

Fixes: 07f25091ca02 ("can: m_can: Implement receive coalescing")
Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
---
 drivers/net/can/m_can/m_can.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
index f2fc862fb21c..7910ee5c5797 100644
--- a/drivers/net/can/m_can/m_can.c
+++ b/drivers/net/can/m_can/m_can.c
@@ -483,7 +483,6 @@ static inline void m_can_disable_all_interrupts(struct m_can_classdev *cdev)
 {
 	m_can_coalescing_disable(cdev);
 	m_can_write(cdev, M_CAN_ILE, 0x0);
-	cdev->active_interrupts = 0x0;
 
 	if (!cdev->net->irq) {
 		dev_dbg(cdev->dev, "Stop hrtimer\n");
-- 
2.45.2


