Return-Path: <netdev+bounces-66422-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 42D4D83EEC3
	for <lists+netdev@lfdr.de>; Sat, 27 Jan 2024 17:45:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 756061C20D37
	for <lists+netdev@lfdr.de>; Sat, 27 Jan 2024 16:45:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 010E12562A;
	Sat, 27 Jan 2024 16:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OwVw/SIs"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 571972C68C
	for <netdev@vger.kernel.org>; Sat, 27 Jan 2024 16:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706373931; cv=none; b=K30BLdENMPwXsvYD6/FLMKE97ta5DnGh8WMYed1LEQAgAfI+TTtMgoqNGLintWqk9gejpK1cAaj81tMDg1SsCukiWAg2c7VIlcp/Gt901n7k16HYAqqmfRcjplcgK0YTqptrTNexZw/fBDyHJJaKYb0v0yO2mhRez7/oAWMrva0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706373931; c=relaxed/simple;
	bh=cfT0XsZ1RKgVSNGVBlfjqBRH8lYWGcNgbF36jrHoTHY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=OfWTsEMTTCduM00rAYS0BWD7mx89RoRv6MoYvM6JKEEHjwXr053n0KD84XWothRTo6BlNRgFNouS5KiYrAL998MHuNKge4V0942Xsv/x2TYtlebsmMoWtYSvFJkNOxX3D/zHEZDhdzl8us5HQsXIjJOqjotwbrUMA64gWIAIKfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OwVw/SIs; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3392b12dd21so1570269f8f.0
        for <netdev@vger.kernel.org>; Sat, 27 Jan 2024 08:45:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706373928; x=1706978728; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=v/W7oUJ2HhNaOAurMi2PWx60uv0Y/uRQwn4EL2qMDdM=;
        b=OwVw/SIsNKhvR6uZSrEOJ6ekpYFAmi7/M5lKPyVSRh53TIN9nN0X5L/Cg6ZBgvaKH4
         PU8mOANUQGhCSPajcllDD2HMPN39s/Nq1RaDP5rl/uiI/wk6GjrVJk9Vf1KlQxNgFDOV
         AtfeWU/NZI1y2EjtGr/Q1pJYypuS+KZaC13NDrz7sKQAxLAYdu2vVlqz6H0BUq4EbM+6
         NQ2wAbS+EVBv0K4pvtNXZinmLMf/wOtbbN9RvfHPq/s/K6pYd7X6Xgw2r+OzQqrMdZO6
         iqbTnMFI2EKRGqFG/Lk4aKjM1ZJAI3fM/cEaK/irMUDIQVaEgR/K90kyXIF4dk/b9uum
         bulw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706373928; x=1706978728;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=v/W7oUJ2HhNaOAurMi2PWx60uv0Y/uRQwn4EL2qMDdM=;
        b=kNZyeXk53L0Wi7MqChFYmAVJ72aMbUaDivH2+Vajtz09fTijSqRr6S/ICX6SKYp4Zu
         16WrLaxz2WwRVy2TEILEmF4D63dls21qgBVgkmhsqF3rk5uaHhm8HIoRCw+Rd2ebMKgt
         kKN9V0aU3oy/W8sAwRfWNSK1nHr58sUNLmJQT7T8Q0HXxVAKDI0poZmUtzIdXWN9oZl6
         JBGUFxmssieewM+ZNcUiiFnX4WYrUoCikDP7kAt01/z1JI4R820Z/dEUAILcYGfzJ9oe
         ov80b9wFYVw/gHMMN8a+h7XIbWtkeHa5a80cubX1p722VU5x2vMVXdfZruQQsWfRq2YG
         gh/Q==
X-Gm-Message-State: AOJu0YyJJ1VSQ5ODp3MFdt4U2VojSX9dFVcyrBq++24FbcACtipA3yWe
	SFzW97obEyqle6oSJ2ScV8/K6zFsXhwBlzqFnQkoC0jAn7HKJRcSsdVwZ27YCOY=
X-Google-Smtp-Source: AGHT+IHE7N7gSLzWCPERE8jy2D0sILXM4jKrm4Ci0pHbQYFp6Utbii+aCg2mkKXpD8TB/wm+igIj7w==
X-Received: by 2002:a5d:59ac:0:b0:337:c4d2:473a with SMTP id p12-20020a5d59ac000000b00337c4d2473amr1327908wrr.69.1706373928072;
        Sat, 27 Jan 2024 08:45:28 -0800 (PST)
Received: from lenovo-lap.localdomain (85-250-47-161.bb.netvision.net.il. [85.250.47.161])
        by smtp.googlemail.com with ESMTPSA id r14-20020a5d498e000000b003392bbeeed3sm3806158wrq.47.2024.01.27.08.45.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Jan 2024 08:45:27 -0800 (PST)
From: Yedaya Katsman <yedaya.ka@gmail.com>
To: netdev@vger.kernel.org
Cc: Taehee Yoo <ap420073@gmail.com>,
	David Ahern <dsahern@gmail.com>,
	Yedaya Katsman <yedaya.ka@gmail.com>
Subject: [PATCH] ip: remove non-existent amt subcommand from usage
Date: Sat, 27 Jan 2024 18:45:08 +0200
Message-Id: <20240127164508.14394-1-yedaya.ka@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 6e15d27aae94 ("ip: add AMT support") added "amt" to the list
of "first level" commands list, which isn't correct, as it isn't present
in the cmds list. remove it from the usage help.

Fixes: 6e15d27aae94 ("ip: add AMT support")
Signed-off-by: Yedaya Katsman <yedaya.ka@gmail.com>
---
 ip/ip.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/ip/ip.c b/ip/ip.c
index 860ff957..39bea69b 100644
--- a/ip/ip.c
+++ b/ip/ip.c
@@ -61,8 +61,8 @@ static void usage(void)
 	fprintf(stderr,
 		"Usage: ip [ OPTIONS ] OBJECT { COMMAND | help }\n"
 		"       ip [ -force ] -batch filename\n"
-		"where  OBJECT := { address | addrlabel | amt | fou | help | ila | ioam | l2tp |\n"
-		"                   link | macsec | maddress | monitor | mptcp | mroute | mrule |\n"
+		"where  OBJECT := { address | addrlabel | fou | help | ila | ioam | l2tp | link |\n"
+		"                   macsec | maddress | monitor | mptcp | mroute | mrule |\n"
 		"                   neighbor | neighbour | netconf | netns | nexthop | ntable |\n"
 		"                   ntbl | route | rule | sr | tap | tcpmetrics |\n"
 		"                   token | tunnel | tuntap | vrf | xfrm }\n"
-- 
2.34.1


