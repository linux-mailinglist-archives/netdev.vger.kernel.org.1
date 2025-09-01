Return-Path: <netdev+bounces-218838-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 58BA6B3EC36
	for <lists+netdev@lfdr.de>; Mon,  1 Sep 2025 18:30:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B277E1A87A1C
	for <lists+netdev@lfdr.de>; Mon,  1 Sep 2025 16:30:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ED78306484;
	Mon,  1 Sep 2025 16:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jcroSccy"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39019258CDF
	for <netdev@vger.kernel.org>; Mon,  1 Sep 2025 16:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756744199; cv=none; b=PTjgx7h6EOag8lRilA1HYiTM9NH37IJIflpIfrS6fK+Qe4iiUlOvZBrKR/+iNYPqTkGvdahH9MqqGI+A10dizZJLwY5wYzjnFQl8SaFi9bRaUDD+njxN1BOVThe/qDqAzZcRxtO8vqaT3NZVDkkSu8TNAvSkzfBfxixlsC7El+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756744199; c=relaxed/simple;
	bh=Cegi9Vay0HmhYLXWon9aWkLCgXSsP0pqKpB4+mmsybs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=llU0+Ons2QZ/MPzt4XAVPyu+saZdfYNZqjC1tPwsS2oOZh5r2agCfkLCOrNnDjgkllJlzdqlI+inJVvJ2CWoq1zY1BAGPd3g9aAByB0SqdBWbvunclHnUCk+9P/vNcKmZtuNwT5LEfn3Rm+tDUYaI5cBVH7WMf+QX3+HRKhPdEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jcroSccy; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-76e4f2e4c40so3682871b3a.2
        for <netdev@vger.kernel.org>; Mon, 01 Sep 2025 09:29:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756744197; x=1757348997; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gVHaqA8d+A2A0VFbozpT9QFVxWs8tE/ZHH5kQY3aPwE=;
        b=jcroSccyo/2V4wIWhTtmc24X35Mklyl4Uom0k1QiaeIT6w/A5xCtJX9ridJmx0bIf3
         mORUVduwg2LBBimND0CkQwmLw+VuRgzfWo8QiqVq1DMF/0ryXub8haiYyvTlBK/vXm/z
         SACNxONzwI2Ywo/6tOtl+FIF9oCFcp5otCUbTQz/4eWKVs0um7NMo40eyZ3GaK5VBpMA
         7jgmfs3tW8blqCtVhSHvPg7MLJqjxVvMWbzQoZFtKBRhWv8m0a/HPvJodKNMmOIlCPMY
         SBXtgE0fm4lNnsxo8QjCKWAnpwXqsQT6NSN8oBy9clHzZ8kHyVyR6G+cOPC2oQBUV9x7
         ry5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756744197; x=1757348997;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gVHaqA8d+A2A0VFbozpT9QFVxWs8tE/ZHH5kQY3aPwE=;
        b=YpvoK59YQeO0Q8SmKwqg1uyx1sRymXKBWdO/oPnwnpY4iVcrDsjHpedjlubrwpNDt6
         ZI3kix1eBNpPm/mJ66zzDzaQKIW8LMgglOLuox4x+PmEvaw4tgYWwuQ8XVvstcptvGNr
         p+VCswxZkCcsS3CAC0+bzxLLq0LD8em4STPZKyBLkeoqfBwyCuU+N+2K0ZaQgvp3CUFS
         k6HjWl4LTMtw8AllbAbSPAOwNrGk3vItCd52g2+z+SY8o9eZyYtOHDiKs2iYhdVzJgCY
         li0tCYmnKyVb6j/t1i+pksghwPnsPwXxJT0j3t2cEWlsuzggUcUw8g8XBf7ZxcoY2IuL
         nGaQ==
X-Forwarded-Encrypted: i=1; AJvYcCVaAXyidEnSXYQNFk8Wbygd/ATzGb2MWa2yUNK6cSnctj2XzpwjqMzH9O0oU9K9tJuKitNeKjQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzASzy2iLIBvc1z9PglI98cReWR3YEZdiTKHkwX+8iU95EWbNJ7
	Rlgntlzl7MJuZjF+v0gytOuUY6xSnTsqKBm0WDpWhA9p5Ea+vQK08JkY
X-Gm-Gg: ASbGncuU89CVpsjOnCklr9mNCzGAojK1uaGlAvXPHnz/sJvZcTZG++EuHjilIjaFZe+
	PkN4IKTVV37+I9va0BJJ892sIxL8wwF7h5U8peCaUy9jJGSNV7nnDjuQuwHGyVzCZRl9b85qMnC
	aH5dWLgrgUWVga3hQbwPegRMjKgM8h/SmBf8Jd5bjrOuVjFWUK8DKQKnxxz4KPSFU9JCHQgau7f
	aqfqBEnrc1VCzmd6t94hZT8CXgvwaC+c+eKmGmwT1I0PyPC3BzdNNz/UaFi6lJp6FRWeIIcOdie
	KP1ls60kpW4w8mQwU7sq/cAN6bhHdEJckZYRZGrzwPeUofsz4ZgSNQq/dzk4Vv7nNRc2/H2saNM
	oA4KMeFFAR69KWgT3PvBg5xkUGggbZ0goyv1lhJqmSfE/WPkEVzhZv3pnCY2bANrRoDMkIUGEX+
	XpqQHGBigTnvcF
X-Google-Smtp-Source: AGHT+IHDnXCAQnNUmI8qNWb5RwrdWnFkkRDolPpQXrlpFtU/IcyeaIWbVczNvnOTJtU0k1FJ5hH5Ow==
X-Received: by 2002:a05:6a00:1398:b0:770:4eff:a300 with SMTP id d2e1a72fcca58-7723e224647mr8756780b3a.8.1756744197369;
        Mon, 01 Sep 2025 09:29:57 -0700 (PDT)
Received: from chandra-mohan-sundar.aristanetworks.com ([2401:4900:1cb9:9f52:dc55:7aae:b6df:e6e9])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7722a26a3e3sm11231741b3a.13.2025.09.01.09.29.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Sep 2025 09:29:57 -0700 (PDT)
From: Chandra Mohan Sundar <chandramohan.explore@gmail.com>
To: nicolas.ferre@microchip.com,
	claudiu.beznea@tuxon.dev,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	shuah@kernel.org
Cc: Chandra Mohan Sundar <chandramohan.explore@gmail.com>,
	linux-kernel-mentees@lists.linux.dev
Subject: [PATCH net-next] net: macb: Validate the value of base_time properly
Date: Mon,  1 Sep 2025 21:59:19 +0530
Message-ID: <20250901162923.627765-1-chandramohan.explore@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In macb_taprio_setup_replace(), the value of start_time is being
compared against zero which would never be true since start_time
is an unsigned value. Due to this there is a chance that an
incorrect config base time value can be used for computation.

Fix by checking the value of conf->base_time directly.
This issue was reported by static coverity analyzer.

Fixes: 89934dbf169e3 ("net: macb: Add TAPRIO traffic scheduling support")
Signed-off-by: Chandra Mohan Sundar <chandramohan.explore@gmail.com>
---
 drivers/net/ethernet/cadence/macb_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index 290d67da704d..e9b262a0223f 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -4104,7 +4104,7 @@ static int macb_taprio_setup_replace(struct net_device *ndev,
 		return -EINVAL;
 	}
 
-	if (start_time < 0) {
+	if (conf->base_time < 0) {
 		netdev_err(ndev, "Invalid base_time: must be 0 or positive, got %lld\n",
 			   conf->base_time);
 		return -ERANGE;
-- 
2.43.0


