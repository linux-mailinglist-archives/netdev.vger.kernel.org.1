Return-Path: <netdev+bounces-146351-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF8DB9D300D
	for <lists+netdev@lfdr.de>; Tue, 19 Nov 2024 22:32:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6DD8C283A6B
	for <lists+netdev@lfdr.de>; Tue, 19 Nov 2024 21:32:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0CF81D172E;
	Tue, 19 Nov 2024 21:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OKjvQt9n"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 045FA199FDD;
	Tue, 19 Nov 2024 21:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732051927; cv=none; b=VZvkAam9Faa+Gv1pO+F0N/dzAmHwegn9TbhUkODbMtfC052FEGEJHnNbaaHvktykx3lN4hZwi32MzisaGQaV7DX/jliu5bbKKc8tIij/QTV0cBlbpENb9m2nBRAYKl77bLrq7czBfewlYfORAz9pYFCocvY2UR0IdIALDgS6FsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732051927; c=relaxed/simple;
	bh=XUiZ0LF9tg0EwVsjZyXw9hay09E3SlVmonzhEXGWNQI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SNo8Rz3MH72B2Y1R45UI/bj8Xyb/wzdre2WhiVqjbwKmWoyK+C78moJWxhg+YBuBWtL/n1KfQj+6+mVRsieE0pqmjQWO2fB3jlGkjv0RHatpA5PT5SlpfbCQsRGXFMvnKhYjGbxHERvdBzK3ldLXfDVqH/tqMZCpzXdnSIC/sWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OKjvQt9n; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-7edb6879196so1044899a12.3;
        Tue, 19 Nov 2024 13:32:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732051925; x=1732656725; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=O3o7KNI2hGFv6gMwjG91XpYbsNxBQO475xkwrT8XXYM=;
        b=OKjvQt9nV6BcAOU+DtxBjR5ytUPYZBxl3vzONlSjBm7utNrmPIgDWEovsg65/0YlJU
         WUcmvKOFHx33LQCr+MnDzkLYcNOnpWGKuJrV5jD8/eoeNPT7TISsVSJMGYMi/d9lYjrY
         Kd/zVg7N4Uw5S+0MaV8+qy8dwCcX5p3nCTZPxMatqV2UaK0YuLgERxafBRiJv6Jn5q+/
         EROXwy/yopbrj3PWuD7yly3Bo+om1K6wLiiPvBd/79cRq9sGmFfGNDCk9unO+/hjkYZ+
         t/LEn1G3SRGK2WioYTF1naKYaR4ToUi52W8m6NZUzqgQ4YmR4AVorF2AOoJLbgwDjPN0
         t8pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732051925; x=1732656725;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O3o7KNI2hGFv6gMwjG91XpYbsNxBQO475xkwrT8XXYM=;
        b=vecTE7Ed1qZz/NIozcKfogvpwvJh6ZS0LjXtwLfKrJOjLCFlnkGriBfFPhrtXj5dhx
         Ch8JfBFcdDtCzs+qRHACVH+LkAXu+woUXb1NrvDdbncMuSU8aolQDdzpNkH0K4neY9+W
         LjYySJ3kuGhD7xVcCYDDnzjcOV8WxpKVZsru9xmzR5kKn4r8EWRhSEdQjVQYtT/4FV6m
         go+J+nnrlq/t695XBLM2jaOUGNbwYVKXZSCyFaMvoAjQhmyag6MetVgUcWOq2SFtQsTf
         zVCoa9gqXcjp41FyY+24YHMNE97Od+yGdKxmwGWZTgcsFZol4UJDdygo4XLUlTLN+ykx
         G9Yg==
X-Forwarded-Encrypted: i=1; AJvYcCWePb0SywtJaeI/ngpGze8Ke4XqohbE+UYxXs/3KBJZMU7ceuUM0en56w8ZAVHs+KSGWPCSPm9U@vger.kernel.org, AJvYcCXrfUuHOV75zTLvjPNpSAgOLX9Gdqh+Um2G7Lr4+EVyM+z35x7riFkIb/7mcp2JNjJR+XQylNkXC1OViLA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyteV/kbB3Wj+K22cUD05Mp01IkmXAtB4OWCTrOvxmu5jrgE1SI
	PmRoqywN2ICjMVMKBx3yNUjh7skmDAFuXqtDLgWYIbzq/UR1lUQ3
X-Google-Smtp-Source: AGHT+IGjXTrCZrjFrmwL8uPXmyNLdwiSuGIuCddplYQq+V8h055S9uTuHLjnVk9EnmuINXG/Fgexng==
X-Received: by 2002:a05:6a21:8ccc:b0:1d8:a3ab:720b with SMTP id adf61e73a8af0-1ddade0ad86mr926004637.9.1732051925108;
        Tue, 19 Nov 2024 13:32:05 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7f8c1c1752csm8275765a12.4.2024.11.19.13.32.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Nov 2024 13:32:04 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
From: Guenter Roeck <linux@roeck-us.net>
To: Lars Povlsen <lars.povlsen@microchip.com>
Cc: Steen Hegelund <Steen.Hegelund@microchip.com>,
	Daniel Machon <daniel.machon@microchip.com>,
	UNGLinuxDriver@microchip.com,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-arm-kernel@lists.infradead.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Guenter Roeck <linux@roeck-us.net>,
	Steen Hegelund <steen.hegelund@microchip.com>
Subject: [RESEND PATCH] net: microchip: vcap: Add typegroup table terminators in kunit tests
Date: Tue, 19 Nov 2024 13:32:02 -0800
Message-ID: <20241119213202.2884639-1-linux@roeck-us.net>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

VCAP API unit tests fail randomly with errors such as

   # vcap_api_iterator_init_test: EXPECTATION FAILED at drivers/net/ethernet/microchip/vcap/vcap_api_kunit.c:387
   Expected 134 + 7 == iter.offset, but
       134 + 7 == 141 (0x8d)
       iter.offset == 17214 (0x433e)
   # vcap_api_iterator_init_test: EXPECTATION FAILED at drivers/net/ethernet/microchip/vcap/vcap_api_kunit.c:388
   Expected 5 == iter.reg_idx, but
       iter.reg_idx == 702 (0x2be)
   # vcap_api_iterator_init_test: EXPECTATION FAILED at drivers/net/ethernet/microchip/vcap/vcap_api_kunit.c:389
   Expected 11 == iter.reg_bitpos, but
       iter.reg_bitpos == 15 (0xf)
   # vcap_api_iterator_init_test: pass:0 fail:1 skip:0 total:1

Comments in the code state that "A typegroup table ends with an all-zero
terminator". Add the missing terminators.

Some of the typegroups did have a terminator of ".offset = 0, .width = 0,
.value = 0,". Replace those terminators with "{ }" (no trailing ',') for
consistency and to excplicitly state "this is a terminator".

Fixes: 67d637516fa9 ("net: microchip: sparx5: Adding KUNIT test for the VCAP API")
Cc: Steen Hegelund <steen.hegelund@microchip.com>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
resend: forgot to copy netdev@.

 .../ethernet/microchip/vcap/vcap_api_kunit.c    | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/microchip/vcap/vcap_api_kunit.c b/drivers/net/ethernet/microchip/vcap/vcap_api_kunit.c
index 7251121ab196..16eb3de60eb6 100644
--- a/drivers/net/ethernet/microchip/vcap/vcap_api_kunit.c
+++ b/drivers/net/ethernet/microchip/vcap/vcap_api_kunit.c
@@ -366,12 +366,13 @@ static void vcap_api_iterator_init_test(struct kunit *test)
 	struct vcap_typegroup typegroups[] = {
 		{ .offset = 0, .width = 2, .value = 2, },
 		{ .offset = 156, .width = 1, .value = 0, },
-		{ .offset = 0, .width = 0, .value = 0, },
+		{ }
 	};
 	struct vcap_typegroup typegroups2[] = {
 		{ .offset = 0, .width = 3, .value = 4, },
 		{ .offset = 49, .width = 2, .value = 0, },
 		{ .offset = 98, .width = 2, .value = 0, },
+		{ }
 	};
 
 	vcap_iter_init(&iter, 52, typegroups, 86);
@@ -399,6 +400,7 @@ static void vcap_api_iterator_next_test(struct kunit *test)
 		{ .offset = 147, .width = 3, .value = 0, },
 		{ .offset = 196, .width = 2, .value = 0, },
 		{ .offset = 245, .width = 1, .value = 0, },
+		{ }
 	};
 	int idx;
 
@@ -433,7 +435,7 @@ static void vcap_api_encode_typegroups_test(struct kunit *test)
 		{ .offset = 147, .width = 3, .value = 5, },
 		{ .offset = 196, .width = 2, .value = 2, },
 		{ .offset = 245, .width = 5, .value = 27, },
-		{ .offset = 0, .width = 0, .value = 0, },
+		{ }
 	};
 
 	vcap_encode_typegroups(stream, 49, typegroups, false);
@@ -463,6 +465,7 @@ static void vcap_api_encode_bit_test(struct kunit *test)
 		{ .offset = 147, .width = 3, .value = 5, },
 		{ .offset = 196, .width = 2, .value = 2, },
 		{ .offset = 245, .width = 1, .value = 0, },
+		{ }
 	};
 
 	vcap_iter_init(&iter, 49, typegroups, 44);
@@ -489,7 +492,7 @@ static void vcap_api_encode_field_test(struct kunit *test)
 		{ .offset = 147, .width = 3, .value = 5, },
 		{ .offset = 196, .width = 2, .value = 2, },
 		{ .offset = 245, .width = 5, .value = 27, },
-		{ .offset = 0, .width = 0, .value = 0, },
+		{ }
 	};
 	struct vcap_field rf = {
 		.type = VCAP_FIELD_U32,
@@ -538,7 +541,7 @@ static void vcap_api_encode_short_field_test(struct kunit *test)
 		{ .offset = 0, .width = 3, .value = 7, },
 		{ .offset = 21, .width = 2, .value = 3, },
 		{ .offset = 42, .width = 1, .value = 1, },
-		{ .offset = 0, .width = 0, .value = 0, },
+		{ }
 	};
 	struct vcap_field rf = {
 		.type = VCAP_FIELD_U32,
@@ -608,7 +611,7 @@ static void vcap_api_encode_keyfield_test(struct kunit *test)
 	struct vcap_typegroup tgt[] = {
 		{ .offset = 0, .width = 2, .value = 2, },
 		{ .offset = 156, .width = 1, .value = 1, },
-		{ .offset = 0, .width = 0, .value = 0, },
+		{ }
 	};
 
 	vcap_test_api_init(&admin);
@@ -671,7 +674,7 @@ static void vcap_api_encode_max_keyfield_test(struct kunit *test)
 	struct vcap_typegroup tgt[] = {
 		{ .offset = 0, .width = 2, .value = 2, },
 		{ .offset = 156, .width = 1, .value = 1, },
-		{ .offset = 0, .width = 0, .value = 0, },
+		{ }
 	};
 	u32 keyres[] = {
 		0x928e8a84,
@@ -732,7 +735,7 @@ static void vcap_api_encode_actionfield_test(struct kunit *test)
 		{ .offset = 0, .width = 2, .value = 2, },
 		{ .offset = 21, .width = 1, .value = 1, },
 		{ .offset = 42, .width = 1, .value = 0, },
-		{ .offset = 0, .width = 0, .value = 0, },
+		{ }
 	};
 
 	vcap_encode_actionfield(&rule, &caf, &rf, tgt);
-- 
2.45.2


