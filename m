Return-Path: <netdev+bounces-140177-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C31C9B56E8
	for <lists+netdev@lfdr.de>; Wed, 30 Oct 2024 00:28:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7FE2A1C21D00
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 23:28:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7614320B210;
	Tue, 29 Oct 2024 23:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bmV761Yr"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FA3C205141;
	Tue, 29 Oct 2024 23:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730244446; cv=none; b=t6EC02x4vVT3QIEEdts2u6RsIvo8sqbpd7qrvXwy4xHBgde2aXcF18XBlxnNR5EGPMSBQ3jLnR4K3JHV6w9Pe6Vbl10q9hxr3VdHnNeyUu+FePFXphlOv6aN0iZj5tlL2ChZK6nGyPHzNsYS4UpeVEYO5OzzgGsp1gOdddF/Ep4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730244446; c=relaxed/simple;
	bh=5bVa21ay7dYtmyCAx6BnQvkA4jvtQuZfFBVVe8Dy76I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dfdIZILheSqHZAEqriANoyz0xusH7SmOfIaVlsVQfB7ltPWxddarsDuRVsYaB2Vhe+neWu072qh10af24ZfDEkD9obGM1WLwqaXz1flX1qlmZnj6THZTO1P4b2PJBmFt8oRiRVydSZ8aIf9XTsz7XoTMi2ZJXNPLq3ODkmX2HUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bmV761Yr; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-20cceb8d8b4so2161155ad.1;
        Tue, 29 Oct 2024 16:27:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730244443; x=1730849243; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2kZRwrfcZPy1AyU5csKSGQr20lxdhyft9OjyIMBEkCw=;
        b=bmV761Yr5F3lYXyThkv5hpRlSp+cFk9By7z/azzbGCxJyMxGGq6a3tcZlOMabkqyiM
         UJ9oAdrn4MeLqjoe/bbC4g1o3CKggcflvPDMz5x93/SzR1YNQM12l+M1pi7dPBG7u1Yh
         Uvbz65VKVWYzonPH3ZdormD1Bi6/fQfkbjLojuEJa/J5sZFK2MU5RdEeflc86A9IkAr0
         fIyFg0qX94v/OQKPjEiR+/H0WYRQac6uTQJD5vN0zkbDdJRomHKLh4/BCfb9PkKnzrM5
         JcKgukbZ/0X9WG3cgl0ytEniaj8Zl6w5PwckRYICzdyw08+Muy96XCaA9NFJp/uICJZC
         hpPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730244443; x=1730849243;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2kZRwrfcZPy1AyU5csKSGQr20lxdhyft9OjyIMBEkCw=;
        b=h1uvSppYfXs75ewNCcUmsBQyFNBMrdInk+o60pptj5bzTrvS4iC7Kh65jqMdeUUq0+
         Wk8T7xKXu/F2/HWuVI0mZ3t5f3BPSS1KgIzR3bx7D6o8z0+uWCTXzHnrG0xubw56PfD3
         aChFhRLCxCaY+Jrbe4kkDhQUw4SkH22bQ1p1TFUe2ickF1s70NlZNQ3nkp4R9kQ6djlV
         Q1P0sjB40LP73zPx8PmaPxsOLYzguts78VhVDOwft+htN4GlQshaIaNwTxbmNM+MzsMk
         kveUfVy1YmQjdHNVOtNFo5V6L7z3S5ZEwqlTrxc5d2i4rmco3OP6eBztNSI9voNs5P+t
         GSOw==
X-Forwarded-Encrypted: i=1; AJvYcCVYDpRFeYimX3QJw5WJsw3/Z9orzlqqapqroVgB2y7Ay4yK4bqeH5G/NwsWYwlm2O3pUX+coZdO96bH4LI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7+6TgqahJNzXFR9EcJbp1ReGRsPaR2w+X7Hvw6+ulJw1nqF9I
	cRlsikCwqWthCJDpwDIbmjFZzE/HbFGFbmKwvHhHWp7dwtGKOP6MIcDvTg==
X-Google-Smtp-Source: AGHT+IEQUaL6YXXl4H24UPvk3iWYagwV6dS4wyVThAwlR4vaFg1k/jAXHeg5RBghElMlhKnRBLcJVw==
X-Received: by 2002:a17:902:f647:b0:20c:7e99:3df2 with SMTP id d9443c01a7336-210ed4495b3mr54994935ad.23.1730244443462;
        Tue, 29 Oct 2024 16:27:23 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8200:dab8::a86])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-210bc012f19sm71678275ad.158.2024.10.29.16.27.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2024 16:27:23 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: netdev@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rosen Penev <rosenp@gmail.com>,
	Simon Horman <horms@kernel.org>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] net: fjes: use ethtool string helpers
Date: Tue, 29 Oct 2024 16:27:21 -0700
Message-ID: <20241029232721.8442-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The latter is the preferred way to copy ethtool strings.

Avoids manually incrementing the pointer.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
Reviewed-by: Simon Horman <horms@kernel.org>
---
 v2: remove p variable and reduce indentation
 drivers/net/fjes/fjes_ethtool.c | 64 ++++++++++++---------------------
 1 file changed, 23 insertions(+), 41 deletions(-)

diff --git a/drivers/net/fjes/fjes_ethtool.c b/drivers/net/fjes/fjes_ethtool.c
index 19c99529566b..70c53f33d857 100644
--- a/drivers/net/fjes/fjes_ethtool.c
+++ b/drivers/net/fjes/fjes_ethtool.c
@@ -87,49 +87,31 @@ static void fjes_get_strings(struct net_device *netdev,
 {
 	struct fjes_adapter *adapter = netdev_priv(netdev);
 	struct fjes_hw *hw = &adapter->hw;
-	u8 *p = data;
 	int i;
 
-	switch (stringset) {
-	case ETH_SS_STATS:
-		for (i = 0; i < ARRAY_SIZE(fjes_gstrings_stats); i++) {
-			memcpy(p, fjes_gstrings_stats[i].stat_string,
-			       ETH_GSTRING_LEN);
-			p += ETH_GSTRING_LEN;
-		}
-		for (i = 0; i < hw->max_epid; i++) {
-			if (i == hw->my_epid)
-				continue;
-			sprintf(p, "ep%u_com_regist_buf_exec", i);
-			p += ETH_GSTRING_LEN;
-			sprintf(p, "ep%u_com_unregist_buf_exec", i);
-			p += ETH_GSTRING_LEN;
-			sprintf(p, "ep%u_send_intr_rx", i);
-			p += ETH_GSTRING_LEN;
-			sprintf(p, "ep%u_send_intr_unshare", i);
-			p += ETH_GSTRING_LEN;
-			sprintf(p, "ep%u_send_intr_zoneupdate", i);
-			p += ETH_GSTRING_LEN;
-			sprintf(p, "ep%u_recv_intr_rx", i);
-			p += ETH_GSTRING_LEN;
-			sprintf(p, "ep%u_recv_intr_unshare", i);
-			p += ETH_GSTRING_LEN;
-			sprintf(p, "ep%u_recv_intr_stop", i);
-			p += ETH_GSTRING_LEN;
-			sprintf(p, "ep%u_recv_intr_zoneupdate", i);
-			p += ETH_GSTRING_LEN;
-			sprintf(p, "ep%u_tx_buffer_full", i);
-			p += ETH_GSTRING_LEN;
-			sprintf(p, "ep%u_tx_dropped_not_shared", i);
-			p += ETH_GSTRING_LEN;
-			sprintf(p, "ep%u_tx_dropped_ver_mismatch", i);
-			p += ETH_GSTRING_LEN;
-			sprintf(p, "ep%u_tx_dropped_buf_size_mismatch", i);
-			p += ETH_GSTRING_LEN;
-			sprintf(p, "ep%u_tx_dropped_vlanid_mismatch", i);
-			p += ETH_GSTRING_LEN;
-		}
-		break;
+	if (stringset != ETH_SS_STATS)
+		return;
+
+	for (i = 0; i < ARRAY_SIZE(fjes_gstrings_stats); i++)
+		ethtool_puts(&data, fjes_gstrings_stats[i].stat_string);
+
+	for (i = 0; i < hw->max_epid; i++) {
+		if (i == hw->my_epid)
+			continue;
+		ethtool_sprintf(&data, "ep%u_com_regist_buf_exec", i);
+		ethtool_sprintf(&data, "ep%u_com_unregist_buf_exec", i);
+		ethtool_sprintf(&data, "ep%u_send_intr_rx", i);
+		ethtool_sprintf(&data, "ep%u_send_intr_unshare", i);
+		ethtool_sprintf(&data, "ep%u_send_intr_zoneupdate", i);
+		ethtool_sprintf(&data, "ep%u_recv_intr_rx", i);
+		ethtool_sprintf(&data, "ep%u_recv_intr_unshare", i);
+		ethtool_sprintf(&data, "ep%u_recv_intr_stop", i);
+		ethtool_sprintf(&data, "ep%u_recv_intr_zoneupdate", i);
+		ethtool_sprintf(&data, "ep%u_tx_buffer_full", i);
+		ethtool_sprintf(&data, "ep%u_tx_dropped_not_shared", i);
+		ethtool_sprintf(&data, "ep%u_tx_dropped_ver_mismatch", i);
+		ethtool_sprintf(&data, "ep%u_tx_dropped_buf_size_mismatch", i);
+		ethtool_sprintf(&data, "ep%u_tx_dropped_vlanid_mismatch", i);
 	}
 }
 
-- 
2.47.0


