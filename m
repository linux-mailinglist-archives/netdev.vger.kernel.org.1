Return-Path: <netdev+bounces-182466-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BF03BA88CB1
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 22:04:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 31E0A1887144
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 20:05:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF34F1AB6C8;
	Mon, 14 Apr 2025 20:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MkjYSp1S"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DCB1BA49;
	Mon, 14 Apr 2025 20:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744661087; cv=none; b=A02KKw+c1booQZCUJQMZWCHSoUjX6uz5J7AhVfpKw0t1iGzCobq0LGXmLpZ8XjwBrqcDzIfEqUfxugQR0HwGAc+YHgRSsa4hcrlclU8CxRZbSgvoqB+H/z66rc2TJwmNeOfXYCq2BYEFAVwKvSps9kbPYYfHQbFBiMt30PXZ4SE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744661087; c=relaxed/simple;
	bh=VZ60pzN3i0UOYp6g5BL7mcTUiU5eCJI+1lnyq3a2Ueg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kaiRL4bCXUK/OymgpiUEYwawpqnagTsHIa5K55b4Nm6jvkwGu8AiyPALE78PeFx2KOC67TlNnz8X9mrG+vbInDUg1f9v9RPtvZVie3nQEndH8C1Ox0hxz9zj7CA1BxDU+bY9hyPr8gJUBM8J8TeyIGF9aVKJ1yj8XTBjpZ1K8KU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MkjYSp1S; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-ac2dfdf3c38so929876066b.3;
        Mon, 14 Apr 2025 13:04:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744661083; x=1745265883; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9sQR+joTS7+yy0wyuXKGmwdkJETmtPh6NN0wKjS83Dw=;
        b=MkjYSp1Ssq8xCfwY16sju0fCrGQjfHgh0PChjEBjfxwScPU2IDkhQXoySEvBMHlqUf
         ltgwHpq0pscu2XhJ/oGnBLfBqTeu7cYNFB/+bTlIH+UYwQGJ3Mr0mhQwaAdFcxIlgTA5
         Z9mCjC/NpHgwfUAQ6RPEavFGC3989+BUeMbJ9kgaqo8oeW+le5dD1Cfw1MYpXKxMQVjW
         uc1+ByAl1CCcWc0vM6dTaNj46KTeVfJxjjPBA3owNx43lHZn4iTJZm5wHQrb71QG26JC
         6iTElYcOxkww+8v9zMufOaU7IUx4jYU7kWHhw1xXMpS1Tnmmf4f0fOl3eXosjdqrN/X2
         KIJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744661083; x=1745265883;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9sQR+joTS7+yy0wyuXKGmwdkJETmtPh6NN0wKjS83Dw=;
        b=o1RpIsuYgUcnsXHAB8/iLilwpzWp7tgiiIYLtxopzUmq1551LoypjZ8tvu7UbETA3z
         MbQhA2w2pMyB3d2E3dl7jxSbS0aIH87nAlC9/IPjy2Ddi5kMPj6Jnpq8a1fKp5fkq8vA
         jPrWi8UNdL6rnXxoj12ZqvMrGNBX5RgTkV7i6ZmnGePdf1erN5jKbKSAOHPSe21EkZ5M
         /ylTuu0a4iiKVG1Kb7EFl0Eu4Rt1R7+1EvdjASATOUO4HN49vos5IsyhkwxIErrhQfqU
         o6zGvOtEYsIjM9+gKPMpTOsDMWwL9ky21VzaT3zTrVHX6bd3+tYbxigbIIyIxN9wxNh2
         n9hg==
X-Forwarded-Encrypted: i=1; AJvYcCX1y/4a4opcEHXgnSNhVgY1ADE0Q3UKWV/aQCDlpgaVLfhGoO49NoKVGqPgLJUzUpA/8LONPMr8@vger.kernel.org, AJvYcCXX7AslUcaPcRKLZzjA66WrwgbutWpnb1mecRZ+Apd8SUv+FgAbbijWnnYKsSDc+8N5cgYa5M8ffKV8fFU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+WC1QDVUPolC4CrrSilB8a+aSzaRwrv3xGD4wl09GQcCBHshv
	pdVz8Qks+F1lrtGjLiHtvi9P6g5fDPlEaT9eRhv0tfaaiq3eDQBk
X-Gm-Gg: ASbGnctgjDnYcaVZm818mOAcULmZ0ZVDL8WiRcuLgV5xQW+6XpeahuI3vC/F0BoGbVD
	8Ikl9w4gwm5GNX02wZ1BsdsaCgcCVsu5fTtqcd8kwMiOyTP7Jpqowa1OV41Lk29LkRhnsgrBB/X
	kx/DqRrnxnl57JQMhioFfCUuXneXncZSgWFh6YTJP/lf4B0+PVA5GL7hcqWe+RtSTIDFM67zzXK
	N9XE1earHg1hNJbuMdyRTKfSkY25Z6ft7bRX/D/mOgHFXIj+QCxX/H+7x6PGb+LV6xPUeL/G3je
	YIGGoiPic40V1igGCw/pjUg9tRd/MWX+KFxMDsRMmLqv2ff63W075jlNmylKi641vQ5e5DwkO/X
	UVwUwbL1Zsu4bFYx3PugY
X-Google-Smtp-Source: AGHT+IGkGOCsuRuRLFSvCcrgQY+/7X21fj/2XnQHuSO/tubZtQpZfsqip6n3I8/6toTaMmjX0M3MHg==
X-Received: by 2002:a17:907:720f:b0:aca:c9b8:7b95 with SMTP id a640c23a62f3a-acad359b958mr1219688866b.46.1744661083129;
        Mon, 14 Apr 2025 13:04:43 -0700 (PDT)
Received: from localhost (dslb-002-205-021-146.002.205.pools.vodafone-ip.de. [2.205.21.146])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-acaa1ccd1cfsm965998866b.138.2025.04.14.13.04.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Apr 2025 13:04:42 -0700 (PDT)
From: Jonas Gorski <jonas.gorski@gmail.com>
To: Florian Fainelli <florian.fainelli@broadcom.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Florian Fainelli <f.fainelli@gmail.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net] net: b53: enable BPDU reception for management port
Date: Mon, 14 Apr 2025 22:04:34 +0200
Message-ID: <20250414200434.194422-1-jonas.gorski@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For STP to work, receiving BPDUs is essential, but the appropriate bit
was never set. Without GC_RX_BPDU_EN, the switch chip will filter all
BPDUs, even if an appropriate PVID VLAN was setup.

Fixes: ff39c2d68679 ("net: dsa: b53: Add bridge support")
Signed-off-by: Jonas Gorski <jonas.gorski@gmail.com>
---
 drivers/net/dsa/b53/b53_common.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/net/dsa/b53/b53_common.c b/drivers/net/dsa/b53/b53_common.c
index 61d164ffb3ae..e5ba71897906 100644
--- a/drivers/net/dsa/b53/b53_common.c
+++ b/drivers/net/dsa/b53/b53_common.c
@@ -737,6 +737,15 @@ static void b53_enable_mib(struct b53_device *dev)
 	b53_write8(dev, B53_MGMT_PAGE, B53_GLOBAL_CONFIG, gc);
 }
 
+static void b53_enable_stp(struct b53_device *dev)
+{
+	u8 gc;
+
+	b53_read8(dev, B53_MGMT_PAGE, B53_GLOBAL_CONFIG, &gc);
+	gc |= GC_RX_BPDU_EN;
+	b53_write8(dev, B53_MGMT_PAGE, B53_GLOBAL_CONFIG, gc);
+}
+
 static u16 b53_default_pvid(struct b53_device *dev)
 {
 	if (is5325(dev) || is5365(dev))
@@ -876,6 +885,7 @@ static int b53_switch_reset(struct b53_device *dev)
 	}
 
 	b53_enable_mib(dev);
+	b53_enable_stp(dev);
 
 	return b53_flush_arl(dev, FAST_AGE_STATIC);
 }
-- 
2.43.0


