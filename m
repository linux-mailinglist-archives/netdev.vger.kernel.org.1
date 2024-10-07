Return-Path: <netdev+bounces-132801-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 327BC99339D
	for <lists+netdev@lfdr.de>; Mon,  7 Oct 2024 18:39:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3DE381C239DF
	for <lists+netdev@lfdr.de>; Mon,  7 Oct 2024 16:39:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E1C41DB531;
	Mon,  7 Oct 2024 16:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="eiVrCxCG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9234D1DA610
	for <netdev@vger.kernel.org>; Mon,  7 Oct 2024 16:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728319105; cv=none; b=BFx3HpKKDwBQI76zgs0hPJ53xQ+e5FbiR/VDobt5w53ikapaFi8D/PFAdPw32GhIaHSOuR7fKzRtNoR82bUl2smgLGCldODTam+1hw68kd519aIpsQjypY1HfT9zz9tp/wOWg+StQFbiJNV/mVpUfZcwvNBKYc8dEhECXW5e5pk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728319105; c=relaxed/simple;
	bh=14hcJr6OfPPOEu402w1kAdGgKIKqcXDs4lXvFfP1H6I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VkPgGwaQnICPp+kPyxbJTQUdow0nGfIzCNbfs8kQAMIw57yihCD27iEJ2VKRByyD6H4mwTKC2+36gji1zcQ3K4XhYY1yV8szAHMUGggwMy+Q6KmFRCkwEpwOS1R3lI5Smo2KT+hZONfUVKt7FMAhG+y0VYL2UQHF5qRwSURRd8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=eiVrCxCG; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-20b6c311f62so39987155ad.0
        for <netdev@vger.kernel.org>; Mon, 07 Oct 2024 09:38:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1728319103; x=1728923903; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Yc77PjJUiDeXng7rXZFp7DhaHfvl24R+UoJhU9+/xy4=;
        b=eiVrCxCGZJEeC7jrIAvqijD4JUVNNFO4PB42C1ChPSd0FOQJm0LLWDctYv5DdLHTv2
         R3vJvGDs1alN/h4Qu6OzMT3k65YwFKJ1K7fRtQ16SoNFn1AMi4cMUBS4pCgtlzKA96wB
         m8klZqqpbIKKfyJ7VEXYF2SVgzfmXNKF44D8hEiLFKphzrixy3WFIqKOLpYA2NymtIgB
         XyvxKWJUOcyZLbCKIOVdSKAxS9qg6Kj11wlgD2p9nl4st1Tpdo7LdCbrHDnVzSdySLf5
         y7iISEaq2IfJQblZC+iEI4kNAmgjQask3cd+U0wqXe/K+HNk6pRQ8+TFcOzx9iQm5VX8
         NBzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728319103; x=1728923903;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Yc77PjJUiDeXng7rXZFp7DhaHfvl24R+UoJhU9+/xy4=;
        b=H4zCwxailvlmoxDjV9QT/qVAs7q6oxlq3PnA9kns0X2HSF8l37KJBZ9TKdkOzfC9KZ
         HRuSTudvdn+RUYAr8OHl5IlnPK8VxwvaRvoVVKu36xaYbty/TM0KGxSpz3mn559AM55M
         ATBhoxAbRItOi8ONk8MZQ8/VukLZ6Hs9g6kXFhCTwK7tb9R2Hete4pQrYfLvruRwBLOh
         DHMwqKX+AQP5LgXrl/ILH2xdvNRopEM6CzdE1OBGpNywvtc3W3j2T+S/qLv09Gika9i5
         i5QmdTjdw6XHIljLE8t5GIuXhABDygSFdw1MBtjqVaKRP5q92yStuLJ1eZftOifM4eBG
         xf4w==
X-Gm-Message-State: AOJu0Yy4C3ZCJbQmmwMHCRaeBhELEU03I/jVyIx5dEsFmqkiNMzKK2H4
	aizeCVLGeG1PrBVDP2jMGwX4mKOv8n5TQ39MCWjx0Jm8yv3AIU5viWk4p1xsw+lSF7arLCjZnKl
	o
X-Google-Smtp-Source: AGHT+IHjd9SkVGVbEYqymkj8WiT7fsLxCD6hh+NbqtkeqTN8naq33T7upXdlTXTRjyaT2fX41fcZhw==
X-Received: by 2002:a17:902:db03:b0:20b:9841:b44a with SMTP id d9443c01a7336-20bff227da1mr156585515ad.61.1728319102849;
        Mon, 07 Oct 2024 09:38:22 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20c1398a767sm41534845ad.273.2024.10.07.09.38.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2024 09:38:22 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: netdev@vger.kernel.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH iproute] netem: swap transposed calloc args
Date: Mon,  7 Oct 2024 09:38:04 -0700
Message-ID: <20241007163812.499944-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Gcc with -Wextra complains about transposed args to calloc
in netem.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 tc/q_netem.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tc/q_netem.c b/tc/q_netem.c
index 90b26136..c48fde11 100644
--- a/tc/q_netem.c
+++ b/tc/q_netem.c
@@ -414,7 +414,7 @@ random_loss_model:
 			}
 		} else if (matches(*argv, "distribution") == 0) {
 			NEXT_ARG();
-			dist_data = calloc(sizeof(dist_data[0]), MAX_DIST);
+			dist_data = calloc(MAX_DIST, sizeof(dist_data[0]));
 			if (dist_data == NULL)
 				return -1;
 
@@ -479,7 +479,7 @@ random_loss_model:
 				if (strcmp(*argv, "distribution") == 0) {
 					present[TCA_NETEM_SLOT] = 1;
 					NEXT_ARG();
-					slot_dist_data = calloc(sizeof(slot_dist_data[0]), MAX_DIST);
+					slot_dist_data = calloc(MAX_DIST, sizeof(slot_dist_data[0]));
 					if (!slot_dist_data)
 						return -1;
 					slot_dist_size = get_distribution(*argv, slot_dist_data, MAX_DIST);
-- 
2.45.2


