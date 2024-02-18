Return-Path: <netdev+bounces-72778-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C8A6859920
	for <lists+netdev@lfdr.de>; Sun, 18 Feb 2024 20:45:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 51285281332
	for <lists+netdev@lfdr.de>; Sun, 18 Feb 2024 19:45:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C196171B39;
	Sun, 18 Feb 2024 19:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ctixvzyz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 144091DFC6
	for <netdev@vger.kernel.org>; Sun, 18 Feb 2024 19:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708285500; cv=none; b=lTCybEgvZxViDxec96lHVK5yF6erYfyiiPDTQNxANnJeUlB2w0YAMCBgDMlXohWpvBkji18IVAtXsWhEPYFDHd5Na7+Jq0k4t93M0EtczG0rete1olHPfa+YtrksrmbUB6ZoBXZxBoYHF55zhHjpJrqAQVvugFgGiCUcdMMKQgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708285500; c=relaxed/simple;
	bh=xkt6Xd6UJvj5puqV7PiGn//vK4ELNESN6wGXXd8GZ/s=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=h0oE6vcQ0ootYny16XWcupECW6wpzMnJdjbcDzzy01taxdw/oI4RrvFDbu5/Tw4d+NFv+P6IljJ1KFILQn407BSFkpzgn2ADIkyFMFTaM5mPL6ZjP5tddmC99fDe84XCBqnmuprpxDA3ZbS134+x8zsvCEWrRdQ67OmHo+p/rR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ctixvzyz; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-511976c126dso4406231e87.1
        for <netdev@vger.kernel.org>; Sun, 18 Feb 2024 11:44:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708285497; x=1708890297; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VyFC7JUUQjWOVmKWSg3KBq9XqDvZ45VrIOOfaP/wzYI=;
        b=ctixvzyzZZzVyKSCV8pO90rveccZVDNGLGhavskcre4epiIykHV/49rygqWvDx96Wk
         6ItHGbAvlU1vqJplwEnkOgC50a6tl+fQqqpaFiD4h8KLBRHw/lmWlpgNOoH2s3v/mGtK
         uyr4yrty4qI780QG5AGLNpDE/H8eDun8P3LLtKAcm26XKD8YccYDlzS9S8CJqnepeq1k
         HdlTAya0Z4sIcZjddjTh1/+W8Zy5mFua9ufCeUH2rvCFHRZld8UidbI6gnRXB0bj99Bl
         jskPT5MMqCniux+luAlUC8u4cL65eBEwjWdQKrhxtDGwWgc92Vw3uFzMKRqSF1ocbiEs
         Zk+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708285497; x=1708890297;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VyFC7JUUQjWOVmKWSg3KBq9XqDvZ45VrIOOfaP/wzYI=;
        b=fDOsc9VaKsQze1gwSdifqUUpoS0s7Np6THQxAvjn1U++o9AZBqbTCg3ZQGghWL5crZ
         LU0SYHl68THzP6WT36YJhPzrV9dzPp24uhOdcLz3tneWYpOjBv69wAhBlxycPL7ugIlf
         twJUX51+9eUfWdPkfugUDYB0YhWdBstYJUpbp7/7d427FEVODZ6T7r2S13i4gZiBc7jV
         BvT8mjqIMxWBHHBMUmZGWHI6liTsMB08NiABITlZalWmLveLU2NVpITbTwmNcz8lKX8P
         rVRFZzxsnW3KFh2afNYL/wGAfKE8DyNFUc/61ayszkHa/wdDqAd0dneM5KMrqQyp6xej
         KYjA==
X-Forwarded-Encrypted: i=1; AJvYcCVfEiuJuvwJDjRcsXRGkQmEzgwOXBNrRHf9QYm60jUeMDkujHzUETyOLmMrZSz3XlJ3UnVhA7vlzhZ9LnGqVKmW51IaDdSc
X-Gm-Message-State: AOJu0YxFAktqUvACZlBzTnvtPaCeX9MB4aLwMMMZGQtrMl908VgJpK1u
	LguHP8wdbckIvpPpzVvV1eQ1Sl4B/v000+6ncO0eDAiBVloK2xSB
X-Google-Smtp-Source: AGHT+IFSi/dhL8BzAj6TLxy0irbuu/qQnUQRpC80djhvbp5fhrzJBCEitE9p/+D51kX3XSLqMq3XbQ==
X-Received: by 2002:ac2:5e9e:0:b0:512:b555:17c4 with SMTP id b30-20020ac25e9e000000b00512b55517c4mr108539lfq.20.1708285496981;
        Sun, 18 Feb 2024 11:44:56 -0800 (PST)
Received: from mishin.sarov.local (95-37-3-243.dynamic.mts-nn.ru. [95.37.3.243])
        by smtp.gmail.com with ESMTPSA id g10-20020a19e04a000000b00512a875fbd5sm520183lfj.137.2024.02.18.11.44.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Feb 2024 11:44:56 -0800 (PST)
From: Maks Mishin <maks.mishinfz@gmail.com>
X-Google-Original-From: Maks Mishin <maks.mishinFZ@gmail.com>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: Maks Mishin <maks.mishinFZ@gmail.com>,
	netdev@vger.kernel.org
Subject: [PATCH] m_ife: Remove unused value
Date: Sun, 18 Feb 2024 22:44:13 +0300
Message-Id: <20240218194413.31742-1-maks.mishinFZ@gmail.com>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The variable `has_optional` do not used after set the value.
Found by RASU JSC.

Signed-off-by: Maks Mishin <maks.mishinFZ@gmail.com>
---
 tc/m_ife.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/tc/m_ife.c b/tc/m_ife.c
index 162607ce..42621bec 100644
--- a/tc/m_ife.c
+++ b/tc/m_ife.c
@@ -291,7 +291,6 @@ static int print_ife(struct action_util *au, FILE *f, struct rtattr *arg)
 	}
 
 	if (tb[TCA_IFE_DMAC]) {
-		has_optional = 1;
 		print_string(PRINT_ANY, "dst", "dst %s ",
 			     ll_addr_n2a(RTA_DATA(tb[TCA_IFE_DMAC]),
 					 RTA_PAYLOAD(tb[TCA_IFE_DMAC]), 0, b2,
@@ -299,7 +298,6 @@ static int print_ife(struct action_util *au, FILE *f, struct rtattr *arg)
 	}
 
 	if (tb[TCA_IFE_SMAC]) {
-		has_optional = 1;
 		print_string(PRINT_ANY, "src", "src %s ",
 			     ll_addr_n2a(RTA_DATA(tb[TCA_IFE_SMAC]),
 					 RTA_PAYLOAD(tb[TCA_IFE_SMAC]), 0, b2,
-- 
2.30.2


