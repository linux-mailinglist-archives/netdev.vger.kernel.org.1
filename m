Return-Path: <netdev+bounces-241834-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE437C88F7D
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 10:33:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B2003B5E4B
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 09:33:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 253202F363B;
	Wed, 26 Nov 2025 09:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GlcKbJlE"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A24462E7BDF
	for <netdev@vger.kernel.org>; Wed, 26 Nov 2025 09:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764149601; cv=none; b=mF8uEAYFYFhEiZeDTfIp3nhEkOuFm7+GOUeTnK8f+sf9Antj8eper/mURZgZknU10Wjpkp2MMXS4ngIb3Qqcmc37hbAt+kZzGYeKLSUim/MQlI4xSgRv1Tpdlt6p8LYeLrg8GdFfx2mwHlRKGVnoSjPY9EsiHrfQDo+yHEoJ+1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764149601; c=relaxed/simple;
	bh=XPoMqDwwNJLwd6t8oOPZg8CGm6E3Kw7Z8uoFKk912hc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aOxizAHZjCoNJQkj1XY5jHoGAZkkMN9OF2kvGiu/EBQU7d0QdfqcVng7jxHk/odwqs1I0Km0eIYd2utcrHX7PwwipcE9yi1ZCwiV/mD/NJ6TBbYPBbVtU8u3jqhDBiRKD1FZgrzQf0eus1rXuqTQfMgVYjUi/axAb+Br/5JZkqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GlcKbJlE; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-298144fb9bcso72016105ad.0
        for <netdev@vger.kernel.org>; Wed, 26 Nov 2025 01:33:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764149599; x=1764754399; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4Kzhu4s+NpOCVTnPevu9VK8eZq5kgkG4j+tx0i0eXd0=;
        b=GlcKbJlEL5w+RBR0xvfZ1N5NXypyABe4gv4TsuzffZgPPVldv2vnsEI4U7+Q15CyZM
         FVaQ0v2YtRuUmd5rl0UCDW6OH9v1S4fqPeRZ/leylQxtIAuxbhmi7syXNJaMsImbs9/e
         gDdqrxg8Ehlc5nwv+ISAKPCSH3dmzxJ6sZ0NVFCZ/GUJb0U58EEuNgMA8Em+6o+21VLL
         7ny+fSTzxXAtP89AB+1IaOmT0wtveGkdDPhwLc0kOW1pfRPdDDQgyJ7cTTogSCxYhRpL
         b7jXkg4+KIcfTCN0W5cmR36nleEdiR/j8KUodPkHqOG4UKpImFlWv868TqEh5rMWwhkz
         WTfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764149599; x=1764754399;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4Kzhu4s+NpOCVTnPevu9VK8eZq5kgkG4j+tx0i0eXd0=;
        b=Ojn7UOjkJe09qkhaS+tW+cie8/BVlX4sP5aG03Gba4R2turMtuAmFLl4DFTg/anXfZ
         mitC0cAjLgUIjQXmwFnAZm2U1bNDFnYMXgtTBGvl3s53WSPnnhM8V4BN/99TFwCFJm8+
         6FtKHa2+xgAUD5FXJ4wnarDFDprcC2Q4w2TkVyaJvRVuABX/es8KBozWbA6HzQG/DwYl
         YesPx8WGCkkuHEGYp9JUIjFmiCtI1tEqDrKGSrDjXXZK9RwGVxcCCMl0KHNV7Lr79nmF
         2NDeZ0EG2v+F/gtObXz9RDog4bzPMuxvjFCuPW+K8MUnIWlu8waG1EqacPXrujNvP5uf
         YyQQ==
X-Gm-Message-State: AOJu0YzM0UNYZycllqyAoHc7Nzm8bifVO5ni8gXWOyW2HgXMGFQMi0b0
	pzq5hv44EX952o70vYcz0DoOojDmGF0DthJEA5JrcPQYkVDm/uG9BBhhrSx1iw==
X-Gm-Gg: ASbGncvnL2ZuJnoKGQcVZXqm20qgBLcCMF25mGiZJe1xQxeqq+wV1hgP9Zb7Q4K4Ygh
	3M2unuS3bHNHpxApzQ5inZmkM4Zia7s3YxFc6gvmDi2GbsgMLBlF2BoWhAkwnIQ4s3CwHcesRtQ
	8v/p1L5b6urlOYphrN1XawqH1wAjEivGjhhaH7ThsRAJ1S7tj9+SwP+nS179jzrE1okBBoq7+B5
	McyAaaVtyC8B+GwFl9M1BIRO0DIq+pt/2KC6qp4XH4iVV+xH8RI0gqgj92gaeeiaCo34glFyWu/
	uwhIcoAOLuQGS/AfLyHZZcoNHGqjnso2fA5hI3ajQ2vCBZ7pFcM3mrlAFpnVVGeM82XA+KctKh/
	Vt2I8cUcoxMW4Yatrg3z8hl0TDHq6qiqwNlf8MCIgP9gWpxijKmpZ8BQVG28fCbi8ZcS+VE3xo8
	mBAEpbvo/iTQvNGNQX5FIrlQ==
X-Google-Smtp-Source: AGHT+IGo+I83jQTyCTIgOsCfJ4GacZwmPf3nL6qIKqhJnmm5dWUuwf6NZgkroxSms0bf3/Wv/y+ySw==
X-Received: by 2002:a17:903:fa4:b0:295:8dbb:b3cc with SMTP id d9443c01a7336-29bab1947admr65396955ad.42.1764149598751;
        Wed, 26 Nov 2025 01:33:18 -0800 (PST)
Received: from d.home.mmyangfl.tk ([2001:19f0:8001:1644:5400:5ff:fe3e:12b1])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29b78740791sm132101735ad.56.2025.11.26.01.33.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Nov 2025 01:33:18 -0800 (PST)
From: David Yang <mmyangfl@gmail.com>
To: netdev@vger.kernel.org
Cc: David Yang <mmyangfl@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Russell King <linux@armlinux.org.uk>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v3 1/4] net: dsa: yt921x: Use *_ULL bitfield macros for VLAN_CTRL
Date: Wed, 26 Nov 2025 17:32:34 +0800
Message-ID: <20251126093240.2853294-2-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251126093240.2853294-1-mmyangfl@gmail.com>
References: <20251126093240.2853294-1-mmyangfl@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

VLAN_CTRL should be treated as a 64-bit register. GENMASK and BIT
macros use unsigned long as the underlying type, which will result in a
build error on architectures where sizeof(long) == 32.

Replace them with unsigned long long variants.

Signed-off-by: David Yang <mmyangfl@gmail.com>
---
 drivers/net/dsa/yt921x.h | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/net/dsa/yt921x.h b/drivers/net/dsa/yt921x.h
index 3e85d90826fb..85d995cdb7c5 100644
--- a/drivers/net/dsa/yt921x.h
+++ b/drivers/net/dsa/yt921x.h
@@ -328,23 +328,23 @@
 #define  YT921X_FDB_HW_FLUSH_ON_LINKDOWN	BIT(0)
 
 #define YT921X_VLANn_CTRL(vlan)		(0x188000 + 8 * (vlan))
-#define  YT921X_VLAN_CTRL_UNTAG_PORTS_M		GENMASK(50, 40)
+#define  YT921X_VLAN_CTRL_UNTAG_PORTS_M		GENMASK_ULL(50, 40)
 #define   YT921X_VLAN_CTRL_UNTAG_PORTS(x)		FIELD_PREP(YT921X_VLAN_CTRL_UNTAG_PORTS_M, (x))
-#define  YT921X_VLAN_CTRL_UNTAG_PORTn(port)	BIT((port) + 40)
-#define  YT921X_VLAN_CTRL_STP_ID_M		GENMASK(39, 36)
+#define  YT921X_VLAN_CTRL_UNTAG_PORTn(port)	BIT_ULL((port) + 40)
+#define  YT921X_VLAN_CTRL_STP_ID_M		GENMASK_ULL(39, 36)
 #define   YT921X_VLAN_CTRL_STP_ID(x)			FIELD_PREP(YT921X_VLAN_CTRL_STP_ID_M, (x))
-#define  YT921X_VLAN_CTRL_SVLAN_EN		BIT(35)
-#define  YT921X_VLAN_CTRL_FID_M			GENMASK(34, 23)
+#define  YT921X_VLAN_CTRL_SVLAN_EN		BIT_ULL(35)
+#define  YT921X_VLAN_CTRL_FID_M			GENMASK_ULL(34, 23)
 #define   YT921X_VLAN_CTRL_FID(x)			FIELD_PREP(YT921X_VLAN_CTRL_FID_M, (x))
-#define  YT921X_VLAN_CTRL_LEARN_DIS		BIT(22)
-#define  YT921X_VLAN_CTRL_INT_PRI_EN		BIT(21)
-#define  YT921X_VLAN_CTRL_INT_PRI_M		GENMASK(20, 18)
-#define  YT921X_VLAN_CTRL_PORTS_M		GENMASK(17, 7)
+#define  YT921X_VLAN_CTRL_LEARN_DIS		BIT_ULL(22)
+#define  YT921X_VLAN_CTRL_INT_PRI_EN		BIT_ULL(21)
+#define  YT921X_VLAN_CTRL_INT_PRI_M		GENMASK_ULL(20, 18)
+#define  YT921X_VLAN_CTRL_PORTS_M		GENMASK_ULL(17, 7)
 #define   YT921X_VLAN_CTRL_PORTS(x)			FIELD_PREP(YT921X_VLAN_CTRL_PORTS_M, (x))
-#define  YT921X_VLAN_CTRL_PORTn(port)		BIT((port) + 7)
-#define  YT921X_VLAN_CTRL_BYPASS_1X_AC		BIT(6)
-#define  YT921X_VLAN_CTRL_METER_EN		BIT(5)
-#define  YT921X_VLAN_CTRL_METER_ID_M		GENMASK(4, 0)
+#define  YT921X_VLAN_CTRL_PORTn(port)		BIT_ULL((port) + 7)
+#define  YT921X_VLAN_CTRL_BYPASS_1X_AC		BIT_ULL(6)
+#define  YT921X_VLAN_CTRL_METER_EN		BIT_ULL(5)
+#define  YT921X_VLAN_CTRL_METER_ID_M		GENMASK_ULL(4, 0)
 
 #define YT921X_TPID_IGRn(x)		(0x210000 + 4 * (x))	/* [0, 3] */
 #define  YT921X_TPID_IGR_TPID_M			GENMASK(15, 0)
-- 
2.51.0


