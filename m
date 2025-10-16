Return-Path: <netdev+bounces-230231-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F1AABE5A0B
	for <lists+netdev@lfdr.de>; Fri, 17 Oct 2025 00:00:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E0C35E5BB6
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 22:00:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 227602E5B0E;
	Thu, 16 Oct 2025 22:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="HhvsVJh0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02D552DFA4A
	for <netdev@vger.kernel.org>; Thu, 16 Oct 2025 21:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760652002; cv=none; b=Sjn/J/f34q8mG1M7pR0nOj6hW86yCnrK9JTo4wezDzZq0lFzWTojL9pg6OwMPqBJAghMieJFAEEjUmT5dkHK3t+MPhjmGDEXGD5CJimKdZm0OM1bfndXtGuL8e+YDT9AJLi3GW1oBAzOn6B5044eZMOR6px1cBdvau8Z2FgE2Rk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760652002; c=relaxed/simple;
	bh=ArB8qGXWTZl9wxaYCMH3ghlRSW//xRAgDWVnxNKH7b8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PDDiGVzgfrqgSBZRObJf6LG5yHgWvGphbbwVKKOUfyWYqhbhBPvstZPardbs/9DRQkrmTMC9gHDDuW119HHse0RVNBzQ8cU6Pe3Kzd+k7J1axyxlMi/xXQDUtuKKem3rn5+i2j5U2DoAONHgbFTviMQjyYXRZe0beCNp1UQxOl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=HhvsVJh0; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-b6271ea3a6fso803739a12.0
        for <netdev@vger.kernel.org>; Thu, 16 Oct 2025 14:59:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1760651999; x=1761256799; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=w+I8lMqiikOuFJTXBqPQIaCOyeVaz9bgNEV0DZ5EWos=;
        b=HhvsVJh0XmLcNeOIwXoqso7u/vRAShvNEJ86vCXu91R+/Jzhc7i0FknDMgAlwm9Stv
         nUjm6YSGey4/txTARvwwzEpINMUFwxJpRLbe8LoZ5vg3D1qyNBjf7vFqOY6bbN+jgJ4O
         bVxgI/zF+63L2+WnJz+kympr8pntSn8Wj7n9kPoZ3VBqE+8VD7rUiqvN1VcEOHJv2PD2
         mmSIQoGlilIv1QXcStU6YG5rF696EGYTaiD1MlA81AEXVqC6/7x6UtJAgVaMtNtCWkhQ
         d7LPFwaxXxnHHh523gcke3rw8OIKzxpvssD8Lc18x2zeVy41Rk8l+Qv3/5MTz/TXGg3X
         iBRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760651999; x=1761256799;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=w+I8lMqiikOuFJTXBqPQIaCOyeVaz9bgNEV0DZ5EWos=;
        b=lEH6OGeXwqn31azLraGs32CRWzTeEH//SDutiGJ5gzD/uiVyBboNk9i9dfKfiBA6sr
         cK/HemEhHPsbGf6MC0exbg20nfMAAmJkghhOysx/GW9JF2PAkSLFkEp1TVtgGUFaHjEg
         OaN430CIq69X5PdUqMHfQl/E7nFxma0bkTJqL8wj7OIrH3cmi1745ZDqeyMD8RVcstD7
         GahV32vx3BB24ZHdohXMboNMSwmXIr1ytiayUxvpUrhOowipaVC4UdSVAYIS732rJyJv
         //vNsx2Igbf5zHAtxx8peuGuUqgm1oPRbD6FtEOCva88NMDS4f2SBYJl4gMeF75pzMOc
         HaLw==
X-Gm-Message-State: AOJu0YzT6kC8YZXvzyw2gaS0bG0YdNSMBShl/yVRVbrNlM7UarY1UZ40
	fjpKSb1GBKtBLDMIOnATHmIYn3eWiFe4+TK5bdsU9ucM8J90bILDank6QmPbuksVzR4oubSjM4h
	hUlMIJ2o=
X-Gm-Gg: ASbGnctWcA1UEBzcSr46egIQSfWOYcDx9jH2nejDqSHgO5dSf6GYuCLV5DDqWIOZWAX
	RKN7j/84slbXl5u0FHfWvM/XkpVJEqQNU+AzGqd9F3Po1XSnAf1fSgEz4aC0vivO1rOg4V26U5B
	qYguSsSDjqTsmxx3O5DkqneMO67NvqAQk9NGpoBMOcqLLObJ5yDjkDOBcLVPzRvZlupfEKcvabP
	PnxyJjYNT9WarQRmMdtit21YAzs+neadf6y0pbDv/Z4IWI5CvdFGFBUKA1o2Dg9+ZvlGgPpYNqz
	RMrN/RPrX0Pye5o/FxSYChjPivUOMwvPBPryecXQ2G1wjIo4qFVccGuq8cPTYB9uX+UXZh6TPtI
	Lo5uVQHdNbWveM2XgEn8t2Yeh2VeJoWUlymCjv86B0RV8QYaNV/yh60cZFR9Jab1LofmxBfxcVQ
	BH/3GzGynBRcRrVtfs//9G11u11nNI41H+PO23mHz7uXabqGsBzw==
X-Google-Smtp-Source: AGHT+IGc759dyiu3IFhtyS3V6Q6yjhS0byOIf57BOpGMtJHqWx3Kp+XGoDGXXzmUsP+zhoHew0YvGg==
X-Received: by 2002:a17:902:db0b:b0:24c:cc32:788b with SMTP id d9443c01a7336-290c9c8a77dmr16153205ad.3.1760651999132;
        Thu, 16 Oct 2025 14:59:59 -0700 (PDT)
Received: from hermes.lan (204-195-96-226.wavecable.com. [204.195.96.226])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33bb66bab42sm3107875a91.17.2025.10.16.14.59.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Oct 2025 14:59:58 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: netdev@vger.kernel.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH iproute2] netshaper: update include files
Date: Thu, 16 Oct 2025 14:59:46 -0700
Message-ID: <20251016215955.14261-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use iwyu to make sure all includes are listed.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 netshaper/netshaper.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/netshaper/netshaper.c b/netshaper/netshaper.c
index 67df2091..edd964c1 100644
--- a/netshaper/netshaper.c
+++ b/netshaper/netshaper.c
@@ -6,12 +6,19 @@
  */
 #include <stdio.h>
 #include <string.h>
+#include <stdlib.h>
+#include <stdbool.h>
+
 #include <linux/genetlink.h>
 #include <linux/netlink.h>
 #include <linux/rtnetlink.h>
 #include <linux/net_shaper.h>
+
 #include "version.h"
 #include "utils.h"
+#include "ll_map.h"
+#include "color.h"
+#include "json_print.h"
 #include "libgenl.h"
 #include "libnetlink.h"
 
-- 
2.47.3


