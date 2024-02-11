Return-Path: <netdev+bounces-70826-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 72600850A8C
	for <lists+netdev@lfdr.de>; Sun, 11 Feb 2024 18:25:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 830471C20E4C
	for <lists+netdev@lfdr.de>; Sun, 11 Feb 2024 17:25:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85FE85C8FD;
	Sun, 11 Feb 2024 17:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="hnhjZeOq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E0905C5EC
	for <netdev@vger.kernel.org>; Sun, 11 Feb 2024 17:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707672345; cv=none; b=ZpYANs7nG8907NFNTCMovrGMCaECg6WH6Y4J5IIqi4Tdfzs9z7Z9g1TOGaq7McD5vxnmwpycqjNYIztv5jIOlSsVyrwXSCA9tzX7sIYYc3M5b/YaNmIsJuXBOTuAtWsqXm5qWGaUXVihDCLJYowRH/c4nnMj4I1VrGecXaRU1q8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707672345; c=relaxed/simple;
	bh=RCxN/8Q94HC17/e/hvM0Z1c3N9saa0xs55/N5JFLm5Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=M7lJyV1jU8pQm5s8P48XfDNIi3QzElcOtGAAd+tK42QPS/OrFnLXsL9ZgUtGcIhNrFM9pAYo5DQRLgRRTdCMsK3xXTgq4UuXMO2fVlH76BrGhR/mFTJULq4wEVE/Ro9u91Iw2ZWNx17MZgR5cWFqVn8fgsBRNW0XLjiC3ZvoJ0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=hnhjZeOq; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-29041136f73so1490263a91.0
        for <netdev@vger.kernel.org>; Sun, 11 Feb 2024 09:25:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1707672343; x=1708277143; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=poxDfnKMtldjN/FCQ2gomlcqAYRrHgqYM55OI6kOfTE=;
        b=hnhjZeOqc0GqNfEqNw5CZv+tsS5A6Dxhog7pynOm+MBVz8JOzCxUfck2GuoQMnqoht
         KJB0qhg14DhkUq/vKkpkAveZI2Iq1N4NiwfqHWGXtxsNBxSt/WtGSevDv3KhXxqMRqua
         L1ABWPcP0RgExEoDBxJty+aUjI2W2aXxyLZPjf9IaFJAGoA91lik8xa6DfY3GjhTyH4H
         4U36IB4yhdr6D6DB3PcOVkDt/zuPkgATshgMq6T4BWei5rcnpBYc4l2OJeCQRV4auxa8
         AnEC7KXk0E7mpWFoHpL4CykBOzphT3scl64zfIO9n/9nipRBlgSLUgPKJbUY8ZkGwA8h
         ifmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707672343; x=1708277143;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=poxDfnKMtldjN/FCQ2gomlcqAYRrHgqYM55OI6kOfTE=;
        b=vWp7upvqKn3894VAfqXctDDswQLysJe2V8T/ltx6qSzXnQezACeU6Y55JrD+XzwZD/
         zVn8TLNNsarfSvGA6bO+fiGCCQEMIZDxJyM4XaEkoG/XMcI8WoFjQ0Pdnfx9LU9v0wE7
         ZmfL2P/Dd/D6t0HhNYPnk/l0vex8rKoaaBMAjW715PhI9SMbEBLie3He5x68Bei/NZfR
         bVswIz0CAr0vRFbdATuceadA03ZwilkfZZAFaY6atYRVLiP1EZcO5w7z6DWx2U1RHi1t
         DrMozGdwWm0wjxwoZ5oVgXVc/RV6G2brREzEPs5i6ECips5QfXSqq3iP7s2MF9xjvO1+
         tUlw==
X-Gm-Message-State: AOJu0YxHqfMi8XblyuVu5wUTMvDHuk9QozmwF6Sj+ra8+BVA8kiuetC5
	vdwCvI3y/MK9gwrpKoDVb2nmUrDnKibFEYNAZr4M/JW9xRjd59JLA022vqrMzsLgroR7EXrs6ZN
	T
X-Google-Smtp-Source: AGHT+IEGzcTC1666ZsXuwJ71tHegPJutJMmIlhzSj4KsqHWNTzkfHcMjRaK7dC8YnkZKXcxKrb3rug==
X-Received: by 2002:a05:6a21:3997:b0:19e:c9ad:6907 with SMTP id ad23-20020a056a21399700b0019ec9ad6907mr1836475pzc.30.1707672342852;
        Sun, 11 Feb 2024 09:25:42 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUl+DQHJM1AsWMbwQPZZ+BLZeF/NaLkdsX41v3QQolhzAPi6w3RIdX1HK6/ELsmtNoq4oJkMwgmIT/ZzZ5itmPxoONE
Received: from hermes.local (204-195-123-141.wavecable.com. [204.195.123.141])
        by smtp.gmail.com with ESMTPSA id hi10-20020a17090b30ca00b00296e04442b8sm5248061pjb.41.2024.02.11.09.25.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Feb 2024 09:25:42 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: netdev@vger.kernel.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
	Dave Taht <dave.taht@gmail.com>
Subject: [PATCH net-next] net: sched: codel replace GPLv2/BSD boilerplate
Date: Sun, 11 Feb 2024 09:24:55 -0800
Message-ID: <20240211172532.6568-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The prologue to codel is using BSD-3 clause and GPL-2 boiler plate
language. Replace it by using SPDX. The automated treewide scan in
commit d2912cb15bdd ("treewide: Replace GPLv2 boilerplate/reference with
SPDX - rule 500") did not pickup dual licensed code.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
Acked-by: Dave Taht <dave.taht@gmail.com>
---
 net/sched/sch_codel.c | 32 +-------------------------------
 1 file changed, 1 insertion(+), 31 deletions(-)

diff --git a/net/sched/sch_codel.c b/net/sched/sch_codel.c
index 61904d3a593b..ecb3f164bb25 100644
--- a/net/sched/sch_codel.c
+++ b/net/sched/sch_codel.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
 /*
  * Codel - The Controlled-Delay Active Queue Management algorithm
  *
@@ -7,37 +8,6 @@
  *  Implemented on linux by :
  *  Copyright (C) 2012 Michael D. Taht <dave.taht@bufferbloat.net>
  *  Copyright (C) 2012,2015 Eric Dumazet <edumazet@google.com>
- *
- * Redistribution and use in source and binary forms, with or without
- * modification, are permitted provided that the following conditions
- * are met:
- * 1. Redistributions of source code must retain the above copyright
- *    notice, this list of conditions, and the following disclaimer,
- *    without modification.
- * 2. Redistributions in binary form must reproduce the above copyright
- *    notice, this list of conditions and the following disclaimer in the
- *    documentation and/or other materials provided with the distribution.
- * 3. The names of the authors may not be used to endorse or promote products
- *    derived from this software without specific prior written permission.
- *
- * Alternatively, provided that this notice is retained in full, this
- * software may be distributed under the terms of the GNU General
- * Public License ("GPL") version 2, in which case the provisions of the
- * GPL apply INSTEAD OF those given above.
- *
- * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
- * "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
- * LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
- * A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
- * OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
- * SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
- * LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
- * DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
- * THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
- * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
- * OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH
- * DAMAGE.
- *
  */
 
 #include <linux/module.h>
-- 
2.43.0


