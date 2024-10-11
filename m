Return-Path: <netdev+bounces-134694-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7370B99AD53
	for <lists+netdev@lfdr.de>; Fri, 11 Oct 2024 22:02:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 32CB62825AF
	for <lists+netdev@lfdr.de>; Fri, 11 Oct 2024 20:02:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6940B1D0940;
	Fri, 11 Oct 2024 20:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YuLVErl7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08E3F1C3F0A;
	Fri, 11 Oct 2024 20:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728676950; cv=none; b=S6iMxwuZVRr46yzC3Qzp2KCHypLpq6Hh0T5ecQFasShU5fnlIpnO3R3gFDmQeRxxQR+NcGCGcYl8+cmfODBzBYgPOeU9FC0hoMYij0Y6xdYkJ2NqNN1Wl+bUu5bq1Wozabn+7Q3fhchwSyJiqWrwNxKf5T8+UJ9cG48AV7Gyv+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728676950; c=relaxed/simple;
	bh=/IYrI9SFtU09li13YBlEfdAOYwPQ1R4jlGIFZ8ncf5M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=C0I5o7FXATkGFXETLhSD9krJOo4+O7SyvdTne6JQEkkz2xZ0z80CrZffBgdxYZ6mLpCn/QLi/t7VwX6+sy8b90L3EyWSJCA+oSW96JcZnaM7DmeIUenLWA26NdHRKGtcYlx7G0GLLmBrS/HN7FC1rYBmElfMRMrZdgL8a4XAWSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YuLVErl7; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-7e9f998e1e4so2028123a12.1;
        Fri, 11 Oct 2024 13:02:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728676948; x=1729281748; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kCdDB4FzZCs+ONnQuY+4pTxcyDhIhs84SvGVwh2KpEw=;
        b=YuLVErl7OZTDedJaMflVYhKLes+v0agcNKMrKN8sA3G24AL+9q5hMhLzIcgozz3S5X
         AK23LXXx8r55PdkgXket71htvNdMVItS+eCY0p9oCrSXixlo0kFKF3HNktA6n9Nx1kSz
         Rflr4FrgBlZS5w8zxiNrcvdscXUfUTLDae717TpzTshvTUdv7fIISMQsC/8lVYqIES4v
         2rNbjkiAHb/d/DGaFHdZ/BNQHoh5GNfEd6unVQlwUMtnPAiO5wOi0oQW8Ae/gtogXPkQ
         kZrnBBvjHblCZkvZJxx36g7+fEgK8pQdS5bd3LWlCgteBHbP0BQXakuwpH2O4SQ2awGQ
         tfAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728676948; x=1729281748;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kCdDB4FzZCs+ONnQuY+4pTxcyDhIhs84SvGVwh2KpEw=;
        b=qPd6pRCqwxA3jpxCzhXQeGFnE3kTLH9cQzdKNeT5m1ba+dhZWpmmDMzSmu4z/dHdXX
         nQqk3sYUn8J9kdA3Mlk8XQN5oxc8/Y7orcbZy2fAdc9AD3ktPaQs0kYMKQxuq5FcgGpm
         8rHj3xHONtcw4q34XtVDhEz6PDmqYoHsnSTgY+5crLgrnV6YfKgpLZQRIXF38R1zgV0Q
         U40kMBY6yO07ybCR1P54fDMdgcGidPX8ty648qaK8YctyF5KIzMp+W0gKbKSUcfgBVeT
         oP4UZjmfrOxlGCAdoPmL1jHZXpIrv1gnzVkSWvhkfjuQmRMpSeVA6c7jEY3bCD5vXkx5
         ylmQ==
X-Forwarded-Encrypted: i=1; AJvYcCX5Ph24BQwlE9pug95wQE30zfNMmNXesLd4uIsL3jAGJx5sxNZnZ9j6EF3sq+GYgxWWVIHWgboWNuA1CO8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyufYkSa7O8BNGDcthnZYWTS7MNJGqO4g1Eb8dlEoGbTSWAvUSb
	zogSe+3uB5GuKcZntR4YCHGTPOat4NQEB2E5mUKMa3rzmRa1npIIfmddpfC4
X-Google-Smtp-Source: AGHT+IGOd18eKj1hzHPwpzvr37oGJNs01DKuB6aPDA1ZxRfgwjuNN7VeD7FJwmq1zYNaqdVBu6/G0Q==
X-Received: by 2002:a05:6a20:b803:b0:1d2:eaca:34ca with SMTP id adf61e73a8af0-1d8bcfb608fmr3684844637.42.1728676948064;
        Fri, 11 Oct 2024 13:02:28 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8200:dab8::a86])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71e2a9f5271sm2966376b3a.56.2024.10.11.13.02.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2024 13:02:27 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: netdev@vger.kernel.org
Cc: Felix Fietkau <nbd@nbd.name>,
	Sean Wang <sean.wang@mediatek.com>,
	Mark Lee <Mark-MC.Lee@mediatek.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-kernel@vger.kernel.org (open list:ARM/Mediatek SoC support),
	linux-arm-kernel@lists.infradead.org (moderated list:ARM/Mediatek SoC support),
	linux-mediatek@lists.infradead.org (moderated list:ARM/Mediatek SoC support)
Subject: [PATCH] net: mtk_eth_soc: use ethtool_puts
Date: Fri, 11 Oct 2024 13:02:25 -0700
Message-ID: <20241011200225.7403-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Allows simplifying get_strings and avoids manual pointer manipulation.

Tested on Belkin RT1800.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/net/ethernet/mediatek/mtk_eth_soc.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/mediatek/mtk_eth_soc.c b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
index 9aaaaa2a27dc..6d93f64f8748 100644
--- a/drivers/net/ethernet/mediatek/mtk_eth_soc.c
+++ b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
@@ -4328,10 +4328,8 @@ static void mtk_get_strings(struct net_device *dev, u32 stringset, u8 *data)
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
2.47.0


