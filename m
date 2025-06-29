Return-Path: <netdev+bounces-202205-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52652AECAD7
	for <lists+netdev@lfdr.de>; Sun, 29 Jun 2025 02:36:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C8AD917909C
	for <lists+netdev@lfdr.de>; Sun, 29 Jun 2025 00:36:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D39324A0C;
	Sun, 29 Jun 2025 00:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RyKHFSqU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DECD36D
	for <netdev@vger.kernel.org>; Sun, 29 Jun 2025 00:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751157383; cv=none; b=KNluELC6stspMZVDXriQU8v9rMo05urSV+yiUfPkiurF8VNZ35x+C+qSxI56Z3zrNVbpxOBZ7kUq8okO4boIzyAqM4nbyEffh/d36/bmkVib9rUJ6DN2LhAiZ/Y+fTbxv3h+1C0thtFod8Kbh3LuurI5KH1UVW0pDdQskU75tyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751157383; c=relaxed/simple;
	bh=n7iwqVWPX+4fE4c5S/iBZ9KthsxH6wPzUFDL0kSCQhs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=S/iCjafWY7yh2VE3oJQJ/OeGdmWlfOgLUpmOxfGnHvVUfX4mW70qarOErUl+6qkPp2irFvziqS39XlrVUFdue1Kyz7O5Ryl0wpGm8E+w5tZqP1BYIiztVkENiqBn7DBti+1asBBZzHJ2xgTspElWnIIkrsXvb/IOPRoG/C+5zRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RyKHFSqU; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-b2c49373c15so2989278a12.3
        for <netdev@vger.kernel.org>; Sat, 28 Jun 2025 17:36:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751157381; x=1751762181; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HpE5FVFi3H3iqdj3+ViRPektuKkTN1wWnQ4VU6+SmHI=;
        b=RyKHFSqUxM0Fn2AHWr6IRIag+3i997x2hW79uMzqX2nd4Ilil5fyEDrzuooNfPHIbo
         vhzJvO7gAEZXs4v8uaLfXdrZPAIwmqN8GIo8LN2ytFIdc2Ao0+imEnIU56wI6KLnpaU3
         CtjZwyqBkzq/TPwygGnqrDVVIeNZYAvRwWr8ko0FJJ6r15xaPCp8eCxN/P1EdYDeLK6j
         SYNvm7K9ea3J0iX7Bt83UaG4FgwakazXz4R3QlSS9uMNMWVfVYmTWBLDdmtDEoHt5ino
         pD7SE/73WgFMxAN5GqHwcupq8JAsfI/CrZX+sJTJ8k+feGifSYt7UhXO8NZFdYwkzMc8
         xuTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751157381; x=1751762181;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HpE5FVFi3H3iqdj3+ViRPektuKkTN1wWnQ4VU6+SmHI=;
        b=vg76fM5z7qMyIzmeKj96AabhlOliTVaoAi3TYalDHUfnggXV+7opbGJ+eHmjHDxQor
         G3uSqY702ngAGDVlPHwl91twMik1hx0B50zx0PyBkwBJh/dsBzmdDf5U9h7dPCkVhM2B
         x4QoDl16zVo9XKsWUPKxbamPpRrfVdHg5vyrU6lQ2i18rrt6Dqgd/0xiGjsjtDkSsOBw
         /FadQqUXtyB7DiP/eHZnx/CUyWBgNw9UrxT1uafNl+8VzfWFTEu0yVT9eVcPo+N79LYT
         wSN6fuGt6EJn4JW0tz7NtKZvXIS3m022kddka/h9n3pt9g+2xr3MTXKsaPyptbLSH7Ej
         k2dA==
X-Gm-Message-State: AOJu0YysbEj6B6gs9MJ3hSVp2WmxMMkt0NLIA0vYEHBabLskN1TvvXDM
	jrvmqNKcmVaJAUcZGZtQRntahBkSq3P63zkEfc5esfZtCubOnVPoi0OzSJc0rd7K
X-Gm-Gg: ASbGncs7gEg17nUnKmXIuPo6Z3dCA7TGgwP/Cv3FDyIxL9+Rocgg+ofMnZcGcI/MO8h
	ADEj5FS8nCJqFbNaVbqB7lSszopnxzC8A14G4PxLf2UYOzJ1P6pJLcY/YY2RRCvlJRpCVIT6wLZ
	M0ogkKRme/FVOk5zTFAkuqb1TI8SZmMGkvrvb03nyVATL7MCGC2BgQfMKrVKGWp2Zklb+iqiNDh
	82DMjtyxMWYn+HRkAcsbgmgKnGA6+tlG49dVGFQSmWzVV0ARgV8DFMM2QsLe9hFeW18/vYwkfSc
	ozVq4hwLWwNo3v9tcTtcf160kvYdMHZ1rl6ZlzFoHzSJmn9XorTheUZxrD0oJ4IE94mdYT5/Rfe
	RQEi0q14j6heW31rWPyPL3A==
X-Google-Smtp-Source: AGHT+IGHa0VT0HF3HnxQLdQ5dknkDyTNDysVyP9UIQgqOiubkPeuGCUIOQt6OTrbfmzhWbhhweK69A==
X-Received: by 2002:a05:6a21:7a8b:b0:1f5:8622:5ecb with SMTP id adf61e73a8af0-220a1809cbemr12767868637.34.1751157381469;
        Sat, 28 Jun 2025 17:36:21 -0700 (PDT)
Received: from KERNELXING-MC1.tencent.com ([111.201.26.0])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74af5573e49sm5545023b3a.77.2025.06.28.17.36.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Jun 2025 17:36:21 -0700 (PDT)
From: Jason Xing <kerneljasonxing@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	michael.chan@broadcom.com,
	pavan.chebbi@broadcom.com
Cc: netdev@vger.kernel.org,
	Jason Xing <kernelxing@tencent.com>,
	kernel test robot <lkp@intel.com>
Subject: [PATCH net] bnxt_en: eliminate the compile warning in bnxt_request_irq due to CONFIG_RFS_ACCEL
Date: Sun, 29 Jun 2025 08:36:16 +0800
Message-Id: <20250629003616.23688-1-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Xing <kernelxing@tencent.com>

I received a kernel-test-bot report[1] that shows the
[-Wunused-but-set-variable] warning. Since the previous commit[2] I made
gives users an option to turn on and off the CONFIG_RFS_ACCEL, the issue
then can be discovered and reproduced. Move the @i into the protection
of CONFIG_RFS_ACCEL.

[1]
All warnings (new ones prefixed by >>):

   drivers/net/ethernet/broadcom/bnxt/bnxt.c: In function 'bnxt_request_irq':
>> drivers/net/ethernet/broadcom/bnxt/bnxt.c:10703:9: warning: variable 'j' set but not used [-Wunused-but-set-variable]
   10703 |  int i, j, rc = 0;
         |         ^

[2]
commit 9b6a30febddf ("net: allow rps/rfs related configs to be switched")

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202506282102.x1tXt0qz-lkp@intel.com/
Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 869580b6f70d..7369b39380d0 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -11538,9 +11538,10 @@ static void bnxt_free_irq(struct bnxt *bp)
 
 static int bnxt_request_irq(struct bnxt *bp)
 {
-	int i, j, rc = 0;
+	int i, rc = 0;
 	unsigned long flags = 0;
 #ifdef CONFIG_RFS_ACCEL
+	int j = 0;
 	struct cpu_rmap *rmap;
 #endif
 
@@ -11559,7 +11560,7 @@ static int bnxt_request_irq(struct bnxt *bp)
 	if (!rc)
 		bp->tph_mode = PCI_TPH_ST_IV_MODE;
 
-	for (i = 0, j = 0; i < bp->cp_nr_rings; i++) {
+	for (i = 0; i < bp->cp_nr_rings; i++) {
 		int map_idx = bnxt_cp_num_to_irq_num(bp, i);
 		struct bnxt_irq *irq = &bp->irq_tbl[map_idx];
 
-- 
2.41.3


