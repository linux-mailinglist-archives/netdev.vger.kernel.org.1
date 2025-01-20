Return-Path: <netdev+bounces-159800-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 477E5A16F75
	for <lists+netdev@lfdr.de>; Mon, 20 Jan 2025 16:42:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E0C7E188206A
	for <lists+netdev@lfdr.de>; Mon, 20 Jan 2025 15:42:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E57001E8840;
	Mon, 20 Jan 2025 15:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FHE4b/WM"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11EA61E9919;
	Mon, 20 Jan 2025 15:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737387745; cv=none; b=JvWQAKkHLW9sTk/9hw2fIOobeCvTtik44KD8Ym6YWy/cKhWAK27451chaFWGogPYADhXkOcPDJn0cBweVgkIgIMkdlOiXujmhlLeCfM8M07G/qQRJ+ZQKSrssxOWLjnkmXutzUXg1nK1xvVTIZsWX5dWiChf4qDE5nlt4YIMpcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737387745; c=relaxed/simple;
	bh=poW/hJ8Butiz4RFFlZ2PHNtFFsAK0CwWU5mYWUeRTJk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dzBTdi3posLONga5ItwhOgfxvgYApp6N+JHF1aQL4FK8999fTrly5pVSboNKh3D8qk9sUGJUYfL2yoqwnRWeDjnCFfWOYnnys59Wd7jz8SbK1Jk8IH/bRleZU/q6Ye05cT4wytBpQArd9TpB3t5H7lFU+jFoO9WBTOg4fQUitjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FHE4b/WM; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4361f796586so50852795e9.3;
        Mon, 20 Jan 2025 07:42:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737387742; x=1737992542; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4W4c0/LuzN7tD5LrAqYqsKuJBLRBMa73Tfh2EMWw5FM=;
        b=FHE4b/WMbYSiDUBE9RM79QNS05XW927FWx22sSCk6WTcg5RmyP6wsKCe+2FTHS+3ol
         vE3AjCmA8L0DAZrBr/FHoomAGTpWJUnqddC3PJrh2U+ive24XU7GdA6JxPMXxwdKISxo
         nSEUwHcjpat34mmx9MLdYioS1nF+m/pQbiTuCBAGj3K7EH05vQKjewNzDqv8VR0cBxJp
         kwzB61A0pXQoCgxEU+IL35bGrcFRJzzQuxqydaLizFwFklcdISL/vQchuTAGginwzpR9
         h0K0/K24qk2BlgMtswaeZVIZmzNqbUgxotEuK9JLe5EvefRvkpVWS29vsWi6KIhigFSW
         nutA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737387742; x=1737992542;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4W4c0/LuzN7tD5LrAqYqsKuJBLRBMa73Tfh2EMWw5FM=;
        b=CHY+Lvro0sbUmhMWv+tchpqnjnqdmAP3j246HfB4GPAzSlZPCo5op6OsAhdh5NaLhP
         D0vfpgiMofTx8TCMcsX1CU2cSEv4XxUGDT9pt82QeRcPtZ9WcaHTknQiXXd8/P9YzuFi
         6eYwfOTjRA/ogI6YWGjeBhkiU5g7sY8mHiWJxECGhC/Y9a4x5ehn0nDy0BilARelXQ6C
         nO39B74zohBLOpXs1sKaNatvBsr4fOBFFuXo0vmVuqythY3G9RKvID+MdKq6gr7tn+tu
         WZMgz8NwBUM4fEfwyAIIE00ErV43i5nWDpySrI3rxET0PMkA7vnf7EqKHCTNsbvw3gsz
         Uv5A==
X-Forwarded-Encrypted: i=1; AJvYcCUOA5RGWfEvHuEUbagLWJrREi5Yvu25A9YXzz3KTmoF7sbd+SxJz0yu/nE4ZvSlWoKlzPC/t5kx@vger.kernel.org, AJvYcCVpR+eij1pp/TJT1gSolS8a0nooABNgOeAWXFempDC6aqcNLdGudgak5yhd3/FptLn4qCU72Tja/UgxNjI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKuVpT9b57fBPWocdQ5pmRpTgdYACgiEmgzYhdtbTW8wOqDOS3
	saqSiB6qm55wLuIAUOy+BxLKp83bHa6WL2PyN2Qh5j6eeD65N2lzYYuPOA==
X-Gm-Gg: ASbGncvD5b/30MYYpOewUZjlP7oOOcN8br9+EwfixUfM5Xti0vVQYEWvuCpZ8SE41xc
	WzvjK66DV9jbf0/W+hErpJek1TiaDx5KGeu11KwCV+igPZ9PfbwQM0OsUM3gsud5IK76hIeytyk
	9BFANyFYEQMtEuUuG+jz0HnumBVzFdBwfMqqJImp8iXmJUigZbF1FnzSLDovxdwom/YjVTyhT7r
	CXo1rHFNyUz0E6iqHQ1uujhhDM9LNG0/Vn/l+ERNcP55XlXchnC4OjBKGRxuyU0127+Noh9aU9U
	CxSzC7Lut8DkGBInFG85q6z/5PUsZIwPNa2aloE=
X-Google-Smtp-Source: AGHT+IHArWGZJYxMqqA7FIuh1RrMO/IPzuG8Jyig93HVcMwBqwDYBNOX69/XG1Nj0C8lDam+sizI7Q==
X-Received: by 2002:a05:600c:3548:b0:434:a1d3:a321 with SMTP id 5b1f17b1804b1-438913c6150mr125730205e9.3.1737387741983;
        Mon, 20 Jan 2025 07:42:21 -0800 (PST)
Received: from localhost.localdomain (93-34-91-161.ip49.fastwebnet.it. [93.34.91.161])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-437c0f03984sm158637895e9.0.2025.01.20.07.42.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jan 2025 07:42:21 -0800 (PST)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Lorenzo Bianconi <lorenzo@kernel.org>,
	Felix Fietkau <nbd@nbd.name>,
	Sean Wang <sean.wang@mediatek.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Christian Marangi <ansuelsmth@gmail.com>
Subject: [net PATCH v2] net: airoha: Fix wrong GDM4 register definition
Date: Mon, 20 Jan 2025 16:41:40 +0100
Message-ID: <20250120154148.13424-1-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix wrong GDM4 register definition, in Airoha SDK GDM4 is defined at
offset 0x2400 but this doesn't make sense as it does conflict with the
CDM4 that is in the same location.

Following the pattern where each GDM base is at the FWD_CFG, currently
GDM4 base offset is set to 0x2500. This is correct but REG_GDM4_FWD_CFG
and REG_GDM4_SRC_PORT_SET are still using the SDK reference with the
0x2400 offset. Fix these 2 define by subtracting 0x100 to each register
to reflect the real address location.

Fixes: 23020f049327 ("net: airoha: Introduce ethernet support for EN7581 SoC")
Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
Acked-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
Changes v2:
- Target correct file (fix wrong downstream branch used)

 drivers/net/ethernet/mediatek/airoha_eth.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/mediatek/airoha_eth.c b/drivers/net/ethernet/mediatek/airoha_eth.c
index 415d784de741..09f448f29124 100644
--- a/drivers/net/ethernet/mediatek/airoha_eth.c
+++ b/drivers/net/ethernet/mediatek/airoha_eth.c
@@ -266,11 +266,11 @@
 #define REG_GDM3_FWD_CFG		GDM3_BASE
 #define GDM3_PAD_EN_MASK		BIT(28)
 
-#define REG_GDM4_FWD_CFG		(GDM4_BASE + 0x100)
+#define REG_GDM4_FWD_CFG		GDM4_BASE
 #define GDM4_PAD_EN_MASK		BIT(28)
 #define GDM4_SPORT_OFFSET0_MASK		GENMASK(11, 8)
 
-#define REG_GDM4_SRC_PORT_SET		(GDM4_BASE + 0x33c)
+#define REG_GDM4_SRC_PORT_SET		(GDM4_BASE + 0x23c)
 #define GDM4_SPORT_OFF2_MASK		GENMASK(19, 16)
 #define GDM4_SPORT_OFF1_MASK		GENMASK(15, 12)
 #define GDM4_SPORT_OFF0_MASK		GENMASK(11, 8)
-- 
2.47.1


