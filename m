Return-Path: <netdev+bounces-206384-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5EAFB02D08
	for <lists+netdev@lfdr.de>; Sat, 12 Jul 2025 23:04:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EFB7117FC16
	for <lists+netdev@lfdr.de>; Sat, 12 Jul 2025 21:04:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6574F220F23;
	Sat, 12 Jul 2025 21:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bQyTZ+pD"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D8B81F560B
	for <netdev@vger.kernel.org>; Sat, 12 Jul 2025 21:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752354282; cv=none; b=GCa+/lzvlKzbfmjSPC5jnc2I9OabnqBup4BKBXjInb44WLN06byZY9Z31ytD9mKGtgadZsNEdDD3HakzUG9EO/EAwF9E5CnqKH5G384SqRDH3gfX6fo+ZUMSv8Tn3j7ysGVAA15ZRJTcFyPN5/LPaDf0jUBcrBMTHDS9abI9cWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752354282; c=relaxed/simple;
	bh=qNyJkm7PeaSYbzvL4wRwzO+7J0l1FEJhgQ8HD0Y7GWs=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ELDxSLAtDC7lSj5V81SWD9NrJefrefU9TikYrMWk7jNFL4Tow+lL3UTRroTWOGVJM86Zgka67af4dXuY9pzHjQNaqRdtfRJCylJmGdjld92yKKCa5/08/kHLCRhuS3vZN1NQ0L41NGqrfy6GsLWgPB2TbisIdRiBzfkwAsGhCgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bQyTZ+pD; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-b31d489a76dso2835577a12.1
        for <netdev@vger.kernel.org>; Sat, 12 Jul 2025 14:04:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752354277; x=1752959077; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SfbqWqhAF1GPPRiAu1364uXMrz946WcMqg/i/HnGuaI=;
        b=bQyTZ+pDV0zmUyznpu1un2v5aY7NmDEH+KHklEPCpVz3ZWAj03zxUM3+qBwJDW4OYv
         jX9XYMYkxGlyLPOqZevjEalwByrJASfEXnCqyhUzJZVFuEq47b2HATDIiPF3ZQmRfnX1
         XRDwdmt0IKIhL4u2qVsYnPqsUaL+EoSnTX1kr8ZqLyiJOOF/5DDI3Lsy0Y1IkKZSa9m+
         wkiUnI91CZ+vyie61ZnhtKMvmO8W7bdLeFhJc4tqf1zvP6rgISHnANf6pMqPV21iS20F
         KFMKhTxDLJLuIA660ZiCU3zUyNOpMGacZ3uN4NI8gn5NJYy7gu/RH/b2Sgx9LSlayD+U
         AMPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752354277; x=1752959077;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SfbqWqhAF1GPPRiAu1364uXMrz946WcMqg/i/HnGuaI=;
        b=lCkJJQSAueAU3370YzveTtF2vtex/b/AEg0mAd2Al/LFpeBLUdVna7ZG5Q/LkjDUlV
         mYwrUgHTF/4jxoqnnt5PUnAVd5NTuQ8+pvJMBJ0qSY8JWHlUByS/c/vdQbgBo4zGVHE/
         2bzMAKjavTueD0jAO1bqU6OTBLn0aGFKpNHry/bb21K16UTXaYAkupzIkmxtLFH6Z09x
         lzz7U/yDG20LyaCwtU9CPtsChm5kS0JcniW9i1OTZbJjzPocLUGoIU+9wIJPSKT9hX6T
         ho+qWXGkkxPEfUMOofFUVgQJHT8jSgztIY8gpzcglvkriYzaTRrenG3ZiM6FSgO0A7Hv
         Sh6w==
X-Gm-Message-State: AOJu0Yw3hIPPDktZ06z2mBLgfp/ZVNYV+nGnzOq46eyfEh4S+G4eRpQ2
	HlG2SYr6oySC3OBYR7orZptZZqA0e0vIHL++A3pIZQPTYAbGRbaaiA8q0Ak4HlKa
X-Gm-Gg: ASbGncsl1H2T1mUtkrQQdMBZ5374PNQe1XFLeJjayULaG2nn5NJLbE5jKt+f8EVVehI
	BQ0ipgTGU8bUjhqxZy/NOf9N1HwBYAWS/irP3kDQZinotRMI/4JOcgE5uKYWZMghOh3HZ4Y8end
	CEya7MA0eHXJN2ZMbhAWxh4Q2EonRRRF4jGAUPqSTh3LvLCOElNmlupcuCLzQLib8WaMFMxVPlb
	h/Bzh7xBvXQwel/lWwynBj78K+N6BU1oP7lfvAUnfPjbWJv1kLaQriTK6sw+vcIlSeprFclXgsG
	4WtHFpC/jtBm3eMaCrjjY0oHB00u6nCX8vYWRZJ2k/p4VeZKFMAfG320SLYbawANf/oVt8/4BQp
	aHmU=
X-Google-Smtp-Source: AGHT+IGdq9rd+Zh8k//xDxUuPL3qzdqjBo6ZEFvBsdEzM5Kf3lT/Pfvhhm7k2mmQenmCQh/Wga7iCQ==
X-Received: by 2002:a17:902:e889:b0:235:f143:9b07 with SMTP id d9443c01a7336-23dee1ae98cmr115977965ad.5.1752354277449;
        Sat, 12 Jul 2025 14:04:37 -0700 (PDT)
Received: from archlinux.lan ([2601:644:8200:dab8::1f6])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23de435cb63sm66828735ad.235.2025.07.12.14.04.36
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Jul 2025 14:04:37 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: netdev@vger.kernel.org
Subject: [PATCHv4 wireless-next 1/7] wifi: rt2x00: add COMPILE_TEST
Date: Sat, 12 Jul 2025 14:04:29 -0700
Message-ID: <20250712210435.429264-2-rosenp@gmail.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250712210435.429264-1-rosenp@gmail.com>
References: <20250712210435.429264-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

While this driver is for a specific arch, there is nothing preventing it
from being compiled on other platforms.

Allows the various bots to test compilation and complain if a patch is
bad.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
Acked-by: Stanislaw Gruszka <stf_xl@wp.pl>
---
 drivers/net/wireless/ralink/rt2x00/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ralink/rt2x00/Kconfig b/drivers/net/wireless/ralink/rt2x00/Kconfig
index d1fd66d44a7e..3a32ceead54f 100644
--- a/drivers/net/wireless/ralink/rt2x00/Kconfig
+++ b/drivers/net/wireless/ralink/rt2x00/Kconfig
@@ -202,7 +202,7 @@ endif
 
 config RT2800SOC
 	tristate "Ralink WiSoC support"
-	depends on SOC_RT288X || SOC_RT305X || SOC_MT7620
+	depends on SOC_RT288X || SOC_RT305X || SOC_MT7620 || COMPILE_TEST
 	select RT2X00_LIB_SOC
 	select RT2X00_LIB_MMIO
 	select RT2X00_LIB_CRYPTO
-- 
2.50.0


