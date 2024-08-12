Return-Path: <netdev+bounces-117574-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A85E494E5DB
	for <lists+netdev@lfdr.de>; Mon, 12 Aug 2024 06:45:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DAC9D1C212E7
	for <lists+netdev@lfdr.de>; Mon, 12 Aug 2024 04:45:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08B3B14A0A0;
	Mon, 12 Aug 2024 04:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M7RrOVPY"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94DA613D538
	for <netdev@vger.kernel.org>; Mon, 12 Aug 2024 04:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723437897; cv=none; b=FtCyx+cQqHs4PCQ6A9sNfcDKgxGJjW/IFHgT9DOykJDBQEnhedMJOIoRHCdQ/pW+kXaI6C33kic7XXgpBJADgjX7a6lX3bN2x2MZztmi2juA63QbB+tIjNG4nKVcrPR5KFqDwPItt/fFqI8V0tN8v9s8u/nD86/DFBvTZdg7p/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723437897; c=relaxed/simple;
	bh=JbMq1rZaxV68HLLM0tE/W7piEBitSV5zC7Dqhiy/BwQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=j/qfpD96dqvUgtzCyn4kYKo9gNUHNGZXi51wixzOu7nZkiB4fIv5gAgcE+SKHK26nKM9YPh11uSUpwaBAdA4DFJdzj6Hl/y28Hx68UPTmosHwX4UndhdVPhs78itsPbKaffGTquvbn22+2NyyWuyaRViMlYRN4zeNcyUP0u3I6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M7RrOVPY; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-6e7b121be30so2417085a12.1
        for <netdev@vger.kernel.org>; Sun, 11 Aug 2024 21:44:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723437896; x=1724042696; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=aEFhPMn3vbOQ8RJYO2JwTuZ4PB2Z0I27kZFssi0BDGk=;
        b=M7RrOVPYI/4x/fBkpcDd86vm9Kj3ElWXQU7HIfHbbbP0KCae+HBdTq+RH7drNwDTXm
         VvfCiFmBRuoUAN58drJFZdZjq52m0N+0zEFQ05Rx4YGkpONGY/47JlGsZ0wKlgyfSpKZ
         nOof+ToLVmLHsCvrKkWZxiFxDKvTgHQYIYcDyqS/ZjfpQjgAQrFF45yGPNcta3GUplA1
         bH54oIi5AzwO+zxHtPhVtuOy+ZxGCtdmlAdwp54Fn6Hd1Hs/38KAhFu8nSxruGgnov55
         +rPoBv1Pi42rc9mNKJrzqvT71K2LOnH3Np6tr3dyVJWobm0qdhpcdSvDQ2HoUF9IsWE1
         xEow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723437896; x=1724042696;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aEFhPMn3vbOQ8RJYO2JwTuZ4PB2Z0I27kZFssi0BDGk=;
        b=RirC71XZZnV/Em0vEPtZK4gd4VIxcHxkRwZIYtNYpacCIxzTbD8pcRdZhbweePqhjg
         1Yk9wBOGvtqI1X4r4byqYtGGItjKvMARCjPooc+5q2ok/0MWHpPg5KQ4Y0bkLqtEc17Z
         Vz/mUYD5UeeQ8w/oqi+JVvOOlE8dcXvSyVjguuFYC+LP0cPE8G+T9PwYbwAy3VM1Q9vh
         wtNZr2iit7zgvVSduVnk6rsn7PMpv4PyxvBO2EYtXgdVRMi+X/nlZqIBqKTIQO2y6KO3
         vVUXJmjuOyAni2mZM1jpAP3aodeMwKWix4nxmrQpl6ZVjERsXfmHOf8ZLL6vWAF+vQaH
         D06Q==
X-Gm-Message-State: AOJu0YxC36z3uL+C0yEQ2R4cu4HztF3X2iHxp5Avu7bYCW4wU+KxNCNS
	YhJ5BIJCZoZ5lIOFP1THw7MUqZWB5Dj/7m0joDUIULiLL//dw/0ryaWbhg==
X-Google-Smtp-Source: AGHT+IF/G0WDfsnZ3ZEMVBgbdhJ/mJlS+w2d52EMUL5a5q3Oq8qIktvn2HCTUwjRynuVjGabi6f/jQ==
X-Received: by 2002:a05:6a20:9e4a:b0:1c4:a1f4:3490 with SMTP id adf61e73a8af0-1c8a00af35emr7239233637.39.1723437895749;
        Sun, 11 Aug 2024 21:44:55 -0700 (PDT)
Received: from laptop.. ([2405:4802:1f31:4f80:d239:57ff:fee4:71e5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-200bba3ffd2sm29086555ad.262.2024.08.11.21.44.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Aug 2024 21:44:55 -0700 (PDT)
From: =?UTF-8?q?L=C6=B0=C6=A1ng=20Vi=E1=BB=87t=20Ho=C3=A0ng?= <tcm4095@gmail.com>
To: stephen@networkplumber.org
Cc: netdev@vger.kernel.org,
	=?UTF-8?q?L=C6=B0=C6=A1ng=20Vi=E1=BB=87t=20Ho=C3=A0ng?= <tcm4095@gmail.com>
Subject: [PATCH iproute2 v2 1/2] tc-cake: document 'ingress'
Date: Mon, 12 Aug 2024 11:41:37 +0700
Message-ID: <20240812044234.3570-1-tcm4095@gmail.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Linux kernel commit 7298de9cd7255a783ba ("sch_cake: Add ingress mode") added
an ingress mode for CAKE, which can be enabled with the 'ingress' parameter.
Document the changes in CAKE's behavior when ingress mode is enabled.

Signed-off-by: Lương Việt Hoàng <tcm4095@gmail.com>
---
 man/man8/tc-cake.8 | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/man/man8/tc-cake.8 b/man/man8/tc-cake.8
index ced9ac78..6d77d7d2 100644
--- a/man/man8/tc-cake.8
+++ b/man/man8/tc-cake.8
@@ -541,6 +541,21 @@ This can be used to set policies in a firewall script that will override CAKE's
 built-in tin selection.
 
 .SH OTHER PARAMETERS
+.B ingress
+.br
+	Indicates that CAKE is running in ingress mode (i.e. running on the downlink
+of a connection). This changes the shaper to also count dropped packets as data
+transferred, as these will have already traversed the link before CAKE can
+choose what to do with them.
+
+	In addition, the AQM will be tuned to always keep at least two packets
+queued per flow. The reason for this is that retransmits are more expensive in
+ingress mode, since dropped packets have to traverse the link again; thus,
+keeping a minimum number of packets queued will improve throughput in cases
+where the number of active flows are so large that they saturate the link even
+at their minimum window size.
+
+.PP
 .B memlimit
 LIMIT
 .br
-- 
2.45.2


