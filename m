Return-Path: <netdev+bounces-109067-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08140926BF8
	for <lists+netdev@lfdr.de>; Thu,  4 Jul 2024 00:51:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3AB041C21DF8
	for <lists+netdev@lfdr.de>; Wed,  3 Jul 2024 22:51:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD361194C69;
	Wed,  3 Jul 2024 22:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=herbertland.com header.i=@herbertland.com header.b="hI1sXn2/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63E59194C74
	for <netdev@vger.kernel.org>; Wed,  3 Jul 2024 22:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720047033; cv=none; b=rojNEJPiZ/0pdP2r+mtM+vKqZ4c4k0lmLe/z85jDZm/kvlmsrKVkBrz7cQ+Gk8Z+dvaif1hBq9tkpJhsSWKH+2mu627ayTpidwbgPGO5vpyl6i9ozWby4f1wkNliZUWG2dQS+orq+FUOjrdngpy/9i67H68LW2hrSfJJBSas5T0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720047033; c=relaxed/simple;
	bh=okRvaY6wtYOig2tH4YWvxkGWOqPOk934c69zOtz6okc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YXlOjIEuNMgyWkWfPXOGZfQjblejRMNDbpMicFkc6baUfXnMDi5kjNtVFVu+9n4RFSlnuv6Nt0t4lC71jUYcyJp/oneSGiq8W4uTy9lM22Jjubr9XNAN6dll1kdwVgOtLPxOaRd1IVLZcqJDuZgGsCQR6HkJUEoP4oWownePPE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=herbertland.com; spf=pass smtp.mailfrom=herbertland.com; dkim=pass (2048-bit key) header.d=herbertland.com header.i=@herbertland.com header.b=hI1sXn2/; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=herbertland.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=herbertland.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-75ee39f1ffbso121874a12.2
        for <netdev@vger.kernel.org>; Wed, 03 Jul 2024 15:50:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=herbertland.com; s=google; t=1720047032; x=1720651832; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LcNhzgnbhqKwod4mhnhz7z6nqA0gm1zz3hxNpqKqAH0=;
        b=hI1sXn2/W2JvZXpe8XAnVclI9BCLDK01knLBzvH84gYh2bapk4jwnWRqkHahxi0M8F
         b06pg39C8kAkw4xyzDoXERQ+4mjxYRv7BDMraXl7S9GaBgRG//UvXJB87geVuhv/HCY+
         LMybU+/B+pU8LK+wBVt5toOZB2iGfmBRStaP0CJvF9t4Zp1kypiftwpzi7d3eCas7raC
         91R/XFjEotiDHUYUiwvtzrMxQQNt0rfTnjkw/vVaWMJtxfrhSuiehAChm04oo9NUmoIL
         KS1E51GVGKTOrmNaWzQMdETi4Q/zgOOKA0BA6OHaqckcIhI2xIC8srI5zd8owbC2OXtl
         QZdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720047032; x=1720651832;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LcNhzgnbhqKwod4mhnhz7z6nqA0gm1zz3hxNpqKqAH0=;
        b=LTPy1WFO7U8C/RGuI7NMmcthRKqQkFrlrdxpJ9lYfHOfYzZLWLkAUWulzEkqPrIKDO
         hgmQyKDaV/khBM32+Jz4L5X2pElr8g5FEZgpZXmjyx93OWufc39wvz2updXBQFb9aTU1
         SCHB3pJ99JASvzRhTXgtCx67TvnzEPPgaHXm6yz5Jre443lBm03S+XIrgQAEt/WBIFi6
         UYzWDvUmpkZhJakJ2vbD18uAFFo9g4yvblaZ6cze1ILR1KeUiDuEzGN00Sl6PBBVcmPM
         AKjirAiS2QoS7x/M28tZ53XGzyOWGNHXa+8UQa9Gu1XVZS2ccC/IN7LxTk8mrt8TDddX
         NfRg==
X-Forwarded-Encrypted: i=1; AJvYcCVnqGRM/rmjNQNY0lD9n/YYdYu/s0Dh8GxeCEOJFN7eTahES6uMEFyLqZi+w/g0aLLV1IjHWUAtsTnPFpYFfVDHXqOgJOLh
X-Gm-Message-State: AOJu0YxM2Ar11l76ymqlAlGYomtWeyQY4bDWJF+FDOYT8RlUx2jyONyY
	X+A/hp7VYoTrECbg/BWnIcZf/eYGsDmXYDfWKnzvyn1m0FTJ4ExLr7ie1Ws0FLgd87K1Rl6c0O7
	H3g==
X-Google-Smtp-Source: AGHT+IGRLAmwIA2CzBRXhD4FX4my0Cv78WXeipXidFdalbHwFMRdRL8OQFAR5KS5LHkIWp79pLZGPQ==
X-Received: by 2002:a05:6a20:1584:b0:1bd:fe8:fc9a with SMTP id adf61e73a8af0-1bef60fc0demr16930039637.17.1720047031780;
        Wed, 03 Jul 2024 15:50:31 -0700 (PDT)
Received: from TomsPC.home ([2601:646:8300:55f0:af8e:aa48:5140:2b5b])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1faf75b3407sm40242185ad.85.2024.07.03.15.50.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jul 2024 15:50:31 -0700 (PDT)
From: Tom Herbert <tom@herbertland.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	jesse.brandeburg@intel.com,
	anthony.l.nguyen@intel.com,
	cai.huoqing@linux.dev,
	netdev@vger.kernel.org,
	felipe@sipanda.io
Cc: Tom Herbert <tom@herbertland.com>
Subject: [RFC net-next 10/10] wangxun: Call skb_set_csum_crc32_unnecessary
Date: Wed,  3 Jul 2024 15:48:50 -0700
Message-Id: <20240703224850.1226697-11-tom@herbertland.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240703224850.1226697-1-tom@herbertland.com>
References: <20240703224850.1226697-1-tom@herbertland.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When a validated offload CRC for SCTP is detected call
skb_set_csum_crc32_unnessary instead of setting
CHECKSUM_UNNECESSARY

Signed-off-by: Tom Herbert <tom@herbertland.com>
---
 drivers/net/ethernet/wangxun/libwx/wx_lib.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/wangxun/libwx/wx_lib.c b/drivers/net/ethernet/wangxun/libwx/wx_lib.c
index ac0e1d42fe55..8f4ffc961abf 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_lib.c
+++ b/drivers/net/ethernet/wangxun/libwx/wx_lib.c
@@ -558,7 +558,10 @@ static void wx_rx_checksum(struct wx_ring *ring,
 	}
 
 	/* It must be a TCP or UDP or SCTP packet with a valid checksum */
-	skb->ip_summed = CHECKSUM_UNNECESSARY;
+	if (dptype.prot == WX_DEC_PTYPE_PROT_SCTP)
+		skb_set_csum_crc32_unnecessary(skb);
+	else
+		skb->ip_summed = CHECKSUM_UNNECESSARY;
 
 	/* If there is an outer header present that might contain a checksum
 	 * we need to bump the checksum level by 1 to reflect the fact that
-- 
2.34.1


