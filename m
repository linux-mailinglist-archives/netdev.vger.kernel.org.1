Return-Path: <netdev+bounces-172399-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 124B3A5476F
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 11:14:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6D2FA7A65FB
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 10:13:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C59E202C56;
	Thu,  6 Mar 2025 10:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gWZswxCu"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B34AD1FF7CC;
	Thu,  6 Mar 2025 10:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741256059; cv=none; b=HD4MEMKqW45Cxzx9yehP8Zx4l2ER7oSRvapnM2bLf6TOB2f8BUP13TKqHmwyyLy3C4eQdVT9igGHA6hP3W8ebG/rP967cS2c4j37A7v1gCMs+axmtAywygvLHW5SnoMBq+ZOxcJpW0kUYVbpt7eGtMwLY7T4Fa2cIwmuoyLhoWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741256059; c=relaxed/simple;
	bh=sx8yumw7/slQUX1H6tCQVoJjkcOlHDuGOyOYDOcCSjI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Jb8KqRt60FhIlWQa94hp3xgkqhWTgdVaA43uRyRBVixlwbrrWIhJyOmGsYCbqPr6g3hz3MRV6AJSnmiExzX8CeKncfBh7We0Do+Z4klQADcrisp10hwjaHJLBiJdh493UPHN86VOPkvsoccH6AhD8fylRycARJx0B0pZS6QTbNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gWZswxCu; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-30ba5cccc19so4710911fa.1;
        Thu, 06 Mar 2025 02:14:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741256056; x=1741860856; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SC6AHDf1+LSGmHO4yF1LlfxNEvEUB10IW0zw+9ERfVQ=;
        b=gWZswxCu6wptNfsZBfZ/eB3qYEsrCKBljuJ8repXjxS8fiNA9aEbHEBF3FZRkWXapT
         tV6jngcZs/knqYGDq7RIyHzy1JdSKmj1gWsTnbk+LrF9Tu+uda1Sl0mFaq7MqW5OHEES
         6DIuAueXGjjv2zNTvo5u9soB0Cpzfwy/4Ww1iz4kXMjBmmfH9fkd9hI6AiUxf5MIWQ2b
         a8Ibec9+1zHn+yNofhHW6ts7hCPYGpTflK6YPwcMTX1UzC/ZuLCOcfnmA6oDJLDX6X7k
         98+A7g0B8gYOepQzBfBdTTXUvW3MMr4DaPvxj9YG8ILSL2aIaVKOsNkIqRFnXCJbQaq9
         HJnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741256056; x=1741860856;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SC6AHDf1+LSGmHO4yF1LlfxNEvEUB10IW0zw+9ERfVQ=;
        b=McXTGvouSdZKC9FxJANPOSTZM2m2UNCnpzkGDXEdk+CpL8zwjHiF+ajlmH0dlXzC7y
         g0g0VCyUuNCVVTxSfY54hzp2Py6so1hIqEpGyJjy3OkUCggXDgdDijc/SJ/38LKM9IQF
         jNcGSL6/lC3cNX4mkrC8Onvw5UQvfhacOU/9HlKzRA1fFlfCPwEG/XtHl4a6t7uf5PSc
         pCfZaWt+UEkEtMlCfBgjYxbGwpLVs1wtWIw12wloLQFO80ALB4VKHlcItiKREY7EWCuL
         2ps2pixjaZwh+FjAslwds18vuQGzI+t6zyIvj8ahtRU3tiYLkWzDGftYRYpAeucjQvG9
         t9UA==
X-Forwarded-Encrypted: i=1; AJvYcCUKSbofjdqltj2J2eZ2fRZTODPs6lxvry4AchXSVbZqX6GpbwU0Q5Xyloe0IAJUESZE9B/E4aDyE36UsoU=@vger.kernel.org, AJvYcCWre6+Q6stbhZabu6QE0voQF7rW/ePQ+sIpohMf9Z/3pGk1khomYOc90YU1zuQG5/iLbH5YGXaM@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1EbJJK9P1OLWdVp48mnnGd4OV3t4OdzsLcxN3ZjVBDxmm05Ik
	O/QU6eDNOryrMfT71ZswIM8aYvjRWUGOA4nQcv6BB1RctNsn3KRb
X-Gm-Gg: ASbGncsIFtg6oo0rTYxNgBYVdy6+ArKVh6gfYiTrM2QMBWTpIJRhRUJRpLKuOk5p/ID
	FWmYVIf6En2MJqmv/itET6YoFwhFovtZvBBHOl4ZNrPQlbJJU1WXL9i1GTGlG04UJYC2oah6Nxf
	KSRdKEevTm+imr+ki30fU0ZYTTRvcKbgopL7E8hTm9W0A21Tu3KAoTs8bYiwmMurY8tNNGnWXGt
	HcM6z6liAy/mtUIbIpO+PdsbQU7CDqPxpMWYd2zOtskVlPo3OJ5Bvky24FzOj30l0xTB+DBhweB
	Kw+cybtwKV6D/yXLgwrCCwdtOZhjiY5RKQ0ZVkVUc9SaGCRmxcxgSraD3aPsaBKgatCP1qq1xbr
	vKA15C9mrdeg=
X-Google-Smtp-Source: AGHT+IHVUL4RmtkhR/oSDlMOZ3ZOLWUDnE3XMBPxWsK2S/UqrYa1tBtOoYQq3Q6pxGdr9M6ejBkxaA==
X-Received: by 2002:a2e:bc06:0:b0:30b:cd68:b69c with SMTP id 38308e7fff4ca-30bd7a1c6admr24523521fa.3.1741256055483;
        Thu, 06 Mar 2025 02:14:15 -0800 (PST)
Received: from rand-ubuntu-development.dl.local (mail.confident.ru. [85.114.29.218])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30be98d09e2sm1550631fa.12.2025.03.06.02.14.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Mar 2025 02:14:15 -0800 (PST)
From: Rand Deeb <rand.sec96@gmail.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	intel-wired-lan@lists.osuosl.org (moderated list:INTEL ETHERNET DRIVERS),
	netdev@vger.kernel.org (open list:NETWORKING DRIVERS),
	linux-kernel@vger.kernel.org (open list)
Cc: deeb.rand@confident.ru,
	lvc-project@linuxtesting.org,
	voskresenski.stanislav@confident.ru,
	Rand Deeb <rand.sec96@gmail.com>
Subject: [PATCH] ixgbe: Fix unreachable retry logic in combined and byte I2C write functions
Date: Thu,  6 Mar 2025 13:12:00 +0300
Message-Id: <20250306101201.1938376-1-rand.sec96@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The current implementation of `ixgbe_write_i2c_combined_generic_int` and
`ixgbe_write_i2c_byte_generic_int` sets `max_retry` to `1`, which makes
the condition `retry < max_retry` always evaluate to `false`. This renders
the retry mechanism ineffective, as the debug message and retry logic are
never executed.

This patch increases `max_retry` to `3` in both functions, aligning them
with the retry logic in `ixgbe_read_i2c_combined_generic_int`. This
ensures that the retry mechanism functions as intended, improving
robustness in case of I2C write failures.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Signed-off-by: Rand Deeb <rand.sec96@gmail.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_phy.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_phy.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_phy.c
index 0a03a8bb5f88..2d54828bdfbb 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_phy.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_phy.c
@@ -167,7 +167,7 @@ int ixgbe_write_i2c_combined_generic_int(struct ixgbe_hw *hw, u8 addr,
 					 u16 reg, u16 val, bool lock)
 {
 	u32 swfw_mask = hw->phy.phy_semaphore_mask;
-	int max_retry = 1;
+	int max_retry = 3;
 	int retry = 0;
 	u8 reg_high;
 	u8 csum;
@@ -2285,7 +2285,7 @@ static int ixgbe_write_i2c_byte_generic_int(struct ixgbe_hw *hw, u8 byte_offset,
 					    u8 dev_addr, u8 data, bool lock)
 {
 	u32 swfw_mask = hw->phy.phy_semaphore_mask;
-	u32 max_retry = 1;
+	u32 max_retry = 3;
 	u32 retry = 0;
 	int status;
 
-- 
2.34.1


