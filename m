Return-Path: <netdev+bounces-128651-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9588897AAF1
	for <lists+netdev@lfdr.de>; Tue, 17 Sep 2024 07:19:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3FFD41F23FEB
	for <lists+netdev@lfdr.de>; Tue, 17 Sep 2024 05:19:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86C083A8F7;
	Tue, 17 Sep 2024 05:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DhgY7Zi8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07D002628C;
	Tue, 17 Sep 2024 05:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726550343; cv=none; b=bxX+ccS4Gexo6j6Mxo1tCsbEkBmX3WmuAOGiC3Ju3oFMinpl5wQzxwFEfaTS+c9HC7+NFSgFZj9m7LGQ+hj/yTCnDJi37UBWY2tDRv8wIDN6GPFn/3CZhgFpUzJs7th5CfEoiRIkEyNavW3hUMnPQvKgXgaEHdpHa3auj+WaDoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726550343; c=relaxed/simple;
	bh=M4vuMj7CLYT3Z8oQXAVcPG0QTJn48rt6NBlRQWqyZWY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=juJrMZweb6SHAT5dyf614gQeiNsq+bq1ZDimviMVh17/r0+FD56AzSr0QJb0bMtTCy1qHYXsPdHNcfiyX7BYaqR3jZi+d9jy3Ft4cftkUxFyv5ZwLQmQEcjZcMNq2Cy/Dw6Pzf0B42YqKZ35LHQO4URanskv101aZPnohuMqJEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DhgY7Zi8; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2d88c5d76eeso2746228a91.2;
        Mon, 16 Sep 2024 22:19:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726550341; x=1727155141; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WRybB9wxP64p2CF/sxwLTas0ioD5kY3JDod4yC46o3Q=;
        b=DhgY7Zi8H73Lbvy9xFo2wwoESkxRXuaPIFI6nbqA5VYa4dDHuQ0ssZYUuoWlnDFxno
         PboLIPaA7mos0s0OfZzL8JL0udyZcrfacJqDTCQNwjfecpoV31ClO9Sq1nxBYe1meQF0
         h2zQ/aE+AsAKtJMiWofy5mNRGL23sIxKeDXl589zuvf/0tA5+dPIc65CXm8231KOH0a+
         FbUFaMV4K56E26wTYNI+bExLAwon6cja03FNhVY34+/AQh+Otl7p8gmijaT1rofglsK0
         g3ktCq2BLu3z7h+y9AXYVxbgGEqVd4YleVUGJ23FmYjt9xIUVImZC3vYxk1jU/ym//yk
         FSaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726550341; x=1727155141;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WRybB9wxP64p2CF/sxwLTas0ioD5kY3JDod4yC46o3Q=;
        b=wN04MPBL8abbNFyjbRjXnSRoxsrlY+NNdNpOWF5zjdsGHw3bjIUpJO28fvqlsnWDif
         iITQQj0V3CqD6NUeURg+N/rMkHxkv8Bgxu+B5ODOuB069RurVDjabGH3p6vO1CWValgh
         olx+buuV+2uap7+r36n5DZG3TcCrdqPam7dIqK3YV6wMjCmzVphUCnrqV0Qgfw1/CfCG
         faQhuRafljheP/A6KkdXAUDABLWXU530c4O93s/jXK6RPzVq1Y9qaG8z9uLs8EC8a0pV
         4scgob990QaBSxSXIURcVEbnKSQYERV1Ju0HN83n9D7RtDD3k1qsF3j7r/G4vLA1czwC
         +YIg==
X-Forwarded-Encrypted: i=1; AJvYcCU09nYcwa0XpUPgI0jaOH5MdnnRFz3EOC33vHVa+GgQWEK0qDQshPuTJJ4U1yX6wbggR9WYeUNFLCstdNE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwruC4cjbFTorfb+1eYVnJjzGMMvlvJNE2OoV8jGC3W5Q3O3D+H
	pTnADk1IMGoKLPDUgo6kFDbaJr9GDbVI7YMqRE9aID9wveOb0j8l
X-Google-Smtp-Source: AGHT+IH51uSUbdMQ9iCrRl2QRy9eX4aXfLw9P5cCMHdLWzhxrn4FSJyPmohY2Oyu5NtEd1wLer9ijg==
X-Received: by 2002:a17:90a:68ce:b0:2c9:61ad:dcd9 with SMTP id 98e67ed59e1d1-2dbb9ee0450mr17054190a91.27.1726550340871;
        Mon, 16 Sep 2024 22:19:00 -0700 (PDT)
Received: from amenon-us-dl.hsd1.ca.comcast.net ([2601:646:a002:44b0:14db:b6fb:c5a7:2dd7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2dbb9d95b42sm8382324a91.48.2024.09.16.22.18.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Sep 2024 22:19:00 -0700 (PDT)
From: Aakash Menon <aakash.r.menon@gmail.com>
X-Google-Original-From: Aakash Menon <aakash.menon@protempis.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	lars.povlsen@microchip.com,
	Steen.Hegelund@microchip.com,
	daniel.machon@microchip.com,
	UNGLinuxDriver@microchip.com,
	aakash.menon@protempis.com,
	horms@kernel.org,
	horatiu.vultur@microchip.com
Cc: netdev@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net v2] net: sparx5: Fix invalid timestamps
Date: Mon, 16 Sep 2024 22:18:29 -0700
Message-ID: <20240917051829.7235-1-aakash.menon@protempis.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Bit 270-271 are occasionally unexpectedly set by the hardware. This issue
was observed with 10G SFPs causing huge time errors (> 30ms) in PTP. Only
30 bits are needed for the nanosecond part of the timestamp, clear 2 most
significant bits before extracting timestamp from the internal frame
header.

Fixes: 70dfe25cd866 ("net: sparx5: Update extraction/injection for timestamping")
Signed-off-by: Aakash Menon <aakash.menon@protempis.com>
---
v2:
- Wrap patch descriptions at 75 characters wide.
- Use GENMASK(5,0) instead of masking with 0x3F
- Update Fixes tag to be on the same line
- Link to v1 -https://lore.kernel.org/r/20240913193357.21899-1-aakash.menon@protempis.com
drivers/net/ethernet/microchip/sparx5/sparx5_packet.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_packet.c b/drivers/net/ethernet/microchip/sparx5/sparx5_packet.c
index f3f5fb420468..70427643f777 100644
--- a/drivers/net/ethernet/microchip/sparx5/sparx5_packet.c
+++ b/drivers/net/ethernet/microchip/sparx5/sparx5_packet.c
@@ -45,8 +45,12 @@ void sparx5_ifh_parse(u32 *ifh, struct frame_info *info)
 	fwd = (fwd >> 5);
 	info->src_port = FIELD_GET(GENMASK(7, 1), fwd);
 
+	/*
+	 * Bit 270-271 are occasionally unexpectedly set by the hardware,
+	 * clear bits before extracting timestamp
+	 */
 	info->timestamp =
-		((u64)xtr_hdr[2] << 24) |
+		((u64)(xtr_hdr[2] & GENMASK(5, 0)) << 24) |
 		((u64)xtr_hdr[3] << 16) |
 		((u64)xtr_hdr[4] <<  8) |
 		((u64)xtr_hdr[5] <<  0);
-- 
2.46.0


