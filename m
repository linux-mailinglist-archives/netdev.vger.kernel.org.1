Return-Path: <netdev+bounces-116574-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4658D94B02F
	for <lists+netdev@lfdr.de>; Wed,  7 Aug 2024 21:01:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 967A3284860
	for <lists+netdev@lfdr.de>; Wed,  7 Aug 2024 19:00:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CDA314388F;
	Wed,  7 Aug 2024 19:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JJc9+Gev"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FAE6142E79
	for <netdev@vger.kernel.org>; Wed,  7 Aug 2024 19:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723057246; cv=none; b=Z5xhnU+JxeqAG4bJQg3KTFIw4iUTzqraLF94laHxTTs4QLE1KJrjpAxe56wbcD6bRl97W+mt44cc6rpsZi1dnSXldnipto7q/a0+7cyCmBCMPkfyA6YBtXHHZQu3HAfQnM27zqCgX2ulGSy7OEB17lWaj58D5se/7PAs21zdE9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723057246; c=relaxed/simple;
	bh=4p3mUowOkDd+O4p0HtPqE/OOyQ9DpdZyWT+rkXVeyFQ=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=fURouV/BMBFArP9bogzvss6kDcQqGpezxsjilTbFMra7GcJYfMUTrc3hDGq3JiSD2APLuw9p+AYoUmL322A6V004pr6b4zdlUwgt0Q2d38wL1adlA+SuANUvFVx5iu6gP3s2JsIQVYTpsdNwn0PMrc/PL6ZMV6nAA0taLYB79zo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JJc9+Gev; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-7a115c427f1so140617a12.0
        for <netdev@vger.kernel.org>; Wed, 07 Aug 2024 12:00:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723057244; x=1723662044; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=ekxhuoOASuJte+IVjHmB7YRJE1hFNTEWvpBzPkjuX+I=;
        b=JJc9+Gevr5r1TMSWKOUXEOs+uxhVe9IsKIlOSii61t4fnfSqpdlA89fY4fofJJPabw
         0kRk9yR328JgIRaQQI1uOVxYEV6DFZaHqaykpn0j3myzSMIiA3TSx3NKGQAtdSNQEUBv
         Q1GmjbuCWYtheD5cL+jwRqpeaGTJZKBnnPk89ASgNhJE6PYXhbJ4k3itVzb/c6Q2t9Wb
         ZX1nm5bcZ9MfPGnKOo1c/CAVCqJFZtrAZTedg5TvIPUOWKBc3nmKIoPu46eHlkh1JHT5
         K/5GhqmgZFTv3LqMk6c2rqJ0Kh/89ZbllrAC9YoUPEaWeYkgtEvp13ssEDoAGJvmvcVu
         ih5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723057244; x=1723662044;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ekxhuoOASuJte+IVjHmB7YRJE1hFNTEWvpBzPkjuX+I=;
        b=P6erxGfSa7Qpthkt1YLWJsCuB1mcbElC8A7SmrE49FunUQLz2uRhWOGgjlMYiGXUfb
         pBjkgU9Nu9OZA45nl5sdHuk/f9mb8v4PM/SnR1g/Y4q8/7uh2WAxgkvO8X4WMYpkZyCF
         rXfI4OigjDFrrNBoL7qJrmxh7lt5lORlz0VUysnEXbDAOUsGYIX0S2TsLiM2I80OrsFI
         k7xptQhcwnd3iApJVnG1hdZT80hRRWNMmz2YucqD54XH78geWXOsfNfcICODNDBxvN1X
         ghtdtGqSb7iCwlZZyi3EhA36DOHE/UMp5avTfcd0jJIu7m0ZbnBHTUJblnaYis58IybD
         eB1A==
X-Gm-Message-State: AOJu0YyoBIyhaC1bMAT9qHvlCaflIPefXHmMLvPGz8/MVGGllY9bL6k3
	Vhdc+GVfKZxmFgHA8JovGV/OOzGxCUtszOkPil0PRf6oUyQ+a0b3I4miPw==
X-Google-Smtp-Source: AGHT+IE/E8Sto17HQVDyI3P2mLr46MDRpXdEdGDxFSOY+e074nSX2ILQS0q6Sk8Py0BOqsQUNKbHYw==
X-Received: by 2002:a17:90b:224e:b0:2cf:c9ab:e747 with SMTP id 98e67ed59e1d1-2cff93c5a3emr20544442a91.1.1723057244388;
        Wed, 07 Aug 2024 12:00:44 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8200:dab8::a86])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d1b3b35f4esm1921898a91.40.2024.08.07.12.00.43
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Aug 2024 12:00:44 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: netdev@vger.kernel.org
Subject: [PATCH] net: mediatek: use ethtool_puts
Date: Wed,  7 Aug 2024 12:00:34 -0700
Message-ID: <20240807190042.6016-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Allows simplifying get_strings and avoids manual pointer manipulation.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/net/ethernet/mediatek/mtk_eth_soc.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/mediatek/mtk_eth_soc.c b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
index 16ca427cf4c3..0cd050f83126 100644
--- a/drivers/net/ethernet/mediatek/mtk_eth_soc.c
+++ b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
@@ -4329,10 +4329,8 @@ static void mtk_get_strings(struct net_device *dev, u32 stringset, u8 *data)
 	case ETH_SS_STATS: {
 		struct mtk_mac *mac = netdev_priv(dev);
 
-		for (i = 0; i < ARRAY_SIZE(mtk_ethtool_stats); i++) {
-			memcpy(data, mtk_ethtool_stats[i].str, ETH_GSTRING_LEN);
-			data += ETH_GSTRING_LEN;
-		}
+		for (i = 0; i < ARRAY_SIZE(mtk_ethtool_stats); i++)
+			ethtool_puts(&data, mtk_ethtool_stats[i].str);
 		if (mtk_page_pool_enabled(mac->hw))
 			page_pool_ethtool_stats_get_strings(data);
 		break;
-- 
2.45.2


