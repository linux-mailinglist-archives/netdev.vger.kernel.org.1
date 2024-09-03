Return-Path: <netdev+bounces-124415-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 80300969586
	for <lists+netdev@lfdr.de>; Tue,  3 Sep 2024 09:31:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B2E971C231ED
	for <lists+netdev@lfdr.de>; Tue,  3 Sep 2024 07:31:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 289622101B9;
	Tue,  3 Sep 2024 07:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TMusd5NF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A43720FABB;
	Tue,  3 Sep 2024 07:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725348602; cv=none; b=fhKwEv114Pf0i4V5Ne1IjNgDHRMyudGCrRmIpN46EaHXHnph/bca7XjprdnOKyN8QmDPsnsHGRUOKQENHXMC2O/1HcdwEAW7NYVrPass/sy6/mq1mIgXVGZt34s9+xmR+7K2QVmrLTCKqHlHV7JfhtN7376pZeFKk65g8mQskDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725348602; c=relaxed/simple;
	bh=KKvHqt3siS6yomCisTHDJUcUhDzuy3LBBgDMRQ4k+Rg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nPQW9clfd6ldxqEoMFpnFZ4MV1XJCY6TGm6zUFTx7YXMuTsq2IKLCz5d9ZCFpFj1HRpQQ6FFue49hAg6GKRFh24ZPpHQ8wdxwd1/Lf8pu2+7m68LSOhAc7vUDluxbUMy8ucVGsuwDTS5r3OA5ikIrKjVTJ4NAl6WOlJ9mQYGbso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TMusd5NF; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5c255e3c327so2148910a12.1;
        Tue, 03 Sep 2024 00:30:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725348599; x=1725953399; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XndFyI8puSjAv9/6vHD7/Fma9yvh6kpyB+LRqezDNzk=;
        b=TMusd5NF6rWMZXHS3Wzjeq6bJnYeRsY1aVUxC4iDsq9zJJwn0FK8xSQ9z67n5wrut0
         xv0ZpbNI5qQc5Qa1z4w4mtf2dg+FCtp6umQaCT88a2F+nqoBC8CVvv2wclydDQKFTRz7
         O9WnF/W6udtsk07n3i8VcDgCnlwGM/AZnrRJapzAiu1wjiMpz80cCytF+rap1BhfCydp
         X5dzeDb457MzEQcdtp0Olso/SEkFZvkAPWHAAwz9868yeHkzsITwqf9c4igNGLeMtH0u
         92PDgHa+E0V9yv8ex7AZlDWmMRdw0nwkoE2UTe2hhPvzRAyUcn1mt379AIQCMOrQDhfe
         vAGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725348599; x=1725953399;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XndFyI8puSjAv9/6vHD7/Fma9yvh6kpyB+LRqezDNzk=;
        b=YXlUy1Y+QSjxtCPA+HPuUp3GDcmlaI+hwM6Hd75yqPmtLGaqo6GEfrQNzBA9J71eTp
         As32GkKYSPJNsQk3bnfUJNPX2OKk7g9WLGrHGGVUuEUMKA2ve6LQCfZSzT2eSUspKqxC
         0P8ovjwXwma6nAkVVcQBGEDneWuwv0HuMQcCirx2vf8fuIpezGcTeQylUyVb+Tl6fNx9
         qE/5EI+OpIRt3LHLC+E1WNUyeM0RHEgt61mr4RKwjGZ0M4SfCUYub3DveVZLfwayUiDs
         UvBpvXQXd/iaLAGX6JEp9OcGWN9mIaT84hnYs/jaeRsf+Aybr8EY0c55YrxdbO0Yi76A
         Iw4g==
X-Forwarded-Encrypted: i=1; AJvYcCU5Hw3xULvE9qNAXnYTVv6//gATyPqDntBOpwIQb2TmG9Zf8q7q7vQ5m6dh/PkpPgYdFoKNBWwF4oEq1GQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4TOGkYIIRux/UshvOLnRQAK3wvXF1d1h0HSkvzqJBEsrsSFEP
	9l5GUCukQ3NK4J2+8tyRX/L4nPtzH91UOIXV8GphHwvTJD4ay/Vb
X-Google-Smtp-Source: AGHT+IFB/oMp09sgiuT+TnuXo+ZNmtpslBujctoMWkBFwLgfqmHZzHNuEXPV06EtYHOC1hyljQaWkw==
X-Received: by 2002:a05:6402:2552:b0:5c2:5cf4:1949 with SMTP id 4fb4d7f45d1cf-5c25cf41a83mr3111262a12.19.1725348598291;
        Tue, 03 Sep 2024 00:29:58 -0700 (PDT)
Received: from lapsy144.cern.ch (lapsy144.ipv6.cern.ch. [2001:1458:202:99::100:4b])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c226c6a37asm6121947a12.1.2024.09.03.00.29.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Sep 2024 00:29:57 -0700 (PDT)
From: vtpieter@gmail.com
To: Woojung Huh <woojung.huh@microchip.com>,
	UNGLinuxDriver@microchip.com,
	Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	Arun.Ramadoss@microchip.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Tristram.Ha@microchip.com,
	o.rempel@pengutronix.de,
	Pieter Van Trappen <pieter.van.trappen@cern.ch>,
	Arun Ramadoss <arun.ramadoss@microchip.com>
Subject: [PATCH net-next v3 2/3] net: dsa: microchip: clean up ksz8_reg definition macros
Date: Tue,  3 Sep 2024 09:29:38 +0200
Message-ID: <20240903072946.344507-3-vtpieter@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240903072946.344507-1-vtpieter@gmail.com>
References: <20240903072946.344507-1-vtpieter@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Pieter Van Trappen <pieter.van.trappen@cern.ch>

Remove macros that are already defined at more appropriate places.

Signed-off-by: Pieter Van Trappen <pieter.van.trappen@cern.ch>
Acked-by: Arun Ramadoss <arun.ramadoss@microchip.com>
---
 drivers/net/dsa/microchip/ksz8_reg.h | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/net/dsa/microchip/ksz8_reg.h b/drivers/net/dsa/microchip/ksz8_reg.h
index ff264d57594f..329688603a58 100644
--- a/drivers/net/dsa/microchip/ksz8_reg.h
+++ b/drivers/net/dsa/microchip/ksz8_reg.h
@@ -364,8 +364,6 @@
 #define REG_IND_DATA_1			0x77
 #define REG_IND_DATA_0			0x78
 
-#define REG_IND_DATA_PME_EEE_ACL	0xA0
-
 #define REG_INT_STATUS			0x7C
 #define REG_INT_ENABLE			0x7D
 
@@ -709,8 +707,6 @@
 #define KSZ8795_ID_LO			0x1550
 #define KSZ8863_ID_LO			0x1430
 
-#define KSZ8795_SW_ID			0x8795
-
 #define PHY_REG_LINK_MD			0x1D
 
 #define PHY_START_CABLE_DIAG		BIT(15)
-- 
2.43.0


