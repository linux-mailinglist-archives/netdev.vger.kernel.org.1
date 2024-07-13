Return-Path: <netdev+bounces-111217-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F29AA9303E3
	for <lists+netdev@lfdr.de>; Sat, 13 Jul 2024 07:57:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A7C4F1F22851
	for <lists+netdev@lfdr.de>; Sat, 13 Jul 2024 05:57:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F28A136669;
	Sat, 13 Jul 2024 05:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gkA1TDy3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E42CC135A71;
	Sat, 13 Jul 2024 05:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720850125; cv=none; b=C4OnblJ7vEaLRHaydmHUqnW4qbHLKLAzWwjRZ6JqjBOZT3lA/23JWB1tX40uvgeYTutr8UF5Tmi21wQsIEJz8xEIQTM1dp8UR0tDc2dsGvFz5q93TuNkC573ePD/TnXT2ydLlspCsTU+vbQarM7w6QCd9uGdNR/emK3lfsYBXx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720850125; c=relaxed/simple;
	bh=W6438tmc00tM5rZzTKV48k4lj4pUeTKMALkVUuK8H5Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mLp45S4b+X9Fa/qCbtSPadrTuJQX/w5J2/SCLD5c7YObWA4Sf3VAnpiLTvAPoch40OEHcwTO/zGwfI/jqphkuIv6k7nAcF4BxHh3ktuIjNvNn9gtp/AAeDRXcLVRDrFatNpZViyv0RGgidvY2KOhyLmL/7foh6hUg7hgIWXG8Yc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gkA1TDy3; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-52ea5dc3c79so3798732e87.1;
        Fri, 12 Jul 2024 22:55:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720850122; x=1721454922; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vSd94frQfpSyqALtcOez4IcP/dqnZZ/I23MmP19uB0I=;
        b=gkA1TDy3aVqD5TKH5pbWrFYcKBwxjooZhSpvcpbCxvOgnTWM/Vgxjk3sg4d3SZpEbg
         /2FNoca8QXAcIh7eKjqf+2WMsL7srRqw5BmIhVWVDp8R7CS1k223nSiLcd+I4AmNRWDZ
         3AI/30DZO3ou7fuXRP+lQmQR4OxeOcpGjSL3PvM2vDGyFGbmceli2rd9V6JSUuFNb7nL
         sgCVEIkMMZVcD2qVjTg7g5oX+xo92CFo3fm7z34xyNrZ0qwyv7asVQh3gPbJHcoBfVyx
         ol4xmL3HqGmddsHMBEfiAkwg+SXTbYcyMjGO2pncH8cSkFzMFLVLDA9uuLuOUM/D0Ob5
         GMPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720850122; x=1721454922;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vSd94frQfpSyqALtcOez4IcP/dqnZZ/I23MmP19uB0I=;
        b=E+xTJFGQjq8pn2bc73X2IsfmmotziCn37DRYliQAimgqtytQ+xUN/OQMidMxzYlHLc
         V4r5rRlpAr/XL8NzFOP+OnM6M9Q5Um3r0MVY48NdvyZ4WwpcUR27MX87w8tSlf+XIPTz
         4VWdBypYIRn8n+rCKRK90Q7FWKexbmXbERDVtiPDKU7myqlI0lp7k9moIMhyugPnIzJk
         KY0rzpHjtJEJtR7QAIZYezKWy+opNDGOaOx0FSxhrf0Zj4Sg/k/gzXJBBR/62kRyO7H8
         vHTAjiy/Mc2drk7g3PLYKzUri+syyxkpLm5FPzj3qSajmiwEmvr5A4scSuYIEPh7qrqn
         cjOA==
X-Forwarded-Encrypted: i=1; AJvYcCWyloOIuESLofZCrPaoIS96QbF+uIXcb5m5ZoE/ntBRj0P9zQvKZ0qV4fl7TH7kTRb9Rwch2qSp1RdJSwmMnNpTmZf8gyngN0ZwjhK6
X-Gm-Message-State: AOJu0YzWy+p+GQMfeOKj+5g8Yt0G/UnrGbJs4Gp9K1K+KpEbTNg69166
	BGBvmDUxw3rsodr4kf6rChuUFP+PEiOJDYHx0e4a/5gHieUZ56iN/Znfmkjw
X-Google-Smtp-Source: AGHT+IHE16dv8de+TUg4jmElVVbPBPngNEooDM8KZRyC9jUUDe79XjDmsdjSMCCLjh+IxCoxdBtxYg==
X-Received: by 2002:a05:6512:239d:b0:52e:7542:f471 with SMTP id 2adb3069b0e04-52eb99a317fmr9393180e87.29.1720850121683;
        Fri, 12 Jul 2024 22:55:21 -0700 (PDT)
Received: from WBEC325.dom.lan ([2001:470:608f:0:b4ea:33f8:5eca:e7fc])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a79bc7f1ceesm20515666b.126.2024.07.12.22.55.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jul 2024 22:55:21 -0700 (PDT)
From: Pawel Dembicki <paweldembicki@gmail.com>
To: netdev@vger.kernel.org
Cc: Paolo Abeni <pabeni@redhat.com>,
	Pawel Dembicki <paweldembicki@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Claudiu Manoil <claudiu.manoil@nxp.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	UNGLinuxDriver@microchip.com,
	Russell King <linux@armlinux.org.uk>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v3 09/12] net: dsa: Define max num of bridges in tag8021q implementation
Date: Sat, 13 Jul 2024 07:54:37 +0200
Message-Id: <20240713055443.1112925-10-paweldembicki@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240713055443.1112925-1-paweldembicki@gmail.com>
References: <20240713055443.1112925-1-paweldembicki@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Max number of bridges in tag8021q implementation is strictly limited
by VBID size: 3 bits. But zero is reserved and only 7 values can be used.

This patch adds define which describe maximum possible value.

Suggested-by: Vladimir Oltean <olteanv@gmail.com>
Signed-off-by: Pawel Dembicki <paweldembicki@gmail.com>
Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Reviewed-by: Vladimir Oltean <olteanv@gmail.com>
---
v3:
  - added 'Reviewed-by' only
v2, v1:
  - resend only
---
Before patch series split:
https://patchwork.kernel.org/project/netdevbpf/list/?series=841034&state=%2A&archive=both
v8:
  - resend only
v7:
  - added 'Reviewed-by' only
v6:
  - resend only
v5:
  - added 'Reviewed-by' only
v4:
  - introduce patch
---
 drivers/net/dsa/sja1105/sja1105_main.c | 3 +--
 include/linux/dsa/8021q.h              | 5 +++++
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/net/dsa/sja1105/sja1105_main.c b/drivers/net/dsa/sja1105/sja1105_main.c
index ee0fb1c343f1..0c55a29d7dd3 100644
--- a/drivers/net/dsa/sja1105/sja1105_main.c
+++ b/drivers/net/dsa/sja1105/sja1105_main.c
@@ -3167,8 +3167,7 @@ static int sja1105_setup(struct dsa_switch *ds)
 	ds->vlan_filtering_is_global = true;
 	ds->untag_bridge_pvid = true;
 	ds->fdb_isolation = true;
-	/* tag_8021q has 3 bits for the VBID, and the value 0 is reserved */
-	ds->max_num_bridges = 7;
+	ds->max_num_bridges = DSA_TAG_8021Q_MAX_NUM_BRIDGES;
 
 	/* Advertise the 8 egress queues */
 	ds->num_tx_queues = SJA1105_NUM_TC;
diff --git a/include/linux/dsa/8021q.h b/include/linux/dsa/8021q.h
index f3664ee12170..1dda2a13b832 100644
--- a/include/linux/dsa/8021q.h
+++ b/include/linux/dsa/8021q.h
@@ -8,6 +8,11 @@
 #include <net/dsa.h>
 #include <linux/types.h>
 
+/* VBID is limited to three bits only and zero is reserved.
+ * Only 7 bridges can be enumerated.
+ */
+#define DSA_TAG_8021Q_MAX_NUM_BRIDGES	7
+
 int dsa_tag_8021q_register(struct dsa_switch *ds, __be16 proto);
 
 void dsa_tag_8021q_unregister(struct dsa_switch *ds);
-- 
2.34.1


